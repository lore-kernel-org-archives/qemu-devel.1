Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31937C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058E0208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058E0208CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9kI5-0002fh-3k
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 01:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j9kHS-00027W-Gl
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j9kHQ-0005z9-UW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:46:50 -0500
Resent-Date: Thu, 05 Mar 2020 01:46:50 -0500
Resent-Message-Id: <E1j9kHQ-0005z9-UW@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j9kHP-0005uo-US
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:46:48 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583390791; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ByEIFKRNb4NuC3D7kuKUNKaq1ohUOev6SlWvvncnOxYGddT+KaB7YEnDOSZTSMK51UsI9Z9MUWbSrjlxun7lSVQRdDSxOYLD57xy+ISa0nxtvVeSx4/dm5HvdEn+6yR/QfahrTa0Yci6H0T3Q9P/5btvpKxwoz6wvh14fqdcv2Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583390791;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=U0mCt237GOSF99Qq9i2J67u8U41alymRVjO/8RHH9jY=; 
 b=VRJfNeYonuM9a/81PkjVhJfgn2Pb6e39Djp9JejiKsYeOCABA6Y04NOgxyZtA4tfp+9b8GUsLYpmBdO3h/c8PA642eRQvCXr2y7qBGT2j2M96knZelCP57Fpu8N39CroXtDbs5LDHcC8Ksm6kmhTqlZtaKUAfvh5EkCH8Tw6IZY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583390787779664.3875363527235;
 Wed, 4 Mar 2020 22:46:27 -0800 (PST)
In-Reply-To: <20200305065422.12707-1-pannengyuan@huawei.com>
Subject: Re: [PATCH v4 0/3] delay timer_new from init to realize to fix
 memleaks.
Message-ID: <158339078635.21741.17139522732073942467@abdcc9e1aa82>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pannengyuan@huawei.com
Date: Wed, 4 Mar 2020 22:46:27 -0800 (PST)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwNTA2NTQyMi4xMjcw
Ny0xLXBhbm5lbmd5dWFuQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2NCAwLzNdIGRlbGF5IHRpbWVyX25ldyBm
cm9tIGluaXQgdG8gcmVhbGl6ZSB0byBmaXggbWVtbGVha3MuCk1lc3NhZ2UtaWQ6IDIwMjAwMzA1
MDY1NDIyLjEyNzA3LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rl
di9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sg
YmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9w
YXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwMzA1
MDY1NDIyLjEyNzA3LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzIwMjAwMzA1
MDY1NDIyLjEyNzA3LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCmU4N2FhOTkgaHcvbWlzYy9tb3M2NTIyOiBtb3ZlIHRpbWVyX25ldyBmcm9t
IGluaXQoKSBpbnRvIHJlYWxpemUoKSB0byBhdm9pZCBtZW1sZWFrcwowYzY1ODhiIG1hY192aWE6
IGZpeCBpbmNvcnJlY3QgY3JlYXRpb24gb2YgbW9zNjUyMiBkZXZpY2UgaW4gbWFjX3ZpYQoxYWZk
YjRlIHMzOTB4OiBmaXggbWVtbGVha3MgaW4gY3B1X2ZpbmFsaXplCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IDFhZmRiNGUxODFmMSAoczM5MHg6IGZpeCBtZW1sZWFr
cyBpbiBjcHVfZmluYWxpemUpCjIvMyBDaGVja2luZyBjb21taXQgMGM2NTg4YmIwOTkxIChtYWNf
dmlhOiBmaXggaW5jb3JyZWN0IGNyZWF0aW9uIG9mIG1vczY1MjIgZGV2aWNlIGluIG1hY192aWEp
CkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiM3MTogRklMRTogaHcvbWlzYy9tYWNfdmlhLmM6
OTU0OgorICAgIG9iamVjdF9pbml0aWFsaXplX2NoaWxkKE9CSkVDVChtKSwgInZpYTEiLCAmbS0+
bW9zNjUyMl92aWExLCAkCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDY2IGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8zIENoZWNraW5n
IGNvbW1pdCBlODdhYTk5Mzc2ZDYgKGh3L21pc2MvbW9zNjUyMjogbW92ZSB0aW1lcl9uZXcgZnJv
bSBpbml0KCkgaW50byByZWFsaXplKCkgdG8gYXZvaWQgbWVtbGVha3MpCj09PSBPVVRQVVQgRU5E
ID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzA1MDY1NDIyLjEyNzA3
LTEtcGFubmVuZ3l1YW5AaHVhd2VpLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

