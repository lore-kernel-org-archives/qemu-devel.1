Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA9C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333592075A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 20:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333592075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1vM-00005s-EL
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 16:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1ji1ul-000877-0x
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 16:29:07 -0400
Resent-Date: Sun, 07 Jun 2020 16:29:07 -0400
Resent-Message-Id: <E1ji1ul-000877-0x@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1ji1uj-0004S3-9J
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 16:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591561734; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=N3n1qvIsVBtA1YzIE8p/okniOrKP66YFOD0/BEk0e7nwVeZiJ7Rv26HE5X8i8PBc09XgSWC1qecCMYNVmVNKb6TxkdcaUUHFv3/EGXYsx+DPf7WN1xdxWwCe3MjNU8cAcUSSMLF2Bp85TasJBNzetKrBREb0QyBQ7oKwq1Rnna0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591561734;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qRdFUxSHFHXU4iRObLjXvxEMIrEYfv5I29mNlI21U50=; 
 b=kCytcutdxSysZGPZZyYpVZKAQCwNFpzLPKyoZRYXl5hk39WMSGMdDZDh2/V5gIYEp1uzQonYm6fEN4Lgzp+B6FooKQrPEBtHrYDGvm42Wn2XgEGq0E+xu1HFuONPZFH2seM3aBdKy7jl7dZ0pu1ctFl2Ewbv06omSgVyFPNa394=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591561732734477.5287253190629;
 Sun, 7 Jun 2020 13:28:52 -0700 (PDT)
Message-ID: <159156173139.32466.16783549689356647947@45ef0f9c86ae>
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Subject: Re: [PULL 00/21] MIPS queue for June 7th, 2020
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.qemu.devel@gmail.com
Date: Sun, 7 Jun 2020 13:28:52 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 16:29:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTkxNTU5MTg1LTMxMjg3LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5xZW11LmRldmVsQGdtYWlsLmNvbS8KCgoKSGksCgpU
aGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9j
a2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVp
Y2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgotLS0gL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3FlbXUtaW90ZXN0cy8wNDAub3V0ICAg
ICAgIDIwMjAtMDYtMDcgMTk6NTY6MzkuMDAwMDAwMDAwICswMDAwCisrKyAvdG1wL3FlbXUtdGVz
dC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvMDQwLm91dC5iYWQgMjAyMC0wNi0wNyAyMDoyMToz
NC44MDMyNTQ5MjkgKzAwMDAKQEAgLTEsMyArMSw1IEBACitXQVJOSU5HOnFlbXUubWFjaGluZTpx
ZW11IHJlY2VpdmVkIHNpZ25hbCA5OiAvdG1wL3FlbXUtdGVzdC9idWlsZC90ZXN0cy9xZW11LWlv
dGVzdHMvLi4vLi4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0IC1kaXNwbGF5IG5v
bmUgLXZnYSBub25lIC1jaGFyZGV2IHNvY2tldCxpZD1tb24scGF0aD0vdG1wL3RtcC5HNXRGTTZx
U3htL3FlbXUtMjA2NjQtbW9uaXRvci5zb2NrIC1tb24gY2hhcmRldj1tb24sbW9kZT1jb250cm9s
IC1xdGVzdCB1bml4OnBhdGg9L3RtcC90bXAuRzV0Rk02cVN4bS9xZW11LTIwNjY0LXF0ZXN0LnNv
Y2sgLWFjY2VsIHF0ZXN0IC1ub2RlZmF1bHRzIC1kaXNwbGF5IG5vbmUgLWFjY2VsIHF0ZXN0CitX
QVJOSU5HOnFlbXUubWFjaGluZTpxZW11IHJlY2VpdmVkIHNpZ25hbCA5OiAvdG1wL3FlbXUtdGVz
dC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvLi4vLi4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0
ZW0teDg2XzY0IC1kaXNwbGF5IG5vbmUgLXZnYSBub25lIC1jaGFyZGV2IHNvY2tldCxpZD1tb24s
cGF0aD0vdG1wL3RtcC5HNXRGTTZxU3htL3FlbXUtMjA2NjQtbW9uaXRvci5zb2NrIC1tb24gY2hh
cmRldj1tb24sbW9kZT1jb250cm9sIC1xdGVzdCB1bml4OnBhdGg9L3RtcC90bXAuRzV0Rk02cVN4
bS9xZW11LTIwNjY0LXF0ZXN0LnNvY2sgLWFjY2VsIHF0ZXN0IC1ub2RlZmF1bHRzIC1kaXNwbGF5
IG5vbmUgLWFjY2VsIHF0ZXN0CiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLgogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogUmFuIDU5IHRlc3RzCi0tLQpO
b3QgcnVuOiAyNTkKRmFpbHVyZXM6IDA0MApGYWlsZWQgMSBvZiAxMTkgaW90ZXN0cwptYWtlOiAq
KiogW2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5l
IDY2NSwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPWY3NzBjODg3ZjU4MjQxMDNhNGJmOWViMWNiNDY2NWQyJywg
Jy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdics
ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNGU3aGhxbHAvc3JjL2RvY2tlci1zcmMuMjAy
MC0wNi0wNy0xNi4xMy4zNy4zMjc2NDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3
JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8g
ZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9Zjc3MGM4ODdmNTgyNDEwM2E0YmY5ZWIxY2I0NjY1ZDIKbWFrZVsxXTogKioqIFtkb2NrZXIt
cnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtNGU3aGhxbHAvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlj
a0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE1bTE0LjkzN3MKdXNlciAgICAwbTkuNTAzcwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU5
MTU1OTE4NS0zMTI4Ny0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIucWVtdS5kZXZlbEBnbWFp
bC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

