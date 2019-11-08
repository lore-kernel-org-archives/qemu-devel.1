Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB98FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8EC206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8EC206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7g4-0002y3-MI
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iT7c7-0000rY-1X
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:00:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iT7c5-0004h0-Hi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:59:58 -0500
Resent-Date: Fri, 08 Nov 2019 11:59:58 -0500
Resent-Message-Id: <E1iT7c5-0004h0-Hi@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iT7c5-0004gf-A4; Fri, 08 Nov 2019 11:59:57 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573232380; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PMEBcQXmNdtBZvOAcP/UPGdm5BgzNM7SbcRvTfTjMnnFPQnvAuclhm1rbtP6VffrufURreZPCDQpzRUDzII3besePz06jIn/8VmTfBdQ3pJh1n3sMtqwvALdN+Zo3tZBAyQsbi9opM6m13Hrz/z9xETv5XR4x9qU1ssNXYYSJBU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573232380;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=M0OnuRU8wPv9WzfXkJikJlZaYEPpdBo4BEuFTfyN3ls=; 
 b=QNdIARQynhzYb84xT3yupU3fouRqoYllpRkImrSp+LU5FL+LnQxhfTQd5bhF68NB7HFjD+QWLboPU1GTlDSgijcMGP2cyHiiN6RawaAB5jmJwbd8L2FCe4b9KUmLYjT9NyAjnOafi1u/M9jfSixa2CCnL1SZnvaLdVB/WmxniqM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573232378723101.94259723248035;
 Fri, 8 Nov 2019 08:59:38 -0800 (PST)
In-Reply-To: <20191108110714.7475-1-david@redhat.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
Message-ID: <157323237682.7743.17902706717978849559@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@redhat.com
Date: Fri, 8 Nov 2019 08:59:38 -0800 (PST)
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
Cc: thuth@redhat.com, berrange@redhat.com, frankja@linux.ibm.com,
 david@redhat.com, cohuck@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mimu@linux.ibm.com,
 jdenemar@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwODExMDcxNC43NDc1
LTEtZGF2aWRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYxIDAvMl0gczM5MHgvY3B1bW9kZWw6IEludHJvZHVj
ZSAiYmVzdCIgbW9kZWwgdmFyaWFudHMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMTA4
MTEwNzE0Ljc0NzUtMS1kYXZpZEByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFn
IHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMTkxMTA4MTI0MjE5LjMxMzQ4LTEtZWRnYXIuaWdsZXNp
YXNAZ21haWwuY29tIC0+IHBhdGNoZXcvMjAxOTExMDgxMjQyMTkuMzEzNDgtMS1lZGdhci5pZ2xl
c2lhc0BnbWFpbC5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDE5MTEwODE1MDEy
My4xMjIxMy0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkxMTA4
MTUwMTIzLjEyMjEzLTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEg
bmV3IGJyYW5jaCAndGVzdCcKNDE0YTYzZiBzMzkweC9jcHVtb2RlbDogSW50cm9kdWNlICJiZXN0
IiBtb2RlbCB2YXJpYW50cwo0MGMwNzE5IHMzOTB4L2NwdW1vZGVsczogRmFjdG9yIG91dCBDUFUg
ZmVhdHVyZSBkZXBlbmRlbmNpZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMiBDaGVja2luZyBj
b21taXQgNDBjMDcxOTRjNzIwIChzMzkweC9jcHVtb2RlbHM6IEZhY3RvciBvdXQgQ1BVIGZlYXR1
cmUgZGVwZW5kZW5jaWVzKQoyLzIgQ2hlY2tpbmcgY29tbWl0IDQxNGE2M2ZlNDAxZCAoczM5MHgv
Y3B1bW9kZWw6IEludHJvZHVjZSAiYmVzdCIgbW9kZWwgdmFyaWFudHMpCkVSUk9SOiBsaW5lIG92
ZXIgOTAgY2hhcmFjdGVycwojMTY3OiBGSUxFOiB0YXJnZXQvczM5MHgvY3B1X21vZGVscy5jOjEz
MTE6CisgICAgeGNjLT5kZXNjID0gZ19zdHJkdXBfcHJpbnRmKCIlcyB3aXRoIGJlc3QgZmVhdHVy
ZXMgc3VwcG9ydGVkIGJ5IHRoZSBhY2NlbGVyYXRvciBpbiB0aGUgY3VycmVudCBob3N0IiwKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTUyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMiBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1h
bmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMDgxMTA3MTQuNzQ3NS0xLWRhdmlkQHJlZGhhdC5j
b20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


