Received: from eggs.gnu.org ([2001:4830:134:3::10]:57891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fveK7-000121-EC
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fveK4-0006RL-3V
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:58:31 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:34728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fveK3-0006MO-Nr
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:58:28 -0400
Date: Fri, 31 Aug 2018 15:58:12 +0800 (CST)
Message-ID: <201808311558126719067@zte.com.cn>
Mime-Version: 1.0
From: <peng.hao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_V5_2/4=5D_target-i386=3Aadd_coal?=
 =?utf-8?q?esced=5Fpio_API?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

Pj4gK3N0YXRpYyB2b2lkIGt2bV9jb2FsZXNjZV9waW9fYWRkKE1lbW9yeUxpc3RlbmVyICpsaXN0
ZW5lciwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9uU2Vj
dGlvbiAqc2VjdGlvbiwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
IHN0YXJ0LCBod2FkZHIgc2l6ZSkKPj4gK3sKPj4gKyAgICBLVk1TdGF0ZSAqcyA9IGt2bV9zdGF0
ZTsKPj4gKwo+PiArICAgIGlmIChzLT5jb2FsZXNjZWRfcGlvKSB7Cj4+ICsgICAgICAgIHN0cnVj
dCBrdm1fY29hbGVzY2VkX21taW9fem9uZSB6b25lOwo+PiArCj4+ICsgICAgICAgIHpvbmUuYWRk
ciA9IHN0YXJ0Owo+PiArICAgICAgICB6b25lLnNpemUgPSBzaXplOwo+PiArICAgICAgICB6b25l
LnBpbyA9IDE7Cj4+ICsKPj4gKyAgICAgICAgKHZvaWQpa3ZtX3ZtX2lvY3RsKHMsIEtWTV9SRUdJ
U1RFUl9DT0FMRVNDRURfTU1JTywgJnpvbmUpOwo+PiArICAgIH0KPj4gK30KPj4gKwo+PiArc3Rh
dGljIHZvaWQga3ZtX2NvYWxlc2NlX3Bpb19kZWwoTWVtb3J5TGlzdGVuZXIgKmxpc3RlbmVyLAo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNZW1vcnlSZWdpb25TZWN0aW9uICpz
ZWN0aW9uLAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgc3RhcnQs
IGh3YWRkciBzaXplKQo+PiArewo+PiArICAgIEtWTVN0YXRlICpzID0ga3ZtX3N0YXRlOwo+PiAr
Cj4+ICsgICAgaWYgKHMtPmNvYWxlc2NlZF9waW8pIHsKPj4gKyAgICAgICAgc3RydWN0IGt2bV9j
b2FsZXNjZWRfbW1pb196b25lIHpvbmU7Cj4+ICsKPj4gKyAgICAgICAgem9uZS5hZGRyID0gc3Rh
cnQ7Cj4+ICsgICAgICAgIHpvbmUuc2l6ZSA9IHNpemU7Cj4+ICsgICAgICAgIHpvbmUucGlvID0g
MTsKPj4gKwo+PiArICAgICAgICAodm9pZClrdm1fdm1faW9jdGwocywgS1ZNX1VOUkVHSVNURVJf
Q09BTEVTQ0VEX01NSU8sICZ6b25lKTsKPj4gKyAgICAgfQo+PiArfQo+YXNzZXJ0IHJhdGhlciB0
aGFuICh2b2lkKT8KSSB0aGluayAodm9pZCkgaXMgYmV0dGVyLiAgcWVtdSBjYW4gd29yayB3ZWxs
IGV2ZW4gaWYgY29hbGVzY2VkIG1taW8vcGlvIHJlZ2lzZXIgb3BlcmF0aW9uIGZhaWxlZC4=
