Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A61C2BBC7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 13:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BC52075E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 13:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BC52075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNzVp-0006hc-9Q
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 09:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45332)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jNzV7-00065q-Gt
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 09:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jNzV5-00058H-V4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 09:51:49 -0400
Resent-Date: Mon, 13 Apr 2020 09:51:49 -0400
Resent-Message-Id: <E1jNzV5-00058H-V4@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21358)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jNzV5-00056s-Ml
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 09:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586785894; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Emmdh79IxNiREF8ZiWA+s+dSuo5EAU6liaCHnPvmfaQHIbN83oCIwzzTcZ+36iobeniyUzeWPX29tlbU1JeTOxPXngDYKV7vTnKzgoeAqg+MyA62Q2mhwXu44FclDK/J7WEM3HsiyKEug18WiEz8NytP3YymXPBQ6MkQTg71IKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586785894;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=jQxzJzfzKuzRP4R2P/F+AyzRd9qP0j8vzIo7TgzBnUo=; 
 b=TzLRY5TEqYolW9QBXJ8HcGPWhK0xXA8kX1dqBM6BsjEnmj+wSFjjz/XEGg5yPMwNY9p4wxHFoss5fpQr7T8bQ2cvqMosPmhrSU5Sj7Yp3ZyTy/17MSThMAIN0IbLo6LCct/XpyYLrLSmPOMw/j7efhbzESktjt8a3gLt0/xoAYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586785891654924.8306588791146;
 Mon, 13 Apr 2020 06:51:31 -0700 (PDT)
In-Reply-To: <1586776334-641239-1-git-send-email-dplotnikov@virtuozzo.com>
Subject: Re: [RFC patch v1 0/3] qemu-file writing performance improving
Message-ID: <158678589039.27250.14048005066509196338@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dplotnikov@virtuozzo.com
Date: Mon, 13 Apr 2020 06:51:31 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: den@openvz.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg2Nzc2MzM0LTY0MTIzOS0x
LWdpdC1zZW5kLWVtYWlsLWRwbG90bmlrb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNl
cmllcyBmYWlsZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0Bm
ZWRvcmEgVEFSR0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vcWVtdS1maWxlLmM6
NDE1OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBhaW9fdGFza19wb29sX3N0YXJ0X3Rhc2snCi91
c3IvYmluL2xkOiBtaWdyYXRpb24vcWVtdS1maWxlLm86IGluIGZ1bmN0aW9uIGBxZW11X2ZpbGVf
c3dpdGNoX2N1cnJlbnRfYnVmJzoKL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9xZW11LWZp
bGUuYzozODA6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGFpb190YXNrX3Bvb2xfd2FpdF9zbG90
JwpjbGFuZy04OiBlcnJvcjogbGlua2VyIGNvbW1hbmQgZmFpbGVkIHdpdGggZXhpdCBjb2RlIDEg
KHVzZSAtdiB0byBzZWUgaW52b2NhdGlvbikKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMv
cnVsZXMubWFrOjEyNDogdGVzdHMvdGVzdC12bXN0YXRlXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1v
ZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTMwNTU0OGU5YmU0
MzRkZGViM2EwNmM3MDZlOWRhYjFhJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNv
ZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWFvdW56a29rL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMTMtMDkuNDQuNTAuMjcw
MzU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzA1NTQ4ZTliZTQzNGRkZWIz
YTA2YzcwNmU5ZGFiMWEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYW91bnprb2sv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0BmZWRvcmFdIEVycm9yIDIKCnJl
YWwgICAgNm0zOS40MDNzCnVzZXIgICAgMG05LjA2OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1ODY3NzYzMzQtNjQxMjM5LTEtZ2l0LXNl
bmQtZW1haWwtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

