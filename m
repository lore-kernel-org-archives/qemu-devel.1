Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E7C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0FD2082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0FD2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i67i0-0002Vm-HO
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 02:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i67hA-00024N-8w
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i67h8-00032D-E9
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:26:07 -0400
Resent-Date: Fri, 06 Sep 2019 02:26:07 -0400
Resent-Message-Id: <E1i67h8-00032D-E9@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i67h8-0002yu-51
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:26:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567751138; cv=none; d=zoho.com; s=zohoarc; 
 b=PcM2w4VAGG0eD0go0FgJsWGbpoI7RPpMjFnz913fcpLb1ltpPy49BNIpaQ/SC9RuGmY/jIzrKcOs5BVhtpkQZxt2EzFxoVh4/f25EfmVBCIgJcU/rJ1450gY5Rg9NA4W7oX/foosAde5nCGFM4q/5BFBY8ksG9wQyLDXMz9fMD8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567751138;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=ncmJga44DRLH3mmJTGW0uo/W/FitA7gtyXCBuhMlB3c=; 
 b=cgPnrYnAyWwo3udPrsej5ZKn0n4SaT/wlSGUDfswKFPriUmqwoB+Cuyaa3Sb+dUUG4+yGDZgfM4QPo1A9gocOy62ooE+1wY82MkEzlBx6zjzsHVh6ufA55OGzvkcxuPitxZCDHOBU0XpPCIQzuDzdY4KmBSWpK1oPqlOfgQ6FEU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156775113740382.23842977239724;
 Thu, 5 Sep 2019 23:25:37 -0700 (PDT)
In-Reply-To: <cover.1567750222.git.alistair@alistair23.me>
Message-ID: <156775113612.4643.4767087241991129875@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alistair@alistair23.me
Date: Thu, 5 Sep 2019 23:25:37 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH v4 0/6] Add the STM32F405 and Netduino Plus
 2 machine
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTY3NzUwMjIyLmdp
dC5hbGlzdGFpckBhbGlzdGFpcjIzLm1lLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0IDAvNl0gQWRkIHRo
ZSBTVE0zMkY0MDUgYW5kIE5ldGR1aW5vIFBsdXMgMiBtYWNoaW5lCk1lc3NhZ2UtaWQ6IGNvdmVy
LjE1Njc3NTAyMjIuZ2l0LmFsaXN0YWlyQGFsaXN0YWlyMjMubWUKVHlwZTogc2VyaWVzCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjhiMGVjZDQgaHcvYXJtOiBBZGQgdGhlIE5ldGR1aW5vIFBsdXMgMgo0MDdmNzNmIGh3L2FybTog
QWRkIHRoZSBTVE0zMkY0eHggU29DCjUxMmZmZjMgaHcvbWlzYzogQWRkIHRoZSBTVE0zMkY0eHgg
RVhUSSBkZXZpY2UKMmNhYWQ1YyBody9taXNjOiBBZGQgdGhlIFNUTTMyRjR4eCBTeXNjb25maWcg
ZGV2aWNlCjk1NWYwNjAgdGFyZ2V0L2FybTogQWxsb3cgc2V0dGluZyBNIG1vZGUgZW50cnkgYW5k
IHNwCmQ4MWQyN2YgYXJtdjdtOiBBbGxvdyBlbnRyeSBpbmZvcm1hdGlvbiB0byBiZSByZXR1cm5l
ZAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS82IENoZWNraW5nIGNvbW1pdCBkODFkMjdmMDk5NmEg
KGFybXY3bTogQWxsb3cgZW50cnkgaW5mb3JtYXRpb24gdG8gYmUgcmV0dXJuZWQpCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyNDogRklMRTogaHcvYXJtL2FybXY3bS5jOjMwOToK
K3VpbnQ2NF90IGFybXY3bV9sb2FkX2tlcm5lbChBUk1DUFUgKmNwdSwgY29uc3QgY2hhciAqa2Vy
bmVsX2ZpbGVuYW1lLCBpbnQgbWVtX3NpemUpCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojNTI6IEZJTEU6IGluY2x1ZGUvaHcvYXJtL2Jvb3QuaDozNjoKK3VpbnQ2NF90IGFybXY3
bV9sb2FkX2tlcm5lbChBUk1DUFUgKmNwdSwgY29uc3QgY2hhciAqa2VybmVsX2ZpbGVuYW1lLCBp
bnQgbWVtX3NpemUpOwoKdG90YWw6IDAgZXJyb3JzLCAyIHdhcm5pbmdzLCAzMCBsaW5lcyBjaGVj
a2VkCgpQYXRjaCAxLzYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMi82IENoZWNraW5nIGNv
bW1pdCA5NTVmMDYwNzg2NjIgKHRhcmdldC9hcm06IEFsbG93IHNldHRpbmcgTSBtb2RlIGVudHJ5
IGFuZCBzcCkKMy82IENoZWNraW5nIGNvbW1pdCAyY2FhZDVjNjcwMzUgKGh3L21pc2M6IEFkZCB0
aGUgU1RNMzJGNHh4IFN5c2NvbmZpZyBkZXZpY2UpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzc3OiAKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25kaXRp
b25hbCBzdGF0ZW1lbnRzICg0LCA3KQojMTM1OiBGSUxFOiBody9taXNjL3N0bTMyZjR4eF9zeXNj
ZmcuYzo1NDoKKyAgICBpZiAoZXh0cmFjdDMyKHMtPnN5c2NmZ19leHRpY3JbaWNycmVnXSwgc3Rh
cnRiaXQsIDQpID09IGNvbmZpZykgeworICAgICAgIHFlbXVfc2V0X2lycShzLT5ncGlvX291dFtp
cnFdLCBsZXZlbCk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMjIyOiBGSUxF
OiBody9taXNjL3N0bTMyZjR4eF9zeXNjZmcuYzoxNDE6CisgICAgICAgIFZNU1RBVEVfVUlOVDMy
X0FSUkFZKHN5c2NmZ19leHRpY3IsIFNUTTMyRjR4eFN5c2NmZ1N0YXRlLCBTWVNDRkdfTlVNX0VY
VElDUiksCgp0b3RhbDogMSBlcnJvcnMsIDIgd2FybmluZ3MsIDI4NSBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAzLzYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvNiBDaGVja2luZyBjb21taXQg
NTEyZmZmM2ZhYjc2IChody9taXNjOiBBZGQgdGhlIFNUTTMyRjR4eCBFWFRJIGRldmljZSkKV0FS
TklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBu
ZWVkIHVwZGF0aW5nPwojNTA6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3Jz
LCAxIHdhcm5pbmdzLCAyODEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC82IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCjUvNiBDaGVja2luZyBjb21taXQgNDA3ZjczZmIzMjI5IChody9hcm06IEFk
ZCB0aGUgU1RNMzJGNHh4IFNvQykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmls
ZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNTc6IApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA0MDQgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggNS82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjYvNiBDaGVja2luZyBjb21taXQg
OGIwZWNkNDEzYmRjIChody9hcm06IEFkZCB0aGUgTmV0ZHVpbm8gUGx1cyAyKQpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiM1NDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDg2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAx
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9j
b3Zlci4xNTY3NzUwMjIyLmdpdC5hbGlzdGFpckBhbGlzdGFpcjIzLm1lL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


