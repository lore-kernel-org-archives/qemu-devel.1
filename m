Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5C1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 18:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439242084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 18:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439242084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO4AU-0007Tg-7N
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 14:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iO49P-0006Xg-OZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 14:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iO49O-00085l-8S
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 14:17:27 -0400
Resent-Date: Fri, 25 Oct 2019 14:17:27 -0400
Resent-Message-Id: <E1iO49O-00085l-8S@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iO49O-000854-0x
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 14:17:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572027439; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eMDgpwxHr7FLsEiuQPSQLbYBFIV6eXZrvoGnazgmYr9mAY0yW8zLzjvx6DJTJiV6jxlIXjb1LP/X2cWnG0qurhpOfEh2zkey1sbGDgtpzwCCMVvToUkipbvaqIwbPTsKePD4XOTKPOAnaEbSGysDCi/Swap0bBfFgEcys9vp7Bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572027439;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=K0971W//SifrkS+TjIsQpqL3BBkW26VP7vt7BMu5E60=; 
 b=HH36wMJ8ZUIDkBoJmBi5jORTOy+stQquacQzyh/kOJVrdbo58FnT9pCwp/qWMbKqrvSKAu75EC4IOMwKL2Mxkg1xWs2yuVeGkOxRzcXXi1SZXLXC798ZDXaHxLkXC0iekIoZi9zTB+UvitCPHQHQMKbd00KRtKpcsZo8wBZWOoI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157202743757186.38259452577006;
 Fri, 25 Oct 2019 11:17:17 -0700 (PDT)
In-Reply-To: <20191024224622.12371-1-keithp@keithp.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
Message-ID: <157202743661.8606.17946324130921853445@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: keithp@keithp.com
Date: Fri, 25 Oct 2019 11:17:17 -0700 (PDT)
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyNDIyNDYyMi4xMjM3
MS0xLWtlaXRocEBrZWl0aHAuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvdHJhY2UvZ2VuZXJhdGVkLWhlbHBlcnMubwouLi92bC5vOiBJbiBmdW5jdGlvbiBgbWFp
bic6Ci90bXAvcWVtdS10ZXN0L3NyYy92bC5jOjQzODU6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YHFlbXVfc2VtaWhvc3RpbmdfY29uc29sZV9pbml0Jwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVy
bmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtxZW11LXN5c3RlbS14ODZfNjRdIEVycm9y
IDEKbWFrZTogKioqIFt4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBMSU5LICAgIGFhcmNoNjQtc29mdG1tdS9xZW11
LXN5c3RlbS1hYXJjaDY0ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTU2ZDc1M2JmZjM4ZjRjNjc5NGJkOTBm
OWE1ZjNlMmRmJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2Fj
aGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAta2Nka3N5dzAvc3JjL2Rv
Y2tlci1zcmMuMjAxOS0xMC0yNS0xNC4xNC4zMS4yMzQ5NDovdmFyL3RtcC9xZW11Onoscm8nLCAn
cWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJu
ZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9NTZkNzUzYmZmMzhmNGM2Nzk0YmQ5MGY5YTVmM2UyZGYKbWFrZVsxXTog
KioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAta2Nka3N5dzAvc3JjJwptYWtlOiAqKiogW2RvY2tlci1y
dW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDJtNDUuNTgxcwp1c2VyICAg
IDBtOC4yMjBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDE5MTAyNDIyNDYyMi4xMjM3MS0xLWtlaXRocEBrZWl0aHAuY29tL3Rlc3Rpbmcu
ZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


