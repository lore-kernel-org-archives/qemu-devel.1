Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE286C4321B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B956320896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B956320896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59112 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hah3E-0006dd-Uc
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 09:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55872)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hah0m-0005NP-AM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:40:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hah0l-0000gL-24
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:40:28 -0400
Resent-Date: Tue, 11 Jun 2019 09:40:28 -0400
Resent-Message-Id: <E1hah0l-0000gL-24@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21921)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hah0k-0000fS-65
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560260344; cv=none; d=zoho.com; s=zohoarc; 
 b=grxMoDwvP/coJOAiROMVVRSRVfCnhOU3xA1+peal6CEPaX9jRBRPS3MLd3gYtXhwHeDs7fgEP5grDp7sitKuiaWu3F22hB9r/v/zhDIJCgSCEEmyfHW6o9JQC3FNWAXcwOsczuJekwbL2tHa19jdZWVZC6Zoe7AQqBM/URCpF+g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560260344;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=eFGOCknIXaDuFCzvogA3qpoM2CcR3xTJIcNBYVibfgs=; 
 b=b8du5jFVnIZ4xs5KxbkLo7MoefXxUJ16wysJ8YLKLgkC8mNTtgTktSnjbD+1V29mslU5WBAfA+gj01E9LqNOcLqP7h4W+a45GhOX/bBWcN0kb+9YEM5ynMXul/jXqg5RCj3cYXS7fX2/J85hgbQNK/eolHCzoI8QdNbhGdsercw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560260343042378.27942228959864;
 Tue, 11 Jun 2019 06:39:03 -0700 (PDT)
In-Reply-To: <20190611113731.16940-1-philmd@redhat.com>
Message-ID: <156026034197.32260.8254517259261085@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Tue, 11 Jun 2019 06:39:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v19 00/21] Add RX archtecture support
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
Cc: imammedo@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 ysato@users.sourceforge.jp, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxMTExMzczMS4xNjk0
MC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQ
V0QvYnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JD
L2NvbmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2Ug
bmVlZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwK
CmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0gUEFDS0FHRVMgPT09
IgpycG0gLXFhCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgcmlzY3YzMi1zb2Z0
bW11L2R1bXAubwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLXF0c2FxdDUwL3NyYy90YXJnZXQvcngvY3B1Lmg6MzEsCiAgICAgICAgICAgICAgICAgZnJv
bSAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcXRzYXF0NTAvc3JjL2V4ZWMuYzoyMzoKL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXF0c2FxdDUwL3NyYy9pbmNsdWRlL2V4ZWMvY3B1LWRl
ZnMuaDozODoxMDogZmF0YWwgZXJyb3I6IGNwdS1wYXJhbS5oOiBObyBzdWNoIGZpbGUgb3IgZGly
ZWN0b3J5CiAgIDM4IHwgI2luY2x1ZGUgImNwdS1wYXJhbS5oIgogICAgICB8ICAgICAgICAgIF5+
fn5+fn5+fn5+fn4KY29tcGlsYXRpb24gdGVybWluYXRlZC4KCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNjExMTEzNzMxLjE2OTQwLTEt
cGhpbG1kQHJlZGhhdC5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


