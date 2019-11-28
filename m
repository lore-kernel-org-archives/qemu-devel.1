Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAA6C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 23:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E9F21775
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 23:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E9F21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaT24-0008KO-7y
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 18:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iaSv4-0006M9-RT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 18:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iaSuu-0005yn-B7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 18:09:48 -0500
Resent-Date: Thu, 28 Nov 2019 18:09:47 -0500
Resent-Message-Id: <E1iaSuu-0005yn-B7@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iaSuj-0005hC-0j; Thu, 28 Nov 2019 18:09:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574982556; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UETdBYriYJ5bEhV06ptlrhjLI+zT3/1E9TPl0jFsMavwmXuMTsikvo42AuRG/idKfrXtwazgyqGdyDIXCuykCxcx/azTBoj1AFhs4zJhSavaNxyQhGU6td6BcDZumANHyyPvnIbCbjG5WIeoqPf8W+q1eDiOrg7Kto7/JmpjpSo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574982556;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DdL8mYrIvT7PlBNKBy5QxKH/jRtl8dw5ftPFWFQXo2I=; 
 b=PTwunY1WAGJrNMlIIiDt4ugTt3uX8uC/yfSsybt4ay4ZQLFCmpZ1hlFzRbgmmTU0BrN0EmX3cUcK9Z7V48Hh4C0mIKHYDt2gEzLhL0DkJld0gQeqSqfJIDTvVUaBeBjIOh4ywamyi6umftZ3T8Eg2o8yH7UknSoOgHcoYOYdnjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574982555652952.8340688484823;
 Thu, 28 Nov 2019 15:09:15 -0800 (PST)
In-Reply-To: <1574935984-16910-1-git-send-email-pmorel@linux.ibm.com>
Subject: Re: [PATCH v1 0/1] s390x: protvirt: SCLP interpretation
Message-ID: <157498255417.16987.8951187663594275841@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pmorel@linux.ibm.com
Date: Thu, 28 Nov 2019 15:09:15 -0800 (PST)
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc0OTM1OTg0LTE2OTEwLTEt
Z2l0LXNlbmQtZW1haWwtcG1vcmVsQGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
c2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxv
dyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MSAwLzFdIHMzOTB4OiBw
cm90dmlydDogU0NMUCBpbnRlcnByZXRhdGlvbgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMTU3
NDkzNTk4NC0xNjkxMC0xLWdpdC1zZW5kLWVtYWlsLXBtb3JlbEBsaW51eC5pYm0uY29tCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CmNjNDJjZGMgczM5MHg6IHByb3R2aXJ0OiBTQ0xQIGludGVycHJldGF0aW9uCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpFUlJPUjogc3dpdGNoIGFuZCBjYXNlIHNob3VsZCBiZSBhdCB0aGUgc2FtZSBp
bmRlbnQKIzEzNTogRklMRTogdGFyZ2V0L3MzOTB4L2t2bS5jOjE3MTU6CiAgICAgc3dpdGNoIChp
Y3B0X2NvZGUpIHsKKyAgICAgICAgIGNhc2UgSUNQVF9QVl9JTlNUUl9OT1Q6ClsuLi5dCisgICAg
ICAgIGNhc2UgSUNQVF9QVl9JTlNUUjoKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTA1
IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBjYzQyY2RjMzYxNzEgKHMzOTB4OiBwcm90dmlydDogU0NM
UCBpbnRlcnByZXRhdGlvbikgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3NDkzNTk4NC0xNjkxMC0x
LWdpdC1zZW5kLWVtYWlsLXBtb3JlbEBsaW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


