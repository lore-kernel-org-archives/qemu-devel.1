Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E685C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206592065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 06:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206592065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZqWi-0006NY-9q
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 02:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZqVh-0005BL-8U; Sat, 16 May 2020 02:41:26 -0400
Resent-Date: Sat, 16 May 2020 02:41:25 -0400
Resent-Message-Id: <E1jZqVh-0005BL-8U@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZqVb-0002dX-SP; Sat, 16 May 2020 02:41:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589611264; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BB/NyTrbS8Lx2SIgiemNjAaHjw9rF3ghUAdC8i7vc1KX5ZjAH+qkiglHvCJ+OoU39WriwjO8LCjGigDXlVNFJLmYB1mNf8vw5STAVbFKXOZQndHGLKT8rPLUV5Bjk8x+uJuLit5C1uY62OxprL0ICZAIJyTFucsnPuRbMadDAI0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589611264;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SqDcPeT8h6mAu/FJPTpwLr+gwDYc35TWznK8QMsUwMI=; 
 b=Qj5Q9oioW91duk3LPE6fWPzQvr7rRWfMrqkj2r/sf7rZZTO2q3A97T+/eXjdacMKBBCe0/HAGrqwqh3RxJ/W4va4bOjth5bdPrFvhUCDLncBNg9piR+uPaOSqFNlxBXHLLq85ca6xRNC5IeFFL1DjUE855rpfTPtgXT4hR6e14Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589611261729690.0011734193398;
 Fri, 15 May 2020 23:41:01 -0700 (PDT)
