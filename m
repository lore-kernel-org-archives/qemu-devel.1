Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE74C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613AC207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 19:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613AC207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQFDO-0006I2-Dt
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 15:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQFCO-0005EK-15; Wed, 07 Oct 2020 15:34:04 -0400
Resent-Date: Wed, 07 Oct 2020 15:34:04 -0400
Resent-Message-Id: <E1kQFCO-0005EK-15@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQFCI-0000Dp-PF; Wed, 07 Oct 2020 15:34:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602099225; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eK+T3VDOoCEuDPqR37nHSZT98BiZdOE8JE0KJksY4KRuzJ+XGLExNeDZuLTiTm3JP/Vf0bkoO0S3UVcHir5xuH2YHVd3qstarWSKv+qjLwCYh++q0QXk9MMqxqyhduKlQnAeQ8lfjkxtuXkXoA34MptYMpmIbVEBGAW6BRTR1ZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602099225;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zWD0NPZinfQ5QQWUI4nwYpnPYulJ/Ds3Bp9Z4X/n9iU=; 
 b=iShDYkACtaPUR8f5DyJ19zn1GdVm4ESS+FAUmLyNbB474TzS2oG9TmkAebUvGCbnLeP91MA7LTBIvNqbTMXIQanljvWFqme20GgnNG2QZvHQ06+G1GIWtFRxm0Zhm0EHMxzLvz0xwDZwL6NgPsfjeVxK1IVJFPMo4+BHyqtkgRI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602099222184956.138247267311;
 Wed, 7 Oct 2020 12:33:42 -0700 (PDT)
Subject: Re: [PATCH v7] scripts: Convert qemu-version.sh to qemu-version.py
Message-ID: <160209922036.3664.11448137849652157024@66eaa9a8a123>
In-Reply-To: <20201007192940.280-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luoyonggang@gmail.com
Date: Wed, 7 Oct 2020 12:33:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 15:33:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, luoyonggang@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwNzE5Mjk0MC4yODAt
MS1sdW95b25nZ2FuZ0BnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAwNzE5Mjk0MC4yODAt
MS1sdW95b25nZ2FuZ0BnbWFpbC5jb20KU3ViamVjdDogW1BBVENIIHY3XSBzY3JpcHRzOiBDb252
ZXJ0IHFlbXUtdmVyc2lvbi5zaCB0byBxZW11LXZlcnNpb24ucHkKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDEwMDcxOTI5NDAuMjgwLTEtbHVveW9u
Z2dhbmdAZ21haWwuY29tIC0+IHBhdGNoZXcvMjAyMDEwMDcxOTI5NDAuMjgwLTEtbHVveW9uZ2dh
bmdAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMzRiNDY4NiBzY3Jp
cHRzOiBDb252ZXJ0IHFlbXUtdmVyc2lvbi5zaCB0byBxZW11LXZlcnNpb24ucHkKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM1OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
CkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNjA6IEZJTEU6IHNjcmlwdHMvcWVtdS12
ZXJzaW9uLnB5OjIxOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0ZG91dD1zdWJwcm9j
ZXNzLlBJUEUsIHN0ZGVycj1zdWJwcm9jZXNzLkRFVk5VTEwsIGVuY29kaW5nPSd1dGY4Jywgc2hl
bGw9RmFsc2UpCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDQxIGxpbmVzIGNoZWNrZWQK
CkNvbW1pdCAzNGI0Njg2NzNkZWUgKHNjcmlwdHM6IENvbnZlcnQgcWVtdS12ZXJzaW9uLnNoIHRv
IHFlbXUtdmVyc2lvbi5weSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDEwMDcxOTI5NDAuMjgw
LTEtbHVveW9uZ2dhbmdAZ21haWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

