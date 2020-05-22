Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBF5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB852065C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB852065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc56z-0000ru-MV
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 06:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1jc56J-0000AF-6G
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:40:27 -0400
Received: from mailin3.audi.de ([143.164.102.17]:41855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1jc56G-0000MH-HK
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:40:26 -0400
From: "Konopik, Andreas (EFS-GH2)" <andreas.konopik@efs-auto.de>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: AW: AW: [PATCH 1/1] tricore: added AURIX TC277 D-Step TriBoard
Thread-Topic: AW: [PATCH 1/1] tricore: added AURIX TC277 D-Step TriBoard
Thread-Index: AQHWJ48LXf6REF2PiEms6mbpmD4Ab6iixO2AgAFZcfD//+L2AIAP8Yyg
Date: Fri, 22 May 2020 10:40:18 +0000
Message-ID: <F5B10EA5F04CF44F81B685A0E281578724EA6EF0@AUDIINSX0385.audi.vwg>
References: <20200511122159.7260-1-david.brenken@efs-auto.org>
 <20200511122159.7260-2-david.brenken@efs-auto.org>
 <a0ccf008-cd88-633b-d22c-9528d17e0c6f@redhat.com>
 <F5B10EA5F04CF44F81B685A0E281578724EA08C9@AUDIINSX0385.audi.vwg>
 <4abd52d7-a30a-2d97-e754-75af25d7a019@amsat.org>
In-Reply-To: <4abd52d7-a30a-2d97-e754-75af25d7a019@amsat.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.44.109]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Received-SPF: none client-ip=143.164.102.17;
 envelope-from=andreas.konopik@efs-auto.de; helo=mailin3.audi.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 06:40:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "Biermanski, Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>, "Hofstetter, 
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Brenken,
 David \(EFS-GH5\)" <david.brenken@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVsbG8gUGhpbGlwcGUsDQoNCnNvcnJ5IHRvIGtlZXAgeW91IHdhaXRpbmcuDQoNCj4gLS0tLS1V
cnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsaXBwZS5tYXRoaWV1LmRhdWRlQGdtYWlsLmNvbT4gSW0gQXVmdHJhZw0KPiB2b24g
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gR2VzZW5kZXQ6IERpZW5zdGFnLCAxMi4gTWFpIDIw
MjAgMTA6NDANCj4gQW46IEtvbm9waWssIEFuZHJlYXMgKEVGUy1HSDIpIDxhbmRyZWFzLmtvbm9w
aWtAZWZzLWF1dG8uZGU+OyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnDQo+IENjOiBrYmFzdGlh
bkBtYWlsLnVuaS1wYWRlcmJvcm4uZGU7IEJyZW5rZW4sIERhdmlkIChFRlMtR0g1KQ0KPiA8ZGF2
aWQuYnJlbmtlbkBlZnMtYXV0by5kZT47IEhvZnN0ZXR0ZXIsIEdlb3JnIChFRlMtR0gyKQ0KPiA8
R2VvcmcuSG9mc3RldHRlckBlZnMtYXV0by5kZT47IFJhc2NoZSwgUm9iZXJ0IChFRlMtR0gyKQ0K
PiA8cm9iZXJ0LnJhc2NoZUBlZnMtYXV0by5kZT47IEJpZXJtYW5za2ksIExhcnMgKEVGUy1HSDMp
DQo+IDxsYXJzLmJpZXJtYW5za2lAZWZzLWF1dG8uZGU+DQo+IEJldHJlZmY6IFJlOiBBVzogW1BB
VENIIDEvMV0gdHJpY29yZTogYWRkZWQgQVVSSVggVEMyNzcgRC1TdGVwIFRyaUJvYXJkDQo+IA0K
PiBPbiA1LzEyLzIwIDEwOjMyIEFNLCBLb25vcGlrLCBBbmRyZWFzIChFRlMtR0gyKSB3cm90ZToN
Cj4gPiBIZWxsbyBQaGlsaXBwZSwNCj4gPg0KPiA+IHRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFj
aywgaW1wbGVtZW50aW5nIHRoZSBUcmlCb2FyZCB3aXRoaW4gYW4gU29DDQo+IHN0cnVjdHVyZSBz
ZWVtcyB0byBiZSBiZXN0IHByYWN0aWNlLg0KPiA+IFdlIHdpbGwgcmV3cml0ZSB0aGUgcGF0Y2gg
YWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBJIGFsc28gYXR0YWNoZWQgYW4gZWxmIHdpdGggYW4gZW1w
dHkgbWFpbi1mdW5jdGlvbiB0byB0ZXN0IHRoZSBNYWNoaW5lLg0KPiANCj4gVGhhbmtzLCBJIGFt
IGdldHRpbmc6DQo+IA0KPiAkIHFlbXUtc3lzdGVtLXRyaWNvcmUgLU0gQVVSSVhfVHJpQm9hcmRf
VEMyNzdEIFwNCj4gICAgLWtlcm5lbCBoZWxsb193b3JsZC5lbGYgLWQgdW5pbXAsaW5fYXNtDQo+
IHFlbXUtc3lzdGVtLXRyaWNvcmU6IGZ1bmN0aW9uIGNwdV9nZXRfcGh5c19wYWdlX2F0dHJzX2Rl
YnVnIG5vdA0KPiBpbXBsZW1lbnRlZCwgYWJvcnRpbmcNCj4gDQoNClRoZSBjdXJyZW50IHN0YXRl
IG9mIHRyaWNvcmUgdGFyZ2V0IGlzIGluIHNvbWUgYXJlYXMgbW9yZSBvZiBhIHJ1ZGltZW50YXJ5
IGltcGxlbWVudGF0aW9uIGFuZCBsYWNrcyBtYW55IGZlYXR1cmVzLCBlc3BlY2lhbGx5IGRpc2Fz
c2VtYmx5Lg0KWW91ciBlcnJvciBoYXMgc29tZXRoaW5nIHRvIGRvIHdpdGggdGhlICJpbl9hc20i
IGxvZ2dpbmcuDQoNCkluIG91ciBjYXNlIHdlIHRlc3QgdHJpY29yZSBpbXBsZW1lbnRhdGlvbnMg
dXNpbmcgYSBkdW1teSBkZXZpY2Ugd2hpY2ggcHJpbnRzIHRvIHRoZSBjb21tYW5kbGluZS4NClRo
ZSBiYXJlLW1ldGFsIGVsZiB0aGVuIHdyaXRlcyBsb2dnaW5nIHN0cmluZ3Mgb25lIGNoYXIgYXQg
YSB0aW1lIGludG8gdGhlIGR1bW15IGRldmljZXMgYWRkcmVzcy4NCg0KSWYgeW91IGxpa2UsIEkg
Y2FuIHNlbmQgeW91IHBhdGNoZXMgZm9yIGEgInJlYWwiIGhlbGxvX3dvcmxkIGV4YW1wbGUgaW5j
bHVkaW5nIGR1bW15IGRldmljZS4NCg0KQmVzdCByZWdhcmRzLA0KDQpBbmRyZWFzDQoNCj4gPg0K
PiA+IEJlc3QgcmVnYXJkcywNCj4gPg0KPiA+IEFuZHJlYXMNCj4gPg0KPiA+PiAtLS0tLVVyc3By
w7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+ID4+IFZvbjogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiA+PiBHZXNlbmRldDogTW9udGFnLCAxMS4gTWFpIDIw
MjAgMTU6NDgNCj4gPj4gQW46IERhdmlkIEJyZW5rZW4gPGRhdmlkLmJyZW5rZW5AZWZzLWF1dG8u
b3JnPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IENjOiBrYmFzdGlhbkBtYWlsLnVuaS1w
YWRlcmJvcm4uZGU7IEJpZXJtYW5za2ksIExhcnMgKEVGUy1HSDMpDQo+ID4+IDxsYXJzLmJpZXJt
YW5za2lAZWZzLWF1dG8uZGU+OyBIb2ZzdGV0dGVyLCBHZW9yZyAoRUZTLUdIMikNCj4gPj4gPEdl
b3JnLkhvZnN0ZXR0ZXJAZWZzLWF1dG8uZGU+OyBCcmVua2VuLCBEYXZpZCAoRUZTLUdINSkNCj4g
Pj4gPGRhdmlkLmJyZW5rZW5AZWZzLWF1dG8uZGU+OyBSYXNjaGUsIFJvYmVydCAoRUZTLUdIMikN
Cj4gPj4gPHJvYmVydC5yYXNjaGVAZWZzLSBhdXRvLmRlPjsgS29ub3BpaywgQW5kcmVhcyAoRUZT
LUdIMikNCj4gPj4gPGFuZHJlYXMua29ub3Bpa0BlZnMtYXV0by5kZT4NCj4gPj4gQmV0cmVmZjog
UmU6IFtQQVRDSCAxLzFdIHRyaWNvcmU6IGFkZGVkIEFVUklYIFRDMjc3IEQtU3RlcCBUcmlCb2Fy
ZA0KPiA+Pg0KPiA+PiBIZWxsbyBEYXZpZCwNCj4gPj4NCj4gPj4gT24gNS8xMS8yMCAyOjIxIFBN
LCBEYXZpZCBCcmVua2VuIHdyb3RlOg0KPiA+Pj4gRnJvbTogQW5kcmVhcyBLb25vcGlrIDxhbmRy
ZWFzLmtvbm9waWtAZWZzLWF1dG8uZGU+DQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogQW5k
cmVhcyBLb25vcGlrIDxhbmRyZWFzLmtvbm9waWtAZWZzLWF1dG8uZGU+DQo+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBEYXZpZCBCcmVua2VuIDxkYXZpZC5icmVua2VuQGVmcy1hdXRvLmRlPg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogR2VvcmcgSG9mc3RldHRlciA8Z2VvcmcuaG9mc3RldHRlckBlZnMtYXV0
by5kZT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBSYXNjaGUgPHJvYmVydC5yYXNjaGVA
ZWZzLWF1dG8uZGU+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBMYXJzIEJpZXJtYW5za2kgPGxhcnMu
Ymllcm1hbnNraUBlZnMtYXV0by5kZT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgaHcvdHJpY29yZS9N
YWtlZmlsZS5vYmpzICAgICAgICAgICB8ICAgMSArDQo+ID4+PiAgICBody90cmljb3JlL2F1cml4
X3RyaWJvYXJkX3RjMjc3ZC5jIHwgMjQwDQo+ID4+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDI0MSBpbnNlcnRpb25zKCspDQo+ID4+PiAg
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvdHJpY29yZS9hdXJpeF90cmlib2FyZF90YzI3N2QuYw0K
PiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9ody90cmljb3JlL01ha2VmaWxlLm9ianMgYi9ody90
cmljb3JlL01ha2VmaWxlLm9ianMNCj4gPj4+IGluZGV4DQo+ID4+PiA1NTAxZjZjMWE4Li5lNGEy
MTA2ZGQ5IDEwMDY0NA0KPiA+Pj4gLS0tIGEvaHcvdHJpY29yZS9NYWtlZmlsZS5vYmpzDQo+ID4+
PiArKysgYi9ody90cmljb3JlL01ha2VmaWxlLm9ianMNCj4gPj4+IEBAIC0xICsxLDIgQEANCj4g
Pj4+ICAgIG9iai0kKENPTkZJR19UUklDT1JFKSArPSB0cmljb3JlX3Rlc3Rib2FyZC5vDQo+ID4+
PiArb2JqLSQoQ09ORklHX1RSSUNPUkUpICs9IGF1cml4X3RyaWJvYXJkX3RjMjc3ZC5vDQo+ID4+
PiBkaWZmIC0tZ2l0IGEvaHcvdHJpY29yZS9hdXJpeF90cmlib2FyZF90YzI3N2QuYw0KPiBbLi4u
XQ0K

