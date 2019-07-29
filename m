Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEFC76186
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 23:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4CB2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 23:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4CB2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsFL0-0006rH-LI
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 19:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hsFKU-0006Q5-BX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 19:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hsFKS-0004EU-W6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 19:45:22 -0400
Resent-Date: Mon, 29 Jul 2019 19:45:22 -0400
Resent-Message-Id: <E1hsFKS-0004EU-W6@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hsFKS-0004Dp-Ia
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 19:45:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564443886; cv=none; d=zoho.com; s=zohoarc; 
 b=Wp5TUyphS2MqxuHvGk9kYKGajBllPWYdUFPJVz4UTqa04MAeUncXOV6Agn2SYLf1ilRVensaAQ0dNsZRb4vfunuo5zLmPPyF7sBIUAfPXX49a/9CsQJEfOJ0Th+y56SinjjsrDjhm1Y9jSmiCFVI6AXDcjkb6qYTuC60jVBJKP0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1564443886;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=dnl3B/yCe5k1SfAFvanUqYAopR9QZG6aoMKGyeli/8I=; 
 b=c6OZe3okoNBpJaXkXFkupzSD+/u0tp0vDO0K46o3WL9j2oJtTUFB07gwNplfMCjj/GUnZTIhiNYuB4G43q12ZFJKl4kwU1ppFIPKSVQPLQIazhvUpx2OTBxIW7cWY3QtgW/tJe1XqJ9vvRrmKAcXU6h0Hzg40t8FlWmiwr5eSFo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1564443884490921.5741698151837;
 Mon, 29 Jul 2019 16:44:44 -0700 (PDT)
Message-ID: <156444388333.13204.17994049100272899841@c4a48874b076>
In-Reply-To: <1564424746-11065-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Mon, 29 Jul 2019 16:44:44 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH for 4.2 v2 0/6] target/mips: Misc patches
 for 4.2
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
Cc: arikalo@wavecomp.com, sw@weilnetz.de, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY0NDI0NzQ2LTExMDY1LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhl
IGRldGFpbHMgYmVsb3cuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMg
VGVzdGluZyBzY3JpcHQgd2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0
aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGll
ZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJhbmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09
PSIKZW52CgplY2hvCmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAi
PT09IFVOQU1FID09PSIKdW5hbWUgLWEKCkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5z
dGFsbApCVUlMRD0kUFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApj
ZCAkQlVJTEQKJFNSQy9jb25maWd1cmUgLS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAt
ajQKIyBYWFg6IHdlIG5lZWQgcmVsaWFibGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEK
bWFrZSBpbnN0YWxsCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NjQ0MjQ3NDYtMTEwNjUtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLnMzOTB4
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


