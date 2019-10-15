Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89862ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6233920650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6233920650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQbe-0004Da-JS
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKQaz-0003gf-A4
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:26:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKQax-0007dF-Pq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:26:53 -0400
Resent-Date: Tue, 15 Oct 2019 13:26:53 -0400
Resent-Message-Id: <E1iKQax-0007dF-Pq@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKQas-0007Y4-Cm; Tue, 15 Oct 2019 13:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571160384; cv=none; d=zoho.com; s=zohoarc; 
 b=lPqecGJGOB4b80PP6swrM8bBzGfQfu244RZ+b+O4UemCsgWVJl8Wek5rzEPHrgUD7Ur9npCJ2bN57QM9QHeWUeL4iLkLsW2FxPwVVEj0F/QfQpp90MWrrZcqud6Xj0nsZGZ5e/hfuo16kND3PhV9fZweOKg3CrkklJ3XudVCBCo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571160384;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7NR7/xW3GLdXT2TPqeBnSysTg53pGqrUbWum+NS0Y1c=; 
 b=IJXDPd5YyGzf/vK83/ZJog0PEqzmJKmz860laPhA1q0MhpQ5gfKz0+7tkllMWBvmTARxqUqquD+K0qSZfkgnNRj3OoPITgQCgHc7ASWoqjfPLIbNSUvJbsNMBu81c8VGjhBkQeX9WW2qkFkBTi6RudjyTVswjjJZ13ei5gWQGIA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571160383027660.346576208769;
 Tue, 15 Oct 2019 10:26:23 -0700 (PDT)
In-Reply-To: <20191015103900.313928-1-its@irrelevant.dk>
Subject: Re: [PATCH v2 00/20] nvme: support NVMe v1.3d,
 SGLs and multiple namespaces
Message-ID: <157116038134.5946.14412649636938701674@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: its@irrelevant.dk
Date: Tue, 15 Oct 2019 10:26:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: kwolf@redhat.com, fam@euphon.net, javier@javigon.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, keith.busch@intel.com,
 Paul.Durrant@citrix.com, sbates@raithlin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNTEwMzkwMC4zMTM5
