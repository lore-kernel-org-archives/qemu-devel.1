Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B25DC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3389D206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 12:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3389D206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQW0Z-00062I-9a
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53270 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jQW02-0005c9-3d
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:58:10 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jQW00-0004Nk-UV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:58:09 -0400
Resent-Date: Mon, 20 Apr 2020 08:58:09 -0400
Resent-Message-Id: <E1jQW00-0004Nk-UV@eggs1p.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21353)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jQW00-0004HV-DC
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 08:58:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587387482; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PiheB/7Exr01nAA9bnR/JKhzbZtZQbt6m7MMoMUFQotnVhWmpSEWuwstQrvDDJbFUGNH5D4fLZ+JzwXnaNI8Q7aHCi1vo9ljoZZJdLifZvfa1GOSIhvoh8GP9rKHUxreWNPKzjN5NoK3A53ZJfGW+zFq+MhGQdjgArsZC4+59Rs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587387482;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4/+Zo6sqInXDhERbFVfejUovpZTY4AZlqg5zBFPG1RA=; 
 b=eM9bxneFgOAdJQ5a0OqeLRYtndBL4Rhwv9xqfNbMAWIvRsV7baQMNJcUgFz3CMuOsHH/58/7l0dEiirc8EyBqSs9BSu+CnJgagfPJZBNpf0gVEE/ByOVtF878oD1/vx1NG4zsQUwGVLYEACg3KHBWnSra7G1goJ2nW4PHM6MDEo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587387479983259.1294792167429;
 Mon, 20 Apr 2020 05:57:59 -0700 (PDT)
