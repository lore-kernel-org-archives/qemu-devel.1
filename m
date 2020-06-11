Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B14222072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 06:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14222072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjH8h-0007Ff-UD
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 02:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjH89-0006in-FP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:56:05 -0400
Resent-Date: Thu, 11 Jun 2020 02:56:05 -0400
Resent-Message-Id: <E1jjH89-0006in-FP@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjH86-00069e-JM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 02:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591858542; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dcXoZvBq/BDhAhXlNasvchfJNI/OrLoY2BQnxmbN3weLxULiEJ9bAXvmk2PDQPL+svf8ZT9iOxoZdlxIC4eqUwnivvuwzAZPL8dsKh7ZPR+qGzxnF+qRC9p8USS7Ykmow0Sfh0zPJiIsdvsoqTJ/EM7OYWrCN8mTkjatVC4My50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591858542;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gIm3rXCb+dMVP8pgaK1auC9kyzD36MF/R+1Zgr2zxII=; 
 b=H80n6IjqBrSB9x3gS5eqbQjbCOXf2ykmPwKSHbUZQ0jDJV8nIx0YU0tOrkZnmNOggN/voEMzVuVZwmvv0RJSySoF4dgAd+/ixwfnvbRlm8uPUm8Adb9tgxRiJuSJdwFg3Ji64W9pySHR6U5+2cb8rAx6H55UGNOLc9RlP4zh67k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591858540835360.7063060973535;
 Wed, 10 Jun 2020 23:55:40 -0700 (PDT)
Message-ID: <159185853937.21115.15711617526734353193@45ef0f9c86ae>
In-Reply-To: <20200611055651.13784-1-alxndr@bu.edu>
Subject: Re: [RFC PATCH 0/3] fuzz: add generic fuzzer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Wed, 10 Jun 2020 23:55:40 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 02:55:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: darren.kenny@oracle.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMTA1NTY1MS4xMzc4
NC0xLWFseG5kckBidS5lZHUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21l
IGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1h
dGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNjExMDU1NjUxLjEzNzg0LTEtYWx4bmRyQGJ1LmVkdQpT
dWJqZWN0OiBbUkZDIFBBVENIIDAvM10gZnV6ejogYWRkIGdlbmVyaWMgZnV6emVyClR5cGU6IHNl
cmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNo
ZXcvMjAyMDA2MTEwNTU2NTEuMTM3ODQtMS1hbHhuZHJAYnUuZWR1IC0+IHBhdGNoZXcvMjAyMDA2
MTEwNTU2NTEuMTM3ODQtMS1hbHhuZHJAYnUuZWR1ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKNTgxYjc1NiBmdXp6OiBBZGQgY2FsbGJhY2tzIGZvciBkbWEtYWNjZXNzIGZ1bmN0aW9u
cwplZmNlYTgyIGZ1eno6IGFkZCBzdXBwb3J0IGZvciBmdXp6aW5nIERNQSByZWdpb25zCjAzZDcw
MTIgZnV6ejogYWRkIGEgZ2VuZXJhbCBmdXp6ZXIgZm9yIGFueSBxZW11IGFyZ3VtZW50cwoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KMS8zIENoZWNraW5nIGNvbW1pdCAwM2Q3MDEyNjUyMDYgKGZ1eno6
IGFkZCBhIGdlbmVyYWwgZnV6emVyIGZvciBhbnkgcWVtdSBhcmd1bWVudHMpCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzIzOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiAiZm9vKiBiYXIiIHNob3Vs
ZCBiZSAiZm9vICpiYXIiCiMzNjY6IEZJTEU6IHRlc3RzL3F0ZXN0L2Z1enovZ2VuZXJhbF9mdXp6
LmM6MzM5OgorICAgIHZvaWQgKCpvcHNbXSkgKFFUZXN0U3RhdGUqIHMsIGNvbnN0IHVuc2lnbmVk
IGNoYXIqICwgc2l6ZV90KSA9IHsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgNDYxIGxp
bmVzIGNoZWNrZWQKClBhdGNoIDEvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi8zIENo
ZWNraW5nIGNvbW1pdCBlZmNlYTgyMzAxY2UgKGZ1eno6IGFkZCBzdXBwb3J0IGZvciBmdXp6aW5n
IERNQSByZWdpb25zKQpFUlJPUjogZXh0ZXJucyBzaG91bGQgYmUgYXZvaWRlZCBpbiAuYyBmaWxl
cwojMzU6IEZJTEU6IHRlc3RzL3F0ZXN0L2Z1enovZ2VuZXJhbF9mdXp6LmM6NzE6Cit2b2lkIGRt
YV9yZWFkX2NiKHNpemVfdCBhZGRyLCBzaXplX3QgbGVuKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgMTQ3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKMy8zIENoZWNraW5nIGNvbW1pdCA1ODFiNzU2ZmYwMzggKGZ1eno6IEFkZCBjYWxs
YmFja3MgZm9yIGRtYS1hY2Nlc3MgZnVuY3Rpb25zKQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVm
b3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwojMjA6IEZJTEU6IGV4ZWMuYzozMjUxOgorICAg
IGlmKGFzLT5yb290ID09IGdldF9zeXN0ZW1fbWVtb3J5KCkpCgpFUlJPUjogc3BhY2UgcmVxdWly
ZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwojMzE6IEZJTEU6IGV4ZWMuYzozNTYz
OgorICAgICAgICBpZihhcy0+cm9vdCA9PSBnZXRfc3lzdGVtX21lbW9yeSgpICYmICFpc193cml0
ZSkKCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBz
dGF0ZW1lbnQKIzMxOiBGSUxFOiBleGVjLmM6MzU2MzoKKyAgICAgICAgaWYoYXMtPnJvb3QgPT0g
Z2V0X3N5c3RlbV9tZW1vcnkoKSAmJiAhaXNfd3JpdGUpClsuLi5dCgpFUlJPUjogc3BhY2UgcmVx
dWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwojNDI6IEZJTEU6IGV4ZWMuYzoz
NTc0OgorICAgIGlmKGFzLT5yb290ID09IGdldF9zeXN0ZW1fbWVtb3J5KCkgJiYgIWlzX3dyaXRl
KQoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0
YXRlbWVudAojNDI6IEZJTEU6IGV4ZWMuYzozNTc0OgorICAgIGlmKGFzLT5yb290ID09IGdldF9z
eXN0ZW1fbWVtb3J5KCkgJiYgIWlzX3dyaXRlKQpbLi4uXQoKRVJST1I6IHNwYWNlIHJlcXVpcmVk
IGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzUzOiBGSUxFOiBleGVjLmM6MzY1MDoK
KyAgICBpZihhcy0+cm9vdCA9PSBnZXRfc3lzdGVtX21lbW9yeSgpICYmICFpc193cml0ZSkKCkVS
Uk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1l
bnQKIzUzOiBGSUxFOiBleGVjLmM6MzY1MDoKKyAgICBpZihhcy0+cm9vdCA9PSBnZXRfc3lzdGVt
X21lbW9yeSgpICYmICFpc193cml0ZSkKWy4uLl0KCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vz
c2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzEyODogRklMRTogaW5jbHVkZS9z
eXNlbXUvZG1hLmg6MTA5OgorICAgIGlmIChkaXIgPT0gRE1BX0RJUkVDVElPTl9UT19ERVZJQ0Up
ClsuLi5dCgp0b3RhbDogOCBlcnJvcnMsIDAgd2FybmluZ3MsIDEzNiBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAzLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoK
VGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjExMDU1NjUxLjEzNzg0LTEtYWx4
bmRyQGJ1LmVkdS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

