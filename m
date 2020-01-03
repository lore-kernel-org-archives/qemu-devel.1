Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32710C00523
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B1022B48
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 06:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B1022B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inGvE-0005xE-4S
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 01:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1inGua-0005FA-2X
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1inGuY-00060i-HG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 01:58:19 -0500
Resent-Date: Fri, 03 Jan 2020 01:58:19 -0500
Resent-Message-Id: <E1inGuY-00060i-HG@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1inGuY-0005qs-56; Fri, 03 Jan 2020 01:58:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578034665; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ody72CT0eT4rfekVURHVBBvNY5qTmV8H4AxP/FiIYENDUGYKmygFf2kV/qYHgENdj20iQpDx26GKbqHBp5BsZwSBU/tyl5psshB4fRa0gDDT2IjjUdbG02aYWvTw1ai+zlcDlIeLMGmDTMl2qw0kQhdo+vx97sS5uTmtFkdjVos=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578034665;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7WtgtvHkSC1LDBQRuIH0eziobHu1V4EDkw9BsF9geEo=; 
 b=Qd1qFFjHsBBwXkb5b2LO4ekXqJ1PUVP3B+uExqw3e6J9NmkrV+WDWXRYUAKjm9VSF5KmjyCCR2WXZY7R3GtO/PC0tYwyQjTVeQTlGcC9qQwj3X2eiDo7LQUUzWhg4SB4solNQayi98YiMDVUDCTR71YZ3ugOGZBg29isxu57RJY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578034660429254.72746608624652;
 Thu, 2 Jan 2020 22:57:40 -0800 (PST)
In-Reply-To: <20200103061217.16396-1-aik@ozlabs.ru>
Subject: Re: [PATCH qemu] spapr: Kill SLOF
Message-ID: <157803465959.32423.14071553007227979026@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aik@ozlabs.ru
Date: Thu, 2 Jan 2020 22:57:40 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: farosas@linux.ibm.com, aik@ozlabs.ru, mpe@ellerman.id.au,
 mdroth@linux.vnet.ibm.com, npiggin@gmail.com, qemu-devel@nongnu.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org, leonardo@linux.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwMzA2MTIxNy4xNjM5
Ni0xLWFpa0BvemxhYnMucnUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXIt
cXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5F
VFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDEwMzA2MTIxNy4xNjM5Ni0xLWFp
a0BvemxhYnMucnUvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==


