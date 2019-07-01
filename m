Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BDBC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800F721479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800F721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8dr-00089C-W5
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60251)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hi4fN-0001qJ-1A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hi4fK-0005ev-If
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:52 -0400
Resent-Date: Mon, 01 Jul 2019 18:20:51 -0400
Resent-Message-Id: <E1hi4fK-0005ev-If@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hi4fK-0005dw-9L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562005960; cv=none; d=zoho.com; s=zohoarc; 
 b=avxehrbsMfMoo/L+mC+fpK01QcSPQWcLQxPA/emn5jz1VZey/yf/9xOSLL95Ao7UiWoLYbSuzYflLTJQZWsKTgb0lQc3DKfb/WxQNsMFSXCDIeHAomNgWZUDnF4bNT0wed3xiuf2qah50th8y6ZWuReJchH4fxHW9sa35GJsPDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562005960;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=WwytJBjS6/lttyfsbDepPWRIOMK/T5OaPzbVvMLs93s=; 
 b=h9q6pkne8sPbfuSF5yBDrG24KZ+6Wxl4satKDfMQfgAOj+gzCESWOdLvecQID825cHe6F2V46bdLVrc6lV/vhIKdHE3S6yIWATwqpeljspDeHCPRvx5mzf4Ug425Eyby4uzBmu64bYoazjnT/m7V+aeIlWyy4rGUKQ/wHoOZjT4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562005958483459.30761266729075;
 Mon, 1 Jul 2019 11:32:38 -0700 (PDT)
Message-ID: <156200595711.9862.7040370997899574980@c4a48874b076>
In-Reply-To: <20190701144705.102615-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: slp@redhat.com
Date: Mon, 1 Jul 2019 11:32:38 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Introduce the microvm machine type
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
Cc: ehabkost@redhat.com, slp@redhat.com, maran.wilson@oracle.com,
 mst@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMTE0NDcwNS4xMDI2
MTUtMS1zbHBAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwNzAxMTQ0NzA1LjEwMjYxNS0x
LXNscEByZWRoYXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjIgMC80XSBJbnRy
b2R1Y2UgdGhlIG1pY3Jvdm0gbWFjaGluZSB0eXBlCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDcwMTE0NDcwNS4xMDI2MTUtMS1zbHBA
cmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwNzAxMTQ0NzA1LjEwMjYxNS0xLXNscEByZWRoYXQu
Y29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNTYzYTExYiBody9pMzg2OiBJbnRy
b2R1Y2UgdGhlIG1pY3Jvdm0gbWFjaGluZSB0eXBlCjRmMzM2OGMgaHcvaTM4NjogRmFjdG9yaXpl
IFBWSCByZWxhdGVkIGZ1bmN0aW9ucwozNjUwOWYxIGh3L2kzODY6IEFkZCBhbiBJbnRlbCBNUFRh
YmxlIGdlbmVyYXRvcgowYjM0MjA3IGh3L3ZpcnRpbzogRmFjdG9yaXplIHZpcnRpby1tbWlvIGhl
YWRlcnMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgMGIzNDIwNzVj
ZWFkIChody92aXJ0aW86IEZhY3Rvcml6ZSB2aXJ0aW8tbW1pbyBoZWFkZXJzKQpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiM2NjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDEwNSBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KMi80IENoZWNraW5nIGNvbW1pdCAzNjUwOWYxODE3YzMgKGh3L2kzODY6IEFkZCBhbiBJ
bnRlbCBNUFRhYmxlIGdlbmVyYXRvcikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQg
ZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTY6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAzNzQgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvNCBDaGVja2luZyBjb21t
aXQgNGYzMzY4Y2M0YTZmIChody9pMzg2OiBGYWN0b3JpemUgUFZIIHJlbGF0ZWQgZnVuY3Rpb25z
KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlO
RVJTIG5lZWQgdXBkYXRpbmc/CiMxODY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGRv
IG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgdG8gMCBvciBOVUxMCiMyMTA6IEZJTEU6IGh3L2kzODYv
cHZoLmM6MjA6CitzdGF0aWMgc2l6ZV90IHB2aF9zdGFydF9hZGRyID0gMDsKCnRvdGFsOiAxIGVy
cm9ycywgMSB3YXJuaW5ncywgMjgxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKNC80IENoZWNraW5nIGNvbW1pdCA1NjNhMTFiYmM1YmQgKGh3L2kz
ODY6IEludHJvZHVjZSB0aGUgbWljcm92bSBtYWNoaW5lIHR5cGUpCldBUk5JTkc6IGFkZGVkLCBt
b3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8K
IzY3OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywg
NTk4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcw
MTE0NDcwNS4xMDI2MTUtMS1zbHBAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


