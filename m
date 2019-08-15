Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD4CC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D33F206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D33F206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyONM-00089h-H0
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 18:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1hyOMc-0007Q8-Ot
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:36:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hyOMb-0002Rt-4s
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:36:58 -0400
Resent-Date: Thu, 15 Aug 2019 18:36:58 -0400
Resent-Message-Id: <E1hyOMb-0002Rt-4s@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hyOMa-0002PA-SK; Thu, 15 Aug 2019 18:36:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565908608; cv=none; d=zoho.com; s=zohoarc; 
 b=dBpclirASt8H6euJJ8UwS5Z82pzyaz3jFehTaG26JYm4oJG0Un4BcrOv99gemrC2XgvhsobZwqYxGiJOaqvZWKBaGei2oR19DlEulQRcro97n5Cgk6HpMlyWBiDeKfUWdsJkCPMWzhvFZLyccngssxJMD+29eshdEbjT1WO8BxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565908608;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=hDdZcPso8Br3U3/Kw7d8h5SGixvev+NIVGv2QQIygIQ=; 
 b=i+f2yI4FWqPfC+1jpblbLPaolKh7OC75JXqE5g/U5xqGK89pAqazcLamd0mvHA2JloYS7DgrqnhdpIwoO2W3QtkuPTqRvZlxia4BC3YKZXaUFgCS8CKf72iLHjocv8feMlqv17TdvgvN2EgNDasfrEH4W+EvS64VsyB/KwJwuhk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565908607210324.2209190167731;
 Thu, 15 Aug 2019 15:36:47 -0700 (PDT)
In-Reply-To: <20190815185024.7010-1-eblake@redhat.com>
Message-ID: <156590860597.18217.2953978604697927652@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Thu, 15 Aug 2019 15:36:47 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH] nbd: Advertise multi-conn for shared
 read-only connections
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 rjones@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgxNTE4NTAyNC43MDEw
LTEtZWJsYWtlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRl
c3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBiZSBp
bnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBj
b21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJh
bmNoCnNldCAtZQoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09PSBQ
QUNLQUdFUyA9PT0iCnJwbSAtcWEKCmVjaG8KZWNobyAiPT09IFVOQU1FID09PSIKdW5hbWUgLWEK
CkNDPSRIT01FL2Jpbi9jYwpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlMRD0kUFdEL2J1aWxkCm1r
ZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQKJFNSQy9jb25maWd1cmUg
LS1jYz0kQ0MgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajQKIyBYWFg6IHdlIG5lZWQgcmVsaWFi
bGUgY2xlYW4gdXAKIyBtYWtlIGNoZWNrIC1qNCBWPTEKbWFrZSBpbnN0YWxsCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgogIENDICAgICAgbWlwczY0LXNvZnRtbXUvdHJhY2UvY29udHJvbC10YXJn
ZXQubwogIENDICAgICAgbWlwczY0LXNvZnRtbXUvdHJhY2UvZ2VuZXJhdGVkLWhlbHBlcnMubwog
IExJTksgICAgbWlwczY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0tbWlwczY0CmNvbGxlY3QyOiBlcnJv
cjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjIwOTog
cWVtdS1zeXN0ZW0tbWlwczY0XSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDcyOiBtaXBz
NjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMTkwODE1MTg1MDI0LjcwMTAtMS1lYmxha2VAcmVkaGF0LmNvbS90ZXN0aW5nLnMz
OTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


