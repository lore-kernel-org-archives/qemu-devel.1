Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79794C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5019820836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 18:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5019820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6I7b-00045n-Ge
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 13:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j6I6y-0003Z9-4x
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j6I6w-0001AO-Lk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 13:05:43 -0500
Resent-Date: Mon, 24 Feb 2020 13:05:43 -0500
Resent-Message-Id: <E1j6I6w-0001AO-Lk@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j6I6w-00018T-DX; Mon, 24 Feb 2020 13:05:42 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582567524; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ltQeTbgIe1Vl9IIE2HC7aLDxK7Vdm/WPOWT0VqBM2tqR3GoPKH1GTSMAM8jqwWyVpCfn9EBunhj3Xvtd82mK9KGBL1AsPTrPDJCJ1HAjQVfrNfvDXIqRCJS2C9U/gSkBUaPQoTh+l+DO1ou6EeEG61Fyj5d1E/5gkWoxIJpdQws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582567524;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ruRV2lr32SAup4GlNyf5to+wJipVhbX9Aee+QhEGQNc=; 
 b=PXqTLJQvaPeM4f6FMMTUjrauLTqlr5widtWX53sNyInWrnOMCCDulaFjh7yK+f0yer/ciMxcT98S10YbWfDKGoZYOCIZf1BJiqTXCEEHb5Nsw5VutRR0TJrNY7Ok6AyT7MHh0Z7xOPn/CE3b7pjkVGIRMoQfAq19K981ejfPlVs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582567520798191.08967717869768;
 Mon, 24 Feb 2020 10:05:20 -0800 (PST)
In-Reply-To: <20200224170301.246623-1-damien.hedde@greensocs.com>
Subject: Re: [PATCH v7 0/9] Clock framework API
Message-ID: <158256751894.10132.1410284959926708983@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: damien.hedde@greensocs.com
Date: Mon, 24 Feb 2020 10:05:20 -0800 (PST)
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIyNDE3MDMwMS4yNDY2
MjMtMS1kYW1pZW4uaGVkZGVAZ3JlZW5zb2NzLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtl
IGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
bWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgYmxvY2svYmxrZGVidWcubwogIENDICAgICAgYmxvY2svYmxrdmVyaWZ5Lm8KCldhcm5p
bmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0L3NyYy9kb2NzL2RldmVsL2Nsb2Nr
cy5yc3Q6NjM6VW5leHBlY3RlZCBpbmRlbnRhdGlvbi4KICBDQyAgICAgIGJsb2NrL2Jsa3JlcGxh
eS5vCiAgQ0MgICAgICBibG9jay9wYXJhbGxlbHMubwotLS0KICBDQyAgICAgIGJsb2NrL2Jsb2Nr
LWJhY2tlbmQubwogIENDICAgICAgYmxvY2svc25hcHNob3QubwogIENDICAgICAgYmxvY2svcWFw
aS5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA2MTogZG9jcy9kZXZlbC9pbmRleC5odG1sXSBFcnJv
ciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAo
bW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHki
LCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3Io
cmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydz
dWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5j
ZS51dWlkPWZiY2U2NmVlOWY0ODQyN2NiZDIxY2YyZmVjMzY5ZDQ5JywgJy11JywgJzEwMDEnLCAn
LS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFS
R0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICct
ZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NB
Q0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC11OGhtbXoyZS9zcmMvZG9ja2VyLXNyYy4yMDIwLTAyLTI0LTEzLjAzLjEz
LjE2MzY5Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11
L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZp
bHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWZiY2U2NmVlOWY0ODQy
N2NiZDIxY2YyZmVjMzY5ZDQ5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtl
WzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXU4aG1t
ejJlL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAy
CgpyZWFsICAgIDJtNS42NDZzCnVzZXIgICAgMG04LjUwMnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjI0MTcwMzAxLjI0NjYyMy0x
LWRhbWllbi5oZWRkZUBncmVlbnNvY3MuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

