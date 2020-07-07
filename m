Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA34C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954E8206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954E8206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssSM-0004Jm-Ul
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jssFo-0001Ct-NQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:23:41 -0400
Resent-Date: Tue, 07 Jul 2020 14:23:40 -0400
Resent-Message-Id: <E1jssFo-0001Ct-NQ@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jssFl-0003ip-Cm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:23:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594146209; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=g4UZuQEbnoKS+f8/nHOf6yDaQRuB9H/DtuShLHgcQzkDa85Iv9mdoH+cyBXkaFQkiGr52gc/82tAvB5y5q8c7RlWjBowyh21r2x3ZHj0pL5WChlCr5Sr5Z1SOmkNDNNDECdj6W+Oo9Sm544bDjH6cWnH4LXo4U5XZvPpjnZ3ADg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594146209;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ze1tNExNEwO6oCGnSKIHjaRcTNucsb4kIdyWC7s0uQ4=; 
 b=kfOjMeCCPPIfraoFhcD+Bnu8wuIgf/PjSlA/XpGVzB+4Wu75fOLwhcn611GPsKMrn2eYz3PaCaE308/xY0MwxoDtZPpNYB4Q5OA3sVm7tYxjbKp3WJvqKDFXCUS8Elfd4pd76MEIVz6nP4KFcHUL8AIkFkkHpjuBd75xUr47c9o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594146206535819.9804559860883;
 Tue, 7 Jul 2020 11:23:26 -0700 (PDT)
Subject: Re: [PULL 0/3] MIPS + TCG Continuous Benchmarking queue for July 7th,
 2020
Message-ID: <159414620534.3720.16902556210213482395@07a7f0d89f7d>
In-Reply-To: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.qemu.devel@gmail.com
Date: Tue, 7 Jul 2020 11:23:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 14:23:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, aleksandar.qemu.devel@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk0MTQwMDYyLTIzNTIyLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5xZW11LmRldmVsQGdtYWlsLmNvbS8KCgoKSGksCgpU
aGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUg
b3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2Ut
aWQ6IDE1OTQxNDAwNjItMjM1MjItMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLnFlbXUuZGV2
ZWxAZ21haWwuY29tClN1YmplY3Q6IFtQVUxMIDAvM10gTUlQUyArIFRDRyBDb250aW51b3VzIEJl
bmNobWFya2luZyBxdWV1ZSBmb3IgSnVseSA3dGgsIDIwMjAKCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJk
ODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAg
IDcxMGZiMDguLmM4ZWFmODEgIG1hc3RlciAgICAgLT4gbWFzdGVyCiAtIFt0YWcgdXBkYXRlXSAg
ICAgIHBhdGNoZXcvMjAyMDA3MDExODM5NDkuMzk4MTM0LTEtYXRpc2gucGF0cmFAd2RjLmNvbSAt
PiBwYXRjaGV3LzIwMjAwNzAxMTgzOTQ5LjM5ODEzNC0xLWF0aXNoLnBhdHJhQHdkYy5jb20KICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDcwNzE4MDgzNi41NDM1LTEtdnJfcWVtdUB0
LW9ubGluZS5kZSAtPiBwYXRjaGV3LzIwMjAwNzA3MTgwODM2LjU0MzUtMS12cl9xZW11QHQtb25s
aW5lLmRlClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKOTYyZjI5ZSBzY3JpcHRzL3Bl
cmZvcm1hbmNlOiBBZGQgZGlzc2VjdC5weSBzY3JpcHQKZTY0NmQ3MyBkaXNhczogbWlwczogQWRk
IExvb25nc29uIDJGIGRpc2Fzc2VtYmxlcgo5OWUwMDlmIHRhcmdldC9taXBzOiBmcHU6IEZpeCBy
ZWNlbnQgcmVncmVzc2lvbiBpbiBhZGQucyBhZnRlciAxYWNlMDk5ZjJhCgo9PT0gT1VUUFVUIEJF
R0lOID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IDk5ZTAwOWYzOTU1YiAodGFyZ2V0L21pcHM6IGZw
dTogRml4IHJlY2VudCByZWdyZXNzaW9uIGluIGFkZC5zIGFmdGVyIDFhY2UwOTlmMmEpCjIvMyBD
aGVja2luZyBjb21taXQgZTY0NmQ3M2Y4YjZlIChkaXNhczogbWlwczogQWRkIExvb25nc29uIDJG
IGRpc2Fzc2VtYmxlcikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwg
ZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjA6IApuZXcgZmlsZSBtb2RlIDEwMDY0
NAoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVu
IHBhcmVudGhlc2lzICcoJwojMTA3OTU6IEZJTEU6IGluY2x1ZGUvZGlzYXMvZGlzLWFzbS5oOjM5
OToKK2ludCBwcmludF9pbnNuX2xvb25nc29uMmYgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxl
X2luZm8qKTsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTA3NjMgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzMgQ2hlY2tpbmcgY29t
bWl0IDk2MmYyOWUwOWE4OSAoc2NyaXB0cy9wZXJmb3JtYW5jZTogQWRkIGRpc3NlY3QucHkgc2Ny
aXB0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5U
QUlORVJTIG5lZWQgdXBkYXRpbmc/CiMzMzogCm5ldyBmaWxlIG1vZGUgMTAwNzU1Cgp0b3RhbDog
MCBlcnJvcnMsIDEgd2FybmluZ3MsIDE2NSBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzMgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMTU5NDE0MDA2Mi0yMzUyMi0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5k
YXIucWVtdS5kZXZlbEBnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

