Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC87C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C65F22D37
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 15:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C65F22D37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i45cB-0004pQ-Vl
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 11:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i45ax-0004LK-Fo
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i45av-0001l3-Op
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:47:19 -0400
Resent-Date: Sat, 31 Aug 2019 11:47:18 -0400
Resent-Message-Id: <E1i45av-0001l3-Op@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i45av-0001ZV-Bs
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 11:47:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567266404; cv=none; d=zoho.com; s=zohoarc; 
 b=WKF6OlYywc3gzbIalmhI9lkSwmKb9Qsuu6DkSXZJiZzsnNkMl0K3WdcF0F6L3Qozm9uZBERRApRlZ1t5EAiU7biyVOZaoiC8JBT9erXoNQiEB0pNTWoytFj7900yE+SNsEzVX2NwKgG9N6HxF+iq0UT+A/LmlllvYj0qHAL7/dA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567266404;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=v8D+hETjBdbOyTiPFZDx4h4fdmbakWyrzmYzPeNJ82U=; 
 b=B41KKwx72izxcf2jmCtajnIB4Ofn06WuBGS48HpBf3c24ZOoY2m+8pVuub3XBa5mFDKPazMCQgp3r8+e3sCTlh4G2fJQDzlLw5iZKJ2CRKObHECW7qY8T9u4Uqu1R7fU0zDEmebJ6L3OXnIMrezfrtTzTTLNMTsTtFatkWK+PjQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1567266402347998.8467691569705;
 Sat, 31 Aug 2019 08:46:42 -0700 (PDT)
In-Reply-To: <20190831153922.121308-1-liq3ea@163.com>
Message-ID: <156726640099.4971.12196429235488580695@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liq3ea@163.com
Date: Sat, 31 Aug 2019 08:46:42 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] vnc: fix memory leak when vnc disconnect
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
Cc: fangying1@huawei.com, liq3ea@gmail.com, liq3ea@163.com, kraxel@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgzMTE1MzkyMi4xMjEz
MDgtMS1saXEzZWFAMTYzLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwODMxMTUzOTIyLjEyMTMwOC0x
LWxpcTNlYUAxNjMuY29tClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHZuYzogZml4IG1l
bW9yeSBsZWFrIHdoZW4gdm5jIGRpc2Nvbm5lY3QKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFt
Ci4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEz
Mzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZmI1MmI0OSB2bmM6IGZpeCBtZW1v
cnkgbGVhayB3aGVuIHZuYyBkaXNjb25uZWN0Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4Old4QikKIzExODogRklMRTogdWkv
dm5jLWVuYy10aWdodC5jOjM1NToKKyAgICAgICAgZGF0YSA9ICh1aW50IyNicHAjI190ICopdnMt
PnRpZ2h0LT50aWdodC5idWZmZXI7ICAgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgODY5IGxpbmVzIGNo
ZWNrZWQKCkNvbW1pdCBmYjUyYjQ5Mjc1N2EgKHZuYzogZml4IG1lbW9yeSBsZWFrIHdoZW4gdm5j
IGRpc2Nvbm5lY3QpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwODMxMTUzOTIyLjEyMTMwOC0x
LWxpcTNlYUAxNjMuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


