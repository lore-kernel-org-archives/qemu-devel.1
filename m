Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EAC10F14
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DC4206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DC4206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJIxI-0006FW-95
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJIwe-0005Ya-4T
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 11:04:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJIwc-0007DF-8P
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 11:04:35 -0400
Resent-Date: Sat, 12 Oct 2019 11:04:35 -0400
Resent-Message-Id: <E1iJIwc-0007DF-8P@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJIwc-0007CS-0d
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 11:04:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570892657; cv=none; d=zoho.com; s=zohoarc; 
 b=mp2jCNsAcemAwgr0uZgBF067taAe04hsCVgg0VhZAqmNMmLDlmVGpp5u2XKaRYyMJOfI4hvSshQGcfq55vDnF0h3/x94UyAqBeao+Q3VbK+iClxhioq8kvnY6+N6Jm56u1faBVxj0C0IAOu6DmvKTUOYDdmaZ0xIz59InUelnyo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570892657;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Mcb9falT5P/zzhBokKcx8+4NCumrAhZvFgWhgjyO8Yc=; 
 b=LLhx+SSmc1JYsLeDv7T7clvpH7gJ3DyRrnSFz+fTKuC89T9/+7iHo7aG/E0DFE+SdZEbFV11z4d3S12SuSvJa91jnn3T502MdMAakOYbTqVEayUfzcnib8Cl11OT1he2BVgHCyZ2IjbZSFKA4t5/6m2zh76GWyp5dC+swo6EjS4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570892656368321.5811850315049;
 Sat, 12 Oct 2019 08:04:16 -0700 (PDT)
In-Reply-To: <1570863638-22272-1-git-send-email-cathy.zhang@intel.com>
Subject: Re: [PATCH 0/3] Add CPU model for intel processor Cooper Lake
Message-ID: <157089265511.19705.15924275646599772449@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cathy.zhang@intel.com
Date: Sat, 12 Oct 2019 08:04:16 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, cathy.zhang@intel.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcwODYzNjM4LTIyMjcyLTEt
Z2l0LXNlbmQtZW1haWwtY2F0aHkuemhhbmdAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVs
b3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMC8zXSBBZGQgQ1BVIG1v
ZGVsIGZvciBpbnRlbCBwcm9jZXNzb3IgQ29vcGVyIExha2UKVHlwZTogc2VyaWVzCk1lc3NhZ2Ut
aWQ6IDE1NzA4NjM2MzgtMjIyNzItMS1naXQtc2VuZC1lbWFpbC1jYXRoeS56aGFuZ0BpbnRlbC5j
b20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCmMxNmE3NGYgaTM4NjogQWRkIG5ldyBDUFUgbW9kZWwgQ29vcGVybGFr
ZQpjNzBiZGQwIGkzODY6IEFkZCBtYWNybyBmb3Igc3RpYnAKMDczYWJkMyBpMzg2OiBBZGQgTVNS
IGZlYXR1cmUgYml0IGZvciBNRFMtTk8KCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2lu
ZyBjb21taXQgMDczYWJkMzY3MTkxIChpMzg2OiBBZGQgTVNSIGZlYXR1cmUgYml0IGZvciBNRFMt
Tk8pCjIvMyBDaGVja2luZyBjb21taXQgYzcwYmRkMDY2NWYwIChpMzg2OiBBZGQgbWFjcm8gZm9y
IHN0aWJwKQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMjM6IEZJTEU6IHRhcmdl
dC9pMzg2L2NwdS5oOjcyMDoKKyNkZWZpbmUgQ1BVSURfN18wX0VEWF9TVElCUCAgICAgKDFVIDw8
IDI3KSAvKiBTaW5nbGUgVGhyZWFkIEluZGlyZWN0IEJyYW5jaCBQcmVkaWN0b3JzICovCgp0b3Rh
bDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8zIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvMyBDaGVja2luZyBjb21taXQgYzE2YTc0ZjEzOGUxIChp
Mzg2OiBBZGQgbmV3IENQVSBtb2RlbCBDb29wZXJsYWtlKQpFUlJPUjogdHJhaWxpbmcgd2hpdGVz
cGFjZQojNTI6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5jOjI2NDQ6CisgICAgICAgICAgICBDUFVJ
RF83XzBfRUJYX1NNQVAgfCBDUFVJRF83XzBfRUJYX0NMV0IgfCAkCgpFUlJPUjogdHJhaWxpbmcg
d2hpdGVzcGFjZQojNjE6IEZJTEU6IHRhcmdldC9pMzg2L2NwdS5jOjI2NTM6CisgICAgICAgICAg
ICBDUFVJRF83XzBfRURYX1NQRUNfQ1RSTF9TU0JEIHwgQ1BVSURfN18wX0VEWF9BUkNIX0NBUEFC
SUxJVElFUywgJAoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBh
IHNlcGFyYXRlIGxpbmUKIzY3OiBGSUxFOiB0YXJnZXQvaTM4Ni9jcHUuYzoyNjU5OgorICAgICAg
ICAvKiBNaXNzaW5nOiBYU0FWRVMgKG5vdCBzdXBwb3J0ZWQgYnkgc29tZSBMaW51eCB2ZXJzaW9u
cywKCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHNob3VsZCBhbGlnbiB0aGUgKiBvbiBlYWNoIGxp
bmUKIzY4OiBGSUxFOiB0YXJnZXQvaTM4Ni9jcHUuYzoyNjYwOgorICAgICAgICAvKiBNaXNzaW5n
OiBYU0FWRVMgKG5vdCBzdXBwb3J0ZWQgYnkgc29tZSBMaW51eCB2ZXJzaW9ucywKKyAgICAgICAg
ICAgICAgICAqIGluY2x1ZGluZyB2NC4xIHRvIHY0LjEyKS4KCnRvdGFsOiAyIGVycm9ycywgMiB3
YXJuaW5ncywgNjUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8zIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2Rl
OiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9n
cy8xNTcwODYzNjM4LTIyMjcyLTEtZ2l0LXNlbmQtZW1haWwtY2F0aHkuemhhbmdAaW50ZWwuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


