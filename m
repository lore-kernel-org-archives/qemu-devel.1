Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D362085B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D362085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdwi-0006g2-Et
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKduJ-0004ZU-1v; Tue, 22 Sep 2020 04:44:15 -0400
Resent-Date: Tue, 22 Sep 2020 04:44:15 -0400
Resent-Message-Id: <E1kKduJ-0004ZU-1v@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKduG-0000W3-Ca; Tue, 22 Sep 2020 04:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600764234; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bK0wH8IUMo0LTsDp/63QN6xjfXlJlB1Vv/RM8do9GgSSpMYPKkxBQ3Ngi8XreJpLFzjp9jfq3IEFuCZ4wzoNXeX8Oa92ngp7cQXrfLlXty075PSdihimxn9dd/zkceO7wnAlw0fXDL61UCEmc8GPZV5M1ZPx+RxdgWCto8Uy5hQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600764234;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=v2TFAeCmYXVzLaXcqPvzRWjCfg0oyZ4Km8UfOoVeCVY=; 
 b=Q+SOWQr3EPsbwRbauRv8J5QuuhHAM6LomwjM3yzEHMb70CnrNljkzXn4bHhZlVThOOHF3qc0oyCfG9GZGFhesFRW6DAMM9/hNhpHvaXgfdB0g/gyu8wSPzwgF0ZyQ8nqH7LuKmM9tiuUyCC8MbA5OLcb0Ev65wtSIv/vZY1sb34=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600764232937452.22768353185313;
 Tue, 22 Sep 2020 01:43:52 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] block/nvme: Map doorbells pages write-only,
 remove magic from nvme_init
Message-ID: <160076423130.32505.12431111143528936360@66eaa9a8a123>
In-Reply-To: <20200922083821.578519-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Tue, 22 Sep 2020 01:43:52 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:44:09
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMjA4MzgyMS41Nzg1
MTktMS1waGlsbWRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTIyMDgzODIxLjU3ODUx
OS0xLXBoaWxtZEByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzZdIGJsb2NrL252bWU6
IE1hcCBkb29yYmVsbHMgcGFnZXMgd3JpdGUtb25seSwgcmVtb3ZlIG1hZ2ljIGZyb20gbnZtZV9p
bml0Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2Ug
YmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
bGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzE2MDA0
ODUwMjMtMjYzNjQzLTEtZ2l0LXNlbmQtZW1haWwtbGVpLnJhb0BpbnRlbC5jb20gLT4gcGF0Y2hl
dy8xNjAwNDg1MDIzLTI2MzY0My0xLWdpdC1zZW5kLWVtYWlsLWxlaS5yYW9AaW50ZWwuY29tCiAt
IFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDA5MTgwOTIyMDMuMjAzODQtMS1jaGVuLnpo
YW5nQGludGVsLmNvbSAtPiBwYXRjaGV3LzIwMjAwOTE4MDkyMjAzLjIwMzg0LTEtY2hlbi56aGFu
Z0BpbnRlbC5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDkyMTE0NDk1Ny45
Nzk5ODktMS1sdml2aWVyQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDkyMTE0NDk1Ny45Nzk5
ODktMS1sdml2aWVyQHJlZGhhdC5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIw
MDkyMTE3NDMyMC40NjA2Mi0xLXRodXRoQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDkyMTE3
NDMyMC40NjA2Mi0xLXRodXRoQHJlZGhhdC5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hl
dy8yMDIwMDkyMTIyMTA0NS42OTk2OTAtMS1laGFia29zdEByZWRoYXQuY29tIC0+IHBhdGNoZXcv
MjAyMDA5MjEyMjEwNDUuNjk5NjkwLTEtZWhhYmtvc3RAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10g
ICAgICAgICBwYXRjaGV3LzIwMjAwOTIyMDgzODIxLjU3ODUxOS0xLXBoaWxtZEByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAyMDA5MjIwODM4MjEuNTc4NTE5LTEtcGhpbG1kQHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiYTViYTdiIGJsb2NrL252bWU6IFJlcGxhY2Ug
bWFnaWMgdmFsdWUgYnkgU0NBTEVfTVMgZGVmaW5pdGlvbgo3OTc1Yzg1IGJsb2NrL252bWU6IFVz
ZSByZWdpc3RlciBkZWZpbml0aW9ucyBmcm9tICdibG9jay9udm1lLmgnCjBjZTMyOGIgYmxvY2sv
bnZtZTogRHJvcCBOVk1lUmVncyBzdHJ1Y3R1cmUsIGRpcmVjdGx5IHVzZSBOdm1lQmFyCjU1NGY2
OGUgYmxvY2svbnZtZTogUmVkdWNlIEkvTyByZWdpc3RlcnMgc2NvcGUKNWNmYjE1OSBibG9jay9u
dm1lOiBNYXAgZG9vcmJlbGxzIHBhZ2VzIHdyaXRlLW9ubHkKMjA2NDcwMyB1dGlsL3ZmaW8taGVs
cGVyczogUGFzcyBwYWdlIHByb3RlY3Rpb25zIHRvIHFlbXVfdmZpb19wY2lfbWFwX2JhcigpCgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzYgQ2hlY2tpbmcgY29tbWl0IDIwNjQ3MDNmZjhkYyAodXRp
bC92ZmlvLWhlbHBlcnM6IFBhc3MgcGFnZSBwcm90ZWN0aW9ucyB0byBxZW11X3ZmaW9fcGNpX21h
cF9iYXIoKSkKMi82IENoZWNraW5nIGNvbW1pdCA1Y2ZiMTU5MzI1MzkgKGJsb2NrL252bWU6IE1h
cCBkb29yYmVsbHMgcGFnZXMgd3JpdGUtb25seSkKMy82IENoZWNraW5nIGNvbW1pdCA1NTRmNjhl
MjVhYmMgKGJsb2NrL252bWU6IFJlZHVjZSBJL08gcmVnaXN0ZXJzIHNjb3BlKQo0LzYgQ2hlY2tp
bmcgY29tbWl0IDBjZTMyOGI3ODA4MyAoYmxvY2svbnZtZTogRHJvcCBOVk1lUmVncyBzdHJ1Y3R1
cmUsIGRpcmVjdGx5IHVzZSBOdm1lQmFyKQpFUlJPUjogVXNlIG9mIHZvbGF0aWxlIGlzIHVzdWFs
bHkgd3JvbmcsIHBsZWFzZSBhZGQgYSBjb21tZW50CiM0MzogRklMRTogYmxvY2svbnZtZS5jOjY5
MjoKKyAgICB2b2xhdGlsZSBOdm1lQmFyICpyZWdzID0gTlVMTDsKCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgNjIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC82IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgo1LzYgQ2hlY2tpbmcgY29tbWl0IDc5NzVjODViMzkwNCAoYmxvY2svbnZtZTog
VXNlIHJlZ2lzdGVyIGRlZmluaXRpb25zIGZyb20gJ2Jsb2NrL252bWUuaCcpCjYvNiBDaGVja2lu
ZyBjb21taXQgYmE1YmE3YjY1NzQyIChibG9jay9udm1lOiBSZXBsYWNlIG1hZ2ljIHZhbHVlIGJ5
IFNDQUxFX01TIGRlZmluaXRpb24pCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4
aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTIyMDgzODIxLjU3ODUxOS0xLXBoaWxtZEByZWRoYXQuY29t
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

