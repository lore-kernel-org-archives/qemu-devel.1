Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E790AC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:34:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9FA120663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 01:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9FA120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi7hC-0005NA-S7
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 21:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53972)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hi4Hx-0001IN-Cy
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hi4Hv-0006rg-Sz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:56:41 -0400
Resent-Date: Mon, 01 Jul 2019 17:56:41 -0400
Resent-Message-Id: <E1hi4Hv-0006rg-Sz@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hi4Ht-0006qP-U9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:56:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562004470; cv=none; d=zoho.com; s=zohoarc; 
 b=OeDWas9EJVCv5M1vhlzng2cH7rac4PqaomvjeN4RVWSA9/c3tv6mVsdG7OE8EO3/YvUVbO+opCQXJk0mSmEjWq0ZLQ6Rs/jsPpW/HMyy42Omr0P2fX3P1Y+B41ts33zMTiTuWzraNdZBKxDsVpFtnv5c8+m7oTYfZP5p7tz3h3w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562004470;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=wZ5cGPi0l/SUOoQu51w367NN/6w37uXrv0/XL0UjZdM=; 
 b=AdG48Mcw5i3x39h7p2FAyMe6Z7KOl8/ADC1/nz7dhuzYK3AbxVoLDGOZFdYuT7hsA92gssa/ycGKVnGqHsbRUwC+YIc9cRwDYQwhB+jM3nDgA4ksjDDHzUzCoVbrhRJf54DREMu9hK0ueX+L5kZoQ7gX0N2j1OOIjhASbmq58/0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562004468152822.5657690749669;
 Mon, 1 Jul 2019 11:07:48 -0700 (PDT)
Message-ID: <156200446699.9862.5828274180078359682@c4a48874b076>
In-Reply-To: <20190701123441.13412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Mon, 1 Jul 2019 11:07:48 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] hw/misc/macio: Add the nvram as child of
 the MacIO south bridge
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
Cc: ehabkost@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMTEyMzQ0MS4xMzQx
Mi0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKCmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0g
UEFDS0FHRVMgPT09IgpycG0gLXFhCgplY2hvCmVjaG8gIj09PSBVTkFNRSA9PT0iCnVuYW1lIC1h
CgpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApt
a2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJl
IC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlh
YmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2UgaW5zdGFsbAo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3L21pc2MvbWFjaW8vcG11Lm8KICBDQyAgICAgIGh3
L21pc2MvbWFjaW8vbWFjX2RiZG1hLm8KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTU4eHhu
YWlmL3NyYy9ody9taXNjL21hY2lvL21hY2lvLmM6IEluIGZ1bmN0aW9uIOKAmG1hY2lvX29sZHdv
cmxkX2luaXTigJk6Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC01OHh4bmFpZi9zcmMvaHcv
bWlzYy9tYWNpby9tYWNpby5jOjI0NjoyOTogZXJyb3I6IHBhc3NpbmcgYXJndW1lbnQgMSBvZiDi
gJhvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZOKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVyIHR5
cGUgWy1XZXJyb3I9aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCiAgMjQ2IHwgICAgIG9iamVj
dF9pbml0aWFsaXplX2NoaWxkKHMsICJudnJhbSIsICAmb3MtPm52cmFtLCBzaXplb2Yob3MtPm52
cmFtKSwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwMTEyMzQ0MS4xMzQxMi0xLXBoaWxtZEByZWRo
YXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


