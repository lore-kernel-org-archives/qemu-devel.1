Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47025C43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 14:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3F8235F9
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 14:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3F8235F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK0AR-0003nH-K9
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 10:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK09M-000339-W9
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 10:17:09 -0400
Resent-Date: Sun, 20 Sep 2020 10:17:08 -0400
Resent-Message-Id: <E1kK09M-000339-W9@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK09J-0000Lv-NI
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 10:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600611401; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lm9cq3OX6lWr3Mz+MBmuD4zDWYR3j4NJXZ02lgc2017PDfunOOCIvG8EyS7zJdtexazcib+qz0kG/FggRB8+HNcdL2ddZ9scZk7rzgvg0f/1PXQ73A7TDhNTF69qLrj5Ev5aQwis3d+z56yQLvNhUWcUqBnjE+2vBgPJOy21eDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600611401;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=U9X/VdH4NXimi4pamWynVe3ZGh2lODm0tDZaY7oEWrY=; 
 b=nJWVIGWmoSym4ot1M9T6FyJufv4cYbV51wzFFCXTiX2o1rm04virSnVHRTRn5Kf5VBcDEMpKJ9qesUFSLhfukVZHvrjlK/w2MCztBxk5E0+QocfZgZJyJYYMIXrQUNLvIaSb2M7a1KverRyJj0i4H3MauPUSDAtbdPnTQVO+5Ro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600611398705616.1006028412447;
 Sun, 20 Sep 2020 07:16:38 -0700 (PDT)
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
Message-ID: <160061139679.23907.2484422056580800954@66eaa9a8a123>
In-Reply-To: <cover.1600556526.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mail@maciej.szmigiero.name
Date: Sun, 20 Sep 2020 07:16:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 10:17:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, imammedo@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com, boris.ostrovsky@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNjAwNTU2NTI2Lmdp
dC5tYWNpZWouc3ptaWdpZXJvQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiBjb3Zlci4xNjAwNTU2
NTI2LmdpdC5tYWNpZWouc3ptaWdpZXJvQG9yYWNsZS5jb20KU3ViamVjdDogW1BBVENIIDAvM10g
SHlwZXItViBEeW5hbWljIE1lbW9yeSBQcm90b2NvbCBkcml2ZXIgKGh2LWJhbGxvb24pCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjE4MDEwNGQgQWRkIGEgSHlwZXItViBEeW5hbWljIE1lbW9yeSBQcm90b2NvbCBkcml2ZXIgKGh2
LWJhbGxvb24pCmNiOWY5ZDcgQWRkIEh5cGVyLVYgRHluYW1pYyBNZW1vcnkgUHJvdG9jb2wgZGVm
aW5pdGlvbnMKM2YyMmU4ZiBoYXByb3Q6IGFkZCBhIGRldmljZSBmb3IgbWVtb3J5IGhvdC1hZGQg
cHJvdG9jb2xzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IDNmMjJl
OGZiNDQ3MyAoaGFwcm90OiBhZGQgYSBkZXZpY2UgZm9yIG1lbW9yeSBob3QtYWRkIHByb3RvY29s
cykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJ
TkVSUyBuZWVkIHVwZGF0aW5nPwojMTA5OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCldBUk5JTkc6
IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMyMTI6IEZJTEU6IGh3L21lbS9oYXByb3QuYzo5OToK
KyAgICAgICAgICAgICAgICAgICAiTm9kZSBwcm9wZXJ0eSB2YWx1ZSAlIlBSSXUzMiIgZXhjZWVk
cyB0aGUgbnVtYmVyIG9mIG51bWEgbm9kZXMgJWQiLAoKdG90YWw6IDAgZXJyb3JzLCAyIHdhcm5p
bmdzLCA0MDQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCjIvMyBDaGVja2luZyBjb21taXQgY2I5ZjlkN2IyZmI0IChBZGQgSHlwZXItViBEeW5hbWlj
IE1lbW9yeSBQcm90b2NvbCBkZWZpbml0aW9ucykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRl
bGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTU6IApuZXcg
ZmlsZSBtb2RlIDEwMDY0NAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzUyOiBG
SUxFOiBpbmNsdWRlL2h3L2h5cGVydi9keW5tZW0tcHJvdG8uaDozMzoKKyNkZWZpbmUgRFlOTUVN
X01BS0VfVkVSU0lPTihNYWpvciwgTWlub3IpICgodWludDMyX3QpKCgoTWFqb3IpIDw8IDE2KSB8
IChNaW5vcikpKQoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYWZ0ZXIgdGhhdCAnJicgKGN0eDpX
eFcpCiM1NDogRklMRTogaW5jbHVkZS9ody9oeXBlcnYvZHlubWVtLXByb3RvLmg6MzU6CisjZGVm
aW5lIERZTk1FTV9NSU5PUl9WRVJTSU9OKFZlcnNpb24pICgodWludDMyX3QpKFZlcnNpb24pICYg
MHhmZikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAyIHdhcm5pbmdzLCA0MjUgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzMgQ2hlY2tpbmcgY29t
bWl0IDE4MDEwNGQ1NTc4NiAoQWRkIGEgSHlwZXItViBEeW5hbWljIE1lbW9yeSBQcm90b2NvbCBk
cml2ZXIgKGh2LWJhbGxvb24pKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxl
KHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxODg6IApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzI0ODogRklMRTogaHcv
aHlwZXJ2L2h2LWJhbGxvb24uYzo1NjoKKyNkZWZpbmUgSFZfQkFMTE9PTl9IQV9DSFVOS19QQUdF
UyAoSFZfQkFMTE9PTl9IQV9DSFVOS19TSVpFIC8gSFZfQkFMTE9PTl9QQUdFX1NJWkUpCgpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTIzNjogRklMRTogaHcvaHlwZXJ2L2h2LWJh
bGxvb24uYzoxMDQ0OgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgxIDw8IGJh
bGxvb24tPmNhcHMuY2FwX2JpdHMuaG90X2FkZF9hbGlnbm1lbnQpCgpXQVJOSU5HOiBsaW5lIG92
ZXIgODAgY2hhcmFjdGVycwojMTYxODogRklMRTogaHcvaHlwZXJ2L2h2LWJhbGxvb24uYzoxNDI2
OgorICAgICAgICAgICAgd2Fybl9yZXBvcnQoImd1ZXN0IHJlcG9ydGVkIHJlbW92ZWQgcGFnZSBi
YWNrZWQgYnkgdW5zdXBwb3J0ZWQgcGFnZSBzaXplICV6dSIsCgpXQVJOSU5HOiBsaW5lIG92ZXIg
ODAgY2hhcmFjdGVycwojMTY5MjogRklMRTogaHcvaHlwZXJ2L2h2LWJhbGxvb24uYzoxNTAwOgor
ICAgICAgICAgICAgICAgIHdhcm5fcmVwb3J0KCJndWVzdCByZXBvcnRlZCByZW1vdmVkIHBhZ2Ug
JSJQUkl1NjQiIG5vdCBmb3VuZCBpbiBSQU0iLAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0
ZXJzCiMxNzAwOiBGSUxFOiBody9oeXBlcnYvaHYtYmFsbG9vbi5jOjE1MDg6CisgICAgICAgICAg
ICAgICAgd2Fybl9yZXBvcnQoImd1ZXN0IHJlcG9ydGVkIHJlbW92ZWQgcGFnZSAlIlBSSXU2NCIg
aW4gYSBzZWN0aW9uIHNtYWxsZXIgdGhhbiBwYWdlIHNpemUiLAoKRVJST1I6IGxpbmUgb3ZlciA5
MCBjaGFyYWN0ZXJzCiMxNzEwOiBGSUxFOiBody9oeXBlcnYvaHYtYmFsbG9vbi5jOjE1MTg6Cisg
ICAgICAgICAgICAgICAgd2Fybl9yZXBvcnQoImd1ZXN0IHJlcG9ydGVkIHJlbW92ZWQgcGFnZSAl
IlBSSXU2NCIgaW4gYSBzZWN0aW9uIHRoYXQgaXMgbm90IGFuIG9yZGluYXJ5IFJBTSIsCgpFUlJP
UjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzE3NDk6IEZJTEU6IGh3L2h5cGVydi9odi1iYWxs
b29uLmM6MTU1NzoKKyAgICAgICAgd2Fybl9yZXBvcnQoImd1ZXN0IHJlcG9ydGVkIG1vcmUgcGFn
ZXMgcmVtb3ZlZCB0aGFuIGN1cnJlbnRseSBwZW5kaW5nICglIlBSSXU2NCIgdnMgJSJQUkl1NjQi
KSIsCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTg2MzogRklMRTogaHcvaHlw
ZXJ2L2h2LWJhbGxvb24uYzoxNjcxOgorICAgIHFhcGlfZXZlbnRfc2VuZF9odl9iYWxsb29uX3N0
YXR1c19yZXBvcnQoKHVpbnQ2NF90KW1zZ1N0YXR1cy0+bnVtX2NvbW1pdHRlZCAqCgpFUlJPUjog
bGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzE5MTg6IEZJTEU6IGh3L2h5cGVydi9odi1iYWxsb29u
LmM6MTcyNjoKKyAgICAgICAgICAgIHdhcm5fcmVwb3J0KCJETV9IT1RfQUREX1JFU1BPTlNFIHBh
Z2UgY291bnQgaGlnaGVyIHRoYW4gcmVxdWVzdGVkICglIlBSSXUzMiIgdnMgJSJQUkl1NjQiKSIs
Cgp0b3RhbDogNCBlcnJvcnMsIDYgd2FybmluZ3MsIDIzNjkgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
My8zIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNjAwNTU2NTI2LmdpdC5tYWNpZWouc3pt
aWdpZXJvQG9yYWNsZS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

