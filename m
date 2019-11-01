Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C2ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFF3208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFF3208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZDB-0001rV-Kp
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 11:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iQZB0-00085a-AO
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iQZAz-0000t2-0N
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:49:26 -0400
Resent-Date: Fri, 01 Nov 2019 11:49:26 -0400
Resent-Message-Id: <E1iQZAz-0000t2-0N@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iQZAt-0000oA-Oz; Fri, 01 Nov 2019 11:49:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572623342; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ihHzv6yeKPI295sUuUG0ovzsC7r/qICjFHgOrpO7U8NcDozQ+CXk/7OBybNfCiKSsSNHXlDBmv+VIS4Q2icBgnx/l51zfsHRrDFVBgUlxClbNK0Ib+QGfpli5SWrOxovrlg3WthJdrMaVVBdqPoODB6wQDuLns1y487mHR1n75E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572623342;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5jG+f1j+11a2sgN4BMm8aLHjngBEiMatNTatRlbXvMw=; 
 b=SpriRZ2DlgP6av7mHmDX7rFWy0V8wBDQ0K5If3vKLiSg3MikKvBaHCJxoqlMQtM1OoW96JKe2P4MQZkxZmaqkeHKab75ggqlOnnGBbCRZ8pE1Nv8GKJ05P35nTphtjx4+DG2SBq5DV4EmYSHFK/WNhbPzJ1mnaEglJap3Eo3qUY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572623339303101.59123142073554;
 Fri, 1 Nov 2019 08:48:59 -0700 (PDT)
In-Reply-To: <20191101152510.11719-1-mreitz@redhat.com>
Subject: Re: [PATCH for-4.2 v2 0/3] qcow2: Fix data corruption on XFS
Message-ID: <157262333774.11413.7122618621068123723@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Fri, 1 Nov 2019 08:48:59 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: kwolf@redhat.com, anton.nefedov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwMTE1MjUxMC4xMTcx
OS0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay1xdGVz
dC14ODZfNjQ6IHRlc3RzL2FoY2ktdGVzdAogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVz
dC1haW8tbXVsdGl0aHJlYWQKdGVzdC1haW8tbXVsdGl0aHJlYWQ6IC90bXAvcWVtdS10ZXN0L3Ny
Yy91dGlsL2FzeW5jLmM6MjgzOiBhaW9fY3R4X2ZpbmFsaXplOiBBc3NlcnRpb24gYCFxZW11X2xv
Y2tjbnRfY291bnQoJmN0eC0+bGlzdF9sb2NrKScgZmFpbGVkLgpFUlJPUiAtIHRvbyBmZXcgdGVz
dHMgcnVuIChleHBlY3RlZCA2LCBnb3QgMikKbWFrZTogKioqIFtjaGVjay11bml0XSBFcnJvciAx
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rl
c3QtcWNvdzI6IDAxMwogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMTcKLS0tCiAgICByYWlzZSBD
YWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NF
cnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcs
ICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWJmODhjYmIyYjFiNDQ5N2Y4ZjRmYzJiNjc0OTAzYjA4
JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywg
Jy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRT
PScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9X
X0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21l
L3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICct
dicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdmhodWI0MXEvc3JjL2RvY2tlci1zcmMu
MjAxOS0xMS0wMS0xMS4zNy4yMy4yOTk0MTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50
b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9YmY4OGNiYjJiMWI0NDk3ZjhmNGZjMmI2NzQ5MDNiMDgKbWFrZVsxXTogKioqIFtkb2Nr
ZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtdmhodWI0MXEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1x
dWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDExbTM2LjQzNHMKdXNlciAgICAwbTkuMTQ1
cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTExMDExNTI1MTAuMTE3MTktMS1tcmVpdHpAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1x
dWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


