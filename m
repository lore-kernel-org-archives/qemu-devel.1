Received: from eggs.gnu.org ([209.51.188.92]:52870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danmei.wei@intel.com>) id 1gzX4s-0004Yq-S0
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 20:35:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danmei.wei@intel.com>) id 1gzX2S-0002Cr-Cd
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 20:32:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:11879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danmei.wei@intel.com>)
	id 1gzX2Q-0002CG-Nc
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 20:32:36 -0500
From: "Wei, Danmei" <danmei.wei@intel.com>
Date: Fri, 1 Mar 2019 01:32:27 +0000
Message-ID: <38A2C2D0FB356A4785EEFA56D99BFB2B0B718B70@SHSMSX101.ccr.corp.intel.com>
References: <38A2C2D0FB356A4785EEFA56D99BFB2B0B718883@SHSMSX101.ccr.corp.intel.com>
	<14b75ee9-7a5f-eb69-f210-f7b2e72cbaf8@redhat.com>
In-Reply-To: <14b75ee9-7a5f-eb69-f210-f7b2e72cbaf8@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Qemu build failure with uninitialized variables
 when "-Wmaybe-uninitialized" is open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Hao, Xudong" <xudong.hao@intel.com>

SSBnb3QgaXQuIE1hbnkgdGhhbmtzLg0KDQpUaGFua3MsDQoJRGFubWVpDQoNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBUaG9tYXMgSHV0aCBbbWFpbHRvOnRodXRoQHJlZGhhdC5j
b21dIA0KU2VudDogRnJpZGF5LCBNYXJjaCAxLCAyMDE5IDEyOjQyIEFNDQpUbzogV2VpLCBEYW5t
ZWkgPGRhbm1laS53ZWlAaW50ZWwuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpDYzogSGFv
LCBYdWRvbmcgPHh1ZG9uZy5oYW9AaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IFtRZW11LWRldmVs
XSBRZW11IGJ1aWxkIGZhaWx1cmUgd2l0aCB1bmluaXRpYWxpemVkIHZhcmlhYmxlcyB3aGVuICIt
V21heWJlLXVuaW5pdGlhbGl6ZWQiIGlzIG9wZW4NCg0KT24gMjgvMDIvMjAxOSAwNC4wMCwgV2Vp
LCBEYW5tZWkgd3JvdGU6DQo+IEhpLA0KPiANCj4gV2hlbiB3ZSBidWlsZCBxZW11IHdpdGggIi1X
bWF5YmUtdW5pbml0aWFsaXplZCIgb24sIGFuZCBnb3QgdGhlIGZvbGxvd2luZyBlcnJvciBpbmZv
cm1hdGlvbi4NCj4gICBDQyAgICAgIHFvYmplY3QvanNvbi1zdHJlYW1lci5vDQo+ICAgQ0MgICAg
ICBxb2JqZWN0L2pzb24tcGFyc2VyLm8NCj4gICBDQyAgICAgIHFvYmplY3QvYmxvY2stcWRpY3Qu
bw0KPiBxb2JqZWN0L2Jsb2NrLXFkaWN0LmM6IEluIGZ1bmN0aW9uICdxZGljdF9hcnJheV9zcGxp
dCc6DQo+IHFvYmplY3QvYmxvY2stcWRpY3QuYzoyNTk6MjU6IGVycm9yOiAnc3VicWRpY3QnIG1h
eSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11
bmluaXRpYWxpemVkXQ0KPiAgICAgICAgICBxbGlzdF9hcHBlbmRfb2JqKCpkc3QsIHN1YnFvYmog
PzogUU9CSkVDVChzdWJxZGljdCkpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPiBtYWtlOiAqKiogW3Fv
YmplY3QvYmxvY2stcWRpY3Qub10gRXJyb3IgMQ0KPiANCj4gSXQgaXMgYmVjYXVzZSBvZiB0aGUg
dW5pbml0aWFsaXplZCB2YXJpYWJsZSBzdWJxZGljdCBmdW5jdGlvbiBxZGljdF9hcnJheV9zcGxp
dC4NCj4gVGhhbmtzIHRvIGNvbmZpcm0gaXQuDQo+IA0KPiBCZWxvdyBpcyB0aGUgRU5WIFNldHRp
bmc6DQo+IE9TOiBSSEVMIE9TIDcuNg0KPiBRZW11IFZlcnNpb246IGNvbW1pdCBjMTAyZDk0NzFm
OGYwMmQ5ZmJlYTcyZWM0NTA1ZDcwODkxNzNmNDcwDQo+IENGTEFHUyBTZXR0aW5nIGluIGVudjog
ZXhwb3J0IENGTEFHUz0iLWcgLU8zIC1XbWF5YmUtdW5pbml0aWFsaXplZCINCg0KRG9uJ3QgYnVp
bGQgUUVNVSB3aXRoIC1PMyBhbmQgLVdtYXliZS11bmluaXRpYWxpemVkIGFuZCAtV2Vycm9yIHRv
Z2V0aGVyLiAtTzMgcHJvZHVjZXMgbG90cyBvZiBmYWxzZSB3YXJuaW5ncyB3aXRoIC1XbWF5YmUt
dW5pbml0aWFsaXplZCwgc28gd2UgY3VycmVudGx5IGRvbid0IHN1cHBvcnQgYnVpbGRpbmcgUUVN
VSB3aXRoIHRoYXQgY29tYmluYXRpb24uIFlvdSBzaG91bGQgYXQgbGVhc3QgYWRkICItV25vLWVy
cm9yPW1heWJlLXVuaW5pdGlhbGl6ZWQiIGlmIHlvdSB3YW50IHRvIGJ1aWxkIHRoYXQgd2F5Lg0K
DQogVGhvbWFzDQo=
