Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B1C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E571C214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 04:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E571C214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvwu8-0004P6-7e
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 00:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hvwt7-0003CQ-VL
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hvwt6-0002IA-MB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 00:52:25 -0400
Resent-Date: Fri, 09 Aug 2019 00:52:25 -0400
Resent-Message-Id: <E1hvwt6-0002IA-MB@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hvwt6-0002H2-Ec; Fri, 09 Aug 2019 00:52:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1565326336; cv=none; d=zoho.com; s=zohoarc; 
 b=E87/PysUjd4KlHtRnqXcmGwd+lG0gGH+exfGxyicFtdI0aEazVvFfgs3e6pMA9fnMsMLoEBnJ6dYZ/lp/NenMMtbqbXeCZFoubJZrJxqOIrczOIibU/9tEQVbPglY9uORBYZyerE0+qbGidItdG6dMBATxnyEwdo6XG9pxjomrk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1565326336;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=cyCaOyeYAAKyIiohxyN4foswcRbCGOq0h57FAmazftw=; 
 b=Hdz6hDizK4nbv92QRKEqw0qLSoMMBFMySwQ8Z9ayzN8Vh1J8IUa1I3JV98JAJWEwT2wyDQcZljlqJrGOn+MmD0WGe5bm+emobJqxFoPNwIE9Ge/UOSs0XLKiqokolxm3Ah03uZGqCiUp/MbJh643qGACv4Ban+wEaE1Oiwccbs4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1565326334093260.07771065423503;
 Thu, 8 Aug 2019 21:52:14 -0700 (PDT)
In-Reply-To: <20190809041952.57302-1-rebecca@bsdio.com>
Message-ID: <156532633286.12874.928655968593675018@b08f24806b7e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rebecca@bsdio.com
Date: Thu, 8 Aug 2019 21:52:14 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
Subject: Re: [Qemu-devel] [PATCH] Update the avx2 configure test to be
 compatible with clang
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
Cc: qemu-trivial@nongnu.org, rebecca@bsdio.com, mjt@tls.msk.ru,
 qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgwOTA0MTk1Mi41NzMw
Mi0xLXJlYmVjY2FAYnNkaW8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2Ug
ZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11IEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdXRpbC9xZW11LXNv
Y2tldHMubwogIENDICAgICAgdXRpbC91cmkubwogIENDICAgICAgdXRpbC9ub3RpZnkubwovdG1w
L3FlbXUtdGVzdC9zcmMvdXRpbC9idWZmZXJpc3plcm8uYzo3MToxMzogZXJyb3I6IHVua25vd24g
cHJhZ21hIGlnbm9yZWQgWy1XZXJyb3IsLVd1bmtub3duLXByYWdtYXNdCiNwcmFnbWEgR0NDIHB1
c2hfb3B0aW9ucwogICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy91dGlsL2J1ZmZlcmlz
emVyby5jOjcyOjEzOiBlcnJvcjogdW5rbm93biBwcmFnbWEgaWdub3JlZCBbLVdlcnJvciwtV3Vu
a25vd24tcHJhZ21hc10KI3ByYWdtYSBHQ0MgdGFyZ2V0KCJzc2UyIikKICAgICAgICAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9idWZmZXJpc3plcm8uYzoxMDg6MTM6IGVycm9yOiB1bmtu
b3duIHByYWdtYSBpZ25vcmVkIFstV2Vycm9yLC1XdW5rbm93bi1wcmFnbWFzXQojcHJhZ21hIEdD
QyBwb3Bfb3B0aW9ucwogICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy91dGlsL2J1ZmZl
cmlzemVyby5jOjExNjoxMzogZXJyb3I6IHVua25vd24gcHJhZ21hIGlnbm9yZWQgWy1XZXJyb3Is
LVd1bmtub3duLXByYWdtYXNdCiNwcmFnbWEgR0NDIHB1c2hfb3B0aW9ucwogICAgICAgICAgICBe
Ci90bXAvcWVtdS10ZXN0L3NyYy91dGlsL2J1ZmZlcmlzemVyby5jOjExNzoxMzogZXJyb3I6IHVu
a25vd24gcHJhZ21hIGlnbm9yZWQgWy1XZXJyb3IsLVd1bmtub3duLXByYWdtYXNdCiNwcmFnbWEg
R0NDIHRhcmdldCgic3NlNCIpCiAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwv
YnVmZmVyaXN6ZXJvLmM6MTQ4OjEzOiBlcnJvcjogdW5rbm93biBwcmFnbWEgaWdub3JlZCBbLVdl
cnJvciwtV3Vua25vd24tcHJhZ21hc10KI3ByYWdtYSBHQ0MgcG9wX29wdGlvbnMKICAgICAgICAg
ICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvdXRpbC9idWZmZXJpc3plcm8uYzoxNDk6MTM6IGVycm9y
OiB1bmtub3duIHByYWdtYSBpZ25vcmVkIFstV2Vycm9yLC1XdW5rbm93bi1wcmFnbWFzXQojcHJh
Z21hIEdDQyBwdXNoX29wdGlvbnMKICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvdXRp
bC9idWZmZXJpc3plcm8uYzoxNTA6MTM6IGVycm9yOiB1bmtub3duIHByYWdtYSBpZ25vcmVkIFst
V2Vycm9yLC1XdW5rbm93bi1wcmFnbWFzXQojcHJhZ21hIEdDQyB0YXJnZXQoImF2eDIiKQogICAg
ICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy91dGlsL2J1ZmZlcmlzemVyby5jOjE4NzoxMzog
ZXJyb3I6IHVua25vd24gcHJhZ21hIGlnbm9yZWQgWy1XZXJyb3IsLVd1bmtub3duLXByYWdtYXNd
CiNwcmFnbWEgR0NDIHBvcF9vcHRpb25zCiAgICAgICAgICAgIF4KOSBlcnJvcnMgZ2VuZXJhdGVk
LgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTA4MDkwNDE5NTIuNTczMDItMS1yZWJlY2NhQGJzZGlvLmNvbS90ZXN0aW5nLmFzYW4vP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


