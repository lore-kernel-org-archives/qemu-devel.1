Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C3FC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B5A207E0
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B5A207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDx85-0004Yj-5P
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iDx6d-0003kv-Tt
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iDx6c-00039d-7B
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:44:47 -0400
Resent-Date: Fri, 27 Sep 2019 16:44:47 -0400
Resent-Message-Id: <E1iDx6c-00039d-7B@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iDx6c-00039I-0P
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:44:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569617067; cv=none; d=zoho.com; s=zohoarc; 
 b=g1LXs+dJpx8rY7zhB1NRlRD2OeWLLWqSfitO4/sTdDszgC4iCBwDocU/FVlWRnbtSI6mxxVKws56Wl9TYK75tGApWWOXKcOG8LvgK/lzk0lqc/fsfnPc9XOZ/45ZlHBcmiEDMIXzTyGf0ZM1Hcf3BuyuKYH3s/Ejo83eVT4hC3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569617067;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=8/4C6S05Nt3cDBAs3WXZF/DIl+H63kIVLv2VdunhSxg=; 
 b=eR1joMoLyUZ/GemslE88FswKZZ5jZkqQ1rTyKQsgSrlqBCARedOdnNcVYs7WGJ7A/sF+IuR/3w8viqoGiY1vr48gZc2xTXAsX9glaE9H7ef4fSY6yFMjw8Wb9G35XfGZ3YxYUJ2fgIfT6XEX7CRZtI7fFkk5vmeLE3WAINTKfuI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569617065395724.0098594541859;
 Fri, 27 Sep 2019 13:44:25 -0700 (PDT)
Subject: Re: [PATCH V2] intel_iommu: TM field should not be in reserved bits
In-Reply-To: <20190927045838.2968-1-qi1.zhang@intel.com>
Message-ID: <156961706401.27524.9579172239216591794@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qi1.zhang@intel.com
Date: Fri, 27 Sep 2019 13:44:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: qi1.zhang@intel.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNzA0NTgzOC4yOTY4
LTEtcWkxLnpoYW5nQGludGVsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwOTI3MDQ1ODM4LjI5Njgt
MS1xaTEuemhhbmdAaW50ZWwuY29tClN1YmplY3Q6IFtQQVRDSCBWMl0gaW50ZWxfaW9tbXU6IFRN
IGZpZWxkIHNob3VsZCBub3QgYmUgaW4gcmVzZXJ2ZWQgYml0cwoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNGNkNTA1
YiBpbnRlbF9pb21tdTogVE0gZmllbGQgc2hvdWxkIG5vdCBiZSBpbiByZXNlcnZlZCBiaXRzCgo9
PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzI2OiBG
SUxFOiBody9pMzg2L2ludGVsX2lvbW11LmM6MzU1MToKKyAgICB2dGRfcGFnaW5nX2VudHJ5X3Jz
dmRfZmllbGRbMV0gPSBWVERfU1BURV9QQUdFX0wxX1JTVkRfTUFTSyhzLT5hd19iaXRzLCB4ODZf
aW9tbXUtPmR0X3N1cHBvcnRlZCk7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzI3
OiBGSUxFOiBody9pMzg2L2ludGVsX2lvbW11LmM6MzU1MjoKKyAgICB2dGRfcGFnaW5nX2VudHJ5
X3JzdmRfZmllbGRbMl0gPSBWVERfU1BURV9QQUdFX0wyX1JTVkRfTUFTSyhzLT5hd19iaXRzLCB4
ODZfaW9tbXUtPmR0X3N1cHBvcnRlZCk7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMK
IzI4OiBGSUxFOiBody9pMzg2L2ludGVsX2lvbW11LmM6MzU1MzoKKyAgICB2dGRfcGFnaW5nX2Vu
dHJ5X3JzdmRfZmllbGRbM10gPSBWVERfU1BURV9QQUdFX0wzX1JTVkRfTUFTSyhzLT5hd19iaXRz
LCB4ODZfaW9tbXUtPmR0X3N1cHBvcnRlZCk7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3Rl
cnMKIzMzOiBGSUxFOiBody9pMzg2L2ludGVsX2lvbW11LmM6MzU1NToKKyAgICB2dGRfcGFnaW5n
X2VudHJ5X3JzdmRfZmllbGRbNV0gPSBWVERfU1BURV9MUEFHRV9MMV9SU1ZEX01BU0socy0+YXdf
Yml0cywgeDg2X2lvbW11LT5kdF9zdXBwb3J0ZWQpOwoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFy
YWN0ZXJzCiMzNDogRklMRTogaHcvaTM4Ni9pbnRlbF9pb21tdS5jOjM1NTY6CisgICAgdnRkX3Bh
Z2luZ19lbnRyeV9yc3ZkX2ZpZWxkWzZdID0gVlREX1NQVEVfTFBBR0VfTDJfUlNWRF9NQVNLKHMt
PmF3X2JpdHMsIHg4Nl9pb21tdS0+ZHRfc3VwcG9ydGVkKTsKCkVSUk9SOiBsaW5lIG92ZXIgOTAg
Y2hhcmFjdGVycwojMzU6IEZJTEU6IGh3L2kzODYvaW50ZWxfaW9tbXUuYzozNTU3OgorICAgIHZ0
ZF9wYWdpbmdfZW50cnlfcnN2ZF9maWVsZFs3XSA9IFZURF9TUFRFX0xQQUdFX0wzX1JTVkRfTUFT
SyhzLT5hd19iaXRzLCB4ODZfaW9tbXUtPmR0X3N1cHBvcnRlZCk7CgpFUlJPUjogc3BhY2VzIHJl
cXVpcmVkIGFyb3VuZCB0aGF0ICc/JyAoY3R4OlZ4RSkKIzQ5OiBGSUxFOiBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmg6MzkxOgorICAgICAgICBkdF9zdXBwb3J0ZWQ/IFwKICAgICAgICAg
ICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPycgKGN0
eDpWeEUpCiM1NDogRklMRTogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oOjM5NToKKyAg
ICAgICAgZHRfc3VwcG9ydGVkPyBcCiAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFj
ZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz8nIChjdHg6VnhFKQojNTk6IEZJTEU6IGh3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaDozOTk6CisgICAgICAgIGR0X3N1cHBvcnRlZD8gXAogICAg
ICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc/
JyAoY3R4OlZ4RSkKIzY2OiBGSUxFOiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmg6NDA1
OgorICAgICAgICBkdF9zdXBwb3J0ZWQ/IFwKICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6
IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPycgKGN0eDpWeEUpCiM3MTogRklMRTogaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oOjQwOToKKyAgICAgICAgZHRfc3VwcG9ydGVkPyBc
CiAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRo
YXQgJz8nIChjdHg6VnhFKQojNzY6IEZJTEU6IGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aDo0MTM6CisgICAgICAgIGR0X3N1cHBvcnRlZD8gXAogICAgICAgICAgICAgICAgICAgICBeCgp0
b3RhbDogMTIgZXJyb3JzLCAwIHdhcm5pbmdzLCA2MiBsaW5lcyBjaGVja2VkCgpDb21taXQgNGNk
NTA1YjgzY2FjIChpbnRlbF9pb21tdTogVE0gZmllbGQgc2hvdWxkIG5vdCBiZSBpbiByZXNlcnZl
ZCBiaXRzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkyNzA0NTgzOC4yOTY4LTEtcWkxLnpo
YW5nQGludGVsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


