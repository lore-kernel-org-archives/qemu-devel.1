Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F83C4646B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DAF2133F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 05:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DAF2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg0ff-0003m9-I9
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 01:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hg0eQ-0003E4-Ss
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hg0eP-0002UB-NO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:39:22 -0400
Resent-Date: Wed, 26 Jun 2019 01:39:22 -0400
Resent-Message-Id: <E1hg0eP-0002UB-NO@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hg0eP-0002TN-Fx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 01:39:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561527505; cv=none; d=zoho.com; s=zohoarc; 
 b=Gj5aKEw8AMKwIjzXJwlwfo78RpyPjDyifea9tMSuY+N4mab/H8flLodxRgA1bgTdCXHQgesvuywS9u1G0N+f8axsR5UzpnSSR+JNd+cCAA5E21hYP4W4fZKPEkKPOCHP+a55xwh64M5LzWxKMvAipGj2c+p1jJ9zSv8icy/TUf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561527505;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=2Pp2Fik+JNy8L0F4BFT8mgLxFrqAdLG3BK7EyR0//D0=; 
 b=DqI/63V+TlL/sCZpop7yuoUNYCUI7yzEKhthyzijigIBYpKcE7qg9EaGbUo9CvrjPei3JilmduYMbHALhf7bHIJ/9kazKchdjJu+YQCnCNyON3ciqOrEfZlZBeayPBMx1VC3cZK8Ltk+KuxHRiDtein9D7odmkxBeIBCZM2t66o=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561527504375137.51994354852354;
 Tue, 25 Jun 2019 22:38:24 -0700 (PDT)
Message-ID: <156152750324.6332.18067610008811555832@c4a48874b076>
In-Reply-To: <20190626051903.26829-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sjitindarsingh@gmail.com
Date: Tue, 25 Jun 2019 22:38:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH v2] powerpc/spapr: Add host
 threads parameter to ibm, get_system_parameter
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, groug@kaod.org,
 sjitindarsingh@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNjA1MTkwMy4yNjgy
OS0xLXNqaXRpbmRhcnNpbmdoQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA2MjYwNTE5MDMuMjY4MjktMS1zaml0
aW5kYXJzaW5naEBnbWFpbC5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UUVNVS1QUENdIFtQQVRDSCB2Ml0gcG93ZXJwYy9zcGFwcjogQWRkIGhvc3QgdGhyZWFkcyBwYXJh
bWV0ZXIgdG8gaWJtLCBnZXRfc3lzdGVtX3BhcmFtZXRlcgoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODMzNTBhOCBw
b3dlcnBjL3NwYXByOiBBZGQgaG9zdCB0aHJlYWRzIHBhcmFtZXRlciB0byBpYm0sIGdldF9zeXN0
ZW1fcGFyYW1ldGVyCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogYnJhY2VzIHt9IGFyZSBu
ZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVtZW50CiM0MjogRklMRTogaHcvcHBj
L3NwYXByX3J0YXMuYzoyNDM6CisgICAgaWYgKCFrdm1fZW5hYmxlZCgpKQpbLi4uXQoKRVJST1I6
IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAoj
NDc6IEZJTEU6IGh3L3BwYy9zcGFwcl9ydGFzLmM6MjQ4OgorICAgIGlmICghZGlyKQpbLi4uXQoK
RVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRl
bWVudAojNzI6IEZJTEU6IGh3L3BwYy9zcGFwcl9ydGFzLmM6MjczOgorICAgICAgICBpZiAoc3Vi
Y29yZXMpClsuLi5dCgp0b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3MsIDcxIGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCA4MzM1MGE4ZmYwYzggKHBvd2VycGMvc3BhcHI6IEFkZCBob3N0IHRocmVhZHMg
cGFyYW1ldGVyIHRvIGlibSwgZ2V0X3N5c3RlbV9wYXJhbWV0ZXIpIGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMTkwNjI2MDUxOTAzLjI2ODI5LTEtc2ppdGluZGFyc2luZ2hAZ21haWwuY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


