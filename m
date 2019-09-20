Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE088C4CECD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A672070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 08:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A672070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBESW-000375-Uu
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 04:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iBEQM-0001HR-7D
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iBEQK-0002Uw-I7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:37:53 -0400
Resent-Date: Fri, 20 Sep 2019 04:37:53 -0400
Resent-Message-Id: <E1iBEQK-0002Uw-I7@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iBEQK-0002S2-BE
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 04:37:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568968661; cv=none; d=zoho.com; s=zohoarc; 
 b=PajaabaT/Ii9jPpAIzN1zf1QA1IcV3vBymO7sD0FL4N/tp9qCbmljFqAua++XlfdpxIQ/VmGrrM5A7/EzUjI4i2mdfHd/Ad9aqusxV+UzSY0K3IdW4SrGvgTSdC9UpG5CK0amz4tTPiGC03n5ssELFVn77AQ4oewgWMncbDXW6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568968661;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=v/qPoq7tMgYKqWQBa8diZCv8I1fuL6Qm+vQ/9fuSSEI=; 
 b=dc5ucsPnmyyk4tMVcgK4GmieMck6lb1ZSDxfxtk8I0NBVMvthZF5nYsWL2W6lvfywoul+afm38a0QlUWN2dazM2PSUYdEx7H+s3v3PElo+nEpC7JUiZ+hmU6hpbWJ8+ohBgUY33IuDMEOh8uxDXAyipcORBnWGZiqwB62M3Wh1c=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568968660492437.8497847561687;
 Fri, 20 Sep 2019 01:37:40 -0700 (PDT)
In-Reply-To: <20190919091043.24503-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/2] Ati 20190919 patches
Message-ID: <156896865960.4246.8851490343337518889@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Fri, 20 Sep 2019 01:37:40 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxOTA5MTA0My4yNDUw
My0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDkxOTA5MTA0My4yNDUwMy0xLWtyYXhlbEByZWRo
YXQuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUFVMTCAwLzJdIEF0aSAyMDE5MDkxOSBwYXRj
aGVzClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApn
aXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVl
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2No
ZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVw
ZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRw
czovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAg
cGF0Y2hldy8yMDE5MDkyMDA4MjU0My4yMzQ0NC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbSAt
PiBwYXRjaGV3LzIwMTkwOTIwMDgyNTQzLjIzNDQ0LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29t
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKCj09PSBPVVRQVVQgQkVHSU4gPT09CmNo
ZWNrcGF0Y2gucGw6IG5vIHJldmlzaW9ucyByZXR1cm5lZCBmb3IgcmV2bGlzdCAnMScKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMjU1CgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxOTA5
MTA0My4yNDUwMy0xLWtyYXhlbEByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


