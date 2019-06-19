Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63865C31E5E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD012084A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 09:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD012084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXFD-0006Jg-3V
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 05:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdX1h-0003Dj-WD
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdX1g-00075R-8Q
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 05:37:09 -0400
Resent-Date: Wed, 19 Jun 2019 05:37:09 -0400
Resent-Message-Id: <E1hdX1g-00075R-8Q@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdX1b-0006zn-CB; Wed, 19 Jun 2019 05:37:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560936978; cv=none; d=zoho.com; s=zohoarc; 
 b=Zqu+iNoOi5xtRTGXt3c0PZAS6Js6oWsLDh8KcpvQAmhVYsHha/fhWyNtUVNjIsMWP9fd7DnC0kABrSU0fcnmJDZ+DiEL6EmtyDC+MZ9pW+Vo72V/xxKpL6UeNKFKHLBs9PgSiXFSlUv0wqMeViHpNVKMJOd/pD3NK1m/+Tnx7rg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560936978;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=QcEk07X2SqSORn6abBEj3LefduT4BAk2jpg4mrC6fcM=; 
 b=VWZsLexw3iN4xYeosx2w5xx3B8RTMJpdMSodwiKDgS/Ij8Ck77Evj/nnzw+4RCAEJ8KOHDtt5ZLRiAirh+342uSuH5sEdZUR60JOb6+5IWodtpRqg4jSof0xViLZt/UKQgOoB3SO4YPw5hbd4WttwHcC+HhH2Mj9fgUbdWiiLwk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560936976946158.19076413779794;
 Wed, 19 Jun 2019 02:36:16 -0700 (PDT)
In-Reply-To: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
Message-ID: <156093697557.22612.8821990862661724517@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shmuel.eiderman@oracle.com
Date: Wed, 19 Jun 2019 02:36:16 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [SeaBIOS] [QEMU] [PATCH v4 0/8] Add Qemu to
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxOTA5MjkwNS4yNDAy
OS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbU2VhQklPU10gW1FFTVVdIFtQQVRDSCB2NCAw
LzhdIEFkZCBRZW11IHRvIFNlYUJJT1MgTENIUyBpbnRlcmZhY2UKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMTkwNjE5MDkyOTA1LjI0MDI5LTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRj
aGV3LzIwMTkwNjE5MDkyOTA1LjI0MDI5LTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20gLT4g
cGF0Y2hldy8yMDE5MDYxOTA5MjkwNS4yNDAyOS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29t
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNjY2NGQ3ZDg5OCBoZC1nZW8tdGVzdDog
QWRkIHRlc3RzIGZvciBsY2hzIG92ZXJyaWRlCjI5YmFlZDNkYWMgYm9vdGRldmljZTogRldfQ0ZH
IGludGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMKMmZmY2RhNTNlMyBib290ZGV2aWNlOiBSZWZhY3Rv
ciBnZXRfYm9vdF9kZXZpY2VzX2xpc3QKNGJiODQ2MTA2NiBib290ZGV2aWNlOiBHYXRoZXIgTENI
UyBmcm9tIGFsbCByZWxldmFudCBkZXZpY2VzCmE3YWU2ZjQ5ODUgc2NzaTogUHJvcGFnYXRlIHVu
cmVhbGl6ZSgpIGNhbGxiYWNrIHRvIHNjc2ktaGQKMWZjMTYwNDFjMCBib290ZGV2aWNlOiBBZGQg
aW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hTCmQ5ZWJiZTgzMDkgYmxvY2s6IFN1cHBvcnQgcHJvdmlk
aW5nIExDSFMgZnJvbSB1c2VyCmNmMjE2OGE2NmQgYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZp
eCB0YWJiaW5nCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IGNmMjE2
OGE2NmRiZCAoYmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZpeCB0YWJiaW5nKQpFUlJPUjogTWFj
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
SU5FUlMuCgoyLzggQ2hlY2tpbmcgY29tbWl0IGQ5ZWJiZTgzMDk2ZiAoYmxvY2s6IFN1cHBvcnQg
cHJvdmlkaW5nIExDSFMgZnJvbSB1c2VyKQozLzggQ2hlY2tpbmcgY29tbWl0IDFmYzE2MDQxYzAy
OSAoYm9vdGRldmljZTogQWRkIGludGVyZmFjZSB0byBnYXRoZXIgTENIUykKNC84IENoZWNraW5n
IGNvbW1pdCBhN2FlNmY0OTg1ZTIgKHNjc2k6IFByb3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFj
ayB0byBzY3NpLWhkKQo1LzggQ2hlY2tpbmcgY29tbWl0IDRiYjg0NjEwNjY5NyAoYm9vdGRldmlj
ZTogR2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZhbnQgZGV2aWNlcykKNi84IENoZWNraW5nIGNv
bW1pdCAyZmZjZGE1M2UzNjIgKGJvb3RkZXZpY2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNf
bGlzdCkKNy84IENoZWNraW5nIGNvbW1pdCAyOWJhZWQzZGFjMDUgKGJvb3RkZXZpY2U6IEZXX0NG
RyBpbnRlcmZhY2UgZm9yIExDSFMgdmFsdWVzKQo4LzggQ2hlY2tpbmcgY29tbWl0IDY2NjRkN2Q4
OThkNSAoaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBmb3IgbGNocyBvdmVycmlkZSkKV0FSTklORzog
bGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzI0MjogRklMRTogdGVzdHMvaGQtZ2VvLXRlc3QuYzo1
Nzk6CisgICAgICAgICAgICAgICAgICAgICAoY2hhciAqKXItPmRldl9wYXRoLCAmKHItPmNocy5j
KSwgJihyLT5jaHMuaCksICYoci0+Y2hzLnMpKTsKCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVz
ZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM2NDA6IEZJTEU6IHRlc3RzL2hkLWdl
by10ZXN0LmM6OTk1OgorICAgICAgICAgICAgICAgICAgICAgICAic2tpcHBpbmcgaGQtZ2VvL292
ZXJyaWRlLyogdGVzdHMiKTsKCnRvdGFsOiAwIGVycm9ycywgMiB3YXJuaW5ncywgNjA4IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDgvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYxOTA5MjkwNS4y
NDAyOS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==


