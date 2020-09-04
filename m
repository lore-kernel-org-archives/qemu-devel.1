Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9604FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5484A2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5484A2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE5I-00068Q-FH
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kEE0S-0004y9-0m; Fri, 04 Sep 2020 11:52:04 -0400
Resent-Date: Fri, 04 Sep 2020 11:52:04 -0400
Resent-Message-Id: <E1kEE0S-0004y9-0m@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21734)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kEE0P-0000Lt-5M; Fri, 04 Sep 2020 11:52:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599234706; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E7mn2do12OKrzqFG3Y5MeVTJz+Fph2EJRqKd5F0ZirctnqDpAsM74cVKANdkJmAZgIzm2h4ICvzOh4tSkLuxcXWF7SjGRQqa0/e9bniPIrOX/75RsKVWiEBDUYulLwTM+MnXCaZaNamE0+7QD8OiWX3FRd6aouOfpwFvp96jpJs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599234706;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=aQFzRdKfvklqCiL0xJn6VfosVRda5Fk74hJJBdu1xfE=; 
 b=m5e3vTJVbUOkB+64Bhsg1xKtaFUUDRk66zhEqC0SpM6M+Tqvn9QlzyHQ4t/u3/vWeVX8gE4KnrQLpUJISq8veJr0rY9dKELj2uIRdVzWriIHQyyZkFlgEowMn5QDPt/YkGd+sopaMS3A0TzhccGa0EnfJd1YNvFh8RZF4HqxN6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599234704401778.4948040787881;
 Fri, 4 Sep 2020 08:51:44 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove KVM support for 32-bit Arm hosts
Message-ID: <159923470338.11986.13453143358471338264@66eaa9a8a123>
In-Reply-To: <20200904154156.31943-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Fri, 4 Sep 2020 08:51:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 11:51:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkwNDE1NDE1Ni4zMTk0
My0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
YnVpbGQgdGVzdCBvbiBGcmVlQlNEIGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93
LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0
IHdpbGwgYmUgaW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50
aW5nIHRvIGEgY29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJi
YXNlIgojIGJyYW5jaAppZiBxZW11LXN5c3RlbS14ODZfNjQgLS1oZWxwID4vZGV2L251bGwgMj4m
MTsgdGhlbgogIFFFTVU9cWVtdS1zeXN0ZW0teDg2XzY0CmVsaWYgL3Vzci9saWJleGVjL3FlbXUt
a3ZtIC0taGVscCA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICBRRU1VPS91c3IvbGliZXhlYy9xZW11
LWt2bQplbHNlCiAgZXhpdCAxCmZpCm1ha2Ugdm0tYnVpbGQtZnJlZWJzZCBKPTIxIFFFTVU9JFFF
TVUKZXhpdCAwCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTA0MTU0MTU2LjMxOTQzLTEt
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnL3Rlc3RpbmcuRnJlZUJTRC8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

