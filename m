Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82EAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CACF206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CACF206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7Ir-00061i-UX
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj7I8-0005Al-CR; Wed, 10 Jun 2020 16:25:44 -0400
Resent-Date: Wed, 10 Jun 2020 16:25:44 -0400
Resent-Message-Id: <E1jj7I8-0005Al-CR@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21754)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj7I6-0004y5-SH; Wed, 10 Jun 2020 16:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591820724; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j4Jr+NgPO8um44v8HrUgcwq25Ojz1cf8gt0r/ckHbzxGHZzsRcBMsFcn7lOE/CVW86GYzy0Vqh09FmfJgw0W94HVApf9RSBKZSXMxlY2YL1rmBBRnSA8MXmccjkb36vlK6Ks/G7OyHBqBgCMiFUeNsCkOiqkd9EqcqMYK0Joa+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591820724;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=U+IbpKBWrbUElvajj2gbWiiGXQ2kM+H0RPs6upQpFBc=; 
 b=D7kgS4nidF4ZfIiTPongIf5p+yMj0pwpo9z4/LsQIrGySgy/PhJOtli53MS1lc+5lHYWC8+WCCT4YAu7L8dmUAhVqwA6hiLUcZuRhM0qyL6cIIwCKYlhgR2iazZUEJMCGO6KOloNaBto0jyZp2Mqz/dYwggVGRMe1SMVCPcbuYk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591820721376185.7963486919756;
 Wed, 10 Jun 2020 13:25:21 -0700 (PDT)
Message-ID: <159182071987.21115.12956552187250814381@45ef0f9c86ae>
In-Reply-To: <20200610182305.3462-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 0/4] nbd: reduce max_block restrictions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 10 Jun 2020 13:25:21 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 16:25:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMDE4MjMwNS4zNDYy
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi0tLSAvdG1wL3FlbXUt
dGVzdC9zcmMvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1MS5vdXQgICAgICAgMjAyMC0wNi0xMCAxODo1
NjozNi4wMDAwMDAwMDAgKzAwMDAKKysrIC90bXAvcWVtdS10ZXN0L2J1aWxkL3Rlc3RzL3FlbXUt
aW90ZXN0cy8yNTEub3V0LmJhZCAyMDIwLTA2LTEwIDIwOjI0OjQwLjAwNzQxMjc5MCArMDAwMApA
QCAtMTgsMjYgKzE4LDE2IEBACiBxZW11LWltZzogd2FybmluZzogZXJyb3Igd2hpbGUgcmVhZGlu
ZyBvZmZzZXQgcmVhZF9mYWlsX29mZnNldF84OiBJbnB1dC9vdXRwdXQgZXJyb3IKIHFlbXUtaW1n
OiB3YXJuaW5nOiBlcnJvciB3aGlsZSByZWFkaW5nIG9mZnNldCByZWFkX2ZhaWxfb2Zmc2V0Xzk6
IElucHV0L291dHB1dCBlcnJvcgogCi13cm90ZSA1MTIvNTEyIGJ5dGVzIGF0IG9mZnNldCByZWFk
X2ZhaWxfb2Zmc2V0XzAKLTUxMiBieXRlcywgWCBvcHM7IFhYOlhYOlhYLlggKFhYWCBZWVkvc2Vj
IGFuZCBYWFggb3BzL3NlYykKLS0tCk5vdCBydW46IDI1OQpGYWlsdXJlczogMDMzIDAzNCAxNTQg
MTc3IDI1MQpGYWlsZWQgNSBvZiAxMTkgaW90ZXN0cwptYWtlOiAqKiogW2NoZWNrLXRlc3RzL2No
ZWNrLWJsb2NrLnNoXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCiAgVEVTVCAgICBjaGVjay1xdGVzdC1hYXJjaDY0OiB0ZXN0cy9xdGVzdC9xb3MtdGVz
dApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD1mYWExZWRmYzY5Njg0NDIyYjMxNDM0M2NmMzAxNzRhNScsICct
dScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRj
aGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12Jywg
Jy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC05ZWd1cnk5cS9zcmMvZG9ja2VyLXNyYy4yMDIw
LTA2LTEwLTE2LjEyLjA3LjExNTg0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcn
LCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBl
eGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVp
ZD1mYWExZWRmYzY5Njg0NDIyYjMxNDM0M2NmMzAxNzRhNQptYWtlWzFdOiAqKiogW2RvY2tlci1y
dW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC05ZWd1cnk5cS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNr
QGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTNtMTIuMjk4cwp1c2VyICAgIDBtOC42NzBzCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDYxMDE4MjMwNS4zNDYyLTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuZG9ja2Vy
LXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

