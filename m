Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A70C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 23:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0032074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 23:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0032074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMgek-0001Oc-B4
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 19:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jMge2-0000wt-T0
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 19:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jMgdy-0007JO-Ax
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 19:31:38 -0400
Resent-Date: Thu, 09 Apr 2020 19:31:35 -0400
Resent-Message-Id: <E1jMgdy-0007JO-Ax@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jMgdy-0007Io-5s
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 19:31:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586475087; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Gnf94TVfd3ozz5Q74zaSQH/LeAgFzKd4juzYNFEkkoAE10dEOQ7/IYHDJ9Gz37m2w689EEUi5WVoQdMUoJ5O2VftEdB7MDHiEJeyfdw2q3mD3esSYUw8V/uGgsa7F4Ot+EMoWZKIHMbCK8apDyOXmOijSfZQdRjNirjxw24r1h4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586475087;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+UmPFczc68RQDYJykJfxvqipdSoX5/yVP2UVlvG7hjQ=; 
 b=R+aklqn25QGHq+2GWxPRP9pukCQSIJZdyx92YidFst3aTbgZliB9yJLNrxNCY9feV6qHhBKjEUYHxyNv7ygShmNeqKW7imW6mbBfV1zwpFP5KQMCDnWfKtCv1+eBNciISSbImPf+va+yiHUXwwM7CWq+kN8ewxWGARkIrUQSLqU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586475085732228.21149341721127;
 Thu, 9 Apr 2020 16:31:25 -0700 (PDT)
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
Subject: Re: [PATCH for 5.0-rc3 v1 00/11] more random fixes
Message-ID: <158647508454.23508.6145580992517458969@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Thu, 9 Apr 2020 16:31:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwOTIxMTUyOS41MjY5
LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIGZvciA1LjAtcmMzIHYxIDAwLzExXSBtb3Jl
IHJhbmRvbSBmaXhlcwpNZXNzYWdlLWlkOiAyMDIwMDQwOTIxMTUyOS41MjY5LTEtYWxleC5iZW5u
ZWVAbGluYXJvLm9yZwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjI3NzliYWUgLnRyYXZpcy55
bWw6IEJ1aWxkIE9TWCAxMC4xNCB3aXRoIFhjb2RlIDEwLjAKZmZhNjllZSBsaW51eC11c2VyOiBm
aXggL3Byb2Mvc2VsZi9zdGF0IGhhbmRsaW5nCmRhNzM0OTYgZ2Ric3R1YjogaTM4NjogRml4IGdk
Yl9nZXRfcmVnMTYoKSBwYXJhbWV0ZXIgdG8gdW5icmVhayBnZGIKYTczOTJkYiB0YXJnZXQvbTY4
ay9oZWxwZXI6IEZpeCBtNjhrX2ZwdV9nZGJfZ2V0X3JlZygpIHVzZSBvZiBHQnl0ZUFycmF5CjZj
ZGJlNGIgY29uZmlndXJlOiBkaXNhYmxlIFBJRSBmb3IgV2luZG93cyBidWlsZHMKZTcwYjQxYSBj
b25maWd1cmU6IHJlZGlyZWN0IHNwaGlueC1idWlsZCBjaGVjayB0byBjb25maWcubG9nCjg0YjAw
MjYgdGVzdHMvZG9ja2VyOiBhZGQgZG9jcyBGRUFUVVJFIGZsYWcgYW5kIHVzZSBmb3IgdGVzdC1t
aXNjCmU5OTE2MzAgbGludXgtdXNlci9wcGM6IEZpeCBwYWRkaW5nIGluIG1jb250ZXh0X3QgZm9y
IHBwYzY0CjNmZTAwMTUgYWNjZWwvdGNnOiBSZWxheCB2YSByZXN0cmljdGlvbnMgb24gNjQtYml0
IGd1ZXN0cwozYTUwNDE0IGV4ZWMvY3B1LWFsbDogVXNlIGJvb2wgZm9yIGhhdmVfZ3Vlc3RfYmFz
ZQo4MzI3ZDAxIGxpbnV4LXVzZXI6IGNvbXBsZXRlbHkgcmUtd3JpdGUgaW5pdF9ndWVzdF9zcGFj
ZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMSBDaGVja2luZyBjb21taXQgODMyN2QwMTgzZDg0
IChsaW51eC11c2VyOiBjb21wbGV0ZWx5IHJlLXdyaXRlIGluaXRfZ3Vlc3Rfc3BhY2UpCkVSUk9S
OiB0cmFpbGluZyB3aGl0ZXNwYWNlCiM3MTU6IEZJTEU6IGxpbnV4LXVzZXIvcWVtdS5oOjIyOToK
KyAqICQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNjgxIGxpbmVzIGNoZWNrZWQKClBh
dGNoIDEvMTEgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvMTEgQ2hlY2tpbmcgY29tbWl0
IDNhNTA0MTQzYzc3MCAoZXhlYy9jcHUtYWxsOiBVc2UgYm9vbCBmb3IgaGF2ZV9ndWVzdF9iYXNl
KQozLzExIENoZWNraW5nIGNvbW1pdCAzZmUwMDE1MWMwZTMgKGFjY2VsL3RjZzogUmVsYXggdmEg
cmVzdHJpY3Rpb25zIG9uIDY0LWJpdCBndWVzdHMpCkVSUk9SOiBNYWNyb3Mgd2l0aCBjb21wbGV4
IHZhbHVlcyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gcGFyZW50aGVzaXMKIzkxOiBGSUxFOiBpbmNs
dWRlL2V4ZWMvY3B1LWFsbC5oOjE4MjoKKyMgZGVmaW5lIEdVRVNUX0FERFJfTUFYXyAgfjB1bAoK
dG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4OCBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzEx
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzExIENoZWNraW5nIGNvbW1pdCBlOTkxNjMw
OTkwMjIgKGxpbnV4LXVzZXIvcHBjOiBGaXggcGFkZGluZyBpbiBtY29udGV4dF90IGZvciBwcGM2
NCkKNS8xMSBDaGVja2luZyBjb21taXQgODRiMDAyNjgwYmEwICh0ZXN0cy9kb2NrZXI6IGFkZCBk
b2NzIEZFQVRVUkUgZmxhZyBhbmQgdXNlIGZvciB0ZXN0LW1pc2MpCjYvMTEgQ2hlY2tpbmcgY29t
bWl0IGU3MGI0MWE0YWMxZSAoY29uZmlndXJlOiByZWRpcmVjdCBzcGhpbngtYnVpbGQgY2hlY2sg
dG8gY29uZmlnLmxvZykKNy8xMSBDaGVja2luZyBjb21taXQgNmNkYmU0YmNkYjZiIChjb25maWd1
cmU6IGRpc2FibGUgUElFIGZvciBXaW5kb3dzIGJ1aWxkcykKOC8xMSBDaGVja2luZyBjb21taXQg
YTczOTJkYjNlMDkxICh0YXJnZXQvbTY4ay9oZWxwZXI6IEZpeCBtNjhrX2ZwdV9nZGJfZ2V0X3Jl
ZygpIHVzZSBvZiBHQnl0ZUFycmF5KQo5LzExIENoZWNraW5nIGNvbW1pdCBkYTczNDk2ZTVhZmQg
KGdkYnN0dWI6IGkzODY6IEZpeCBnZGJfZ2V0X3JlZzE2KCkgcGFyYW1ldGVyIHRvIHVuYnJlYWsg
Z2RiKQoxMC8xMSBDaGVja2luZyBjb21taXQgZmZhNjllZTAzZTYzIChsaW51eC11c2VyOiBmaXgg
L3Byb2Mvc2VsZi9zdGF0IGhhbmRsaW5nKQoxMS8xMSBDaGVja2luZyBjb21taXQgMjc3OWJhZWY0
ZjE0ICgudHJhdmlzLnltbDogQnVpbGQgT1NYIDEwLjE0IHdpdGggWGNvZGUgMTAuMCkKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDkyMTE1
MjkuNTI2OS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

