Received: from eggs.gnu.org ([2001:4830:134:3::10]:58087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1emcVn-0007hz-7H
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rnsastry@linux.vnet.ibm.com>) id 1emcVk-0002wN-K5
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:40:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55152
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rnsastry@linux.vnet.ibm.com>)
	id 1emcVk-0002t2-DY
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 04:40:56 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1G9cpNO116597
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 04:40:54 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g5tn65a19-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 04:40:54 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <rnsastry@linux.vnet.ibm.com>;
	Fri, 16 Feb 2018 02:40:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 16 Feb 2018 15:12:36 +0530
From: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
In-Reply-To: <b6000e1f-ccae-9adc-bbde-5a1f4c715482@vivier.eu>
References: <151799695576.147.5866177190489987115@bdbb90650ae5>
	<381c5681-a194-6750-06ac-7afeda9173f7@vivier.eu>
	<56e236398cf70cc2f2b431ea7660b3bd@linux.vnet.ibm.com>
	<b6000e1f-ccae-9adc-bbde-5a1f4c715482@vivier.eu>
Message-Id: <1d5a44052bc4f4933ac520b1bbd9a88b@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [patch] linux-user/syscall.c: Fix missing break
 for host_to_target_cmsg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

T24gMjAxOC0wMi0xNSAyMDoxNywgTGF1cmVudCBWaXZpZXIgd3JvdGU6DQo+IExlIDA4LzAy
LzIwMTggw6AgMTA6NTYsIE5hZ2Vzd2FyYSBSIFNhc3RyeSBhIMOpY3JpdMKgOg0KPj4gT24g
MjAxOC0wMi0wNyAxOToyNywgTGF1cmVudCBWaXZpZXIgd3JvdGU6DQo+Pj4gTGUgMDcvMDIv
MjAxOCDDoCAxMDo0OSwgbm8tcmVwbHlAcGF0Y2hldy5vcmcgYSDDqWNyaXTCoDoNCj4+Pj4g
SGksDQo+Pj4+IA0KPj4+PiBUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQgdGVzdCBvbiBzMzkw
eCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscw0KPj4+PiBiZWxvdy4NCj4+PiAuLi4N
Cj4+Pj4gwqAgQ0PCoMKgwqDCoMKgIGFhcmNoNjRfYmUtbGludXgtdXNlci9saW51eC11c2Vy
L3N5c2NhbGwubw0KPj4+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20NCj4+Pj4gL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWV3amduMDgzL3NyYy9saW51eC11c2VyL3FlbXUuaDoxNjow
LA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcm9tDQo+Pj4+IC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ld2pnbjA4My9zcmMvbGludXgtdXNlci9zeXNj
YWxsLmM6MTE4Og0KPj4+PiAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZXdqZ24wODMv
c3JjL2xpbnV4LXVzZXIvc3lzY2FsbC5jOiBJbg0KPj4+PiBmdW5jdGlvbiDigJhkb19zZW5k
cmVjdm1zZ19sb2NrZWTigJk6DQo+Pj4+IC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1l
d2pnbjA4My9zcmMvbGludXgtdXNlci9zeXNjYWxsX2RlZnMuaDozMDg6NjE6DQo+Pj4+IGVy
cm9yOiDigJh0Z3RfbGVu4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBm
dW5jdGlvbg0KPj4+PiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQ0KPj4+PiDCoCNk
ZWZpbmUgVEFSR0VUX0NNU0dfTEVOKGxlbikgKHNpemVvZihzdHJ1Y3QgdGFyZ2V0X2Ntc2do
ZHIpICsgDQo+Pj4+IChsZW4pKQ0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgDQo+Pj4+IF4NCj4+Pj4g
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWV3amduMDgzL3NyYy9saW51eC11c2VyL3N5
c2NhbGwuYzoxNzk3OjEzOiANCj4+Pj4gbm90ZToNCj4+Pj4g4oCYdGd0X2xlbuKAmSB3YXMg
ZGVjbGFyZWQgaGVyZQ0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgIGludCB0Z3RfbGVuLCB0Z3Rf
c3BhY2U7DQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+DQo+Pj4gDQo+
Pj4gaXQgc2VlbXMgZ2NjIGRpc2FncmVlcyB3aXRoIENvdmVyaXR5Li4uDQo+Pj4gDQo+Pj4g
SSB0aGluayB0aGlzIHNob3VsZCBmaXhlZCBsaWtlOg0KPj4+IA0KPj4+IMKgZGlmZiAtLWdp
dCBhL2xpbnV4LXVzZXIvc3lzY2FsbC5jIGIvbGludXgtdXNlci9zeXNjYWxsLmMNCj4+PiBp
bmRleCA3NDM3ODk0N2YwLi5kN2ZiZTMzNGViIDEwMDY0NA0KPj4+IC0tLSBhL2xpbnV4LXVz
ZXIvc3lzY2FsbC5jDQo+Pj4gKysrIGIvbGludXgtdXNlci9zeXNjYWxsLmMNCj4+PiBAQCAt
MTgyNCw4ICsxODI0LDEwIEBAIHN0YXRpYyBpbmxpbmUgYWJpX2xvbmcgDQo+Pj4gaG9zdF90
b190YXJnZXRfY21zZyhzdHJ1Y3QNCj4+PiB0YXJnZXRfbXNnaGRyICp0YXJnZXRfbXNnaCwN
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Z3RfbGVuID0gc2l6ZW9m
KHN0cnVjdCANCj4+PiB0YXJnZXRfdGltZXZhbCk7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
ZmF1bHQ6DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Z3RfbGVuID0g
bGVuOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4g
DQo+PiBJbiBteSB2aWV3IHRoaXMgd2lsbCByZXN1bHQgaW4gYXNzaWduaW5nIGEgd3Jvbmcg
dmFsdWUgdG8gDQo+PiDigJh0Z3RfbGVu4oCZIGF0DQo+PiB0aGlzIOKAmHN3aXRjaC1jYXNl
4oCZIGNvbmRpdGlvbi4NCj4+IEluc3RlYWQgbG9va2luZyBhdCB0aGUgb3B0aW9uIG9mIGlu
aXRpYWxpemluZyDigJh0Z3RfbGVuJyB0byDigJgw4oCZLg0KPiANCj4gQWNjb3JkaW5nIHRv
IHRoZSBjb21tZW50IGFib3ZlIHRoZSBzd2l0Y2goKToNCj4gDQo+ICAgICAgICAgLyogUGF5
bG9hZCB0eXBlcyB3aGljaCBuZWVkIGEgZGlmZmVyZW50IHNpemUgb2YgcGF5bG9hZCBvbg0K
PiAgICAgICAgICAqIHRoZSB0YXJnZXQgbXVzdCBhZGp1c3QgdGd0X2xlbiBoZXJlLg0KPiAg
ICAgICAgICAqLw0KPiANCj4gU28gInRndF9sZW4iIG11c3QgYmUgImxlbiIgYnkgZGVmYXVs
dCwgZXhjZXB0IGlmIGl0IG5lZWRzIHRvIGJlIA0KPiBhZGp1c3RlZA0KPiAoY3VycmVudGx5
IG9ubHkgZm9yIFNPX1RJTUVTVEFNUCksIHNvIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgaXQg
c2hvdWxkDQo+IGJlIHNldCB0byAiMCIuDQo+IA0KPiBUaGFua3MsDQo+IExhdXJlbnQNCg0K
ICAxODE0ICAgICAgICAgc3dpdGNoIChjbXNnLT5jbXNnX2xldmVsKSB7DQogIDE4MTUgICAg
ICAgICBjYXNlIFNPTF9TT0NLRVQ6DQogIDE4MTYgICAgICAgICAgICAgc3dpdGNoIChjbXNn
LT5jbXNnX3R5cGUpIHsNCiAgMTgxNyAgICAgICAgICAgICBjYXNlIFNPX1RJTUVTVEFNUDoN
CiAgMTgxOCAgICAgICAgICAgICAgICAgdGd0X2xlbiA9IHNpemVvZihzdHJ1Y3QgdGFyZ2V0
X3RpbWV2YWwpOw0KICAxODE5ICAgICAgICAgICAgICAgICBicmVhazsNCiAgMTgyMCAgICAg
ICAgICAgICBkZWZhdWx0Og0KICAxODIxICAgICAgICAgICAgICAgICBicmVhazsNCiAgMTgy
MiAgICAgICAgICAgICB9DQogIDE4MjMgICAgICAgICBkZWZhdWx0Og0KICAxODI0ICAgICAg
ICAgICAgIHRndF9sZW4gPSBsZW47DQogIDE4MjUgICAgICAgICAgICAgYnJlYWs7DQogIDE4
MjYgICAgICAgICB9DQoNCg0KSWYgc2V0dGluZyB0Z3RfbGVuID0gbGVuIGF0IDE4MjAgdGhl
biBpdCBnZXQgc2V0IHRvICdjYXNlIFNPTF9TT0NLRVR7IA0Kc3dpdGNoIChjbXNnX3R5cGUn
cyBkZWZhdWx0KSB9JyBUaGlzIHBsYWNlIGFtIG5vdCBzdXJlIGFzc2luZ24gdGd0X2xlbiAN
CndpdGggbGVuLiBUbyBlbGltaW5hdGUgdGhlIGdjYyB1bmluaXRpYWxpemVkIGVycm9yIHRo
b3VnaHQgb2YgDQppbml0aWFsaXppbmcgd2l0aCAnMCcuDQoNCg0KLS0gDQpSZWdhcmRzLA0K
Ui5OYWdlc3dhcmEgU2FzdHJ5DQoNCg==
