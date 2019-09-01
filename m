Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C183AC3A5A4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 12:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F92821897
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 12:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92821897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4P0H-0007MV-JG
	for qemu-devel@archiver.kernel.org; Sun, 01 Sep 2019 08:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1i4Oz2-0006lX-PR
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 08:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1i4Oz1-0001Yi-3e
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 08:29:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2068 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1i4Oz0-0001JE-Id
 for qemu-devel@nongnu.org; Sun, 01 Sep 2019 08:29:27 -0400
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id C5E024496B8A95E634B3;
 Sun,  1 Sep 2019 20:29:16 +0800 (CST)
Received: from DGGEML529-MBX.china.huawei.com ([169.254.6.23]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0439.000; Sun, 1 Sep 2019 20:29:08 +0800
From: fangying <fangying1@huawei.com>
To: Li Qiang <liq3ea@gmail.com>
Thread-Topic: [Qemu-devel] Discussion: vnc: memory leak in zrle_compress_data
Thread-Index: AQHVYMDZqlayrxhx20GDySkBq1VNcA==
Date: Sun, 1 Sep 2019 12:29:07 +0000
Message-ID: <43E932EA88344C498D975E4FF00CF41E2EAB29A5@dggeml529-mbx.china.huawei.com>
References: <7d22c299-29fe-8479-ee14-17d521bb9d6b@huawei.com>,
 <CAKXe6SL+LC4RVRy+4oAKnuS=qMFDG4A0iyoL0hqg_f76gSrmBA@mail.gmail.com>
In-Reply-To: <CAKXe6SL+LC4RVRy+4oAKnuS=qMFDG4A0iyoL0hqg_f76gSrmBA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.189
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Discussion: vnc: memory leak in zrle_compress_data
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, zhouyibo <zhouyibo3@huawei.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TmljZSB3b3JrLCB5b3VyIHBhdGNoIGRvZXMgZml4IHRoaXMgaXNzdWUgaW4gbXkgdGVzdC4NCg0K
SSB0aGluayB3ZSBzaG91bGQgbWFrZSBWbmNTdGF0ZS56bGliIHRvIGJlIGEgcG9pbnRlciB0eXBl
IGFzIHdlbGwuDQoNClNpbmNlIHdlIGFyZSBnb2luZyB0byB1c2UgcG9pbnRlcnMgaW5zdGVhZCBv
ZiBjb3B5LCB3ZSBtdXN0IG1ha2Ugc3VyZSB0aGF0IHRoZXJloa9zIG5vIHJhY2UgY29uZGl0aW9u
IG9mIHBvaW50ZXIgbWVtYmVycyBiZXR3ZWVuIHRoZSBsb2NhbCB2cyAodm5jIHdvcmtlciB0aHJl
YWQpIGFuZCBvcmlnaW4gdnMgKG1haW4gdGhyZWFkKS4NCg0KDQpUaGFua3MuDQpZaW5nIEZhbmcN
CreivP7Iy6O6IExpIFFpYW5nPGxpcTNlYUBnbWFpbC5jb208bWFpbHRvOmxpcTNlYUBnbWFpbC5j
b20+Pg0KytW8/sjLo7ogZmFuZ3lpbmc8ZmFuZ3lpbmcxQGh1YXdlaS5jb208bWFpbHRvOmZhbmd5
aW5nMUBodWF3ZWkuY29tPj4NCrOty82juiBHZXJkIEhvZmZtYW5uPGtyYXhlbEByZWRoYXQuY29t
PG1haWx0bzprcmF4ZWxAcmVkaGF0LmNvbT4+O3FlbXUtZGV2ZWw8cWVtdS1kZXZlbEBub25nbnUu
b3JnPG1haWx0bzpxZW11LWRldmVsQG5vbmdudS5vcmc+PjtEYW5pZWwgUC4gQmVycmFuZ2U8YmVy
cmFuZ2VAcmVkaGF0LmNvbTxtYWlsdG86YmVycmFuZ2VAcmVkaGF0LmNvbT4+O3pob3V5aWJvPHpo
b3V5aWJvM0BodWF3ZWkuY29tPG1haWx0bzp6aG91eWlibzNAaHVhd2VpLmNvbT4+DQrW98zio7og
UmU6IFtRZW11LWRldmVsXSBEaXNjdXNzaW9uOiB2bmM6IG1lbW9yeSBsZWFrIGluIHpybGVfY29t
cHJlc3NfZGF0YQ0KyrG85KO6IDIwMTktMDgtMzEgMjM6NDg6MTANCg0KDQoNCmZhbmd5aW5nIDxm
YW5neWluZzFAaHVhd2VpLmNvbTxtYWlsdG86ZmFuZ3lpbmcxQGh1YXdlaS5jb20+PiDT2jIwMTnE
6jjUwjMxyNXW3MH5IMnPzuc4OjQ10LS1wKO6DQpIaSBHZXJkLA0KDQpNZW1vcnkgbGVhayBpcyBv
YnNlcnZlZCBpbiB6cmxlX2NvbXByZXNzX2RhdGEgd2hlbiB3ZSBhcmUgZG9pbmcgc29tZQ0KQWRk
cmVzc1Nhbml0aXplciB0ZXN0cy4gVGhlIGxlYWsgc3RhY2sgaXMgYXMgYmVsbG93Og0KDQo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KPT00Nzg4Nz09RVJST1I6IExlYWtTYW5pdGl6ZXI6IGRldGVjdGVkIG1lbW9yeSBsZWFr
cw0KDQpEaXJlY3QgbGVhayBvZiAyOTc2MCBieXRlKHMpIGluIDUgb2JqZWN0KHMpIGFsbG9jYXRl
ZCBmcm9tOg0KICAgICAjMCAweGZmZmZhNjdlZjNjMyBpbiBfX2ludGVyY2VwdG9yX2NhbGxvYyAo
L2xpYjY0L2xpYmFzYW4uc28uNCsweGQzM2MzKQ0KICAgICAjMSAweGZmZmZhNjUwNzFjYiBpbiBn
X21hbGxvYzAgKC9saWI2NC9saWJnbGliLTIuMC5zby4wKzB4NTcxY2IpDQogICAgICMyIDB4ZmZm
ZmE1ZTk2OGY3IGluIGRlZmxhdGVJbml0Ml8gKC9saWI2NC9saWJ6LnNvLjErMHg3OGY3KQ0KICAg
ICAjMyAweGFhYWFjZWM1ODYxMyBpbiB6cmxlX2NvbXByZXNzX2RhdGEgdWkvdm5jLWVuYy16cmxl
LmM6ODcNCiAgICAgIzQgMHhhYWFhY2VjNTg2MTMgaW4genJsZV9zZW5kX2ZyYW1lYnVmZmVyX3Vw
ZGF0ZSB1aS92bmMtZW5jLXpybGUuYzozNDQNCiAgICAgIzUgMHhhYWFhY2VjMzRlNzcgaW4gdm5j
X3NlbmRfZnJhbWVidWZmZXJfdXBkYXRlIHVpL3ZuYy5jOjkxOQ0KICAgICAjNiAweGFhYWFjZWM1
ZTAyMyBpbiB2bmNfd29ya2VyX3RocmVhZF9sb29wIHVpL3ZuYy1qb2JzLmM6MjcxDQogICAgICM3
IDB4YWFhYWNlYzVlNWU3IGluIHZuY193b3JrZXJfdGhyZWFkIHVpL3ZuYy1qb2JzLmM6MzQwDQog
ICAgICM4IDB4YWFhYWNlZTRkM2MzIGluIHFlbXVfdGhyZWFkX3N0YXJ0IHV0aWwvcWVtdS10aHJl
YWQtcG9zaXguYzo1MDINCiAgICAgIzkgMHhmZmZmYTU0NGU4YmIgaW4gc3RhcnRfdGhyZWFkICgv
bGliNjQvbGlicHRocmVhZC5zby4wKzB4NzhiYikNCiAgICAgIzEwIDB4ZmZmZmE1Mzk2NWNiIGlu
IHRocmVhZF9zdGFydCAoL2xpYjY0L2xpYmMuc28uNisweGQ1NWNiKQ0KDQpUaGlzIGxlYWsgc3Rh
Y2sgY2FuIGJlIGVhc2lseSByZXByb2R1Y2VkIGluIHRoZSBjYXNlIHRoYXQgYSBjbGllbnQgcmVw
ZWF0ZWRseQ0KZG9lcyB2bmMgY29ubmVjdC9kaXNjb25uZWN0IC4NCg0KVG8gZ2V0IHRoZSBsZWFr
IHN0YWNrLCB3ZSBjYW4gY29tcGlsZSBxZW11IHdpdGgNCi0tZXh0cmEtbGRmbGFncz0tV2wsLS1i
dWlsZC1pZCAtV2wsLXoscmVscm8gLVdsLC16LG5vdyAtbGFzYW4nDQonLS1leHRyYS1jZmxhZ3M9
LU8wIC1nIC1mbm8tb21pdC1mcmFtZS1wb2ludGVyIC1mbm8tc3RhY2stcHJvdGVjdG9yDQotZnNh
bml0aXplPWFkZHJlc3MgLWZzYW5pdGl6ZT1sZWFrJyB1c2luZyBnY2MgdGhhdCBzdXBwb3J0cyBh
c2FuLg0KDQpJdCBpcyBvYnZpb3VzIHRoYXQgdGhlcmUgbWF5IGJlIG1lbW9yeSBsZWFrIGluIHRo
ZSB6bGliL3pybGUgY29tcHJlc3Mgc3R1ZmYuDQpJSVVDLCAqZGVmbGF0ZUluaXQyKiBpcyBjYWxs
ZWQgd2l0aCB0aGUgbG9jYWwgVm5jU3RhdGUgdnMtPnpybGUuc3RyZWFtIHdoZW4gYQ0KY2xpZW50
IGlzIGNvbm5lY3RlZCB0aGUgdm5jIHNlcnZlci4gQW5kIHRoZW4gKmRlZmxhdGUqIGlzIGNhbGxl
ZCB0byBkbyB0aGUNCmVuY29kaW5nLiBGaW5hbGx5ICpkZWZsYXRlRW5kKiBpcyBjYWxsZWQgaW4g
dm5jX3pybGVfY2xlYXIgd2hlbiBhIGNvbm5lY3Rpb24gaXMNCmNsb3NlZC4NCg0KSSBoYWQgbm90
IHRoaW5rIGl0IG91dCB3aHkgdGhpcyBtZW1vcnkgbGVhayBjb3VsZCBoYXBwZW4gaGVyZS4NCkl0
IGlzIG5vdGljZWQgdGhhdCBkZWZsYXRlSW5pdDIgaXMgY2FsbGVkIHdpdGggdGhlIGxvY2FsIHZz
LA0KaG93ZXZlciBkZWZsYXRlRW5kIGlzIGNhbGxlZCB3aXRoIHRoZSBvcmlnaW4gdnMuDQpUaGUg
bG9jYWwgdnMgaXMgY29waWVkIHRvIHRoZSBvcmlnaW4gdnMgaW4gdm5jX2FzeW5jX2VuY29kaW5n
X3N0YXJ0IGFuZA0Kdm5jX2FzeW5jX2VuY29kaW5nX2VuZCBvbiB0aGUgY29udHJhcnkuDQoNCkhh
dmUgeW91IGdvdCBhbnkgaWRlYSBvbiB0aGlzIGlzc3VlID8NCg0KDQpIZWxsbyBZaW5nLA0KDQpJ
IGhhdmUgcG9zdGVkIGEgcGF0Y2ggZm9yIHRoaXMgaXNzdWU6DQotLT4gaHR0cHM6Ly9saXN0cy5n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTktMDgvbXNnMDY2NzUuaHRtbA0KDQpQ
bGVhc2UgY2hlY2sgd2hldGhlciB0aGUgcGF0Y2ggY2FuIGFkZHJlc3MgdGhpcyBpc3N1ZS4NCg0K
VGhhbmtzLA0KTGkgUWlhbmcNCg0KDQoNCg0KVGhhbmtzLg0KWWluZyBGYW5nDQoNCg0K
