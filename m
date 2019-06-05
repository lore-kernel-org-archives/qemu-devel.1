Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF510C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888EF206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 18:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888EF206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48357 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYavK-0005Us-IN
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 14:46:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYauB-00056M-At
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hYauA-0002fW-2K
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:44:59 -0400
Resent-Date: Wed, 05 Jun 2019 14:44:59 -0400
Resent-Message-Id: <E1hYauA-0002fW-2K@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hYau8-0002Ya-Kv
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 14:44:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559760276; cv=none; d=zoho.com; s=zohoarc; 
	b=AqgiKciVLMkYE6Af0+d1nZ9+DJy7Wqj4RhZYHLi5nCiuB4i3AGk+TtSi6vklzqu+mx+jXfMfi4ZBL7sRmj8JhLR6uNvtUIE6ILm5OMZXB+55Ve78MwBRPODvMAX0/Wxn9AUE16K1zEvpCfG4gy8CVm/yArOJeHxldaxJnjq9HnI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559760276;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=ERg7YxPehJSblByx800uvYAGCS0Xbkjvw4zst0/gOyg=; 
	b=WNkLZzBwKT0oNf8ewEMT24AEUzqZ+PV0iGfk+oR/+cL4U0c11viHqMXUVR9BAsAEk6+SUYv2r+hP4Xb2oGLxy5y+A8ax8rCa+siTaYag7AtmqXv+tVcMMtjUIOuCAaHos427zY8769kXblkkAqQCe6/b+2M4Bu5dY8nVbyzp8k0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559760273653708.3566285580528;
	Wed, 5 Jun 2019 11:44:33 -0700 (PDT)
