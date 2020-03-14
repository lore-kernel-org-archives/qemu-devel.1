Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7077AC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9A92074C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 08:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9A92074C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2VZ-0000Xr-F3
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 04:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jD2UE-0008DH-3d
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jD2UB-00029G-IO
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:49:37 -0400
Resent-Date: Sat, 14 Mar 2020 04:49:36 -0400
Resent-Message-Id: <E1jD2UB-00029G-IO@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jD2U9-0001yu-IQ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 04:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584175756; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HbUvHTB/v/JEG8HIrWsoXtPUzztSX/J6YA+03KXSP288TjR6+nvgWbcSs8Kgonhgpu7QYTc30RBMvxAvv2U77BfaYSzbqL3XuSUfw45SN6wopNNxqWyJ5dJ8LvJDB1QUsupOUqwO2bTdkvLBFhmJzxCd4Sv7X67diRlN2TwPgcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584175756;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=w6whUahiKhDP/14heov8yuTjCXlBwFDWrtZ3kxcr+OA=; 
 b=UAxNj5i6iIfu+YTglJtXbzgB3XJMagbWMtx59GYfU7HsB8+1sAv8uC+eM77vkvboAGyaaXbLLd79GBoKpshyuSOr1XiUwt6q/sN4pCmWlMIYPH2GRVbmylE+hTmmdtMFQjegUi4HPUJh+BjCTJN0CKPe8qr9tN5P3CBZjxem2+0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584175755025908.0344551673073;
 Sat, 14 Mar 2020 01:49:15 -0700 (PDT)
In-Reply-To: <20200314084730.25876-1-pannengyuan@huawei.com>
Subject: Re: [PATCH v5 0/4] delay timer_new from init to realize to fix
 memleaks.
Message-ID: <158417575384.31574.3454645038204657338@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pannengyuan@huawei.com
Date: Sat, 14 Mar 2020 01:49:15 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, euler.robot@huawei.com, pannengyuan@huawei.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxNDA4NDczMC4yNTg3
Ni0xLXBhbm5lbmd5dWFuQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2NSAwLzRdIGRlbGF5IHRpbWVyX25ldyBm
cm9tIGluaXQgdG8gcmVhbGl6ZSB0byBmaXggbWVtbGVha3MuCk1lc3NhZ2UtaWQ6IDIwMjAwMzE0
MDg0NzMwLjI1ODc2LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4
MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXct
cHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDAzMTIxNDU5MDAu
MjA1NC0xLXpoaXdlaV9saXVAYy1za3kuY29tIC0+IHBhdGNoZXcvMjAyMDAzMTIxNDU5MDAuMjA1
NC0xLXpoaXdlaV9saXVAYy1za3kuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
NTcyMjViNSBody9taXNjL21vczY1MjI6IG1vdmUgdGltZXJfbmV3IGZyb20gaW5pdCgpIGludG8g
cmVhbGl6ZSgpIHRvIGF2b2lkIG1lbWxlYWtzCjY4YWUwYTIgaHcvbWlzYy9tYWNpbzogZml4IGlu
Y29ycmVjdCBjcmVhdGlvbiBvZiBtb3M2NTIyJ3Mgc3ViY2xhc3Nlcwo1YjgzMjViIG1hY192aWE6
IGZpeCBpbmNvcnJlY3QgY3JlYXRpb24gb2YgbW9zNjUyMiBkZXZpY2UgaW4gbWFjX3ZpYQozMzBk
ZTQ4IHMzOTB4OiBmaXggbWVtbGVha3MgaW4gY3B1X2ZpbmFsaXplCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQoxLzQgQ2hlY2tpbmcgY29tbWl0IDMzMGRlNDg0YTUxNSAoczM5MHg6IGZpeCBtZW1sZWFr
cyBpbiBjcHVfZmluYWxpemUpCjIvNCBDaGVja2luZyBjb21taXQgNWI4MzI1YmRiNzUyIChtYWNf
dmlhOiBmaXggaW5jb3JyZWN0IGNyZWF0aW9uIG9mIG1vczY1MjIgZGV2aWNlIGluIG1hY192aWEp
CjMvNCBDaGVja2luZyBjb21taXQgNjhhZTBhMmVhOTViIChody9taXNjL21hY2lvOiBmaXggaW5j
b3JyZWN0IGNyZWF0aW9uIG9mIG1vczY1MjIncyBzdWJjbGFzc2VzKQpFUlJPUjogc3VwZXJmbHVv
dXMgdHJhaWxpbmcgc2VtaWNvbG9uCiM2MjogRklMRTogaHcvbWlzYy9tYWNpby9wbXUuYzo3NDU6
CisgICAgRGV2aWNlU3RhdGUgKmQgPSBERVZJQ0UoJnMtPm1vczY1MjJfcG11KTs7Cgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDUyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNCBoYXMgc3R5
bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBm
YWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BB
VENIIGluIE1BSU5UQUlORVJTLgoKNC80IENoZWNraW5nIGNvbW1pdCA1NzIyNWI1Y2VhM2IgKGh3
L21pc2MvbW9zNjUyMjogbW92ZSB0aW1lcl9uZXcgZnJvbSBpbml0KCkgaW50byByZWFsaXplKCkg
dG8gYXZvaWQgbWVtbGVha3MpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMjAwMzE0MDg0NzMwLjI1ODc2LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNv
bS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

