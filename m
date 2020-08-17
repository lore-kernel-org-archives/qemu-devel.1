Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C402220674
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C402220674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Vhm-0001W0-VY
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 23:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7VhA-000113-IQ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:20:24 -0400
Resent-Date: Sun, 16 Aug 2020 23:20:24 -0400
Resent-Message-Id: <E1k7VhA-000113-IQ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7Vh8-0001l7-7H
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597634402; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jkvPFXYManV8suCgQ8IEOYsU3BB6x3fvHHelbzDAJdkBiXvA3zKCosc1W10oCzmbFah0bLk2LYvebDEfb+MjS+PWS+O621S4LYurve/Nqrz+UcuLkeh/Cw/JNNR0Bpg5eXrJ84ySRNV0CNlM0szrF1yz7vIXtBZIZpnGRr79wCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597634402;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+fvdGVOllunjFC/zSibYSglkb1Z1QW2D0+K2Y4pFc/M=; 
 b=TK+UaG4nb+Z3S+wZ8jq6A6fkmopc+iWJJgr0AFXprZLzHbCr3uL7cp5I4eWwqHzpDGW2pKtEgzf71Qe2avn2NhzqvxhB8ul+SrdNoex1+uvvcxCYTA8+7qKq8pVHr+eJE2vIF0H6UZ2jtd671EyZDUQFzLmBRlD4g4xs8ISiaiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597634398621790.0186919106437;
 Sun, 16 Aug 2020 20:19:58 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] *** A Method for evaluating dirty page rate ***
