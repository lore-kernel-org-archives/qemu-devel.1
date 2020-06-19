Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB230C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F2C21527
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F2C21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHW5-0003u3-Ql
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmHVM-0003LJ-Db
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:56:28 -0400
Resent-Date: Fri, 19 Jun 2020 09:56:28 -0400
Resent-Message-Id: <E1jmHVM-0003LJ-Db@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmHVK-0001Z6-0x
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:56:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592574978; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iKi6Wt9IxIBR8zkeNRXBHEzWVXS9AEJocfw60d6inQlmx0qUgRgnmUu0vctFjzbJWy5JD9K4mrF6q8jatM+vgGds9T2ZBAyRsxbPpH6So/6zUcaGvGOaYDw4UH2Uv3QKeio+7D8DjifgmqPBMt8dfmrnm6XITDQcn7GpVnsS6fA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592574978;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PLOd68uZXolx/LizxOR24NNzC6+TY40e16xPdxHykYk=; 
 b=Ldw6JHgEcR40uI1Vm5eFoJJ08dc8MTO895+pMr6JbQiX/L24eICkaV/AjInW/8NiPgFNsGbCtoswvQrBcoZLNNJL3YBCi0b7VhjdHtneq1G/YloqtyWc7q5lbqz0XmzP5o59AbTeNhiyq5M+wZUzNAK+yoBwh2d3qErP5eyO5k8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592574976412474.9790726364729;
 Fri, 19 Jun 2020 06:56:16 -0700 (PDT)
Message-ID: <159257497532.2529.17652457882745894379@d1fd068a5071>
Subject: Re: [PULL 0/7] Audio 20200619 patches
In-Reply-To: <20200619131741.10857-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Fri, 19 Jun 2020 06:56:16 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 07:15:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxOTEzMTc0MS4xMDg1
Ny0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUFVMTCAwLzddIEF1ZGlvIDIwMjAwNjE5IHBhdGNoZXMKVHlw
ZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNjE5MTMxNzQxLjEwODU3LTEta3JheGVsQHJlZGhh
dC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAy
MDA2MTkxMjMzMzEuMTczODctMS1maWxpcC5ib3p1dGFAc3lybWlhLmNvbSAtPiBwYXRjaGV3LzIw
MjAwNjE5MTIzMzMxLjE3Mzg3LTEtZmlsaXAuYm96dXRhQHN5cm1pYS5jb20KU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0Jwo0MjZlODQzIGh3L2F1ZGlvL2d1czogRml4IHJlZ2lzdGVycyAz
Mi1iaXQgYWNjZXNzCmZmYWQ5NDMgYXVkaW8vamFjazogc2ltcGxpZnkgdGhlIHJlLWluaXQgY29k
ZSBwYXRoCjhlYzQ4ZWYgYXVkaW8vamFjazogaG9ub3VyIHRoZSBlbmFibGUgc3RhdGUgb2YgdGhl
IGF1ZGlvIGRldmljZQpmNDA3M2Y1IGF1ZGlvL2phY2s6IGRvIG5vdCByZW1vdmUgcG9ydHMgd2hl
biBmaW5pc2hpbmcKZmMzMTRhNiBhdWRpby9qYWNrOiByZW1vdmUgaW52YWxpZCBzZXQgb2YgaW5w
dXQgc3VwcG9ydCBib29sCjY5YzVmM2YgYXVkaW8vamFjazogcmVtb3ZlIHVudXNlZCBzdG9wcGVk
IHN0YXRlCmY2NTg2ZWYgYXVkaW8vamFjazogZml4IGludmFsaWQgbWluaW11bSBidWZmZXIgc2l6
ZSBjaGVjawoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS83IENoZWNraW5nIGNvbW1pdCBmNjU4NmVm
OTBiN2UgKGF1ZGlvL2phY2s6IGZpeCBpbnZhbGlkIG1pbmltdW0gYnVmZmVyIHNpemUgY2hlY2sp
CjIvNyBDaGVja2luZyBjb21taXQgNjljNWYzZmUwYTE3IChhdWRpby9qYWNrOiByZW1vdmUgdW51
c2VkIHN0b3BwZWQgc3RhdGUpCjMvNyBDaGVja2luZyBjb21taXQgZmMzMTRhNmI4YWEzIChhdWRp
by9qYWNrOiByZW1vdmUgaW52YWxpZCBzZXQgb2YgaW5wdXQgc3VwcG9ydCBib29sKQo0LzcgQ2hl
Y2tpbmcgY29tbWl0IGY0MDczZjVjYjA1NCAoYXVkaW8vamFjazogZG8gbm90IHJlbW92ZSBwb3J0
cyB3aGVuIGZpbmlzaGluZykKNS83IENoZWNraW5nIGNvbW1pdCA4ZWM0OGVmYjFiMjEgKGF1ZGlv
L2phY2s6IGhvbm91ciB0aGUgZW5hYmxlIHN0YXRlIG9mIHRoZSBhdWRpbyBkZXZpY2UpCkVSUk9S
OiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gcGFyZW50aGVzaXMgJygnCiM0NDogRklM
RTogYXVkaW8vamFja2F1ZGlvLmM6Mjc3OgorICAgICAgICAgICAgZm9yKGludCBpID0gMDsgaSA8
IGMtPm5jaGFubmVsczsgKytpKSB7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDkxIGxp
bmVzIGNoZWNrZWQKClBhdGNoIDUvNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi83IENo
ZWNraW5nIGNvbW1pdCBmZmFkOTQzYmNjYmMgKGF1ZGlvL2phY2s6IHNpbXBsaWZ5IHRoZSByZS1p
bml0IGNvZGUgcGF0aCkKNy83IENoZWNraW5nIGNvbW1pdCA0MjZlODQzZTc2OGMgKGh3L2F1ZGlv
L2d1czogRml4IHJlZ2lzdGVycyAzMi1iaXQgYWNjZXNzKQo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYxOTEzMTc0MS4xMDg1Ny0xLWtyYXhl
bEByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

