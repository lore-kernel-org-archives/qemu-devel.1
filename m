Received: from eggs.gnu.org ([2001:4830:134:3::10]:45961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.shi@intel.com>) id 1eu8KJ-0006Zp-8b
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.shi@intel.com>) id 1eu8KF-0007hO-Tg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:04:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:56739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.shi@intel.com>)
	id 1eu8KF-0007h5-J3
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 22:04:07 -0500
From: "Shi, Steven" <steven.shi@intel.com>
Date: Fri, 9 Mar 2018 03:03:51 +0000
Message-ID: <06C8AB66E78EE34A949939824ABE2B313B6613A0@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<06C8AB66E78EE34A949939824ABE2B313B651F39@shsmsx102.ccr.corp.intel.com>
	<CAJ+F1CKuHzO-F3XbjqQyLL49JipsR+Sk8zFy1ZuMssUz_71qvA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKuHzO-F3XbjqQyLL49JipsR+Sk8zFy1ZuMssUz_71qvA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 0/8] RFC: ovmf: preliminary TPM2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "lersek@redhat.com" <lersek@redhat.com>, "pjones@redhat.com" <pjones@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

SGkgTWFyY2FuZHJlLA0KVGhhbmtzIGZvciB5b3VyIGNvbW1hbmQgc3RlcHMgYW5kIEkgdHJpZWQg
dGhlbSwgYnV0IG15IHFlbXUgZmFpbGVkIHRvIGNvbm5lY3QgdGhlIHNvY2tldCB0cG1lbXUuc29j
ay4gV2hlbiBJIGFkZGVkIHRoZSBjb250cm9sIGNoYW5uZWwgdG8gdGhlIFRQTSwgdGhlIHN3dHBt
IHNvY2tldCBjb21tYW5kIHN0dWNrIHRoZXJlIGFuZCBuZXZlciBleGl0LiBOb3Qgc3VyZSB3aGV0
aGVyIGl0IHdhcyBzdWNjZXNzZnVsLiANCkJlbG93IGFyZSB0aGUgY29tbWFuZCBzdGVwcyBydW5u
aW5nIG91dHB1dCBpbiBteSBzaWRlDQoNCj4gVGhlbiB5b3UgY2FuIHJ1bjoNCj4gbWtkaXIgdHBt
c3RhdGVkaXINCj4gc3d0cG1fc2V0dXAuc2ggLS10cG0yIC0tdHBtLXN0YXRlIHRwbXN0YXRlZGly
DQokIHN3dHBtX3NldHVwLnNoIC0tdHBtMiAtLXRwbS1zdGF0ZSB0cG1zdGF0ZWRpcg0KU3RhcnRp
bmcgdlRQTSBtYW51ZmFjdHVyaW5nIGFzIGpzaGkxOTpqc2hpMTkgQCAyMDE45bm0MDPmnIgwOeaX
pSDmmJ/mnJ/kupQgMTDml7YyOOWIhjM556eSDQpUUE0gaXMgbGlzdGVuaW5nIG9uIFRDUCBwb3J0
IDQ3MzY0Lg0KU3VjY2Vzc2Z1bGx5IGF1dGhvcmVkIFRQTSBzdGF0ZS4NCkVuZGluZyB2VFBNIG1h
bnVmYWN0dXJpbmcgQCAyMDE45bm0MDPmnIgwOeaXpSDmmJ/mnJ/kupQgMTDml7YyOOWIhjM556eS
DQoNCj4gUnVuIHRoZSBlbXVsYXRvcjoNCj4gc3d0cG0gc29ja2V0IC0tdHBtc3RhdGUgZGlyPXRw
bXN0YXRlZGlyIC0tY3RybCB0eXBlPXVuaXhpbyxwYXRoPXRwbWVtdS5zb2NrICAtLXRwbTINCiQg
c3d0cG0gc29ja2V0IC0tdHBtc3RhdGUgZGlyPXRwbXN0YXRlZGlyIC0tY3RybCB0eXBlPXVuaXhp
byxwYXRoPXRwbWVtdS5zb2NrIC0tdHBtMg0KKHRoZSBzd3RwbSBzb2NrZXQgY29tbWFuZCBzdHVj
ayB0aGVyZSBhbmQgbmV2ZXIgZXhpdCkNCg0KPiBSdW4gcWVtdSAoZnJvbSBnaXQpIHdpdGggb3Zt
ZiAod2l0aCB0aGlzIHNlcmllcyk6DQo+IHFlbXUgLi4uIC1jaGFyZGV2IHNvY2tldCxpZD1jaHJ0
cG0scGF0aD10cG1lbXUuc29jayAtdHBtZGV2DQo+IGVtdWxhdG9yLGlkPXRwbTAsY2hhcmRldj1j
aHJ0cG0gIC1kZXZpY2UgdHBtLWNyYix0cG1kZXY9dHBtMA0KPiAtZHJpdmUgaWY9cGZsYXNoLGZv
cm1hdD1yYXcsZmlsZT1PVk1GX0NPREUuZmQscmVhZG9ubHkgLWRyaXZlDQo+IGlmPXBmbGFzaCxm
b3JtYXQ9cmF3LGZpbGU9T1ZNRl9WQVJTLmZkIC4uDQokIHFlbXUtc3lzdGVtLXg4Nl82NCAgLXNl
cmlhbCBmaWxlOnNlcmlhbC5sb2cgLW0gNTEyMCAtaGRhIGZhdDouIC1tb25pdG9yIHN0ZGlvIC0t
ZW5hYmxlLWt2bSAtc21wIDQgLWJpb3MgLi4vT3ZtZjMyNjQvTk9PUFRfR0NDNS9GVi9PVk1GLmZk
IC1jaGFyZGV2IHNvY2tldCxpZD1jaHJ0cG0scGF0aD10cG1lbXUuc29jayAtdHBtZGV2IGVtdWxh
dG9yLGlkPXRwbTAsY2hhcmRldj1jaHJ0cG0gIC1kZXZpY2UgdHBtLWNyYix0cG1kZXY9dHBtMA0K
cWVtdS1zeXN0ZW0teDg2XzY0OiAtY2hhcmRldiBzb2NrZXQsaWQ9Y2hydHBtLHBhdGg9dHBtZW11
LnNvY2s6IEZhaWxlZCB0byBjb25uZWN0IHNvY2tldCB0cG1lbXUuc29jazogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQ0KDQpJIHVzZSB0aGUgbGF0ZXN0IHZlcnNpb24gcWVtdSBhcyBiZWxvdzoN
CiQgcWVtdS1zeXN0ZW0teDg2XzY0IC0tdmVyc2lvbg0KUUVNVSBlbXVsYXRvciB2ZXJzaW9uIDIu
MTEuNTAgKHYyLjEwLjAtNDE4NC1nOTMwYjAxMTM4Yi1kaXJ0eSkNCkNvcHlyaWdodCAoYykgMjAw
My0yMDE3IEZhYnJpY2UgQmVsbGFyZCBhbmQgdGhlIFFFTVUgUHJvamVjdCBkZXZlbG9wZXJzDQoN
ClRoYW5rcw0KU3RldmVuIFNoaQ0KDQo=
