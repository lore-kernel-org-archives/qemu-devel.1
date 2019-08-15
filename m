Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F6FC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D11F208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D11F208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5iC-0002pd-2U
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1hy5Jp-0006IH-PM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hy5Jn-0008Mx-G9
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:16:49 -0400
Resent-Date: Wed, 14 Aug 2019 22:16:48 -0400
Resent-Message-Id: <E1hy5Jn-0008Mx-G9@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hy5Jl-0008KD-I7
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565835396; cv=none; d=zoho.com; s=zohoarc; 
 b=QiWQozm7Y2mvapNdJCL78R2tp7OlbUU2NQBiEosv40AXMhJl3nPA+eWXw7EBb+Z3hjR6C5khTd0p5smlc/haY1O9wFMS5Tc1mxSdFZYhJz1j1u5pUFHX0XKG6QCma65PAc1zB2akSE1Zfm5xQFAxK+qT5C+jeGqqhN4FotTBNy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565835396;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=KjFmtaJ+0wf6iuZw6sLB15AiuRzELaLINrINA8IeHOU=; 
 b=L7YMrX3eRJLu2UGjoaW/7t7ZkVRUKVx2tl2DMfL+42e4zDMI31IwbM+3qTusIVZRX+yFIPLDW/tcCBegB4+tjF00GDTsLsTYpmdNX/rUUl9qe/J8Tk5ROVLQg1wY+2iU45yBcB9oZzMNheIzL1/7Et+HIfETCGlpcJo7PSr5ZbM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565835391953836.6077154609436;
 Wed, 14 Aug 2019 19:16:31 -0700 (PDT)
In-Reply-To: <20190814175535.2023-1-dgilbert@redhat.com>
Message-ID: <156583539073.3056.15938317313488505633@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Wed, 14 Aug 2019 19:16:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Fix MemoryRegionSection alignment
 and comparison
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgxNDE3NTUzNS4yMDIz
LTEtZGdpbGJlcnRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQg
dGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxsIGJl
IGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0byBh
IGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIKIyBi
cmFuY2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAiPT09
IFBBQ0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0gVU5BTUUgPT09Igp1bmFtZSAt
YQoKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQV0QvYnVpbGQK
bWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2NvbmZpZ3Vy
ZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVlZCByZWxp
YWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB4dGVuc2EtbGludXgtdXNlci9hY2NlbC9zdHVicy9r
dm0tc3R1Yi5vCiAgQ0MgICAgICB4dGVuc2EtbGludXgtdXNlci9hY2NlbC90Y2cvdGNnLXJ1bnRp
bWUubwogIENDICAgICAgeHRlbnNhLWxpbnV4LXVzZXIvYWNjZWwvdGNnL3RjZy1ydW50aW1lLWd2
ZWMubwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsxXTog
KioqIFtNYWtlZmlsZToyMDk6IHFlbXUteDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZp
bGU6NDcyOiB4ODZfNjQtbGludXgtdXNlci9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcg
Zm9yIHVuZmluaXNoZWQgam9icy4uLi4KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwODE0MTc1NTM1LjIwMjMtMS1kZ2lsYmVydEByZWRo
YXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


