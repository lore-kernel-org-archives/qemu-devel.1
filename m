Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4F0C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2634321882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2634321882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hixkX-0002Qq-20
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32851)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hixjf-0001o1-Sa
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hixje-0002mz-Jv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:08:59 -0400
Resent-Date: Thu, 04 Jul 2019 05:08:59 -0400
Resent-Message-Id: <E1hixje-0002mz-Jv@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hixje-0002m5-AY; Thu, 04 Jul 2019 05:08:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562231284; cv=none; d=zoho.com; s=zohoarc; 
 b=XeGa0km4V7xMKMcpIDws1Zdx0HzTojw+FvdgOqbG01QgvvaC0XM0jl4VYbAdt0UrgyoMQ1qDC7nFaBV7Xgkriy1ZGV382XK82ZExp9lEM/T6U2JEhZLn3szDGZ+sD9aWTPH97vtBS4XmKr5soMyNvV65yt7bsr43SuJ8A4fvTDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562231284;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=ds/PzTViTCLk6TNAHAeelsx3sEWHDT05aEkEJuwm4Jo=; 
 b=I7K9ykk2HckbjXzaczBaaVVzJfhkHPabJubHa3SYfxWjZTAEFrMJ+VkdyUJf6fKZywdLIPWn7d3kkyhR8IG8aDEgFpPIZtopc3dDyJ6pOenxVjycBWx445QByEWVWVdJQA+ThZvuzEK+SYxvqUCIXDVUCFYKFulcjCkUVVDGGks=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562231282945220.814580556024;
 Thu, 4 Jul 2019 02:08:02 -0700 (PDT)
Message-ID: <156223128170.21218.10672070400569105866@c4a48874b076>
In-Reply-To: <20190703085416.21837-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 4 Jul 2019 02:08:02 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PULL 0/4] Vga 20190703 patches
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
Cc: peter.maydell@linaro.org, mst@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, kraxel@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMzA4NTQxNi4yMTgz
Ny0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA3MDMwODU0MTYuMjE4Mzct
MS1rcmF4ZWxAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BVTEwgMC80XSBWZ2Eg
MjAxOTA3MDMgcGF0Y2hlcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApn
aXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVw
ZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRw
czovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAg
cGF0Y2hldy8yMDE5MDcwNDA4MzY0Ny4zMDYxNC0xLWNoZW4uemhhbmdAaW50ZWwuY29tIC0+IHBh
dGNoZXcvMjAxOTA3MDQwODM2NDcuMzA2MTQtMS1jaGVuLnpoYW5nQGludGVsLmNvbQogKiBbbmV3
IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTkwNzA0MDg0MTE1LjI0NzEzLTEtbHZpdmllckByZWRo
YXQuY29tIC0+IHBhdGNoZXcvMjAxOTA3MDQwODQxMTUuMjQ3MTMtMS1sdml2aWVyQHJlZGhhdC5j
b20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
Y2hlY2twYXRjaC5wbDogbm8gcmV2aXNpb25zIHJldHVybmVkIGZvciByZXZsaXN0ICcxJwo9PT0g
T1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAyNTUKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNzAz
MDg1NDE2LjIxODM3LTEta3JheGVsQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