Message-ID: <158961125979.14027.17199612590911195654@45ef0f9c86ae>
In-Reply-To: <20200515222032.18838-1-walling@linux.ibm.com>
Subject: Re: [PATCH v2 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: walling@linux.ibm.com
Date: Fri, 15 May 2020 23:41:01 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 23:45:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNTIyMjAzMi4xODgz
OC0xLXdhbGxpbmdAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MTUyMjIwMzIuMTg4MzgtMS13YWxsaW5n
QGxpbnV4LmlibS5jb20KU3ViamVjdDogW1BBVENIIHYyIDAvOF0gczM5MDogRXh0ZW5kZWQtTGVu
Z3RoIFNDQ0IgJiBESUFHTk9TRSAweDMxOApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZjhjYjgyMSBzMzkw
OiBndWVzdCBzdXBwb3J0IGZvciBkaWFnbm9zZSAweDMxOAo2Yjg3YzU5IHMzOTAva3ZtOiBoZWFk
ZXIgc3luYyBmb3IgZGlhZzMxOAphZjA2NjI3IHMzOTAvc2NscDogYWRkIGV4dGVuZGVkLWxlbmd0
aCBzY2NiIHN1cHBvcnQgZm9yIGt2bSBndWVzdAozOWI4NDhjIHMzOTAvc2NscDogdXNlIGNwdSBv
ZmZzZXQgdG8gbG9jYXRlIGNwdSBlbnRyaWVzCjFkZDhlMDIgczM5MC9zY2xwOiByZWFkIHNjY2Ig
ZnJvbSBtZW0gYmFzZWQgb24gc2NjYiBsZW5ndGgKYWFkOTU2ZCBzMzkwL3NjbHA6IHJld29yayBz
Y2xwIGJvdW5kYXJ5IGFuZCBsZW5ndGggY2hlY2tzCjQyOGIxZTQgczM5MC9zY2xwOiBjaGVjayBz
Y2NiIGxlbiBiZWZvcmUgZmlsbGluZyBpbiBkYXRhCjg1MGUxYjggczM5MC9zY2xwOiBnZXQgbWFj
aGluZSBvbmNlIGR1cmluZyByZWFkIHNjcC9jcHUgaW5mbwoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
MS84IENoZWNraW5nIGNvbW1pdCA4NTBlMWI4ODcyOWYgKHMzOTAvc2NscDogZ2V0IG1hY2hpbmUg
b25jZSBkdXJpbmcgcmVhZCBzY3AvY3B1IGluZm8pCjIvOCBDaGVja2luZyBjb21taXQgNDI4YjFl
NDZlMDE2IChzMzkwL3NjbHA6IGNoZWNrIHNjY2IgbGVuIGJlZm9yZSBmaWxsaW5nIGluIGRhdGEp
CldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMzogRklMRTogaHcvczM5MHgvc2Ns
cC5jOjc4OgorICAgIGlmIChiZTE2X3RvX2NwdShzY2NiLT5oLmxlbmd0aCkgPCAoc2l6ZW9mKFJl
YWRJbmZvKSArIGNwdV9jb3VudCAqIHNpemVvZihDUFVFbnRyeSkpKSB7CgpFUlJPUjogbGluZSBv
dmVyIDkwIGNoYXJhY3RlcnMKIzQ4OiBGSUxFOiBody9zMzkweC9zY2xwLmM6MTM3OgorICAgIGlm
IChiZTE2X3RvX2NwdShzY2NiLT5oLmxlbmd0aCkgPCAoc2l6ZW9mKFJlYWRDcHVJbmZvKSArIGNw
dV9jb3VudCAqIHNpemVvZihDUFVFbnRyeSkpKSB7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2Fybmlu
Z3MsIDQ1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKMy84IENoZWNraW5nIGNvbW1pdCBhYWQ5NTZkNWFjOTIgKHMzOTAvc2NscDogcmV3b3JrIHNj
bHAgYm91bmRhcnkgYW5kIGxlbmd0aCBjaGVja3MpCjQvOCBDaGVja2luZyBjb21taXQgMWRkOGUw
MmFmN2IyIChzMzkwL3NjbHA6IHJlYWQgc2NjYiBmcm9tIG1lbSBiYXNlZCBvbiBzY2NiIGxlbmd0
aCkKNS84IENoZWNraW5nIGNvbW1pdCAzOWI4NDhjM2JlMTUgKHMzOTAvc2NscDogdXNlIGNwdSBv
ZmZzZXQgdG8gbG9jYXRlIGNwdSBlbnRyaWVzKQo2LzggQ2hlY2tpbmcgY29tbWl0IGFmMDY2Mjdj
YzVmYiAoczM5MC9zY2xwOiBhZGQgZXh0ZW5kZWQtbGVuZ3RoIHNjY2Igc3VwcG9ydCBmb3Iga3Zt
IGd1ZXN0KQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojOTE6IEZJTEU6IGh3L3Mz
OTB4L3NjbHAuYzoxMzc6CisgICAgICAgIHdhcm5fcmVwb3J0KCJpbnN1ZmZpY2llbnQgc2NjYiBz
aXplIHRvIHN0b3JlIGZ1bGwgcmVhZCBzY3AgaW5mbyByZXNwb25zZSIpOwoKV0FSTklORzogbGlu
ZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzExNTogRklMRTogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJl
c19kZWYuaW5jLmg6MTAwOgorREVGX0ZFQVQoRVhURU5ERURfTEVOR1RIX1NDQ0IsICJlbHMiLCBT
VEZMLCAxNDAsICJFeHRlbmRlZC1sZW5ndGggU0NDQiBmYWNpbGl0eSIpCgp0b3RhbDogMCBlcnJv
cnMsIDIgd2FybmluZ3MsIDc2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvOCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo3LzggQ2hlY2tpbmcgY29tbWl0IDZiODdjNTk5Mjc2OCAoczM5MC9rdm06
IGhlYWRlciBzeW5jIGZvciBkaWFnMzE4KQo4LzggQ2hlY2tpbmcgY29tbWl0IGY4Y2I4MjExMzRh
NyAoczM5MDogZ3Vlc3Qgc3VwcG9ydCBmb3IgZGlhZ25vc2UgMHgzMTgpCkVSUk9SOiBsaW5lIG92
ZXIgOTAgY2hhcmFjdGVycwojMjI2OiBGSUxFOiB0YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzX2Rl
Zi5pbmMuaDoxMjU6CisvKiBGZWF0dXJlcyBleHBvc2VkIHZpYSBTQ0xQIFNDQ0IgRmFjaWxpdGll
cyBieXRlIDEzNCAoYml0IG51bWJlcnMgcmVsYXRpdmUgdG8gYnl0ZS0xMzQpICovCgpXQVJOSU5H
OiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMjI3OiBGSUxFOiB0YXJnZXQvczM5MHgvY3B1X2Zl
YXR1cmVzX2RlZi5pbmMuaDoxMjY6CitERUZfRkVBVChESUFHXzMxOCwgImRpYWdfMzE4IiwgU0NM
UF9GQUMxMzQsIDAsICJDb250cm9sIHByb2dyYW0gbmFtZSBhbmQgdmVyc2lvbiBjb2RlcyIpCgp0
b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDI2MiBsaW5lcyBjaGVja2VkCgpQYXRjaCA4Lzgg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTE1MjIyMDMyLjE4ODM4LTEtd2FsbGluZ0BsaW51
eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

