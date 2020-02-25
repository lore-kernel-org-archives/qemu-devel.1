Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6172C35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1DE20714
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1DE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XQS-0002ve-NX
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6XPp-0002GI-5r
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6XPn-0006Gi-TG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:26:13 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:39366 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j6XPk-0006ED-PB; Tue, 25 Feb 2020 05:26:09 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 92BFCEE6EE1832367D8B;
 Tue, 25 Feb 2020 18:26:02 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 18:26:02 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0439.000;
 Tue, 25 Feb 2020 18:25:51 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 09/13] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
Thread-Topic: [PATCH 09/13] dma/xlnx-zdma: Remove redundant statement in
 zdma_write_dst()
Thread-Index: AQHV64DJX5oKQCUBD0CAP5e60Hgha6grIPsAgACILuD//4G4AIAAh5mQ
Date: Tue, 25 Feb 2020 10:25:51 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B661C30@dggemm531-mbx.china.huawei.com>
References: <20200225020937.25028-1-kuhn.chenqun@huawei.com>
 <20200225020937.25028-10-kuhn.chenqun@huawei.com>
 <6d31ac16-adc6-235e-8784-51bf86e33b72@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B661BD7@dggemm531-mbx.china.huawei.com>
 <8ceb7ecc-8edc-0ced-8171-6200ded0dd05@redhat.com>
