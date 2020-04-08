Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330C6C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094AA206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094AA206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM4St-0000TO-6c
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 02:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM4SD-0008Po-E4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM4SC-0003rB-0X
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:44:53 -0400
Resent-Date: Wed, 08 Apr 2020 02:44:53 -0400
Resent-Message-Id: <E1jM4SC-0003rB-0X@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM4SB-0003qj-PI
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586328286; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CuK4+P0izLMsOCJATEzLQmmMDGrSlknsyVMr5hC41B03HUbwBfc4QaKwUsMi4P01VO8QI6zzRT6VB57Q6AQSHC6Xv9LFWa0xNvh/mMvPS/s4X0WZ+hSW+TuMaGg5JMz5bEXpi1XNSN4ir1j9ytQ+EJUBrcy4zIyZMHs0Q2pGKng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586328286;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LtiTda9/tWe+1zFFjJA5AC+JXa8wi0Gi1VIJTe1iyQc=; 
 b=HOC/wQWOkyALIp+lRACGoj/mrvxP2ilRvKRJXGOr+ytO8CUFxOd70XMfWs4w97RNo54vWyfS3nNqyxA4Fa61iihEIoI56q1y1KqGpwl9qjr3IxhbMVi4jhaieTIH/o+lbLf0HSUJyZSUB2GBtjjqv0okOtllzedrfc2qdJuiBW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586328284622705.2642470063267;
 Tue, 7 Apr 2020 23:44:44 -0700 (PDT)
In-Reply-To: <20200408003552.58095-1-mansourweb@gmail.com>
Subject: Re: [PATCH] When updating the PFLASH file contents,
 we should check for a possible failure of blk_pwrite(). Similar to
 3a68829 commit
Message-ID: <158632828357.16886.2458324819961395602@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mansourweb@gmail.com
Date: Tue, 7 Apr 2020 23:44:44 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: mansourweb@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODAwMzU1Mi41ODA5
NS0xLW1hbnNvdXJ3ZWJAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBo
dy9jb3JlL21hY2hpbmUtaG1wLWNtZHMubwogIENDICAgICAgaHcvY29yZS9udW1hLm8KL3RtcC9x
ZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL3BmbGFzaF9jZmkwMi5jOiBJbiBmdW5jdGlvbiAncGZsYXNo
X3VwZGF0ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9wZmxhc2hfY2ZpMDIuYzo0MDU6
NjogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdlcnJvcl9yZXBvcnQn
OyBkaWQgeW91IG1lYW4gJ2Vycm9yX3JlcG9ydF9lcnInPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5j
dGlvbi1kZWNsYXJhdGlvbl0KICAgICAgZXJyb3JfcmVwb3J0KCJDb3VsZCBub3QgdXBkYXRlIFBG
TEFTSDogJXMiLCBzdHJlcnJvcigtcmV0KSk7CiAgICAgIF5+fn5+fn5+fn5+fgogICAgICBlcnJv
cl9yZXBvcnRfZXJyCi90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9wZmxhc2hfY2ZpMDIuYzo0
MDU6NjogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ2Vycm9yX3JlcG9ydCcg
Wy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcv
YmxvY2svcGZsYXNoX2NmaTAyLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUg
Ii4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAg
IHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVk
UHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICct
LWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzljMTlhYjM4ZDk4NDIwZDg1OGE1ZDI3
ZmFjODQwYzQnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29u
ZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklH
VVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1l
JywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNo
ZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1wNGloZDZmdy9zcmMvZG9j
a2VyLXNyYy4yMDIwLTA0LTA4LTAyLjQyLjMwLjEwMjI5Oi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPTM5YzE5YWIzOGQ5ODQyMGQ4NThhNWQyN2ZhYzg0MGM0Cm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXA0aWhkNmZ3L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDJtMTMuNTA2cwp1c2VyICAgIDBt
OC40NjhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDQwODAwMzU1Mi41ODA5NS0xLW1hbnNvdXJ3ZWJAZ21haWwuY29tL3Rlc3Rpbmcu
ZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

