Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0AC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FBC206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 21:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FBC206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDb6H-0003QQ-E1
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 17:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jDb1u-0002FD-Tb
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jDb1t-0001zF-CQ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:42:42 -0400
Resent-Date: Sun, 15 Mar 2020 17:42:42 -0400
Resent-Message-Id: <E1jDb1t-0001zF-CQ@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jDb1s-0001rH-Ea
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 17:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584308553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FnqPk3rNUOcOYsv1c/2n2jQB+V21CvMy5PdEhuloXQ4K6K7tmQB5lbr/qfeQ2IV7ebkRgMI0N3Io9a8qCATF14G4Fr/nP0MphHyRD+8jAs431pxnZdu01+ZaEC/HxsNEo52F5OPC6NslbYyUnmwYlWx3OgXDmBQjFz3AggaCFD4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584308553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5v/sW147Udr98GPFaHy8v5d1nhEtTaY3AKjTpBIymPg=; 
 b=jhWyHqq5Emk3SEXI0uEKzT6qJi9yqhU/HDFzoexiamAHPsRkOAkK+sMleEVAgOStI92QtLsgBlsZFgdEsm0uGxS01JTCP3Q0Dn+cepir38ObkhfN3dxpxjTRe3Wm9pmiJTn6sJxBPZ58aV3vcXegbw7wkoXEMmnZaLM3leg7oW8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584308551985694.7807149928946;
 Sun, 15 Mar 2020 14:42:31 -0700 (PDT)
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
Subject: Re: [PATCH 0/9] user-mode: Prune build dependencies (part 3)
Message-ID: <158430855063.6054.15100755778610559786@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Sun, 15 Mar 2020 14:42:31 -0700 (PDT)
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMzE4NDYwNy4xMTc5
Mi0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgTElOSyAgICB2aG9zdC11c2Vy
LWlucHV0CnFhcGkvcWFwaS1jb21tYW5kcy1jaGFyLm86IEluIGZ1bmN0aW9uIGBxbXBfbWFyc2hh
bF9hZGRfY2xpZW50JzoKL3RtcC9xZW11LXRlc3QvYnVpbGQvcWFwaS9xYXBpLWNvbW1hbmRzLWNo
YXIuYzo0MDQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHFtcF9hZGRfY2xpZW50Jwpjb2xsZWN0
MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFtxZW11LXN0b3Jh
Z2UtZGFlbW9uXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2Rv
Y2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPTJlN2EwYTgyYzI2ZTQ5MmNiMmQ2OTg5NTU4ZTI3YTIzJywg
Jy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdics
ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdHU1OTF4cmwvc3JjL2RvY2tlci1zcmMuMjAy
MC0wMy0xNS0xNy40MC4wMy4yNTgzMjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3
JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8g
ZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9MmU3YTBhODJjMjZlNDkyY2IyZDY5ODk1NThlMjdhMjMKbWFrZVsxXTogKioqIFtkb2NrZXIt
cnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtdHU1OTF4cmwvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlj
a0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDJtMjguNTUzcwp1c2VyICAgIDBtOC41NzFzCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDMxMzE4NDYwNy4xMTc5Mi0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNr
QGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

