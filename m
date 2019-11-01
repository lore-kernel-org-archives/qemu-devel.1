Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C50CA9ECB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 02:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D532067D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 02:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D532067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQMWd-0004eT-74
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 22:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iQMVz-0004Cv-QH
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 22:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iQMVy-0005bp-7o
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 22:18:15 -0400
Resent-Date: Thu, 31 Oct 2019 22:18:15 -0400
Resent-Message-Id: <E1iQMVy-0005bp-7o@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iQMVy-0005DG-07
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 22:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572574663; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PQ/WHWMMNvEMVFCCj8LTrpEMj+xFYyuGm4/4ofu8WejTfa/JiCf/3nBt9yzkl/InFJw/LhTJLq85+ei0kpvHz01/0WzwfjmOpRzaukXw9ccbdwaauTcKM9K5ZJcvDItIu9Q4yoFdhgYEQU/8WhEqB1Y80I+CIw5dfmVT+MFRs/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572574663;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1j4RB9ZKnOIvKMqp2b3hOsucL2go5N9i/3U5GtvA81s=; 
 b=Bn6ptdAjXHp/HS023ILz7WRdfdIhwd8aeEbmQe5ixJKWpfHByYxLHyEMwsQVJXA2lntQJeqIo4XETjlf2cg0YRjLzlQKiV93/gtGaIgQxyo/+GVN/j5pqSGnhTLr6YCu9AfTq4xCPSMQ8E7qwAq6pdRZTUWj1ks3ctekJKihqNI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157257466237639.411143469050785;
 Thu, 31 Oct 2019 19:17:42 -0700 (PDT)
In-Reply-To: <20191101014528.14505-1-richardw.yang@linux.intel.com>
Subject: Re: [PATCH] target/i386: return directly from hyperv_init_vcpu() if
 hyperv not enabled
Message-ID: <157257466091.11413.1382425269622176860@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richardw.yang@linux.intel.com
Date: Thu, 31 Oct 2019 19:17:42 -0700 (PDT)
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
Cc: ehabkost@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 richardw.yang@linux.intel.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwMTAxNDUyOC4xNDUw
NS0xLXJpY2hhcmR3LnlhbmdAbGludXguaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHRhcmdldC9pMzg2OiByZXR1
cm4gZGlyZWN0bHkgZnJvbSBoeXBlcnZfaW5pdF92Y3B1KCkgaWYgaHlwZXJ2IG5vdCBlbmFibGVk
ClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTEwMTAxNDUyOC4xNDUwNS0xLXJpY2hhcmR3
LnlhbmdAbGludXguaW50ZWwuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVz
IFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmQ3NjUyYjQgdGFyZ2V0L2kzODY6IHJldHVybiBk
aXJlY3RseSBmcm9tIGh5cGVydl9pbml0X3ZjcHUoKSBpZiBoeXBlcnYgbm90IGVuYWJsZWQKCj09
PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykK
CnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOSBsaW5lcyBjaGVja2VkCgpDb21taXQgZDc2
NTJiNGYyOGZmICh0YXJnZXQvaTM4NjogcmV0dXJuIGRpcmVjdGx5IGZyb20gaHlwZXJ2X2luaXRf
dmNwdSgpIGlmIGh5cGVydiBub3QgZW5hYmxlZCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEx
MDEwMTQ1MjguMTQ1MDUtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


