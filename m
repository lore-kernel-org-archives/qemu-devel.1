Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E07BC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2737F206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2737F206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXWa-0005M4-P3
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdXVQ-0004k4-Mi
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdXVP-0002hw-AV
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:07:52 -0400
Resent-Date: Wed, 19 Jun 2019 06:07:52 -0400
Resent-Message-Id: <E1hdXVP-0002hw-AV@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdXVM-0002eK-Hk; Wed, 19 Jun 2019 06:07:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560938817; cv=none; d=zoho.com; s=zohoarc; 
 b=eLrLto03fjetCJqqSrYwfwceQybQ5oj7+XLkihII64uX8gS2IhzNF3Hxuwgr13vN8wAJinJDEQVwHaAXc/6AJJrYlz3mmtRA/F6JL8grQeFiy4BXlqOoeWdzAxbjJ05gdk7EWbKI/oKYmXDvlYFtHeedrs6kXXT6OnHpLYodzjc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560938817;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=B9BuNClBuOG4n6VN3lLlS5Ajj5l/oMgiz2vNg6vh8tg=; 
 b=PxFLleBdjTPRLvmhfGdPjuyvNxxLVk+KdWz3/a54/M2mVlwC6yDNhk2fBwtw1zPfsN15ex4ct3WqqfdZf8Kz3uY1sVzweZli3jK11S15FoezMUe+lQ5Zc9MmU7NTwLzgsoeo19V7rrd7oau+K6D4PCnZa3ptk6JM8++ab7xhF8w=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560938815577348.5912143121369;
 Wed, 19 Jun 2019 03:06:55 -0700 (PDT)
In-Reply-To: <20190619092905.24029-1-shmuel.eiderman@oracle.com>
Message-ID: <156093881407.26721.4577394079116317217@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shmuel.eiderman@oracle.com
Date: Wed, 19 Jun 2019 03:06:55 -0700 (PDT)
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
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIw
MTkwNjE5MDkyOTA1LjI0MDI5LTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20gLT4gcGF0Y2hl
dy8yMDE5MDYxOTA5MjkwNS4yNDAyOS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZjNmNTZlYiBoZC1nZW8tdGVzdDogQWRkIHRlc3Rz
IGZvciBsY2hzIG92ZXJyaWRlCjQ1OTFlN2YgYm9vdGRldmljZTogRldfQ0ZHIGludGVyZmFjZSBm
b3IgTENIUyB2YWx1ZXMKZWQyZDc2YyBib290ZGV2aWNlOiBSZWZhY3RvciBnZXRfYm9vdF9kZXZp
Y2VzX2xpc3QKYTkyNTE0YyBib290ZGV2aWNlOiBHYXRoZXIgTENIUyBmcm9tIGFsbCByZWxldmFu
dCBkZXZpY2VzCmE2ZGJhN2Mgc2NzaTogUHJvcGFnYXRlIHVucmVhbGl6ZSgpIGNhbGxiYWNrIHRv
IHNjc2ktaGQKMjJiMDljMiBib290ZGV2aWNlOiBBZGQgaW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hT
CmM4OTZkYzkgYmxvY2s6IFN1cHBvcnQgcHJvdmlkaW5nIExDSFMgZnJvbSB1c2VyCmQ4YWFlZTUg
YmxvY2s6IFJlZmFjdG9yIG1hY3JvcyAtIGZpeCB0YWJiaW5nCgo9PT0gT1VUUFVUIEJFR0lOID09
PQoxLzggQ2hlY2tpbmcgY29tbWl0IGQ4YWFlZTUwYmEwYiAoYmxvY2s6IFJlZmFjdG9yIG1hY3Jv
cyAtIGZpeCB0YWJiaW5nKQpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxk
IGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2lzCiM1NTogRklMRTogaW5jbHVkZS9ody9ibG9jay9i
bG9jay5oOjY1OgorI2RlZmluZSBERUZJTkVfQkxPQ0tfQ0hTX1BST1BFUlRJRVMoX3N0YXRlLCBf
Y29uZikgICAgICAgICAgICAgICAgICAgICAgXAorICAgIERFRklORV9QUk9QX1VJTlQzMigiY3ls
cyIsIF9zdGF0ZSwgX2NvbmYuY3lscywgMCksICAgICAgICAgICAgICAgICAgXAorICAgIERFRklO
RV9QUk9QX1VJTlQzMigiaGVhZHMiLCBfc3RhdGUsIF9jb25mLmhlYWRzLCAwKSwgICAgICAgICAg
ICAgICAgXAogICAgIERFRklORV9QUk9QX1VJTlQzMigic2VjcyIsIF9zdGF0ZSwgX2NvbmYuc2Vj
cywgMCkKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzcgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggMS84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzggQ2hlY2tpbmcgY29tbWl0IGM4
OTZkYzk4MTJiYyAoYmxvY2s6IFN1cHBvcnQgcHJvdmlkaW5nIExDSFMgZnJvbSB1c2VyKQozLzgg
Q2hlY2tpbmcgY29tbWl0IDIyYjA5YzIwZmVmMSAoYm9vdGRldmljZTogQWRkIGludGVyZmFjZSB0
byBnYXRoZXIgTENIUykKNC84IENoZWNraW5nIGNvbW1pdCBhNmRiYTdjMzI4OTAgKHNjc2k6IFBy
b3BhZ2F0ZSB1bnJlYWxpemUoKSBjYWxsYmFjayB0byBzY3NpLWhkKQo1LzggQ2hlY2tpbmcgY29t
bWl0IGE5MjUxNGM1ZDAxNSAoYm9vdGRldmljZTogR2F0aGVyIExDSFMgZnJvbSBhbGwgcmVsZXZh
bnQgZGV2aWNlcykKNi84IENoZWNraW5nIGNvbW1pdCBlZDJkNzZjOTM4NDUgKGJvb3RkZXZpY2U6
IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNfbGlzdCkKNy84IENoZWNraW5nIGNvbW1pdCA0NTkx
ZTdmZTk1ZWQgKGJvb3RkZXZpY2U6IEZXX0NGRyBpbnRlcmZhY2UgZm9yIExDSFMgdmFsdWVzKQo4
LzggQ2hlY2tpbmcgY29tbWl0IGYzZjU2ZWJlNjM1NCAoaGQtZ2VvLXRlc3Q6IEFkZCB0ZXN0cyBm
b3IgbGNocyBvdmVycmlkZSkKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzI0Mjog
RklMRTogdGVzdHMvaGQtZ2VvLXRlc3QuYzo1Nzk6CisgICAgICAgICAgICAgICAgICAgICAoY2hh
ciAqKXItPmRldl9wYXRoLCAmKHItPmNocy5jKSwgJihyLT5jaHMuaCksICYoci0+Y2hzLnMpKTsK
CldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBs
aW5lCiM2NDA6IEZJTEU6IHRlc3RzL2hkLWdlby10ZXN0LmM6OTk1OgorICAgICAgICAgICAgICAg
ICAgICAgICAic2tpcHBpbmcgaGQtZ2VvL292ZXJyaWRlLyogdGVzdHMiKTsKCnRvdGFsOiAwIGVy
cm9ycywgMiB3YXJuaW5ncywgNjA4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDE5MDYxOTA5MjkwNS4yNDAyOS0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


