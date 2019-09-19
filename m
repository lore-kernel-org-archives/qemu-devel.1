Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0883C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 19:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A637A20717
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 19:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A637A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB2A0-000242-Og
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 15:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iB28Z-0001Lu-Lq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iB28X-0000b0-SB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:30:43 -0400
Resent-Date: Thu, 19 Sep 2019 15:30:43 -0400
Resent-Message-Id: <E1iB28X-0000b0-SB@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iB28X-0000aU-JW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 15:30:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568920521; cv=none; d=zoho.com; s=zohoarc; 
 b=U3LNP96COkC5u3JReZwVRmbFnALFj3T3X0uhQfWW5g9SlxgynrPgvGUR0xBDwb02vCFboBuVVP+1lnuL3Sk69aAfSR4P9/LXYi5Y/2Sfhvv+i9U78+CFw7tgfb7+mQJ/Hf4OHG56IHri6+Z+njd4zlHIT6mOHu0XC8EOuGbddyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568920521;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=xWBEkmjly+oo2hqbyn7OqT1RNkrRIU1EKQslKaLclPY=; 
 b=LbaatMQm9FDu1av6E4XjpBtfk240J2tI/5QM2TwNs13lPSrrxtI/5vxFIu2+dMn/rmEjEe2dB9Z27uyjTe7XkQmL+bP4GIU6mDRDSu9H4qjNAtkk60N/lvVe/dFpyrGDI9LzGKw/vvokHkV6koehR080KbrM/ZGrHwu/OpADhzQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568920519543879.9782293252933;
 Thu, 19 Sep 2019 12:15:19 -0700 (PDT)
In-Reply-To: <20190919020629.26530-1-tao3.xu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] target/i386: Correct extra enter and spaces
 in comment
Message-ID: <156892051830.2125.611112040192372756@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Thu, 19 Sep 2019 12:15:19 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, tao3.xu@intel.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxOTAyMDYyOS4yNjUz
MC0xLXRhbzMueHVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDkxOTAyMDYyOS4yNjUzMC0xLXRhbzMueHVAaW50
ZWwuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHRhcmdldC9pMzg2OiBDb3JyZWN0
IGV4dHJhIGVudGVyIGFuZCBzcGFjZXMgaW4gY29tbWVudApUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKM2Zm
OGY5MCB0YXJnZXQvaTM4NjogQ29ycmVjdCBleHRyYSBlbnRlciBhbmQgc3BhY2VzIGluIGNvbW1l
bnQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwoj
MjM6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5oOjY5ODoKKyNkZWZpbmUgQ1BVSURfODAwMF8wMDA4
X0VCWF9XQk5PSU5WRCAoMVUgPDwgOSkgLyogV3JpdGUgYmFjayBhbmQgZG8gbm90IGludmFsaWRh
dGUgY2FjaGUgKi8KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOSBsaW5lcyBjaGVja2Vk
CgpDb21taXQgM2ZmOGY5MDVjM2IwICh0YXJnZXQvaTM4NjogQ29ycmVjdCBleHRyYSBlbnRlciBh
bmQgc3BhY2VzIGluIGNvbW1lbnQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE5MDIwNjI5
LjI2NTMwLTEtdGFvMy54dUBpbnRlbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


