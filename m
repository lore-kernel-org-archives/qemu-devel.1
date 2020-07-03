Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBACC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:05:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B79207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B79207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJVI-0003pD-Jo
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 07:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrJUU-0002fN-Vt
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:04:22 -0400
Resent-Date: Fri, 03 Jul 2020 07:04:22 -0400
Resent-Message-Id: <E1jrJUU-0002fN-Vt@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrJUS-0001tM-4W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:04:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593774244; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jKPJkJ+/sa6lTBMo0Zh77cUWHat5TPrh5RB+JwcQGkjm7ZVcobxmOkueADNU87sqeAzFombcoOF6hVe3Ru4LurZBIbNO1bZ/KE//4UurEVpOjwUaFLcoYaano/ehJsbhHP+++SJYRS3hQdmyyRoqcCRptuDeep2p6zHxf9QN6yg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593774244;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HwGadAKlhA4UtsJjbZbhTgPA0vAqeW+LqYEdZ7crXFQ=; 
 b=j5YkiEC5A+j1tVZdQst0LWeQM8k7WthitimRWvWeeuKHZHFbVpNq4YQBLx64fN7fLnCI5VZXmTI7MwnYxxrohStxL1VOraESc3ixNl1AZmRAyeATDAILD0ND3n3UhdCuJWDjhb7T1tTt/58YO01/fxbnN9ZlM3TTAmDI7v/hXEw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159377424267875.98211442087984;
 Fri, 3 Jul 2020 04:04:02 -0700 (PDT)
Message-ID: <159377424130.13189.9582392029105156021@d1fd068a5071>
Subject: Re: [PATCH v2 0/1] Add Loongson 2F disassembler
In-Reply-To: <20200703104409.6986-1-stefan.brankovic@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanbrankovic96@gmail.com
Date: Fri, 3 Jul 2020 04:04:02 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 07:04:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: thuth@redhat.com, aleksandar.rikalo@syrmia.com, qemu-devel@nongnu.org,
 aleksandar.qemu.devel@gmail.com, stefan.brankovic@syrmia.com,
 chenhc@lemote.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwMzEwNDQwOS42OTg2
LTEtc3RlZmFuLmJyYW5rb3ZpY0BzeXJtaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjIgMC8xXSBBZGQgTG9vbmdzb24g
MkYgZGlzYXNzZW1ibGVyClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDcwMzEwNDQwOS42
OTg2LTEtc3RlZmFuLmJyYW5rb3ZpY0BzeXJtaWEuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBb
bmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNzAzMTA0NDA5LjY5ODYtMS1zdGVmYW4uYnJh
bmtvdmljQHN5cm1pYS5jb20gLT4gcGF0Y2hldy8yMDIwMDcwMzEwNDQwOS42OTg2LTEtc3RlZmFu
LmJyYW5rb3ZpY0BzeXJtaWEuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNWJk
Y2E4NyBkaXNhczogbWlwczogQWRkIExvb25nc29uIDJGIGRpc2Fzc2VtYmxlcgoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNTc6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
RVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBh
cmVudGhlc2lzICcoJwojMTA3OTI6IEZJTEU6IGluY2x1ZGUvZGlzYXMvZGlzLWFzbS5oOjM5OToK
K2ludCBwcmludF9pbnNuX2xvb25nc29uMmYgICAgICAgKGJmZF92bWEsIGRpc2Fzc2VtYmxlX2lu
Zm8qKTsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTA3NjEgbGluZXMgY2hlY2tlZAoK
Q29tbWl0IDViZGNhODc2YTk0YiAoZGlzYXM6IG1pcHM6IEFkZCBMb29uZ3NvbiAyRiBkaXNhc3Nl
bWJsZXIpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNzAzMTA0NDA5LjY5ODYtMS1zdGVmYW4u
YnJhbmtvdmljQHN5cm1pYS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t

