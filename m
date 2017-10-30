Received: from eggs.gnu.org ([2001:4830:134:3::10]:50084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.hatayama@jp.fujitsu.com>) id 1e97ut-0002Yg-Ub
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.hatayama@jp.fujitsu.com>) id 1e97uo-0000j8-1z
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:07:39 -0400
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:44875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.hatayama@jp.fujitsu.com>)
	id 1e97un-0000bh-HU
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 07:07:33 -0400
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
	(g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
	by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 54FBCAC009E
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 20:07:22 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Date: Mon, 30 Oct 2017 11:07:20 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B120583@G01JPEXMBYT03>
Content-Language: ja-JP
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 5/5] RFC: fw_cfg: add DMA write
 operation in sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'marcandre.lureau@redhat.com'" <marcandre.lureau@redhat.com>
Cc: "'somlo@cmu.edu'" <somlo@cmu.edu>, "'mst@redhat.com'" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

PiBGcm9tOiBNYXJjLUFuZHKopiBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbT4NCj4NCj4gU2luY2UgcWVtdSAyLjksIERNQSB3cml0ZSBv
cGVyYXRpb25zIGFyZSBhbGxvd2VkLiBIb3dldmVyLCB1c2FnZSBvZiB0aGlz
DQo+IGludGVyZmFjZSBmcm9tIGtlcm5lbCBvciB1c2VyLXNwYWNlIGlzIHN0
cm9uZ2x5IGRpc2NvdXJhZ2VkIGJ5IHRoZQ0KPiBtYWludGFpbmVycy4gVGhp
cyBwYXRjaCBpcyBtZWFudCBmb3IgZXhwZXJpbWVudGF0aW9ucyBmb3Igbm93
Lg0KPg0KDQpDb3VsZCB5b3UgKG9yIG1haW50YWluZXJzPykgdGVsbCBtZSBo
b3cgZXhwZXJpbWVudGFsIHRoZSBETUEgd3JpdGUNCm9wZXJhdGlvbnMgZnJv
bSBrZXJuZWwgYXJlPw0KDQpGcm9tIHNvbWUgdGVjaG5pY2FsIHJlYXNvbj8N
Ck9yIHNpbXBseSB0aGVyZSBoYXMgbm90IGJlZW4gZW5vdWdoIHRlc3QgeWV0
IHNvIGZhcj8NCg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjLUFuZHKopiBMdXJl
YXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2Zpcm13YXJlL3FlbXVfZndfY2ZnLmMgfCAyMSArKysrKysrKysr
KysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Zpcm13YXJlL3FlbXVfZndfY2ZnLmMgYi9kcml2ZXJzL2Zpcm13YXJlL3Fl
bXVfZndfY2ZnLmMNCj4gaW5kZXggNTRiNTY5ZGEzMjU3Li5lMmYyYWQxYzlj
MGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvcWVtdV9md19j
ZmcuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3FlbXVfZndfY2ZnLmMN
Cj4gQEAgLTUyNCw5ICs1MjQsMjggQEAgc3RhdGljIHNzaXplX3QgZndfY2Zn
X3N5c2ZzX3JlYWRfcmF3KHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qga29i
amVjdCAqa29iaiwNCj4gICAgICAgcmV0dXJuIGZ3X2NmZ19yZWFkX2Jsb2Io
ZW50cnktPmYuc2VsZWN0LCBidWYsIHBvcywgY291bnQsIHRydWUpOw0KPiAg
fQ0KPg0KPiArc3RhdGljIHNzaXplX3QgZndfY2ZnX3N5c2ZzX3dyaXRlX3Jh
dyhzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IGtvYmplY3QgKmtvYmosDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBi
aW5fYXR0cmlidXRlICpiaW5fYXR0ciwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY2hhciAqYnVmLCBsb2ZmX3QgcG9zLCBzaXpl
X3QgY291bnQpDQo+ICt7DQo+ICsgICAgIHN0cnVjdCBmd19jZmdfc3lzZnNf
ZW50cnkgKmVudHJ5ID0gdG9fZW50cnkoa29iaik7DQo+ICsNCj4gKyAgICAg
aWYgKCFmd19jZmdfZG1hX2VuYWJsZWQoKSkNCj4gKyAgICAgICAgICAgICBy
ZXR1cm4gLUVOT1RTVVBQOw0KPiArDQo+ICsgICAgIGlmIChwb3MgPiBlbnRy
eS0+Zi5zaXplKQ0KPiArICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0K
PiArDQo+ICsgICAgIGlmIChjb3VudCA+IGVudHJ5LT5mLnNpemUgLSBwb3Mp
DQo+ICsgICAgICAgICAgICAgY291bnQgPSBlbnRyeS0+Zi5zaXplIC0gcG9z
Ow0KPiArDQo+ICsgICAgIHJldHVybiBmd19jZmdfd3JpdGVfYmxvYihlbnRy
eS0+Zi5zZWxlY3QsIGJ1ZiwgcG9zLCBjb3VudCk7DQo+ICt9DQo+ICsNCj4g
IHN0YXRpYyBzdHJ1Y3QgYmluX2F0dHJpYnV0ZSBmd19jZmdfc3lzZnNfYXR0
cl9yYXcgPSB7DQo+IC0gICAgIC5hdHRyID0geyAubmFtZSA9ICJyYXciLCAu
bW9kZSA9IFNfSVJVU1IgfSwNCj4gKyAgICAgLmF0dHIgPSB7IC5uYW1lID0g
InJhdyIsIC5tb2RlID0gU19JUlVTUiB8IFNfSVdVU1IgfSwNCj4gICAgICAg
LnJlYWQgPSBmd19jZmdfc3lzZnNfcmVhZF9yYXcsDQo+ICsgICAgIC53cml0
ZSA9IGZ3X2NmZ19zeXNmc193cml0ZV9yYXcsDQo+ICB9Ow0KPg0KPiAgLyoN
Cj4gLS0NCj4gMi4xNC4xLjE0Ni5nZDM1ZmFhODE5DQoNClRoYW5rcy4NCkhB
VEFZQU1BLCBEYWlzdWtlDQoNCg==
