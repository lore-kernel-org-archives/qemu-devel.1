Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D652C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96C0206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96C0206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJgcW-0004Q1-Vt
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJgbZ-0003wc-5i
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJgbX-0003JB-UN
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:52:41 -0400
Resent-Date: Wed, 01 Apr 2020 12:52:41 -0400
Resent-Message-Id: <E1jJgbX-0003JB-UN@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJgbU-000380-Uy; Wed, 01 Apr 2020 12:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585759934; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AwRZizh/8nOHjjv1ipZI36/xuy6zIdu+yef4STxX0ppShh78820wMI5Q5NGcEho3qeiAHHT9L06TeyuUAADWyT+xrUgsyTgCQq75jDU38sP8VP5s6DIeS8wXEk/qz0YUwTpz5yGJw2+z1jLB2F/vHjTxZji/bbHtCVXaYfcQCBM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585759934;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SIUjVtc4UjOTTL2OZ7sCvDwQPMo8UgkL5l2pICGwvaY=; 
 b=TFKhtWtZYOKf5revZSnJywfvcco49FYW1d14zVoor9y1c7iLgQAYm85r9BfGtm3/aHja6cUlZUm9rcgnzB77hIjbNIcJmTGuoQRu1EaMeFkjR1Jvr5m8/9nOeFHKhCAiqdDH+Jep/TFW4EyifdmL+757V+CmZf2JxMi7TteLPYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585759929135764.7914619434102;
 Wed, 1 Apr 2020 09:52:09 -0700 (PDT)
In-Reply-To: <20200401150112.9557-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 0/6] nbd: reduce max_block restrictions
Message-ID: <158575992796.20436.13965435168851617205@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 1 Apr 2020 09:52:09 -0700 (PDT)
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMTE1MDExMi45NTU3
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi0tLSAvdG1wL3FlbXUt
dGVzdC9zcmMvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1MS5vdXQgICAgICAgMjAyMC0wNC0wMSAxNTow
MToxOS4wMDAwMDAwMDAgKzAwMDAKKysrIC90bXAvcWVtdS10ZXN0L2J1aWxkL3Rlc3RzL3FlbXUt
aW90ZXN0cy8yNTEub3V0LmJhZCAyMDIwLTA0LTAxIDE2OjQ5OjM2LjU0MjA5NzUzNCArMDAwMApA
QCAtMTgsMjYgKzE4LDE2IEBACiBxZW11LWltZzogd2FybmluZzogZXJyb3Igd2hpbGUgcmVhZGlu
ZyBvZmZzZXQgcmVhZF9mYWlsX29mZnNldF84OiBJbnB1dC9vdXRwdXQgZXJyb3IKIHFlbXUtaW1n
OiB3YXJuaW5nOiBlcnJvciB3aGlsZSByZWFkaW5nIG9mZnNldCByZWFkX2ZhaWxfb2Zmc2V0Xzk6
IElucHV0L291dHB1dCBlcnJvcgogCi13cm90ZSA1MTIvNTEyIGJ5dGVzIGF0IG9mZnNldCByZWFk
X2ZhaWxfb2Zmc2V0XzAKLTUxMiBieXRlcywgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZWVkvc2Vj
IGFuZCBYWFggb3BzL3NlYykKLS0tCk5vdCBydW46IDI1OQpGYWlsdXJlczogMDMzIDAzNCAxNTQg
MTc3IDI1MQpGYWlsZWQgNSBvZiAxMTYgaW90ZXN0cwptYWtlOiAqKiogW2NoZWNrLXRlc3RzL2No
ZWNrLWJsb2NrLnNoXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCiAgVEVTVCAgICBjaGVjay1xdGVzdC1hYXJjaDY0OiB0ZXN0cy9xdGVzdC90ZXN0LWht
cAogIFRFU1QgICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvcW9zLXRlc3QKLS0t
CiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNh
bGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4n
LCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTA2N2E4YzFkMWQwMDQwM2JhODQ0
NzMxNTA5NWQ2Mzg4JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11
bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NP
TkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScs
ICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywg
Jy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAv
Y2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTdyZ3kyeWZfL3Ny
Yy9kb2NrZXItc3JjLjIwMjAtMDQtMDEtMTIuMzcuMTguMjg0OTA6L3Zhci90bXAvcWVtdTp6LHJv
JywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJl
dHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20u
cWVtdS5pbnN0YW5jZS51dWlkPTA2N2E4YzFkMWQwMDQwM2JhODQ0NzMxNTA5NWQ2Mzg4Cm1ha2Vb
MV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBg
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTdyZ3kyeWZfL3NyYycKbWFrZTogKioqIFtkb2Nr
ZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxNG00OS4zMjhzCnVz
ZXIgICAgMG03Ljg5OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMjAwNDAxMTUwMTEyLjk1NTctMS12c2VtZW50c292QHZpcnR1b3p6by5j
b20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

