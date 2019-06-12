Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C20C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763F82080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763F82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58360 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb0GJ-00073E-1f
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 06:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hb0Fm-0006YX-AP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hb0Fk-000733-9Z
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:13:14 -0400
Resent-Date: Wed, 12 Jun 2019 06:13:13 -0400
Resent-Message-Id: <E1hb0Fk-000733-9Z@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hb0Fj-00072O-DT
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:13:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560334336; cv=none; d=zoho.com; s=zohoarc; 
 b=bQLobfVcBc4vZZOskDlthnoMzaqkwJS6a/shRtDPmbVmHkOGhQ6fXwzgdHH23E3ouG5OPRt0ajsoGOMUz9k8fq1J4MhBW06sLCiS9fvz1zAkx9/ZIs0oPCGefRytO0QQpvmpuEkr+6ikSehCA9fxy2jWuSJX72wZnSDvT6W+xBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560334336;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=MbK57nbsYXuLdRDPkBPPwqgALyWWkqbp5SgrgAlnBxI=; 
 b=ROE2aPVjkTfG+RQ8GAdCsWJhtcoUgzQ3dT6DL9f2TRYgHT+u3PFARVvtPNbutDP8HAvOG/cPx0CINFDZSKbNYVKyao3oProZuotXtvxeybJYs4a5PDwAQ7wZMGArppC2+vxKQsP9I6pJ6Z2uoRd/aFydDPdgMSTQkRYDsWP5jKw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560334333584694.7460933415969;
 Wed, 12 Jun 2019 03:12:13 -0700 (PDT)
In-Reply-To: <20190612094237.47462-1-shmuel.eiderman@oracle.com>
Message-ID: <156033433213.31589.7042996978527633083@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shmuel.eiderman@oracle.com
Date: Wed, 12 Jun 2019 03:12:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [SeaBIOS] [QEMU] [PATCH 0/8] Add Qemu to SeaBIOS
 LCHS interface
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxMjA5NDIzNy40NzQ2
Mi0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbU2VhQklPU10gW1FFTVVdIFtQQVRDSCAwLzhd
IEFkZCBRZW11IHRvIFNlYUJJT1MgTENIUyBpbnRlcmZhY2UKVHlwZTogc2VyaWVzCk1lc3NhZ2Ut
aWQ6IDIwMTkwNjEyMDk0MjM3LjQ3NDYyLTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4g
L2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJh
Y2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3
LzIwMTkwNjEyMDk0MjM3LjQ3NDYyLTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20gLT4gcGF0
Y2hldy8yMDE5MDYxMjA5NDIzNy40NzQ2Mi0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYTlhMGNmYzk1NiBoZC1nZW8tdGVzdDogQWRk
IHRlc3RzIGZvciBsY2hzIG92ZXJyaWRlCmQxYjg2ZjlmNDcgYm9vdGRldmljZTogRldfQ0ZHIGlu
dGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMKNDhkZDA4M2Q2NSBib290ZGV2aWNlOiBSZWZhY3RvciBn
ZXRfYm9vdF9kZXZpY2VzX2xpc3QKZjM3ZThmN2MzYyBib290ZGV2aWNlOiBHYXRoZXIgTENIUyBm
cm9tIGFsbCByZWxldmFudCBkZXZpY2VzCjhhNzE5M2MxNmIgc2NzaTogUHJvcGFnYXRlIHVucmVh
bGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQKYzBhM2E0M2ZlMiBib290ZGV2aWNlOiBBZGQgaW50
ZXJmYWNlIHRvIGdhdGhlciBMQ0hTCjllYmM5YzFmZDkgYmxvY2s6IFN1cHBvcnQgcHJvdmlkaW5n
IExDSFMgZnJvbSB1c2VyCjY1OTM0MDAwNzUgYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZpeCB0
YWJiaW5nCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IDY1OTM0MDAw
NzUzNyAoYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZpeCB0YWJiaW5nKQpFUlJPUjogTWFjcm9z
IHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM1
NTogRklMRTogaW5jbHVkZS9ody9ibG9jay9ibG9jay5oOjY1OgorI2RlZmluZSBERUZJTkVfQkxP
Q0tfQ0hTX1BST1BFUlRJRVMoX3N0YXRlLCBfY29uZikgICAgICAgICAgICAgICAgICAgICAgXAor
ICAgIERFRklORV9QUk9QX1VJTlQzMigiY3lscyIsIF9zdGF0ZSwgX2NvbmYuY3lscywgMCksICAg
ICAgICAgICAgICAgICAgXAorICAgIERFRklORV9QUk9QX1VJTlQzMigiaGVhZHMiLCBfc3RhdGUs
IF9jb25mLmhlYWRzLCAwKSwgICAgICAgICAgICAgICAgXAogICAgIERFRklORV9QUk9QX1VJTlQz
Migic2VjcyIsIF9zdGF0ZSwgX2NvbmYuc2VjcywgMCkKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMzcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgoyLzggQ2hlY2tpbmcgY29tbWl0IDllYmM5YzFmZDlhMiAoYmxvY2s6IFN1cHBvcnQgcHJv
dmlkaW5nIExDSFMgZnJvbSB1c2VyKQozLzggQ2hlY2tpbmcgY29tbWl0IGMwYTNhNDNmZTIyZSAo
Ym9vdGRldmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENIUykKNC84IENoZWNraW5nIGNv
bW1pdCA4YTcxOTNjMTZiYjkgKHNjc2k6IFByb3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFjayB0
byBzY3NpLWhkKQo1LzggQ2hlY2tpbmcgY29tbWl0IGYzN2U4ZjdjM2NjNiAoYm9vdGRldmljZTog
R2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcykKNi84IENoZWNraW5nIGNvbW1p
dCA0OGRkMDgzZDY1ZWQgKGJvb3RkZXZpY2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNfbGlz
dCkKNy84IENoZWNraW5nIGNvbW1pdCBkMWI4NmY5ZjQ3OGMgKGJvb3RkZXZpY2U6IEZXX0NGRyBp
bnRlcmZhY2UgZm9yIExDSFMgdmFsdWVzKQo4LzggQ2hlY2tpbmcgY29tbWl0IGE5YTBjZmM5NTZh
NyAoaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBvdmVycmlkZSkKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA2MTIwOTQyMzcuNDc0
NjItMS1zaG11ZWwuZWlkZXJtYW5Ab3JhY2xlLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


