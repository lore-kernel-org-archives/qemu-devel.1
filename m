Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4227C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:59:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14790206E4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14790206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV5Ld-0002dx-9e
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 21:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iV5L0-0002CM-0b
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iV5Ky-0006uE-G9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:58:25 -0500
Resent-Date: Wed, 13 Nov 2019 21:58:25 -0500
Resent-Message-Id: <E1iV5Ky-0006uE-G9@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iV5KO-00060P-IA; Wed, 13 Nov 2019 21:58:24 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573700253; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JI0bMdWy5SFk784tmsg6xNM3qgkWPL6Lq3DT7ay4jcYzZTCZdOYg+iEJKpYjYp/jGPbQXj4jp0eCFiqkmUcncZw7Dw5VpVx7ZF0sC1oWKldyGwAs2NW+UoEsrCr786ycjd1J5BVbSvdjC5mJzRnjuSIhwDPRiV3mhs1Nxc3Ardo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573700253;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=nK2uhHgvOcYq3+MUkQVTwKJ4HDOTugwdjQwbNNKoDUM=; 
 b=EBB19KQB7ysHiF8aWFgC5C1njBCtMDzrRMwA3Yh7tyrh4SkkTXdlMAy8gJjFGX/BvPdSAchbm3rQo/2WmY0+THLKoj0j5yeFDdUdKw3pqC30rcm1P4x0JcTe58h+sWP5XRvNBwnD7amx7lB6vTYphhRlQE9lQULke53jK9+P7YM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573700251205683.1976351109112;
 Wed, 13 Nov 2019 18:57:31 -0800 (PST)
In-Reply-To: <20191114024635.11363-1-eblake@redhat.com>
Subject: Re: [PATCH v3 for-4.2 0/4] Better NBD string length handling
Message-ID: <157370024990.25875.17193988249957300170@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Wed, 13 Nov 2019 18:57:31 -0800 (PST)
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExNDAyNDYzNS4xMTM2
My0xLWVibGFrZUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgICAgICAgICAgICAgICAgZnJv
bSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L29zZGVwLmg6MTQwLAogICAgICAgICAg
ICAgICAgIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL25iZC9zZXJ2ZXIuYzoyMDoKL3RtcC9xZW11
LXRlc3Qvc3JjL25iZC9zZXJ2ZXIuYzogSW4gZnVuY3Rpb24gJ25iZF9uZWdvdGlhdGVfaGFuZGxl
X2V4cG9ydF9uYW1lJzoKL3Vzci9pbmNsdWRlL2dsaWItMi4wL2dsaWIvZ2xpYi1hdXRvY2xlYW51
cHMuaDoyODoxMDogZXJyb3I6ICduYW1lJyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRo
aXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgZ19mcmVlICgqcHAp
OwogICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvbmJkL3NlcnZlci5jOjQzNToyMjogbm90
ZTogJ25hbWUnIHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgZ19hdXRvZnJlZSBjaGFyICpuYW1lOwog
ICAgICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycwptYWtlOiAqKiogW25iZC9zZXJ2ZXIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGlu
ZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgY2hhcmRldi9jaGFyLWZpbGUubwog
IENDICAgICAgY2hhcmRldi9jaGFyLWlvLm8KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPTk2MjA4MTYxNjEwMDRiNGM4NDc0NmVhYmE2ODhhZjVhJywgJy11JywgJzEwMDMn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWdzeHpmdzluL3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMTMtMjEu
NTUuMjEuMTQ3Mjc6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTk2MjA4MTYx
NjEwMDRiNGM4NDc0NmVhYmE2ODhhZjVhCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWdzeHpmdzluL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10g
RXJyb3IgMgoKcmVhbCAgICAybTkuNDg5cwp1c2VyICAgIDBtNy41ODlzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTExNDAyNDYzNS4x
MTM2My0xLWVibGFrZUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=