MjgtMS1pdHNAaXJyZWxldmFudC5kay8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyIDAwLzIwXSBudm1lOiBzdXBwb3J0IE5WTWUg
djEuM2QsIFNHTHMgYW5kIG11bHRpcGxlIG5hbWVzcGFjZXMKVHlwZTogc2VyaWVzCk1lc3NhZ2Ut
aWQ6IDIwMTkxMDE1MTAzOTAwLjMxMzkyOC0xLWl0c0BpcnJlbGV2YW50LmRrCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVs
bCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2Uu
Lgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwpjNjhmN2UwIG52bWU6IGhhbmRsZSBkbWEgZXJyb3JzCjg1NWYyYjggbnZtZTogbWFrZSBsYmEg
ZGF0YSBzaXplIGNvbmZpZ3VyYWJsZQo2OGZjNTc1IG52bWU6IHJlbW92ZSByZWR1bmRhbnQgTnZt
ZUNtZCBwb2ludGVyIHBhcmFtZXRlcgplYjU4NWQxIG52bWU6IGJ1bXAgY29udHJvbGxlciBwY2kg
ZGV2aWNlIGlkCjIyNzI4MGMgbnZtZTogc3VwcG9ydCBtdWx0aXBsZSBuYW1lc3BhY2VzCmNjYzg3
N2IgbnZtZTogYWRkIHN1cHBvcnQgZm9yIHNjYXR0ZXIgZ2F0aGVyIGxpc3RzCjc2ZDZmZTYgbnZt
ZTogYWxsb3cgbXVsdGlwbGUgYWlvcyBwZXIgY29tbWFuZAo3MzIyN2NiIG52bWU6IHJlZmFjdG9y
IHBycCBtYXBwaW5nCmRmNWZkOWYgbnZtZTogYnVtcCBzdXBwb3J0ZWQgc3BlY2lmaWNhdGlvbiB2
ZXJzaW9uIHRvIDEuMwpjODVjMGZmIG52bWU6IGFkZCBtaXNzaW5nIG1hbmRhdG9yeSBmZWF0dXJl
cwoxMTg4NTUyIG52bWU6IGFkZCBsb2dnaW5nIHRvIGVycm9yIGluZm9ybWF0aW9uIGxvZyBwYWdl
CjcxNDgwOGMgbnZtZTogYWRkIHN1cHBvcnQgZm9yIHRoZSBhc3luY2hyb25vdXMgZXZlbnQgcmVx
dWVzdCBjb21tYW5kCjg4YmRmY2UgbnZtZTogYWRkIHN1cHBvcnQgZm9yIHRoZSBnZXQgbG9nIHBh
Z2UgY29tbWFuZAo3NzE2NjQ5IG52bWU6IHJlZmFjdG9yIGRldmljZSByZWFsaXphdGlvbgo3ZDJk
NTFlIG52bWU6IGFkZCBzdXBwb3J0IGZvciB0aGUgYWJvcnQgY29tbWFuZAo0ZWMwZTgxIG52bWU6
IGFsbG93IGNvbXBsZXRpb24gcXVldWVzIGluIHRoZSBjbWIKNjhmMDBkYiBudm1lOiBwb3B1bGF0
ZSB0aGUgbWFuZGF0b3J5IHN1Ym5xbiBhbmQgdmVyIGZpZWxkcwpmMDhkNjZhIG52bWU6IGFkZCBt
aXNzaW5nIGZpZWxkcyBpbiB0aGUgaWRlbnRpZnkgY29udHJvbGxlciBkYXRhIHN0cnVjdHVyZQoz
MTVhNmViIG52bWU6IG1vdmUgZGV2aWNlIHBhcmFtZXRlcnMgdG8gc2VwYXJhdGUgc3RydWN0CmI5
NGNmNGEgbnZtZTogcmVtb3ZlIHN1cGVyZmx1b3VzIGJyZWFrcwoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KMS8yMCBDaGVja2luZyBjb21taXQgYjk0Y2Y0YWVhMDdiIChudm1lOiByZW1vdmUgc3VwZXJm
bHVvdXMgYnJlYWtzKQoyLzIwIENoZWNraW5nIGNvbW1pdCAzMTVhNmViMWYwOWYgKG52bWU6IG1v
dmUgZGV2aWNlIHBhcmFtZXRlcnMgdG8gc2VwYXJhdGUgc3RydWN0KQpFUlJPUjogTWFjcm9zIHdp
dGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiMxNzc6
IEZJTEU6IGh3L2Jsb2NrL252bWUuaDo2OgorI2RlZmluZSBERUZJTkVfTlZNRV9QUk9QRVJUSUVT
KF9zdGF0ZSwgX3Byb3BzKSBcCisgICAgREVGSU5FX1BST1BfU1RSSU5HKCJzZXJpYWwiLCBfc3Rh
dGUsIF9wcm9wcy5zZXJpYWwpLCBcCisgICAgREVGSU5FX1BST1BfVUlOVDMyKCJjbWJfc2l6ZV9t
YiIsIF9zdGF0ZSwgX3Byb3BzLmNtYl9zaXplX21iLCAwKSwgXAorICAgIERFRklORV9QUk9QX1VJ
TlQzMigibnVtX3F1ZXVlcyIsIF9zdGF0ZSwgX3Byb3BzLm51bV9xdWV1ZXMsIDY0KQoKdG90YWw6
IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxODEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8yMCBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8yMCBDaGVja2luZyBjb21taXQgZjA4ZDY2YWE3NjFi
IChudm1lOiBhZGQgbWlzc2luZyBmaWVsZHMgaW4gdGhlIGlkZW50aWZ5IGNvbnRyb2xsZXIgZGF0
YSBzdHJ1Y3R1cmUpCjQvMjAgQ2hlY2tpbmcgY29tbWl0IDY4ZjAwZGI1N2U4NyAobnZtZTogcG9w
dWxhdGUgdGhlIG1hbmRhdG9yeSBzdWJucW4gYW5kIHZlciBmaWVsZHMpCjUvMjAgQ2hlY2tpbmcg
Y29tbWl0IDRlYzBlODFhOGNhNSAobnZtZTogYWxsb3cgY29tcGxldGlvbiBxdWV1ZXMgaW4gdGhl
IGNtYikKNi8yMCBDaGVja2luZyBjb21taXQgN2QyZDUxZTVkYTg5IChudm1lOiBhZGQgc3VwcG9y
dCBmb3IgdGhlIGFib3J0IGNvbW1hbmQpCjcvMjAgQ2hlY2tpbmcgY29tbWl0IDc3MTY2NDljM2Q2
ZCAobnZtZTogcmVmYWN0b3IgZGV2aWNlIHJlYWxpemF0aW9uKQo4LzIwIENoZWNraW5nIGNvbW1p
dCA4OGJkZmNlMWE1OTkgKG52bWU6IGFkZCBzdXBwb3J0IGZvciB0aGUgZ2V0IGxvZyBwYWdlIGNv
bW1hbmQpCjkvMjAgQ2hlY2tpbmcgY29tbWl0IDcxNDgwOGNkM2VmOCAobnZtZTogYWRkIHN1cHBv
cnQgZm9yIHRoZSBhc3luY2hyb25vdXMgZXZlbnQgcmVxdWVzdCBjb21tYW5kKQoxMC8yMCBDaGVj
a2luZyBjb21taXQgMTE4ODU1MjJmYTg3IChudm1lOiBhZGQgbG9nZ2luZyB0byBlcnJvciBpbmZv
cm1hdGlvbiBsb2cgcGFnZSkKMTEvMjAgQ2hlY2tpbmcgY29tbWl0IGM4NWMwZmY1ZWEzNSAobnZt
ZTogYWRkIG1pc3NpbmcgbWFuZGF0b3J5IGZlYXR1cmVzKQoxMi8yMCBDaGVja2luZyBjb21taXQg
ZGY1ZmQ5ZjI4M2E0IChudm1lOiBidW1wIHN1cHBvcnRlZCBzcGVjaWZpY2F0aW9uIHZlcnNpb24g
dG8gMS4zKQoxMy8yMCBDaGVja2luZyBjb21taXQgNzMyMjdjYjNjODNjIChudm1lOiByZWZhY3Rv
ciBwcnAgbWFwcGluZykKMTQvMjAgQ2hlY2tpbmcgY29tbWl0IDc2ZDZmZTZlYTFjZiAobnZtZTog
YWxsb3cgbXVsdGlwbGUgYWlvcyBwZXIgY29tbWFuZCkKMTUvMjAgQ2hlY2tpbmcgY29tbWl0IGNj
Yzg3N2I2ZjcyYiAobnZtZTogYWRkIHN1cHBvcnQgZm9yIHNjYXR0ZXIgZ2F0aGVyIGxpc3RzKQox
Ni8yMCBDaGVja2luZyBjb21taXQgMjI3MjgwYzhkMDhjIChudm1lOiBzdXBwb3J0IG11bHRpcGxl
IG5hbWVzcGFjZXMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzQyOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
CnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgODAxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDE2
LzIwIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjE3LzIwIENoZWNraW5nIGNvbW1pdCBlYjU4
NWQxMjMxZTMgKG52bWU6IGJ1bXAgY29udHJvbGxlciBwY2kgZGV2aWNlIGlkKQoxOC8yMCBDaGVj
a2luZyBjb21taXQgNjhmYzU3NWIzZmM3IChudm1lOiByZW1vdmUgcmVkdW5kYW50IE52bWVDbWQg
cG9pbnRlciBwYXJhbWV0ZXIpCjE5LzIwIENoZWNraW5nIGNvbW1pdCA4NTVmMmI4NmRkNmMgKG52
bWU6IG1ha2UgbGJhIGRhdGEgc2l6ZSBjb25maWd1cmFibGUpCjIwLzIwIENoZWNraW5nIGNvbW1p
dCBjNjhmN2UwZDBjNTUgKG52bWU6IGhhbmRsZSBkbWEgZXJyb3JzKQpXQVJOSU5HOiBsaW5lIG92
ZXIgODAgY2hhcmFjdGVycwojNzc6IEZJTEU6IGh3L2Jsb2NrL252bWUuYzoyNTc6CisgICAgICAg
ICAgICAgICAgICAgIGlmIChudm1lX2FkZHJfcmVhZChuLCBwcnBfZW50LCAodm9pZCAqKSBwcnBf
bGlzdCwgcHJwX3RyYW5zKSkgewoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzEw
MzogRklMRTogaHcvYmxvY2svbnZtZS5jOjQyODoKKyAgICAgICAgaWYgKG52bWVfYWRkcl9yZWFk
KG4sIGFkZHIsIHNlZ21lbnQsIG5zZ2xkICogc2l6ZW9mKE52bWVTZ2xEZXNjcmlwdG9yKSkpIHsK
CnRvdGFsOiAwIGVycm9ycywgMiB3YXJuaW5ncywgMTQ4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIw
LzIwIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDE1MTAzOTAwLjMxMzkyOC0xLWl0c0BpcnJl
bGV2YW50LmRrL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


