Received: from eggs.gnu.org ([209.51.188.92]:45044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMK8J-0003hw-AU
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMK8I-0002GD-6q
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:24:51 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:50898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMK8H-0002DO-DT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 18:24:50 -0400
In-Reply-To: <d23b59fa-2909-f124-3aab-cc5ded90f063@redhat.com>
References: <tencent_9962D5F9426BA267581CCB79DB1FE17AD508@qq.com>
	<d23b59fa-2909-f124-3aab-cc5ded90f063@redhat.com>
From: "=?ISO-8859-1?B?R0ggQ2Fv?=" <driver1998@foxmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Fri, 3 May 2019 06:24:36 +0800
Message-ID: <tencent_EE29897A62292DA76CA785FB55AF5507090A@qq.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] qga: Fix an enum conversion
 warningincommands-win32.c, hit by clang.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?B?RXJpYyBCbGFrZQ==?= <eblake@redhat.com>, =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>

T24gNS8zLzE5IDY6MjAgQU0sIEVyaWMgQmxha2Ugd3JvdGU6DQoNCj4gV2hlcmUgaXMgZW51
bSBTVE9SQUdFX0JVU19UWVBFIGRlZmluZWQ/IA0KSW4gdGhlIFdpbmRvd3MgU0RLICh3aW5p
b2N0bC5oKSwgc28gYSB0d28td2F5IGNvbnZlcnNpb24gdGFibGUgaXMgbmVlZGVkLg0KDQo+
IEluIGZhY3QsIGl0IGxvb2tzIGxpa2Ugd2luMnFlbXVbXSBpcyBzdXBwb3NlZCB0byBiZSB0
aGF0IHRhYmxlLA0KPiBidXQgaXQgd2FzIGluY29ycmVjdGx5IHdyaXR0ZW4uICBZb3UgV0FO
VCB0byBkbzoNCg0KPiBkaWZmIC0tZ2l0IGkvcWdhL2NvbW1hbmRzLXdpbjMyLmMgdy9xZ2Ev
Y29tbWFuZHMtd2luMzIuYw0KPiBpbmRleCBkNDBkNjFmNjA1Yy4uNmI2N2YxNmZhZjEgMTAw
NjQ0DQo+IC0tLSBpL3FnYS9jb21tYW5kcy13aW4zMi5jDQo+ICsrKyB3L3FnYS9jb21tYW5k
cy13aW4zMi5jDQo+IEBAIC00NTcsNyArNDU3LDcgQEAgdm9pZCBxbXBfZ3Vlc3RfZmlsZV9m
bHVzaChpbnQ2NF90IGhhbmRsZSwgRXJyb3IgKiplcnJwKQ0KPg0KPiAjaWZkZWYgQ09ORklH
X1FHQV9OVEREU0NTSQ0KPg0KPiAtc3RhdGljIFNUT1JBR0VfQlVTX1RZUEUgd2luMnFlbXVb
XSA9IHsNCj4gK3N0YXRpYyBHdWVzdERpc2tCdXNUeXBlIHdpbjJxZW11W10gPSB7DQo+ICAg
ICBbQnVzVHlwZVVua25vd25dID0gR1VFU1RfRElTS19CVVNfVFlQRV9VTktOT1dOLA0KPiAg
ICAgW0J1c1R5cGVTY3NpXSA9IEdVRVNUX0RJU0tfQlVTX1RZUEVfU0NTSSwNCj4gICAgIFtC
dXNUeXBlQXRhcGldID0gR1VFU1RfRElTS19CVVNfVFlQRV9JREUsDQo+DQo+IHdpdGggbm8g
Y2FzdHMgbmVlZGVkLCBlaXRoZXIgaW4gdGhlIHRhYmxlIG9yIGluIHRoZSBmdW5jdGlvbiB0
aGF0DQo+IHJlZmVyZW5jZXMgdGhlIHRhYmxlLg0KDQpZZXMsIEkgY2FuIGNvbmZpcm0gdGhh
dCBmaXhlcyB0aGUgaXNzdWUsIGFuZCBjbGVhcmx5IGJldHRlciB0aGFuIG15IHByZXZpb3Vz
IGVmZm9ydC4NCkknbGwgdXNlIHRoaXMgaW5zdGVhZCBpbiBteSB1cGNvbWluZyB2MyBwYXRj
aCBzZXQu
