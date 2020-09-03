Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61384C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8E4206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8E4206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDqP5-0003Tj-BG
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kDqNm-0002Pn-76; Thu, 03 Sep 2020 10:38:34 -0400
Resent-Date: Thu, 03 Sep 2020 10:38:34 -0400
Resent-Message-Id: <E1kDqNm-0002Pn-76@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kDqNj-0000jv-Pk; Thu, 03 Sep 2020 10:38:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599143901; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fEgdjLfW7EVsehKmYvxdcnGpe+z5g/GZsrGKgGndIR00QtNGylNe5xcv0nVJ2FY7yyFAVSw6AXSFAOPui8rx+Po5rl6Mb1/ydchYVSAJ2dYH9SsF1QCXXkmbULID/0dc9gOY+KVza7nMRLoYrSktwAJH7kz1Z8sAeuk/JnotQqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599143901;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=kiY1j7ulvTIWIlp4jbE6k+zNWfxHv3W1tvXwvpN0E88=; 
 b=MyCIkUeDw5BVQ4wnYOrUsl5W9N5bsmMGltEqwmRhj6MIpPw5DL555+Lf1753MK2czqKr/DkWAMZav5Kup5I/uxwM/BzUdS1YvvbFGDgZVj9rfFOz+eA68DNz5uCB2eH2h43bHgs0GATJ7PNuFi7QHiW4jBU2/TV7uUGY8+/FGik=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599143898635205.15535712244446;
 Thu, 3 Sep 2020 07:38:18 -0700 (PDT)
Subject: Re: [PATCH] tests/qtest/ahci: Improve error handling
 (NEGATIVE_RETURNS)
Message-ID: <159914389701.592.14179192808573308867@66eaa9a8a123>
In-Reply-To: <20200902080552.159806-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Thu, 3 Sep 2020 07:38:18 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 10:38:25
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-block@nongnu.org,
 jsnow@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkwMjA4MDU1Mi4xNTk4
MDYtMS1waGlsbWRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpDbG9uZSBvZiAnaHR0cHM6Ly9n
aXQucWVtdS5vcmcvZ2l0L2R0Yy5naXQnIGludG8gc3VibW9kdWxlIHBhdGggJ2R0YycgZmFpbGVk
CmZhaWxlZCB0byB1cGRhdGUgc3VibW9kdWxlIGR0YwpTdWJtb2R1bGUgJ2R0YycgKGh0dHBzOi8v
Z2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0KSB1bnJlZ2lzdGVyZWQgZm9yIHBhdGggJ2R0YycKbWFr
ZVsxXTogKioqIFsvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcnd1MGY2N2Uvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wOS0wMy0xMC4zNy40Ni4zMDA0OF0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJ3dTBmNjdlL3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAw
bTMwLjk5NnMKdXNlciAgICAwbTIuMTEzcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MDIwODA1NTIuMTU5ODA2LTEtcGhpbG1kQHJl
ZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

