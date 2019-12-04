Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA0C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2BB20833
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2BB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icTmo-0008KL-5i
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 07:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1icTDu-0004Dt-LB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:53:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1icTDp-0006jk-PU
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 06:53:35 -0500
Resent-Date: Wed, 04 Dec 2019 06:53:35 -0500
Resent-Message-Id: <E1icTDp-0006jk-PU@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1icTDn-0006Jf-Rh; Wed, 04 Dec 2019 06:53:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575460400; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F8jypdx9V1X8Re6q6iTZdKFL6EJcmHmmIaDVovi1rq2vtQvPZsV8VghNTv6OlNB0gRWF5Qz2rvofWBJuGxus73Oc1WexYOhYexh+Zo5mI0OS0XRsWoBzaRedPG2X0W0aSGF5waEWQIFDf+6h7JDPSrsOtQ4/vRVoIFcMfU+P8P4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575460400;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hFMsxS+ExnFRVxRW7VzE+YkEb9qWfXcVwGFKkSZdJJ4=; 
 b=YiF/aPV4TV6srsEpKFih62vBEhXAc48iOx4gXuqjmbwCrI7f2tAuncvKfyfdgranXc/P/CSxsyopG535rf9nd5b/B6vWZoAyqZLgLAgybZ58xR8XUPjxFJngdwpxG7FZYCtPuedob7cKSF0e+pd28jvZcL4pFqj4CWBThcKZ51s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575460398468289.67097072103354;
 Wed, 4 Dec 2019 03:53:18 -0800 (PST)
In-Reply-To: <20191204085628.2892-1-hhan@redhat.com>
Subject: Re: [PATCH] Revert "qemu-options.hx: Update for reboot-timeout
 parameter"
Message-ID: <157546039706.18804.4103010064190588655@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: hhan@redhat.com
Date: Wed, 4 Dec 2019 03:53:18 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: qemu-trivial@nongnu.org, laurent@vivier.eu, qemu-devel@nongnu.org,
 dgilbert@redhat.com, hhan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwNDA4NTYyOC4yODky
LTEtaGhhbkByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIFJldmVydCAicWVtdS1vcHRpb25zLmh4OiBVcGRhdGUg
Zm9yIHJlYm9vdC10aW1lb3V0IHBhcmFtZXRlciIKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIw
MTkxMjA0MDg1NjI4LjI4OTItMS1oaGFuQHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNjgwMzMzOCBSZXZlcnQg
InFlbXUtb3B0aW9ucy5oeDogVXBkYXRlIGZvciByZWJvb3QtdGltZW91dCBwYXJhbWV0ZXIiCgo9
PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMp
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEwIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA2
ODAzMzM4MjIwMjYgKFJldmVydCAicWVtdS1vcHRpb25zLmh4OiBVcGRhdGUgZm9yIHJlYm9vdC10
aW1lb3V0IHBhcmFtZXRlciIpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMjA0MDg1NjI4LjI4
OTItMS1oaGFuQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t


