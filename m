Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67BDC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3B520746
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 18:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3B520746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW1uK-0007td-KR
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 14:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW1ZZ-0001el-IG
 for qemu-devel@nongnu.org; Tue, 05 May 2020 13:41:37 -0400
Resent-Date: Tue, 05 May 2020 13:41:37 -0400
Resent-Message-Id: <E1jW1ZZ-0001el-IG@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jW1ZX-0004Uc-QX
 for qemu-devel@nongnu.org; Tue, 05 May 2020 13:41:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588700487; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O+CIc5GhKnTPPxTOlb6VO6qF7PhHxC6AFRdFcXGnUZ8c/YgHJbA1fFsgaQP+qjS51zsLsk0yd7PbYbn3grdpeqxbS2sjAB/dbaIJg+hWSwY1j6lnZjSGlbPSUG/H1rIeOkz707d/auPtO5PG3tvUlMwJtj4l9U/Lg4tyI7nXrNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588700487;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rWSeB3uaPVOLoocXsN9TNLbVkhBf7tM4En/mViJytmY=; 
 b=JJW2b6xgyPOORYbLHehrLptcDDymAG5f2Y+aPaY8Lx7DWdd31CmRgGTiEaO2pxJMeKIAMzkD8LPSRzy//OKXP5IOv1q3awRsX9yoDaJ2iaP7ySu0kiPKlgC/OWfXVw6VN4pcKt7Ubj+O/ZsC4bJrBOZ0e1Dl2xBbZIqZlvSsiTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588700485736639.0110299823077;
 Tue, 5 May 2020 10:41:25 -0700 (PDT)
Message-ID: <158870048467.24779.5617074057792488302@45ef0f9c86ae>
In-Reply-To: <20200505151055.5EAD73A022F@moya.office.hostfission.com>
Subject: Re: [PATCH v6] audio/jack: add JACK client audiodev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: geoff@hostfission.com
Date: Tue, 5 May 2020 10:41:25 -0700 (PDT)
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
Cc: geoff@hostfission.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNTE1MTA1NS41RUFE
NzNBMDIyRkBtb3lhLm9mZmljZS5ob3N0Zmlzc2lvbi5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTA1MTUxMDU1LjVFQUQ3
M0EwMjJGQG1veWEub2ZmaWNlLmhvc3RmaXNzaW9uLmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjZdIGF1
ZGlvL2phY2s6IGFkZCBKQUNLIGNsaWVudCBhdWRpb2RldgpUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2
NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNDBl
MTRmYiBhdWRpby9qYWNrOiBhZGQgSkFDSyBjbGllbnQgYXVkaW9kZXYKCj09PSBPVVRQVVQgQkVH
SU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJ
TlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzUyOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9S
OiAiZm9vICogYmFyIiBzaG91bGQgYmUgImZvbyAqYmFyIgojNzE2OiBGSUxFOiBhdWRpby9qYWNr
YXVkaW8uYzo2NjA6CitzdGF0aWMgdm9pZCBxamFja19lcnJvcihjb25zdCBjaGFyICogbXNnKQoK
RVJST1I6ICJmb28gKiBiYXIiIHNob3VsZCBiZSAiZm9vICpiYXIiCiM3MjE6IEZJTEU6IGF1ZGlv
L2phY2thdWRpby5jOjY2NToKK3N0YXRpYyB2b2lkIHFqYWNrX2luZm8oY29uc3QgY2hhciAqIG1z
ZykKCnRvdGFsOiAyIGVycm9ycywgMSB3YXJuaW5ncywgODA2IGxpbmVzIGNoZWNrZWQKCkNvbW1p
dCA0MGUxNGZiZWJjMjQgKGF1ZGlvL2phY2s6IGFkZCBKQUNLIGNsaWVudCBhdWRpb2RldikgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDUxNTEwNTUuNUVBRDczQTAyMkZAbW95YS5vZmZpY2Uu
aG9zdGZpc3Npb24uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

