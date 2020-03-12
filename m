Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F98C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20AB206E7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20AB206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOq6-0004sO-Vl
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCOpT-0003ZJ-38
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCOpR-0005Z6-35
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:28:54 -0400
Resent-Date: Thu, 12 Mar 2020 10:28:54 -0400
Resent-Message-Id: <E1jCOpR-0005Z6-35@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCOpQ-0005YO-Qc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584023326; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CtrF86UCzSdgBAhfjY5VDCB/mlITQ71ekvzjiRZjKVI8oBxN0QiHnH5WoTjQxmbmAAk8YAr91l9rc2yU+btpVQEZKCpNANMW/0XkiHSZlaXz2fB75AlOuBnIr9NUboS0r8/p4j5UWc0Cbe2sxx4AMJDhhNhSrZmmwQEqOPDuiM8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584023326;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=0niZX8PwxumE/UzYcFwGnfqa5bJlUZSGPVWb9mANXYk=; 
 b=F/A/p33+yap/HKpb0zTOMZR6xLVdaFr7IdnNhknRh6d+FKSCYEE8GMM6GwqJDCx7f6yM2s4S6MElhkhnqX+N+8ba3+O6XegeAdjyisvsJHBQuc5wddXFwjmCJK4wawnkjbLXJaKqIur79L2BxKtPassYuumUpvcUz59pNsd/w58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584023323930644.9744745025542;
 Thu, 12 Mar 2020 07:28:43 -0700 (PDT)
In-Reply-To: <20200312140547.20448-1-ovoshcha@redhat.com>
Subject: Re: [PATCH v2] python/qemu/qmp.py: QMP debug with VM label
Message-ID: <158402332246.16773.12309807289447908847@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ovoshcha@redhat.com
Date: Thu, 12 Mar 2020 07:28:43 -0700 (PDT)
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
Cc: ehabkost@redhat.com, ovoshcha@redhat.com, qemu-devel@nongnu.org,
 wainersm@redhat.com, crosa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMjE0MDU0Ny4yMDQ0
OC0xLW92b3NoY2hhQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2Ml0gcHl0aG9uL3FlbXUvcW1wLnB5OiBRTVAg
ZGVidWcgd2l0aCBWTSBsYWJlbApNZXNzYWdlLWlkOiAyMDIwMDMxMjE0MDU0Ny4yMDQ0OC0xLW92
b3NoY2hhQHJlZGhhdC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjhhMGFjOGYgcHl0aG9uL3FlbXUv
cW1wLnB5OiBRTVAgZGVidWcgd2l0aCBWTSBsYWJlbAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJS
T1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMyNTogRklMRTogcHl0aG9uL3FlbXUvbWFjaGlu
ZS5weToyNzM6CisgICAgICAgICAgICBzZWxmLl9xbXAgPSBxbXAuUUVNVU1vbml0b3JQcm90b2Nv
bChzZWxmLl92bV9tb25pdG9yLCBzZXJ2ZXI9VHJ1ZSwgbmlja25hbWU9c2VsZi5fbmFtZSkKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzEgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDhhMGFj
OGYyMjAzZSAocHl0aG9uL3FlbXUvcW1wLnB5OiBRTVAgZGVidWcgd2l0aCBWTSBsYWJlbCkgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQg
ZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMTIxNDA1NDcuMjA0NDgtMS1vdm9zaGNoYUByZWRoYXQu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

