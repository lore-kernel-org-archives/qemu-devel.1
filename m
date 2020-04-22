Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D890C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AB320767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 20:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AB320767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRLtO-0002fb-3k
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 16:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRLsd-00029o-83
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRLsU-0002BY-K5
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:21:57 -0400
Resent-Date: Wed, 22 Apr 2020 16:21:57 -0400
Resent-Message-Id: <E1jRLsU-0002BY-K5@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRLsU-0001kM-4a
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 16:21:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587586902; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XJBYmUYN5JdZfMLCBOV7kiiT19Xa7MqLq/DowhADfSgGxLSD8jVRNO8Zg/fwWhDhx4gNON041eM4T67x6aTkAp1zBisI50zXcpJUdXGWk60MArMAby7M4GyViX+6RjLU6RFBKKf+onPWQwyLFQNbg95Coasi6do0D0VQUb+M0Bs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587586902;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=O8cbjTBLMAkhexZ67CYBG0QNOgefEkIVV2rRXP8aWJI=; 
 b=RSd9xr1dt7QdgzV62TlFafsmgUwyR1KXLmXmSZc2SiUw+ikZJS2LKCLjJ6JdNNPmr0CWQfEwl6q0yFSl0JekmaogZLkwqZmxkaBd00v2DSYClMndMyZE6UywZN8qDRn0b4GnFgaytoJ2VRaurr9/1WvTsgyPoZq0cJ16aueR6S4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587586901063784.0355964454786;
 Wed, 22 Apr 2020 13:21:41 -0700 (PDT)
