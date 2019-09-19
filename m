Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA3C4CEC4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 01:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC87120578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 01:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC87120578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAlh4-0004kI-SR
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 21:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAlfv-0003mZ-I9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 21:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAlfu-0003eU-0y
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 21:56:03 -0400
Resent-Date: Wed, 18 Sep 2019 21:56:03 -0400
Resent-Message-Id: <E1iAlfu-0003eU-0y@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAlft-0003ak-DU; Wed, 18 Sep 2019 21:56:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568858095; cv=none; d=zoho.com; s=zohoarc; 
 b=GxCAqkl+8DM4nJ0nwy75z31r3hSuOeGohJ98gI3c9nCUQXd5LuRYhAUy5DcItzYwjf9Agq9ZSQCc2S/qwHOMA4JsLRKyePEaskiJ6RFZrbvqz3+rMlmBCe8AWhF5gUFOlLm7DjWcCm2AX5Ht8P4d2OdD+4OosAv/FxA66OO8P7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568858095;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=g3MUPPNoxnyxxc+tFruon4uQYRok2KBctXnL7EMokb8=; 
 b=eJw38i2hw+q8LhSbTWfiSKQwA4QL/FBAhx7zdIJUOlmWeU0nWsUMnd/yu3MUYUcddvVuh/vGC1hhklP30v8OnXNEpeofPE+XaPnIqnjNgHEkwgHLQytEzc6kBTjU2SnblGYRt667vmoZ/6dVYKG9o5EWZitVsS2zZXhWXtGofBQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568858094046855.4916674348552;
 Wed, 18 Sep 2019 18:54:54 -0700 (PDT)
In-Reply-To: <20190918130244.24257-1-vsementsov@virtuozzo.com>
Message-ID: <156885809062.17151.6266982811357723263@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 18 Sep 2019 18:54:54 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: fam@euphon.net, peter.maydell@linaro.org, mst@redhat.com,
 codyprime@gmail.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com, kraxel@redhat.com, sundeep.lkml@gmail.com,
 qemu-block@nongnu.org, quintela@redhat.com, david@redhat.com,
 armbru@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au, farman@linux.ibm.com,
 groug@kaod.org, dgilbert@redhat.com, alex.williamson@redhat.com,
 qemu-arm@nongnu.org, stefanha@redhat.com, jsnow@redhat.com, rth@twiddle.net,
 kwolf@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxODEzMDI0NC4yNDI1
Ny0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtSRkNdIGVycm9yOiBhdXRv
IHByb3BhZ2F0ZWQgbG9jYWxfZXJyCk1lc3NhZ2UtaWQ6IDIwMTkwOTE4MTMwMjQ0LjI0MjU3LTEt
dnNlbWVudHNvdkB2aXJ0dW96em8uY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMTZlODg3
NCBlcnJvcjogYXV0byBwcm9wYWdhdGVkIGxvY2FsX2VycgoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzI5MTogRklMRTogaW5jbHVkZS9xYXBp
L2Vycm9yLmg6MzkxOgorc3RhdGljIGlubGluZSB2b2lkIGVycm9yX3Byb3BhZ2F0aW9uX3N0cnVj
dF9jbGVhbnVwKEVycm9yUHJvcGFnYXRpb25TdHJ1Y3QgKnByb3ApCgpFUlJPUjogTWFjcm9zIHdp
dGggbXVsdGlwbGUgc3RhdGVtZW50cyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gYSBkbyAtIHdoaWxl
IGxvb3AKIzMwMTogRklMRTogaW5jbHVkZS9xYXBpL2Vycm9yLmg6NDAxOgorI2RlZmluZSBERUZf
QVVUT19FUlJQX1YyKGF1dG9fZXJycCwgZXJycCkgXAorICAgIGdfYXV0byhFcnJvclByb3BhZ2F0
aW9uU3RydWN0KSAoX19hdXRvX2VycnBfcHJvcCkgPSB7LmVycnAgPSAoZXJycCl9OyBcCisgICAg
RXJyb3IgKiphdXRvX2VycnAgPSBcCisgICAgICAgICgoZXJycCkgPT0gTlVMTCB8fCAqKGVycnAp
ID09IGVycm9yX2Fib3J0IHx8ICooZXJycCkgPT0gZXJyb3JfZmF0YWwpID8gXAorICAgICAgICAm
X19hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnIgOiBcCisgICAgICAgIChlcnJwKTsKCkVSUk9SOiBN
YWNyb3Mgd2l0aCBtdWx0aXBsZSBzdGF0ZW1lbnRzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBhIGRv
IC0gd2hpbGUgbG9vcAojMzIwOiBGSUxFOiBpbmNsdWRlL3FhcGkvZXJyb3IuaDo0MjA6CisjZGVm
aW5lIE1BS0VfRVJSUF9TQUZFKGVycnApIFwKK2dfYXV0byhFcnJvclByb3BhZ2F0aW9uU3RydWN0
KSAoX19hdXRvX2VycnBfcHJvcCkgPSB7LmVycnAgPSAoZXJycCl9OyBcCitpZiAoKGVycnApID09
IE5VTEwgfHwgKihlcnJwKSA9PSBlcnJvcl9hYm9ydCB8fCAqKGVycnApID09IGVycm9yX2ZhdGFs
KSB7IFwKKyAgICAoZXJycCkgPSAmX19hdXRvX2VycnBfcHJvcC5sb2NhbF9lcnI7IFwKK30KCnRv
dGFsOiAyIGVycm9ycywgMSB3YXJuaW5ncywgMjc3IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAxNmU4
ODc0OTQ3ZTcgKGVycm9yOiBhdXRvIHByb3BhZ2F0ZWQgbG9jYWxfZXJyKSBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDE5MDkxODEzMDI0NC4yNDI1Ny0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


