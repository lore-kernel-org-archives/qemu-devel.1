Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2293C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BA9206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 12:42:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BA9206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdZuk-0004H5-D9
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 08:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdZtI-0003jd-6c
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdZt9-0004C6-NN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:40:35 -0400
Resent-Date: Wed, 19 Jun 2019 08:40:32 -0400
Resent-Message-Id: <E1hdZt9-0004C6-NN@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdZt7-0003uq-9s
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 08:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560947967; cv=none; d=zoho.com; s=zohoarc; 
 b=Le/RBqW9gEG7pHITzD1BbBUIDOJaV0Naj2KP36U91XfyDXLZ5kiKysoCCs2cuTXgx4Vjzq3gyepIAag+96q6MQNpBvvgmWNDmuLu6WUugpBCYjDgz3cgDUZkBhzgcVwwXqCh8LCsflQlun9EBDWwFCu/WxyWvN9+w/+VDnyniTU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560947967;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=5gEysdriYcDu0Pj3suySYT5b+/pPhbhEGYUx3jQ+Z/k=; 
 b=XWj+fvLSvkWjI6vD+CdxjeE95xMaHVQoX2PH4Z57xG69cqmU0yQ+kxzM7YFt8F9kmm8bhbmn1zY+wTZDaCNo2aGgLc6La6KKvOrSBbQaX4R6g48Q3VA8qkEUeMv+BJGHnHf11SpmpgnO9DeiNLPKN9D87B3oXJuTvrCMfgqiGOo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560947965368263.27441975720126;
 Wed, 19 Jun 2019 05:39:25 -0700 (PDT)
In-Reply-To: <20190619123042.4822-1-kpouget@redhat.com>
Message-ID: <156094796445.27226.1027934106005620089@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kpouget@redhat.com
Date: Wed, 19 Jun 2019 05:39:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC] spice-core: allow setting properties from QMP
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxOTEyMzA0Mi40ODIy
LTEta3BvdWdldEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1JGQ10gc3BpY2UtY29yZTogYWxsb3cg
c2V0dGluZyBwcm9wZXJ0aWVzIGZyb20gUU1QClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5
MDYxOTEyMzA0Mi40ODIyLTEta3BvdWdldEByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDYxOTEyMzA0Mi40
ODIyLTEta3BvdWdldEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxOTA2MTkxMjMwNDIuNDgyMi0x
LWtwb3VnZXRAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjUxODA5
ZmQ5OWQgc3BpY2UtY29yZTogYWxsb3cgc2V0dGluZyBwcm9wZXJ0aWVzIGZyb20gUU1QCgo9PT0g
T1VUUFVUIEJFR0lOID09PQpFUlJPUjogb3BlbiBicmFjZSAneycgZm9sbG93aW5nIGZ1bmN0aW9u
IGRlY2xhcmF0aW9ucyBnbyBvbiB0aGUgbmV4dCBsaW5lCiM2MTogRklMRTogdWkvc3BpY2UtY29y
ZS5jOjUwNjoKK3ZvaWQgcW1wX3NldF9zcGljZShjb25zdCBjaGFyICpwcm9wZXJ0eSwgY29uc3Qg
Y2hhciAqdmFsdWUsIEVycm9yICoqZXJycCkgewoKRVJST1I6IEVycm9yIG1lc3NhZ2VzIHNob3Vs
ZCBub3QgY29udGFpbiBuZXdsaW5lcwojNjc6IEZJTEU6IHVpL3NwaWNlLWNvcmUuYzo1MTI6Cisg
ICAgICAgICAgICAgICAgICAgICAgICJ0aGUgcHJvcGVydHkgJXM9JXNcbiIsIGludmFsaWRfY29k
ZWNzLCBwcm9wZXJ0eSwgdmFsdWUpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMK
IzcwOiBGSUxFOiB1aS9zcGljZS1jb3JlLmM6NTE1OgorICAgICAgICBlcnJvcl9zZXRnKGVycnAs
ICJTZXR0aW5nIGFuIHVua25vd24gc3BpY2UgcHJvcGVydHkgKCVzPSVzKVxuIiwgcHJvcGVydHks
IHZhbHVlKTsKCkVSUk9SOiBFcnJvciBtZXNzYWdlcyBzaG91bGQgbm90IGNvbnRhaW4gbmV3bGlu
ZXMKIzcwOiBGSUxFOiB1aS9zcGljZS1jb3JlLmM6NTE1OgorICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJTZXR0aW5nIGFuIHVua25vd24gc3BpY2UgcHJvcGVydHkgKCVzPSVzKVxuIiwgcHJvcGVy
dHksIHZhbHVlKTsKCkVSUk9SOiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFs
OiA0IGVycm9ycywgMSB3YXJuaW5ncywgNDQgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDUxODA5ZmQ5
OWQ3NiAoc3BpY2UtY29yZTogYWxsb3cgc2V0dGluZyBwcm9wZXJ0aWVzIGZyb20gUU1QKSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYxOTEyMzA0Mi40ODIyLTEta3BvdWdldEByZWRoYXQuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


