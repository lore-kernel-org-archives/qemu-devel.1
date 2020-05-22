Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A6CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30BD206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30BD206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc5qo-0002iw-3i
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 07:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jc5q9-0001vQ-66
 for qemu-devel@nongnu.org; Fri, 22 May 2020 07:27:49 -0400
Resent-Date: Fri, 22 May 2020 07:27:49 -0400
Resent-Message-Id: <E1jc5q9-0001vQ-66@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jc5q7-0000kf-Js
 for qemu-devel@nongnu.org; Fri, 22 May 2020 07:27:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590146847; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LIHD3N9OORH43h6tC4qaqUy4Gg3SF2JfVjycYAF2TvSie22Asr31W1Kz8yx/sGgLjMrYn1DxHkDk5/ofUfaRc5KFrBgpRZFJk/REz5aYU066hI0J5i0GrMe8jw3gWDfaFf04xQzewGYzTcGeUqYYq6ZqifbtgZ4VzkB5Kkeo7oY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590146847;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Uw++7RnCCYR4bhiOCS0WIlXPEYnWrE1iWAZyCmK88lA=; 
 b=dQ5wiXbXY3cZo+AW675mHo5J0cE0LyFpgzINvDVMB/eWNT/MMKSwZBD6ZztZ4cGGvK4fUbL4yngJIa/b7pMzlUGVtNGjoZz5zCI7GL5xqGl+3gjVSeia7DcnQpaNh7ndtFpYZGoYIe1VWNSFWa8QXOXxcLLn80/66Pg4nJO9VBI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590146845453351.79329883667765;
 Fri, 22 May 2020 04:27:25 -0700 (PDT)
Message-ID: <159014684405.1576.13333684800446868523@45ef0f9c86ae>
In-Reply-To: <159012995470.27967.18129611453659045726.stgit@pasha-ThinkPad-X280>
Subject: Re: [PATCH] replay: fix replay shutdown for console mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Pavel.Dovgaluk@gmail.com
Date: Fri, 22 May 2020 04:27:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 07:27:45
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
Cc: qemu-devel@nongnu.org, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, alex.bennee@linaro.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTkwMTI5OTU0NzAuMjc5Njcu
MTgxMjk2MTE0NTM2NTkwNDU3MjYuc3RnaXRAcGFzaGEtVGhpbmtQYWQtWDI4MC8KCgoKSGksCgpU
aGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9j
a2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVp
Y2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxMTcKc29ja2V0X2FjY2VwdCBmYWlsZWQ6IFJl
c291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3Ny
Yy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjMwMTpxdGVzdF9pbml0X3dpdGhvdXRfcW1wX2hhbmRz
aGFrZTogYXNzZXJ0aW9uIGZhaWxlZDogKHMtPmZkID49IDAgJiYgcy0+cW1wX2ZkID49IDApCi90
bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE2Njoga2lsbF9xZW11KCkg
dHJpZWQgdG8gdGVybWluYXRlIFFFTVUgcHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0
dXMgMSAoZXhwZWN0ZWQgMCkKRVJST1IgLSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qv
c3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFu
ZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkK
bWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcg
Zm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMTIwCiAgVEVT
VCAgICBpb3Rlc3QtcWNvdzI6IDEyNgotLS0KcWVtdS1zeXN0ZW0tYWFyY2g2NDogY2Fubm90IHNl
dCB1cCBndWVzdCBtZW1vcnkgJ2V4eW5vczQyMTAuZHJhbTAnOiBDYW5ub3QgYWxsb2NhdGUgbWVt
b3J5CkJyb2tlbiBwaXBlCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5j
OjE2Njoga2lsbF9xZW11KCkgdHJpZWQgdG8gdGVybWluYXRlIFFFTVUgcHJvY2VzcyBidXQgZW5j
b3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhwZWN0ZWQgMCkKRVJST1IgLSB0b28gZmV3IHRlc3Rz
IHJ1biAoZXhwZWN0ZWQgNjYsIGdvdCA0KQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LWFhcmNoNjRd
IEVycm9yIDEKICBURVNUICAgIGlvdGVzdC1xY293MjogMTU2CiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDE1OAogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxNTkKLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPWE2YzZmNTg4M2YyNTRkMWM4ODUwNjQxNTcwY2EzNmVhJywgJy11
JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0x
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWNuZ21oNDl5L3NyYy9kb2NrZXItc3JjLjIwMjAt
MDUtMjItMDcuMDkuMzkuMjIzMzY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycs
ICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlk
PWE2YzZmNTg4M2YyNTRkMWM4ODUwNjQxNTcwY2EzNmVhCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1
bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWNuZ21oNDl5L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tA
Y2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxN200NS4yODVzCnVzZXIgICAgMG04LjY0NnMKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1OTAx
Mjk5NTQ3MC4yNzk2Ny4xODEyOTYxMTQ1MzY1OTA0NTcyNi5zdGdpdEBwYXNoYS1UaGlua1BhZC1Y
MjgwL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

