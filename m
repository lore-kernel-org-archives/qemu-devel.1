Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86FC606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382B42166E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382B42166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWfA-0001AG-Ee
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hkWas-0006rg-H2
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hkWaq-0001yO-5u
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:34:22 -0400
Resent-Date: Mon, 08 Jul 2019 12:34:21 -0400
Resent-Message-Id: <E1hkWaq-0001yO-5u@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hkWap-0001tT-SK; Mon, 08 Jul 2019 12:34:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562603597; cv=none; d=zoho.com; s=zohoarc; 
 b=GJm0vS2rzZ9fzm7LjbWdzDFpdEmZvsCGeAF94E+nhQtyKmVbHZUWD77xVkYWhBiPy9WMg0L8h/CCBs9eQbcHX/y/fkyzjK7IiCYEVH2vaGaQoPB6cLGPdsvo2xVcnITqXkTKEdM0ybaOGBlyfFDl5wt0kmMvqAvZpgEUnZmZP0k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562603597;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=R9iSp79pwt78qKQIRhKolWKS9M8ZmKFvCPwATKGimXc=; 
 b=UsfLndpVPZ4w/vGZLKMdyEQ2ZsPYZwIK31s3Pm7XYuE5dy9OWi2gP04y2c4DblSgNKVvxg7k+t0rpgexHlttenoK5EuuASOjkat4yYPJKKe30G6aeq93fu6oxYAUotHjix+Uz3dWjjXyCAOK5b4iZZzdLUOkiHi/Iyc0dMijtI4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562603595458331.2448027429275;
 Mon, 8 Jul 2019 09:33:15 -0700 (PDT)
Message-ID: <156260359401.25929.14953771987329923345@c4a48874b076>
In-Reply-To: <20190708144013.83474-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: borntraeger@de.ibm.com
Date: Mon, 8 Jul 2019 09:33:15 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] s390: cpumodel: fix name and description
 for the new vector facility
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
Cc: akrowiak@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwODE0NDAxMy44MzQ3
NC0xLWJvcm50cmFlZ2VyQGRlLmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNzA4MTQ0MDEzLjgzNDc0LTEtYm9ybnRy
YWVnZXJAZGUuaWJtLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRD
SF0gczM5MDogY3B1bW9kZWw6IGZpeCBuYW1lIGFuZCBkZXNjcmlwdGlvbiBmb3IgdGhlIG5ldyB2
ZWN0b3IgZmFjaWxpdHkKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjZmZDQxNTc1YzMgczM5MDogY3B1bW9kZWw6IGZp
eCBuYW1lIGFuZCBkZXNjcmlwdGlvbiBmb3IgdGhlIG5ldyB2ZWN0b3IgZmFjaWxpdHkKCj09PSBP
VVRQVVQgQkVHSU4gPT09CkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMjQ6IEZJTEU6
IHRhcmdldC9zMzkweC9jcHVfZmVhdHVyZXNfZGVmLmluYy5oOjEwNjoKK0RFRl9GRUFUKFZFQ1RP
Ul9QQUNLRURfREVDLCAidnhwIiwgU1RGTCwgMTUyLCAiVmVjdG9yLVBhY2tlZC1EZWNpbWFsLUVu
aGFuY2VtZW50IEZhY2lsaXR5IikKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjQgbGlu
ZXMgY2hlY2tlZAoKQ29tbWl0IDZmZDQxNTc1YzMyNyAoczM5MDogY3B1bW9kZWw6IGZpeCBuYW1l
IGFuZCBkZXNjcmlwdGlvbiBmb3IgdGhlIG5ldyB2ZWN0b3IgZmFjaWxpdHkpIGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3
aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMTkwNzA4MTQ0MDEzLjgzNDc0LTEtYm9ybnRyYWVnZXJAZGUuaWJtLmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


