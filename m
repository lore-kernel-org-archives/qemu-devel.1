Received: from eggs.gnu.org ([2001:4830:134:3::10]:33253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1dtxOq-0005o6-4a
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xin.zeng@intel.com>) id 1dtxOm-0003X8-UQ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:51:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:4835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xin.zeng@intel.com>) id 1dtxOm-0003VV-Iw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:51:48 -0400
From: "Zeng, Xin" <xin.zeng@intel.com>
Date: Mon, 18 Sep 2017 14:51:33 +0000
Message-ID: <82063967A54EF84C8AFCD6BD7F6AD93310E1111B@SHSMSX103.ccr.corp.intel.com>
References: <1505092362-10544-1-git-send-email-longpeng2@huawei.com>
	<1505092362-10544-2-git-send-email-longpeng2@huawei.com>
	<67d5549e-84de-ee85-00a7-37edc52234c4@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3D9A7B@DGGEMA505-MBX.china.huawei.com>
	<73b9f2a8-6746-593b-4277-3ea757476130@linux.vnet.ibm.com>
	<33183CC9F5247A488A2544077AF19020DA3D9B61@DGGEMA505-MBX.china.huawei.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA3D9B61@DGGEMA505-MBX.china.huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH REPOST v19 1/2] virtio-crypto: Add virtio
 crypto device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Griffin,
	John" <john.griffin@intel.com>, "Varun.Sethi@freescale.com" <Varun.Sethi@freescale.com>, "denglingli@chinamobile.com" <denglingli@chinamobile.com>, "arei.gonglei@hotmail.com" <arei.gonglei@hotmail.com>, "agraf@suse.de" <agraf@suse.de>, "vincent.jardin@6wind.com" <vincent.jardin@6wind.com>, "Ola.Liljedahl@arm.com" <Ola.Liljedahl@arm.com>, Luonengjun <luonengjun@huawei.com>, "Ma, Liang J" <liang.j.ma@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Jani Kokkonen <Jani.Kokkonen@huawei.com>, "Keating,
	Brian A" <brian.a.keating@intel.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "mike.caraman@nxp.com" <mike.caraman@nxp.com>

