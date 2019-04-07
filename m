Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A2C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 18:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A694820896
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 18:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A694820896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42443 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDCxp-0004T6-Sw
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 14:56:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDCx4-00048m-UI
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 14:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hDCx3-0007uz-LN
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 14:55:34 -0400
Resent-Date: Sun, 07 Apr 2019 14:55:34 -0400
Resent-Message-Id: <E1hDCx3-0007uz-LN@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hDCx3-0007eh-AM
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 14:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554663307; cv=none; d=zoho.com; s=zohoarc; 
	b=YwpJe1cJ6A9J9C0T0PAf4q5GIm8LI9Q8ZIJbxEAphJG9lTVqXncDfyQkavhytZx2hxx00Lnv1r7V8ylVluf4/n1VTfiuRJuXJWK7u9r8Qt4ZW8FJjCw1+4I32ff42/E3QivbFg98ZpQFzaZoF61pandR4iEn1PTAc4/Ktf5SXLE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554663307;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=cyk7KapgAu1i8RAx7wP3XO6epHD5WMlkM09UdFVjkwU=; 
	b=PTUjNS0mt/MWCNFReRc9Qm71C7dZ3FQREzWJcwEWFAB6Iw7d/WG94M7TAne2K1Xx0QQ/WmobKAoKMSOGxaGFL46+L75XJJnYdhjFwiWEgClbrv12ocDgcW3s2XmahN22mAGoWr3vAaLgGq7DIdZSsUKKRtwD3HVrVXOBWftcPYU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554663304790236.18341238256755;
	Sun, 7 Apr 2019 11:55:04 -0700 (PDT)
Message-ID: <155466330356.12882.14207478694719549753@76452e4e88f2>
In-Reply-To: <20190407185042.7624-1-sohailalvi2236@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sohailalvi2236@gmail.com
Date: Sun, 7 Apr 2019 11:55:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] set_bit() function added to the source
 code of uncategorized devices and categorizes have been assigne to them.
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
Cc: fam@euphon.net, sohailalvi2236@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407185504.w2uHWNR8CM0iZHukU1n4C-EYn00_AJNnxFuauLmLglE@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQwNzE4NTA0Mi43NjI0
LTEtc29oYWlsYWx2aTIyMzZAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBzZXRfYml0KCkg
ZnVuY3Rpb24gYWRkZWQgdG8gdGhlIHNvdXJjZSBjb2RlIG9mIHVuY2F0ZWdvcml6ZWQgZGV2aWNl
cyBhbmQgY2F0ZWdvcml6ZXMgaGF2ZSBiZWVuIGFzc2lnbmUgdG8gdGhlbS4KVHlwZTogc2VyaWVz
Ck1lc3NhZ2UtaWQ6IDIwMTkwNDA3MTg1MDQyLjc2MjQtMS1zb2hhaWxhbHZpMjIzNkBnbWFpbC5j
b20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICAxMDU0NmUwLi45MGZiODY0ICBtYXN0ZXIg
ICAgIC0+IG1hc3RlcgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMTkwNDA3MTg1MDQyLjc2MjQtMS1zb2hh
aWxhbHZpMjIzNkBnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDE5MDQwNzE4NTA0Mi43NjI0LTEtc29o
YWlsYWx2aTIyMzZAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNTJj
OGFlNSBzZXRfYml0KCkgZnVuY3Rpb24gYWRkZWQgdG8gdGhlIHNvdXJjZSBjb2RlIG9mIHVuY2F0
ZWdvcml6ZWQgZGV2aWNlcyBhbmQgY2F0ZWdvcml6ZXMgaGF2ZSBiZWVuIGFzc2lnbmUgdG8gdGhl
bS4KCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciBTaWdu
ZWQtb2ZmLWJ5OgojOTogCiAgICBTaWduZWQtb2ZmLWJ5OlNvaGFpbEFsdmkgPHNvaGFpbGFsdmky
MjM2QGdtYWlsLmNvbT4KCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMyOTogRklMRTogaHcv
YmxvY2sveGVuLWJsb2NrLmM6NjI4OgorICAgIFhlbkJsb2NrRGV2aWNlQ2xhc3MgKmJsb2NrZGV2
X2NsYXNzID0gWEVOX0JMT0NLX0RFVklDRV9DTEFTUyhjbGFzcyk7ICAgICQKCkVSUk9SOiB0cmFp
bGluZyB3aGl0ZXNwYWNlCiM0NTogRklMRTogaHcvZG1hL2k4MjM3NC5jOjE0NzoKKyAgICBzZXRf
Yml0KERFVklDRV9DQVRFR09SWV9CUklER0UsIGRjLT5jYXRlZ29yaWVzKTsgICAgJAoKRVJST1I6
IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzE3MDogRklMRTogaHcvbWVtL252ZGltbS5jOjIwMDoKKyAg
ICBzZXRfYml0KERFVklDRV9DQVRFR09SWV9TVE9SQUdFLCBkYy0+Y2F0ZWdvcmllcyk7ICAgICQK
CnRvdGFsOiA0IGVycm9ycywgMCB3YXJuaW5ncywgMTE5IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA1
MmM4YWU1NmUwNGQgKHNldF9iaXQoKSBmdW5jdGlvbiBhZGRlZCB0byB0aGUgc291cmNlIGNvZGUg
b2YgdW5jYXRlZ29yaXplZCBkZXZpY2VzIGFuZCBjYXRlZ29yaXplcyBoYXZlIGJlZW4gYXNzaWdu
ZSB0byB0aGVtLikgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MDcxODUwNDIuNzYyNC0xLXNv
aGFpbGFsdmkyMjM2QGdtYWlsLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


