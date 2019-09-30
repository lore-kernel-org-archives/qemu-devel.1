Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BC6C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706922168B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 17:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706922168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEzM1-0007X9-Id
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 13:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iEzLC-0006pQ-4u
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iEzL9-0000PV-Vk
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 13:20:05 -0400
Resent-Date: Mon, 30 Sep 2019 13:20:04 -0400
Resent-Message-Id: <E1iEzL9-0000PV-Vk@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iEzL9-0000Ou-O3; Mon, 30 Sep 2019 13:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569863967; cv=none; d=zoho.com; s=zohoarc; 
 b=Yg3N6bcNKhInCXqTjEqgY3r0PWSSx/LyliEPmKXoG/RxDc+5KKPLcbgLzLI7EGYTcIyBKGTMAQaQjen5UycGambU5FIzGXf3187bNfGEbrZRcHPVYQJZfyDSTXCInLTGfBiuT/lpXXDf/sAIgLvMNqvzw4TxN7hgyLXwL3zwPkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569863967;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=quW1jKyQbrCHORj2wrrXVoQbtI9aPT7ArqeZkSzySLM=; 
 b=Pd7uqHNXxeMUqKdw1+vF2S1fvqJpDzFFYdhnNrNSoMeAsHb8YJHKQ7kKdYDybLysNdE8PNdl6ZIqqGTh13/+8X93ZKqJ0mU74H7IbQ/d1dvYc1oIAUYbp/L0WgqE1TGacB4c3ennLbHgmZ7UwpbsVo4mSLElKyhjdde6L9rxq5E=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569863965488316.47336312751486;
 Mon, 30 Sep 2019 10:19:25 -0700 (PDT)
Subject: Re: [PATCH] hw/isa: Introduce a CONFIG_ISA_SUPERIO switch for
 isa-superio.c
In-Reply-To: <20190930150436.18162-1-thuth@redhat.com>
Message-ID: <156986396389.27524.5625558969416986785@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Mon, 30 Sep 2019 10:19:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: mst@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 arikalo@wavecomp.com, hpoussin@reactos.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkzMDE1MDQzNi4xODE2
Mi0xLXRodXRoQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkzMDE1MDQzNi4x
ODE2Mi0xLXRodXRoQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


