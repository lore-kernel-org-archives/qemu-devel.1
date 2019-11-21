Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E36CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 23:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD2220637
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 23:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD2220637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXvhM-000188-8J
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 18:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iXvg4-0000Ko-23
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 18:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iXvg2-0005Nw-IB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 18:15:55 -0500
Resent-Date: Thu, 21 Nov 2019 18:15:55 -0500
Resent-Message-Id: <E1iXvg2-0005Nw-IB@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iXvg2-0005M4-AF
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 18:15:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574378147; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Osg/IgoxUCE05IhKPMCzdPaGCOuI7wZm7p4Ko1a1LGc7HrA7T/QvZTJMskv1G9OOqx6BpI8Q0U3gU2u/a3rOmzGeZva4w60Y1q33gGublbXlgBPfkDKaNOymBXvJdbL9ujZULlXfPmTFEPn7mnViM2lYn25mB5EOTCCvJ7C9MDw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574378147;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qtasF/SqV0MrQQsv2r06kAfiJS4RpDlF+19EpMhHDQ4=; 
 b=N9q9oWtvHQTI0I+/xaRvrCnsoJYpLmGweXhM9m3aJ8zdnf/XacHpis4sJmHi6HGlgN/WCjqtOQs/uuxTk5lQ+/GC0dz8MjeKOB0eNwAcHdCT83rqdb/uqysKsvyFmh1n1w91lE0opAxMCHPNzmDHU9BGggwYJoBVVPsdisU36UI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574378146767915.2697697495863;
 Thu, 21 Nov 2019 15:15:46 -0800 (PST)
In-Reply-To: <20191121201448.GA3133@ls3530.fritz.box>
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
Message-ID: <157437814491.7001.2832286753868527009@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: deller@gmx.de
Date: Thu, 21 Nov 2019 15:15:46 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyMTIwMTQ0OC5HQTMx
MzNAbHMzNTMwLmZyaXR6LmJveC8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBsaW51eC11c2VyOiBJbXByb3ZlIHN0cmFjZSBvdXRw
dXQgZm9yIHJlYWQoKSBhbmQgZ2V0Y3dkKCkKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkx
MTIxMjAxNDQ4LkdBMzEzM0BsczM1MzAuZnJpdHouYm94Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBb
bmV3IHRhZ10gICAgICAgICBwYXRjaGV3L2NvdmVyLjE1NzQzNzU2NjguZ2l0LmRpcnR5QGFwcGxl
LmNvbSAtPiBwYXRjaGV3L2NvdmVyLjE1NzQzNzU2NjguZ2l0LmRpcnR5QGFwcGxlLmNvbQpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmUzNjdhYTMgbGludXgtdXNlcjogSW1wcm92ZSBz
dHJhY2Ugb3V0cHV0IGZvciByZWFkKCkgYW5kIGdldGN3ZCgpCgo9PT0gT1VUUFVUIEJFR0lOID09
PQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzc6IEZJTEU6IGxpbnV4LXVzZXIv
c3RyYWNlLmM6NjQ6CitVTlVTRUQgc3RhdGljIHZvaWQgcHJpbnRfZW5jb2RlZF9zdHJpbmcoYWJp
X2xvbmcgYWRkciwgdW5zaWduZWQgaW50IG1heGxlbiwgaW50IGxhc3QpOwoKRVJST1I6IHN0b3Jh
Z2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiMz
NzogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzo2NDoKK1VOVVNFRCBzdGF0aWMgdm9pZCBwcmlu
dF9lbmNvZGVkX3N0cmluZyhhYmlfbG9uZyBhZGRyLCB1bnNpZ25lZCBpbnQgbWF4bGVuLCBpbnQg
bGFzdCk7Cgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDEzNyBsaW5lcyBjaGVja2VkCgpD
b21taXQgZTM2N2FhMzg1OTY1IChsaW51eC11c2VyOiBJbXByb3ZlIHN0cmFjZSBvdXRwdXQgZm9y
IHJlYWQoKSBhbmQgZ2V0Y3dkKCkpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTIxMjAxNDQ4
LkdBMzEzM0BsczM1MzAuZnJpdHouYm94L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


