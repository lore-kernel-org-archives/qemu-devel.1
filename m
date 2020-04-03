Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FFCC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADA520721
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=tencent.com header.i=@tencent.com header.b="eX1ESAvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADA520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKIBH-0006no-99
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bauerchen@tencent.com>) id 1jKIAc-0006Im-SW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bauerchen@tencent.com>) id 1jKIAQ-0001XI-AL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:59:11 -0400
Received: from mail4.tencent.com ([183.57.53.109]:60260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bauerchen@tencent.com>)
 id 1jKIAO-0001Hg-Vu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:59:10 -0400
Received: from EX-SZ020.tencent.com (unknown [10.28.6.40])
 by mail4.tencent.com (Postfix) with ESMTP id 0D346724E2;
 Fri,  3 Apr 2020 16:50:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
 s=s202002; t=1585903820;
 bh=bSCuvDVSaS7XT74qYskCN3zfpT2t25mUaPv2ju3Bcx0=;
 h=From:To:CC:Subject:Date:References;
 b=eX1ESAvUId4fXZLPcyYlO/OIxYeKdNEhsLu0jKFehRQR4T4Me3Z4bTh0xjqLP7ltG
 xhe82Q6VgAKnobfImmxVTVH3LYWC8BhgjFumiZ0MnVPLgoi1W2qbgtgWg+zimR9Av1
 2qidd2/mPJmhfBqJOtMuSsgzn/XTD7EmB4+Dry4c=
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ020.tencent.com
 (10.28.6.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 3 Apr 2020
 16:50:19 +0800
Received: from EX-SZ005.tencent.com (10.28.6.29) by EX-SZ012.tencent.com
 (10.28.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Fri, 3 Apr 2020
 16:50:19 +0800
Received: from EX-SZ005.tencent.com ([fe80::5d14:1c60:ce53:dbd6]) by
 EX-SZ005.tencent.com ([fe80::5d14:1c60:ce53:dbd6%4]) with mapi id
 15.01.1847.007; Fri, 3 Apr 2020 16:50:19 +0800
From: =?utf-8?B?YmF1ZXJjaGVuKOmZiOiSmeiSmSk=?= <bauerchen@tencent.com>
To: kraxel <kraxel@redhat.com>
Subject: Re: Re: is just a wrong function name of libusb_get_port_number?
 request for a review of the bug fix(Internet mail)
Thread-Topic: Re: is just a wrong function name of libusb_get_port_number?
 request for a review of the bug fix(Internet mail)
Thread-Index: AQHWCZCTQDr8mw9eNEWTKl704+n/Sg==
Date: Fri, 3 Apr 2020 08:50:19 +0000
Message-ID: <0679a6d48df44a6e8d2b635dfb0cc566@tencent.com>
References: <02a07a59c3964199b73b1145e4abe0e9@tencent.com>,
 <20200403065042.cirj4ih3fl45wlqb@sirius.home.kraxel.org>,
 <ffdaa53629a94b20aa7b1023911e41a6@tencent.com>,
 <20200403081902.tvjuv6gel3iucub7@sirius.home.kraxel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [10.14.87.247]
Content-Type: multipart/alternative;
 boundary="_000_0679a6d48df44a6e8d2b635dfb0cc566tencentcom_"
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 183.57.53.109
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
Cc: hdegoede <hdegoede@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_0679a6d48df44a6e8d2b635dfb0cc566tencentcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T0vvvIx0aGFua3MsIEkgd2lsbCB0cnkgLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KQmF1ZXINCg0KRnJvbToga3JheGVsPG1haWx0bzprcmF4ZWxAcmVkaGF0LmNvbT4NCkRh
dGU6IDIwMjAtMDQtMDMgMTY6MTkNClRvOiBiYXVlcmNoZW4o6ZmI6JKZ6JKZKTxtYWlsdG86YmF1
ZXJjaGVuQHRlbmNlbnQuY29tPg0KQ0M6IHFlbXUtZGV2ZWw8bWFpbHRvOnFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz47IGhkZWdvZWRlPG1haWx0bzpoZGVnb2VkZUByZWRoYXQuY29tPg0KU3ViamVjdDog
UmU6IGlzIGp1c3QgYSB3cm9uZyBmdW5jdGlvbiBuYW1lIG9mIGxpYnVzYl9nZXRfcG9ydF9udW1i
ZXI/IHJlcXVlc3QgZm9yIGEgcmV2aWV3IG9mIHRoZSBidWcgZml4KEludGVybmV0IG1haWwpDQpP
biBGcmksIEFwciAwMywgMjAyMCBhdCAwNzowNToxM0FNICswMDAwLCBiYXVlcmNoZW4o6ZmI6JKZ
6JKZKSB3cm90ZToNCj4gdGhhbmtzLCBidXQgbXkgbGlidXNieCB2ZXJzaW9uIGlzIGxpYnVzYngt
MS4wLjE1LTQuZWw3Lng4Nl82NCAsDQo+IEkgY2FuIGZpbmQgbGlidXNiX2dldF9wb3J0X251bWJl
cnMgZnVuY3Rpb24gaW4gbGlidXNiLTEuMC5zby4wIGJ1dCBmaW5kIGxpYnVzYl9nZXRfcG9ydF9u
dW1iZXINCj4NCj4gW3Jvb3RAdF0jIHN0cmluZ3MgL2xpYjY0L2xpYnVzYi0xLjAuc28uMCB8Z3Jl
cCBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyDQo+IGxpYnVzYl9nZXRfcG9ydF9udW1iZXINCj4gW3Jv
b3RAdF0jDQoNCmtyYXhlbEBzaXJpdXMgfiMgZ3JlcCBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyIC91
c3IvaW5jbHVkZS9saWJ1c2ItMS4wL2xpYnVzYi5oDQp1aW50OF90IExJQlVTQl9DQUxMIGxpYnVz
Yl9nZXRfcG9ydF9udW1iZXIobGlidXNiX2RldmljZSAqZGV2KTsNCmludCBMSUJVU0JfQ0FMTCBs
aWJ1c2JfZ2V0X3BvcnRfbnVtYmVycyhsaWJ1c2JfZGV2aWNlICpkZXYsIHVpbnQ4X3QqIHBvcnRf
bnVtYmVycywgaW50IHBvcnRfbnVtYmVyc19sZW4pOw0KTElCVVNCX0RFUFJFQ0FURURfRk9SKGxp
YnVzYl9nZXRfcG9ydF9udW1iZXJzKQ0KDQpTbyBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVycyByZXBs
YWNlcyBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyLCBzZWVtcyB5b3UgaGF2ZSBhbg0Kb2xkIHZlcnNp
b24gd2hpY2ggaGFzbid0IHlldCBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVycy4NCg0KT24gb2xkIHZl
cnNpb24gcWVtdSBzaG91bGQgZmFsbGJhY2sgdG8gbGlidXNiX2dldF9wb3J0X3BhdGgsIGJ1dCBt
YXliZSB0aGUNCnZlcnNpb24gI2lmZGVmIGlzIHdyb25nIHNvIHRoaXMgZG9lc24ndCB3b3JrIHBy
b3Blcmx5IGZvciBzb21lIHZlcnNpb25zIC4uLg0KDQpBY2NvcmRpbmcgdG8gbXkgL3Vzci9pbmNs
dWRlL2xpYnVzYi0xLjAvbGlidXNiLmggbGlidXNiID49IDEuMC4xNiBkZWNsYXJlcw0KTElCVVNC
X0FQSV9WRVJTSU9OID49IDB4MDEwMDAxMDIsIHNvIHRoYXQgbG9va3Mgb2suICBIbW0sIG5vdCBz
dXJlIHdoYXQgaXMNCmdvaW5nIG9uIGhlcmUuICBJbiBhbnkgY2FzZSB0aGUgbGlidXNiX2dldF9w
b3J0X3BhdGggZmFsbGJhY2sgY29kZSBwYXRoDQpzaG91bGQgd29yay4NCg0KY2hlZXJzLA0KICBH
ZXJkDQoNCg0K

--_000_0679a6d48df44a6e8d2b635dfb0cc566tencentcom_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZT5ib2R5IHsgbGluZS1oZWlnaHQ6IDEu
NTsgfWJsb2NrcXVvdGUgeyBtYXJnaW4tdG9wOiAwcHg7IG1hcmdpbi1ib3R0b206IDBweDsgbWFy
Z2luLWxlZnQ6IDAuNWVtOyB9Ym9keSB7IGZvbnQtc2l6ZTogMTAuNXB0OyBmb250LWZhbWlseTog
J01pY3Jvc29mdCBZYUhlaSBVSSc7IGNvbG9yOiByZ2IoMCwgMCwgMCk7IGxpbmUtaGVpZ2h0OiAx
LjU7IH08L3N0eWxlPg0KPC9oZWFkPg0KPGJvZHk+DQo8ZGl2PjxzcGFuPjwvc3Bhbj5PS++8jHRo
YW5rcywgSSB3aWxsIHRyeSAuPC9kaXY+DQo8ZGl2Pjxicj4NCjwvZGl2Pg0KPGhyIHN0eWxlPSJ3
aWR0aDogMjEwcHg7IGhlaWdodDogMXB4OyIgY29sb3I9IiNiNWM0ZGYiIHNpemU9IjEiIGFsaWdu
PSJsZWZ0Ij4NCjxkaXY+PHNwYW4+QmF1ZXI8L3NwYW4+PC9kaXY+DQo8YmxvY2txdW90ZSBzdHls
ZT0ibWFyZ2luLVRvcDogMHB4OyBtYXJnaW4tQm90dG9tOiAwcHg7IG1hcmdpbi1MZWZ0OiAwLjVl
bSI+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdiBzdHlsZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLXRv
cDpzb2xpZCAjQjVDNERGIDEuMHB0O3BhZGRpbmc6My4wcHQgMGNtIDBjbSAwY20iPg0KPGRpdiBz
dHlsZT0iUEFERElORy1SSUdIVDogOHB4OyBQQURESU5HLUxFRlQ6IDhweDsgRk9OVC1TSVpFOiAx
MnB4O0ZPTlQtRkFNSUxZOnRhaG9tYTtDT0xPUjojMDAwMDAwOyBCQUNLR1JPVU5EOiAjZWZlZmVm
OyBQQURESU5HLUJPVFRPTTogOHB4OyBQQURESU5HLVRPUDogOHB4Ij4NCjxkaXY+PGI+RnJvbTo8
L2I+Jm5ic3A7PGEgaHJlZj0ibWFpbHRvOmtyYXhlbEByZWRoYXQuY29tIj5rcmF4ZWw8L2E+PC9k
aXY+DQo8ZGl2PjxiPkRhdGU6PC9iPiZuYnNwOzIwMjAtMDQtMDMmbmJzcDsxNjoxOTwvZGl2Pg0K
PGRpdj48Yj5Ubzo8L2I+Jm5ic3A7PGEgaHJlZj0ibWFpbHRvOmJhdWVyY2hlbkB0ZW5jZW50LmNv
bSI+YmF1ZXJjaGVuKOmZiOiSmeiSmSk8L2E+PC9kaXY+DQo8ZGl2PjxiPkNDOjwvYj4mbmJzcDs8
YSBocmVmPSJtYWlsdG86cWVtdS1kZXZlbEBub25nbnUub3JnIj5xZW11LWRldmVsPC9hPjsgPGEg
aHJlZj0ibWFpbHRvOmhkZWdvZWRlQHJlZGhhdC5jb20iPg0KaGRlZ29lZGU8L2E+PC9kaXY+DQo8
ZGl2PjxiPlN1YmplY3Q6PC9iPiZuYnNwO1JlOiBpcyBqdXN0IGEgd3JvbmcgZnVuY3Rpb24gbmFt
ZSBvZiBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyPyByZXF1ZXN0IGZvciBhIHJldmlldyBvZiB0aGUg
YnVnIGZpeChJbnRlcm5ldCBtYWlsKTwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8ZGl2
Pk9uIEZyaSwgQXByIDAzLCAyMDIwIGF0IDA3OjA1OjEzQU0gJiM0MzswMDAwLCBiYXVlcmNoZW4o
6ZmI6JKZ6JKZKSB3cm90ZTo8L2Rpdj4NCjxkaXY+Jmd0OyB0aGFua3MsIGJ1dCBteSBsaWJ1c2J4
IHZlcnNpb24gaXMgbGlidXNieC0xLjAuMTUtNC5lbDcueDg2XzY0ICw8L2Rpdj4NCjxkaXY+Jmd0
OyBJIGNhbiBmaW5kIGxpYnVzYl9nZXRfcG9ydF9udW1iZXJzIGZ1bmN0aW9uIGluIGxpYnVzYi0x
LjAuc28uMCBidXQgZmluZCBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyPC9kaXY+DQo8ZGl2PiZndDsg
PC9kaXY+DQo8ZGl2PiZndDsgW3Jvb3RAdF0jIHN0cmluZ3MgL2xpYjY0L2xpYnVzYi0xLjAuc28u
MCB8Z3JlcCBsaWJ1c2JfZ2V0X3BvcnRfbnVtYmVyPC9kaXY+DQo8ZGl2PiZndDsgbGlidXNiX2dl
dF9wb3J0X251bWJlcjwvZGl2Pg0KPGRpdj4mZ3Q7IFtyb290QHRdIzwvZGl2Pg0KPGRpdj4mbmJz
cDs8L2Rpdj4NCjxkaXY+a3JheGVsQHNpcml1cyB+IyBncmVwIGxpYnVzYl9nZXRfcG9ydF9udW1i
ZXIgL3Vzci9pbmNsdWRlL2xpYnVzYi0xLjAvbGlidXNiLmgNCjwvZGl2Pg0KPGRpdj51aW50OF90
IExJQlVTQl9DQUxMIGxpYnVzYl9nZXRfcG9ydF9udW1iZXIobGlidXNiX2RldmljZSAqZGV2KTs8
L2Rpdj4NCjxkaXY+aW50IExJQlVTQl9DQUxMIGxpYnVzYl9nZXRfcG9ydF9udW1iZXJzKGxpYnVz
Yl9kZXZpY2UgKmRldiwgdWludDhfdCogcG9ydF9udW1iZXJzLCBpbnQgcG9ydF9udW1iZXJzX2xl
bik7PC9kaXY+DQo8ZGl2PkxJQlVTQl9ERVBSRUNBVEVEX0ZPUihsaWJ1c2JfZ2V0X3BvcnRfbnVt
YmVycyk8L2Rpdj4NCjxkaXY+Jm5ic3A7PC9kaXY+DQo8ZGl2PlNvIGxpYnVzYl9nZXRfcG9ydF9u
dW1iZXJzIHJlcGxhY2VzIGxpYnVzYl9nZXRfcG9ydF9udW1iZXIsIHNlZW1zIHlvdSBoYXZlIGFu
PC9kaXY+DQo8ZGl2Pm9sZCB2ZXJzaW9uIHdoaWNoIGhhc24ndCB5ZXQgbGlidXNiX2dldF9wb3J0
X251bWJlcnMuPC9kaXY+DQo8ZGl2PiZuYnNwOzwvZGl2Pg0KPGRpdj5PbiBvbGQgdmVyc2lvbiBx
ZW11IHNob3VsZCBmYWxsYmFjayB0byBsaWJ1c2JfZ2V0X3BvcnRfcGF0aCwgYnV0IG1heWJlIHRo
ZTwvZGl2Pg0KPGRpdj52ZXJzaW9uICNpZmRlZiBpcyB3cm9uZyBzbyB0aGlzIGRvZXNuJ3Qgd29y
ayBwcm9wZXJseSBmb3Igc29tZSB2ZXJzaW9ucyAuLi48L2Rpdj4NCjxkaXY+Jm5ic3A7PC9kaXY+
DQo8ZGl2PkFjY29yZGluZyB0byBteSAvdXNyL2luY2x1ZGUvbGlidXNiLTEuMC9saWJ1c2IuaCBs
aWJ1c2IgJmd0Oz0gMS4wLjE2IGRlY2xhcmVzPC9kaXY+DQo8ZGl2PkxJQlVTQl9BUElfVkVSU0lP
TiAmZ3Q7PSAweDAxMDAwMTAyLCBzbyB0aGF0IGxvb2tzIG9rLiZuYnNwOyBIbW0sIG5vdCBzdXJl
IHdoYXQgaXM8L2Rpdj4NCjxkaXY+Z29pbmcgb24gaGVyZS4mbmJzcDsgSW4gYW55IGNhc2UgdGhl
IGxpYnVzYl9nZXRfcG9ydF9wYXRoIGZhbGxiYWNrIGNvZGUgcGF0aDwvZGl2Pg0KPGRpdj5zaG91
bGQgd29yay48L2Rpdj4NCjxkaXY+Jm5ic3A7PC9kaXY+DQo8ZGl2PmNoZWVycyw8L2Rpdj4NCjxk
aXY+Jm5ic3A7IEdlcmQ8L2Rpdj4NCjxkaXY+Jm5ic3A7PC9kaXY+DQo8ZGl2PiZuYnNwOzwvZGl2
Pg0KPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--_000_0679a6d48df44a6e8d2b635dfb0cc566tencentcom_--

