Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D0DC0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE43213F2
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE43213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjjCu-0007lp-84
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57954)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hjj8U-0006Ug-Lc
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hjj8S-0004qK-Bz
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:45:46 -0400
Resent-Date: Sat, 06 Jul 2019 07:45:45 -0400
Resent-Message-Id: <E1hjj8S-0004qK-Bz@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hjj8Q-0004mt-TH; Sat, 06 Jul 2019 07:45:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562413533; cv=none; d=zoho.com; s=zohoarc; 
 b=StZzWfWgUSWwV0duSM54jYotvg94VVte78SUCHRTm58TouLv8/O2Q8QFr6kLyynNDbpGto8NHYRYoQUaRLdj9x/MhMHc1C0l7Q5YU0HeTm7ENhWeWFAh8v3CbxRtfYhNEY4tFrC7Qj/9GQSQln7Q5LP6hcubye0wTF95AZjDtNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562413533;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=ZAjAFFMjzDOqqXjn0soZejArvpr5GYsSXoFhLaSdAW8=; 
 b=j+V2+pIldguNLgjxlscMVueuIPkV5obYD3R6aqjYxBv2sRN7yvSdwG6myDivaBbdDEfjVBFT8IL2FwSw+YkiQaZ5C5Z+oB/eNi3xBVuPMRHhKFOM3lR2GXSpdGEWRP7hdAxY5KavzpyeYJUCsoU12a8+mdwl17VmaHp8li/o55c=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156241353291559.330888580737906;
 Sat, 6 Jul 2019 04:45:32 -0700 (PDT)
Message-ID: <156241353142.4200.7077749980045313649@c4a48874b076>
In-Reply-To: <20190705202500.18853-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Sat, 6 Jul 2019 04:45:32 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v4 0/3] hw/ssi/xilinx_spips: Avoid
 NULL pointer deference
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
Cc: peter.maydell@linaro.org, frasse.iglesias@gmail.com, alistair@alistair23.me,
 qemu-devel@nongnu.org, ppandit@redhat.com, slei.casper@gmail.com,
 qemu-arm@nongnu.org, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwNTIwMjUwMC4xODg1
My0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
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
Q1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3L3NzaS9hc3BlZWRfc21jLm8KICBDQyAgICAgIGh3
L3NzaS9zdG0zMmYyeHhfc3BpLm8KICBDQyAgICAgIGh3L3NzaS9tc3Mtc3BpLm8KL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWdoamp2ODZiL3NyYy9ody9zc2kveGlsaW54X3NwaXBzLmM6MTI0
Njo1OiBlcnJvcjogZXhwZWN0ZWQg4oCYfeKAmSBiZWZvcmUg4oCYLuKAmSB0b2tlbgogMTI0NiB8
ICAgICAuaW1wbCA9IHsKICAgICAgfCAgICAgXgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
Z2hqanY4NmIvc3JjL2h3L3NzaS94aWxpbnhfc3BpcHMuYzoxMjM4OjQyOiBub3RlOiB0byBtYXRj
aCB0aGlzIOKAmHvigJkKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwNzA1MjAyNTAwLjE4ODUzLTEtcGhpbG1kQHJlZGhhdC5jb20vdGVz
dGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


