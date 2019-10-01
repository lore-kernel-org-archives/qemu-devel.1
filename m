Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AA0ECE58A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4280421783
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280421783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLUl-0002s7-41
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFKn8-0005iF-7X
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFKn6-0002qQ-Fi
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:14:21 -0400
Resent-Date: Tue, 01 Oct 2019 12:14:21 -0400
Resent-Message-Id: <E1iFKn6-0002qQ-Fi@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFKn6-0002ls-87
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:14:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569946447; cv=none; d=zoho.com; s=zohoarc; 
 b=aQvBml8vz+vc2OoqZLp6W8xq5lrvov4Vxnip/gDbfTxL1xsWxX3D7ctOLh6qZUbxBdiQEN0aav5wPmqabMc7gzC1E/LKBiqbvyLImv76wpzEwxGPwCIvohjMseLJIBXpKyM+zat+a53kS8qvLMsh+PCXpRD+YBc5hJi6z3pN63w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569946447;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=mQkQhqFc1rlUVJC5HGyrxvd9YWnGNHVrro9q+A0DvWQ=; 
 b=NmPgMkRWLwZ4geNCD6GXqVv2LtTzNjuMPDGkkPSM5vKW8IwYKTS+GMZzi5zbnok/wKy1vn38/5mtzYzVntqms5hGIqZCEJnv5ztG8wN30/YyISdO5p7a/xfl5kV3rhoWpNOWzl9XUVg613dsnO7rwBo9gdAW2BT2GYy2pIerjSQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156994644540571.86639096041574;
 Tue, 1 Oct 2019 09:14:05 -0700 (PDT)
Subject: Re: [PATCH] virtio-net: prevent offloads reset on migration
In-Reply-To: <1569932308-30478-2-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
Message-ID: <156994644427.27524.7166605496047304746@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mikhail.sennikovskii@cloud.ionos.com
Date: Tue, 1 Oct 2019 09:14:05 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: mikhail.sennikovskii@cloud.ionos.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY5OTMyMzA4LTMwNDc4LTIt
Z2l0LXNlbmQtZW1haWwtbWlraGFpbC5zZW5uaWtvdnNraWlAY2xvdWQuaW9ub3MuY29tLwoKCgpI
aSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMu
IFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVz
c2FnZS1pZDogMTU2OTkzMjMwOC0zMDQ3OC0yLWdpdC1zZW5kLWVtYWlsLW1pa2hhaWwuc2Vubmlr
b3Zza2lpQGNsb3VkLmlvbm9zLmNvbQpTdWJqZWN0OiBbUEFUQ0hdIHZpcnRpby1uZXQ6IHByZXZl
bnQgb2ZmbG9hZHMgcmVzZXQgb24gbWlncmF0aW9uCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3Jh
bQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcx
MzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjlkMjc3NGUgdmlydGlvLW5ldDog
cHJldmVudCBvZmZsb2FkcyByZXNldCBvbiBtaWdyYXRpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09
CkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojOTc6IEZJTEU6IGh3L3ZpcnRpby92aXJ0
aW8uYzoyMDQ5Ogorc3RhdGljIGludCB2aXJ0aW9fc2V0X2ZlYXR1cmVzX25vY2hlY2soVmlydElP
RGV2aWNlICp2ZGV2LCB1aW50NjRfdCB2YWwsIGJvb2wgcmVzZXRfb2ZmbG9hZHMpCgp0b3RhbDog
MSBlcnJvcnMsIDAgd2FybmluZ3MsIDc0IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA5ZDI3NzRlYTdl
YjEgKHZpcnRpby1uZXQ6IHByZXZlbnQgb2ZmbG9hZHMgcmVzZXQgb24gbWlncmF0aW9uKSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8xNTY5OTMyMzA4LTMwNDc4LTItZ2l0LXNlbmQtZW1haWwtbWlraGFp
bC5zZW5uaWtvdnNraWlAY2xvdWQuaW9ub3MuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==


