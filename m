Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC51EC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EE820732
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 09:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EE820732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVXSe-0005e3-S0
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 04:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iVXRN-0004zN-17
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iVXRI-000709-Uo
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:58:52 -0500
Resent-Date: Fri, 15 Nov 2019 03:58:52 -0500
Resent-Message-Id: <E1iVXRI-000709-Uo@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iVXRH-0006xR-3W
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 03:58:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573808296; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JIAALjWzVcyWGzLZrhQgyQZewpjOD5ERkeGI12F6fE6ZEAQCcGWimQhre9/4UaGLj0UtYWbkSLq3DRyLYBp8FncTsW4hYD7cC5GSZcoWMyIDAGxwphQ/iddIm/kJp60Xec1/WHWQvUUqshhFjGqUv8eZmq9hUjeEtnhJ1I/wLMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573808296;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xZIDz9YSM5WoqrFQ/O8cdVowenHQmY5ca8czfoE33KA=; 
 b=KUca/X23DJ3Rw9lnF40v6RXUP+JL9e1JlOInOTZTwJRS3yoLzm5ib0+MK0sxTgWPeuUd/6ACQG5s9gj2UbL0j5Eq7FlsKWQWgR3admEWbNV6wH48ORl4r9R0j2KbYjW7bsM3OZQNHyrTQ7/iv0p5Pq1upgWb/afBR2KpdHEfbE8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573808295905917.1993311280779;
 Fri, 15 Nov 2019 00:58:15 -0800 (PST)
In-Reply-To: <20191115075352.17734-1-tao3.xu@intel.com>
Subject: Re: [PATCH v16 00/14] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <157380829404.4715.555837369756675966@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Fri, 15 Nov 2019 00:58:15 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, tao3.xu@intel.com,
 fan.du@intel.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com,
 jonathan.cameron@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExNTA3NTM1Mi4xNzcz
