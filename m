Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AFDC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 05:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404FC20715
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 05:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404FC20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVUXe-0002IR-BT
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 00:53:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iVUWo-0001np-OJ
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 00:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iVUWn-0001mJ-7G
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 00:52:18 -0500
Resent-Date: Fri, 15 Nov 2019 00:52:18 -0500
Resent-Message-Id: <E1iVUWn-0001mJ-7G@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iVUWm-0001lG-Vq
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 00:52:17 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573797119; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Nz/c7H9jqj0WdDXz0P0FzTFv8SH4PV4oZaHcAr5PsbK24LHHsDaUPWCLG31EPUzVFYUr0x3SnNunUeU9R3mYMm+dicGlJEI2uM91CIDWnB/c1FbTLAIs/gwBR4rwZh6YGurWH2N21Hiyzv+nl6mcRW9TtnFDLv7ajk1dj9z5zlk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573797119;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IiSM/WwjpakNxQ4RsttutZrE2n/y5cK9AF/6y4pdfcE=; 
 b=GzdHCPFK8KiX/Tj6iIeiC2W3u8XPx0zHTXDO+e6CKTBvVGlBM1uNCTmTDYQOHs8nkj9ejriP1ae2hTWKEfD0z0BAsBSdU5UlwBJ5attAkf0WHMO2k8j/7RnuKq5Ei+X/00+61Tlgf1JydYDv3EVIS02MqgpYqaGEtTibn8pHW98=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573797118298669.0102631317333;
 Thu, 14 Nov 2019 21:51:58 -0800 (PST)
In-Reply-To: <1573792691-398-1-git-send-email-tsimpson@quicinc.com>
Subject: Re: [PATCH] Modify tests to work with clang
Message-ID: <157379711710.4715.5068757074759451357@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tsimpson@quicinc.com
Date: Thu, 14 Nov 2019 21:51:58 -0800 (PST)
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
Cc: tsimpson@quicinc.com, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTczNzkyNjkxLTM5OC0xLWdp
dC1zZW5kLWVtYWlsLXRzaW1wc29uQHF1aWNpbmMuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIE1vZGlmeSB0ZXN0cyB0byB3
b3JrIHdpdGggY2xhbmcKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NzM3OTI2OTEtMzk4LTEt
Z2l0LXNlbmQtZW1haWwtdHNpbXBzb25AcXVpY2luYy5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDBmYTVjMCBNb2RpZnkg
dGVzdHMgdG8gd29yayB3aXRoIGNsYW5nCgo9PT0gT1VUUFVUIEJFR0lOID09PQpXQVJOSU5HOiBC
bG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojMTg6IEZJ
TEU6IHRlc3RzL3RjZy9tdWx0aWFyY2gvZmxvYXRfaGVscGVycy5jOjI5OgorLyotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgKiBvbiBzdWJzZXF1ZW50IGxp
bmVzCiMxOTogRklMRTogdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9oZWxwZXJzLmM6MzA6Cisv
Ki0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KK3wgVGhlIG1hY3JvIFFFTVVfR05VQ19QUkVSRVEgdGVzdHMg
Zm9yIG1pbmltdW0gdmVyc2lvbiBvZiB0aGUgR05VIEMgY29tcGlsZXIuCgpXQVJOSU5HOiBCbG9j
ayBjb21tZW50cyB1c2UgYSB0cmFpbGluZyAqLyBvbiBhIHNlcGFyYXRlIGxpbmUKIzIxOiBGSUxF
OiB0ZXN0cy90Y2cvbXVsdGlhcmNoL2Zsb2F0X2hlbHBlcnMuYzozMjoKKyotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tKi8KCldBUk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBi
ZSBhdm9pZGVkCiMyMjogRklMRTogdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9oZWxwZXJzLmM6
MzM6CisjaWYgZGVmaW5lZChfX0dOVUNfXykgJiYgZGVmaW5lZChfX0dOVUNfTUlOT1JfXykKCldB
Uk5JTkc6IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBkZWZpbmVzIHNob3VsZCBiZSBhdm9pZGVkCiMz
NzogRklMRTogdGVzdHMvdGNnL211bHRpYXJjaC9mbG9hdF9oZWxwZXJzLmM6OTM6CisjIGlmIGRl
ZmluZWQoX19jbGFuZ19fKSB8fCBRRU1VX0dOVUNfUFJFUkVRKDMsIDMpCgpFUlJPUjogVXNlIG9m
IHZvbGF0aWxlIGlzIHVzdWFsbHkgd3JvbmcsIHBsZWFzZSBhZGQgYSBjb21tZW50CiM1MDogRklM
RTogdGVzdHMvdGNnL211bHRpYXJjaC9saW51eC10ZXN0LmM6NDg4OgorICAgICAgICAqKHZvbGF0
aWxlIHVpbnQ4X3QgKikwID0gMDsKCnRvdGFsOiAxIGVycm9ycywgNSB3YXJuaW5ncywgMzMgbGlu
ZXMgY2hlY2tlZAoKQ29tbWl0IDQwZmE1YzBkN2ExYiAoTW9kaWZ5IHRlc3RzIHRvIHdvcmsgd2l0
aCBjbGFuZykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3Mzc5MjY5MS0zOTgtMS1naXQtc2VuZC1l
bWFpbC10c2ltcHNvbkBxdWljaW5jLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