In-Reply-To: <20200420083236.19309-1-armbru@redhat.com>
Subject: Re: [PATCH 00/11] Miscellaneous error handling fixes
Message-ID: <158738747900.13510.13465599114284903404@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Mon, 20 Apr 2020 05:57:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 07:20:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMDA4MzIzNi4xOTMw
OS0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMDAvMTFdIE1pc2NlbGxhbmVvdXMgZXJyb3IgaGFu
ZGxpbmcgZml4ZXMKTWVzc2FnZS1pZDogMjAyMDA0MjAwODMyMzYuMTkzMDktMS1hcm1icnVAcmVk
aGF0LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRj
aGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOTQyMTgxYiBtaWdyYXRpb24vY29sbzogRml4IHFt
cF94ZW5fY29sb19kb19jaGVja3BvaW50KCkgZXJyb3IgaGFuZGxpbmcKYThjMmYyOSBpbzogRml4
IHFpb19jaGFubmVsX3NvY2tldF9jbG9zZSgpIGVycm9yIGhhbmRsaW5nCmNlZGI1NmUgeGVuL3B0
OiBGaXggZmxhd2VkIGNvbnZlcnNpb24gdG8gcmVhbGl6ZSgpCjcxNzNhMGUgdmlydGlvLW5ldDog
Rml4IGR1cGxleD0uLi4gYW5kIHNwZWVkPS4uLiBlcnJvciBoYW5kbGluZwo5YzdhZmMzIGJvY2hz
LWRpc3BsYXk6IEZpeCB2Z2FtZW09U0laRSBlcnJvciBoYW5kbGluZwpmM2FkN2Q0IGZkYzogRml4
IGZhbGxiYWNrPWF1dG8gZXJyb3IgaGFuZGxpbmcKZTQ4NGUxNSBhcm0vdmlydDogRml4IHZpcnRf
bWFjaGluZV9kZXZpY2VfcGx1Z19jYigpIGVycm9yIEFQSSB2aW9sYXRpb24KMWM1NGYxMCBjcHVz
OiBQcm9wZXIgcmFuZ2UtY2hlY2tpbmcgZm9yIC1pY291bnQgc2hpZnQ9TgowYTY5ZGM0IGNwdXM6
IEZpeCBjb25maWd1cmVfaWNvdW50KCkgZXJyb3IgQVBJIHZpb2xhdGlvbgpiYWZlNWY1IGJsb2Nr
L2ZpbGUtcG9zaXg6IEZpeCBjaGVja19jYWNoZV9kcm9wcGVkKCkgZXJyb3IgaGFuZGxpbmcKYTY5
MGZhMSBjcnlwdG9kZXY6IEZpeCBjcnlwdG9kZXZfYnVpbHRpbl9jbGVhbnVwKCkgZXJyb3IgQVBJ
IHZpb2xhdGlvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMSBDaGVja2luZyBjb21taXQgYTY5
MGZhMWRjNDI1IChjcnlwdG9kZXY6IEZpeCBjcnlwdG9kZXZfYnVpbHRpbl9jbGVhbnVwKCkgZXJy
b3IgQVBJIHZpb2xhdGlvbikKMi8xMSBDaGVja2luZyBjb21taXQgYmFmZTVmNWU5ODg4IChibG9j
ay9maWxlLXBvc2l4OiBGaXggY2hlY2tfY2FjaGVfZHJvcHBlZCgpIGVycm9yIGhhbmRsaW5nKQoz
LzExIENoZWNraW5nIGNvbW1pdCAwYTY5ZGM0NTAwN2MgKGNwdXM6IEZpeCBjb25maWd1cmVfaWNv
dW50KCkgZXJyb3IgQVBJIHZpb2xhdGlvbikKRVJST1I6IGNvbnNpZGVyIHVzaW5nIHFlbXVfc3Ry
dG9sIGluIHByZWZlcmVuY2UgdG8gc3RydG9sCiM1ODogRklMRTogY3B1cy5jOjgxODoKKyAgICAg
ICAgdGltZV9zaGlmdCA9IHN0cnRvbChvcHRpb24sICZyZW1fc3RyLCAwKTsKCnRvdGFsOiAxIGVy
cm9ycywgMCB3YXJuaW5ncywgNzAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8xMSBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKNC8xMSBDaGVja2luZyBjb21taXQgMWM1NGYxMDJhZWQzIChjcHVz
OiBQcm9wZXIgcmFuZ2UtY2hlY2tpbmcgZm9yIC1pY291bnQgc2hpZnQ9TikKNS8xMSBDaGVja2lu
ZyBjb21taXQgZTQ4NGUxNTM2ZWQ3IChhcm0vdmlydDogRml4IHZpcnRfbWFjaGluZV9kZXZpY2Vf
cGx1Z19jYigpIGVycm9yIEFQSSB2aW9sYXRpb24pCjYvMTEgQ2hlY2tpbmcgY29tbWl0IGYzYWQ3
ZDQ0NGE2NiAoZmRjOiBGaXggZmFsbGJhY2s9YXV0byBlcnJvciBoYW5kbGluZykKNy8xMSBDaGVj
a2luZyBjb21taXQgOWM3YWZjM2M1N2E0IChib2Nocy1kaXNwbGF5OiBGaXggdmdhbWVtPVNJWkUg
ZXJyb3IgaGFuZGxpbmcpCjgvMTEgQ2hlY2tpbmcgY29tbWl0IDcxNzNhMGUzOTlmZCAodmlydGlv
LW5ldDogRml4IGR1cGxleD0uLi4gYW5kIHNwZWVkPS4uLiBlcnJvciBoYW5kbGluZykKOS8xMSBD
aGVja2luZyBjb21taXQgY2VkYjU2ZWMzZGEzICh4ZW4vcHQ6IEZpeCBmbGF3ZWQgY29udmVyc2lv
biB0byByZWFsaXplKCkpCjEwLzExIENoZWNraW5nIGNvbW1pdCBhOGMyZjI5NGFiYjIgKGlvOiBG
aXggcWlvX2NoYW5uZWxfc29ja2V0X2Nsb3NlKCkgZXJyb3IgaGFuZGxpbmcpCjExLzExIENoZWNr
aW5nIGNvbW1pdCA5NDIxODFiNzI1MDUgKG1pZ3JhdGlvbi9jb2xvOiBGaXggcW1wX3hlbl9jb2xv
X2RvX2NoZWNrcG9pbnQoKSBlcnJvciBoYW5kbGluZykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjAwODMyMzYuMTkzMDktMS1hcm1icnVA
cmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

