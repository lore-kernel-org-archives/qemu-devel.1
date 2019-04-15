Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55EDC10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 869622073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869622073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG0iv-0004NT-R1
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 08:28:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0i8-00045q-VV
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG0i7-0005mU-TD
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:27:44 -0400
Resent-Date: Mon, 15 Apr 2019 08:27:44 -0400
Resent-Message-Id: <E1hG0i7-0005mU-TD@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hG0i7-0005mK-Lk
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555331228; cv=none; d=zoho.com; s=zohoarc; 
	b=eoSRvVNGcAsMsq2HfQkeLiD2D/B7KqK05MmLK1f2OFpxd3Axv55u1TMUsbQ20ErfS/Ap85sBGA3oRmxDu64Wh/0tGMHZK8m7+ushJBpAepnPQvWfdSgqPnKUwkz8Jhs8ZtR2w8B1dCiRG2YDG5YNUSj62lr2plx1Qvqc9qsHXU0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555331228;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=Fohi1WGi+ZEgN9ojN/ivss8FIuU/vC9LcDAWdPA3wqc=; 
	b=EcuIRZf/VP40fN6yzCRwtBEdfP8TnyF3F8+JeSKtuLMCI3ANKqpg9QDddJT2hLwNN1gybVv1nV+BZPP8bp19CG1vMZ1runk/wq4Twlt/Y/1mi2Mu1lyJYETPvYo+gvYLOagrGxUP6hts/sdaFtE9s7A8iBg3iXXGMPuATKZIlHs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555331225979141.32048747119745;
	Mon, 15 Apr 2019 05:27:05 -0700 (PDT)
Message-ID: <155533122467.29694.15903663744275078359@76452e4e88f2>
In-Reply-To: <20190415121740.9881-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dgilbert@redhat.com
Date: Mon, 15 Apr 2019 05:27:05 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v3] slirp: Gcc 9 -O3 fix
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
Cc: fam@euphon.net, jan.kiszka@siemens.com, qemu-devel@nongnu.org,
	samuel.thibault@gnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415122705.ai90EzqtNCkr1aiL7wTiBbVwhY5Z2COXXbrJlk4J0nA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNTEyMTc0MC45ODgx
LTEtZGdpbGJlcnRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MTUxMjE3NDAuOTg4MS0xLWRnaWxiZXJ0QHJl
ZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2M10gc2xpcnA6IEdjYyA5IC1P
MyBmaXgKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAg
ICAgICAgICBwYXRjaGV3LzIwMTkwNDE1MTIxNzQwLjk4ODEtMS1kZ2lsYmVydEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAxOTA0MTUxMjE3NDAuOTg4MS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpkZDY3ZmJhYTQwIHNsaXJwOiBHY2MgOSAtTzMg
Zml4Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiMyMjogRklMRTogc2xpcnAvc3JjL3NvY2tldC5jOjE3NDoKK15Jc2l6ZV90IGJ1
Zl9sZW47JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzE6IEZJ
TEU6IHNsaXJwL3NyYy9zb2NrZXQuYzoxODU6CiteSWJ1Zl9sZW4gPSBzb3ByZXByYnVmKHNvLCBp
b3YsICZuKTskCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzMjog
RklMRTogc2xpcnAvc3JjL3NvY2tldC5jOjE4NjoKK15JYXNzZXJ0KGJ1Zl9sZW4gIT0gMCk7JAoK
RVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDA6IEZJTEU6IHNsaXJw
L3NyYy9zb2NrZXQuYzoyNjI6CiteSWFzc2VydChzaXplID4gMCk7JAoKdG90YWw6IDQgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAyMyBsaW5lcyBjaGVja2VkCgpDb21taXQgZGQ2N2ZiYWE0MDAzIChzbGly
cDogR2NjIDkgLU8zIGZpeCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MTUxMjE3NDAuOTg4
MS0xLWRnaWxiZXJ0QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


