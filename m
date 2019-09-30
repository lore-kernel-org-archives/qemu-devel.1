Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF7DC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE2820842
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 21:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE2820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF3eb-0005wO-Ub
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 17:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iF3dl-0005VJ-0r
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iF3dj-0005CM-Nu
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:55:32 -0400
Resent-Date: Mon, 30 Sep 2019 17:55:32 -0400
Resent-Message-Id: <E1iF3dj-0005CM-Nu@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iF3dj-0005Bd-G3
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 17:55:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569880520; cv=none; d=zoho.com; s=zohoarc; 
 b=ngT8YNWGBqD2VrSYpNAe3AamQ5D+VkK9TD138gFWvEjMVKYfViYm1wHcHWfD+0YW/nv0kzvPlVPZHHl6gms5dqVESuoXmF3im+jZ5rJ9lVcXqP/uEZnXGKIS2HBq/fhRzG5eCrg9LWdt56q5BohtN/6J4UyEulHspnJcfZn1rYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569880520;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=1JZ++lqIZ28VpAaoh0IMI8rzvN3nfI5wzNECEZQN7PU=; 
 b=cT6cLn1AuLh62cF+v1VmPjzhTWDjHkErRT3bwxWE/Xp8/i8oKZtNU86DiYxxB3d2Yh4ssu0HxjC/lKYau/vuEIUVlfMo/f9kare4TMS6T2Ff3a6VCPxlJJj0dQSTrXF0ah7d8bWUTgx+6oQ3TyhJzQS2RAjYBL0IjvhlIxps0H0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569880518565287.149685609538;
 Mon, 30 Sep 2019 14:55:18 -0700 (PDT)
Subject: Re: [PATCH v5 00/10] Audio: Mixeng-free 5.1/7.1 audio support
In-Reply-To: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
Message-ID: <156988051740.27524.14439809539555312000@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dirty.ice.hu@gmail.com
Date: Mon, 30 Sep 2019 14:55:18 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTY5ODc0NjQxLmdp
dC5EaXJ0WS5pQ0UuaHVAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9j
b3Zlci4xNTY5ODc0NjQxLmdpdC5EaXJ0WS5pQ0UuaHVAZ21haWwuY29tL3Rlc3RpbmcuYXNhbi8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


