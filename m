Received: from eggs.gnu.org ([2001:4830:134:3::10]:55599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dcj0y-0008JL-Qf
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dcj0u-0000Og-QE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:04:00 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38577)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dcj0t-0000Hf-TN
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:03:56 -0400
Date: Wed, 2 Aug 2017 10:03:39 +0800 (CST)
Message-ID: <201708021003393261961@zte.com.cn>
References: 201707250902596770211@zte.com.cn,20170801145224.GD3206@lemon.lan
Mime-Version: 1.0
From: <wang.yong155@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCHv2_02/04=5D_colo-compare=3A_Proce?=
 =?utf-8?q?sspactkets_inthe_IOThreadofthe_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, famz@redhat.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, wang.guang55@zte.com.cn, jasowang@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, marcandre.lureau@gmail.com, stefanha@redhat.com, zhang.zhanghailiang@huawei.com

Pk9uIFR1ZSwgMDgvMDEgMTI6MjUsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQoNCj4+IE9uIDI4LzA3
LzIwMTcgMDI6MjUsIEZhbSBaaGVuZyB3cm90ZToNCg0KPj4gPiBPbiBUaHUsIDA3LzI3IDE1OjQ3
LCBaaGFuZyBDaGVuIHdyb3RlOg0KDQo+PiA+PiBDQy4gRmFtIGFuZCBEYXZpZC4NCg0KPj4gPj4N
Cg0KPj4gPj4gQW55IGlkZWEgYWJvdXQgaXQ/DQoNCj4+ID4gDQoNCj4+ID4gSXMgaXQgcG9zc2li
bGUgdG8gdXNlIGdfbWFpbl9jb250ZXh0X3twdXNoLHBvcH1fdGhyZWFkX2RlZmF1bHQgdG8gIm1v
dmUiIGNoYXJkZXYNCg0KPj4gPiBHU291cmNlcyB0byBJT1RocmVhZCdzIGNvbnRleHQsIHRoZW4g
dXNlIGdfbWFpbl9jb250ZXh0X3F1ZXJ5IGxpa2UgbWFpbiB0aHJlYWQNCg0KPj4gPiBhbmQgcG9s
bCB0aGUgZmRzIGluIGFpb19wb2xsPw0KDQo+PiANCg0KPj4gSG93IHdvdWxkIHlvdSBkbyB0aGF0
IHdpdGhvdXQgbWFraW5nIGFpb19wb2xsIHBlcmZvcm1hbmNlIHdvcnNlIGZvcg0KDQo+PiBldmVy
eW9uZT8NCg0KPg0KDQo+SSBkb24ndCBrbm9lLiBNYWludGFpbiBhIGZsYWcgYW5kIG9ubHkgZG8g
dGhlc2Ugc2xvdyBzdHVmZiBhZnRlciBhdCBsZWFzdCBvbmUNCg0KPkdTb3VyY2UgaGFzIGJlZW4g
bW92ZWQgYXJvdW5kPw0KDQoNCg0KDQpIb3cgYWJvdXQgdGhpcywgd2hlbiBJb3RocmVhZCdzIEdN
YWluQ29udGV4dCBpcyBOVUxMLCB1c2UgaW9fcG9sbCwgb3IgZWxzZSB1c2UgZ19tYWluX2NvbnRl
eHRfKiBwb2xsIHRoZSBmZHMgPw0KDQoNCg0KDQpJb3RocmVhZCdzIEdNYWluQ29udGV4dCBpcyBO
VUxMIGJ5IGRlZmF1bHQsc28gdXNlIGFpb19wb2xsIGluIGlvdGhyZWFkX3J1biBmdW5jdGlvbi4N
Cg0KSW4gYWRkaXRpb24gd2UgY2FuIGNyZWF0ZSBhIG5ldyBHTWFpbkNvbnRleHQgaW4gY2hhcmRl
dix1c2UgZ19tYWluX2NvbnRleHRfKiBpbiBpb3RocmVhZF9ydW4uDQoNCk1heWJlIHRoaXMgZG9l
c24ndCBhZmZlY3QgcGVyZm9ybWFuY2UgPw0KDQoNCg0KDQpUaGFua3MNCg0KV2FuZ1lvbmcNCg0K
DQoNCg0KDQoNCg0KDQoNCg0KDQoNCuWOn+Wni+mCruS7tg0KDQoNCg0K5Y+R5Lu25Lq677yaIDxm
YW16QHJlZGhhdC5jb20+DQrmlLbku7bkurrvvJogPHBib256aW5pQHJlZGhhdC5jb20+DQrmioTp
gIHkurrvvJogPHpoYW5nY2hlbi5mbnN0QGNuLmZ1aml0c3UuY29tPueOi+WLhzEwMTcwNTMwIDxs
aXpoaWppYW5AY24uZnVqaXRzdS5jb20+546L5bm/MTAxNjU5OTIgPGphc293YW5nQHJlZGhhdC5j
b20+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+IDxkZ2lsYmVydEByZWRoYXQuY29tPiA8bWFyY2Fu
ZHJlLmx1cmVhdUBnbWFpbC5jb20+IDxzdGVmYW5oYUByZWRoYXQuY29tPiA8emhhbmcuemhhbmdo
YWlsaWFuZ0BodWF3ZWkuY29tPg0K5pelIOacnyDvvJoyMDE35bm0MDjmnIgwMeaXpSAyMjo1Mg0K
5Li7IOmimCDvvJpSZTogW1FlbXUtZGV2ZWxdIFtQQVRDSHYyIDAyLzA0XSBjb2xvLWNvbXBhcmU6
IFByb2Nlc3NwYWN0a2V0cyBpbnRoZSBJT1RocmVhZG9mdGhlIHByaW1hcnkNCg0KDQoNCg0KDQpP
biBUdWUsIDA4LzAxIDEyOjI1LCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPiBPbiAyOC8wNy8yMDE3
IDAyOjI1LCBGYW0gWmhlbmcgd3JvdGU6DQo+ID4gT24gVGh1LCAwNy8yNyAxNTo0NywgWmhhbmcg
Q2hlbiB3cm90ZToNCj4gPj4gQ0MuIEZhbSBhbmQgRGF2aWQuDQo+ID4+DQo+ID4+IEFueSBpZGVh
IGFib3V0IGl0Pw0KPiA+IA0KPiA+IElzIGl0IHBvc3NpYmxlIHRvIHVzZSBnX21haW5fY29udGV4
dF97cHVzaCxwb3B9X3RocmVhZF9kZWZhdWx0IHRvICJtb3ZlIiBjaGFyZGV2DQo+ID4gR1NvdXJj
ZXMgdG8gSU9UaHJlYWQncyBjb250ZXh0LCB0aGVuIHVzZSBnX21haW5fY29udGV4dF9xdWVyeSBs
aWtlIG1haW4gdGhyZWFkDQo+ID4gYW5kIHBvbGwgdGhlIGZkcyBpbiBhaW9fcG9sbD8NCj4gDQo+
IEhvdyB3b3VsZCB5b3UgZG8gdGhhdCB3aXRob3V0IG1ha2luZyBhaW9fcG9sbCBwZXJmb3JtYW5j
ZSB3b3JzZSBmb3INCj4gZXZlcnlvbmU/DQoNCkkgZG9uJ3Qga25vZS4gTWFpbnRhaW4gYSBmbGFn
IGFuZCBvbmx5IGRvIHRoZXNlIHNsb3cgc3R1ZmYgYWZ0ZXIgYXQgbGVhc3Qgb25lDQpHU291cmNl
IGhhcyBiZWVuIG1vdmVkIGFyb3VuZD8NCg0KRmFt
