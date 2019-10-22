Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA4FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33FF21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33FF21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMvXC-0002kh-Ow
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iMunC-0000Ic-9y
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iMun6-0002CE-Qc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:05:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2048 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iMun3-00028t-2Z; Tue, 22 Oct 2019 10:05:37 -0400
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 67F4519BA3D160F1BC6A;
 Tue, 22 Oct 2019 15:05:32 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.18]) by
 lhreml705-cah.china.huawei.com ([10.201.108.46]) with mapi id 14.03.0415.000; 
 Tue, 22 Oct 2019 15:05:22 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Subject: RE: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Topic: [PATCH 0/5] ARM virt: Add NVDIMM support
Thread-Index: AQHVeswdQv2zL2ZjnU2+5S1CywnCCKdgnucAgAYn2EA=
Date: Tue, 22 Oct 2019 14:05:22 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F467DD5@lhreml524-mbs.china.huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
 <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
In-Reply-To: <a133d4c4-3f60-2bb1-a7d7-35cdb06af265@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.176.76.210
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
 "lersek@redhat.com" <lersek@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBdWdlciBF
cmljIFttYWlsdG86ZXJpYy5hdWdlckByZWRoYXQuY29tXQ0KPiBTZW50OiAxOCBPY3RvYmVyIDIw
MTkgMTc6NDANCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT47DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1h
cm1Abm9uZ251Lm9yZzsgaW1hbW1lZG9AcmVkaGF0LmNvbQ0KPiBDYzogcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyBzaGFubm9uLnpoYW9zbEBnbWFpbC5jb207IHh1d2VpIChPKQ0KPiA8eHV3ZWk1
QGh1YXdlaS5jb20+OyBsZXJzZWtAcmVkaGF0LmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1
YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC81XSBBUk0gdmlydDogQWRkIE5WRElN
TSBzdXBwb3J0DQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gMTAvNC8xOSA1OjUyIFBNLCBT
aGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgTlZESU1NIHN1cHBv
cnQgdG8gYXJtL3ZpcnQgcGxhdGZvcm0uDQo+ID4gVGhpcyBoYXMgYSBkZXBlbmRlbmN5IG9uIFsw
XSBhbmQgbWFrZSB1c2Ugb2YgdGhlIEdFRA0KPiA+IGRldmljZSBmb3IgTlZESU1NIGhvdHBsdWcg
ZXZlbnRzLiBUaGUgc2VyaWVzIHJldXNlcw0KPiA+IHNvbWUgb2bCoHRoZcKgcGF0Y2hlcyBwb3N0
ZWQgYnkgRXJpYyBpbiBoaXMgZWFybGllcg0KPiA+IGF0dGVtcHQgaGVyZVsxXS4NCj4gPg0KPiA+
IFBhdGNoIDEvNSBpcyBhIGZpeCB0byB0aGUgR3Vlc3QgcmVib290IGlzc3VlIG9uIE5WRElNTQ0K
PiA+IGhvdCBhZGQgY2FzZSBkZXNjcmliZWQgaGVyZVsyXS4NCj4gPg0KPiA+IEkgaGF2ZSBkb25l
IGJhc2ljIHNhbml0eSB0ZXN0aW5nIG9mIE5WRElNTSBkZXZpZWNzIHdpdGgNCj4gZGV2Y2llcw0K
PiA+IGJvdGggQUNQSSBhbmQgRFQgR3Vlc3QgYm9vdC4gRnVydGhlciB0ZXN0aW5nIGlzIGFsd2F5
cw0KPiA+IHdlbGNvbWUuDQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBmZWVkYmFj
ay4NCj4gDQo+IEkgdGVzdGVkIGl0IG9uIG15IHNpZGUuIExvb2tzIHRvIHdvcmsgcHJldHR5IHdl
bGwuDQoNClRoYW5rcyBmb3IgZ2l2aW5nIHRoaXMgYSBzcGluLg0KIA0KPiBvbmUgcXVlc3Rpb246
IEkgbm90aWNlZCB0aGF0IHdoZW4gYSBOVkRJTU0gc2xvdCBpcyBob3RwbHVnZ2VkIG9uZSBnZXQN
Cj4gdGhlIGZvbGxvd2luZyB0cmFjZSBvbiBndWVzdDoNCj4gDQo+IG5maXQgQUNQSTAwMTI6MDA6
IGZvdW5kIGEgemVybyBsZW5ndGggdGFibGUgJzAnIHBhcnNpbmcgbmZpdA0KPiBwbWVtMDogZGV0
ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAxMDczNzQxODI0DQo+IA0KPiBIYXZlIHlv
dSBleHBlcmllbmNlZCB0aGUgMCBsZW5ndGggdHJhY2U/DQoNCkkgZG91YmxlIGNoZWNrZWQgYW5k
IHllcyB0aGF0IHRyYWNlIGlzIHRoZXJlLiBBbmQgSSBkaWQgYSBxdWljayBjaGVjayB3aXRoDQp4
ODYgYW5kIGl0IGlzIG5vdCB0aGVyZS4gDQoNClRoZSByZWFzb24gbG9va3MgbGlrZSwgQVJNNjQg
a2VybmVsIHJlY2VpdmVzIGFuIGFkZGl0aW9uYWwgOCBieXRlcyBzaXplIHdoZW4NCnRoZSBrZXJu
ZWwgZXZhbHVhdGVzIHRoZSAiX0ZJVCIgb2JqZWN0LiANCg0KRm9yIHRoZSBzYW1lIHRlc3Qgc2Nl
bmFyaW8sIFFlbXUgcmVwb3J0cyBhIEZJVCBidWZmZXIgc2l6ZSBvZiAweGI4IGFuZCANCg0KWDg2
IEd1ZXN0IGtlcm5lbCwNClsgICAgMS42MDEwNzddIGFjcGlfbmZpdF9pbml0OiBkYXRhIDB4ZmZm
ZjhhMjczZGMxMmIxOCBzeiAweGI4DQoNCkFSTTY0IEd1ZXN0LA0KWyAgICAwLjkzMzEzM10gYWNw
aV9uZml0X2luaXQ6IGRhdGEgMHhmZmZmMDAwMDNjYmU2MDE4IHN6IDB4YzANCg0KSSBhbSBub3Qg
c3VyZSBob3cgdGhhdCBzaXplIGdldHMgY2hhbmdlZCBmb3IgQVJNIHdoaWNoIHJlc3VsdHMgaW4N
CnRoZSBhYm92ZSBtZW50aW9uZWQgMCBsZW5ndGggdHJhY2UuIEkgbmVlZCB0byBkZWJ1ZyB0aGlz
IGZ1cnRoZXIuDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBhbnkgcG9pbnRlcnMu
Li4NCiANCj4gQmVzaWRlcyB3aGVuIHdlIHJlc2V0IHRoZSBzeXN0ZW0gd2UgZmluZCB0aGUgbmFt
ZXNwYWNlcyBhZ2FpbiB1c2luZw0KPiAibmRjdGwgbGlzdCAtdSIgc28gdGhlIG9yaWdpbmFsIGJ1
ZyBzZWVtcyB0byBiZSBmaXhlZC4NCj4gDQo+IERpZCB5b3UgdHJ5IHRvIG1vdW50IGEgREFYIEZT
LiBJIGNhbiBtb3VudCBidXQgd2l0aCBEQVggZm9yY2VkIG9mZi4NCj4gc3VkbyBta2RpciAvbW50
L21lbTANCg0KWWVzLiBJIGRpZCB0cnkgd2l0aCBEQVggRlMuIEJ1dCBkbyB3ZSBuZWVkIHRvIGNo
YW5nZSB0aGUgbmFtZXNwYWNlIG1vZGUgdG8gDQpmaWxlIHN5c3RlbSBEQVggbW9kZT8NCg0KSSB1
c2VkIHRoZSBiZWxvdyBjb21tYW5kIGJlZm9yZSBhdHRlbXB0aW5nIHRvIG1vdW50IHdpdGggLW8g
ZGF4LA0KDQpuZGN0bCBjcmVhdGUtbmFtZXNwYWNlIC1mIC1lIG5hbWVzcGFjZTAuMCAtLW1vZGU9
ZnNkYXgNCg0KQW5kIGluIG9yZGVyIHRvIGRvIHRoZSBhYm92ZSB5b3UgbWlnaHQgbmVlZCB0aGUg
Wk9ORV9ERVZJQ0Ugc3VwcG9ydA0KaW4gdGhlIEtlcm5lbCB3aGljaCBpbiB0dXJuIGhhcyBkZXBl
bmRlbmN5IG9uIGhvdCByZW1vdmUuIEhlbmNlIEkgdHJpZWQgd2l0aA0KImFybTY0L21tOiBFbmFi
bGUgbWVtb3J5IGhvdCByZW1vdmUiIHBhdGNoZXMsDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvY292ZXIvMTExODUxNjkvDQoNCj4gbWtmcy54ZnMgLWYgLW0gcmVmbGluaz0wIC9kZXYv
cG1lbTANCj4gc3VkbyBtb3VudCAtbyBkYXggL2Rldi9wbWVtMCAvbW50L21lbTANCj4gWyAyNjEw
LjA1MTgzMF0gWEZTIChwbWVtMCk6IERBWCBlbmFibGVkLiBXYXJuaW5nOiBFWFBFUklNRU5UQUws
IHVzZSBhdA0KPiB5b3VyIG93biByaXNrDQo+IFsgMjYxMC4xNzg1ODBdIFhGUyAocG1lbTApOiBE
QVggdW5zdXBwb3J0ZWQgYnkgYmxvY2sgZGV2aWNlLiBUdXJuaW5nIG9mZg0KPiBEQVguDQo+IFsg
MjYxMC4xODA4NzFdIFhGUyAocG1lbTApOiBNb3VudGluZyBWNSBGaWxlc3lzdGVtDQo+IFsgMjYx
MC4xODk3OTddIFhGUyAocG1lbTApOiBFbmRpbmcgY2xlYW4gbW91bnQNCj4gDQo+IEkgZmFpbCB0
byByZW1lbWJlciBpZiBpdCB3YXMgdGhlIGNhc2UgbW9udGhzIGFnby4gSSBhbSBub3Qgc3VyZSBp
ZiBpdCBpcw0KPiBhbiBpc3N1ZSBpbiBteSBndWVzdCAuY29uZmlnIG9yIGlmIHRoZXJlIGlzIHNv
bWV0aGluZyBub3QgeWV0IHN1cHBvcnRlZA0KPiBvbiBhYXJjaDY0PyBEaWQgeW91IHRyeSBvbiB5
b3VyIHNpZGU/DQo+IA0KPiBBbHNvIGlmIHlvdSBmb3JnZXQgdG8gcHV0IHRoZSAiLG52ZGltbSIg
dG8gdGhlIG1hY2h2aXJ0IG9wdGlvbnMgeW91IGdldCwNCj4gb24gaG90cGx1ZzoNCj4geyJlcnJv
ciI6IHsiY2xhc3MiOiAiR2VuZXJpY0Vycm9yIiwgImRlc2MiOiAibnZkaW1tIGlzIG5vdCB5ZXQg
c3VwcG9ydGVkIn19DQo+IHdoaWNoIGlzIG5vdCBjb3JyZWN0IGFueW1vcmUgOy0pDQoNCk9rLiBJ
IHdpbGwgY2hlY2sgdGhpcy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KIA0KPiBUaGFua3MNCj4gDQo+
IEVyaWMNCj4gDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFNoYW1lZXINCj4gPg0KPiA+IFsw
XSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMTUwMzQ1Lw0KPiA+IFsxXSBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzEwODMwNzc3Lw0KPiA+IFsyXSBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTU0NzU3Lw0KPiA+DQo+ID4gRXJpYyBB
dWdlciAoMSk6DQo+ID4gICBody9hcm0vYm9vdDogRXhwb3NlIHRoZSBwbWVtIG5vZGVzIGluIHRo
ZSBEVA0KPiA+DQo+ID4gS3dhbmd3b28gTGVlICgyKToNCj4gPiAgIG52ZGltbTogVXNlIGNvbmZp
Z3VyYWJsZSBBQ1BJIElPIGJhc2UgYW5kIHNpemUNCj4gPiAgIGh3L2FybS92aXJ0OiBBZGQgbnZk
aW1tIGhvdC1wbHVnIGluZnJhc3RydWN0dXJlDQo+ID4NCj4gPiBTaGFtZWVyIEtvbG90aHVtICgy
KToNCj4gPiAgIGh3L2FybTogQWxpZ24gQUNQSSBibG9iIGxlbiB0byBQQUdFIHNpemUNCj4gPiAg
IGh3L2FybS92aXJ0OiBBZGQgbnZkaW1tIGhvdHBsdWcgc3VwcG9ydA0KPiA+DQo+ID4gIGRvY3Mv
c3BlY3MvYWNwaV9od19yZWR1Y2VkX2hvdHBsdWcucnN0IHwgIDEgKw0KPiA+ICBody9hY3BpL2dl
bmVyaWNfZXZlbnRfZGV2aWNlLmMgICAgICAgICB8IDEzICsrKysrKysrDQo+ID4gIGh3L2FjcGkv
bnZkaW1tLmMgICAgICAgICAgICAgICAgICAgICAgIHwgMzIgKysrKysrKysrKysrLS0tLS0tDQo+
ID4gIGh3L2FybS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPiA+ICBo
dy9hcm0vYm9vdC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQ1DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIGh3L2FybS92aXJ0LWFjcGktYnVpbGQuYyAgICAgICAgICAg
ICAgIHwgMjAgKysrKysrKysrKysrDQo+ID4gIGh3L2FybS92aXJ0LmMgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgNDINCj4gKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gIGh3L2kzODYv
YWNwaS1idWlsZC5jICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKw0KPiA+ICBody9pMzg2L2Fj
cGktYnVpbGQuaCAgICAgICAgICAgICAgICAgICB8ICAzICsrDQo+ID4gIGh3L2kzODYvcGNfcGlp
eC5jICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysNCj4gPiAgaHcvaTM4Ni9wY19xMzUuYyAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMiArKw0KPiA+ICBody9tZW0vS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ID4gIGluY2x1ZGUvaHcvYWNwaS9nZW5lcmljX2V2
ZW50X2RldmljZS5oIHwgIDEgKw0KPiA+ICBpbmNsdWRlL2h3L2FybS92aXJ0LmggICAgICAgICAg
ICAgICAgICB8ICAxICsNCj4gPiAgaW5jbHVkZS9ody9tZW0vbnZkaW1tLmggICAgICAgICAgICAg
ICAgfCAgMyArKw0KPiA+ICAxNSBmaWxlcyBjaGFuZ2VkLCAxNTcgaW5zZXJ0aW9ucygrKSwgMTcg
ZGVsZXRpb25zKC0pDQo+ID4NCg==

