Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C3C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255F020782
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 06:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255F020782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPD0-0003oL-Th
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 02:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44894)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQPBm-0003G1-BC; Thu, 08 Oct 2020 02:14:06 -0400
Resent-Date: Thu, 08 Oct 2020 02:14:06 -0400
Resent-Message-Id: <E1kQPBm-0003G1-BC@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQPBh-0004xC-Ov; Thu, 08 Oct 2020 02:14:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602137634; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BHFlzCKLw/waY6eJwW9FYk5MBX167dNQWw/A/BNYOka9ziSTtAQSff4+gWRVxakDW5jySgKHpBFNWTC0WzBibyNvGzkyRWUwqMOmaMDY2DSkL4jkLYs6+JHbu31vLsr6Q1ZUESfPnjwAiAsZAOterXr6AxxL0YwWmoQTOe0RC4E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602137634;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oRHsSwCSn+EbvUBDZiD7ujX766ZD3qyxAdoL2yP+wyc=; 
 b=hHcRO4QvgUO0pegQxmz/kSuM/XIi7cdHDQntr+3o2PVuQe23w9zXi4qGBr6rVGyUQPX6ARJ7hkg2djho2ADxPQ+iWZ1yIbqfcgGZi+EGfLV40d4OB1nPVfQPGsCXWWo8aQxdLO9nHaN92lzaRn4WlxVQXQvpcUVdqVNePsdYOoA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602137631199424.6516133880799;
 Wed, 7 Oct 2020 23:13:51 -0700 (PDT)
Subject: Re: [PATCH] Fixing LGPL version number
Message-ID: <160213762982.3664.4276125729135036871@66eaa9a8a123>
In-Reply-To: <20201008060528.68579-1-chetan4windows@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: chetan4windows@gmail.com
Date: Wed, 7 Oct 2020 23:13:51 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:13:58
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, chetan4windows@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwODA2MDUyOC42ODU3
OS0xLWNoZXRhbjR3aW5kb3dzQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAxMDA4MDYwNTI4
LjY4NTc5LTEtY2hldGFuNHdpbmRvd3NAZ21haWwuY29tClN1YmplY3Q6IFtQQVRDSF0gRml4aW5n
IExHUEwgdmVyc2lvbiBudW1iZXIKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20g
aHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAg
ICAgIHBhdGNoZXcvMjAyMDEwMDgwNjA1MjguNjg1NzktMS1jaGV0YW40d2luZG93c0BnbWFpbC5j
b20gLT4gcGF0Y2hldy8yMDIwMTAwODA2MDUyOC42ODU3OS0xLWNoZXRhbjR3aW5kb3dzQGdtYWls
LmNvbQpBdXRvIHBhY2tpbmcgdGhlIHJlcG9zaXRvcnkgZm9yIG9wdGltdW0gcGVyZm9ybWFuY2Uu
IFlvdSBtYXkgYWxzbwpydW4gImdpdCBnYyIgbWFudWFsbHkuIFNlZSAiZ2l0IGhlbHAgZ2MiIGZv
ciBtb3JlIGluZm9ybWF0aW9uLgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjczNTVh
NTYgRml4aW5nIExHUEwgdmVyc2lvbiBudW1iZXIKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9S
OiBzcGFjZSBwcm9oaWJpdGVkIGJldHdlZW4gZnVuY3Rpb24gbmFtZSBhbmQgb3BlbiBwYXJlbnRo
ZXNpcyAnKCcKIzExNTQ6IEZJTEU6IGh3L25ldC9lMTAwMGUuYzoyNToKKyogdmVyc2lvbiAyLjEg
b2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCgpF
UlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFy
ZW50aGVzaXMgJygnCiMxMTY3OiBGSUxFOiBody9uZXQvZTEwMDBlX2NvcmUuYzoyNToKKyogdmVy
c2lvbiAyLjEgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5k
IG9wZW4gcGFyZW50aGVzaXMgJygnCiMxMTgwOiBGSUxFOiBody9uZXQvZTEwMDBlX2NvcmUuaDoy
NToKKyogdmVyc2lvbiAyLjEgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55
IGxhdGVyIHZlcnNpb24uCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9u
IG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiMxMTkzOiBGSUxFOiBody9uZXQvZTEwMDB4
X2NvbW1vbi5jOjE0OgorKiB2ZXJzaW9uIDIuMSBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIg
b3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJldHdl
ZW4gZnVuY3Rpb24gbmFtZSBhbmQgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzEyMDY6IEZJTEU6IGh3
L25ldC9lMTAwMHhfY29tbW9uLmg6MTQ6CisqIHZlcnNpb24gMi4xIG9mIHRoZSBMaWNlbnNlLCBv
ciAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgoKRVJST1I6IGRvIG5vdCB1c2Ug
Qzk5IC8vIGNvbW1lbnRzCiM0MjI5OiBGSUxFOiB0YXJnZXQvaTM4Ni9odmYveDg2X2VtdS5jOjI2
OgorLy8gIHZlcnNpb24gMi4xIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQgeW91ciBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLgoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiM0MjU1
OiBGSUxFOiB0YXJnZXQvaTM4Ni9odmYveDg2X2ZsYWdzLmM6OToKKy8vICB2ZXJzaW9uIDIuMSBv
ZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KCkVS
Uk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojNDI2ODogRklMRTogdGFyZ2V0L2kzODYv
aHZmL3g4Nl9mbGFncy5oOjk6CisvLyAgdmVyc2lvbiAyLjEgb2YgdGhlIExpY2Vuc2UsIG9yIChh
dCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCgpFUlJPUjogc3BhY2UgcHJvaGliaXRl
ZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM1MjMwOiBG
SUxFOiB0YXJnZXQvc3BhcmMvdHJhbnNsYXRlLmM6MTA6CisgICB2ZXJzaW9uIDIuMSBvZiB0aGUg
TGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KCnRvdGFsOiA5
IGVycm9ycywgMCB3YXJuaW5ncywgMzkzNiBsaW5lcyBjaGVja2VkCgpDb21taXQgNzM1NWE1NjM3
MzRiIChGaXhpbmcgTEdQTCB2ZXJzaW9uIG51bWJlcikgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDEwMDgwNjA1MjguNjg1NzktMS1jaGV0YW40d2luZG93c0BnbWFpbC5jb20vdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

