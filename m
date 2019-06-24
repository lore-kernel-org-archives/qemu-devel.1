Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F4C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB0820657
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB0820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfKwm-0008QA-3k
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hfKvR-0007WY-Ry
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hfKvQ-0001FG-Jl
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:06:09 -0400
Resent-Date: Mon, 24 Jun 2019 05:06:09 -0400
Resent-Message-Id: <E1hfKvQ-0001FG-Jl@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hfKvQ-0000dl-BH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561367147; cv=none; d=zoho.com; s=zohoarc; 
 b=gZtTK9FeBJ94kzwVjtZ+3CI1fhQf+tSHlmQg7DL8OjfRXh3MuPkHEQk4YPiT7EACo1nkkj+CYDAb69aUw2hPNyDBJ9CUNTMlSXiDZTiWzkPIUExZoNmniRlrfsSw/7p2BLWigiRAZebdcIpBNqWiw15Uv7Do6tnsVMlCvZmP+qc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561367147;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=zQqvxBlrC0LCnjEEAVNSOMJgVZvmgj1OcRvsDQLpWQM=; 
 b=eK2SP9EoDc4DG4uivs5YTVT22kQReCBF10OCZpFNo8Zi51ZunnIXL3Vcbp+X58ZsqtN0Mcr3rkq8HkruYUhqapJQuAoVTnhkFDBIqWAA9OVMNJZiliDSFS8XUKI0kVXX8XbUP4Du4KEGjQIa2AKi+L5RrBn/drca+6gJIycoltM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561367145183735.9013859929129;
 Mon, 24 Jun 2019 02:05:45 -0700 (PDT)
In-Reply-To: <20190624070339.4408-1-david.brenken@efs-auto.org>
Message-ID: <156136714420.4070.12487446110075258042@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david.brenken@efs-auto.org
Date: Mon, 24 Jun 2019 02:05:45 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v3 0/5] tricore: adding new instructions
 and fixing
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
Cc: kbastian@mail.uni-paderborn.de, david.brenken@efs-auto.de,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyNDA3MDMzOS40NDA4
LTEtZGF2aWQuYnJlbmtlbkBlZnMtYXV0by5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IGJ1aWxkIHRlc3Qgb24gczM5MHggaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cu
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQg
d2lsbCBiZSBpbnZva2VkIHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRp
bmcgdG8gYSBjb21taXQgdGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJh
c2UiCiMgYnJhbmNoCnNldCAtZQpDQz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwK
QlVJTEQ9JFBXRC9idWlsZApta2RpciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJV
SUxECiRTUkMvY29uZmlndXJlIC0tY2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMg
WFhYOiB3ZSBuZWVkIHJlbGlhYmxlIGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2Ug
aW5zdGFsbAoKZWNobwplY2hvICI9PT0gRU5WID09PSIKZW52CgplY2hvCmVjaG8gIj09PSBQQUNL
QUdFUyA9PT0iCnJwbSAtcWEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICB0cmlj
b3JlLXNvZnRtbXUvdGFyZ2V0L3RyaWNvcmUvZnB1X2hlbHBlci5vCiAgQ0MgICAgICB1bmljb3Jl
MzItc29mdG1tdS9ody90cG0vdHBtX3BwaS5vCi92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13
dG9jMHppOS9zcmMvdGFyZ2V0L3RyaWNvcmUvZnB1X2hlbHBlci5jOiBJbiBmdW5jdGlvbiDigJho
ZWxwZXJfcXNlZWTigJk6Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13dG9jMHppOS9zcmMv
dGFyZ2V0L3RyaWNvcmUvZnB1X2hlbHBlci5jOjI0Mzo5OiBlcnJvcjogdG9vIGZldyBhcmd1bWVu
dHMgdG8gZnVuY3Rpb24g4oCYZmxvYXQzMl9pc19zaWduYWxpbmdfbmFu4oCZCiAgMjQzIHwgICAg
IGlmIChmbG9hdDMyX2lzX3NpZ25hbGluZ19uYW4oYXJnMSkgfHwgcmVzdWx0ID09IGZsb2F0MzJf
c3FydF9uYW4pIHsKICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpJbiBm
aWxlIGluY2x1ZGVkIGZyb20gL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXd0b2Mwemk5L3Ny
Yy90YXJnZXQvdHJpY29yZS9mcHVfaGVscGVyLmM6MjM6CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDYyNDA3MDMzOS40NDA4LTEtZGF2
aWQuYnJlbmtlbkBlZnMtYXV0by5vcmcvdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==


