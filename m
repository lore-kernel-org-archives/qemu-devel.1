Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC288C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2873F2311A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2873F2311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHuu-0001sk-RZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJHpd-0006ca-GQ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:57:49 -0400
Resent-Date: Fri, 18 Sep 2020 10:57:49 -0400
Resent-Message-Id: <E1kJHpd-0006ca-GQ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJHpa-0006d9-IM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:57:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600441056; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n65JjF38JWKcyDmb6tm4zJwPHvyHf7wc/QQboBMdB9x0+nv9uEkHs9GMCdfGPL7SMBfhtiDRFp0Wlhi9u9vrFxe3IN0SyHU1uZOtiJmXtcuzAXysQtMgMcRwkwWDeTrqnuI+heZzhxVhajTrx1F1nQ2ZFx1wBLIM30V9DB1t/QY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600441056;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zIXZAncskp6tkxI0/fum0dhaMbMBIJP9oAwTnOOdPzg=; 
 b=FLpiUmzR1hqoRHU7mkygOcQTzZyaQkUV18nG/EC1FzAnqLfiXQdYF56bAwrqwkjNtYd471YQY8WyXwHENywX6b5K+AYrOQuH1JQmml25rTyiG9bq1dIfDK1Ozuz9N/DKT4XArvdjF4YTWSQL8K2bvv9aw1tKOTKcVTPZz1Veg7w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600441055687456.5117916401035;
 Fri, 18 Sep 2020 07:57:35 -0700 (PDT)
Subject: Re: [PATCH 0/3] gitlab: add jobs for checking paches
Message-ID: <160044105412.8478.2954401371038885653@66eaa9a8a123>
In-Reply-To: <20200918132903.1848939-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Fri, 18 Sep 2020 07:57:35 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 09:36:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, wainersm@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxODEzMjkwMy4xODQ4
OTM5LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgoKCgoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MTgx
MzI5MDMuMTg0ODkzOS0xLWJlcnJhbmdlQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tA
Y2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

