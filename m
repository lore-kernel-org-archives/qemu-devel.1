Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AE0C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1E8223CB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 08:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1E8223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvHhE-0006xt-W8
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 04:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hvHgo-0006Y1-6K
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hvHgm-0006aC-US
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:52:58 -0400
Resent-Date: Wed, 07 Aug 2019 04:52:58 -0400
Resent-Message-Id: <E1hvHgm-0006aC-US@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hvHgm-0006Va-Lx
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 04:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565167899; cv=none; d=zoho.com; s=zohoarc; 
 b=MIKkL08Iv8zR2QvEbFgvL/dRnNMfQSq8kBM0MVKIpcrRSMj8jBpLxKF6O3HGG20jSgzC0hW7YEZP/nGJNPBZSr9F9OzaZCtEzJYVsewmZAV05DEDhBHIXhDRl7pli6YA5ZFmbeajnaQi0czhuQ32WwqVBneWFPWewd051vdJZ40=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565167899;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=oUANY1ZLhe1x6kBAhH55vA9bVzgXdr01ZemRSdfCfKU=; 
 b=hexRrjrhRax3MdSVtaal57LhnuEyBgcpvOpOgBNtqJ/utQ8V+CHKOIikjxGbOkEfTXWnEHN2ZC53bUdL761zcxRzmBG2UYuoYJ0hdU/qIhPEyNiGmhNRW5NlSIBOAFQRbqemZOl/1QGk8q5wu/5gX8Yg/4WhpHmUsL1pcsAG+vc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565167898924603.2411763861518;
 Wed, 7 Aug 2019 01:51:38 -0700 (PDT)
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
Message-ID: <156516789741.4245.4299712311905095744@b08f24806b7e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: bala24@linux.ibm.com
Date: Wed, 7 Aug 2019 01:51:38 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Enhancing Qemu MMIO emulation with
 scripting interface
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
Cc: maddy@linux.vnet.ibm.com, qemu-devel@nongnu.org, bala24@linux.ibm.com,
 anju@linux.vnet.ibm.com, clg@kaod.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwNzA3MTQ0NS40MTA5
LTEtYmFsYTI0QGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxk
IHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBi
ZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8g
YSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMg
YnJhbmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09
PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAiPT09IFVOQU1FID09PSIKdW5hbWUg
LWEKCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlMRD0kUFdEL2J1aWxk
Cm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQKJFNSQy9jb25maWd1
cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6IHdlIG5lZWQgcmVs
aWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0YWxsCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdXRpbC9maWxlbW9uaXRvci1pbm90aWZ5Lm8KICBD
QyAgICAgIHV0aWwvdmZpby1oZWxwZXJzLm8KL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWpf
cTNhdWNmL3NyYy91dGlsL3B5dGhvbl9hcGkuYzogSW4gZnVuY3Rpb24g4oCYcHl0aG9uX2NhbGxi
YWNrX3N0cuKAmToKL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWpfcTNhdWNmL3NyYy91dGls
L3B5dGhvbl9hcGkuYzo3MjoxMjogZXJyb3I6IHJldHVybiBkaXNjYXJkcyDigJhjb25zdOKAmSBx
dWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Vycm9yPWRpc2NhcmRlZC1xdWFs
aWZpZXJzXQogICA3MiB8ICAgICByZXR1cm4gUHlVbmljb2RlX0FzVVRGOChyZXN1bHQpOwogICAg
ICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDgwNzA3MTQ0NS40MTA5LTEtYmFsYTI0QGxpbnV4
LmlibS5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


