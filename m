Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80DDC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02282070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02282070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY5v4-0002qd-LJ
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iY5u1-0002Oz-J4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iY5tz-0002tT-Nw
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:11:01 -0500
Resent-Date: Fri, 22 Nov 2019 05:11:01 -0500
Resent-Message-Id: <E1iY5tz-0002tT-Nw@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21164)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iY5tz-0002sg-GM; Fri, 22 Nov 2019 05:10:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574417450; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j23Uun3Q78hmXktWcIsAiPFOdF0fHi6uqc7sMipWvpuzP7Zp15TLouknMvIDxw5tGi76fecug9J1OlDJjlioyjS/4moD8EhXeHsyZOZjIJpR7hO8tcM+El/yOZw0yXOnK7ySpBJ7YQtkSYGG+x+vR8pyW8hdAmSo88TqJYBOCz4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574417450;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vKKgFQxitGhg1Do2t5gNmPt7zMDkvrTyQ+nMJ+hu32c=; 
 b=Y8xHsyQ08KrdAj8H2MlMbWroHd3gzsSVKNKEqCG5krkMu9s+CwqDJ2Iq36of76uZUm5Ph66sPUDIGSVRvO0+w/YOhpSBo9ricuxm0G43oMEiuFdo5kQtdOckyY1lql3sWPTkpRbKiKrhf6Ll3g1FpyrAMOv7LT6sQflAVr96kXU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574417449144924.5787763219571;
 Fri, 22 Nov 2019 02:10:49 -0800 (PST)
In-Reply-To: <20191122075218.23935-1-frankja@linux.ibm.com>
Subject: Re: [PATCH 0/4] s390x: Reset cleanup
Message-ID: <157441744777.7001.4986349569481081153@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Fri, 22 Nov 2019 02:10:49 -0800 (PST)
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyMjA3NTIxOC4yMzkz
NS0xLWZyYW5ramFAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAvNF0gczM5MHg6IFJlc2V0IGNsZWFudXAK
VHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkxMTIyMDc1MjE4LjIzOTM1LTEtZnJhbmtqYUBs
aW51eC5pYm0uY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCBy
ZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2tw
YXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRp
bmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCmI1NTdkZWEgczM5MHg6IEJlYXV0aWZ5IG1hY2hpbmUgcmVzZXQK
ZTUyNDRjNyBzMzkweDogQmVhdXRpZnkgZGlhZzMwOCBoYW5kbGluZwoyODhmNDM2IHMzOTB4OiBD
bGVhbnVwIGNwdSByZXNldHMKOWY4NWFmNiBzMzkweDogRG9uJ3QgZG8gYSBub3JtYWwgcmVzZXQg
b24gdGhlIGluaXRpYWwgY3B1Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29t
bWl0IDlmODVhZjY4ODQ0YSAoczM5MHg6IERvbid0IGRvIGEgbm9ybWFsIHJlc2V0IG9uIHRoZSBp
bml0aWFsIGNwdSkKMi80IENoZWNraW5nIGNvbW1pdCAyODhmNDM2ZGM4ZTkgKHMzOTB4OiBDbGVh
bnVwIGNwdSByZXNldHMpCjMvNCBDaGVja2luZyBjb21taXQgZTUyNDRjN2VkZGU4IChzMzkweDog
QmVhdXRpZnkgZGlhZzMwOCBoYW5kbGluZykKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMjU6IEZJTEU6IHRhcmdldC9zMzkweC9kaWFnLmM6NTY6CisjZGVmaW5lIERJ
QUczMDhfUkVTRVRfTU9EX0NMUl5JXkkwJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMjY6IEZJTEU6IHRhcmdldC9zMzkweC9kaWFnLmM6NTc6CisjZGVmaW5lIERJ
QUczMDhfUkVTRVRfTE9BRF9OT1JNXkleSTEkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMyNzogRklMRTogdGFyZ2V0L3MzOTB4L2RpYWcuYzo1ODoKKyNkZWZpbmUg
RElBRzMwOF9MT0FEX0NMRUFSXkleSTMkCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiMyODogRklMRTogdGFyZ2V0L3MzOTB4L2RpYWcuYzo1OToKKyNkZWZpbmUgRElB
RzMwOF9MT0FEX05PUk1BTF9EVU1QXkk0JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMjk6IEZJTEU6IHRhcmdldC9zMzkweC9kaWFnLmM6NjA6CisjZGVmaW5lIERJ
QUczMDhfU0VUXkleSV5JNSQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRh
YnMKIzMwOiBGSUxFOiB0YXJnZXQvczM5MHgvZGlhZy5jOjYxOgorI2RlZmluZSBESUFHMzA4X1NU
T1JFXkleSV5JNiQKCnRvdGFsOiA2IGVycm9ycywgMCB3YXJuaW5ncywgODMgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzQgQ2hlY2tpbmcgY29t
bWl0IGI1NTdkZWExOGJjMSAoczM5MHg6IEJlYXV0aWZ5IG1hY2hpbmUgcmVzZXQpCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTIyMDc1MjE4
LjIzOTM1LTEtZnJhbmtqYUBsaW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