NC0xLXRhbzMueHVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjE2IDAwLzE0XSBCdWlsZCBBQ1BJIEhldGVyb2dl
bmVvdXMgTWVtb3J5IEF0dHJpYnV0ZSBUYWJsZSAoSE1BVCkKVHlwZTogc2VyaWVzCk1lc3NhZ2Ut
aWQ6IDIwMTkxMTE1MDc1MzUyLjE3NzM0LTEtdGFvMy54dUBpbnRlbC5jb20KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxOTExMTUwODMzNDUuMjI2Mzgt
MS10YW8zLnh1QGludGVsLmNvbSAtPiBwYXRjaGV3LzIwMTkxMTE1MDgzMzQ1LjIyNjM4LTEtdGFv
My54dUBpbnRlbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkNWRhMjBjIHRl
c3RzL2Jpb3MtdGFibGVzLXRlc3Q6IGFkZCB0ZXN0IGNhc2VzIGZvciBBQ1BJIEhNQVQKNDg2MTg1
ZCB0ZXN0cy9udW1hOiBBZGQgY2FzZSBmb3IgUU1QIGJ1aWxkIEhNQVQKZWIzMjk0NiBobWF0IGFj
cGk6IEJ1aWxkIE1lbW9yeSBTaWRlIENhY2hlIEluZm9ybWF0aW9uIFN0cnVjdHVyZShzKQplNDk3
ZmU3IGhtYXQgYWNwaTogQnVpbGQgU3lzdGVtIExvY2FsaXR5IExhdGVuY3kgYW5kIEJhbmR3aWR0
aCBJbmZvcm1hdGlvbiBTdHJ1Y3R1cmUocykKMjU1NDg3YSBobWF0IGFjcGk6IEJ1aWxkIE1lbW9y
eSBQcm94aW1pdHkgRG9tYWluIEF0dHJpYnV0ZXMgU3RydWN0dXJlKHMpCjNhZjBjMGIgbnVtYTog
RXh0ZW5kIENMSSB0byBwcm92aWRlIG1lbW9yeSBzaWRlIGNhY2hlIGluZm9ybWF0aW9uCjU2ZDFj
ODAgbnVtYTogRXh0ZW5kIENMSSB0byBwcm92aWRlIG1lbW9yeSBsYXRlbmN5IGFuZCBiYW5kd2lk
dGggaW5mb3JtYXRpb24KYjYwN2I4NCBudW1hOiBFeHRlbmQgQ0xJIHRvIHByb3ZpZGUgaW5pdGlh
dG9yIGluZm9ybWF0aW9uIGZvciBudW1hIG5vZGVzCjE4NGRkNjIgdGVzdHM6IEFkZCB0ZXN0IGZv
ciBRQVBJIGJ1aWx0aW4gdHlwZSB0aW1lCmI3ZjFiMmMgcWFwaTogQWRkIGJ1aWx0aW4gdHlwZSB0
aW1lCjIwMThmOTEgdXRpbC9jdXRpbHM6IEFkZCBxZW11X3N0cnRvdGltZV9ucygpCjAwNjcyOGIg
dXRpbC9jdXRpbHM6IHJlZmFjdG9yIGRvX3N0cnRvc3ooKSB0byBzdXBwb3J0IHN1ZmZpeGVzIGxp
c3QKOGE1Nzc1MSB1dGlsL2N1dGlsczogVXNlIHFlbXVfc3RydG9sZF9maW5pdGUgdG8gcGFyc2Ug
c2l6ZQplYjJkMWZkIHV0aWwvY3V0aWxzOiBBZGQgQWRkIHFlbXVfc3RydG9sZCBhbmQgcWVtdV9z
dHJ0b2xkX2Zpbml0ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xNCBDaGVja2luZyBjb21taXQg
ZWIyZDFmZGIyY2YwICh1dGlsL2N1dGlsczogQWRkIEFkZCBxZW11X3N0cnRvbGQgYW5kIHFlbXVf
c3RydG9sZF9maW5pdGUpCkVSUk9SOiBjb25zaWRlciB1c2luZyBxZW11X3N0cnRvbGQgaW4gcHJl
ZmVyZW5jZSB0byBzdHJ0b2xkCiM2MTogRklMRTogdXRpbC9jdXRpbHMuYzo2MzY6CisgICAgKnJl
c3VsdCA9IHN0cnRvbGQobnB0ciwgJmVwKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywg
NjkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8xNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoK
Mi8xNCBDaGVja2luZyBjb21taXQgOGE1Nzc1MWMxN2VkICh1dGlsL2N1dGlsczogVXNlIHFlbXVf
c3RydG9sZF9maW5pdGUgdG8gcGFyc2Ugc2l6ZSkKMy8xNCBDaGVja2luZyBjb21taXQgMDA2NzI4
YmIwYjRiICh1dGlsL2N1dGlsczogcmVmYWN0b3IgZG9fc3RydG9zeigpIHRvIHN1cHBvcnQgc3Vm
Zml4ZXMgbGlzdCkKNC8xNCBDaGVja2luZyBjb21taXQgMjAxOGY5MTdjMzkxICh1dGlsL2N1dGls
czogQWRkIHFlbXVfc3RydG90aW1lX25zKCkpCjUvMTQgQ2hlY2tpbmcgY29tbWl0IGI3ZjFiMmNj
MWU5NiAocWFwaTogQWRkIGJ1aWx0aW4gdHlwZSB0aW1lKQo2LzE0IENoZWNraW5nIGNvbW1pdCAx
ODRkZDYyOWMyZmQgKHRlc3RzOiBBZGQgdGVzdCBmb3IgUUFQSSBidWlsdGluIHR5cGUgdGltZSkK
Ny8xNCBDaGVja2luZyBjb21taXQgYjYwN2I4NDk5ZjczIChudW1hOiBFeHRlbmQgQ0xJIHRvIHBy
b3ZpZGUgaW5pdGlhdG9yIGluZm9ybWF0aW9uIGZvciBudW1hIG5vZGVzKQo4LzE0IENoZWNraW5n
IGNvbW1pdCA1NmQxYzgwMTc1YWQgKG51bWE6IEV4dGVuZCBDTEkgdG8gcHJvdmlkZSBtZW1vcnkg
bGF0ZW5jeSBhbmQgYmFuZHdpZHRoIGluZm9ybWF0aW9uKQo5LzE0IENoZWNraW5nIGNvbW1pdCAz
YWYwYzBiOGZlNzEgKG51bWE6IEV4dGVuZCBDTEkgdG8gcHJvdmlkZSBtZW1vcnkgc2lkZSBjYWNo
ZSBpbmZvcm1hdGlvbikKMTAvMTQgQ2hlY2tpbmcgY29tbWl0IDI1NTQ4N2E0NGE4YiAoaG1hdCBh
Y3BpOiBCdWlsZCBNZW1vcnkgUHJveGltaXR5IERvbWFpbiBBdHRyaWJ1dGVzIFN0cnVjdHVyZShz
KSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJ
TkVSUyBuZWVkIHVwZGF0aW5nPwojNzI6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAg
ZXJyb3JzLCAxIHdhcm5pbmdzLCAxODUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTAvMTQgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KMTEvMTQgQ2hlY2tpbmcgY29tbWl0IGU0OTdmZTdjOGFkZiAo
aG1hdCBhY3BpOiBCdWlsZCBTeXN0ZW0gTG9jYWxpdHkgTGF0ZW5jeSBhbmQgQmFuZHdpZHRoIElu
Zm9ybWF0aW9uIFN0cnVjdHVyZShzKSkKMTIvMTQgQ2hlY2tpbmcgY29tbWl0IGViMzI5NDZjYWU0
ZiAoaG1hdCBhY3BpOiBCdWlsZCBNZW1vcnkgU2lkZSBDYWNoZSBJbmZvcm1hdGlvbiBTdHJ1Y3R1
cmUocykpCjEzLzE0IENoZWNraW5nIGNvbW1pdCA0ODYxODVkNmY3MGUgKHRlc3RzL251bWE6IEFk
ZCBjYXNlIGZvciBRTVAgYnVpbGQgSE1BVCkKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3Rl
cnMKIzY1OiBGSUxFOiB0ZXN0cy9udW1hLXRlc3QuYzozNzQ6CisgICAgZ19hc3NlcnQoIXFtcF9y
c3BfaXNfZXJyKHF0ZXN0X3FtcChxcywgInsgJ2V4ZWN1dGUnOiAneC1leGl0LXByZWNvbmZpZycg
fSIpKSk7Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDYzIGxpbmVzIGNoZWNrZWQKClBh
dGNoIDEzLzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjE0LzE0IENoZWNraW5nIGNvbW1p
dCBkNWRhMjBjZjA1MTQgKHRlc3RzL2Jpb3MtdGFibGVzLXRlc3Q6IGFkZCB0ZXN0IGNhc2VzIGZv
ciBBQ1BJIEhNQVQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzEwNjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDY1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDE0
LzE0IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTE1MDc1MzUyLjE3NzM0LTEtdGFvMy54dUBp
bnRlbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


