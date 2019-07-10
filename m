Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE57C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802DA2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802DA2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl7e3-0001Gy-S1
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48142)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hl7cg-00007Y-2b
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hl7ce-0003lp-9d
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:06:42 -0400
Resent-Date: Wed, 10 Jul 2019 04:06:41 -0400
Resent-Message-Id: <E1hl7ce-0003lp-9d@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hl7cd-0003k7-Hi
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:06:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562745989; cv=none; d=zoho.com; s=zohoarc; 
 b=YeTZIQuqmjKsZEQBy6IqEc63FBUhJ3M8ApJVsS40M2+3h13fK1OxqwIDFMT9mAABPf2rUqsyzJA3mFYiuBFFvXQ6apMFFFQdc/WXDYwzE20ovsnQPLxx3xYbskgfEj8GkZiED+0glg/iFjbk00w6Zup2QA/vDf8evh5ayVBO44s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562745989;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=2o3NbJBqyZXDiXzEVTVyfYsBLx2fIPEjwBbFcyGFK5Q=; 
 b=b+9FQAgYAuL9W9l0a6AVC06QIA6dTn5+a4ykqh8BxW411Lcc1KxyO0zv6AW1OOlecREdUggG1GeIXyDHGPUj/Sh0MhPoGuyQ1Lh2uPBSAblgdTBAzUxhidgeIsnOlVX7RrkNUXL5a9kPacp/t+JgYst4Y8xvrOJE7xEzdWJtvXg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562745988520894.8566524668529;
 Wed, 10 Jul 2019 01:06:28 -0700 (PDT)
Message-ID: <156274598730.3735.39776049536903184@c4a48874b076>
In-Reply-To: <1562745044-7838-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kernellwp@gmail.com
Date: Wed, 10 Jul 2019 01:06:28 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_SCHED_YIELD CPUID
 feature bit
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
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYyNzQ1MDQ0LTc4MzgtMS1n
aXQtc2VuZC1lbWFpbC13YW5wZW5nbGlAdGVuY2VudC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMg
YmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBz
Y3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQg
cG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Ag
b2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52Cgpl
Y2hvCmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAiPT09IFVOQU1F
ID09PSIKdW5hbWUgLWEKCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlM
RD0kUFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQK
JFNSQy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6
IHdlIG5lZWQgcmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0
YWxsCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYXJtLXNvZnRtbXUvcWFwaS9x
YXBpLXZpc2l0LW1pc2MtdGFyZ2V0Lm8KICBDQyAgICAgIGkzODYtc29mdG1tdS90YXJnZXQvaTM4
Ni9jcHUubwogIENDICAgICAgYXJtLXNvZnRtbXUvcWFwaS9xYXBpLXZpc2l0Lm8KL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLXJfOGxwdWRxL3NyYy90YXJnZXQvaTM4Ni9jcHUuYzo5MDk6MTk6
IGVycm9yOiBtaXNzaW5nIHRlcm1pbmF0aW5nICIgY2hhcmFjdGVyIFstV2Vycm9yXQogIDkwOSB8
ICAgICAgICAgICAgIE5VTEwsICJrdm0tcHYtc2NoZWQteWllbGQnLCBOVUxMLCBOVUxMLAogICAg
ICB8ICAgICAgICAgICAgICAgICAgIF4KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJfOGxw
dWRxL3NyYy90YXJnZXQvaTM4Ni9jcHUuYzo5MDk6MTk6IGVycm9yOiBtaXNzaW5nIHRlcm1pbmF0
aW5nICIgY2hhcmFjdGVyCiAgOTA5IHwgICAgICAgICAgICAgTlVMTCwgImt2bS1wdi1zY2hlZC15
aWVsZCcsIE5VTEwsIE5VTEwsCiAgICAgIHwgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8xNTYyNzQ1MDQ0LTc4MzgtMS1naXQtc2VuZC1lbWFpbC13YW5wZW5nbGlAdGVuY2VudC5j
b20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


