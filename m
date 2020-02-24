Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A254C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B262080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 10:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B262080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6BPf-0007bP-LZ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 05:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j6BOw-00077l-31
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j6BOu-0002oy-GN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 05:55:49 -0500
Resent-Date: Mon, 24 Feb 2020 05:55:49 -0500
Resent-Message-Id: <E1j6BOu-0002oy-GN@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j6BOu-0002oP-8u; Mon, 24 Feb 2020 05:55:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582541735; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n7oVZPjgqliq9TJ/2LqssDQM7Z1ytfc6RzbGxB+D+ddpqxuPvyEwKY2f71cW2VBX1pwVM5R4L+YS4CrYDnruIOUh7cG6T+tEu4DxODzGjoZyh2hy7mP2zCfgh3g1tk5AsI9Seqhpays6t+6lcM/Z4wJPM7/fUiyboEmXVd65XIo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582541735;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=OR8C8oF/EXgMa0aOXdbMQH0hWoZ17l1ffDYvfaM3rNY=; 
 b=fe3U4iI7U+RJCOPqB2PYfl2gZdqZPK+G9az582M1XMatWKmdHZtF/Fa8SuPxH0sgfwDQ2gRkYYNK5vvYD/7HZfbPIJiW7ssVNb0DXtSQAI3XgSr/UVN1cPS6wOP91Su2sN4TNBZ5MuH2seqR1pRAy04kCMRdNQ1DoDDqW5pbvzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582541733814832.2648883516708;
 Mon, 24 Feb 2020 02:55:33 -0800 (PST)
In-Reply-To: <20200224103406.1894923-1-stefanha@redhat.com>
Subject: Re: [PATCH 0/2] qemu/queue.h: clear linked list pointers on remove
Message-ID: <158254173238.10132.7761755657862330006@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Mon, 24 Feb 2020 02:55:33 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: fam@euphon.net, pbonzini@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIyNDEwMzQwNi4xODk0
OTIzLTEtc3RlZmFuaGFAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAvMl0gcWVtdS9xdWV1ZS5oOiBjbGVhciBs
aW5rZWQgbGlzdCBwb2ludGVycyBvbiByZW1vdmUKTWVzc2FnZS1pZDogMjAyMDAyMjQxMDM0MDYu
MTg5NDkyMy0xLXN0ZWZhbmhhQHJlZGhhdC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjU2YjY1Mjkg
YWlvLXBvc2l4OiByZW1vdmUgY29uZnVzaW5nIFFMSVNUX1NBRkVfUkVNT1ZFKCkKZjkxM2IyNCBx
ZW11L3F1ZXVlLmg6IGNsZWFyIGxpbmtlZCBsaXN0IHBvaW50ZXJzIG9uIHJlbW92ZQoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCBmOTEzYjI0MzBhZDMgKHFlbXUvcXVl
dWUuaDogY2xlYXIgbGlua2VkIGxpc3QgcG9pbnRlcnMgb24gcmVtb3ZlKQpFUlJPUjogZG8gbm90
IHVzZSBhc3NpZ25tZW50IGluIGlmIGNvbmRpdGlvbgojNjU6IEZJTEU6IGluY2x1ZGUvcWVtdS9x
dWV1ZS5oOjMxNDoKKyAgICBpZiAoKChoZWFkKS0+c3FoX2ZpcnN0ID0gZWxtLT5maWVsZC5zcWVf
bmV4dCkgPT0gTlVMTCkgICAgICAgICAgICAgIFwKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgNTkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
CgoyLzIgQ2hlY2tpbmcgY29tbWl0IDU2YjY1MjliMTg5NCAoYWlvLXBvc2l4OiByZW1vdmUgY29u
ZnVzaW5nIFFMSVNUX1NBRkVfUkVNT1ZFKCkpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjI0MTAzNDA2LjE4OTQ5MjMtMS1zdGVmYW5oYUBy
ZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