In-Reply-To: <8ceb7ecc-8edc-0ced-8171-6200ded0dd05@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.255
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIFttYWlsdG86cGhpbG1kQHJlZGhhdC5jb21dDQo+U2VudDogVHVlc2RheSwgRmVicnVh
cnkgMjUsIDIwMjAgNjoxMiBQTQ0KPlRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1
YXdlaS5jb20+OyBxZW11LQ0KPmRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUu
b3JnDQo+Q2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgWmhhbmdoYWlsaWFuZw0KPjx6aGFu
Zy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpckBh
bGlzdGFpcjIzLm1lPjsNCj5xZW11LWFybUBub25nbnUub3JnDQo+U3ViamVjdDogUmU6IFtQQVRD
SCAwOS8xM10gZG1hL3hsbngtemRtYTogUmVtb3ZlIHJlZHVuZGFudCBzdGF0ZW1lbnQgaW4NCj56
ZG1hX3dyaXRlX2RzdCgpDQo+DQo+T24gMi8yNS8yMCAxMTowMSBBTSwgQ2hlbnF1biAoa3Vobikg
d3JvdGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSBbbWFpbHRvOnBoaWxtZEByZWRoYXQuY29tXQ0KPj4+IFNlbnQ6IFR1
ZXNkYXksIEZlYnJ1YXJ5IDI1LCAyMDIwIDU6MzYgUE0NCj4+PiBUbzogQ2hlbnF1biAoa3Vobikg
PGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPjsgcWVtdS0NCj5kZXZlbEBub25nbnUub3JnOw0KPj4+
IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+Pj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9y
ZzsgWmhhbmdoYWlsaWFuZw0KPj4+IDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBB
bGlzdGFpciBGcmFuY2lzDQo+Pj4gPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+OyBxZW11LWFybUBu
b25nbnUub3JnDQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCAwOS8xM10gZG1hL3hsbngtemRtYTog
UmVtb3ZlIHJlZHVuZGFudCBzdGF0ZW1lbnQNCj4+PiBpbg0KPj4+IHpkbWFfd3JpdGVfZHN0KCkN
Cj4+Pg0KPj4+IE9uIDIvMjUvMjAgMzowOSBBTSwga3Vobi5jaGVucXVuQGh1YXdlaS5jb20gd3Jv
dGU6DQo+Pj4+IEZyb206IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+Pj4N
Cj4+Pj4gQ2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6ZXIgc2hvdyB3YXJuaW5nOg0KPj4+PiBody9k
bWEveGxueC16ZG1hLmM6Mzk5OjEzOiB3YXJuaW5nOiBWYWx1ZSBzdG9yZWQgdG8gJ2RzdF90eXBl
JyBpcw0KPj4+PiBuZXZlcg0KPj4+IHJlYWQNCj4+Pj4gICAgICAgICAgICAgICBkc3RfdHlwZSA9
IEZJRUxEX0VYMzIocy0+ZHNjX2RzdC53b3Jkc1szXSwNCj4+PiBaRE1BX0NIX0RTVF9EU0NSX1dP
UkQzLA0KPj4+PiAgICAgICAgICAgICAgIF4NCj4+PiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+Pj4+DQo+Pj4+IFJlcG9ydGVkLWJ5OiBF
dWxlciBSb2JvdCA8ZXVsZXIucm9ib3RAaHVhd2VpLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTog
Q2hlbiBRdW4gPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPj4+PiAtLS0NCj4+Pj4gQ2M6IEFs
aXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+DQo+Pj4+IENjOiAiRWRnYXIg
RS4gSWdsZXNpYXMiIDxlZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20+DQo+Pj4+IENjOiBQZXRlciBN
YXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+Pj4+IENjOiBxZW11LWFybUBub25n
bnUub3JnDQo+Pj4+IC0tLQ0KPj4+PiAgICBody9kbWEveGxueC16ZG1hLmMgfCAyIC0tDQo+Pj4+
ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0
IGEvaHcvZG1hL3hsbngtemRtYS5jIGIvaHcvZG1hL3hsbngtemRtYS5jIGluZGV4DQo+Pj4+IDhm
YjgzZjViMDcuLjQ1MzU1YzVkNTkgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2RtYS94bG54LXpkbWEu
Yw0KPj4+PiArKysgYi9ody9kbWEveGxueC16ZG1hLmMNCj4+Pj4gQEAgLTM5Niw4ICszOTYsNiBA
QCBzdGF0aWMgdm9pZCB6ZG1hX3dyaXRlX2RzdChYbG54WkRNQSAqcywgdWludDhfdA0KPj4+ICpi
dWYsIHVpbnQzMl90IGxlbikNCj4+Pj4gICAgICAgICAgICAgICAgemRtYV9sb2FkX2Rlc2NyaXB0
b3IocywgbmV4dCwgJnMtPmRzY19kc3QpOw0KPj4+PiAgICAgICAgICAgICAgICBkc3Rfc2l6ZSA9
IEZJRUxEX0VYMzIocy0+ZHNjX2RzdC53b3Jkc1syXSwNCj4+PiBaRE1BX0NIX0RTVF9EU0NSX1dP
UkQyLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0laRSk7DQo+
Pj4+IC0gICAgICAgICAgICBkc3RfdHlwZSA9IEZJRUxEX0VYMzIocy0+ZHNjX2RzdC53b3Jkc1sz
XSwNCj4+PiBaRE1BX0NIX0RTVF9EU0NSX1dPUkQzLA0KPj4+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFRZUEUpOw0KPj4+DQo+Pj4gTWF5YmUgbW92ZSBkc3RfdHlwZSB0byB0
aGlzIGlmKCkgc3RhdGVtZW50IG5vdz8NCj4+Pg0KPj4gU29ycnksIEkgZG9uJ3QgZm9sbG93IHlv
dS4gICBJIGRpZG4ndCBmaW5kIHdoZXJlIEkgY291bGQgbW92ZSBkc3RfdHlwZS4NCj4+IERvIHlv
dSBtZWFuIHRvIG1vdmUgdGhlIGZpcnN0IGRzdF90eXBlIHRvIHRoZSBpZigpLg0KPj4gTW9kaWZ5
IGl0IGxpa2UgdGhpczoNCj4+ICAgICAgd2hpbGUgKGxlbikgew0KPj4gICAgICAgICAgZHN0X3Np
emUgPSBGSUVMRF9FWDMyKHMtPmRzY19kc3Qud29yZHNbMl0sDQo+WkRNQV9DSF9EU1RfRFNDUl9X
T1JEMiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTSVpFKTsNCj4+ICAgICAg
ICAgIGlmIChkc3Rfc2l6ZSA9PSAwICYmIHB0eXBlID09IFBUX01FTSkgew0KPj4gICAgICAgICAg
ICAgIHVpbnQ2NF90IG5leHQ7DQo+PiAgICAgICAgICAgICAgZHN0X3R5cGUgPSBGSUVMRF9FWDMy
KHMtPmRzY19kc3Qud29yZHNbM10sDQo+WkRNQV9DSF9EU1RfRFNDUl9XT1JEMywNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFKTsNCj4+ICAgICAgICAgICAgICBuZXh0ID0g
emRtYV91cGRhdGVfZGVzY3JfYWRkcihzLCBkc3RfdHlwZSwNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBSX1pETUFfQ0hfRFNUX0NVUl9EU0NSX0xTQik7DQo+
PiAgICAgICAgICAgICAgemRtYV9sb2FkX2Rlc2NyaXB0b3IocywgbmV4dCwgJnMtPmRzY19kc3Qp
Ow0KPj4gICAgICAgICAgICAgIGRzdF9zaXplID0gRklFTERfRVgzMihzLT5kc2NfZHN0LndvcmRz
WzJdLA0KPlpETUFfQ0hfRFNUX0RTQ1JfV09SRDIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFNJWkUpOw0KPj4gICAgICAgICAgfQ0KPj4gICAgICAgICAuLi4NCj4+ICAg
ICB9DQo+DQo+Tm8sIGxpa2UgdGhpczoNCj4NCj4tLSA+OCAtLQ0KPkBAIC0zNzMsNyArMzczLDcg
QEAgc3RhdGljIHVpbnQ2NF90IHpkbWFfdXBkYXRlX2Rlc2NyX2FkZHIoWGxueFpETUENCj4qcywg
Ym9vbCB0eXBlLA0KPiAgc3RhdGljIHZvaWQgemRtYV93cml0ZV9kc3QoWGxueFpETUEgKnMsIHVp
bnQ4X3QgKmJ1ZiwgdWludDMyX3QgbGVuKQ0KPiAgew0KPiAgICAgIHVpbnQzMl90IGRzdF9zaXpl
LCBkbGVuOw0KPi0gICAgYm9vbCBkc3RfaW50ciwgZHN0X3R5cGU7DQo+KyAgICBib29sIGRzdF9p
bnRyOw0KPiAgICAgIHVuc2lnbmVkIGludCBwdHlwZSA9IEFSUkFZX0ZJRUxEX0VYMzIocy0+cmVn
cywgWkRNQV9DSF9DVFJMMCwNCj5QT0lOVF9UWVBFKTsNCj4gICAgICB1bnNpZ25lZCBpbnQgcndf
bW9kZSA9IEFSUkFZX0ZJRUxEX0VYMzIocy0+cmVncywgWkRNQV9DSF9DVFJMMCwNCj5NT0RFKTsN
Cj4gICAgICB1bnNpZ25lZCBpbnQgYnVyc3RfdHlwZSA9IEFSUkFZX0ZJRUxEX0VYMzIocy0+cmVn
cywNCj5aRE1BX0NIX0RBVEFfQVRUUiwgQEAgLTM4NywxNyArMzg3LDE3IEBAIHN0YXRpYyB2b2lk
DQo+emRtYV93cml0ZV9kc3QoWGxueFpETUEgKnMsIHVpbnQ4X3QgKmJ1ZiwgdWludDMyX3QgbGVu
KQ0KPiAgICAgIHdoaWxlIChsZW4pIHsNCj4gICAgICAgICAgZHN0X3NpemUgPSBGSUVMRF9FWDMy
KHMtPmRzY19kc3Qud29yZHNbMl0sDQo+WkRNQV9DSF9EU1RfRFNDUl9XT1JEMiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFNJWkUpOw0KPi0gICAgICAgIGRzdF90eXBlID0gRklF
TERfRVgzMihzLT5kc2NfZHN0LndvcmRzWzNdLA0KPlpETUFfQ0hfRFNUX0RTQ1JfV09SRDMsDQo+
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEUpOw0KPiAgICAgICAgICBpZiAoZHN0
X3NpemUgPT0gMCAmJiBwdHlwZSA9PSBQVF9NRU0pIHsNCj4gICAgICAgICAgICAgIHVpbnQ2NF90
IG5leHQ7DQo+KyAgICAgICAgICAgIGJvb2wgZHN0X3R5cGU7DQo+Kw0KPisgICAgICAgICAgICBk
c3RfdHlwZSA9IEZJRUxEX0VYMzIocy0+ZHNjX2RzdC53b3Jkc1szXSwNCj5aRE1BX0NIX0RTVF9E
U0NSX1dPUkQzLA0KPisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRSk7DQo+
ICAgICAgICAgICAgICBuZXh0ID0gemRtYV91cGRhdGVfZGVzY3JfYWRkcihzLCBkc3RfdHlwZSwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJfWkRNQV9DSF9E
U1RfQ1VSX0RTQ1JfTFNCKTsNCj4gICAgICAgICAgICAgIHpkbWFfbG9hZF9kZXNjcmlwdG9yKHMs
IG5leHQsICZzLT5kc2NfZHN0KTsNCj4gICAgICAgICAgICAgIGRzdF9zaXplID0gRklFTERfRVgz
MihzLT5kc2NfZHN0LndvcmRzWzJdLA0KPlpETUFfQ0hfRFNUX0RTQ1JfV09SRDIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0laRSk7DQo+LSAgICAgICAgICAgIGRzdF90
eXBlID0gRklFTERfRVgzMihzLT5kc2NfZHN0LndvcmRzWzNdLA0KPlpETUFfQ0hfRFNUX0RTQ1Jf
V09SRDMsDQo+LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUWVBFKTsNCj4gICAg
ICAgICAgfQ0KSG1tLCAgdGhpcyBpcyBiZXR0ZXIuIA0KSSB3aWxsIG1vZGlmeSBpdCBsYXRlciBp
biBWMi4NCg0KVGhhbmtzLg0KPi0tLQ0KDQo=

