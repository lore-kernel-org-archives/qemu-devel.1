Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BDAC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 23:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3491206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 23:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3491206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW6wq-00052w-Sv
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 19:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW6wG-0004ZU-NF
 for qemu-devel@nongnu.org; Tue, 05 May 2020 19:25:24 -0400
Resent-Date: Tue, 05 May 2020 19:25:24 -0400
Resent-Message-Id: <E1jW6wG-0004ZU-NF@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW6wE-0001Ar-U1
 for qemu-devel@nongnu.org; Tue, 05 May 2020 19:25:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588721114; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XsI++i7AZ4K0V5JjGiN0BKfNF9s6P1HEahlRadeZpLUiNI0a6UxwAs6W+7RqenGFqZbZ/oDe618WLsZl9zsOFAozIJE15+47hOVvveakOzSEJoM05nwxaWD4pdpVyb/I1jLmY3BOpGKYiq8BrmtSZogE0n5xjjEGLip9zpZjzzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588721114;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ux3LP/3wsZgTeVAfnqKKuTWsY1V3QlXV+enZQ0M2xEs=; 
 b=CKe0jdPey2zEQ4FQQiuMfmXoECkQlbgZakBE+iR4NfiLZYs4K9WyfZ/1hUJ8shOuDV3A0BepeiL7tG/WrHXvQfZtUmavDd01xIZxgH7V2c3b+W7C7IXOES1CitV1898M7WiYXSagDrTQfBjNKRar0+JhRpgSVJvIskZYLnurEi8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588721111778218.5344369536681;
 Tue, 5 May 2020 16:25:11 -0700 (PDT)
