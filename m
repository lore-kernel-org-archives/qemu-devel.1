Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C8C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBA720673
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 17:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBA720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT8N0-0001qB-P9
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 12:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iT8Lp-0000yB-Ic
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iT8Lo-0003SF-FT
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:47:13 -0500
Resent-Date: Fri, 08 Nov 2019 12:47:13 -0500
Resent-Message-Id: <E1iT8Lo-0003SF-FT@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iT8Lo-0003RI-7W
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 12:47:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573235226; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Av8tlbgGRXSlP33GjWfaJ2Yc3AGkwcsmonsy8o3EvKSDHLNSPjZ8erLRMLEntKZakjE+SFao1bqa2A5SLNJAbo9y3L2jPTRcN80A+61CWrRxy9Pa2P+XIdfm7oTKyLyF7Dnz+8IfUMtTBlKfLZkVoBBkMacZq6R45FYgGAi+a8k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573235226;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=KWu3j7k/QPO+SoQrmb5DZN0vXhFsit5YcjAvXR3JQKQ=; 
 b=DhONT4Bcc7j1fBDV0KdusDU6cfYqkmvYmYP11IjuXhrroy4S+46npQF4OuvpqRY8YK7juMIcyv4khlSSDdN/0GsiuDdGwNjvattXNd/XG51ZGQAGqzlDJEjz8ygtCHkPxVLrOfz1L3tJiT3z5uzBB3sKFfxAcNxZN66ly1OdUIA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573235225084769.9289301518943;
 Fri, 8 Nov 2019 09:47:05 -0800 (PST)
In-Reply-To: <20191108104307.125020-1-dgilbert@redhat.com>
Subject: Re: [PATCH] tests/migration: Print some debug on bad status
Message-ID: <157323522392.7743.17041423273148629916@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Fri, 8 Nov 2019 09:47:05 -0800 (PST)
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
Cc: thuth@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwODEwNDMwNy4xMjUw
MjAtMS1kZ2lsYmVydEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMDgxMDQz
MDcuMTI1MDIwLTEtZGdpbGJlcnRAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRv
cmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


