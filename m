Received: from eggs.gnu.org ([2001:4830:134:3::10]:58170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gCPGQ-0001VK-2R
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gCPGM-0004RV-Oq
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:19:58 -0400
Received: from mail-eopbgr00109.outbound.protection.outlook.com
	([40.107.0.109]:14432
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1gCPGM-0004Pf-Cm
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:19:54 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 16 Oct 2018 13:19:49 +0000
Message-ID: <0af002e9-80dc-70b8-6a5b-49e3b1fd235f@virtuozzo.com>
References: <20180313211441.5179-1-jsnow@redhat.com>
	<20180313211441.5179-12-jsnow@redhat.com>
	<CAFEAcA8K9eV=GSrvLsz+XmxsD0g1MrZ+MRFbPHYVR6zR7hucQg@mail.gmail.com>
	<CAFEAcA9hNc1_f7qrJV41pP_WKAb7Zfn9riQyZGBJnanTLd3vnw@mail.gmail.com>
	<17713fbc-6311-87b4-d3d4-6a72cadd6b41@redhat.com>
	<CAFEAcA-uE5PKdC4dTi9CCscUrkvAs82uk60Kfp6btqgWSDf+TQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-uE5PKdC4dTi9CCscUrkvAs82uk60Kfp6btqgWSDf+TQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <876F84DB8771474CBD077EEF1899CC91@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 11/13] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

MTYuMTAuMjAxOCAxNToyNSwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gMjAgSnVuZSAyMDE4
IGF0IDE3OjU4LCBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+IE9u
IDA2LzIwLzIwMTggMTI6NDMgUE0sIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+Pj4gT24gMjcgQXBy
aWwgMjAxOCBhdCAxNDoyMiwgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
PiB3cm90ZToNCj4+Pj4gT24gMTMgTWFyY2ggMjAxOCBhdCAyMToxNCwgSm9obiBTbm93IDxqc25v
d0ByZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+IEZyb206IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+DQo+Pj4+PiBQb3N0Y29weSBt
aWdyYXRpb24gb2YgZGlydHkgYml0bWFwcy4gT25seSBuYW1lZCBkaXJ0eSBiaXRtYXBzIGFyZSBt
aWdyYXRlZC4NCj4+Pj4+DQo+Pj4+PiBJZiBkZXN0aW5hdGlvbiBxZW11IGlzIGFscmVhZHkgY29u
dGFpbmluZyBhIGRpcnR5IGJpdG1hcCB3aXRoIHRoZSBzYW1lIG5hbWUNCj4+Pj4+IGFzIGEgbWln
cmF0ZWQgYml0bWFwIChmb3IgdGhlIHNhbWUgbm9kZSksIHRoZW4sIGlmIHRoZWlyIGdyYW51bGFy
aXRpZXMgYXJlDQo+Pj4+PiB0aGUgc2FtZSB0aGUgbWlncmF0aW9uIHdpbGwgYmUgZG9uZSwgb3Ro
ZXJ3aXNlIHRoZSBlcnJvciB3aWxsIGJlIGdlbmVyYXRlZC4NCj4+Pj4+DQo+Pj4+PiBJZiBkZXN0
aW5hdGlvbiBxZW11IGRvZXNuJ3QgY29udGFpbiBzdWNoIGJpdG1hcCBpdCB3aWxsIGJlIGNyZWF0
ZWQuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4+Pj4gUmV2aWV3ZWQtYnk6IERyLiBE
YXZpZCBBbGFuIEdpbGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5jb20+DQo+Pj4+PiBNZXNzYWdlLWlk
OiAyMDE4MDMxMzE4MDMyMC4zMzk3OTYtMTItdnNlbWVudHNvdkB2aXJ0dW96em8uY29tDQo+Pj4+
PiBbQ2hhbmdlZCAnKycgdG8gJyonIGFzIHBlciBsaXN0IGRpc2N1c3Npb24uIC0tanNdDQo+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+Pj4+PiArc3Rh
dGljIGludCBpbml0X2RpcnR5X2JpdG1hcF9taWdyYXRpb24odm9pZCkNCj4+Pj4+ICt7DQo+Pj4+
IEhpOyBDb3Zlcml0eSAoQ0lEMTM5MDYyNSkgY29tcGxhaW5zIGFib3V0IGEgcG9zc2libGUgZGVy
ZWZlcmVuY2UNCj4+Pj4gYWZ0ZXIgTlVMTCBjaGVjayBpbiB0aGlzIGZ1bmN0aW9uOg0KPj4+Pg0K
Pj4+Pj4gKyAgICBCbG9ja0RyaXZlclN0YXRlICpiczsNCj4+Pj4+ICsgICAgQmRydkRpcnR5Qml0
bWFwICpiaXRtYXA7DQo+Pj4+PiArICAgIERpcnR5Qml0bWFwTWlnQml0bWFwU3RhdGUgKmRibXM7
DQo+Pj4+PiArICAgIEJkcnZOZXh0SXRlcmF0b3IgaXQ7DQo+Pj4+PiArDQo+Pj4+PiArICAgIGRp
cnR5X2JpdG1hcF9taWdfc3RhdGUuYnVsa19jb21wbGV0ZWQgPSBmYWxzZTsNCj4+Pj4+ICsgICAg
ZGlydHlfYml0bWFwX21pZ19zdGF0ZS5wcmV2X2JzID0gTlVMTDsNCj4+Pj4+ICsgICAgZGlydHlf
Yml0bWFwX21pZ19zdGF0ZS5wcmV2X2JpdG1hcCA9IE5VTEw7DQo+Pj4+PiArICAgIGRpcnR5X2Jp
dG1hcF9taWdfc3RhdGUubm9fYml0bWFwcyA9IGZhbHNlOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICBm
b3IgKGJzID0gYmRydl9maXJzdCgmaXQpOyBiczsgYnMgPSBiZHJ2X25leHQoJml0KSkgew0KPj4+
Pj4gKyAgICAgICAgY29uc3QgY2hhciAqZHJpdmVfbmFtZSA9IGJkcnZfZ2V0X2RldmljZV9vcl9u
b2RlX25hbWUoYnMpOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgICAgLyogc2tpcCBhdXRvbWF0aWNh
bGx5IGluc2VydGVkIG5vZGVzICovDQo+Pj4+PiArICAgICAgICB3aGlsZSAoYnMgJiYgYnMtPmRy
diAmJiBicy0+aW1wbGljaXQpIHsNCj4+Pj4+ICsgICAgICAgICAgICBicyA9IGJhY2tpbmdfYnMo
YnMpOw0KPj4+Pj4gKyAgICAgICAgfQ0KPj4+PiBUaGUgJ2JzJyB0ZXN0IGluIHRoaXMgd2hpbGUo
KSBsb29wIGltcGxpZXMgdGhhdCB3ZSBtaWdodA0KPj4+PiBsZWF2ZSB0aGUgbG9vcCBiZWNhdXNl
IGJzID09IE5VTEwuLi4NCj4+Pj4NCj4+Pj4+ICsNCj4+Pj4+ICsgICAgICAgIGZvciAoYml0bWFw
ID0gYmRydl9kaXJ0eV9iaXRtYXBfbmV4dChicywgTlVMTCk7IGJpdG1hcDsNCj4+Pj4gLi4uYnV0
IHRoaXMgY2FsbCB0byBiZHJ2X2RpcnR5X2JpdG1hcF9uZXh0KCkgd2lsbCBhbHdheXMNCj4+Pj4g
ZGVyZWZlcmVuY2UgYnMsIHNvIGlmIGl0J3MgTlVMTCB3ZSdsbCBjcmFzaC4NCj4+Pj4NCj4+Pj4+
ICsgICAgICAgICAgICAgYml0bWFwID0gYmRydl9kaXJ0eV9iaXRtYXBfbmV4dChicywgYml0bWFw
KSkNCj4+PiBIaSAtLSBqdXN0IGEgbnVkZ2UgdGhhdCBDb3Zlcml0eSB0aGlua3MgdGhpcyBvbmUg
aXMgc3RpbGwgdW5maXhlZC4NCj4+IFRoYW5rIHlvdSBmb3IgdGhlIHJlbWluZGVyLCBJJ3ZlIGJl
ZW4gYSBiaXQgc2NhdHRlci1icmFpbmVkIHJlY2VudGx5Lg0KPiBQaW5nPyBUaGlzIGlzIHN0aWxs
IGluIENvdmVyaXR5J3MgbGlzdCBvZiB1bmZpeGVkIGlzc3Vlcy4NCj4NCj4gdGhhbmtzDQo+IC0t
IFBNTQ0KDQpXaWxsIHNlbmQgaW4gZmV3IHNlY29uZHMsIHNvcnJ5IGZvciBzdWNoIGEgdGVycmli
bGUgZGVsYXkgOigNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0KDQo=
