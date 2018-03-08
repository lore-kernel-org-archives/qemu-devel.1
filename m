Received: from eggs.gnu.org ([2001:4830:134:3::10]:44948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.b.zhang@intel.com>) id 1etjWY-0003GJ-KV
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.b.zhang@intel.com>) id 1etjWU-00027v-EX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:35:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:43576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.b.zhang@intel.com>)
	id 1etjWU-00027H-4N
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 19:35:06 -0500
From: "Zhang, Chao B" <chao.b.zhang@intel.com>
Date: Thu, 8 Mar 2018 00:35:00 +0000
Message-ID: <FF72C7E4248F3C4E9BDF19D4918E90F249662402@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-2-marcandre.lureau@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/8] SecurityPkg: also clear
 HashInterfaceHob.SupportedHashMask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>
Cc: "pjones@redhat.com" <pjones@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>, "lersek@redhat.com" <lersek@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>, "Zeng, Star" <star.zeng@intel.com>

UmV2aWV3ZWQtYnk6IENoYW8gWmhhbmc8Y2hhby5iLnpoYW5nQGludGVsLmNvbT4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSBb
bWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbV0gDQpTZW50OiBXZWRuZXNkYXksIE1h
cmNoIDcsIDIwMTggMTE6NTggUE0NClRvOiBlZGsyLWRldmVsQGxpc3RzLjAxLm9yZw0KQ2M6IHBq
b25lc0ByZWRoYXQuY29tOyBZYW8sIEppZXdlbiA8amlld2VuLnlhb0BpbnRlbC5jb20+OyBzdGVm
YW5iQGxpbnV4LnZuZXQuaWJtLmNvbTsgbGVyc2VrQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgamF2aWVybUByZWRoYXQuY29tOyBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbT47IFpoYW5nLCBDaGFvIEIgPGNoYW8uYi56aGFuZ0BpbnRlbC5j
b20+OyBaZW5nLCBTdGFyIDxzdGFyLnplbmdAaW50ZWwuY29tPg0KU3ViamVjdDogW1BBVENIIHYy
IDEvOF0gU2VjdXJpdHlQa2c6IGFsc28gY2xlYXIgSGFzaEludGVyZmFjZUhvYi5TdXBwb3J0ZWRI
YXNoTWFzaw0KDQpGcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVk
aGF0LmNvbT4NCg0KQ29tbWl0IDRjYzJiNjNiZDgyOTQyNmIwNWJhZDBkODk1MmYxODU1YTEwZDZl
ZDcgZml4ZWQgYW4gb3V0IG9mIGJvdW5kcw0KWmVyb01lbSgpIGNhbGwuIEhvd2V2ZXIsIGFzIExh
c3psbyBFcnNlayBwb2ludGVkIG91dCwgdGhlIGludGVudCB3YXMgdG8gY2xlYXIgYWxsIGJ1dCB0
aGUgSWRlbnRpZmllciAodG8gcmV2ZXJ0IHRoZSBlZmZlY3Qgb2YgUmVnaXN0ZXJIYXNoSW50ZXJm
YWNlTGliKCkpLiBGb3IgdGhhdCwgaXQgc2hvdWxkIGNsZWFyIHRoZSBTdXBwb3J0ZWRIYXNoTWFz
ayB0b28uDQoNCkNjOiBKaWV3ZW4gWWFvIDxqaWV3ZW4ueWFvQGludGVsLmNvbT4NCkNjOiBDaGFv
IFpoYW5nIDxjaGFvLmIuemhhbmdAaW50ZWwuY29tPg0KQ2M6IFN0YXIgWmVuZyA8c3Rhci56ZW5n
QGludGVsLmNvbT4NCkNjOiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRoYXQuY29tPg0KQ29udHJp
YnV0ZWQtdW5kZXI6IFRpYW5vQ29yZSBDb250cmlidXRpb24gQWdyZWVtZW50IDEuMQ0KU2lnbmVk
LW9mZi1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+
DQotLS0NCiAuLi4vTGlicmFyeS9IYXNoTGliQmFzZUNyeXB0b1JvdXRlci9IYXNoTGliQmFzZUNy
eXB0b1JvdXRlclBlaS5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoN
CmRpZmYgLS1naXQgYS9TZWN1cml0eVBrZy9MaWJyYXJ5L0hhc2hMaWJCYXNlQ3J5cHRvUm91dGVy
L0hhc2hMaWJCYXNlQ3J5cHRvUm91dGVyUGVpLmMgYi9TZWN1cml0eVBrZy9MaWJyYXJ5L0hhc2hM
aWJCYXNlQ3J5cHRvUm91dGVyL0hhc2hMaWJCYXNlQ3J5cHRvUm91dGVyUGVpLmMNCmluZGV4IDM2
MWE0ZjY1MDhhMC4uYmY2ZTEzMzZlZTc2IDEwMDY0NA0KLS0tIGEvU2VjdXJpdHlQa2cvTGlicmFy
eS9IYXNoTGliQmFzZUNyeXB0b1JvdXRlci9IYXNoTGliQmFzZUNyeXB0b1JvdXRlclBlaS5jDQor
KysgYi9TZWN1cml0eVBrZy9MaWJyYXJ5L0hhc2hMaWJCYXNlQ3J5cHRvUm91dGVyL0hhc2hMaWJC
YXNlQ3J5cHRvUm91dGUNCisrKyByUGVpLmMNCkBAIC00MjYsNiArNDI2LDcgQEAgSGFzaExpYkJh
c2VDcnlwdG9Sb3V0ZXJQZWlDb25zdHJ1Y3RvciAoDQogICAgIC8vDQogICAgIFplcm9NZW0gKCZI
YXNoSW50ZXJmYWNlSG9iLT5IYXNoSW50ZXJmYWNlLCBzaXplb2YgKEhhc2hJbnRlcmZhY2VIb2It
Pkhhc2hJbnRlcmZhY2UpKTsNCiAgICAgSGFzaEludGVyZmFjZUhvYi0+SGFzaEludGVyZmFjZUNv
dW50ID0gMDsNCisgICAgSGFzaEludGVyZmFjZUhvYi0+U3VwcG9ydGVkSGFzaE1hc2sgPSAwOw0K
ICAgfQ0KIA0KICAgLy8NCi0tDQoyLjE2LjIuMzQ2Lmc5Nzc5MzU1ZTM0DQoNCg==
