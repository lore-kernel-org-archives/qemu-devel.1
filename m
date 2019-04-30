Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9147EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6691D2087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6691D2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcIt-0001Sr-KW
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:36:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLcGv-00088n-IV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLcGu-0000Wc-AA
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:34:49 -0400
Resent-Date: Tue, 30 Apr 2019 19:34:49 -0400
Resent-Message-Id: <E1hLcGu-0000Wc-AA@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLcGu-0000W3-1v; Tue, 30 Apr 2019 19:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556667270; cv=none; d=zoho.com; s=zohoarc; 
	b=e+pLLbb6xbGzLdVcNeRxrPYZ3/0FtiOAFZaDXQQb/iHgEQIx3ljaoBGdXZqAVYkuACpDYdVmKQX0i/bkMWHBi3FfDpSTevHt2L7+tZLy4WLxnDBoagPLfc7KoSm4V481U+HZvIeinTiDh593KHOiR4KQcbtxOCntuXUyBysxkX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556667270;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=IutWLPpO3rFHaajsfycJl5ax9DNR64o9DwSkm33WBMo=; 
	b=OuTsmCoxwPUQS1blz3c6zTKcS1b5N/DpD59Hx72eKFfYH2qEMszyXMLLsaWEl8wbvn2COreLRcimaSjp206+1IL7y31REdEgvyVqYusAcJRwbNqcxWNwtVKjm6wjsuRd3oYIqXZ7mhFeO+f4IyxVM9M4+DHrRaa8cN621hVe2mU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556667269463363.6905693799648;
	Tue, 30 Apr 2019 16:34:29 -0700 (PDT)
In-Reply-To: <20190430231536.25353-1-jsnow@redhat.com>
Message-ID: <155666726797.10667.16771870824759307989@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Tue, 30 Apr 2019 16:34:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH RFC] migration/dirty-bitmaps: change bitmap
 enumeration method
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
	quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
	stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430233429.StNR3IEwkPlqdjHJhM2XryUfDe1zNeLPyJwiclILx-U@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQzMDIzMTUzNi4yNTM1
My0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDQzMDIzMTUzNi4yNTM1My0x
LWpzbm93QHJlZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCBSRkNdIG1pZ3Jh
dGlvbi9kaXJ0eS1iaXRtYXBzOiBjaGFuZ2UgYml0bWFwIGVudW1lcmF0aW9uIG1ldGhvZAoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hl
dy1wcm9qZWN0L3FlbXUKIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQy
NDEwMzc0Ny4xMDE3My0xLXRodXRoQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQyNDEwMzc0
Ny4xMDE3My0xLXRodXRoQHJlZGhhdC5jb20KICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0
Y2hldy8yMDE5MDQzMDIzMTUzNi4yNTM1My0xLWpzbm93QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8y
MDE5MDQzMDIzMTUzNi4yNTM1My0xLWpzbm93QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcg
YnJhbmNoICd0ZXN0Jwo2YzQ1YzNmYmQ0IG1pZ3JhdGlvbi9kaXJ0eS1iaXRtYXBzOiBjaGFuZ2Ug
Yml0bWFwIGVudW1lcmF0aW9uIG1ldGhvZAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IE1p
c3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAzOCBsaW5lcyBjaGVja2VkCgpDb21taXQgNmM0NWMzZmJkNDdkIChtaWdyYXRpb24vZGlydHkt
Yml0bWFwczogY2hhbmdlIGJpdG1hcCBlbnVtZXJhdGlvbiBtZXRob2QpIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMTkwNDMwMjMxNTM2LjI1MzUzLTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


