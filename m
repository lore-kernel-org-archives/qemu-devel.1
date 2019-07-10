Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467CDC73C6D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D82D2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 06:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D82D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl5r5-0006s8-Cb
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 02:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37541)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hl5qF-00060n-3a
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hl5qD-00084M-Lm
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 02:12:35 -0400
Resent-Date: Wed, 10 Jul 2019 02:12:35 -0400
Resent-Message-Id: <E1hl5qD-00084M-Lm@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hl5qD-0007zK-Cy; Wed, 10 Jul 2019 02:12:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562739134; cv=none; d=zoho.com; s=zohoarc; 
 b=mH4aPJS8VOcMMaciV6FwHXOyGI6G4SfGOfLva0aLf4aChOTxN1cM8YWCPEsYeF400XSouaqoQ0HPvc5xdHrrGEburlOnwti6bLn1tMyIeIkQvqkFDpy7Tq17xQELA4iTOTS5oxGHPIO2eE1rMw75g3cj8AaAfObhtl80PJfAlU4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562739134;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=zIRkXxrNbhEOPTPyFYFwX7UR5j2Q0+monOgGgRI8g2o=; 
 b=aAbI2HSaXxWPqiTXu56wCmYVkjKeWtFkbPQ+hIAvYlmfFhkq1Umw6cE/WYjrRFw6oP/8UlzstVoCHv/PaaRmz8aWjtltybR9DrD6pLb0TmKNjc8ggzfJv51MSDylh2eS0+nfiZY9gsNSeQ+mLLGX68c6avATN0rIkJktYcxsxqY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562739133663843.5632843826825;
 Tue, 9 Jul 2019 23:12:13 -0700 (PDT)
Message-ID: <156273913241.3386.15746188914180946036@c4a48874b076>
In-Reply-To: <20190710060621.16430-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: bharata@linux.ibm.com
Date: Tue, 9 Jul 2019 23:12:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v0] ppc/spapr: Support reboot of secure
 pseries guest
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, linuxram@us.ibm.com,
 qemu-devel@nongnu.org, bharata@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMDA2MDYyMS4xNjQz
MC0xLWJoYXJhdGFAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA3MTAwNjA2MjEuMTY0MzAtMS1iaGFyYXRh
QGxpbnV4LmlibS5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0gg
djBdIHBwYy9zcGFwcjogU3VwcG9ydCByZWJvb3Qgb2Ygc2VjdXJlIHBzZXJpZXMgZ3Vlc3QKCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4g
L2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJh
Y2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3
LzIwMTkwNzEwMDYwNjIxLjE2NDMwLTEtYmhhcmF0YUBsaW51eC5pYm0uY29tIC0+IHBhdGNoZXcv
MjAxOTA3MTAwNjA2MjEuMTY0MzAtMS1iaGFyYXRhQGxpbnV4LmlibS5jb20KU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0Jwo2MzZhMjdmODBmIHBwYy9zcGFwcjogU3VwcG9ydCByZWJvb3Qg
b2Ygc2VjdXJlIHBzZXJpZXMgZ3Vlc3QKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBjb2Rl
IGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzc5OiBGSUxFOiB0YXJnZXQvcHBjL2t2bV9w
cGMuaDoyMDc6CiteSXJldHVybiAwOyQKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNDIg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IDYzNmEyN2Y4MGYwZCAocHBjL3NwYXByOiBTdXBwb3J0IHJl
Ym9vdCBvZiBzZWN1cmUgcHNlcmllcyBndWVzdCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA3
MTAwNjA2MjEuMTY0MzAtMS1iaGFyYXRhQGxpbnV4LmlibS5jb20vdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