Message-ID: <159763439703.28013.16223124632696494268@66eaa9a8a123>
In-Reply-To: <1597634433-18809-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhengchuan@huawei.com
Date: Sun, 16 Aug 2020 20:19:58 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/16 23:20:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, linyilu@huawei.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 ann.zhuangyanying@huawei.com, fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk3NjM0NDMzLTE4ODA5LTEt
Z2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVs
b3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTU5NzYz
NDQzMy0xODgwOS0xLWdpdC1zZW5kLWVtYWlsLXpoZW5nY2h1YW5AaHVhd2VpLmNvbQpTdWJqZWN0
OiBbUEFUQ0ggdjMgMDAvMTBdICoqKiBBIE1ldGhvZCBmb3IgZXZhbHVhdGluZyBkaXJ0eSBwYWdl
IHJhdGUgKioqCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYt
cGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRj
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3
LzE1OTc2MzQ0MzMtMTg4MDktMS1naXQtc2VuZC1lbWFpbC16aGVuZ2NodWFuQGh1YXdlaS5jb20g
LT4gcGF0Y2hldy8xNTk3NjM0NDMzLTE4ODA5LTEtZ2l0LXNlbmQtZW1haWwtemhlbmdjaHVhbkBo
dWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKY2U2ZmUwZCBtaWdyYXRp
b24vZGlydHlyYXRlOiBJbXBsZW1lbnQgcW1wX2NhbF9kaXJ0eV9yYXRlKCkvcW1wX2dldF9kaXJ0
eV9yYXRlKCkgZnVuY3Rpb24KOTZjZTAwNyBtaWdyYXRpb24vZGlydHlyYXRlOiBJbXBsZW1lbnQg
Y2FsY3VsYXRlX2RpcnR5cmF0ZSgpIGZ1bmN0aW9uCjQyNjQyZDQgbWlncmF0aW9uL2RpcnR5cmF0
ZTogSW1wbGVtZW50IGdldF9zYW1wbGVfcGFnZV9wZXJpb2QoKSBhbmQgYmxvY2tfc2FtcGxlX3Bh
Z2VfcGVyaW9kKCkKM2E0ZDRhMiBtaWdyYXRpb24vZGlydHlyYXRlOiBza2lwIHNhbXBsaW5nIHJh
bWJsb2NrIHdpdGggc2l6ZSBiZWxvdyBNSU5fUkFNQkxPQ0tfU0laRQozMWYzNWI3IG1pZ3JhdGlv
bi9kaXJ0eXJhdGU6IENvbXBhcmUgcGFnZSBoYXNoIHJlc3VsdHMgZm9yIHJlY29yZGVkIHNhbXBs
ZWQgcGFnZQphM2Q1ODJkIG1pZ3JhdGlvbi9kaXJ0eXJhdGU6IFJlY29yZCBoYXNoIHJlc3VsdHMg
Zm9yIGVhY2ggc2FtcGxlZCBwYWdlCjg1YzY0NDcgbWlncmF0aW9uL2RpcnR5cmF0ZTogbW92ZSBS
QU1CTE9DS19GT1JFQUNIX01JR1JBVEFCTEUgaW50byByYW0uaApjN2M5NGNjIG1pZ3JhdGlvbi9k
aXJ0eXJhdGU6IEFkZCBkaXJ0eXJhdGUgc3RhdGlzdGljcyBzZXJpZXMgZnVuY3Rpb25zCmE3NmMw
ZDAgbWlncmF0aW9uL2RpcnR5cmF0ZTogQWRkIFJhbWxvY2tEaXJ0eUluZm8gdG8gc3RvcmUgc2Ft
cGxlZCBwYWdlIGluZm8KN2Y2MDkyYyBtaWdyYXRpb24vZGlydHlyYXRlOiBBZGQgZ2V0X2RpcnR5
cmF0ZV90aHJlYWQoKSBmdW5jdGlvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMCBDaGVja2lu
ZyBjb21taXQgN2Y2MDkyYzUyZDVjIChtaWdyYXRpb24vZGlydHlyYXRlOiBBZGQgZ2V0X2RpcnR5
cmF0ZV90aHJlYWQoKSBmdW5jdGlvbikKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQg
ZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjY6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxMTUgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMS8xMCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoyLzEwIENoZWNraW5nIGNv
bW1pdCBhNzZjMGQwOGU5M2QgKG1pZ3JhdGlvbi9kaXJ0eXJhdGU6IEFkZCBSYW1sb2NrRGlydHlJ
bmZvIHRvIHN0b3JlIHNhbXBsZWQgcGFnZSBpbmZvKQozLzEwIENoZWNraW5nIGNvbW1pdCBjN2M5
NGNjNGMxN2QgKG1pZ3JhdGlvbi9kaXJ0eXJhdGU6IEFkZCBkaXJ0eXJhdGUgc3RhdGlzdGljcyBz
ZXJpZXMgZnVuY3Rpb25zKQo0LzEwIENoZWNraW5nIGNvbW1pdCA4NWM2NDQ3M2FiNzAgKG1pZ3Jh
dGlvbi9kaXJ0eXJhdGU6IG1vdmUgUkFNQkxPQ0tfRk9SRUFDSF9NSUdSQVRBQkxFIGludG8gcmFt
LmgpCkVSUk9SOiBNYWNyb3Mgd2l0aCBtdWx0aXBsZSBzdGF0ZW1lbnRzIHNob3VsZCBiZSBlbmNs
b3NlZCBpbiBhIGRvIC0gd2hpbGUgbG9vcAojNjM6IEZJTEU6IG1pZ3JhdGlvbi9yYW0uaDo0MjoK
KyNkZWZpbmUgUkFNQkxPQ0tfRk9SRUFDSF9OT1RfSUdOT1JFRChibG9jaykgICAgICAgICAgICBc
CisgICAgSU5URVJOQUxfUkFNQkxPQ0tfRk9SRUFDSChibG9jaykgICAgICAgICAgICAgICAgICAg
XAorICAgICAgICBpZiAocmFtYmxvY2tfaXNfaWdub3JlZChibG9jaykpIHt9IGVsc2UKCkVSUk9S
OiB0cmFpbGluZyBzdGF0ZW1lbnRzIHNob3VsZCBiZSBvbiBuZXh0IGxpbmUKIzY1OiBGSUxFOiBt
aWdyYXRpb24vcmFtLmg6NDQ6CisgICAgICAgIGlmIChyYW1ibG9ja19pc19pZ25vcmVkKGJsb2Nr
KSkge30gZWxzZQoKRVJST1I6IE1hY3JvcyB3aXRoIG11bHRpcGxlIHN0YXRlbWVudHMgc2hvdWxk
IGJlIGVuY2xvc2VkIGluIGEgZG8gLSB3aGlsZSBsb29wCiM2NzogRklMRTogbWlncmF0aW9uL3Jh
bS5oOjQ2OgorI2RlZmluZSBSQU1CTE9DS19GT1JFQUNIX01JR1JBVEFCTEUoYmxvY2spICAgICAg
ICAgICAgIFwKKyAgICBJTlRFUk5BTF9SQU1CTE9DS19GT1JFQUNIKGJsb2NrKSAgICAgICAgICAg
ICAgICAgICBcCisgICAgICAgIGlmICghcWVtdV9yYW1faXNfbWlncmF0YWJsZShibG9jaykpIHt9
IGVsc2UKCkVSUk9SOiB0cmFpbGluZyBzdGF0ZW1lbnRzIHNob3VsZCBiZSBvbiBuZXh0IGxpbmUK
IzY5OiBGSUxFOiBtaWdyYXRpb24vcmFtLmg6NDg6CisgICAgICAgIGlmICghcWVtdV9yYW1faXNf
bWlncmF0YWJsZShibG9jaykpIHt9IGVsc2UKCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2Fy
eSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzY5OiBGSUxFOiBtaWdyYXRpb24vcmFt
Lmg6NDg6CisgICAgICAgIGlmICghcWVtdV9yYW1faXNfbWlncmF0YWJsZShibG9jaykpIHt9IGVs
c2UKWy4uLl0KKyAgICAgICAgaWYgKCFxZW11X3JhbV9pc19taWdyYXRhYmxlKGJsb2NrKSkge30g
ZWxzZQpbLi4uXQoKdG90YWw6IDUgZXJyb3JzLCAwIHdhcm5pbmdzLCA0NSBsaW5lcyBjaGVja2Vk
CgpQYXRjaCA0LzEwIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzEwIENoZWNraW5nIGNv
bW1pdCBhM2Q1ODJkODgwOTMgKG1pZ3JhdGlvbi9kaXJ0eXJhdGU6IFJlY29yZCBoYXNoIHJlc3Vs
dHMgZm9yIGVhY2ggc2FtcGxlZCBwYWdlKQo2LzEwIENoZWNraW5nIGNvbW1pdCAzMWYzNWI3M2U3
NjEgKG1pZ3JhdGlvbi9kaXJ0eXJhdGU6IENvbXBhcmUgcGFnZSBoYXNoIHJlc3VsdHMgZm9yIHJl
Y29yZGVkIHNhbXBsZWQgcGFnZSkKNy8xMCBDaGVja2luZyBjb21taXQgM2E0ZDRhMjA3ODEyICht
aWdyYXRpb24vZGlydHlyYXRlOiBza2lwIHNhbXBsaW5nIHJhbWJsb2NrIHdpdGggc2l6ZSBiZWxv
dyBNSU5fUkFNQkxPQ0tfU0laRSkKOC8xMCBDaGVja2luZyBjb21taXQgNDI2NDJkNDVjZjI5ICht
aWdyYXRpb24vZGlydHlyYXRlOiBJbXBsZW1lbnQgZ2V0X3NhbXBsZV9wYWdlX3BlcmlvZCgpIGFu
ZCBibG9ja19zYW1wbGVfcGFnZV9wZXJpb2QoKSkKOS8xMCBDaGVja2luZyBjb21taXQgOTZjZTAw
NzQyZDIzIChtaWdyYXRpb24vZGlydHlyYXRlOiBJbXBsZW1lbnQgY2FsY3VsYXRlX2RpcnR5cmF0
ZSgpIGZ1bmN0aW9uKQoxMC8xMCBDaGVja2luZyBjb21taXQgY2U2ZmUwZDEyNGM1IChtaWdyYXRp
b24vZGlydHlyYXRlOiBJbXBsZW1lbnQgcW1wX2NhbF9kaXJ0eV9yYXRlKCkvcW1wX2dldF9kaXJ0
eV9yYXRlKCkgZnVuY3Rpb24pCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzE1OTc2MzQ0MzMtMTg4MDktMS1naXQtc2VuZC1lbWFpbC16aGVuZ2NodWFu
QGh1YXdlaS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

