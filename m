Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82ADC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C5B20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 23:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C5B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCuOv-0001Lt-DZ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 19:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iCuNm-0000pG-4R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:38:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iCuNi-0005o2-Ad
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:38:09 -0400
Resent-Date: Tue, 24 Sep 2019 19:38:09 -0400
Resent-Message-Id: <E1iCuNi-0005o2-Ad@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iCuNi-0005kO-5M
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 19:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569361854; cv=none; d=zoho.com; s=zohoarc; 
 b=eefr/HMSwbwFXQ3ZvGHv1tpQOJ3lTrmhO6WKD5BLCOriBJdcsueLVkLjF10aYEWSK94NGFk9HTBLky9nI7xZIKAvkfRZQ2RXFJfsd2gw7dw4BWjHytL/lT9QF9rOco56mO6Fsoo3S5fEP1t7jxiAiGCHSD4ZtXMnWVh4UL6FE+c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569361854;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=La2rQQ0xXp4KEwMUMLWTbzJVepw5JBu+iGkK+aqTOlo=; 
 b=GolA/muBZ52OS0WJTRmkV6YZ1MELw/2/Aq0lWMfaGRARypmrJ7TI+dAzKh2oqodvehYDFZ6Chci8zzAOTZXrvfI99z7yg4K8awvzn4b6YkfIYVKJxcFZkakOUZYtMaGiVetqumSsubpLRFBCIQK6qSQj6PEYduY8VD0I27tVBFQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569361852768218.7507142309155;
 Tue, 24 Sep 2019 14:50:52 -0700 (PDT)
Subject: Re: [PATCH v2] qga: add command guest-get-devices for reporting
 VirtIO devices
In-Reply-To: <95b2f9d76104ee09b43159528b35b96eb01bbd8c.1569329826.git.tgolembi@redhat.com>
Message-ID: <156936185147.1758.2623058237678499300@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tgolembi@redhat.com
Date: Tue, 24 Sep 2019 14:50:52 -0700 (PDT)
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS85NWIyZjlkNzYxMDRlZTA5YjQz
MTU5NTI4YjM1Yjk2ZWIwMWJiZDhjLjE1NjkzMjk4MjYuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20v
CgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9i
bGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmll
cwpNZXNzYWdlLWlkOiA5NWIyZjlkNzYxMDRlZTA5YjQzMTU5NTI4YjM1Yjk2ZWIwMWJiZDhjLjE1
NjkzMjk4MjYuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYyXSBxZ2E6
IGFkZCBjb21tYW5kIGd1ZXN0LWdldC1kZXZpY2VzIGZvciByZXBvcnRpbmcgVmlydElPIGRldmlj
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKNjY2ZDVhZCBxZ2E6IGFkZCBjb21tYW5kIGd1ZXN0LWdldC1kZXZpY2VzIGZvciBy
ZXBvcnRpbmcgVmlydElPIGRldmljZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IGxp
bmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM2NzogRklMRTogcWdhL2NvbW1hbmRzLXdpbjMyLmM6NDc6
CitERUZJTkVfREVWUFJPUEtFWShxZ2FfREVWUEtFWV9OQU1FLCAweGI3MjVmMTMwLCAweDQ3ZWYs
IDB4MTAxYSwgMHhhNSwgMHhmMSwgMHgwMiwKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzCiM2OTogRklMRTogcWdhL2NvbW1hbmRzLXdpbjMyLmM6NDk6CitERUZJTkVfREVWUFJPUEtF
WShxZ2FfREVWUEtFWV9EZXZpY2VfSGFyZHdhcmVJZHMsIDB4YTQ1YzI1NGUsIDB4ZGYxYywgMHg0
ZWZkLCAweDgwLAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzcyOiBGSUxFOiBx
Z2EvY29tbWFuZHMtd2luMzIuYzo1MjoKK0RFRklORV9ERVZQUk9QS0VZKHFnYV9ERVZQS0VZX0Rl
dmljZV9Ecml2ZXJEYXRlLCAweGE4Yjg2NWRkLCAweDJlM2QsIDB4NDA5NCwgMHhhZCwKCkVSUk9S
OiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hWKQojODE6IEZJTEU6IHFn
YS9jb21tYW5kcy13aW4zMi5jOjYxOgorICAgIENPTlNUIERFVlBST1BLRVkgKlByb3BlcnR5S2V5
LAogICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQg
dGhhdCAnKicgKGN0eDpXeFYpCiM4MjogRklMRTogcWdhL2NvbW1hbmRzLXdpbjMyLmM6NjI6Cisg
ICAgREVWUFJPUFRZUEUgICAgICAqUHJvcGVydHlUeXBlLAogICAgICAgICAgICAgICAgICAgICAg
XgoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKycgKGN0eDpWeFYpCiMxMjY6
IEZJTEU6IHFnYS9jb21tYW5kcy13aW4zMi5jOjIyODg6CisgICAgYnVmZmVyID0gZ19tYWxsb2Mo
YnVmZmVyX2xlbisxKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKRVJST1I6
IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKycgKGN0eDpWeFYpCiMxNTk6IEZJTEU6IHFn
YS9jb21tYW5kcy13aW4zMi5jOjIzMjE6CisgICAgaHdfaWRzID0gZ19uZXcoY2hhciosIGNvdW50
KzEpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiAiZm9vKiBiYXIi
IHNob3VsZCBiZSAiZm9vICpiYXIiCiMyMDU6IEZJTEU6IHFnYS9jb21tYW5kcy13aW4zMi5jOjIz
Njc6CisgICAgICAgIGdfYXV0b2ZyZWUgY2hhciogdmVuZG9yX2lkID0gTlVMTDsKCkVSUk9SOiAi
Zm9vKiBiYXIiIHNob3VsZCBiZSAiZm9vICpiYXIiCiMyMDY6IEZJTEU6IHFnYS9jb21tYW5kcy13
aW4zMi5jOjIzNjg6CisgICAgICAgIGdfYXV0b2ZyZWUgY2hhciogZGV2aWNlX2lkID0gTlVMTDsK
CkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz0nIChjdHg6VnhWKQojMjI0OiBG
SUxFOiBxZ2EvY29tbWFuZHMtd2luMzIuYzoyMzg2OgorICAgICAgICBmb3IgKGo9MDsgaHdfaWRz
W2pdICE9IE5VTEw7IGorKykgewogICAgICAgICAgICAgICBeCgp0b3RhbDogNyBlcnJvcnMsIDMg
d2FybmluZ3MsIDI4NiBsaW5lcyBjaGVja2VkCgpDb21taXQgNjY2ZDVhZDBkMTk3IChxZ2E6IGFk
ZCBjb21tYW5kIGd1ZXN0LWdldC1kZXZpY2VzIGZvciByZXBvcnRpbmcgVmlydElPIGRldmljZXMp
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzk1YjJmOWQ3NjEwNGVlMDliNDMxNTk1MjhiMzViOTZlYjAx
YmJkOGMuMTU2OTMyOTgyNi5naXQudGdvbGVtYmlAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


