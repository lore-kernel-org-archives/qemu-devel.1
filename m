Received: from eggs.gnu.org ([2001:4830:134:3::10]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d9FjF-0004QE-6p
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anthony.xu@intel.com>) id 1d9FjA-0005mP-Sc
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:55:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:35644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anthony.xu@intel.com>)
	id 1d9FjA-0005fB-IP
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:55:48 -0400
From: "Xu, Anthony" <anthony.xu@intel.com>
Date: Fri, 12 May 2017 18:55:43 +0000
Message-ID: <4712D8F4B26E034E80552F30A67BE0B1AB6AA2@ORSMSX112.amr.corp.intel.com>
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
	<618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
	<20170511163447.GA7785@morn.lan>
	<4712D8F4B26E034E80552F30A67BE0B1AB61D5@ORSMSX112.amr.corp.intel.com>
	<ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
In-Reply-To: <ff74288a-d26d-b037-2b55-7dac459aa4ec@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin O'Connor <kevin@koconnor.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

IA0KPiBPbiAxMi8wNS8yMDE3IDAxOjU1LCBYdSwgQW50aG9ueSB3cm90ZToNCj4gPiBIaSBQYW9s
bywNCj4gPg0KPiA+IEluIEtWTSBtb2RlLCBzZWVtcyBBMjAgaXMgaWdub3JlZC4NCj4gPiBEbyB5
b3Ugc2VlIGFueSBwb3RlbnRpYWwgaXNzdWUgaGVyZT8NCj4gDQo+IE5vOyByZWNlbnQgcHJvY2Vz
c29ycyBkb24ndCBoYXZlIEEyMCBhdCBhbGwuDQoNCkkgbWVhbiBBMjAgaW4gZ3Vlc3QsIG5vdCBB
MjAgaW4gaG9zdC4gIA0KR3Vlc3QgaXMgcnVubmluZyBvbiBvbGQgcGxhdGZvcm0sIGl0IHRyaWVz
IHRvIGNvbnRyb2wgQTIwICB0aHJvdWdoIHBvcnQgOTIgbGlrZSB3aGF0IFNlYUJpb3MgZG9lcy4N
ClFFTVUvS1ZNIGRvZXMgaGFuZGxlIHBvcnQgOTIgYWNjZXNzIHRvIHNldCBjb3JyZWN0IGVudi0+
YTIwX21hc2ssDQpidXQgUUVNVS9LVk0gaWdub3JlcyBBMjAgc3RhdHVzIHdoZW4gaGFuZGxpbmcg
Z3Vlc3QgbWVtb3J5IGFjY2Vzcy4NCg0KU2luY2UgUUVNVS9LVk0gd29ya3Mgd2VsbCB3aXRoIFNl
YUJpb3MsIGRvZXMgdGhhdCBpbXBseSBTZWFCaW9zIGRvZXNuJ3QgZ2VuZXJhdGUgYWRkcmVzcw0K
bGFyZ2VyIHRoYW4gMHgxMDAwMDAgaW4gcmVhbCBtb2RlPw0KDQpJZiB0aGF0J3MgdGhlIGNhc2Us
ICBRRU1VL1RDRyBzaG91bGQgd29yayB3aXRoIFNlYUJpb3MgZXZlbiB3aXRoIGlnbm9yaW5nIEEy
MC4NCg0KRHVyaW5nIFNlYUJpb3MgYm9vdCwgdGhlcmUgYXJlID4zNTAgcG9ydCA5MiBhY2Nlc3Ms
IGlmIHdlIGRvbid0IG5lZWQgdG8gaGFuZGxlIEEyMCwgDQp3ZSBjYW4gbWFrZSBBMjAgY29uZmln
dXJhYmxlIGluIFNlYWJpb3MsIEl0IG1heSByZWR1Y2UgU2VhQmlvcyBib290IHRpbWUuDQoNCg0K
QW50aG9ueQ0KDQoNCg0K
