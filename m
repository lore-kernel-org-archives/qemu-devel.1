Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA97C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B89207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B89207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdhn-0002cW-Ai
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqdfv-0000Lx-NC
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:25:23 -0400
Resent-Date: Wed, 01 Jul 2020 10:25:23 -0400
Resent-Message-Id: <E1jqdfv-0000Lx-NC@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqdfq-0001vV-Rq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:25:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593613497; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LIkcve+xUVCn37GggvN9jSDd+KUSHdYIrqi6vmIS6NhA8Hdbe0kO3rkYSyFQ4DvEUIWfjlWyODm1cOK72j9taZdz414oNsFCphc+e58IMPRIgh1Oxwno27s+/ak/NdWX9FLtxuZT8lg4kKp8Rh8vMLU259wh5QtAymu7TC9u30s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593613497;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=MeQna3sOE1bogK1HrISvyaAEkB/Nc3QquUT6aUSm1oA=; 
 b=bWMAHkdXA6BsJs04prFSWhBrAy9HzgOey1I1U8NsH7NOH1XT0FMt4PCXkcgEQb8u1XEEaySxH8u+WnzU7HS7NkSZIJxJGpPFJw9tOKpWNpuzeYuC8nSLhyoOmVkY9Bfdqx5kUm7pj964ka1quKqwweJ6WnbE08wSO55gk/yTvGE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593613492399878.0960906124783;
 Wed, 1 Jul 2020 07:24:52 -0700 (PDT)
Message-ID: <159361349123.26405.13886207944377670259@d1fd068a5071>
Subject: Re: [PATCH v2] tests: disassemble-aml.sh: generate AML in readable
 format
In-Reply-To: <20200701121349.50523-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Wed, 1 Jul 2020 07:24:52 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 10:25:14
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMTEyMTM0OS41MDUy
My0xLW1zdEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjJdIHRlc3RzOiBkaXNhc3NlbWJsZS1hbWwuc2g6IGdl
bmVyYXRlIEFNTCBpbiByZWFkYWJsZSBmb3JtYXQKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIw
MjAwNzAxMTIxMzQ5LjUwNTIzLTEtbXN0QHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2Nh
bCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlz
dG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNU
IFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNzAxMTIxMzQ5LjUwNTIzLTEt
bXN0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDcwMTEyMTM0OS41MDUyMy0xLW1zdEByZWRo
YXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYWI1NDIzMiB0ZXN0czogZGlz
YXNzZW1ibGUtYW1sLnNoOiBnZW5lcmF0ZSBBTUwgaW4gcmVhZGFibGUgZm9ybWF0Cgo9PT0gT1VU
UFVUIEJFR0lOID09PQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxNjogCm5ldyBmaWxlIG1vZGUgMTAwNzU1
CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzA6IEZJTEU6IHRlc3RzL2RhdGEv
YWNwaS9kaXNhc3NlbWxlLWFtbC5zaDoxMDoKKyAgICAgICAgZWNobyAiVXNhZ2U6IC4vdGVzdHMv
ZGF0YS9hY3BpL2Rpc2Fzc2VtbGUtYW1sLnNoIFstbyA8b3V0cHV0LWRpcmVjdG9yeT5dIgoKRVJS
T1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM4MTogRklMRTogdGVzdHMvZGF0YS9hY3BpL3Jl
YnVpbGQtZXhwZWN0ZWQtYW1sLnNoOjM5OgorZWNobyAiWW91IGNhbiB1c2UgJHtTUkNfUEFUSH0v
dGVzdHMvZGF0YS9hY3BpL2Rpc2Fzc2VtbGUtYW1sLnNoIHRvIGRpc2Fzc2VtYmxlIHRoZW0gdG8g
QVNMLiIKCnRvdGFsOiAxIGVycm9ycywgMiB3YXJuaW5ncywgNTkgbGluZXMgY2hlY2tlZAoKQ29t
bWl0IGFiNTQyMzI5M2RhMiAodGVzdHM6IGRpc2Fzc2VtYmxlLWFtbC5zaDogZ2VuZXJhdGUgQU1M
IGluIHJlYWRhYmxlIGZvcm1hdCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3MDExMjEzNDku
NTA1MjMtMS1tc3RAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=