T24gTW9uZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMTcgOToyNCBQTSwgR29uZ2xlaSAoQXJlaSkgd3Jv
dGU6DQoNCjwgPiBPbiAwOS8xOC8yMDE3IDAyOjEzIFBNLCBHb25nbGVpIChBcmVpKSB3cm90ZToN
CjwgPiA+PiBEZXN0cm95IGRvZXMgbm90IG5lZWQgdG8gc3BlY2lmeSBxdWV1ZV9pZC4gVGhhdCBt
ZWFucyBzZXNzaW9uX2lkJ3MgYXJlbid0DQo8ID4gPj4gcXVldWUgc2NvcGVkIGZyb20gbmFtZXNw
YWNlIHBlcnNwZWN0aXZlLiBUaGUgcXVlc3Rpb24gcmVtYWlucyB3aGF0IGlzDQo8ID4gPj4gcXVl
dWVfaWQgZ29vZCBmb3IsIGFuZCB3aGV0aGVyIGEgc2Vzc2lvbiB0eXBlIG9wIHJlcXVlc3Qgc2hv
dWxkIGJlDQo8ID4gPj4gcmVqZWN0ZWQgaWYgdGhlIHRoZSBzZXNzaW9uIGlkIG9yaWdpbmF0ZXMg
ZnJvbSBhIHNlc3Npb24gY3JlYXRpb24NCjwgPiA+PiByZXF1ZXN0IHNwZWNpZnlpbmcgYSBkaWZm
ZXJlbnQgZGF0YXF1ZXVlIChub3QgdGhlIGRhdGFxdWV1ZSBjb250YWluaW5nDQo8ID4gPj4gdGhl
IGdpdmVuIHJlcXVlc3QpPw0KPCA+ID4+DQo8ID4gPiBNeSBvcmlnaW5hbCBpZGVhIGFib3V0IHRo
ZSBxdWV1ZV9pZCBpcyB1c2luZyB0aGUgcXVldWVfaWQgdG8gc3BlY2lmeSB3aGljaA0KPCA+ID4g
ZGF0ZXF1ZXVlIG9mIHRoZSBmb2xsb3dpbmcgZGF0YSByZXF1ZXN0cyB3aWxsIGJlIHVzZWQuIEJ1
dCBhZnRlciBkZWVwDQo8ID4gdGhpbmtpbmcsDQo8ID4gPiBJIGZpbmQgdGhhdCB0aGUgcXVldWVf
aWQgaXMgc3VwZXJmbHVvdXMsIGFuZCB0aGUgY3VycmVudCBjb2RlIGluIFFFTVUgYWxzbw0KPCA+
ID4gZG9uJ3QgdXNlIHRoZSBxdWV1ZV9pZCB2YWx1ZSBhcyB3ZWxsLiBUaGF0J3MgYmVjYXVzZSB0
aGUgd2UgY2FuIHVzZQ0KPCA+IHNlc3Npb25faWQNCjwgPiA+IHRvIGZpbmQgdGhlIHBlcnZpb3Vz
IHNlc3Npb24gaW5mb3JtYXRpb24gYW5kIGdldCB0aGUgY3VycmVudCBkYXRhcXVldWUgaWQNCjwg
PiA+IGZyb20gdGhlIHVzZWQgdmlydHF1ZXVlIC4NCjwgPiA+DQo8ID4gPiBTbyBtYXliZSB3ZSBz
aG91bGQgZHJvcCB0aGUgcXVldWVfaWQgdGhpcyB0aW1lLg0KPCA+ID4NCjwgPiA+DQo8ID4NCjwg
PiBTb3VuZHMgcmVhc29uYWJsZSB0byBtZS4gV2UgY2FuIG1ha2UgaXQgcmVzZXJ2ZWQgYW5kIGln
bm9yZWQgaW4NCjwgPiB0aGUgc3BlY2lmaWNhdGlvbi4gTGludXggdXNlcyBpdCwgYnV0IGl0J3Mg
YWx3YXlzIHNldCB0byAwIGFzIHdlIG9ubHkNCjwgPiBzdXBwb3J0IG9uZSBkYXRhLXF1ZXVlIChp
ZiBJJ20gbm90IHdyb25nKS4gU28gcmVzZXJ2ZWQgYW5kIG11c3QgYmUgemVybw0KPCA+IGlzIGFu
IG9wdGlvbiB0b28uDQo8ID4NCjwgTWFrZXMgc2Vuc2UgdG8ga2VlcGluZyBjb21wYXRpYmlsaXR5
Lg0KPCANCg0KSWYgd2UgYWx3YXlzIHNldCBpdCB0byAwLCBhbmQgYmFja2VuZCBkZXZpY2UgZG9l
c24ndCBzcGVjaWZ5IHRoZSBxdWV1ZQ0KaWQgd2hlbiBjcmVhdGluZyBzZXNzaW9uLCB0aGlzIHdv
cmtzIG9ubHkgd2hlbiBvbmUgZGF0YSBxdWV1ZSBpcw0Kc3VwcG9ydGVkLiBCdXQgaWYgd2Ugd2Fu
dCB0byBzdXBwb3J0IG11bHRpIGRhdGEgcXVldWVzLA0KaG93IGRvZXMgZnJvbnRlbmQgZHJpdmVy
IGtub3cgd2hpY2ggcXVldWUgaXQgc2hvdWxkIHVzZSB3aGVuIA0Kc2VuZGluZyByZXF1ZXN0cyB0
byB0aGUgdmlydCBxdWV1ZT8gQW5kIGZ1cnRoZXJtb3JlLCBpZiB0aGUgZGF0YSBxdWV1ZSANCmlk
IHdoaWNoIGNhbiBiZSB1c2VkIGlzIGRldGVybWluZWQgYnkgYmFja2VuZCBkZXZpY2UsIGhvdyBk
b2VzIA0KZ3Vlc3QgZnJvbnRlbmQgZHJpdmVyIGtub3cgd2hpY2ggcXVldWUgY2FuIGJlIHVzZWQg
d2hlbiBvcGVyYXRpbmcNCmluIHN0YXRlbGVzcyBtb2RlIGluIGNhc2UgbXVsdGkgZGF0YSBxdWV1
ZSBpcyBzdXBwb3J0ZWQ/DQpTbyBmcm9tIG15IHBvaW50IG9mIHZpZXcsIHNlc3Npb24gc2hvdWxk
IG9ubHkgYmUgYXNzb2NpYXRlZCB3aXRoIHNlcnZpY2UNCnJlbGF0ZWQgaW5mb3JtYXRpb24sIGJ1
dCBub3QgYXNzb2NpYXRlZCB3aXRoIHRoZSB0cmFuc3BvcnQgbGF5ZXIgaW5mb3JtYXRpb24sDQpp
LmUuIGRhdGEgcXVldWUgaWQgaW4gdGhpcyBjYXNlLiBUaGUgZGF0YSBxdWV1ZSB0byBiZSB1c2Vk
IHNob3VsZCBiZSBjaG9zZW4gYnkNCmZyb250ZW5kIGRyaXZlci4gRnJvbnRlbmQgZHJpdmVyIGNh
biB1c2UgYW55IHZhbGlkIGRhdGEgcXVldWUgdG8gc2VuZCByZXF1ZXN0cw0KdG8gYmFja2VuZCBk
ZXZpY2UsIGJhY2tlbmQgZGV2aWNlIG5lZWQgdG8gZXh0cmFjdCB0aGUgc2Vzc2lvbiBpbmZvcm1h
dGlvbg0KZnJvbSB0aGUgcmVxdWVzdCBwYWNrZXQgYW5kIHJldHJpZXZlIHRoZSByZXF1ZXN0J3Mg
c2Vzc2lvbiBpbmZvIHRoZW4gaGFuZGxlIGl0IA0KY29ycmVzcG9uZGluZ2x5Lg0KDQo8IFRoYW5r
cywNCjwgLUdvbmdsZWkNCg==
