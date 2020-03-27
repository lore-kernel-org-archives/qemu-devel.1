Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F1C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCEA2072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCEA2072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHvxr-00031U-3u
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 16:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jHvx3-0002Lu-2h
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jHvx1-0000d2-JY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:51:36 -0400
Resent-Date: Fri, 27 Mar 2020 16:51:36 -0400
Resent-Message-Id: <E1jHvx1-0000d2-JY@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jHvx1-0000bs-BQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:51:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585342285; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yge5ZocPUhg6hkGdos01lsxfL9B2bsACzY90/zGO6obLvypKeGr0mYoMtCOih8Uas5kozew+fA9PhGeA0CQdEE8sJbzat0ESDklHD3JH7LYqqE+4St3puEoAEJjG137TTraw374MupXVP9oMXCUHnIhDtM96rAo23c6Xhq7rTXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585342285;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=b9Sze/8lbE4wKJ3nkXwBOOCRjhtnFW96FfUiwiFcKTg=; 
 b=IIrp5lLnd487JY0d3OGVqfw9Ffp5StziCV/kG7XUwt1k7eBw3ZD9n2f5puLocUI57aRTkjkGGUdKAFphsXgTdc5ZSx4WJudp+OyNPOdzBTAsEFcxyF0Qbp8rxKZx5tE1Qnw9WmYH6YJmDuXYxFPoa5+Szu4B9MPFjhsjmkINzI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585342283245957.6059498290018;
 Fri, 27 Mar 2020 13:51:23 -0700 (PDT)
In-Reply-To: <1242491200.59.1585326983523@webmail.proxmox.com>
Subject: Re: AIO_WAIT_WHILE questions
Message-ID: <158534228235.1378.514078368134920793@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dietmar@proxmox.com
Date: Fri, 27 Mar 2020 13:51:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xMjQyNDkxMjAwLjU5LjE1ODUz
MjY5ODM1MjNAd2VibWFpbC5wcm94bW94LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogQUlPX1dBSVRfV0hJTEUgcXVlc3Rpb25zCk1lc3Nh
Z2UtaWQ6IDEyNDI0OTEyMDAuNTkuMTU4NTMyNjk4MzUyM0B3ZWJtYWlsLnByb3htb3guY29tClR5
cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0
cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIDc3YTQ4YTcuLjEyN2ZlODYg
IG1hc3RlciAgICAgLT4gbWFzdGVyClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYTEy
OGFkMCBBSU9fV0FJVF9XSElMRSBxdWVzdGlvbnMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9S
OiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMjYgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGExMjhhZDBiMTAwOSAoQUlPX1dBSVRfV0hJ
TEUgcXVlc3Rpb25zKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xMjQyNDkxMjAwLjU5LjE1ODUzMjY5
ODM1MjNAd2VibWFpbC5wcm94bW94LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

