Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16C1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A382086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A382086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBEeP-00074e-MA
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iBEc8-0004SB-CL
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iBEc6-0003DB-UK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:50:03 -0400
Resent-Date: Fri, 20 Sep 2019 04:50:03 -0400
Resent-Message-Id: <E1iBEc6-0003DB-UK@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iBEc6-0003Cn-MI
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:50:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568969394; cv=none; d=zoho.com; s=zohoarc; 
 b=J0i+4otp9C6MGChJJlxrzzMZ6GExmcimzANtOoPXzk9MfMkbnl85/J3UXp4BiNOEMZRxsRaG2sRsL8jhAbeL7mDnPm7zy6iYjWE0cUG8q8F6+MGYW6UhOEJs0iGEW9n5gQsv0kipuv28dt6qnPZ5/TDA+gM7Hn8sknvrSlnmG74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568969394;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=t/SIRdwMiLtTMQarymMq39zO8W5fwx28k2CdXAO6gVk=; 
 b=gx4KtvVF+Ga1+gxBgVGayQtM0omyAdAYg8hqleTQ2nnG5ILzoLYjsA9kgigpx0uEVzFpMKk8J/zoBWfyTa5CpfnTKBdbYkKTzMCs1qzDSZBv5ZS/h7Pn6bpewgUq+j8qY6W29Pq7/UcD16+W8JFHayHkRAmEvV73R7k0stPVii4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568969392683937.073054758263;
 Fri, 20 Sep 2019 01:49:52 -0700 (PDT)
In-Reply-To: <20190919091043.24503-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/2] Ati 20190919 patches
Message-ID: <156896939167.4246.11560664597787059433@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Fri, 20 Sep 2019 01:49:52 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxOTA5MTA0My4yNDUw
My0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWlt
YWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9j
a2pvYi5vCiAgQ0MgICAgICBqb2IubwoKRW5jb2RpbmcgZXJyb3I6Cid1dGYtOCcgY29kZWMgY2Fu
J3QgZGVjb2RlIGJ5dGUgMHg5NSBpbiBwb3NpdGlvbiA3OTk6IGludmFsaWQgc3RhcnQgYnl0ZQpU
aGUgZnVsbCB0cmFjZWJhY2sgaGFzIGJlZW4gc2F2ZWQgaW4gL3RtcC9zcGhpbngtZXJyLXpqcDl0
OTB4LmxvZywgaWYgeW91IHdhbnQgdG8gcmVwb3J0IHRoZSBpc3N1ZSB0byB0aGUgZGV2ZWxvcGVy
cy4KICBDQyAgICAgIHFlbXUtaW8tY21kcy5vCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxOTA5MTA0My4yNDUwMy0xLWtyYXhlbEBy
ZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==


