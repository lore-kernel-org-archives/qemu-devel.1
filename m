Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA4C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 20:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC69218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 20:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC69218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Pwg-0006bh-GL
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 16:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7Pvv-000643-IA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 16:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7Pvt-0006JH-WE
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 16:06:43 -0400
Resent-Date: Mon, 09 Sep 2019 16:06:43 -0400
Resent-Message-Id: <E1i7Pvt-0006JH-WE@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7Pvt-0006Ig-Md; Mon, 09 Sep 2019 16:06:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568059571; cv=none; d=zoho.com; s=zohoarc; 
 b=TycBzOv4+W5daIpVVWsQlmM/QdLnrlfwIyHiwj3mklJi2gmXZFz+fB/yp0mOUpeVDO4iMW/r4alDqjEANWK73arja2Kb3rR22WJ8yuT8DH25ioxr1L29KtsqvrSpouI/xZhZIkwM3EVcE0tE8iIdz1JQ2ov4XNL/l7Q3YUKUTXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568059571;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=tuGH0LQ778TAi4gDo4l8s45VsND9THMMEuhKW8RYo1s=; 
 b=co7LPw6cdK6G1klTojlVNc8XSF/RLRc+3zfTI2vJ0R0ZBtQtHP+SwO5BpxitfR0PY7BKYxqoZS8AD8ZgEHN8uoVN4DXJ+Eag9PxladQJOq9OxbInfaY93w5eHXkmXvjpMdZt8wEQsQpEWkXSeelkS5pn6nFX/0Z0lakn73OuG+Y=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568059570442914.2141937349784;
 Mon, 9 Sep 2019 13:06:10 -0700 (PDT)
In-Reply-To: <20190909155813.27760-1-laurent@vivier.eu>
Message-ID: <156805956846.9541.9235971279734253457@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Mon, 9 Sep 2019 13:06:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v9 0/9] hw/m68k: add Apple Machintosh
 Quadra 800 machine
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com,
 aurelien@aurel32.net, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkwOTE1NTgxMy4yNzc2
MC0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY5IDAvOV0gaHcvbTY4azog
YWRkIEFwcGxlIE1hY2hpbnRvc2ggUXVhZHJhIDgwMCBtYWNoaW5lCk1lc3NhZ2UtaWQ6IDIwMTkw
OTA5MTU1ODEzLjI3NzYwLTEtbGF1cmVudEB2aXZpZXIuZXUKVHlwZTogc2VyaWVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIx
NjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjM4
MjU0NzYgaHcvbTY4azogZGVmaW5lIE1hY2ludG9zaCBRdWFkcmEgODAwCjExNGE3N2QgaHcvbTY4
azogYWRkIGEgZHVtbXkgU1dJTSBmbG9wcHkgY29udHJvbGxlcgpkODQ4MzhmIGh3L202OGs6IGFk
ZCBOdWJ1cyBzdXBwb3J0IGZvciBtYWNmYiB2aWRlbyBjYXJkCjJhYWIxOTkgaHcvbTY4azogYWRk
IE51YnVzIHN1cHBvcnQKMGEzZmNjMSBody9tNjhrOiBhZGQgbWFjZmIgdmlkZW8gY2FyZAowZjZh
YWU2IGh3L202OGs6IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQgZm9yIHZpYQo2MjU0OTk2IGh3
L202OGs6IGFkZCB2aWEgc3VwcG9ydAo0Yjk2YTFlIGRwODM5M3g6IG1hbmFnZSBiaWcgZW5kaWFu
IGJ1cwo4MDc3NGVhIGVzcDogYWRkIHBzZXVkby1ETUEgYXMgdXNlZCBieSBNYWNpbnRvc2gKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvOSBDaGVja2luZyBjb21taXQgODA3NzRlYWQyMmMwIChlc3A6
IGFkZCBwc2V1ZG8tRE1BIGFzIHVzZWQgYnkgTWFjaW50b3NoKQoyLzkgQ2hlY2tpbmcgY29tbWl0
IDRiOTZhMWUzNmJiMSAoZHA4MzkzeDogbWFuYWdlIGJpZyBlbmRpYW4gYnVzKQozLzkgQ2hlY2tp
bmcgY29tbWl0IDYyNTQ5OTY2NmVhMCAoaHcvbTY4azogYWRkIHZpYSBzdXBwb3J0KQpXQVJOSU5H
OiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQg
dXBkYXRpbmc/CiMzOTogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogc3BhY2UgcHJvaGli
aXRlZCBhZnRlciB0aGF0ICcmJicgKGN0eDpXeFcpCiMzODc6IEZJTEU6IGh3L21pc2MvbWFjX3Zp
YS5jOjM0NDoKKyAgICAgICAgaWYgKCEodjFzLT5sYXN0X2IgJiBWSUExQl92UlRDQ2xrKSAmJiAo
cy0+YiAmIFZJQTFCX3ZSVENDbGspKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCA4MTQgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggMy85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzkgQ2hlY2tpbmcg
Y29tbWl0IDBmNmFhZTY1NGZkYyAoaHcvbTY4azogaW1wbGVtZW50IEFEQiBidXMgc3VwcG9ydCBm
b3IgdmlhKQo1LzkgQ2hlY2tpbmcgY29tbWl0IDBhM2ZjYzE1YzA3OSAoaHcvbTY4azogYWRkIG1h
Y2ZiIHZpZGVvIGNhcmQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyks
IGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzUzOiAKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTA0IGxpbmVzIGNoZWNrZWQKClBhdGNo
IDUvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo2LzkgQ2hlY2tpbmcgY29tbWl0IDJhYWIx
OTkwMzJkNiAoaHcvbTY4azogYWRkIE51YnVzIHN1cHBvcnQpCldBUk5JTkc6IGFkZGVkLCBtb3Zl
ZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM4
OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTE4
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo3Lzkg
Q2hlY2tpbmcgY29tbWl0IGQ4NDgzOGYyNGE1ZSAoaHcvbTY4azogYWRkIE51YnVzIHN1cHBvcnQg
Zm9yIG1hY2ZiIHZpZGVvIGNhcmQpCjgvOSBDaGVja2luZyBjb21taXQgMTE0YTc3ZDFiZmM4ICho
dy9tNjhrOiBhZGQgYSBkdW1teSBTV0lNIGZsb3BweSBjb250cm9sbGVyKQpXQVJOSU5HOiBhZGRl
ZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRp
bmc/CiMzNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fybmlu
Z3MsIDUxMCBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KOS85IENoZWNraW5nIGNvbW1pdCAzODI1NDc2MjNkOTggKGh3L202OGs6IGRlZmluZSBNYWNp
bnRvc2ggUXVhZHJhIDgwMCkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShz
KSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojOTY6IApuZXcgZmlsZSBtb2RlIDEw
MDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1MzkgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggOS85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTA5MTU1ODEzLjI3NzYwLTEtbGF1cmVu
dEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


