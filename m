Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB41EC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFF72189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 08:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFF72189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiwlj-0003CR-Mn
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 04:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51505)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hiwku-0002Uo-IA
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hiwks-0007jj-Qx
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 04:06:12 -0400
Resent-Date: Thu, 04 Jul 2019 04:06:12 -0400
Resent-Message-Id: <E1hiwks-0007jj-Qx@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hiwks-0007ia-Ij; Thu, 04 Jul 2019 04:06:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562227510; cv=none; d=zoho.com; s=zohoarc; 
 b=LyPR9PX4g91GVxYrRs82oBXv3JQ2Ib8dFR6GoxjbpM/xoieClM24Jw1WV5/eql6ufqpzS3FdLVqUrEc6ExR8t38yoVE58nQzg6uGCbciJuNdfoucsTIqh67bMakPwdpvjqSFXpqt4o6/mPFPT3sbnJ69KGMLo7IVrpW9vUa6S3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562227510;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=0hrJdJsUEiclc3/L/9oz3wKB+Lwun6WJQ1SLIuoeCZw=; 
 b=ADaTu+EMCVLZ8qMAj8+kVusLKYLd4Sshbpt/sFI/algjujBoXYq0oI/X4qElRvN0A2SJpRkz6mB0PGoK6+/NULPQbDP28FcTs5Ha8g9ViyBLFHsdp6LIkzqkDtcnz9slHpsQhJOaqsE931hDxaECRzWKEpZI24gNekrMrS06G54=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562227507859290.5570158904585;
 Thu, 4 Jul 2019 01:05:07 -0700 (PDT)
Message-ID: <156222750645.21218.4512744542143739311@c4a48874b076>
In-Reply-To: <20190703085416.21837-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 4 Jul 2019 01:05:07 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
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
czovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgYzIwNGUzNC4uZjA1NzdjNiAg
bWFzdGVyICAgICAtPiBtYXN0ZXIKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDE5MDcw
MzA4NTQxNi4yMTgzNy0xLWtyYXhlbEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAxOTA3MDMwODU0
MTYuMjE4MzctMS1rcmF4ZWxAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCgo9PT0gT1VUUFVUIEJFR0lOID09PQpjaGVja3BhdGNoLnBsOiBubyByZXZpc2lvbnMgcmV0
dXJuZWQgZm9yIHJldmxpc3QgJzEnCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDI1NQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA3MDMwODU0MTYuMjE4MzctMS1rcmF4ZWxAcmVkaGF0LmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


