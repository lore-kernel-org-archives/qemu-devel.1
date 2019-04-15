Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C170C10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3C1206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3C1206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG0Pv-0006jK-Hv
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 08:08:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0P9-0006Q5-7q
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0P8-0006VO-5H
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:08:07 -0400
Resent-Date: Mon, 15 Apr 2019 08:08:07 -0400
Resent-Message-Id: <E1hG0P8-0006VO-5H@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hG0P7-0006VC-TW
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:08:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555330053; cv=none; d=zoho.com; s=zohoarc; 
	b=CIuL0FHL4qsvLrSUdDMtj7kGwKIR5HJ3mrQvR2oVtzKAR0Mnw/+njHamd+Y16qG3CPvVNhrAj5c5LfCBt0kvfzHmKu6QNGfClTB1l7SJm/QrIOXzKOMJRhi7OKEEvE5H6gBG5MnM3SJuBKe1lC7Ou+YpocW9nk/e7ZHzZhaYnAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555330053;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=MjnDdoMqXLRgKAwUhNnxen7yEJ0rMnkUriHWwXoUx8g=; 
	b=GNwhNiVRyYL9ydeAou9UMKKkOCBUZ7wNz9HaT+lz27x8fBYYooU/Eysxa1ED6hc1aFMi7PimLxRMIbROwWfQxdJL3npIr5D4U5q2XMowgX3EYkkG2x2PRXz3bdKsAMviPsXO4F1FusiHSUi9sjdIygmmvurNsnLScLol1d1lk4Q=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555330047348656.0911302184746;
	Mon, 15 Apr 2019 05:07:27 -0700 (PDT)
Message-ID: <155533004608.29694.13253782465233935680@76452e4e88f2>
In-Reply-To: <20190415120205.2221-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Mon, 15 Apr 2019 05:07:27 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2] slirp: Gcc 9 -O3 fix
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
Cc: fam@euphon.net, jan.kiszka@siemens.com, qemu-devel@nongnu.org,
	samuel.thibault@gnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415120727.Pzoxhd0sWIWxsON0wCTP0pyNUk5kEEMLBPhHSzEzXBA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNTEyMDIwNS4yMjIx
LTEtZGdpbGJlcnRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MTUxMjAyMDUuMjIyMS0xLWRnaWxiZXJ0QHJl
ZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2Ml0gc2xpcnA6IEdjYyA5IC1P
MyBmaXgKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNDE1MTIwMjA1LjIyMjEtMS1kZ2lsYmVydEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MTUxMjAyMDUuMjIyMS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4MWU0ZDlkZDgzIHNsaXJwOiBHY2MgOSAtTzMg
Zml4Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiMyMzogRklMRTogc2xpcnAvc3JjL3NvY2tldC5jOjE4NDoKK15JYXNzZXJ0KHNv
cHJlcHJidWYoc28sIGlvdiwgJm4pICE9IDApOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQg
bmV2ZXIgdXNlIHRhYnMKIzMxOiBGSUxFOiBzbGlycC9zcmMvc29ja2V0LmM6MjYwOgorXklhc3Nl
cnQoc2l6ZSA+IDApOyQKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTUgbGluZXMgY2hl
Y2tlZAoKQ29tbWl0IDgxZTRkOWRkODNlMCAoc2xpcnA6IEdjYyA5IC1PMyBmaXgpIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwNDE1MTIwMjA1LjIyMjEtMS1kZ2lsYmVydEByZWRoYXQuY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


