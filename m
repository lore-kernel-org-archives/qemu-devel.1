Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25743C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05732089E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 13:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05732089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58832 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hagmc-0002mx-El
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 09:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1haghg-0000J2-TB
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1haghV-0005hP-G5
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:20:35 -0400
Resent-Date: Tue, 11 Jun 2019 09:20:34 -0400
Resent-Message-Id: <E1haghV-0005hP-G5@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1haghT-0005Mc-2d
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:20:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560259164; cv=none; d=zoho.com; s=zohoarc; 
 b=dlGOSdL6lYynmPBwfHsFqIBVkNUJt8PKPANeYG6XTozzlmhZdnWDDJf/ff/MYa182Fl9YA7PLBV4A+PeQX7D0YEnczf6qEq7d6ctwO0lZf48mYt6n0M6toxPFcQTf50/Ho8UNvl3LQzWDrvs7RD4gk4kJbr2FpCQAcj0oq+jCY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560259164;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=KxhuGzm0GvGSiqOw0t1BhFOiXI9ogL/drr3vJfP4hBI=; 
 b=B+GyUbmxI4hnglV72EyRmJ4oeTPbxL/j+iizl5FokLKEi5CWCU6epdpyRHDVJJcg1PTHa8K3dp1V6kjcsj9Uek7GMuvRJvecVaMkpi5rmAjmrd1vYDAL12kUomAssp+1qEcPiWkc6Rm3snMOvpDteLILOehRoDZsfbsDRU8Vu7s=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560259162210304.1250441084726;
 Tue, 11 Jun 2019 06:19:22 -0700 (PDT)
In-Reply-To: <20190611113731.16940-1-philmd@redhat.com>
Message-ID: <156025916106.32260.7604766616678035688@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Tue, 11 Jun 2019 06:19:22 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
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
IgpycG0gLXFhCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgcngtc29mdG1tdS9l
eGVjLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1x
a3hybGR0Yi9zcmMvdGFyZ2V0L3J4L2NwdS5oOjMxLAogICAgICAgICAgICAgICAgIGZyb20gL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXFreHJsZHRiL3NyYy9leGVjLmM6MjM6Ci92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1xa3hybGR0Yi9zcmMvaW5jbHVkZS9leGVjL2NwdS1kZWZzLmg6
Mzg6MTA6IGZhdGFsIGVycm9yOiBjcHUtcGFyYW0uaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9y
eQogICAzOCB8ICNpbmNsdWRlICJjcHUtcGFyYW0uaCIKICAgICAgfCAgICAgICAgICBefn5+fn5+
fn5+fn5+CmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYxMTExMzczMS4xNjk0MC0xLXBoaWxt
ZEByZWRoYXQuY29tL3Rlc3RpbmcuczM5MHgvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


