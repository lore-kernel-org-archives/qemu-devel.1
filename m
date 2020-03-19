Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69962C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 00:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C10D20752
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 00:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C10D20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEizI-0004qx-TM
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 20:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jEiyl-0004Qz-HC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 20:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jEiyj-00060n-Vx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 20:24:07 -0400
Resent-Date: Wed, 18 Mar 2020 20:24:07 -0400
Resent-Message-Id: <E1jEiyj-00060n-Vx@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jEiyj-0005Ow-Pz; Wed, 18 Mar 2020 20:24:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584577428; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Spj1IYT9s8TbkmOczNNyeVTirL0jPUmwznqqPZv0Wqb+62eoXjPnCJjyCv/oDX11Nzq1pYM8ku0G31ow2R3CRztCBYY09DSwfjhzJ+Si5Ri97AyXQYH/lNvq2jjQcaO5l0c8GEHIlz/5oXGxB3Jls2vKDWAtUBo24vrOePuy1YE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584577428;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=bE03Vp/7hq+fSUoFDwsF3A+kTG8g6Ds0D5I2/JMq7uk=; 
 b=moLmPoqz9z9dvSZG5RgWKYS7xW0s4y9QBPYBzlW/qC/HELA9YtdRttJR/X7N0NSpbRCOZe0hM/540Tuaxh9n0Bu/tnWgjgvpmzlQjqrs4HdTMGYXvBUQ5sQ2TwppqEFkmNMFMc9g33WPABH58eS1e28ryBjprRHCLXOPBjT5J9Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584577426968341.3174062090925;
 Wed, 18 Mar 2020 17:23:46 -0700 (PDT)
In-Reply-To: <20200318222717.24676-1-philmd@redhat.com>
Subject: Re: [PATCH v2 0/4] travis-ci: Add a KVM-only s390x job
Message-ID: <158457742511.25478.7980618794664107306@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Wed, 18 Mar 2020 17:23:46 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: fam@euphon.net, thuth@redhat.com, berrange@redhat.com, quintela@redhat.com,
 alex.bennee@linaro.org, cohuck@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com, dgilbert@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxODIyMjcxNy4yNDY3
Ni0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay11bml0
OiB0ZXN0cy90ZXN0LXJjdS1zaW1wbGVxCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyNAoqKgpF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbWlncmF0aW9uLXRlc3QuYzoxMjQ5
OnRlc3RfbWlncmF0ZV9hdXRvX2NvbnZlcmdlOiBhc3NlcnRpb24gZmFpbGVkIChyZW1haW5pbmcg
PCAoZXhwZWN0ZWRfdGhyZXNob2xkICsgZXhwZWN0ZWRfdGhyZXNob2xkIC8gMTAwKSk6ICgxMDM4
MDkwMjQgPCAxMDEwMDAwMDApCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0
L3NyYy90ZXN0cy9xdGVzdC9taWdyYXRpb24tdGVzdC5jOjEyNDk6dGVzdF9taWdyYXRlX2F1dG9f
Y29udmVyZ2U6IGFzc2VydGlvbiBmYWlsZWQgKHJlbWFpbmluZyA8IChleHBlY3RlZF90aHJlc2hv
bGQgKyBleHBlY3RlZF90aHJlc2hvbGQgLyAxMDApKTogKDEwMzgwOTAyNCA8IDEwMTAwMDAwMCkK
bWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5n
IGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0
LXJjdS10YWlscQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMjUKLS0tCnFlbXUtc3lzdGVtLXg4
Nl82NDogLWFjY2VsIGt2bTogZmFpbGVkIHRvIGluaXRpYWxpemUga3ZtOiBObyBzdWNoIGZpbGUg
b3IgZGlyZWN0b3J5CnFlbXUtc3lzdGVtLXg4Nl82NDogZmFsbGluZyBiYWNrIHRvIHRjZwoqKgpF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbWlncmF0aW9uLXRlc3QuYzoxMjQ5
OnRlc3RfbWlncmF0ZV9hdXRvX2NvbnZlcmdlOiBhc3NlcnRpb24gZmFpbGVkIChyZW1haW5pbmcg
PCAoZXhwZWN0ZWRfdGhyZXNob2xkICsgZXhwZWN0ZWRfdGhyZXNob2xkIC8gMTAwKSk6ICgxMDM4
MDkwMjQgPCAxMDEwMDAwMDApCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0
L3NyYy90ZXN0cy9xdGVzdC9taWdyYXRpb24tdGVzdC5jOjEyNDk6dGVzdF9taWdyYXRlX2F1dG9f
Y29udmVyZ2U6IGFzc2VydGlvbiBmYWlsZWQgKHJlbWFpbmluZyA8IChleHBlY3RlZF90aHJlc2hv
bGQgKyBleHBlY3RlZF90aHJlc2hvbGQgLyAxMDApKTogKDEwMzgwOTAyNCA8IDEwMTAwMDAwMCkK
bWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKICBURVNUICAgIGlvdGVzdC1x
Y293MjogMDQxCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0MgogIFRFU1QgICAgaW90ZXN0LXFj
b3cyOiAwNDMKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2Rv
Y2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWZmMjRlZTI5
NTNmMTQ1NDI5MDMwNTExM2NlZmE4ZjdlJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQn
LCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
cWoyeDI5dGEvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0xOC0yMC4xMi4xMy4yOTc4MzovdmFyL3Rt
cC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
cXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZmYyNGVlMjk1M2YxNDU0MjkwMzA1MTEzY2Vm
YThmN2UKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcWoyeDI5dGEvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEx
bTMyLjI1MXMKdXNlciAgICAwbTguNTg5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMTgyMjI3MTcuMjQ2NzYtMS1waGlsbWRAcmVk
aGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

