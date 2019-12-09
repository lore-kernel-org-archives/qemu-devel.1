Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642A7C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B41205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B41205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieOh2-0002Df-9Q
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 14:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieOgI-0001lk-Mv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:26:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieOgH-0001ZS-Dp
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:26:54 -0500
Resent-Date: Mon, 09 Dec 2019 14:26:54 -0500
Resent-Message-Id: <E1ieOgH-0001ZS-Dp@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieOgH-0001Xg-5t
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:26:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575919606; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jlasrum9V4nMTyj+lmmPWnRt3E6SxX8H5V8hX3H6y/V0LBEojNtK2BXtYtuyawj6BBZBI1jQooQe4mvUjEug7RG+tVbxEQN2aObgGn/Hd90o1sdbChL1JNT3lwMA1UPh8V/hKyFNlwW0SnyBrIjldz9V58WQZZ+l4ojFGEF8l5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575919606;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1xP8tk9pLg8Ux3KKPqMZPmzdhUWsSeachdAZcorTY1I=; 
 b=ictc2CZtvvqFOyIr2a887nCD5DevWKTB2cGyP+o2HMMG2sCJtZKM0vCl0F9CT4jMOSbzn7+ECjwIZew/2l5iSAKa3ZUP+7SXeB82UwV700uLtc/1ERaMrTK3Zn4tiRXHUy7fDSJEKp0x7WTkk7IT5xYhUgS5TQ7v6mBzUV8sEi8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575919604562929.9148971212119;
 Mon, 9 Dec 2019 11:26:44 -0800 (PST)
In-Reply-To: <20191209110759.35227-1-stefanha@redhat.com>
Subject: Re: [PATCH] virtio-fs: fix MSI-X nvectors calculation
Message-ID: <157591960341.7675.10377093509815064802@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Mon, 9 Dec 2019 11:26:44 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: mst@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwOTExMDc1OS4zNTIy
Ny0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3VibW9kdWxlICdk
dGMnIChodHRwczovL2dpdC5xZW11Lm9yZy9naXQvZHRjLmdpdCkgcmVnaXN0ZXJlZCBmb3IgcGF0
aCAnZHRjJwpDbG9uaW5nIGludG8gJ2R0YycuLi4KcmVtb3RlOiBDb3VudGluZyBvYmplY3RzOiA1
MjgwLCBkb25lLiAgICAgICAgCmVycm9yOiBSUEMgZmFpbGVkOyByZXN1bHQ9MTgsIEhUVFAgY29k
ZSA9IDIwMApmYXRhbDogVGhlIHJlbW90ZSBlbmQgaHVuZyB1cCB1bmV4cGVjdGVkbHkKZmF0YWw6
IHByb3RvY29sIGVycm9yOiBiYWQgcGFjayBoZWFkZXIKQ2xvbmUgb2YgJ2h0dHBzOi8vZ2l0LnFl
bXUub3JnL2dpdC9kdGMuZ2l0JyBpbnRvIHN1Ym1vZHVsZSBwYXRoICdkdGMnIGZhaWxlZApmYWls
ZWQgdG8gdXBkYXRlIHN1Ym1vZHVsZSBkdGMKU3VibW9kdWxlICdkdGMnIChodHRwczovL2dpdC5x
ZW11Lm9yZy9naXQvZHRjLmdpdCkgdW5yZWdpc3RlcmVkIGZvciBwYXRoICdkdGMnCm1ha2VbMV06
ICoqKiBbL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXFmOF9rZG9nL3NyYy9kb2NrZXItc3Jj
LjIwMTktMTItMDktMTQuMjIuMTcuMTcwMThdIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJl
Y3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1xZjhfa2RvZy9zcmMnCm1ha2U6ICoq
KiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICA0bTI2LjQ4
MnMKdXNlciAgICAwbTIuMjc1cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEyMDkxMTA3NTkuMzUyMjctMS1zdGVmYW5oYUByZWRoYXQu
Y29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