In-Reply-To: <20190605162326.13896-1-alex.bennee@linaro.org>
Message-ID: <155976027279.32260.12612937992786116413@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Wed, 5 Jun 2019 11:44:33 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH  v1 0/4] softmmu de-macro fix with tests
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYwNTE2MjMyNi4xMzg5
Ni0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNjA1MTYyMzI2LjEzODk2LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIICB2MSAwLzRdIHNv
ZnRtbXUgZGUtbWFjcm8gZml4IHdpdGggdGVzdHMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjlhMmI4ZTYg
dGVzdHMvdGNnL3g4Nl82NDogYWRkIGEgUFZIVk0gY3J0Lm8gZm9yIHg4Nl82NCBzeXN0ZW0gdGVz
dHMKNDk4NDFlZCB0ZXN0cy90Y2c6IGNsZWFuLXVwIFZQQVRIL1RFU1RTIGZvciBpMzg2CmZkMTg4
MmUgdGVzdHMvdGNnOiBiZXR0ZXIgZGV0ZWN0IHRydW5jYXRlZCByZWFkcwoyMTRhMmM5IGNwdXRs
YjogdXNlIHVpbnQ2NF90IGZvciBpbnRlcmltIHZhbHVlcyBmb3IgdW5hbGlnbmVkIGxvYWQKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgMjE0YTJjOTlhODEzIChjcHV0
bGI6IHVzZSB1aW50NjRfdCBmb3IgaW50ZXJpbSB2YWx1ZXMgZm9yIHVuYWxpZ25lZCBsb2FkKQoy
LzQgQ2hlY2tpbmcgY29tbWl0IGZkMTg4MmViZDYwZiAodGVzdHMvdGNnOiBiZXR0ZXIgZGV0ZWN0
IHRydW5jYXRlZCByZWFkcykKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM2NTogRklM
RTogdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vbWVtb3J5LmM6MjczOgorICAgICAgICAgICAg
bWxfcHJpbnRmKCJFcnJvciBAICVwLCBtb3JlIHplcm9zIHRoYW4gZXhwZWN0ZWQ6ICVkLCAlZCwg
JWQsICVkLCAlZCwgJWQsICVkLCAlZCIsCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDg0
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy80
IENoZWNraW5nIGNvbW1pdCA0OTg0MWVkZjdhMWYgKHRlc3RzL3RjZzogY2xlYW4tdXAgVlBBVEgv
VEVTVFMgZm9yIGkzODYpCjQvNCBDaGVja2luZyBjb21taXQgOWEyYjhlNjZkYWJmICh0ZXN0cy90
Y2cveDg2XzY0OiBhZGQgYSBQVkhWTSBjcnQubyBmb3IgeDg2XzY0IHN5c3RlbSB0ZXN0cykKV0FS
TklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBu
ZWVkIHVwZGF0aW5nPwojMjY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGxpbmUgb3Zl
ciA5MCBjaGFyYWN0ZXJzCiM4MjogRklMRTogdGVzdHMvdGNnL3g4Nl82NC9zeXN0ZW0vYm9vdC5T
OjUyOgorICAgICAgIEVMRk5PVEUoWGVuLCBYRU5fRUxGTk9URV9QSFlTMzJfRU5UUlksICAgX0FT
TV9QVFIgX3N0YXJ0KSAgICAvKiBlbnRyeSA9PSB2aXJ0YmFzZSAqLwoKV0FSTklORzogbGluZSBv
dmVyIDgwIGNoYXJhY3RlcnMKIzkwOiBGSUxFOiB0ZXN0cy90Y2cveDg2XzY0L3N5c3RlbS9ib290
LlM6NjA6CisgICAgICAgKiAtIGBlYnhgOiBjb250YWlucyB0aGUgcGh5c2ljYWwgbWVtb3J5IGFk
ZHJlc3Mgd2hlcmUgdGhlIGxvYWRlciBoYXMgcGxhY2VkCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAg
Y2hhcmFjdGVycwojOTI6IEZJTEU6IHRlc3RzL3RjZy94ODZfNjQvc3lzdGVtL2Jvb3QuUzo2MjoK
KyAgICAgICAqIC0gYGNyMGA6IGJpdCAwIChQRSkgbXVzdCBiZSBzZXQuIEFsbCB0aGUgb3RoZXIg
d3JpdGVhYmxlIGJpdHMgYXJlIGNsZWFyZWQuCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojOTQ6IEZJTEU6IHRlc3RzL3RjZy94ODZfNjQvc3lzdGVtL2Jvb3QuUzo2NDoKKyAgICAg
ICAqIC0gYGNzIGA6IG11c3QgYmUgYSAzMi1iaXQgcmVhZC9leGVjdXRlIGNvZGUgc2VnbWVudCB3
aXRoIGEgYmFzZSBvZiDigJgw4oCZCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwoj
OTU6IEZJTEU6IHRlc3RzL3RjZy94ODZfNjQvc3lzdGVtL2Jvb3QuUzo2NToKKyAgICAgICAqICAg
ICAgICAgIGFuZCBhIGxpbWl0IG9mIOKAmDB4RkZGRkZGRkbigJkuIFRoZSBzZWxlY3RvciB2YWx1
ZSBpcyB1bnNwZWNpZmllZC4KCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojOTc6IEZJ
TEU6IHRlc3RzL3RjZy94ODZfNjQvc3lzdGVtL2Jvb3QuUzo2NzoKKyAgICAgICAqICAgICAgICAg
ICAgICAg4oCYMOKAmSBhbmQgYSBsaW1pdCBvZiDigJgweEZGRkZGRkZG4oCZLiBUaGUgc2VsZWN0
b3IgdmFsdWVzIGFyZSBhbGwKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMDI6
IEZJTEU6IHRlc3RzL3RjZy94ODZfNjQvc3lzdGVtL2Jvb3QuUzo3MjoKKyAgICAgICAqICAgICAg
ICAgICAgIEJpdCA4IChURikgbXVzdCBiZSBjbGVhcmVkLiBPdGhlciBiaXRzIGFyZSBhbGwgdW5z
cGVjaWZpZWQuCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTA0OiBGSUxFOiB0
ZXN0cy90Y2cveDg2XzY0L3N5c3RlbS9ib290LlM6NzQ6CisgICAgICAgKiBBbGwgb3RoZXIgcHJv
Y2Vzc29yIHJlZ2lzdGVycyBhbmQgZmxhZyBiaXRzIGFyZSB1bnNwZWNpZmllZC4gVGhlIE9TIGlz
IGluCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTU3OiBGSUxFOiB0ZXN0cy90
Y2cveDg2XzY0L3N5c3RlbS9ib290LlM6MTI3OgorICAgICAgICAvKiBkb24ndCB3b3JyeSBhYm91
dCBzdGFjayBmcmFtZSwgYXNzdW1lIGV2ZXJ0aGluZyBpcyBnYXJiYWdlIHdoZW4gd2UgcmV0dXJu
ICovCgp0b3RhbDogMiBlcnJvcnMsIDggd2FybmluZ3MsIDMxNyBsaW5lcyBjaGVja2VkCgpQYXRj
aCA0LzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNjA1MTYyMzI2LjEzODk2LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


