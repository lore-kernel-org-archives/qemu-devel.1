Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D77CECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC9C20659
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 08:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC9C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJvwe-0001z7-9q
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 04:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJvvq-0001Z5-LO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJvvo-0005xJ-UU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 04:42:22 -0400
Resent-Date: Mon, 14 Oct 2019 04:42:22 -0400
Resent-Message-Id: <E1iJvvo-0005xJ-UU@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJvvo-0005wO-NA; Mon, 14 Oct 2019 04:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571042511; cv=none; d=zoho.com; s=zohoarc; 
 b=KMsJcEXD1kWQlsB7B9sdt2olp6Yw+f2FvqMcFzYC7kstW2PZWdyEylc+sNuYamVU+YS2DGCm4gBuwOSIK5sEKvkZJdkIih7ly3Ff5KsTziCm8+B3YRP2XQIpbvf2jWZm/LP3wM/r3bY0JqdcpnPmdNCK6GYYZ4Wc30fEPSRI4wM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571042511;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=GwlAqQkXnXbsdJEa8FIFmrLpWcmYSBMi45OHiDHcrS4=; 
 b=ZqnGTsyUAyLTQMPYT6fh+SFVrYiu7nZcvZu6mm+R+cgUnARio7sxjHD23iKuLu2OCcrS1ngH/H1Ag/5zsEt41W5S1EL3KDB5nOfMIuoTwC66sFFqNiqHU44gwO3M09hkT5DAhNlRZg8BjW7269U4LNeNWJdeepLbOSMiH6Lj/6Y=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571042508494902.5391177133597;
 Mon, 14 Oct 2019 01:41:48 -0700 (PDT)
In-Reply-To: <20191014081545.29694-1-berto@igalia.com>
Subject: Re: [PATCH v2] block: Reject misaligned write requests with
 BDRV_REQ_NO_FALLBACK
Message-ID: <157104250708.31500.17641159477782057221@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Mon, 14 Oct 2019 01:41:48 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: kwolf@redhat.com, anton.nefedov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNDA4MTU0NS4yOTY5
NC0xLWJlcnRvQGlnYWxpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGJsb2Nr
L3FlZC10YWJsZS5vCiAgQ0MgICAgICBibG9jay9xZWQtY2x1c3Rlci5vCiAgQ0MgICAgICBibG9j
ay9xZWQtY2hlY2subwptYWtlOiAqKiogW01ha2VmaWxlOjk5NDogZG9jcy9pbnRlcm9wL2luZGV4
Lmh0bWxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
ICBDQyAgICAgIGJsb2NrL3ZoZHgubwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6
Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vz
cy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAn
cnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD01ZTNjOWNlYjBkMGU0OGYx
YjdmZGFlZTMyYmZiZDJjMicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2Nv
bXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRS
QV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJV
Rz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hl
JywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90
bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXRfc2d4cHp0
L3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMTQtMDQuMzkuNTMuMTY2NTk6L3Zhci90bXAvcWVtdTp6
LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScg
cmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9NWUzYzljZWIwZDBlNDhmMWI3ZmRhZWUzMmJmYmQyYzIKbWFr
ZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5
IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdF9zZ3hwenQvc3JjJwptYWtlOiAqKiogW2Rv
Y2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMW01My42OTdzCnVz
ZXIgICAgMG03LjQxMXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkxMDE0MDgxNTQ1LjI5Njk0LTEtYmVydG9AaWdhbGlhLmNvbS90ZXN0
aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


