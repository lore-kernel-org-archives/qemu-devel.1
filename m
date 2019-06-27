Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B05C48BE4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 18:44:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237D22075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 18:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237D22075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgZNV-0002WQ-Tg
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 14:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgZKw-00017A-C5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 14:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgZKv-0008ON-6q
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 14:41:34 -0400
Resent-Date: Thu, 27 Jun 2019 14:41:34 -0400
Resent-Message-Id: <E1hgZKv-0008ON-6q@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgZKv-0008Mv-08
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 14:41:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561660837; cv=none; d=zoho.com; s=zohoarc; 
 b=k+4NSOfLO0MjFerXoim29t4E29oxt4piYV2fMxaIEkazmYfJasov2AUDjPyFi8OguSvKM/WzmAS6TvFMw7Qhw2iXjumqdDCs+P4awXrzvAwjL6M90bVZUkHR5GNyZyXSJL5bkYUQaxicoIBQe1jQYncJMSCsS1NEsoCb0z3eGho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561660837;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Zvlv6oJhxXoba2z/7jHx0+nhBg69Sy7XK9aW30zQ/78=; 
 b=M/Gf3K0ZVA0Pvd/Nzm70QO5HbdajaSB6N9xx4TUlVg0Dw6DS5092V7XPpLc+ye7myNvMFUqAvDAopBZx3j3EdCACG/P1FoTwmX+343AXrCFoLbVRMrvpTK0iOmbeLk+3PCbGdQ77/oxMeC3Ld5UpTQ3y+SEJ0mfBL3azaDbb87w=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561660829153719.9239068298021;
 Thu, 27 Jun 2019 11:40:29 -0700 (PDT)
Message-ID: <156166082790.6332.2982587489189178304@c4a48874b076>
In-Reply-To: <20190627131252.GA14795@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: w.bumiller@proxmox.com
Date: Thu, 27 Jun 2019 11:40:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] balloon config change seems to break live
 migration from 3.0.1 to 4.0
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNzEzMTI1Mi5HQTE0
Nzk1QG9sZ2EucHJveG1veC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDYyNzEzMTI1Mi5HQTE0Nzk1
QG9sZ2EucHJveG1veC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIGJhbGxvb24gY29uZmlnIGNo
YW5nZSBzZWVtcyB0byBicmVhayBsaXZlIG1pZ3JhdGlvbiBmcm9tIDMuMC4xIHRvIDQuMAoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29t
L3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAxOTA2
MjcxMzEyNTIuR0ExNDc5NUBvbGdhLnByb3htb3guY29tIC0+IHBhdGNoZXcvMjAxOTA2MjcxMzEy
NTIuR0ExNDc5NUBvbGdhLnByb3htb3guY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVz
dCcKMTZlZWFjYSBiYWxsb29uIGNvbmZpZyBjaGFuZ2Ugc2VlbXMgdG8gYnJlYWsgbGl2ZSBtaWdy
YXRpb24gZnJvbSAzLjAuMSB0byA0LjAKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBkbyBu
b3QgdXNlIEM5OSAvLyBjb21tZW50cwojMTI3OiBGSUxFOiBody92aXJ0aW8vdmlydGlvLWJhbGxv
b24uYzo2MjY6CisgICAgLy9pZiAoZGV2LT5mcmVlX3BhZ2VfcmVwb3J0X3N0YXR1cyA9PSBGUkVF
X1BBR0VfUkVQT1JUX1NfUkVRVUVTVEVEKSB7CgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29t
bWVudHMKIzEyODogRklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6NjI3OgorICAgIC8v
ICAgIGNvbmZpZy5mcmVlX3BhZ2VfcmVwb3J0X2NtZF9pZCA9CgpFUlJPUjogZG8gbm90IHVzZSBD
OTkgLy8gY29tbWVudHMKIzEyOTogRklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6NjI4
OgorICAgIC8vICAgICAgICAgICAgICAgICAgIGNwdV90b19sZTMyKGRldi0+ZnJlZV9wYWdlX3Jl
cG9ydF9jbWRfaWQpOwoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMxMzA6IEZJ
TEU6IGh3L3ZpcnRpby92aXJ0aW8tYmFsbG9vbi5jOjYyOToKKyAgICAvL30gZWxzZSBpZiAoZGV2
LT5mcmVlX3BhZ2VfcmVwb3J0X3N0YXR1cyA9PSBGUkVFX1BBR0VfUkVQT1JUX1NfU1RPUCkgewoK
RVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMxMzE6IEZJTEU6IGh3L3ZpcnRpby92
aXJ0aW8tYmFsbG9vbi5jOjYzMDoKKyAgICAvLyAgICBjb25maWcuZnJlZV9wYWdlX3JlcG9ydF9j
bWRfaWQgPQoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiMxMzI6IEZJTEU6IGh3
L3ZpcnRpby92aXJ0aW8tYmFsbG9vbi5jOjYzMToKKyAgICAvLyAgICAgICAgICAgICAgICAgICBj
cHVfdG9fbGUzMihWSVJUSU9fQkFMTE9PTl9DTURfSURfU1RPUCk7CgpFUlJPUjogZG8gbm90IHVz
ZSBDOTkgLy8gY29tbWVudHMKIzEzMzogRklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6
NjMyOgorICAgIC8vfSBlbHNlIGlmIChkZXYtPmZyZWVfcGFnZV9yZXBvcnRfc3RhdHVzID09IEZS
RUVfUEFHRV9SRVBPUlRfU19ET05FKSB7CgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVu
dHMKIzEzNDogRklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6NjMzOgorICAgIC8vICAg
IGNvbmZpZy5mcmVlX3BhZ2VfcmVwb3J0X2NtZF9pZCA9CgpFUlJPUjogZG8gbm90IHVzZSBDOTkg
Ly8gY29tbWVudHMKIzEzNTogRklMRTogaHcvdmlydGlvL3ZpcnRpby1iYWxsb29uLmM6NjM0Ogor
ICAgIC8vICAgICAgICAgICAgICAgICAgIGNwdV90b19sZTMyKFZJUlRJT19CQUxMT09OX0NNRF9J
RF9ET05FKTsKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojMTM2OiBGSUxFOiBo
dy92aXJ0aW8vdmlydGlvLWJhbGxvb24uYzo2MzU6CisgICAgLy99CgpFUlJPUjogTWlzc2luZyBT
aWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMTEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzOCBs
aW5lcyBjaGVja2VkCgpDb21taXQgMTZlZWFjYTc4YTE1IChiYWxsb29uIGNvbmZpZyBjaGFuZ2Ug
c2VlbXMgdG8gYnJlYWsgbGl2ZSBtaWdyYXRpb24gZnJvbSAzLjAuMSB0byA0LjApIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkwNjI3MTMxMjUyLkdBMTQ3OTVAb2xnYS5wcm94bW94LmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


