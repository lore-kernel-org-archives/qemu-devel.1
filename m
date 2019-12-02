Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45C5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94ED20722
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 16:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94ED20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibobp-0003ka-RH
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 11:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ibob3-0003J1-5H
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ibob1-00046M-Ds
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:30:48 -0500
Resent-Date: Mon, 02 Dec 2019 11:30:48 -0500
Resent-Message-Id: <E1ibob1-00046M-Ds@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ibob1-000448-8P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 11:30:47 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575304233; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XUjh+7rP4/5O9ocVYgQja/8dKi5xrjznWAZDF066epXln7Jd3kR03NcOgAsrRgiZoHjg+xAm8WIlekCu5TC4qPFunaLZWDV0wcpMUq9B0b5ce/QG/DEtxcbg8hMfunXdcB6yslx30YcFG5mXGn7cDVuvFbqDvekrTKDjzJ/UZUM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575304233;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Zs7kQWUwzJlhok6KIcKLSG3MNv3Feil4k3q4pqCvb5g=; 
 b=MISh8aOdIoYj4d4ZQySyufJRxl3Ub3qwuq76IVcMD3s88iiUfwA6SghRcmEKBvyLGUGKqDOL9ceo995A4NhW5eiSrt3ZhVPGs0cD600pR3yXufx3jltqZUqxjy6NmR7G9H4VhxNSTeR36u5n7zoD6v0cDkapWL6HXmI8vXbmvNs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157530423137976.31544629946552;
 Mon, 2 Dec 2019 08:30:31 -0800 (PST)
In-Reply-To: <20191202123430.7125-1-yuri.benditovich@daynix.com>
Subject: Re: [PATCH 0/2] Remove 'remote wakeup' flag from USB config descriptor
Message-ID: <157530423020.2847.13781787321931276923@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yuri.benditovich@daynix.com
Date: Mon, 2 Dec 2019 08:30:31 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: qemu-devel@nongnu.org, yan@daynix.com, ehabkost@redhat.com,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwMjEyMzQzMC43MTI1
LTEteXVyaS5iZW5kaXRvdmljaEBkYXluaXguY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMC8yXSBSZW1vdmUgJ3JlbW90ZSB3
YWtldXAnIGZsYWcgZnJvbSBVU0IgY29uZmlnIGRlc2NyaXB0b3IKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMTkxMjAyMTIzNDMwLjcxMjUtMS15dXJpLmJlbmRpdG92aWNoQGRheW5peC5jb20K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Bh
dGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAxOTEyMDIw
NjA4MDYuNzc5NjgtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUgLT4gcGF0Y2hldy8yMDE5
MTIwMjA2MDgwNi43Nzk2OC0xLWRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjkxYmM3NDMgdXNiLXJlZGlyOiByZW1vdmUgJ3JlbW90ZSB3
YWtldXAnIGZsYWcgZnJvbSBjb25maWd1cmF0aW9uIGRlc2NyaXB0b3IKZTNhNzlkNyB1c2ItaG9z
dDogcmVtb3ZlICdyZW1vdGUgd2FrZXVwJyBmbGFnIGZyb20gY29uZmlndXJhdGlvbiBkZXNjcmlw
dG9yCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IGUzYTc5ZDc2ODI0
YSAodXNiLWhvc3Q6IHJlbW92ZSAncmVtb3RlIHdha2V1cCcgZmxhZyBmcm9tIGNvbmZpZ3VyYXRp
b24gZGVzY3JpcHRvcikKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBv
biBhIHNlcGFyYXRlIGxpbmUKIzU3OiBGSUxFOiBody91c2IvaG9zdC1saWJ1c2IuYzo0MDA6Cisg
ICAgICAgIC8qIElmIHRoaXMgaXMgR0VUX0RFU0NSSVBUT1IgcmVxdWVzdCBmb3IgY29uZmlndXJh
dGlvbiBkZXNjcmlwdG9yLAoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgdHJhaWxpbmcg
Ki8gb24gYSBzZXBhcmF0ZSBsaW5lCiM1OTogRklMRTogaHcvdXNiL2hvc3QtbGlidXNiLmM6NDAy
OgorICAgICAgICAgKiBpbiBXaW5kb3dzIGd1ZXN0ICovCgpFUlJPUjogbGluZSBvdmVyIDkwIGNo
YXJhY3RlcnMKIzY0OiBGSUxFOiBody91c2IvaG9zdC1saWJ1c2IuYzo0MDc6CisgICAgICAgICAg
ICB4ZmVyLT5hY3R1YWxfbGVuZ3RoID4gb2Zmc2V0b2Yoc3RydWN0IGxpYnVzYl9jb25maWdfZGVz
Y3JpcHRvciwgYm1BdHRyaWJ1dGVzKSAmJgoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3Rl
cnMKIzY4OiBGSUxFOiBody91c2IvaG9zdC1saWJ1c2IuYzo0MTE6CisgICAgICAgICAgICAgICAg
dHJhY2VfdXNiX2hvc3RfcmVtb3RlX3dha2V1cF9yZW1vdmVkKGRlc2MuaWRWZW5kb3IsIGRlc2Mu
aWRQcm9kdWN0KTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM3ODogRklMRTog
aHcvdXNiL2hvc3QtbGlidXNiLmM6MTYxNjoKKyAgICBERUZJTkVfUFJPUF9CT09MKCJzdXBwcmVz
cy1yZW1vdGUtd2FrZSIsIFVTQkhvc3REZXZpY2UsIHN1cHByZXNzX3JlbW90ZV93YWtlLCB0cnVl
KSwKCnRvdGFsOiAxIGVycm9ycywgNCB3YXJuaW5ncywgNTMgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
MS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tpbmcgY29tbWl0IDkxYmM3
NDNmYWU0YiAodXNiLXJlZGlyOiByZW1vdmUgJ3JlbW90ZSB3YWtldXAnIGZsYWcgZnJvbSBjb25m
aWd1cmF0aW9uIGRlc2NyaXB0b3IpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM3
MjogRklMRTogaHcvdXNiL3JlZGlyZWN0LmM6MjU1MToKKyAgICBERUZJTkVfUFJPUF9CT09MKCJz
dXBwcmVzcy1yZW1vdGUtd2FrZSIsIFVTQlJlZGlyRGV2aWNlLCBzdXBwcmVzc19yZW1vdGVfd2Fr
ZSwgdHJ1ZSksCgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDQ0IGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDIvMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0K
ClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTIwMjEyMzQzMC43MTI1LTEteXVy
aS5iZW5kaXRvdmljaEBkYXluaXguY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


