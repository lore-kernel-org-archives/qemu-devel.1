Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F12C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F83B21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F83B21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS4Pj-0001aT-Lv
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 14:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iS4OF-0000af-9Q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iS4OD-0002sG-2s
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:21:18 -0500
Resent-Date: Tue, 05 Nov 2019 14:21:18 -0500
Resent-Message-Id: <E1iS4OD-0002sG-2s@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iS4OC-0002og-RA; Tue, 05 Nov 2019 14:21:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572981612; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UgAYfejr3fDVbo8L7rVv3ShvbjcrSeXpwTR6dXZm7OHpa4WAG4T6j7lavuPgVqSBMpARBeosIAMK/OEW4+rjJJmMyhj2e1xaXUGW9xeFkkHO2LLQd4hbiOfBP8948IxsrVdppq1/RXMpqX7hwgHFPBBkoJb92JGt5J6vI5k/W4s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572981612;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TKqHNauIz3QKxpJho757GRjU1wyQS+vDXhCWV2Kk3eE=; 
 b=GyG4nz3vWbbjEgOBZ6+ArmRAp+534/5aQolivw7aHofmnurtRusRbRiT8Sg+LrUoOI190q2jmQ9yDc1XFhfxqLycBOar1u5II3zbQFoAtxIzCFHDDoKYSeoRurP/glDzL5J7wuTgYK0v8PHAcu1QnIEzLNbMqP5w3JlzSg6hl2I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157298161033387.53528998268598;
 Tue, 5 Nov 2019 11:20:10 -0800 (PST)
In-Reply-To: <20191105175010.2591-1-laurent@vivier.eu>
Subject: Re: [Xen-devel] [PULL v2 0/3] Trivial branch patches
Message-ID: <157298160814.27285.16893877491189017648@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 5 Nov 2019 11:20:10 -0800 (PST)
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, ehabkost@redhat.com,
 paul@xen.org, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 claudio.fontana@huawei.com, qemu-devel@nongnu.org, chouteau@adacore.com,
 laurent@vivier.eu, xen-devel@lists.xenproject.org, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, crosa@redhat.com,
 anthony.perard@citrix.com, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNTE3NTAxMC4yNTkx
LTEtbGF1cmVudEB2aXZpZXIuZXUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtYZW4tZGV2ZWxdIFtQVUxMIHYyIDAvM10gVHJpdmlhbCBicmFu
Y2ggcGF0Y2hlcwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTExMDUxNzUwMTAuMjU5MS0x
LWxhdXJlbnRAdml2aWVyLmV1Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0OWE1NWY3IGdsb2JhbDogU3F1YXNoICd0
aGUgdGhlJwpjMGI1NTEzIGh3L21pc2MvZ3JsaWJfYWhiX2FwYl9wbnA6IEZpeCA4LWJpdCBhY2Nl
c3NlcwplYjQzMzk1IGh3L21pc2MvZ3JsaWJfYWhiX2FwYl9wbnA6IEF2b2lkIGNyYXNoIHdoZW4g
d3JpdGluZyB0byBQblAgcmVnaXN0ZXJzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzMgQ2hlY2tp
bmcgY29tbWl0IGViNDMzOTViZjhmMSAoaHcvbWlzYy9ncmxpYl9haGJfYXBiX3BucDogQXZvaWQg
Y3Jhc2ggd2hlbiB3cml0aW5nIHRvIFBuUCByZWdpc3RlcnMpCjIvMyBDaGVja2luZyBjb21taXQg
YzBiNTUxM2Y5NzFhIChody9taXNjL2dybGliX2FoYl9hcGJfcG5wOiBGaXggOC1iaXQgYWNjZXNz
ZXMpCjMvMyBDaGVja2luZyBjb21taXQgNDlhNTVmN2ZlYjE5IChnbG9iYWw6IFNxdWFzaCAndGhl
IHRoZScpCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojMjY6IEZJTEU6IGRpc2Fz
L2xpYnZpeGwvdml4bC9pbnZhbHNldC5oOjEwNToKKyAgLy8gTm90ZSB0aGF0IHRoaXMgZG9lcyBu
b3QgbWVhbiB0aGUgYmFja2luZyBzdG9yYWdlIGlzIGVtcHR5OiBpdCBjYW4gc3RpbGwKCnRvdGFs
OiAxIGVycm9ycywgMCB3YXJuaW5ncywgNTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8zIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDE5MTEwNTE3NTAxMC4yNTkxLTEtbGF1cmVudEB2aXZpZXIuZXUv
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


