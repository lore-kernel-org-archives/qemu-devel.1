Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A4BC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713A120768
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713A120768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7ui-0008VJ-KF
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49396)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM7u4-0007y9-7B
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM7u3-0003Wh-2J
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:25:52 -0400
Resent-Date: Wed, 08 Apr 2020 06:25:52 -0400
Resent-Message-Id: <E1jM7u3-0003Wh-2J@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM7u0-0003Ve-G0; Wed, 08 Apr 2020 06:25:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586341533; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=P49+lGOpU2N5ZNhRM89wUdjC2pPVOXtmx6vLX6L2N0MsVCjuqLW/McVjhnM3XyRTPmqH6umzBgkboCfzeFH9XySPCKk6jetFiyXOQZoWWhYB+ECB/+zV/1VYLQ/JR2t2A0KGw13fptutWxsWS8r+mBfqFHs3ZadBs6wwxWegrkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586341533;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lRACiBCbdegW0GyEvdDPEoYXXGw/W+ugONw1bu5IHmM=; 
 b=UnMY/sqHNR8DJpLGd4q3fZsgRGpsYzVHqi2pojESQBbz6xdMlkBMyAdnIXqrOXu45FRvCeU9llG1JFtAwZ4iOko1SxgwBjK8ABTQyZutrN5jwztuBYujuSENeOTA8Ph+KKBr2zsYLnWCsHoQ9PEWVK3YbMSSl106LoW3lfGQmIs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586341532568957.6150182991196;
 Wed, 8 Apr 2020 03:25:32 -0700 (PDT)
In-Reply-To: <20200408093051.9893-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0? 0/9] block/io: safer inc/dec in_flight sections
Message-ID: <158634153097.16886.10882883810164250044@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 8 Apr 2020 03:25:32 -0700 (PDT)
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
aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9j
a2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAg
ICBody9hY3BpL2NwdV9ob3RwbHVnLm8KICBDQyAgICAgIGh3L2FjcGkvbWVtb3J5X2hvdHBsdWcu
bwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svaW8uYzogSW4gZnVuY3Rpb24gJ2JkcnZfY29fcGRp
c2NhcmQnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svaW8uYzozMjM2OjIzOiBlcnJvcjogdW51
c2VkIHZhcmlhYmxlICdicycgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQogICAgIEJsb2NrRHJp
dmVyU3RhdGUgKmJzID0gY2hpbGQtPmJzOwogICAgICAgICAgICAgICAgICAgICAgIF5+CmNjMTog
YWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11
LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogYmxvY2svaW8ub10gRXJyb3IgMQptYWtlOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwg
bGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxt
b2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2Nr
ZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0wYTNjNDZlODI4
ZjU0YzdlYWNjODU3MzNmMDg2ZTA5MycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0Jywg
J3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScs
ICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScs
ICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTl6
bnE2OWlpL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMDgtMDYuMjMuMTguMTIzMzQ6L3Zhci90bXAv
cWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWlu
Z3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxh
YmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MGEzYzQ2ZTgyOGY1NGM3ZWFjYzg1NzMzZjA4NmUw
OTMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOXpucTY5aWkvc3JjJwptYWtlOiAq
KiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm0xMi4z
OTlzCnVzZXIgICAgMG04LjMyNnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDA4MDkzMDUxLjk4OTMtMS12c2VtZW50c292QHZpcnR1
b3p6by5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

