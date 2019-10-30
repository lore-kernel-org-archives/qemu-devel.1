Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1088CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 07:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30A820874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 07:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30A820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPi83-0001lS-Ul
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 03:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iPi79-00019L-4k
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 03:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iPi77-0004OR-Jq
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 03:09:54 -0400
Resent-Date: Wed, 30 Oct 2019 03:09:54 -0400
Resent-Message-Id: <E1iPi77-0004OR-Jq@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iPi77-0004Nt-Bs
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 03:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572419373; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L8v/2GluMLDn2f9RBMGNJ+KkW8MhsKL0Tjw9JOFfYgO83j9JFCeU0QxekVlFQEWTWR4ycJHb70D1LCc+vuE71T4/SQHAQM0LBVOlLTJLIdAfNayL3pCoWgRTxIFN7blp8ZompqL6FnbtBq6Ubw0dEk2n9hFHE2FAmj/LC+3rOaI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572419373;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=nDIH4YSEqTymEz4cd/K1NBDTA0W+hSyr+M/hIbWRc2I=; 
 b=m5wyc9dorCy2AXUXRY9XUSbc3Mr+VZ+JWzmMVMxfHMjdXbdx9VN4/jInIZmUItrtF2ex10jHKgVC6kZtWWjoEf4njoMo7w5Yqi4KvutstknKvEepIrFqFT+bkwmQ7l0Tf0Y2o0jO+aXalsiLldbIg+XUaN3hmEjxBv8UCAffiPQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572419370559707.2315174705834;
 Wed, 30 Oct 2019 00:09:30 -0700 (PDT)
In-Reply-To: <1572413233-27015-1-git-send-email-luwei.kang@intel.com>
Subject: Re: [PATCH v1] target/i386: set the CPUID level to 0x14 on old
 machine-type
Message-ID: <157241936935.22267.15655251672835552404@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luwei.kang@intel.com
Date: Wed, 30 Oct 2019 00:09:30 -0700 (PDT)
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, luwei.kang@intel.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcyNDEzMjMzLTI3MDE1LTEt
Z2l0LXNlbmQtZW1haWwtbHV3ZWkua2FuZ0BpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MV0gdGFyZ2V0L2kzODY6
IHNldCB0aGUgQ1BVSUQgbGV2ZWwgdG8gMHgxNCBvbiBvbGQgbWFjaGluZS10eXBlClR5cGU6IHNl
cmllcwpNZXNzYWdlLWlkOiAxNTcyNDEzMjMzLTI3MDE1LTEtZ2l0LXNlbmQtZW1haWwtbHV3ZWku
a2FuZ0BpbnRlbC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM1NzM2ZmUgdGFyZ2V0L2kzODY6IHNldCB0aGUg
Q1BVSUQgbGV2ZWwgdG8gMHgxNCBvbiBvbGQgbWFjaGluZS10eXBlCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpFUlJPUjogRXJyb3IgbWVzc2FnZXMgc2hvdWxkIG5vdCBjb250YWluIG5ld2xpbmVzCiMz
NjogRklMRTogdGFyZ2V0L2kzODYvY3B1LmM6NTQ0ODoKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiYnkgXCItY3B1IC4uLiwraW50ZWwtcHQsbGV2ZWw9MHgxNFwiXG4iKTsKCnRvdGFsOiAx
IGVycm9ycywgMCB3YXJuaW5ncywgMTQgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGM1NzM2ZmU5NWQz
ZiAodGFyZ2V0L2kzODY6IHNldCB0aGUgQ1BVSUQgbGV2ZWwgdG8gMHgxNCBvbiBvbGQgbWFjaGlu
ZS10eXBlKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTcyNDEzMjMzLTI3MDE1LTEtZ2l0LXNlbmQt
ZW1haWwtbHV3ZWkua2FuZ0BpbnRlbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


