Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B866C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F9D20722
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F9D20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBmD-0008SX-3p
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kEBlV-0007xP-Ln
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:28:29 -0400
Resent-Date: Fri, 04 Sep 2020 09:28:29 -0400
Resent-Message-Id: <E1kEBlV-0007xP-Ln@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kEBlS-00048y-O0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:28:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599226102; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KCW2FjL85vpYJFhRvLx+gZ0kXLli/l6KhseRrlP2Jh96o52M9OrZMQmy7/BUafrrAcCK4VIzucteetCr+AQtak/hPiskAsaG/zn3n3SFZoc6G1Vq6iPYWeIM+fa5eni1BUv3xhzK1/tYrKS4Ryi+5AqAWdj8sTqYWk3y2pTYgD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599226102;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2MijjdVOtqfIRvv7zaCxPa8t81rrS61QBaLvNF4bwDI=; 
 b=YfssPeUD9ZANlPJl519KjX3AuCvLSxNNAsg8fGU/IzWi6wnVFXnzGvFe6CSklmiavnj31dzVV4Z913nR1yRG8k0X71MWMsf6W+a/pgkRf5G8hteJsSST9cKMnr8ve16e7y0tf+rCEPjRyMGZWnDxJPni8LUPtBDKBeh8XCY3y9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599226100353137.44917451978029;
 Fri, 4 Sep 2020 06:28:20 -0700 (PDT)
Subject: Re: [PATCH 0/2] vhost-vdpa: improve parameters error management
Message-ID: <159922609905.11986.7761234044237873654@66eaa9a8a123>
In-Reply-To: <20200903185327.774708-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lvivier@redhat.com
Date: Fri, 4 Sep 2020 06:28:20 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 09:24:22
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
Cc: lvivier@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 lulu@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkwMzE4NTMyNy43NzQ3
MDgtMS1sdml2aWVyQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgoKCgoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MDMxODUz
MjcuNzc0NzA4LTEtbHZpdmllckByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9y
YS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