In-Reply-To: <20200422130719.28225-1-armbru@redhat.com>
Subject: Re: [PATCH v2 00/14] Miscellaneous error handling fixes
Message-ID: <158758690007.861.615761739031001337@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Wed, 22 Apr 2020 13:21:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 14:26:26
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjEzMDcxOS4yODIy
NS0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjIgMDAvMTRdIE1pc2NlbGxhbmVvdXMgZXJyb3Ig
aGFuZGxpbmcgZml4ZXMKTWVzc2FnZS1pZDogMjAyMDA0MjIxMzA3MTkuMjgyMjUtMS1hcm1icnVA
cmVkaGF0LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmRkNjlhZjEgcWdhOiBGaXggcW1w
X2d1ZXN0X3N1c3BlbmRfe2Rpc2ssIHJhbX0oKSBlcnJvciBoYW5kbGluZwo0YTA4ZjMxIHFnYTog
Rml4IHFtcF9ndWVzdF9nZXRfbWVtb3J5X2Jsb2NrcygpIGVycm9yIGhhbmRsaW5nCjYzNzA2NWIg
dGVzdHMvdGVzdC1sb2dnaW5nOiBGaXggdGVzdCBmb3IgLWRmaWx0ZXIgMC4uMHhmZmZmZmZmZmZm
ZmZmZmZmCjM3M2U3NDEgbWlncmF0aW9uL2NvbG86IEZpeCBxbXBfeGVuX2NvbG9fZG9fY2hlY2tw
b2ludCgpIGVycm9yIGhhbmRsaW5nCmFlZTgzODQgaW86IEZpeCBxaW9fY2hhbm5lbF9zb2NrZXRf
Y2xvc2UoKSBlcnJvciBoYW5kbGluZwpkNjE0OWU5IHhlbi9wdDogRml4IGZsYXdlZCBjb252ZXJz
aW9uIHRvIHJlYWxpemUoKQo2OTg4NjZlIHZpcnRpby1uZXQ6IEZpeCBkdXBsZXg9Li4uIGFuZCBz
cGVlZD0uLi4gZXJyb3IgaGFuZGxpbmcKZWFkN2Q1YiBib2Nocy1kaXNwbGF5OiBGaXggdmdhbWVt
PVNJWkUgZXJyb3IgaGFuZGxpbmcKZTM2YTc1YSBmZGM6IEZpeCBmYWxsYmFjaz1hdXRvIGVycm9y
IGhhbmRsaW5nCjM4NDA5OTMgYXJtL3ZpcnQ6IEZpeCB2aXJ0X21hY2hpbmVfZGV2aWNlX3BsdWdf
Y2IoKSBlcnJvciBBUEkgdmlvbGF0aW9uCmU2NzNkZGUgY3B1czogUHJvcGVyIHJhbmdlLWNoZWNr
aW5nIGZvciAtaWNvdW50IHNoaWZ0PU4KZWMwM2JkNSBjcHVzOiBGaXggY29uZmlndXJlX2ljb3Vu
dCgpIGVycm9yIEFQSSB2aW9sYXRpb24KYjcyMjdlNSBibG9jay9maWxlLXBvc2l4OiBGaXggY2hl
Y2tfY2FjaGVfZHJvcHBlZCgpIGVycm9yIGhhbmRsaW5nCmMyZDYzODMgY3J5cHRvZGV2OiBGaXgg
Y3J5cHRvZGV2X2J1aWx0aW5fY2xlYW51cCgpIGVycm9yIEFQSSB2aW9sYXRpb24KCj09PSBPVVRQ
VVQgQkVHSU4gPT09CjEvMTQgQ2hlY2tpbmcgY29tbWl0IGMyZDYzODMxODk4ZCAoY3J5cHRvZGV2
OiBGaXggY3J5cHRvZGV2X2J1aWx0aW5fY2xlYW51cCgpIGVycm9yIEFQSSB2aW9sYXRpb24pCjIv
MTQgQ2hlY2tpbmcgY29tbWl0IGI3MjI3ZTU0ZDNlMiAoYmxvY2svZmlsZS1wb3NpeDogRml4IGNo
ZWNrX2NhY2hlX2Ryb3BwZWQoKSBlcnJvciBoYW5kbGluZykKMy8xNCBDaGVja2luZyBjb21taXQg
ZWMwM2JkNTY0NzdhIChjcHVzOiBGaXggY29uZmlndXJlX2ljb3VudCgpIGVycm9yIEFQSSB2aW9s
YXRpb24pCkVSUk9SOiBjb25zaWRlciB1c2luZyBxZW11X3N0cnRvbCBpbiBwcmVmZXJlbmNlIHRv
IHN0cnRvbAojNTg6IEZJTEU6IGNwdXMuYzo4MTg6CisgICAgICAgIHRpbWVfc2hpZnQgPSBzdHJ0
b2wob3B0aW9uLCAmcmVtX3N0ciwgMCk7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDcw
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvMTQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQv
MTQgQ2hlY2tpbmcgY29tbWl0IGU2NzNkZGUxNTdiYyAoY3B1czogUHJvcGVyIHJhbmdlLWNoZWNr
aW5nIGZvciAtaWNvdW50IHNoaWZ0PU4pCjUvMTQgQ2hlY2tpbmcgY29tbWl0IDM4NDA5OTM0NWJk
MCAoYXJtL3ZpcnQ6IEZpeCB2aXJ0X21hY2hpbmVfZGV2aWNlX3BsdWdfY2IoKSBlcnJvciBBUEkg
dmlvbGF0aW9uKQo2LzE0IENoZWNraW5nIGNvbW1pdCBlMzZhNzVhMzQ1MzkgKGZkYzogRml4IGZh
bGxiYWNrPWF1dG8gZXJyb3IgaGFuZGxpbmcpCjcvMTQgQ2hlY2tpbmcgY29tbWl0IGVhZDdkNWJi
MWY0OCAoYm9jaHMtZGlzcGxheTogRml4IHZnYW1lbT1TSVpFIGVycm9yIGhhbmRsaW5nKQo4LzE0
IENoZWNraW5nIGNvbW1pdCA2OTg4NjZlMzQ0OTcgKHZpcnRpby1uZXQ6IEZpeCBkdXBsZXg9Li4u
IGFuZCBzcGVlZD0uLi4gZXJyb3IgaGFuZGxpbmcpCjkvMTQgQ2hlY2tpbmcgY29tbWl0IGQ2MTQ5
ZTljNzQxZCAoeGVuL3B0OiBGaXggZmxhd2VkIGNvbnZlcnNpb24gdG8gcmVhbGl6ZSgpKQoxMC8x
NCBDaGVja2luZyBjb21taXQgYWVlODM4NDJhOGRjIChpbzogRml4IHFpb19jaGFubmVsX3NvY2tl
dF9jbG9zZSgpIGVycm9yIGhhbmRsaW5nKQoxMS8xNCBDaGVja2luZyBjb21taXQgMzczZTc0MWM0
NWRiIChtaWdyYXRpb24vY29sbzogRml4IHFtcF94ZW5fY29sb19kb19jaGVja3BvaW50KCkgZXJy
b3IgaGFuZGxpbmcpCjEyLzE0IENoZWNraW5nIGNvbW1pdCA2MzcwNjViZGI4ZmUgKHRlc3RzL3Rl
c3QtbG9nZ2luZzogRml4IHRlc3QgZm9yIC1kZmlsdGVyIDAuLjB4ZmZmZmZmZmZmZmZmZmZmZikK
MTMvMTQgQ2hlY2tpbmcgY29tbWl0IDRhMDhmMzEzNzU5YiAocWdhOiBGaXggcW1wX2d1ZXN0X2dl
dF9tZW1vcnlfYmxvY2tzKCkgZXJyb3IgaGFuZGxpbmcpCjE0LzE0IENoZWNraW5nIGNvbW1pdCBk
ZDY5YWYxZDgwMTAgKHFnYTogRml4IHFtcF9ndWVzdF9zdXNwZW5kX3tkaXNrLCByYW19KCkgZXJy
b3IgaGFuZGxpbmcpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwNDIyMTMwNzE5LjI4MjI1LTEtYXJtYnJ1QHJlZGhhdC5jb20vdGVzdGluZy5j
aGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

