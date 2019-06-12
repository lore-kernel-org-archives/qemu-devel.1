Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB34C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9678420896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9678420896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2Wb-0003ta-Mw
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hb2SM-0002Ht-0c
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hb2SK-0003gW-O5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:34:21 -0400
Resent-Date: Wed, 12 Jun 2019 08:34:21 -0400
Resent-Message-Id: <E1hb2SK-0003gW-O5@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hb2SH-0003bi-2c; Wed, 12 Jun 2019 08:34:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560342798; cv=none; d=zoho.com; s=zohoarc; 
 b=jQui0RZhdkfdAgdRwIwEgUyWd2c82c7FFdoSILoOYQsvEf0M6DSMxCqm8japHuOkh+B2Eo+Udkd+/r4w/pzhqNM87oCNB3w240jbtEkDN5O5qIOpahuG9ARy8CNiYoyUmAtsZR8ym3AQ7fdxcxwHYPOKHFaEm00A5Gv6Kci0sq4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560342798;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=VRuuEZXy4IAomVsS2KCIL97xTlnaRHbvrd6PJ3q7IcQ=; 
 b=okQUMtIoeP4utzGfZ9rYElwcZc1luD7+IRXhiHnhQIjr+OEnEQGrRQf1Trqqkk5y84pSM3W3eqMLQSGH+PYdtBoNAGCkfJrTXjbWw+iI0CnzZZPWrPUcnaqMr39vrNApaK+VNut4NRY1oVfo/bfH+s973V2DF/9PZkcUryPfnqc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560342796658239.20970309029826;
 Wed, 12 Jun 2019 05:33:16 -0700 (PDT)
In-Reply-To: <20190612115939.23825-1-shmuel.eiderman@oracle.com>
Message-ID: <156034279518.31589.8098855244590447539@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shmuel.eiderman@oracle.com
Date: Wed, 12 Jun 2019 05:33:16 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [SeaBIOS] [QEMU] [PATCH v2 0/8] Add Qemu to
 SeaBIOS LCHS interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxMjExNTkzOS4yMzgy
NS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbU2VhQklPU10gW1FFTVVdIFtQQVRDSCB2MiAw
LzhdIEFkZCBRZW11IHRvIFNlYUJJT1MgTENIUyBpbnRlcmZhY2UKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMTkwNjEyMTE1OTM5LjIzODI1LTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRj
aGV3LzIwMTkwNjEyMTE1OTM5LjIzODI1LTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20gLT4g
cGF0Y2hldy8yMDE5MDYxMjExNTkzOS4yMzgyNS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29t
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYmRmNmExYmQyNCBoZC1nZW8tdGVzdDog
QWRkIHRlc3RzIGZvciBsY2hzIG92ZXJyaWRlCmQ3YjY3ZjQxOTMgYm9vdGRldmljZTogRldfQ0ZH
IGludGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMKMTFhNjRmZDExZiBib290ZGV2aWNlOiBSZWZhY3Rv
ciBnZXRfYm9vdF9kZXZpY2VzX2xpc3QKZGNlMzFjZjJjNyBib290ZGV2aWNlOiBHYXRoZXIgTENI
UyBmcm9tIGFsbCByZWxldmFudCBkZXZpY2VzCmFhYTAyNWFlYTMgc2NzaTogUHJvcGFnYXRlIHVu
cmVhbGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQKYmE3NzdjZDhiMSBib290ZGV2aWNlOiBBZGQg
aW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hTCmVkOWI2MWVlOGQgYmxvY2s6IFN1cHBvcnQgcHJvdmlk
aW5nIExDSFMgZnJvbSB1c2VyCmViNjFmNmYxZDMgYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZp
eCB0YWJiaW5nCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IGViNjFm
NmYxZDM1YyAoYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZpeCB0YWJiaW5nKQpFUlJPUjogTWFj
cm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lz
CiM1NTogRklMRTogaW5jbHVkZS9ody9ibG9jay9ibG9jay5oOjY1OgorI2RlZmluZSBERUZJTkVf
QkxPQ0tfQ0hTX1BST1BFUlRJRVMoX3N0YXRlLCBfY29uZikgICAgICAgICAgICAgICAgICAgICAg
XAorICAgIERFRklORV9QUk9QX1VJTlQzMigiY3lscyIsIF9zdGF0ZSwgX2NvbmYuY3lscywgMCks
ICAgICAgICAgICAgICAgICAgXAorICAgIERFRklORV9QUk9QX1VJTlQzMigiaGVhZHMiLCBfc3Rh
dGUsIF9jb25mLmhlYWRzLCAwKSwgICAgICAgICAgICAgICAgXAogICAgIERFRklORV9QUk9QX1VJ
TlQzMigic2VjcyIsIF9zdGF0ZSwgX2NvbmYuc2VjcywgMCkKCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgMzcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS84IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgoyLzggQ2hlY2tpbmcgY29tbWl0IGVkOWI2MWVlOGRiZiAoYmxvY2s6IFN1cHBvcnQg
cHJvdmlkaW5nIExDSFMgZnJvbSB1c2VyKQozLzggQ2hlY2tpbmcgY29tbWl0IGJhNzc3Y2Q4YjFl
MyAoYm9vdGRldmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENIUykKNC84IENoZWNraW5n
IGNvbW1pdCBhYWEwMjVhZWEzMzMgKHNjc2k6IFByb3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFj
ayB0byBzY3NpLWhkKQo1LzggQ2hlY2tpbmcgY29tbWl0IGRjZTMxY2YyYzdhYyAoYm9vdGRldmlj
ZTogR2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcykKNi84IENoZWNraW5nIGNv
bW1pdCAxMWE2NGZkMTFmMGYgKGJvb3RkZXZpY2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNf
bGlzdCkKNy84IENoZWNraW5nIGNvbW1pdCBkN2I2N2Y0MTkzZWYgKGJvb3RkZXZpY2U6IEZXX0NG
RyBpbnRlcmZhY2UgZm9yIExDSFMgdmFsdWVzKQo4LzggQ2hlY2tpbmcgY29tbWl0IGJkZjZhMWJk
MjRiZCAoaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBvdmVycmlkZSkKPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA2MTIxMTU5Mzku
MjM4MjUtMS1zaG11ZWwuZWlkZXJtYW5Ab3JhY2xlLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


