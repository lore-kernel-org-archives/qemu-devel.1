Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26920C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 03:30:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D91E120714
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 03:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91E120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJqYV-0003DG-6V
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 23:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJqXl-0002f1-2j
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 23:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJqXj-0003kj-CK
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 23:29:24 -0400
Resent-Date: Wed, 01 Apr 2020 23:29:24 -0400
Resent-Message-Id: <E1jJqXj-0003kj-CK@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJqXj-0003eE-4Q; Wed, 01 Apr 2020 23:29:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585798146; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OZUx/ZXx7GLqCNjb+BLGi2jYGdace9ilC0pcCgJbsAS7HqGyQdg/2GP5kzQrjOKOIivKph4EdK2J3DCMGgsAsU+c9+40Tuef5QO/V6l/Uu2Q5e4xh8ZynKywmuqbpEDfrOGYv5sFWAU9RH0V0ZoOIOM6g6t1L/iHy8HXljdLbrA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585798146;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=L0+qk6D2AKB2HUIxKwwFK4aRuogAlFYV1r8MJKfMEew=; 
 b=KSKD2RbXqnhJqUep7DOzAcp31kTxZgVB69O8bSWKY+fCI1ew4FKJBPCyv3/NXfalrJNsfdlpxwfbW7C8jQDjizFevY5/qyi2/dpb+ySmAjo22pP2rlygUzTjHptfvBiEw4MjnYXIvdNZbAMbmmfx1ejeW8w4MByz7Rpsd0061YI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585798140190833.7404142626564;
 Wed, 1 Apr 2020 20:29:00 -0700 (PDT)
In-Reply-To: <20200402011803.1270-1-fangying1@huawei.com>
Subject: Re: [PATCH] util/async: Add memory barrier to aio_ctx_prepare
Message-ID: <158579813892.23425.2529024709471270485@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fangying1@huawei.com
Date: Wed, 1 Apr 2020 20:29:00 -0700 (PDT)
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
Cc: fam@euphon.net, zhang.zhanghailiang@huawei.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 pbonzini@redhat.com, wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMjAxMTgwMy4xMjcw
LTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSF0gdXRpbC9hc3luYzogQWRkIG1lbW9yeSBiYXJy
aWVyIHRvIGFpb19jdHhfcHJlcGFyZQpNZXNzYWdlLWlkOiAyMDIwMDQwMjAxMTgwMy4xMjcwLTEt
ZmFuZ3lpbmcxQGh1YXdlaS5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBb
bmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNDAyMDI0NDMxLjE2MjktMS1mYW5neWluZzFA
aHVhd2VpLmNvbSAtPiBwYXRjaGV3LzIwMjAwNDAyMDI0NDMxLjE2MjktMS1mYW5neWluZzFAaHVh
d2VpLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjA2YTVkNTkgdXRpbC9hc3lu
YzogQWRkIG1lbW9yeSBiYXJyaWVyIHRvIGFpb19jdHhfcHJlcGFyZQoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KRVJST1I6IG1lbW9yeSBiYXJyaWVyIHdpdGhvdXQgY29tbWVudAojNjA6IEZJTEU6IHV0
aWwvYXN5bmMuYzoyNTQ6CisgICAgc21wX21iKCk7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDcgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDA2YTVkNTlkNTQxZCAodXRpbC9hc3luYzogQWRk
IG1lbW9yeSBiYXJyaWVyIHRvIGFpb19jdHhfcHJlcGFyZSkgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAyMDA0MDIwMTE4MDMuMTI3MC0xLWZhbmd5aW5nMUBodWF3ZWkuY29tL3Rlc3RpbmcuY2hlY2tw
YXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

