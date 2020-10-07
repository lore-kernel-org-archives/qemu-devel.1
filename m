Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774FFC47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B294020739
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B294020739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCmO-0003mP-IF
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQCcy-0000yx-AS; Wed, 07 Oct 2020 12:49:20 -0400
Resent-Date: Wed, 07 Oct 2020 12:49:20 -0400
Resent-Message-Id: <E1kQCcy-0000yx-AS@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQCcv-0002FX-L7; Wed, 07 Oct 2020 12:49:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602089339; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ENb602Vy0UgRWm1SjzkkSlVstRr9WaZcv4+q28w5vupNRuVZB+VPKBMzJWIC6Wj7nhaWG8GFTEMHX4UYXtf6RMel8YHtdAYSFOnO8iPUCjtDWZhwZVpcLN8t3x6QnEqlCV2JWzBjdMHQL897/j5RPpeNcCkGmRfjPrdZDZQ0+Fs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602089339;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vgdCQ7ncc0N8wos2UXuVVF4IsIDp/Adj3TKinqYRmrU=; 
 b=VtRsAXvNnY5FtQnLRrYn6Fjs/xayLzWxeexxJWOjtnNeF5nuVRkhGrBTnS5kQHMXyk6925re3j6MHIt4uz6g1HdWfc5K/AGxwJ95AUWO2PPAWxVUAFuQByXjHH9wBnSIrPpyIqKjOzRgTwERWqHHEp2Zi7wfN+rrTzYMXu6D0hg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602089336262670.5117220606605;
 Wed, 7 Oct 2020 09:48:56 -0700 (PDT)
Subject: Re: [PATCH v6] scripts: Convert qemu-version.sh to qemu-version.py
Message-ID: <160208933460.3664.3185538282247320794@66eaa9a8a123>
In-Reply-To: <20201007162138.425-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luoyonggang@gmail.com
Date: Wed, 7 Oct 2020 09:48:56 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 12:49:11
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwNzE2MjEzOC40MjUt
MS1sdW95b25nZ2FuZ0BnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAwNzE2MjEzOC40MjUt
MS1sdW95b25nZ2FuZ0BnbWFpbC5jb20KU3ViamVjdDogW1BBVENIIHY2XSBzY3JpcHRzOiBDb252
ZXJ0IHFlbXUtdmVyc2lvbi5zaCB0byBxZW11LXZlcnNpb24ucHkKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDEwMDcxNjIxMzguNDI1LTEtbHVveW9u
Z2dhbmdAZ21haWwuY29tIC0+IHBhdGNoZXcvMjAyMDEwMDcxNjIxMzguNDI1LTEtbHVveW9uZ2dh
bmdAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYzFjNmM5YyBzY3Jp
cHRzOiBDb252ZXJ0IHFlbXUtdmVyc2lvbi5zaCB0byBxZW11LXZlcnNpb24ucHkKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzMzOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
CldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM1ODogRklMRTogc2NyaXB0cy9xZW11
LXZlcnNpb24ucHk6MjE6CisgICAgICAgIHBjID0gc3VicHJvY2Vzcy5ydW4oWydnaXQnLCAnZGVz
Y3JpYmUnLCAnLS1tYXRjaCcsICIndionIiwgJy0tZGlydHknLCAnLS1hbHdheXMnXSwKCkVSUk9S
OiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNTk6IEZJTEU6IHNjcmlwdHMvcWVtdS12ZXJzaW9u
LnB5OjIyOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0ZG91dD1zdWJwcm9jZXNzLlBJ
UEUsIHN0ZGVycj1zdWJwcm9jZXNzLkRFVk5VTEwsIGVuY29kaW5nPSd1dGY4JykKCnRvdGFsOiAx
IGVycm9ycywgMiB3YXJuaW5ncywgNDIgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGMxYzZjOWMwNDM0
OSAoc2NyaXB0czogQ29udmVydCBxZW11LXZlcnNpb24uc2ggdG8gcWVtdS12ZXJzaW9uLnB5KSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMTAwNzE2MjEzOC40MjUtMS1sdW95b25nZ2FuZ0BnbWFp
bC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

