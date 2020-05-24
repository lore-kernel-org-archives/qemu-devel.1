Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F0C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 12:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06CAA20787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 12:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CAA20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcpj5-00028H-6t
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 08:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcpiF-0000uv-6g; Sun, 24 May 2020 08:26:43 -0400
Resent-Date: Sun, 24 May 2020 08:26:43 -0400
Resent-Message-Id: <E1jcpiF-0000uv-6g@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcpiD-0004tq-Js; Sun, 24 May 2020 08:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590323192; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EKPWL/M0bX0HZ4Ztic6d5R/w2X4DqMJKkjqGLrTYhAvixa9lz4wqj+1yjDfPtaUAwOACExgL4R+CIL8vjDi0BGrBm27ojYjMu0l6Mf8ARSW8Tnm8oOPd84H1fLvju9WWecClpPz7rUJNPD/yBUqhBdTFa3Jxl+U407Gv0ss1TZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590323192;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LegiIIBweImhjf0t5touw530zc19+0bLIDt2o/sEL5M=; 
 b=aY7IddXA7Rk29S2gT1D/AvWBibYZNonimrgr7HuEKZokN0eMZwuhyp+m5vzggekLMQKHnQ7muAJ6z/+uEcMI0rp5MsbqkJnrm3zb7c913EVpRHZEpGRwoTYSed200fqyeDyjcSG8uqZJIEif/XYj1k2YQ175t8UvZeZsAOCetTE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590323191407618.5473013240561;
 Sun, 24 May 2020 05:26:31 -0700 (PDT)
Message-ID: <159032319028.25024.16341819742251742761@45ef0f9c86ae>
In-Reply-To: <20200524110121.12686-1-f4bug@amsat.org>
Subject: Re: [PATCH 0/4] hw/display/cirrus_vga: Convert debug printf() to
 qemu_log_mask & trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 24 May 2020 05:26:31 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 08:26:38
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
Cc: qemu-trivial@nongnu.org, f4bug@amsat.org, qemu-devel@nongnu.org,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNDExMDEyMS4xMjY4
Ni0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjQxMTAxMjEuMTI2ODYtMS1mNGJ1Z0BhbXNhdC5v
cmcKU3ViamVjdDogW1BBVENIIDAvNF0gaHcvZGlzcGxheS9jaXJydXNfdmdhOiBDb252ZXJ0IGRl
YnVnIHByaW50ZigpIHRvIHFlbXVfbG9nX21hc2sgJiB0cmFjZQpUeXBlOiBzZXJpZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
ZjJjNWE3NiBody9kaXNwbGF5L2NpcnJ1c192Z2E6IENvbnZlcnQgZGVidWcgcHJpbnRmKCkgdG8g
dHJhY2UgZXZlbnQKMGIwMWE2MyBody9kaXNwbGF5L2NpcnJ1c192Z2E6IFVzZSBxZW11X2xvZ19t
YXNrKEVSUk9SKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50Zgo3NGQxOGI3IGh3L2Rpc3BsYXkvY2ly
cnVzX3ZnYTogVXNlIHFlbXVfbG9nX21hc2soVU5JTVApIGluc3RlYWQgb2YgZGVidWcgcHJpbnRm
CjkwMDA1MzUgaHcvZGlzcGxheS9jaXJydXNfdmdhOiBDb252ZXJ0IGRlYnVnIHByaW50ZigpIHRv
IHRyYWNlIGV2ZW50Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29tbWl0IDkw
MDA1MzU0YjdkNCAoaHcvZGlzcGxheS9jaXJydXNfdmdhOiBDb252ZXJ0IGRlYnVnIHByaW50Zigp
IHRvIHRyYWNlIGV2ZW50KQoyLzQgQ2hlY2tpbmcgY29tbWl0IDc0ZDE4YjdjYTgzYiAoaHcvZGlz
cGxheS9jaXJydXNfdmdhOiBVc2UgcWVtdV9sb2dfbWFzayhVTklNUCkgaW5zdGVhZCBvZiBkZWJ1
ZyBwcmludGYpCjMvNCBDaGVja2luZyBjb21taXQgMGIwMWE2MzNmZTkyIChody9kaXNwbGF5L2Np
cnJ1c192Z2E6IFVzZSBxZW11X2xvZ19tYXNrKEVSUk9SKSBpbnN0ZWFkIG9mIGRlYnVnIHByaW50
ZikKRVJST1I6IHN1c3BlY3QgY29kZSBpbmRlbnQgZm9yIGNvbmRpdGlvbmFsIHN0YXRlbWVudHMg
KDE2LCAxMikKIzMxOiBGSUxFOiBody9kaXNwbGF5L2NpcnJ1c192Z2EuYzoxMDM4OgogICAgICAg
ICAgICAgICAgaWYgKHMtPmNpcnJ1c19ibHRfcGl4ZWx3aWR0aCA+IDIpIHsKKyAgICAgICAgICAg
IHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5p
bmdzLCAxNTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgo0LzQgQ2hlY2tpbmcgY29tbWl0IGYyYzVhNzY4NjU3NCAoaHcvZGlzcGxheS9jaXJydXNf
dmdhOiBDb252ZXJ0IGRlYnVnIHByaW50ZigpIHRvIHRyYWNlIGV2ZW50KQo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUyNDExMDEyMS4xMjY4
Ni0xLWY0YnVnQGFtc2F0Lm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

