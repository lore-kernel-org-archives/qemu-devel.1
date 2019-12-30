Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE94C2D0CE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA0C2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 08:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA0C2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilq5a-0001Ca-GJ
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 03:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ilq4v-0000mw-Ib
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ilq4t-0002rR-ON
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:07:04 -0500
Resent-Date: Mon, 30 Dec 2019 03:07:04 -0500
Resent-Message-Id: <E1ilq4t-0002rR-ON@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ilq4t-0002hz-Fv
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 03:07:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1577693213; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GRLbZpqW9ZcmRQOdE78wlNRoBJF6RdWLr5kQvYCnCYCZBJHQ79IMWw3ZZE+HxU3KEKD7pDstpzNnyfctYCDm4RQLLVnn+VDfRFDJhsKMfjigrBUP4tggLg4BOhyI5xWRnIdeZtGZv1sCT6GBlNGrzdAWRbdclUWZLqejbIRZP9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1577693213;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=b1B0+wwEdwaWEAvvIvjnACSsjxgiGGhrhKJXOq1I/bU=; 
 b=Y7tY1S5oapSEwdpYofOFn7bb//Ki+MRmzs1sdHqNKzY+43Ee9JREbqHGJG2gpDB2Ebu4S2LsYRB3DdOWFJXzNfkPaocS4whJlBa95fpf0C+KbEHAJkScWWf6503zpLWdUDih1IVcmhAPtkyqll9fVBc7xhYMNCpNxR1vvNFZxzs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15776932034581014.3949518743435;
 Mon, 30 Dec 2019 00:06:43 -0800 (PST)
In-Reply-To: <7cc91bab3191bfd7e071bdd3fdf7fe2a2991deb0.1577692822.git.mprivozn@redhat.com>
Subject: Re: [PATCH] x86: Check for machine state object class before
 typecasting it
Message-ID: <157769320291.19009.148550606587330700@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mprivozn@redhat.com
Date: Mon, 30 Dec 2019 00:06:43 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS83Y2M5MWJhYjMxOTFiZmQ3ZTA3
MWJkZDNmZGY3ZmUyYTI5OTFkZWIwLjE1Nzc2OTI4MjIuZ2l0Lm1wcml2b3puQHJlZGhhdC5jb20v
CgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWls
ZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0
IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJl
cHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tl
ci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy83Y2M5MWJhYjMxOTFiZmQ3ZTA3MWJkZDNmZGY3ZmUyYTI5OTFkZWIwLjE1
Nzc2OTI4MjIuZ2l0Lm1wcml2b3puQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2Vu
dG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


