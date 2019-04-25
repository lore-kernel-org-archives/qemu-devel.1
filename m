Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC3C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0462320717
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 20:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0462320717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34531 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJkhE-0001k8-Oa
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 16:10:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJkgP-0001R6-1N
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJkgN-00018t-MF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:09:25 -0400
Resent-Date: Thu, 25 Apr 2019 16:09:24 -0400
Resent-Message-Id: <E1hJkgN-00018t-MF@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hJkgN-00010h-GS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 16:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556222944; cv=none; d=zoho.com; s=zohoarc; 
	b=kTBtG2oOA09ZsMebjY4SOAVtsRBKWJgvRGLfsDnJJ/F0z7UFhrNmbhHdsTzBJyUpa7kbK1gsby9QfEYJk1JX2vxqKiB2bJOc1Zt6yrJlgoFJugXV1Ej0DEjnCq9uSiBxMis3x1M4FUGvYv4NUsS3oqbveeWmd6g5A7IXhetmfCw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556222944;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=UKI/RqSP5UvEk08TCSamP7Es5cECT+mrdU7UIhOqAlQ=; 
	b=ct1+xIII2LWetlFCG1wfs+2LxxdURjJoBGPZo4CREHIiGFfuSMeEUONIWpJe1A8kHd2rijZoCazZRwHLc4r/NpxkrSLtfCrq5I8FbhZZb7sywkOxejbGDXKojMPbguVs4A2/pmDJNTU8i1kkFLY7w7aHcAq4awqfjug60c42GKE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556222942053610.7316291914372;
	Thu, 25 Apr 2019 13:09:02 -0700 (PDT)
In-Reply-To: <20190425200051.19906-1-ehabkost@redhat.com>
Message-ID: <155622294067.2185.14377228691078068865@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Thu, 25 Apr 2019 13:09:02 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH 0/4] Remove some qdev_get_machine() calls
 from CONFIG_USER_ONLY
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, thuth@redhat.com,
	like.xu@linux.intel.com, qemu-devel@nongnu.org,
	armbru@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425200902.hItALLbTXkPpUlGu-R9FM5PNj-GHyrCM0gQqcWXnrQQ@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNTIwMDA1MS4xOTkw
Ni0xLWVoYWJrb3N0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDQyNTIwMDA1MS4xOTkw
Ni0xLWVoYWJrb3N0QHJlZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzRd
IFJlbW92ZSBzb21lIHFkZXZfZ2V0X21hY2hpbmUoKSBjYWxscyBmcm9tIENPTkZJR19VU0VSX09O
TFkKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcv
MjAxOTA0MjQwMDQ3MDAuMTI3NjYtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbSAtPiBw
YXRjaGV3LzIwMTkwNDI0MDA0NzAwLjEyNzY2LTEtcmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5j
b20KICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQyNTIwMDA1MS4xOTkw
Ni0xLWVoYWJrb3N0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQyNTIwMDA1MS4xOTkwNi0x
LWVoYWJrb3N0QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpjNWM3
N2VhMmNjIHFkZXYtaG90cGx1ZzogRG9uJ3QgY2hlY2sgdHlwZSBvZiBxZGV2X2dldF9tYWNoaW5l
KCkKODU0ZGVkNzExZCBxZGV2OiBEb24ndCBjb21waWxlIGhvdHBsdWcgY29kZSBpbiB1c2VyLW1v
ZGUgZW11bGF0aW9uCjFiZDMzMzA3YmUgbW92ZSBxZGV2IGhvdHBsdWcgY29kZSB0byBxZGV2LWhv
dHBsdWcuYwowMmIxZjVkYjZmIG1hY2hpbmU6IE1vdmUgZ3BpbyBjb2RlIHRvIGh3L2NvcmUvZ3Bp
by5jCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29tbWl0IDAyYjFmNWRiNmZj
ZCAobWFjaGluZTogTW92ZSBncGlvIGNvZGUgdG8gaHcvY29yZS9ncGlvLmMpCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzI2OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRz
IHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM2MDogRklMRTogaHcvY29yZS9n
cGlvLmM6MzA6CisgICAgICAgIC8qIE5VTEwgaXMgYSB2YWxpZCBhbmQgbWF0Y2hhYmxlIG5hbWUs
IG90aGVyd2lzZSBkbyBhIG5vcm1hbAoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVh
ZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzE1NjogRklMRTogaHcvY29yZS9ncGlvLmM6MTI2
OgorICAgICAgICAvKiBXZSBuZWVkIGEgbmFtZSBmb3Igb2JqZWN0X3Byb3BlcnR5X3NldF9saW5r
IHRvIHdvcmsuICBJZiB0aGUKCkVSUk9SOiAiZm9vICogYmFyIiBzaG91bGQgYmUgImZvbyAqYmFy
IgojMjA1OiBGSUxFOiBody9jb3JlL2dwaW8uYzoxNzU6Cit2b2lkIHFkZXZfY29ubmVjdF9ncGlv
X291dChEZXZpY2VTdGF0ZSAqIGRldiwgaW50IG4sIHFlbXVfaXJxIHBpbikKCnRvdGFsOiAxIGVy
cm9ycywgMyB3YXJuaW5ncywgNDAzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvNCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKMi80IENoZWNraW5nIGNvbW1pdCAxYmQzMzMwN2JlMTEgKG1vdmUg
cWRldiBob3RwbHVnIGNvZGUgdG8gcWRldi1ob3RwbHVnLmMpCldBUk5JTkc6IGFkZGVkLCBtb3Zl
ZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzQ5
OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTM0
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgozLzQg
Q2hlY2tpbmcgY29tbWl0IDg1NGRlZDcxMWRhYSAocWRldjogRG9uJ3QgY29tcGlsZSBob3RwbHVn
IGNvZGUgaW4gdXNlci1tb2RlIGVtdWxhdGlvbikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRl
bGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNDg6IApuZXcg
ZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA3NyBsaW5lcyBj
aGVja2VkCgpQYXRjaCAzLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNC80IENoZWNraW5n
IGNvbW1pdCBjNWM3N2VhMmNjZGUgKHFkZXYtaG90cGx1ZzogRG9uJ3QgY2hlY2sgdHlwZSBvZiBx
ZGV2X2dldF9tYWNoaW5lKCkpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwNDI1MjAwMDUxLjE5OTA2LTEtZWhhYmtvc3RAcmVkaGF0LmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