Message-ID: <158872111042.24779.10569159884458800505@45ef0f9c86ae>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
Subject: Re: [PATCH v2 00/18] qom: Spring cleaning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 5 May 2020 16:25:11 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 13:41:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, philmd@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNTE1MjkyNi4xODg3
Ny0xLWFybWJydUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUwNTE1MjkyNi4xODg3Ny0xLWFybWJydUByZWRo
YXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwMC8xOF0gcW9tOiBTcHJpbmcgY2xlYW5pbmcKVHlw
ZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYt
cGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRj
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3
LzIwMjAwNTA1MjMwOTQxLjM5ODQxMDgtMS1hbGlzdGFpci5mcmFuY2lzQHdkYy5jb20gLT4gcGF0
Y2hldy8yMDIwMDUwNTIzMDk0MS4zOTg0MTA4LTEtYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMjU4Mzc4ZCBxb206IERyb3AgQGVycnAgcGFy
YW1ldGVyIG9mIG9iamVjdF9wcm9wZXJ0eV9kZWwoKQphZTc4MDNkIHNwYXByX3BjaTogRHJvcCBz
b21lIGRlYWQgZXJyb3IgaGFuZGxpbmcKMzg2NzM0MSBxZGV2OiBVbnJlYWxpemUgbXVzdCBub3Qg
ZmFpbAoyN2FiOTY0IERyb3AgbW9yZSBAZXJycCBwYXJhbWV0ZXJzIGFmdGVyIHByZXZpb3VzIGNv
bW1pdAowNTFhYjAxIHFvbTogRHJvcCBwYXJhbWV0ZXIgQGVycnAgb2Ygb2JqZWN0X3Byb3BlcnR5
X2FkZCgpICYgZnJpZW5kcwpkOTk4N2I0IHFkZXY6IENsZWFuIHVwIHFkZXZfY29ubmVjdF9ncGlv
X291dF9uYW1lZCgpCjRhYzk0OTIgaHcvYXJtL2JjbTI4MzU6IERyb3AgZnV0aWxlIGF0dGVtcHRz
IGF0IFFPTS1hZG9wdGluZyBtZW1vcnkKNTc2YmNjMSBlMTAwMDogRG9uJ3QgcnVuIGUxMDAwX2lu
c3RhbmNlX2luaXQoKSB0d2ljZQoxZTM0M2ZiIGh3L2lzYS9zdXBlcmlvOiBNYWtlIHRoZSBjb21w
b25lbnRzIFFPTSBjaGlsZHJlbgoyNTQ2MzcyIHMzOTB4L2NwdW1vZGVsOiBGaXggVUkgdG8gQ1BV
IGZlYXR1cmVzIHBjYy1jbWFjLXthZXMsIGVhZXN9LTI1Ngo5ZmVlZTRlIHRlc3RzL2NoZWNrLXFv
bS1wcm9wbGlzdDogSW1wcm92ZSBpdGVyYXRvciBjb3ZlcmFnZQplM2Y0ZTI0IHFvbTogRHJvcCBv
YmplY3RfcHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKCkgcGFyYW1ldGVyIEBlcnJwCjIyMzVjNzIg
cW9tOiBNYWtlIGFsbCB0aGUgb2JqZWN0X3Byb3BlcnR5X2FkZF9GT08oKSByZXR1cm4gdGhlIHBy
b3BlcnR5CjRhOTYxZjYgcW9tOiBEcm9wIGNvbnZlbmllbmNlIG1ldGhvZCBvYmplY3RfcHJvcGVy
dHlfZ2V0X3VpbnQxNkxpc3QoKQphNGZmZWM4IHFvbTogU2ltcGxpZnkgb2JqZWN0X3Byb3BlcnR5
X2dldF9lbnVtKCkKMzBjYTg5OCBxb206IERyb3Agb2JqZWN0X3Byb3BlcnR5X2RlbF9jaGlsZCgp
J3MgdW51c2VkIHBhcmFtZXRlciBAZXJycAo3N2Q4MTlhIHFvbTogQ2xlYW4gdXAgaW5jb25zaXN0
ZW50IHVzZSBvZiBnY2hhciAqIHZzLiBjaGFyICoKOTYyMDlmMyBxb206IENsZWFyZXIgcmVmZXJl
bmNlIGNvdW50aW5nIGluIG9iamVjdF9pbml0aWFsaXplX2NoaWxkdigpCgo9PT0gT1VUUFVUIEJF
R0lOID09PQoxLzE4IENoZWNraW5nIGNvbW1pdCA5NjIwOWYzOWYxNjcgKHFvbTogQ2xlYXJlciBy
ZWZlcmVuY2UgY291bnRpbmcgaW4gb2JqZWN0X2luaXRpYWxpemVfY2hpbGR2KCkpCjIvMTggQ2hl
Y2tpbmcgY29tbWl0IDc3ZDgxOWFjYmMwMyAocW9tOiBDbGVhbiB1cCBpbmNvbnNpc3RlbnQgdXNl
IG9mIGdjaGFyICogdnMuIGNoYXIgKikKMy8xOCBDaGVja2luZyBjb21taXQgMzBjYTg5OGJiN2Rj
IChxb206IERyb3Agb2JqZWN0X3Byb3BlcnR5X2RlbF9jaGlsZCgpJ3MgdW51c2VkIHBhcmFtZXRl
ciBAZXJycCkKNC8xOCBDaGVja2luZyBjb21taXQgYTRmZmVjODYzYjhkIChxb206IFNpbXBsaWZ5
IG9iamVjdF9wcm9wZXJ0eV9nZXRfZW51bSgpKQo1LzE4IENoZWNraW5nIGNvbW1pdCA0YTk2MWY2
N2FmMjIgKHFvbTogRHJvcCBjb252ZW5pZW5jZSBtZXRob2Qgb2JqZWN0X3Byb3BlcnR5X2dldF91
aW50MTZMaXN0KCkpCjYvMTggQ2hlY2tpbmcgY29tbWl0IDIyMzVjNzJkNDVhNiAocW9tOiBNYWtl
IGFsbCB0aGUgb2JqZWN0X3Byb3BlcnR5X2FkZF9GT08oKSByZXR1cm4gdGhlIHByb3BlcnR5KQo3
LzE4IENoZWNraW5nIGNvbW1pdCBlM2Y0ZTI0ZGRiMmUgKHFvbTogRHJvcCBvYmplY3RfcHJvcGVy
dHlfc2V0X2Rlc2NyaXB0aW9uKCkgcGFyYW1ldGVyIEBlcnJwKQo4LzE4IENoZWNraW5nIGNvbW1p
dCA5ZmVlZTRlM2RhNDAgKHRlc3RzL2NoZWNrLXFvbS1wcm9wbGlzdDogSW1wcm92ZSBpdGVyYXRv
ciBjb3ZlcmFnZSkKOS8xOCBDaGVja2luZyBjb21taXQgMjU0NjM3MmU2ZTg1IChzMzkweC9jcHVt
b2RlbDogRml4IFVJIHRvIENQVSBmZWF0dXJlcyBwY2MtY21hYy17YWVzLCBlYWVzfS0yNTYpCkVS
Uk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNTM6IEZJTEU6IHRhcmdldC9zMzkweC9jcHVf
ZmVhdHVyZXNfZGVmLmluYy5oOjMxNDoKK0RFRl9GRUFUKFBDQ19DTUFDX0FFU18yNTYsICJwY2Mt
Y21hYy1hZXMtMjU2IiwgUENDLCAyMCwgIlBDQyBDb21wdXRlLUxhc3QtQmxvY2stQ01BQy1Vc2lu
Zy1BRVMtMjU2IikKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2Vk
CgpQYXRjaCA5LzE4IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoxMC8xOCBDaGVja2luZyBj
b21taXQgMWUzNDNmYmU5OWFmIChody9pc2Evc3VwZXJpbzogTWFrZSB0aGUgY29tcG9uZW50cyBR
T00gY2hpbGRyZW4pCjExLzE4IENoZWNraW5nIGNvbW1pdCA1NzZiY2MxMjZkY2EgKGUxMDAwOiBE
b24ndCBydW4gZTEwMDBfaW5zdGFuY2VfaW5pdCgpIHR3aWNlKQoxMi8xOCBDaGVja2luZyBjb21t
aXQgNGFjOTQ5MjkzNjE3IChody9hcm0vYmNtMjgzNTogRHJvcCBmdXRpbGUgYXR0ZW1wdHMgYXQg
UU9NLWFkb3B0aW5nIG1lbW9yeSkKMTMvMTggQ2hlY2tpbmcgY29tbWl0IGQ5OTg3YjQ5ZjM3MyAo
cWRldjogQ2xlYW4gdXAgcWRldl9jb25uZWN0X2dwaW9fb3V0X25hbWVkKCkpCjE0LzE4IENoZWNr
aW5nIGNvbW1pdCAwNTFhYjAxZWQ1ZmUgKHFvbTogRHJvcCBwYXJhbWV0ZXIgQGVycnAgb2Ygb2Jq
ZWN0X3Byb3BlcnR5X2FkZCgpICYgZnJpZW5kcykKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJh
Y3RlcnMKIzIwOTogRklMRTogYmFja2VuZHMvaG9zdG1lbS1maWxlLmM6MTg3OgorICAgICAgICBm
aWxlX21lbW9yeV9iYWNrZW5kX2dldF9kaXNjYXJkX2RhdGEsIGZpbGVfbWVtb3J5X2JhY2tlbmRf
c2V0X2Rpc2NhcmRfZGF0YSk7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTA4
MDogRklMRTogaHcvYXJtL3Jhc3BpLmM6Mjg3OgorICAgIG9iamVjdF9wcm9wZXJ0eV9hZGRfY29u
c3RfbGluayhPQkpFQ1QoJnMtPnNvYyksICJyYW0iLCBPQkpFQ1QobWFjaGluZS0+cmFtKSk7CgpX
QVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzA5NTogRklMRTogaHcvcHBjL3NwYXBy
LmM6MzM0NjoKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnNwYXByLT5rZXJu
ZWxfYWRkciwgT0JKX1BST1BfRkxBR19SRUFEV1JJVEUpOwoKdG90YWw6IDAgZXJyb3JzLCAzIHdh
cm5pbmdzLCA0NDcxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDE0LzE4IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCjE1LzE4IENoZWNraW5nIGNvbW1pdCAyN2FiOTY0MmY1YjkgKERyb3AgbW9yZSBA
ZXJycCBwYXJhbWV0ZXJzIGFmdGVyIHByZXZpb3VzIGNvbW1pdCkKMTYvMTggQ2hlY2tpbmcgY29t
bWl0IDM4NjczNDE0OTc5MyAocWRldjogVW5yZWFsaXplIG11c3Qgbm90IGZhaWwpCjE3LzE4IENo
ZWNraW5nIGNvbW1pdCBhZTc4MDNkNzM3ZjQgKHNwYXByX3BjaTogRHJvcCBzb21lIGRlYWQgZXJy
b3IgaGFuZGxpbmcpCjE4LzE4IENoZWNraW5nIGNvbW1pdCAyNTgzNzhkZDk3NWQgKHFvbTogRHJv
cCBAZXJycCBwYXJhbWV0ZXIgb2Ygb2JqZWN0X3Byb3BlcnR5X2RlbCgpKQo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUwNTE1MjkyNi4xODg3
Ny0xLWFybWJydUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

