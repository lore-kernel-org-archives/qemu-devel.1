Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CABC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354AE2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354AE2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixIpi-0008S5-Ag
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ixIor-000808-2X
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ixIop-0006Fj-Cp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 18:01:52 -0500
Resent-Date: Thu, 30 Jan 2020 18:01:52 -0500
Resent-Message-Id: <E1ixIop-0006Fj-Cp@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ixIop-0006Eo-55; Thu, 30 Jan 2020 18:01:51 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580425296151821.8129367430024;
 Thu, 30 Jan 2020 15:01:36 -0800 (PST)
In-Reply-To: <20200130213907.2830642-1-danielhb413@gmail.com>
Subject: Re: [PATCH v9 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
Message-ID: <158042529491.12871.13608440111125476825@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: danielhb413@gmail.com
Date: Thu, 30 Jan 2020 15:01:36 -0800 (PST)
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
Cc: kwolf@redhat.com, danielhb413@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEzMDIxMzkwNy4yODMw
NjQyLTEtZGFuaWVsaGI0MTNAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCnFlbXUtc3lzdGVtLXg4
Nl82NDogLWFjY2VsIGt2bTogZmFpbGVkIHRvIGluaXRpYWxpemUga3ZtOiBObyBzdWNoIGZpbGUg
b3IgZGlyZWN0b3J5CnFlbXUtc3lzdGVtLXg4Nl82NDogZmFsbGluZyBiYWNrIHRvIHRjZwoqKgpF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbWlncmF0aW9uLWhlbHBlcnMuYzox
MTk6Y2hlY2tfbWlncmF0aW9uX3N0YXR1czogYXNzZXJ0aW9uIGZhaWxlZCAoY3VycmVudF9zdGF0
dXMgIT0gImNvbXBsZXRlZCIpOiAoImNvbXBsZXRlZCIgIT0gImNvbXBsZXRlZCIpCkVSUk9SIC0g
QmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9taWdyYXRpb24t
aGVscGVycy5jOjExOTpjaGVja19taWdyYXRpb25fc3RhdHVzOiBhc3NlcnRpb24gZmFpbGVkIChj
dXJyZW50X3N0YXR1cyAhPSAiY29tcGxldGVkIik6ICgiY29tcGxldGVkIiAhPSAiY29tcGxldGVk
IikKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMTg0CiAg
VEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE4NgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9MGNhY2E5NzhiY2RkNGY2MWI1ODRlN2ZlMmQ5NTA1MGUnLCAnLXUnLCAnMTAwMScs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1nXzhkYjQzZS9zcmMvZG9ja2VyLXNyYy4yMDIwLTAxLTMwLTE3LjUw
LjMxLjM1ODU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9x
ZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIu
CmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTBjYWNhOTc4YmNk
ZDRmNjFiNTg0ZTdmZTJkOTUwNTBlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWdf
OGRiNDNlL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJy
b3IgMgoKcmVhbCAgICAxMW00LjYwNHMKdXNlciAgICAwbTkuNTA3cwoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAxMzAyMTM5MDcuMjgz
MDY0Mi0xLWRhbmllbGhiNDEzQGdtYWlsLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

