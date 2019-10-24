Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44BBCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C12C205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C12C205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhay-0007UR-KC
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNgzy-0007XJ-RE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNgzx-0008E9-5a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:34:10 -0400
Resent-Date: Thu, 24 Oct 2019 13:34:10 -0400
Resent-Message-Id: <E1iNgzx-0008E9-5a@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNgzw-0008Dv-U4; Thu, 24 Oct 2019 13:34:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571938419; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=l3vnN05vmMPjFEf0SNNVk/nO2jd1B9Hy9AuzUC0lQkh0hrqX0GtLiK3OHhh+1euvgbu+O1iO3oB1DDrxqm+YzDjvXNCEn3g32fodAF7IrI7qVs4QmhZNq8NJ6t4CHAu8IhDwnc/ws1AgrYM9OYGdZQJdSxK1cqA+tHHFyVxpJus=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571938419;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1xJHYBv5Uzib9/Fel0PYb7LqVDB8tn5oBzjjqNPX1nA=; 
 b=nM3SU8EOdPzzW68bK/StMFODrdIAFRmMAdEmqxTYjtPI9KA52Pz9H8COJEcADytw/xXdHPM9P8m+xcbAVMKoG/kkfcL43W36fou5+bSqsPcR1ac/s7oYgyT5TXupkA0kzKL7mzsahhh3JWXBhgVpGMwVreMzJWfWpu9w7q6xFqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571938415658556.4208570396182;
 Thu, 24 Oct 2019 10:33:35 -0700 (PDT)
In-Reply-To: <20191023192640.13125-1-keithp@keithp.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v3)
Message-ID: <157193841432.8331.7323182040062540268@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: keithp@keithp.com
Date: Thu, 24 Oct 2019 10:33:35 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, keithp@keithp.com, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu, qemu-arm@nongnu.org,
 pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMzE5MjY0MC4xMzEy
NS0xLWtlaXRocEBrZWl0aHAuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvdGFyZ2V0L2FybS90cmFuc2xhdGUtc3ZlLm8KLi4vdmwubzogSW4gZnVuY3Rpb24gYG1h
aW4nOgovdG1wL3FlbXUtdGVzdC9zcmMvdmwuYzo0Mzg1OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
IGBxZW11X3NlbWlob3N0aW5nX2NvbnNvbGVfaW5pdCcKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1
cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbcWVtdS1zeXN0ZW0teDg2XzY0XSBFcnJv
ciAxCm1ha2U6ICoqKiBbeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgTElOSyAgICBhYXJjaDY0LXNvZnRtbXUvcWVt
dS1zeXN0ZW0tYWFyY2g2NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0zYzgyZDM3MDk5NmY0MjliYjRiZTdm
ZWY1NmU3MjQ3YicsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICct
dicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW5qdTZrd3hpL3NyYy9k
b2NrZXItc3JjLjIwMTktMTAtMjQtMTMuMjkuMzMuMjQyMDU6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPTNjODJkMzcwOTk2ZjQyOWJiNGJlN2ZlZjU2ZTcyNDdiCm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW5qdTZrd3hpL3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTUyLjQ2NHMKdXNlciAg
ICAwbTguNDY0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTEwMjMxOTI2NDAuMTMxMjUtMS1rZWl0aHBAa2VpdGhwLmNvbS90ZXN0aW5n
LmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


