Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B365C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C32620768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C32620768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7s3-0006CX-FP
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM7rR-0005dr-1h
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM7rP-0002D4-Sl
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:23:08 -0400
Resent-Date: Wed, 08 Apr 2020 06:23:08 -0400
Resent-Message-Id: <E1jM7rP-0002D4-Sl@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM7rN-0002Ax-0D; Wed, 08 Apr 2020 06:23:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586341366; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UKZelOQf9eyJY9xNDJKcYwq5StX4RpYs+qlAqAng+YTpjQBbgzCsMQfEydUz6P5Ksvzviyy0O1IzdbZvub2i+HGSpZiZS3AJwCy5tiwnnM6WRrta8ZvV/ImDS49liyMzOUkfD49mw4wfTDQp83m1TTk9l50t7UFsB0xdUhfAgMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586341366;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=CgzGaX/5FvFV/WEjGz/Z4TJRNMDWMxDO3VmfL6bJeyA=; 
 b=GYitg38Nl0GBXBAIDT9kGRoAHdeDqme0xGQYOHoSErykLzwwYqylTF7gc7DexJ9f/eKxPitiN0CF8n9oBYMb8r4suP8o+lUocWXJ3twmT7VUESYKZGzl3pR2ZJUpfVeSBzDgpV/g1O18EYbFTC2Gasyhw4ktwUQ8XAOcr/WhxBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586341365140229.98528806752313;
 Wed, 8 Apr 2020 03:22:45 -0700 (PDT)
In-Reply-To: <20200408093051.9893-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections
Message-ID: <158634136362.16886.16896112748733362910@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 8 Apr 2020 03:22:45 -0700 (PDT)
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODA5MzA1MS45ODkz
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBjcnlw
dG8vdGxzc2Vzc2lvbi5vCiAgQ0MgICAgICBjcnlwdG8vc2VjcmV0Lm8KL3RtcC9xZW11LXRlc3Qv
c3JjL2Jsb2NrL2lvLmM6IEluIGZ1bmN0aW9uICdiZHJ2X2NvX3BkaXNjYXJkJzoKL3RtcC9xZW11
LXRlc3Qvc3JjL2Jsb2NrL2lvLmM6MzIzNjoyMzogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSAnYnMn
IFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0KICAgICBCbG9ja0RyaXZlclN0YXRlICpicyA9IGNo
aWxkLT5iczsKICAgICAgICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5n
IHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbYmxvY2svaW8ub10gRXJyb3IgMQptYWtlOiAq
KiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50
IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQs
IGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1hMGYx
ZTQxY2MwYTc0YmQ3YTM0MWUxN2E2ZTM3NGI5MScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92
YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC1qemZkMzJmOS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTA4LTA2LjIwLjMwLjU3MDU6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWEwZjFlNDFjYzBhNzRiZDdhMzQxZTE3
YTZlMzc0YjkxCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWp6ZmQzMmY5L3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAybTEzLjk5M3MKdXNlciAgICAwbTguMjI5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDgwOTMwNTEuOTg5My0xLXZzZW1lbnRz
b3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

