Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE856C3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9D0217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9D0217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB6hQ-0004eo-TK
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 20:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iB6gK-00036g-JR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iB6gJ-0007PF-HN
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:21:52 -0400
Resent-Date: Thu, 19 Sep 2019 20:21:52 -0400
Resent-Message-Id: <E1iB6gJ-0007PF-HN@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iB6gJ-0007P2-8l
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:21:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568938906; cv=none; d=zoho.com; s=zohoarc; 
 b=Nx6hUKOyEd2U4dVH7EO76rWR3xqn1a0Bs3666Qa87NOVQL9ucYajalrYFFksvY3d7M21Q/cOJASfFQTXvGx9H1EihtOJGZ9FhWayE3jofJa/W7lLZU2NDhwhPWvB/9Msad12uIWT6azkEEmh3k3XCR5+ocuahNKCTO22mLq5OVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568938906;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=+YjF8uVqphpSLyfA48bIjH9ZEUFxa/9NWXc2zbq899w=; 
 b=URFKOa7uId/4XWOVdNsJeVOeq1zTF64tCsz4/LO2vit5sE1nV9grgcAJFUGWZ6czuv8Z7yp/9tWlKVw22etkMyGqS4VVvA8BGebuy8bCStHdMbbs/qOHRWx3criYNCUMA1TpoZr8Oa8+/cZE2NRIS8Bc7WHoYHKDXxmj36XGfwU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568938905094299.9957221577105;
 Thu, 19 Sep 2019 17:21:45 -0700 (PDT)
In-Reply-To: <20190918231846.22538-1-alxndr@bu.edu>
Subject: Re: [Qemu-devel] [PATCH v3 00/22] Add virtual device fuzzing support
Message-ID: <156893890382.2125.15899205279428860336@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Thu, 19 Sep 2019 17:21:45 -0700 (PDT)
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
Cc: pbonzini@redhat.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, alxndr@bu.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxODIzMTg0Ni4yMjUz
OC0xLWFseG5kckBidS5lZHUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXIt
cXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5F
VFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKZGVmYXVsdCBkZXZpY2VzICAgeWVzCmZ1
enppbmcgc3VwcG9ydCAgIG5vCgp3YXJuaW5nOiBQeXRob24gMiBzdXBwb3J0IGlzIGRlcHJlY2F0
ZWQKd2FybmluZzogUHl0aG9uIDMgd2lsbCBiZSByZXF1aXJlZCBmb3IgYnVpbGRpbmcgZnV0dXJl
IHZlcnNpb25zIG9mIFFFTVUKY3Jvc3MgY29udGFpbmVycyAgbm8KCk5PVEU6IGd1ZXN0IGNyb3Nz
LWNvbXBpbGVycyBlbmFibGVkOiBjYwotLS0KICBDQyAgICAgIGJhY2tlbmRzL2hvc3RtZW0tcmFt
Lm8KICBDQyAgICAgIGJhY2tlbmRzL2hvc3RtZW0tZmlsZS5vCi90bXAvcWVtdS10ZXN0L3NyYy92
bC5jOiBJbiBmdW5jdGlvbiAncWVtdV9jbGVhbnVwJzoKL3RtcC9xZW11LXRlc3Qvc3JjL3ZsLmM6
NDQ3OTo2OiBlcnJvcjogb2xkLXN0eWxlIGZ1bmN0aW9uIGRlZmluaXRpb24gWy1XZXJyb3I9b2xk
LXN0eWxlLWRlZmluaXRpb25dCiB2b2lkIHFlbXVfY2xlYW51cCgpCiAgICAgIF4KY2MxOiBhbGwg
d2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwOTE4MjMxODQ2LjIyNTM4LTEtYWx4
bmRyQGJ1LmVkdS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t


