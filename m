Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF632C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 819B9204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819B9204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg3iz-00084B-K3
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53920)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hg3iT-0007aH-F3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hg3iR-0004iI-Uc
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:55:45 -0400
Resent-Date: Wed, 26 Jun 2019 04:55:45 -0400
Resent-Message-Id: <E1hg3iR-0004iI-Uc@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hg3iR-0004fG-Ln
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:55:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561539320; cv=none; d=zoho.com; s=zohoarc; 
 b=guTEv2i+jrCpDSzB/MlySK1jptK2BGaoT2PwhLY79Q3Xdy5pKE0Ky8TynH3XsxdkzgmgMneyswxMop6j76dykHmLQWLW4/eTk33UQuKge3XOvFobkXYEdePOtEf2avHcEG0YX3RcsPNiaN/Ncg9c/8Kda2bMNynC5sPSuLz09II=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561539320;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=WuzFcPJyiuvMhsOi4I25g1doK0eOXJC/2hM1bOAb5Ts=; 
 b=kwCVMf5tKtxh+vmfXAw27f/ha3/6KGVEcQvzPgknF2wkQFArUxw2gSry7icDbU3AL2Edc6o55akchNyOMNs/hnXCJhq7F9aW+giNtjYjJkQufGeSy36AOyp7qJ+hvveFDjfP2V1YvcIUN9t9cRuLpL3y5COn1ou5/WfC0DXkmgw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561539318923160.59553278855833;
 Wed, 26 Jun 2019 01:55:18 -0700 (PDT)
Message-ID: <156153931798.6332.16615356988111850360@c4a48874b076>
In-Reply-To: <1561528815-4912-1-git-send-email-hang.yuan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: hang.yuan@linux.intel.com
Date: Wed, 26 Jun 2019 01:55:18 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] target/i386: HAX: Enable ROM/ROM device
 memory region support
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
Cc: hang.yuan@linux.intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNTI4ODE1LTQ5MTItMS1n
aXQtc2VuZC1lbWFpbC1oYW5nLnl1YW5AbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2Vy
aWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQg
YmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAxNTYxNTI4ODE1LTQ5MTIt
MS1naXQtc2VuZC1lbWFpbC1oYW5nLnl1YW5AbGludXguaW50ZWwuY29tClR5cGU6IHNlcmllcwpT
dWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSB0YXJnZXQvaTM4NjogSEFYOiBFbmFibGUgUk9N
L1JPTSBkZXZpY2UgbWVtb3J5IHJlZ2lvbiBzdXBwb3J0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBb
bmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzE1NjE1Mjg4MTUtNDkxMi0xLWdpdC1zZW5kLWVtYWls
LWhhbmcueXVhbkBsaW51eC5pbnRlbC5jb20gLT4gcGF0Y2hldy8xNTYxNTI4ODE1LTQ5MTItMS1n
aXQtc2VuZC1lbWFpbC1oYW5nLnl1YW5AbGludXguaW50ZWwuY29tCiAtIFt0YWcgdXBkYXRlXSAg
ICAgIHBhdGNoZXcvMjAxOTA2MjYwMjQ5NDIuMjk3NTgtMS1lYmxha2VAcmVkaGF0LmNvbSAtPiBw
YXRjaGV3LzIwMTkwNjI2MDI0OTQyLjI5NzU4LTEtZWJsYWtlQHJlZGhhdC5jb20KU3dpdGNoZWQg
dG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo5NDU2ZTA5IHRhcmdldC9pMzg2OiBIQVg6IEVuYWJsZSBS
T00vUk9NIGRldmljZSBtZW1vcnkgcmVnaW9uIHN1cHBvcnQKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0
ZW1lbnQKIzMyOiBGSUxFOiB0YXJnZXQvaTM4Ni9oYXgtbWVtLmM6MTc5OgorICAgIGlmIChtZW1v
cnlfcmVnaW9uX2lzX3JvbShtcikgfHwgKG1lbW9yeV9yZWdpb25faXNfcm9tZChtcikpKQpbLi4u
XQorICAgIGVsc2UgaWYgKCFtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikpClsuLi5dCgpFUlJPUjog
Y29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzMzogRklMRTogdGFyZ2V0L2kzODYv
aGF4LW1lbS5jOjE4MDoKK15JZmxhZ3MgfD0gSEFYX1JBTV9JTkZPX1JPTTskCgpFUlJPUjogYnJh
Y2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiMzNDog
RklMRTogdGFyZ2V0L2kzODYvaGF4LW1lbS5jOjE4MToKKyAgICBlbHNlIGlmICghbWVtb3J5X3Jl
Z2lvbl9pc19yYW0obXIpKQpbLi4uXQoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdzLCAxOSBs
aW5lcyBjaGVja2VkCgpDb21taXQgOTQ1NmUwOTVmYWU5ICh0YXJnZXQvaTM4NjogSEFYOiBFbmFi
bGUgUk9NL1JPTSBkZXZpY2UgbWVtb3J5IHJlZ2lvbiBzdXBwb3J0KSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBj
b2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8xNTYxNTI4ODE1LTQ5MTItMS1naXQtc2VuZC1lbWFpbC1oYW5nLnl1YW5AbGludXguaW50
ZWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


