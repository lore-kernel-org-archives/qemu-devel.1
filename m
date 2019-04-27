Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337FBC43219
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 18:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 017B2206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 18:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017B2206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKRhQ-0000uB-6m
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 14:05:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKRgW-0000b6-Ko
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hKRgU-00031M-IB
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:04:24 -0400
Resent-Date: Sat, 27 Apr 2019 14:04:23 -0400
Resent-Message-Id: <E1hKRgU-00031M-IB@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hKRgQ-0002lR-Ms
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 14:04:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556388189; cv=none; d=zoho.com; s=zohoarc; 
	b=auvEHXcD/QSoERJd/C6sEKhG/AmN0qVvrbkG9GVv2RFAKauW6TkB6dDhAhkjauatQmRiqglj2b/Dr7uXbS3u3OTzMMG/RcxnLe10p+je9LmiYg8ZPnLV9WTJWsCezT/F2hbRxnw2rz1+p/F3QAIJ2sjKdsKjm2gOxfo8+GCIm30=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556388189;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=iMUH0GC877K7MYWPVRmXZqNjiGjcSSD9scAmhMkBiBw=; 
	b=DmHS0iJKF2Ly/RNcM9/T1wb7NL5ymDhI6VIMJKbS8RBa90+gJacLV2WoQBk7ILK85XTNjPm6FSEA5p6iGTCLFQ8VDK1ugEeEf0z62YMsrslk7H8shacN7JRb7+k3mha4loWbZtECICkevmZOypc91gCf6vnudMnynPVZkNliruM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556388187120581.0331304065456;
	Sat, 27 Apr 2019 11:03:07 -0700 (PDT)
In-Reply-To: <20190427165504.29846-1-philmd@redhat.com>
Message-ID: <155638818481.10667.17867845742126511613@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Sat, 27 Apr 2019 11:03:07 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/2] hw/acpi: Improve build modularity
 (targeting MIPS/PPC)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, yang.zhong@intel.com, thuth@redhat.com,
	sameo@linux.intel.com, mst@redhat.com, arikalo@wavecomp.com,
	qemu-devel@nongnu.org, hpoussin@reactos.org,
	amarkovic@wavecomp.com, pbonzini@redhat.com, imammedo@redhat.com,
	philmd@redhat.com, aurelien@aurel32.net, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427180307.834y-7FpiT6sxHrBlGt0n8S0J-8mlHBw9DPoJY2kNuU@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNzE2NTUwNC4yOTg0
Ni0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IFNIT1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0
MjcxNjU1MDQuMjk4NDYtMS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0Bm
ZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


