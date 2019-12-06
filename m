Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D039C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 23:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E9220409
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 23:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E9220409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idNMD-0003md-3Z
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 18:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56300)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1idNLX-0003Mq-Cc
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 18:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1idNLV-000520-NA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 18:49:14 -0500
Resent-Date: Fri, 06 Dec 2019 18:49:14 -0500
Resent-Message-Id: <E1idNLV-000520-NA@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1idNLV-0004mI-Dk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 18:49:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575676138; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AmH8Mzg7pWaYVEzE4knc/JjgZCnz/U9oRW7aaFLkcu4CBSbKEB9IJC96+p2X82+Wb1+iziy34LvGEUGH6fD/0eFLBexvc4HdA9PB227QDtgPgy1J83/Fdz8cy3op6NFMLlIBm9SAdGOzosv40262ZYDj/3xSuajxwFUzQInYVTE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575676138;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=E1jlx6HZE4rmafsjKWjU2SJkYMh4I37w9SK1XsVquGA=; 
 b=OA/FACuChlwaat1dUMe8IHWhiYVzhS32kIlPtoRlMjU+LIp2dHDY8GmBSM+8RsiOwYnCXSO7yFlugO9IMweL99ABkkZUl/CqfqeIxhWyGeJLwaQNMqHzmyQYfCNHx8p4nu0sRWMhNGqjR2RVJ/68e8j3+pokhqQc3fCi+h6fDJ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575676137139446.59853742157395;
 Fri, 6 Dec 2019 15:48:57 -0800 (PST)
In-Reply-To: <1575627817-24625-1-git-send-email-catherine.hecx@gmail.com>
Subject: Re: [PATCH] target/i386: skip kvm_msr_entry_add when kvm_vmx_basic is
 0
Message-ID: <157567613553.744.12283750572800820793@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: catherine.hecx@gmail.com
Date: Fri, 6 Dec 2019 15:48:57 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mtosatti@redhat.com,
 qemu-devel@nongnu.org, catherine.hecx@gmail.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc1NjI3ODE3LTI0NjI1LTEt
Z2l0LXNlbmQtZW1haWwtY2F0aGVyaW5lLmhlY3hAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2Vy
aWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQg
YmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHRhcmdldC9pMzg2
OiBza2lwIGt2bV9tc3JfZW50cnlfYWRkIHdoZW4ga3ZtX3ZteF9iYXNpYyBpcyAwClR5cGU6IHNl
cmllcwpNZXNzYWdlLWlkOiAxNTc1NjI3ODE3LTI0NjI1LTEtZ2l0LXNlbmQtZW1haWwtY2F0aGVy
aW5lLmhlY3hAZ21haWwuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjk4NzQ0MWYgdGFyZ2V0L2kzODY6IHNraXAga3ZtX21z
cl9lbnRyeV9hZGQgd2hlbiBrdm1fdm14X2Jhc2ljIGlzIDAKCj09PSBPVVRQVVQgQkVHSU4gPT09
CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzM4OiBGSUxFOiB0YXJn
ZXQvaTM4Ni9rdm0uYzoyNjM3OgorXkkvKiBPbmx5IGFkZCB0aGUgZW50cnkgd2hlbiBob3N0IHN1
cHBvcnRzIGl0ICovJAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNCBsaW5lcyBjaGVj
a2VkCgpDb21taXQgOTg3NDQxZjc0MjRjICh0YXJnZXQvaTM4Njogc2tpcCBrdm1fbXNyX2VudHJ5
X2FkZCB3aGVuIGt2bV92bXhfYmFzaWMgaXMgMCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3NTYy
NzgxNy0yNDYyNS0xLWdpdC1zZW5kLWVtYWlsLWNhdGhlcmluZS5oZWN4QGdtYWlsLmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


