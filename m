Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCA0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D16220708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 20:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D16220708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYFWk-0003Vz-9H
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 15:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iYFVd-0002w4-PT
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iYFVc-00074b-4s
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:26:29 -0500
Resent-Date: Fri, 22 Nov 2019 15:26:29 -0500
Resent-Message-Id: <E1iYFVc-00074b-4s@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iYFVb-00073L-T6
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 15:26:28 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574454379; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iiFy3Bjv96YSzkIRvRqQh+1Yah3m2TrNoFO/ZUWT2RQATQ2V52t5bYAY7Wz1K+4RsrBHRhwmCbzA0EczdnQU9VCJNMHaxSDY40yvWltf3fdKry1dBor/tsBzJnoDHGn17U1ZwazWqQgh+obvMZuR2///zZKvWSKR0DepMR7naiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574454379;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JvnUUgdXuanyU96aq/LCeYAFfGe91s+AoORRx7nWduc=; 
 b=TYbOb/vwWxPXLBIOvKyevCJ3NOcuZ/OH1Lec6+vYRBr6xzRrcZ+1SPJjNcvLQ/WeorlkCv2c61r/NYZQ9PHDks5bKdoIdP9YTQX5BhfLycj8k3TSIyLmUHRd4pzBy9aMaFGnzrXTQuOshKCdIHrPAjPMKR18w3quhHkp8/cfAwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574454377144481.51732741716796;
 Fri, 22 Nov 2019 12:26:17 -0800 (PST)
In-Reply-To: <20191122172201.11456-1-philmd@redhat.com>
Subject: Re: [RFC PATCH-for-5.0] hw/pci-host: Add Kconfig selector for IGD
 PCIe pass-through
Message-ID: <157445437557.7001.12443690176718184739@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Fri, 22 Nov 2019 12:26:17 -0800 (PST)
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
Cc: thuth@redhat.com, mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyMjE3MjIwMS4xMTQ1
Ni0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgTElOSyAgICBhYXJjaDY0LXNv
ZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2NApody92ZmlvL3BjaS5vOiBJbiBmdW5jdGlvbiBgdmZp
b19yZWFsaXplJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3ZmaW8vcGNpLmM6Mjk0OTogdW5kZWZp
bmVkIHJlZmVyZW5jZSB0byBgdmZpb19wY2lfaWdkX29wcmVnaW9uX2luaXQnCmNvbGxlY3QyOiBl
cnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlWzFdOiAqKiogW3FlbXUtc3lzdGVt
LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogW3g4Nl82NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpt
YWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpody92ZmlvL3BjaS5vOiBJ
biBmdW5jdGlvbiBgdmZpb19yZWFsaXplJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3ZmaW8vcGNp
LmM6Mjk0OTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdmZpb19wY2lfaWdkX29wcmVnaW9uX2lu
aXQnCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlWzFdOiAq
KiogW3FlbXUtc3lzdGVtLWFhcmNoNjRdIEVycm9yIDEKbWFrZTogKioqIFthYXJjaDY0LXNvZnRt
bXUvYWxsXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxl
ICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2MiwgaW4gPG1vZHVsZT4KICAgIHN5
cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwg
Y21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1u
JywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTU3
YjhmNmUwMDU5NjRmMGNiNTA1YTAyMTM5NDE0ZTg4JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0
eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9
JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0
JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9
L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tl
ci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLW83OG50c3JrL3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMjItMTUuMjMuNDAuMjgzNzI6
L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bics
ICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0t
LWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTU3YjhmNmUwMDU5NjRmMGNiNTA1
YTAyMTM5NDE0ZTg4Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBM
ZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW83OG50c3JrL3Ny
YycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVh
bCAgICAybTM2LjI4MnMKdXNlciAgICAwbTcuODg0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMjIxNzIyMDEuMTE0NTYtMS1waGls
bWRAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


