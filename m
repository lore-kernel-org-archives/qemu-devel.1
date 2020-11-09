Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53984C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7D9206CB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7D9206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcEuM-0006jK-6u
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kcEtL-0006DD-MY
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:39:59 -0500
Resent-Date: Mon, 09 Nov 2020 16:39:59 -0500
Resent-Message-Id: <E1kcEtL-0006DD-MY@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kcEtI-0007GE-AB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:39:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604957989; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DLeSmQqvNxpkiY/nx2zydGnguMWtrjTYMTdTzc7lVfUC/B2OnA7dzTr3scoJMhNQxakIXSvSlCIky2wkBKAsXKXTkjJLVgZzoLR1rI6X4U36EP7kPXjEG0CeucB8q5KHp769Q5cYQCPXU+ZWxezbOuqFGUdKpsolSQZvPUB3KxA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604957989;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9uR25DYWk6tlwo8C8eOUtJeSbrxpLeckRUQG+BZiFQk=; 
 b=k4unyZ+Nt5rrXIS4ZLUHmS/cCNsLZyMzfftmpKdNdubVD8LF+KYiZgv7rXNs7C3i6i9IkqC+UqI+ljTCNmvnRrFgq36eX9LyGIhe/vjz4yqcmdTrRLxXfD/wqVltDLEPXL3dVp4CVVlIuhvc66639D9+IFSNPzM3DBHDqdWmBpk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604957987700737.0033268737639;
 Mon, 9 Nov 2020 13:39:47 -0800 (PST)
Message-ID: <160495798642.32285.17713378637940035517@b92d57cec08d>
Subject: Re: [PATCH 0/8] qom: Use qlit to represent property defaults
In-Reply-To: <20201109212556.3934583-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Mon, 9 Nov 2020 13:39:47 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 16:39:53
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwOTIxMjU1Ni4zOTM0
NTgzLTEtZWhhYmtvc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDExMDkyMTI1NTYuMzkzNDU4My0xLWVoYWJr
b3N0QHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIDAvOF0gcW9tOiBVc2UgcWxpdCB0byByZXBy
ZXNlbnQgcHJvcGVydHkgZGVmYXVsdHMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVH
SU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0
IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhp
c3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRi
ZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQog
KiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMTA5MjEyNTU2LjM5MzQ1ODMtMS1laGFi
a29zdEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDExMDkyMTI1NTYuMzkzNDU4My0xLWVoYWJr
b3N0QHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1MTQxMTVlIHFv
bTogVXNlIHFsaXQgdG8gcmVwcmVzZW50IHByb3BlcnR5IGRlZmF1bHRzCjJjYTM1NjEgcW9tOiBN
YWtlIG9iamVjdF9wcm9wZXJ0eV9zZXRfZGVmYXVsdCgpIHB1YmxpYwo0YzI2MWFlIHFsaXQ6IHFs
aXRfdHlwZSgpIGZ1bmN0aW9uCjhiNjAxYzQgcWxpdDogU3VwcG9ydCBhbGwgdHlwZXMgb2YgUU51
bXMKMmQ1ZjFhZiBxbnVtOiBxbnVtX3ZhbHVlX2lzX2VxdWFsKCkgZnVuY3Rpb24KYmU3NGM0OSBx
bnVtOiBRTnVtVmFsdWUgdHlwZSBmb3IgUU51bSB2YWx1ZSBsaXRlcmFscwo4N2IwZWRjIHFudW06
IE1ha2UgcW51bV9nZXRfZG91YmxlKCkgZ2V0IGNvbnN0IHBvaW50ZXIKYWI0YjUxMCBxb2JqZWN0
OiBJbmNsdWRlIEFQSSBkb2NzIGluIGRvY3MvZGV2ZWwvcW9iamVjdC5odG1sCgo9PT0gT1VUUFVU
IEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IGFiNGI1MTBjMGUyMiAocW9iamVjdDogSW5j
bHVkZSBBUEkgZG9jcyBpbiBkb2NzL2RldmVsL3FvYmplY3QuaHRtbCkKV0FSTklORzogYWRkZWQs
IG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5n
PwojMjM6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdz
LCAyMDEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
CjIvOCBDaGVja2luZyBjb21taXQgODdiMGVkY2I1MGE3IChxbnVtOiBNYWtlIHFudW1fZ2V0X2Rv
dWJsZSgpIGdldCBjb25zdCBwb2ludGVyKQozLzggQ2hlY2tpbmcgY29tbWl0IGJlNzRjNDk3OGYw
NSAocW51bTogUU51bVZhbHVlIHR5cGUgZm9yIFFOdW0gdmFsdWUgbGl0ZXJhbHMpCjQvOCBDaGVj
a2luZyBjb21taXQgMmQ1ZjFhZjg0NjQ2IChxbnVtOiBxbnVtX3ZhbHVlX2lzX2VxdWFsKCkgZnVu
Y3Rpb24pCjUvOCBDaGVja2luZyBjb21taXQgOGI2MDFjNDQyNjZlIChxbGl0OiBTdXBwb3J0IGFs
bCB0eXBlcyBvZiBRTnVtcykKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM2NDogRklM
RTogcW9iamVjdC9xbGl0LmM6NzQ6CisgICAgICAgIHJldHVybiBxbnVtX3ZhbHVlX2lzX2VxdWFs
KCZsaHMtPnZhbHVlLnFudW0sIHFudW1fZ2V0X3ZhbHVlKHFvYmplY3RfdG8oUU51bSwgcmhzKSkp
OwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNTQgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
NS84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo2LzggQ2hlY2tpbmcgY29tbWl0IDRjMjYx
YWU0YzNmMiAocWxpdDogcWxpdF90eXBlKCkgZnVuY3Rpb24pCjcvOCBDaGVja2luZyBjb21taXQg
MmNhMzU2MWVlNjkwIChxb206IE1ha2Ugb2JqZWN0X3Byb3BlcnR5X3NldF9kZWZhdWx0KCkgcHVi
bGljKQo4LzggQ2hlY2tpbmcgY29tbWl0IDUxNDExNWU1OTdmMSAocW9tOiBVc2UgcWxpdCB0byBy
ZXByZXNlbnQgcHJvcGVydHkgZGVmYXVsdHMpCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBh
IGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiMxNDg6IEZJTEU6IGluY2x1ZGUvcW9tL3By
b3BlcnR5LXR5cGVzLmg6MzM6CisgICAgICAgIC8qIE5vdGUgdGhhdCBfX1ZBX0FSR1NfXyBjYW4g
c3RpbGwgb3ZlcnJpZGUgLmRlZnZhbCAqLyAgIFwKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5n
cywgMzI1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDgvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
Lgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MTEwOTIxMjU1Ni4zOTM0NTgzLTEtZWhhYmtvc3RAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

