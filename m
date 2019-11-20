Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDACA2244A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 05:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDACA2244A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXIlI-0003ne-Vy
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 00:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iXIjh-0002rN-Lb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iXIjf-0004lT-4h
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 00:41:05 -0500
Resent-Date: Wed, 20 Nov 2019 00:41:04 -0500
Resent-Message-Id: <E1iXIjf-0004lT-4h@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iXIjd-0004i8-6p; Wed, 20 Nov 2019 00:41:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574228390; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LNn2MseIKtGt3TOQpqejIowowwJ5NRdLkGpBad2fP0f2uP3HqCVHBV55sTjh1NE7lYdKKqSnr1d04rwvN4DnUOywUODo3TDUSsQCgNZu7MLGZXhSNndtLjF8Zu8wG2pKAJpVkQjuq8k8X/odrmMbZnUXmi/A+J4jk+SSbIAYKmE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574228390;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ab4GkkjgM89fnZ5nP2L+uMLBRCDw7fIePKlfAHNOU14=; 
 b=EEkl2dbybpp/Om0kbDE6TYWY0qLnG4JcIB262NepUcb+RHqu+dlUvJEvVqLXmcFYWMOyi3Rq7xKQehDzDaZ+CsT14pp5xH6pAla39RU8jvS5FhDO75oK81i24aTsuzJ6FDneLnmiZmAvpcp+1vvtQHHM8mDHKkuyNh2nsSEgC5Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574228388532602.2304862008273;
 Tue, 19 Nov 2019 21:39:48 -0800 (PST)
In-Reply-To: <20191119204551.240792-1-stefanha@redhat.com>
Subject: Re: [PULL for-4.2-rc2 0/2] Tracing patches
Message-ID: <157422838685.2797.14570794774294363160@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Tue, 19 Nov 2019 21:39:48 -0800 (PST)
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, amarkovic@wavecomp.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, aleksandar.rikalo@rt-rk.com, philmd@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExOTIwNDU1MS4yNDA3
OTItMS1zdGVmYW5oYUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUFVMTCBmb3ItNC4yLXJjMiAwLzJdIFRyYWNpbmcgcGF0
Y2hlcwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTExMTkyMDQ1NTEuMjQwNzkyLTEtc3Rl
ZmFuaGFAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApn
aXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKCj09PSBPVVRQVVQgQkVHSU4gPT09CmNoZWNr
cGF0Y2gucGw6IG5vIHJldmlzaW9ucyByZXR1cm5lZCBmb3IgcmV2bGlzdCAnMScKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMjU1CgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTExOTIwNDU1
MS4yNDA3OTItMS1zdGVmYW5oYUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


