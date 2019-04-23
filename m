Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65E5C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DE62175B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DE62175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxgl-0001Hd-S6
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:50:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIxfS-0000Sy-6x
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIxfQ-0003kO-8Z
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:49:10 -0400
Resent-Date: Tue, 23 Apr 2019 11:49:09 -0400
Resent-Message-Id: <E1hIxfQ-0003kO-8Z@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hIxfP-0003jJ-4y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:49:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556034519; cv=none; d=zoho.com; s=zohoarc; 
	b=kOtejOA5ZE85HI8zWBcHPL/QCOI9a8fXg4VTtBH8+WIfRjNYjVhhNX+vRruT2L0HWjdM2Toizqz4tXAOQT5c3PS6V1SniXzVY7UOIuQmjP5F0+GXFuY71nf+1g4AwgRlcbetjmNix+FfAjSE38XZf4o/+PXcbv8thErG+35HUaA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556034519;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=pZ6C+qIM0j0jii/GuSavEmp5Zc2WUmZ5CWE/FSJi81Y=; 
	b=geFLdGCyUhIL58/dI+3HplK74slRCVvgg7KnVHArzFfSTTSlpVKjFzuU2KPxdnD3lAX8Gk3q3Dx5iE/bvgUnKmrYx31mxxU+dIh1ecl/nTeFuO4zVyWfJz3jwf0WZ+NZiIAkRn2KCKUiz14kX0qpzmgFM65mlsVQQdU8fBKEYa0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556034517908843.8134972930264;
	Tue, 23 Apr 2019 08:48:37 -0700 (PDT)
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
Message-ID: <155603451680.26689.17404772311634658081@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 23 Apr 2019 08:48:37 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2 0/7] tcg: Restart TB generation on
 overflow
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
Cc: fam@euphon.net, alistair23@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423154837.cFIE6jyrMuBqbFox_2h7HJ3NM3gEHFfdBpICEY_8C1U@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzE1Mzg1My4xOTc5
MC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDQyMzE1
Mzg1My4xOTc5MC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2MiAwLzddIHRjZzogUmVzdGFydCBUQiBnZW5lcmF0aW9uIG9uIG92ZXJm
bG93Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2Ug
YmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3
LzIwMTkwNDIzMTUzODUzLjE5NzkwLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyAtPiBw
YXRjaGV3LzIwMTkwNDIzMTUzODUzLjE5NzkwLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
ZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmMzYjQ5OWFjNTQgdGNnL2FybTogUmVz
dHJpY3QgY29uc3RhbnQgcG9vbCBkaXNwbGFjZW1lbnQgdG8gMTIgYml0cwo1MDRmZTkyYzFhIHRj
Zy9wcGM6IEFsbG93IHRoZSBjb25zdGFudCBwb29sIHRvIG92ZXJmbG93IGF0IDMyawo2Mzk3ZjMx
ZGJlIHRjZzogUmVzdGFydCBUQiBnZW5lcmF0aW9uIGFmdGVyIG91dC1vZi1saW5lIGxkc3Qgb3Zl
cmZsb3cKM2ExYjMzYjNmYyB0Y2c6IFJlc3RhcnQgVEIgZ2VuZXJhdGlvbiBhZnRlciBjb25zdGFu
dCBwb29sIG92ZXJmbG93CmZhMmVlYjA4YmEgdGNnOiBSZXN0YXJ0IFRCIGdlbmVyYXRpb24gYWZ0
ZXIgcmVsb2NhdGlvbiBvdmVyZmxvdwo0YWI0OTRjNDQyIHRjZzogUmVzdGFydCBhZnRlciBUQiBj
b2RlIGdlbmVyYXRpb24gb3ZlcmZsb3cKZDdkZTE4MGIyNSB0Y2c6IEhvaXN0IG1heF9pbnNucyBj
b21wdXRhdGlvbiB0byB0Yl9nZW5fY29kZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS83IENoZWNr
aW5nIGNvbW1pdCBkN2RlMTgwYjI1NmQgKHRjZzogSG9pc3QgbWF4X2luc25zIGNvbXB1dGF0aW9u
IHRvIHRiX2dlbl9jb2RlKQoyLzcgQ2hlY2tpbmcgY29tbWl0IDRhYjQ5NGM0NDI1MyAodGNnOiBS
ZXN0YXJ0IGFmdGVyIFRCIGNvZGUgZ2VuZXJhdGlvbiBvdmVyZmxvdykKMy83IENoZWNraW5nIGNv
bW1pdCBmYTJlZWIwOGJhYWUgKHRjZzogUmVzdGFydCBUQiBnZW5lcmF0aW9uIGFmdGVyIHJlbG9j
YXRpb24gb3ZlcmZsb3cpCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMxNDI6IEZJTEU6IHRj
Zy90Y2cuaDoyNDY6Cit9OyAkCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE0MCBsaW5l
cyBjaGVja2VkCgpQYXRjaCAzLzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvNyBDaGVj
a2luZyBjb21taXQgM2ExYjMzYjNmYzcwICh0Y2c6IFJlc3RhcnQgVEIgZ2VuZXJhdGlvbiBhZnRl
ciBjb25zdGFudCBwb29sIG92ZXJmbG93KQo1LzcgQ2hlY2tpbmcgY29tbWl0IDYzOTdmMzFkYmUw
ZSAodGNnOiBSZXN0YXJ0IFRCIGdlbmVyYXRpb24gYWZ0ZXIgb3V0LW9mLWxpbmUgbGRzdCBvdmVy
ZmxvdykKNi83IENoZWNraW5nIGNvbW1pdCA1MDRmZTkyYzFhZTggKHRjZy9wcGM6IEFsbG93IHRo
ZSBjb25zdGFudCBwb29sIHRvIG92ZXJmbG93IGF0IDMyaykKNy83IENoZWNraW5nIGNvbW1pdCBj
M2I0OTlhYzU0ODMgKHRjZy9hcm06IFJlc3RyaWN0IGNvbnN0YW50IHBvb2wgZGlzcGxhY2VtZW50
IHRvIDEyIGJpdHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMTkwNDIzMTUzODUzLjE5NzkwLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
Zy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


