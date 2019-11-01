Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B669CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5035D208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5035D208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQVl9-0001FR-FJ
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 08:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iQVkW-0000fL-8H
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iQVkU-0001Hc-Lw
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:09:51 -0400
Resent-Date: Fri, 01 Nov 2019 08:09:51 -0400
Resent-Message-Id: <E1iQVkU-0001Hc-Lw@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iQVkU-0001BY-Du; Fri, 01 Nov 2019 08:09:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572610174; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JzWZFa+nUqUgQu4cf0eTaLS5Y1S07Zho51XFN4mMXiVnDAGn0y+4Q6XY5MQ4HXIX+mzOT/JACRPX8tJ4tJ9DaXG5Og9Erz00D4vlhjL/T7B67BklkQyoImK6W3l74OrbU+Jm7z9ZdVkbay0LG+GmJoVDyjSCX+SiNS7gmyRT/7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572610174;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wZEBfBNidULKgTy6y+qdU52qMQe6oxH8RXw9lId7sOc=; 
 b=M61PqujUzUKqhsX4gHNwyx2qzYmPBaRZLBxwRu9JhpMOsf/NXGEPHegmnH7qZPKfIWUSpJ6D0SKrc/SmKADp46AzjKEH8Ih2uOEUJf81ocPtaZFIVHfWpu7HTD5zaBjqalXKLMzGjBoNEGHpsJo1QGLmgro7hKrGbMu20I4yPD0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572610172756325.79732018890877;
 Fri, 1 Nov 2019 05:09:32 -0700 (PDT)
In-Reply-To: <20191101103232.3692818-1-luc.michel@greensocs.com>
Subject: Re: [PATCH] hw/arm/pxa2xx: rebuild hflags cache when modifying CPU
 state
Message-ID: <157261017167.11413.14176314326675211052@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luc.michel@greensocs.com
Date: Fri, 1 Nov 2019 05:09:32 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwMTEwMzIzMi4zNjky
ODE4LTEtbHVjLm1pY2hlbEBncmVlbnNvY3MuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVz
dGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIg
aW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2Ug
ZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1t
aW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICBhYXJjaDY0LXNvZnRtbXUvdHJhY2UvZ2VuZXJhdGVkLWhlbHBlcnMubwogIENDICAgICAg
YWFyY2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vdHJhbnNsYXRlLXN2ZS5vCi90bXAvcWVtdS10ZXN0
L3NyYy9ody9hcm0vcHhhMnh4LmM6IEluIGZ1bmN0aW9uICdweGEyeHhfcHdybW9kZV93cml0ZSc6
Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9hcm0vcHhhMnh4LmM6MzA5OjM0OiBlcnJvcjogaW5jb21w
YXRpYmxlIHR5cGUgZm9yIGFyZ3VtZW50IDEgb2YgJ2FybV9yZWJ1aWxkX2hmbGFncycKICAgICAg
ICAgYXJtX3JlYnVpbGRfaGZsYWdzKHMtPmNwdS0+ZW52KTsKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH5+fn5+fl5+fn5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9z
cmMvaHcvYXJtL3B4YTJ4eC5jOjE1OgovdG1wL3FlbXUtdGVzdC9zcmMvdGFyZ2V0L2FybS9jcHUu
aDozMzA0OjM4OiBub3RlOiBleHBlY3RlZCAnQ1BVQVJNU3RhdGUgKicge2FrYSAnc3RydWN0IENQ
VUFSTVN0YXRlIConfSBidXQgYXJndW1lbnQgaXMgb2YgdHlwZSAnQ1BVQVJNU3RhdGUnIHtha2Eg
J3N0cnVjdCBDUFVBUk1TdGF0ZSd9CiB2b2lkIGFybV9yZWJ1aWxkX2hmbGFncyhDUFVBUk1TdGF0
ZSAqZW52KTsKICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+fn5+fn5+fn5efn4KbWFrZVsx
XTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9hcm0vcHhhMnh4Lm9d
IEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFr
ZTogKioqIFtNYWtlZmlsZTo0ODg6IGFhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBHRU4gICAgIHg4Nl82NC1zb2Z0
bW11L3FlbXUtc3lzdGVtLXg4Nl82NC5leGUKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9M2Q3OTRmZDlkZjcy
NDYyMzhkOTNkNzA1OGE1YzE1YmYnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2Nj
YWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zh
ci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTd1bmJ5
b2N6L3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMDEtMDguMDYuMzkuMTg5Mjc6L3Zhci90bXAvcWVt
dTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9M2Q3OTRmZDlkZjcyNDYyMzhkOTNkNzA1OGE1YzE1YmYK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtN3VuYnlvY3ovc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm01Mi44NDdz
CnVzZXIgICAgMG02LjU2M3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTAxMTAzMjMyLjM2OTI4MTgtMS1sdWMubWljaGVsQGdyZWVu
c29jcy5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


