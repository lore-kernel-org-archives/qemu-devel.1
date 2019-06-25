Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B4AC48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5D4208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5D4208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33938 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoRL-0001rV-Ma
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hfoPy-0000YA-Lm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hfoPw-00089L-SZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 12:35:38 -0400
Resent-Date: Tue, 25 Jun 2019 12:35:38 -0400
Resent-Message-Id: <E1hfoPw-00089L-SZ@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hfoPw-00088k-JX; Tue, 25 Jun 2019 12:35:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561480497; cv=none; d=zoho.com; s=zohoarc; 
 b=FnkpOuKB1+lhnhZpYKMbcLDo4jtmgwtbdTrHziUCHTPYeeDsLEf1/C8gxdPwdexqvN8oOClH7PUBZgOck+F4ddqcCn4KE35Akizigb5+//nQDxyGJaA5RRe+9N+KEbVCPH+YuVHW/3zmn08YZ0OCNpVGWb+6Rg7gv+LuaMjZJHc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561480497;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=nNv/F3UtR3DkmDHXQCkDHRx64dhTFSQ3kiIocrSIdGw=; 
 b=Iw0lJMf7zd2bIR/6y4/AXlpWGnoB5TcE/kifO3/ck+gBPc0sItpJ0AiR3HkPgDtFD4nrC/rZcbvNowjouE4gClaH4L+y3FVbsTQxJRprHq7rtdS01LwhB1EuouJ5tDKckZbWVJIAI9q0X0AijQn5qT1wPLUavvtEpq2P42nFxoQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561480496400176.43585904483007;
 Tue, 25 Jun 2019 09:34:56 -0700 (PDT)
Message-ID: <156148049495.4374.2975977607094009414@c4a48874b076>
In-Reply-To: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: walling@linux.ibm.com
Date: Tue, 25 Jun 2019 09:34:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH v5 0/2] Guest Support for DIAGNOSE 0x318
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
Cc: david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNDc1ODI5LTE5MjAyLTEt
Z2l0LXNlbmQtZW1haWwtd2FsbGluZ0BsaW51eC5pYm0uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVs
b3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY1
IDAvMl0gR3Vlc3QgU3VwcG9ydCBmb3IgRElBR05PU0UgMHgzMTgKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDE1NjE0NzU4MjktMTkyMDItMS1naXQtc2VuZC1lbWFpbC13YWxsaW5nQGxpbnV4Lmli
bS5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8v
Z2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRj
aGV3LzE1NjE0NzU4MjktMTkyMDItMS1naXQtc2VuZC1lbWFpbC13YWxsaW5nQGxpbnV4LmlibS5j
b20gLT4gcGF0Y2hldy8xNTYxNDc1ODI5LTE5MjAyLTEtZ2l0LXNlbmQtZW1haWwtd2FsbGluZ0Bs
aW51eC5pYm0uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMmNkNjAyMSBzMzkw
OiBkaWFnbm9zZSAzMTggaW5mbyByZXNldCBhbmQgbWlncmF0aW9uIHN1cHBvcnQKZjAxNzg1YiBz
MzkwL2t2bTogaGVhZGVyIHN5bmMgZm9yIGRpYWczMTgKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
MiBDaGVja2luZyBjb21taXQgZjAxNzg1YjkwMzEwIChzMzkwL2t2bTogaGVhZGVyIHN5bmMgZm9y
IGRpYWczMTgpCjIvMiBDaGVja2luZyBjb21taXQgMmNkNjAyMWI2ZDJhIChzMzkwOiBkaWFnbm9z
ZSAzMTggaW5mbyByZXNldCBhbmQgbWlncmF0aW9uIHN1cHBvcnQpCldBUk5JTkc6IGFkZGVkLCBt
b3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8K
IzM3OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBhZGRpbmcgYSBsaW5lIHdpdGhvdXQg
bmV3bGluZSBhdCBlbmQgb2YgZmlsZQojMTY1OiBGSUxFOiBody9zMzkweC9kaWFnMzE4Lmg6Mzg6
CisjZW5kaWYgLyogSFdfRElBRzMxOF9IICovCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3Rl
cnMKIzI4NTogRklMRTogdGFyZ2V0L3MzOTB4L2NwdV9mZWF0dXJlcy5jOjEzMToKKyAgICBGRUFU
X0lOSVQoImRpYWczMTgiLCBTMzkwX0ZFQVRfVFlQRV9TQ0xQX0JZVEVfMTM0LCAwLCAiQ29udHJv
bCBwcm9ncmFtIG5hbWUgYW5kIHZlcnNpb24gY29kZXMiKSwKCnRvdGFsOiAyIGVycm9ycywgMSB3
YXJuaW5ncywgMzAwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMiBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMTU2MTQ3NTgyOS0xOTIwMi0xLWdpdC1zZW5kLWVtYWlsLXdhbGxpbmdAbGludXguaWJtLmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


