Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1faNcd-0007h9-VB
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paulmck@linux.vnet.ibm.com>) id 1faNcY-0000SL-Ua
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:53:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56040
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <paulmck@linux.vnet.ibm.com>)
	id 1faNcY-0000S0-NN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:53:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63FmdrS115713
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 11:53:36 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k0aajdwtu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 11:53:35 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 11:53:34 -0400
Date: Tue, 3 Jul 2018 08:55:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-10-xiaoguangrong@tencent.com>
	<20180620045203.GE18985@xz-mi>
	<6f871708-d38b-2acf-350a-985c8a23a013@gmail.com>
	<5B34CCB9.5040406@intel.com>
	<e7e37560-3c52-39d2-64be-67d79d210496@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7e37560-3c52-39d2-64be-67d79d210496@gmail.com>
Message-Id: <20180703155541.GB3593@linux.vnet.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 09/12] ring: introduce lockless ring buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Peter Xu <peterx@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, Xiao Guangrong <xiaoguangrong@tencent.com>, peterz@infradead.org, stefani@seibold.net, Lai Jiangshan <jiangshanlai@gmail.com>

T24gRnJpLCBKdW4gMjksIDIwMTggYXQgMTE6NTU6MDhBTSArMDgwMCwgWGlhbyBHdWFuZ3Jv
bmcgd3JvdGU6DQo+IA0KPiANCj4gT24gMDYvMjgvMjAxOCAwNzo1NSBQTSwgV2VpIFdhbmcg
d3JvdGU6DQo+ID5PbiAwNi8yOC8yMDE4IDA2OjAyIFBNLCBYaWFvIEd1YW5ncm9uZyB3cm90
ZToNCj4gPj4NCj4gPj5DQzogUGF1bCwgUGV0ZXIgWmlqbHN0cmEsIFN0ZWZhbmksIExhaSB3
aG8gYXJlIGFsbCBnb29kIGF0IG1lbW9yeSBiYXJyaWVyLg0KPiA+Pg0KPiA+Pg0KPiA+Pk9u
IDA2LzIwLzIwMTggMTI6NTIgUE0sIFBldGVyIFh1IHdyb3RlOg0KPiA+Pj5PbiBNb24sIEp1
biAwNCwgMjAxOCBhdCAwNTo1NToxN1BNICswODAwLCBndWFuZ3JvbmcueGlhb0BnbWFpbC5j
b20gd3JvdGU6DQo+ID4+Pj5Gcm9tOiBYaWFvIEd1YW5ncm9uZyA8eGlhb2d1YW5ncm9uZ0B0
ZW5jZW50LmNvbT4NCj4gPj4+Pg0KPiA+Pj4+SXQncyB0aGUgc2ltcGxlIGxvY2tsZXNzIHJp
bmcgYnVmZmVyIGltcGxlbWVudCB3aGljaCBzdXBwb3J0cyBib3RoDQo+ID4+Pj5zaW5nbGUg
cHJvZHVjZXIgdnMuIHNpbmdsZSBjb25zdW1lciBhbmQgbXVsdGlwbGUgcHJvZHVjZXJzIHZz
Lg0KPiA+Pj4+c2luZ2xlIGNvbnN1bWVyLg0KPiA+Pj4+DQo+ID4+Pj5NYW55IGxlc3NvbnMg
d2VyZSBsZWFybmVkIGZyb20gTGludXggS2VybmVsJ3Mga2ZpZm8gKDEpIGFuZCBEUERLJ3MN
Cj4gPj4+PnJ0ZV9yaW5nICgyKSBiZWZvcmUgaSB3cm90ZSB0aGlzIGltcGxlbWVudC4gSXQg
Y29ycmVjdHMgc29tZSBidWdzIG9mDQo+ID4+Pj5tZW1vcnkgYmFycmllcnMgaW4ga2ZpZm8g
YW5kIGl0IGlzIHRoZSBzaW1wbGVyIGxvY2tsZXNzIHZlcnNpb24gb2YNCj4gPj4+PnJ0ZV9y
aW5nIGFzIGN1cnJlbnRseSBtdWx0aXBsZSBhY2Nlc3MgaXMgb25seSBhbGxvd2VkIGZvciBw
cm9kdWNlci4NCj4gPj4+DQo+ID4+PkNvdWxkIHlvdSBwcm92aWRlIHNvbWUgbW9yZSBpbmZv
cm1hdGlvbiBhYm91dCB0aGUga2ZpZm8gYnVnPyBBbnkNCj4gPj4+cG9pbnRlciB3b3VsZCBi
ZSBhcHByZWNpYXRlZC4NCj4gPj4+DQo+ID4+DQo+ID4+U3VyZSwgaSByZXBvcnRlZCBvbmUg
b2YgdGhlIG1lbW9yeSBiYXJyaWVyIGlzc3VlIHRvIGxpbnV4IGtlcm5lbDoNCj4gPj7CoMKg
IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzUvMTEvNTgNCj4gPj4NCj4gPj5BY3R1YWxs
eSwgYmVzaWRlIHRoYXQsIHRoZXJlIGlzIGFub3RoZXIgbWVtb3J5IGJhcnJpZXIgaXNzdWUg
aW4ga2ZpZm8sDQo+ID4+cGxlYXNlIGNvbnNpZGVyIHRoaXMgY2FzZToNCj4gPj4NCj4gPj7C
oMKgIGF0IHRoZSBiZWdpbm5pbmcNCj4gPj7CoMKgIHJpbmctPnNpemUgPSA0DQo+ID4+wqDC
oCByaW5nLT5vdXQgPSAwDQo+ID4+wqDCoCByaW5nLT5pbiA9IDQNCj4gPj4NCj4gPj7CoMKg
wqDCoCBDb25zdW1lcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBQcm9kdWNlcg0KPiA+PsKgLS0tLS0tLS0tLS0tLS0twqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtLS0tLS0tLS0tLS0tLQ0KPiA+PsKg
wqAgaW5kZXggPSByaW5nLT5vdXQ7IC8qIGluZGV4ID09IDAgKi8NCj4gPj7CoMKgIHJpbmct
Pm91dCsrOyAvKiByaW5nLT5vdXQgPT0gMSAqLw0KPiA+PsKgwqAgPCBSZS1PcmRlciA+DQo+
ID4+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBvdXQgPSByaW5nLT5vdXQ7DQo+ID4+wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAocmluZy0+aW4gLSBvdXQgPj0gcmluZy0+bWFzaykNCj4gPj7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FRlVMTDsNCj4gPj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IHNlZSB0aGUgcmluZyBpcyBub3QgZnVsbCAqLw0KPiA+PsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5k
ZXggPSByaW5nLT5pbiAmIHJpbmctPm1hc2s7IC8qIGluZGV4ID09IDAgKi8NCj4gPj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJpbmctPmRhdGFbaW5kZXhdID0gbmV3X2RhdGE7DQo+ID4+44CA44CA
44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA44CA
44CAcmluZy0+aW4rKzsNCj4gPj4NCj4gPj7CoMKgIGRhdGEgPSByaW5nLT5kYXRhW2luZGV4
XTsNCj4gPj7CoMKgICEhISEhISB0aGUgb2xkIGRhdGEgaXMgbG9zdCAhISEhISENCj4gPj4N
Cj4gPj5TbyB3ZSBuZWVkIHRvIG1ha2Ugc3VyZToNCj4gPj4xKSBmb3IgdGhlIGNvbnN1bWVy
LCB3ZSBzaG91bGQgcmVhZCB0aGUgcmluZy0+ZGF0YVtdIG91dCBiZWZvcmUgdXBkYXRpbmcg
cmluZy0+b3V0DQo+ID4+MikgZm9yIHRoZSBwcm9kdWNlciwgd2Ugc2hvdWxkIHJlYWQgcmlu
Zy0+b3V0IGJlZm9yZSB1cGRhdGluZyByaW5nLT5kYXRhW10NCj4gPj4NCj4gPj5hcyBmb2xs
b3dpbmdzOg0KPiA+PsKgwqDCoMKgwqAgUHJvZHVjZXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IENvbnN1bWVyDQo+ID4+wqAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PsKgwqDCoMKgwqAgUmVhZGluZyByaW5n
LT5vdXTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgUmVhZGluZyByaW5nLT5kYXRhW2luZGV4XQ0KPiA+PsKgwqDCoMKgwqAgc21wX21i
KCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc21wX21iKCkNCj4gPj7CoMKgwqDCoMKgIFNldHRpbmcg
cmluZy0+ZGF0YVtpbmRleF0gPSBkYXRhIHJpbmctPm91dCsrDQo+ID4+DQo+ID4+WyBpIHVz
ZWQgYXRvbWljX3N0b3JlX3JlbGVhc2UoKSBhbmQgYXRvbWljX2xvYWRfYWNxdWlyZSgpIGlu
c3RlYWQgb2Ygc21wX21iKCkgaW4gdGhlDQo+ID4+wqAgcGF0Y2guIF0NCj4gPj4NCj4gPj5C
dXQgaSBhbSBub3Qgc3VyZSBpZiB3ZSBjYW4gdXNlIHNtcF9hY3F1aXJlX19hZnRlcl9jdHJs
X2RlcCgpIGluIHRoZSBwcm9kdWNlcj8NCj4gPg0KPiA+DQo+ID5JIHdvbmRlciBpZiB0aGlz
IGNvdWxkIGJlIHNvbHZlZCBieSBzaW1wbHkgdHdlYWtpbmcgdGhlIGFib3ZlIGNvbnN1bWVy
IGltcGxlbWVudGF0aW9uOg0KPiA+DQo+ID5bMV0gaW5kZXggPSByaW5nLT5vdXQ7DQo+ID5b
Ml0gZGF0YSA9IHJpbmctPmRhdGFbaW5kZXhdOw0KPiA+WzNdIGluZGV4Kys7DQo+ID5bNF0g
cmluZy0+b3V0ID0gaW5kZXg7DQo+ID4NCj4gPk5vdyBbMl0gYW5kIFszXSBmb3JtcyBhIFdB
UiBkZXBlbmRlbmN5LCB3aGljaCBhdm9pZHMgdGhlIHJlb3JkZXJpbmcuDQo+IA0KPiBJdCBj
YW4gbm90LiBbMl0gYW5kIFs0XSBzdGlsbCBkbyBub3QgYW55IGRlcGVuZGVuY3ksIENQVSBh
bmQgY29tcGxhaW5lciBjYW4gb21pdA0KPiB0aGUgJ2luZGV4Jy4NCg0KT25lIHRoaW5nIHRv
IHRyeSB3b3VsZCBiZSB0aGUgTGludXgta2VybmVsIG1lbW9yeSBtb2RlbCB0b29scyBpbg0K
dG9vbHMvbWVtb3J5LW1vZGVsIGluIGN1cnJlbnQgbWFpbmxpbmUuICBUaGVyZSBpcyBhIFJF
QURNRSBmaWxlIGRlc2NyaWJpbmcNCmhvdyB0byBpbnN0YWxsIGFuZCBzZXQgaXQgdXAsIHdp
dGggYSBudW1iZXIgb2YgZmlsZXMgaW4gRG9jdW1lbnRhdGlvbg0KYW5kIGxpdG11cy10ZXN0
cyB0aGF0IGNhbiBoZWxwIGd1aWRlIHlvdS4NCg0KCQkJCQkJCVRoYW54LCBQYXVsDQoNCg==
