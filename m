Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756FAC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427FF20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 03:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LxsDPm2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427FF20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2p3l-0005Hr-Ak
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 23:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1i2p2r-0004lv-QC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1i2p2p-0001aQ-Sk
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:54:53 -0400
Received: from smtpbg501.qq.com ([203.205.250.101]:41635 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1i2p2o-0001M3-Og
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 23:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1566964477;
 bh=m9d7MnUypLIUpb4Xu6aElkkv+lTpCFRxNeTzzPz944I=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=LxsDPm2iIB+CvWqPxOWmOa4cZ+38JP7LNfQxE0r1LFZNVFDhyf0m+v0anwYNhdwr8
 G32DB7VfISt4m659jDZgcLXUjqo76JRIBALQ1binVBogXpklZQRQdRcVN1ZABdKvqu
 nLqPCPBEh+g7AVlfh6jTX/Nxq7Bnf6WGNykZht74=
X-QQ-SSF: 000100000000006000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <CAL1e-=gtL6AxsRYPTO5bztH_F-gJDXixEEif3QRKQYo7d4XcUA@mail.gmail.com>
References: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
 <CAL1e-=jUNzu19BBhFq0M_hjxi6BSgfmZUgQMygszTTonORVNmg@mail.gmail.com>
 <tencent_6386EC2F24D7A13D2B753FCF@qq.com>
 <CAL1e-=gtL6AxsRYPTO5bztH_F-gJDXixEEif3QRKQYo7d4XcUA@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1566964477t104269
From: "=?gb18030?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?gb18030?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?=" <aleksandar.m.mail@gmail.com>
Mime-Version: 1.0
Date: Wed, 28 Aug 2019 11:54:37 +0800
X-Priority: 3
Message-ID: <tencent_1D2ACC9711B86DEA5633A4F0@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 578337816
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Wed, 28 Aug 2019 11:54:37 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.101
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: =?gb18030?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQWxla3NhbmRhciwNCg0KDQpUaGFuayB5b3UgZm9yIHRoZSBsaW5rIHRvIExvb25nc29u
MkYgZG9jdW1lbnRhdGlvbi4gSXQgaGFzIGJlZW4gdmVyeSB1c2VmdWw6KQ0KDQoNCkkgaGF2
ZSBzcGVudCBzZXZlcmFsIGRheXMgaW1tZXJzaW5nIG15c2VsZiBpbiB0aGUgc291cmNlIGNv
ZGUsIG5vdyBJIHRoaW5rIEkgaGF2ZSBhIG1vcmUgc29saWQgdW5kZXJzdGFuZGluZyBhYm91
dCBpdC4gSnVzdCBsaWtlIExvb25nc29uIE11bHRpbWVkaWEgSW5zdHJ1Y3Rpb25zLCBJIG5l
ZWQgdG8gaW1wbGVtZW50IHNvbWUgc29ydCBvZiBjb21wbGV4IHZlY3RvciBpbnN0cnVjdGlv
bnMsIGFuZCBJIG5lZWQgdG8gd3JpdGUgc29tZSBoZWxwZXIgZnVuY3Rpb25zIChlLmcuIG15
X2hlbHBlci5jKS4NCg0KDQpUaGUgUUVNVSB3aWtpIHdlYnNpdGUgaGFzIHZlcnkgdGhvcm91
Z2ggZXhwbGFuYXRpb24gb24gVENHLCBidXQgSSBoYXZlbid0IGZvdW5kIGFueSBleHBsYW5h
dGlvbiBvbiB0aGUgcG9ydC1zcGVjaWZpYyBoZWxwZXJzLiBJcyB0aGVyZSBhbnkgZG9jdW1l
bnRhdGlvbiBvbiBob3cgdGhlIGhlbHBlciBmdW5jdGlvbnMgYXJlIGdlbmVyYXRlZD8gSSB0
aGluayBub3cgSSAqbWlnaHQqIGtub3cgaG93IHRvIHdyaXRlIGEgd29ya2luZyBoZWxwZXIg
ZnVuY3Rpb24sIGJ1dCBJIGp1c3QgZG9uJ3Qga25vdyBob3cgaXQgd29ya3MuDQoNCg0KQ2hl
ZXJzLA0KTGlibw0KDQoNCg0KDQoNCg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdp
bmFsIG1lc3NhZ2UgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAiQWxla3NhbmRhciBNYXJr
b3ZpYyI7IA0KU2VuZHRpbWU6IFRodXJzZGF5LCBBdWcgMjIsIDIwMTkgNjo1MyBQTQ0KVG86
ICJMaWJvIFpob3UiOyANCkNjOiAicWVtdS1kZXZlbCI7IA0KU3ViamVjdDogUmU6IFtRZW11
LWRldmVsXSBRRU1VIGFzIElTUyAoSW5zdHJ1Y3Rpb24gU2V0IFNpbXVsYXRvcikNCg0KDQoN
Ck9uIFRodSwgQXVnIDIyLCAyMDE5IGF0IDEyOjI0IFBNIMGiIDx6aGxiMjlAZm94bWFpbC5j
b20+IHdyb3RlOg0KDQo+IEhpIEFsZWtzYW5kYXIsDQo+DQo+IFRoYW5rIHlvdSB2ZXJ5IG11
Y2ggZm9yIHlvdXIgcGF0aWVudCBleHBsYW5hdGlvbiBpbiB0aGUgcHJldmlvdXMgcG9zdC4g
QW5kDQo+IHRoYW5rIHlvdSBmb3IgY2hlY2tpbmcuDQo+IFlvdXIgYW5kIFBldGVyJ3MgcmVw
bGllcyBpbiB0aGUgcHJldmlvdXMgcG9zdCBjZXJ0YWlubHkgaGVscGVkIGEgbG90LiBJIGFt
DQo+IG5vdyBsb29raW5nIGF0IGEgZ2l0IGNvbW1pdCA3IHllYXJzIGFnbyAoDQo+IGJkMjc3
ZmExOTY2YmM0MDBmMWI0MTFmODY4ZjM5MTI1Y2RhMGM0MDMpLCBpdCB3YXMgYSBMb29uZ3Nv
biBNdWx0aW1lZGlhDQo+IEluc3RydWN0aW9uIGltcGxlbWVudGF0aW9uIGRvbmUgbXkgUmlj
aGFyZCBIZW5kZXJzb24uDQo+DQoNCkNvb2wsIHRoYXQgY29tbWl0IGlzIGEgdmVyeSBnb29k
IHN0YXJpbmcgcG9pbnQgLSBpdCBpcyBkZWZpbml0ZWx5IG5vdCB0b28NCnNpbXBsZSwgYW5k
IGl0IGlzIG5vdCB0b28gY29tcGxleCBlaXRoZXIuIEFuZCB5b3UgY2FuIGRpc2NvdmVyIHNl
dmVyYWwNCmRpZmZlcmVudCBjb25jZXB0cyBpbiB0aGUgcHJvY2VzcyBvZiBleHBsb3Jpbmcg
dGhlIGNoYW5nZS4NCg0KRG9jdW1lbnRhdGlvbiBvbiBpbnN0cnVjdGlvbiBzZXQgZXh0ZW5z
aW9uIHJlbGF0ZWQgdG8gdGhlIGNvbW1pdCAoZm91bmQgYnkNCkdvb2dsZSk6DQpodHRwczov
L2ZpbGVzLnNvbW5pYWZhYnVsYXJ1bS5jb20vbG9vbmdzb24vZG9jcy9Mb29uZ3NvbjJGVXNl
ckd1aWRlLnBkZg0KDQpCZSBwZXJzaXN0ZW50LCB0YWtlIHlvdXIgdGltZSwgc3R1ZHkgdGhl
IGRldGFpbHMgYW5kIGhhbmRsaW5nIG9mIGluZGl2aWR1YWwNCmluc3RydWN0aW9ucywgYW5k
LCBvZiBjb3Vyc2UsIGxldCB1cyBrbm93IGlmIHlvdSBlbmNvdW50ZXIgc29tZSBtYWpvcg0K
b2JzdGFjbGVzIG9yIHRob3JueSBkaWxlbW1hcy4NCg0KWW91cnMsDQpBbGVrc2FuZGFyDQoN
Cg0KPiBJIHRoaW5rIHdoYXQgaGUgZGlkIGlzIGV4YWN0bHkgd2hhdCBJIHdhbnQgdG8gZG8g
bm93LiBJIGdvdCBhIHZhZ3VlIHZpZXcNCj4gb2YgdGhlIGJpZyBwaWN0dXJlLCBidXQgSSBu
ZWVkIG1vcmUgdGltZSB0byBmaWd1cmUgb3V0IHRoZSBkZXRhaWxzLiBJIHdpbGwNCj4gY2Vy
dGFpbmx5IGFzayBtb3JlIHF1ZXN0aW9ucyBhYm91dCB0aGlzIGxhdGVyLCBidXQgYmVmb3Jl
IHRoYXQgSSBuZWVkIHRvDQo+IGxvb2sgYXQgc29tZSBvdGhlciBwYXJ0cyBvZiB0aGUgc291
cmNlIGNvZGU6KSBBZ2FpbiB0aGFuayB5b3UgZm9yIGNoZWNraW5nIQ0KPg0KPiBDaGVlcnMs
DQo+IExpYm8NCj4NCj4NCj4gLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIG1lc3NhZ2Ug
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ICpGcm9tOiogIkFsZWtzYW5kYXIgTWFya292aWMiOw0K
PiAqU2VuZHRpbWU6KiBUaHVyc2RheSwgQXVnIDIyLCAyMDE5IDQ6MjMgUE0NCj4gKlRvOiog
IsGiIjsNCj4gKkNjOiogInFlbXUtZGV2ZWwiOw0KPiAqU3ViamVjdDoqIFJlOiBbUWVtdS1k
ZXZlbF0gUUVNVSBhcyBJU1MgKEluc3RydWN0aW9uIFNldCBTaW11bGF0b3IpDQo+DQo+IE9u
IFR1ZSwgQXVnIDIwLCAyMDE5IGF0IDEyOjEyIFBNIMGiIDx6aGxiMjlAZm94bWFpbC5jb20+
IHdyb3RlOg0KPg0KPiA+IEkgYW0gd29ya2luZyBvbiBhIHByb2plY3QgdGhhdCByZXF1aXJl
cyBtZSB0byBtb2RpZnkgdGhlIElTQSBvZiB0aGUgTUlQUw0KPiA+IHRhcmdldC4NCj4NCj4N
Cj4gTC4sDQo+DQo+IEhvdyBpcyBpdCBnb2luZz8NCj4NCj4gQWxla3NhbmRhcg0KPg0KPg0K
Pg0KPiA+IEkgaGF2ZSBiZWVuIHN0YXJpbmcgYXQgdGhlIHNvdXJjZSBjb2RlIGZvciBhYm91
dCBhIHdlZWssIGJ1dCBmb3VuZCBpdA0KPiA+IHJlYWxseSBkaWZmaWN1bHQgZHVlIHRvIG1l
IGJlaW5nIGEgeW91bmcgcm9va2llIGFuZCB0aGUgc3BhcnNlIGNvbW1lbnRzLg0KPiA+IFNw
ZWNpZmljYWxseSwgSSBuZWVkIHRvIGV4dGVuZCBNSVBTLCBieSBhZGRpbmcgc29tZSBuZXcg
aW5zdHJ1Y3Rpb25zIGFuZA0KPiA+IG5ldyBDUFUgcmVnaXN0ZXJzIHRvIHRoZSBjdXJyZW50
IGFyY2hpdGVjdHVyZSwgYW5kIHRoYXQgc291bmRzIHJlYWxseQ0KPiBlYXN5Lg0KPiA+IEkg
dGhpbmsgdGhlIHBsYWNlIGZvciBtZSB0byBsb29rIGF0IHNob3VsZCBiZSBhdCB0aGUgZGly
ZWN0b3J5DQo+ID4gJHtxZW11X3Jvb3R9L3RhcmdldC9taXBzLy4gV2l0aCBhIE1JUFMgSW5z
dHJ1Y3Rpb24gU2V0IE1hbnVhbCBSZWxlYXNlIDYNCj4gPiBoYW5keSwgSSBoYXZlIGRpZmZp
Y3VsdHkgZmluZGluZyB0aGUgc291cmNlIGNvZGUgd2hlcmUgdGhlIElTQSByZXNpZGVzLg0K
PiBJcw0KPiA+IGl0IGluIG9wX2hlbHBlci5jPyBPciB0cmFuc2xhdGUuYz8gQW55IGd1aWRh
bmNlIHdvdWxkIGJlIHJlYWxseQ0KPiA+IGFwcHJlY2lhdGVkLiBUaGFuayB5b3UgdmVyeSBt
dWNoIGluIGFkdmFuY2UuDQo+ID4NCj4gPg0KPiA+IENoZWVycywNCj4gPiBMLg0KPg==
