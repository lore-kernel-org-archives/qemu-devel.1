Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E1C2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6162A20776
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 19:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6162A20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPX6e-0003y5-Gv
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 15:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jPX5m-0003XF-Dv
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jPX5k-0005Z6-8b
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:56:01 -0400
Resent-Date: Fri, 17 Apr 2020 15:56:01 -0400
Resent-Message-Id: <E1jPX5k-0005Z6-8b@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jPX5i-0005SM-37
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 15:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587153347; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jwYOCK2I79yzns6et5VESkOPHTwNo+/l0w7uTXBSfJJZDdCjhHuxAJQJyIVfknUhRJ5LD54HCbsM1979+V2kTVNRrrWf9jYdcsyFYjCnIY/1WhDEgtZMSc3o1Ud/1Oe0P54CxNJG6kpCjtYP/3fwo90s0/+GlstaI5rC18SEves=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587153347;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=674UmRMmK8e2q72Ov4fKTYLn5h/K+eulw8B0Z8zaWnk=; 
 b=GwOIwYAt5KBLmHE2ZMdVVfkBmWaVVxUyV25P/eV425bXHfj015h/RC5VDOn+CFqNSLSjuaiiBNr+jRnwGPVwzYZqus6DhFiDNQ9fSSWdOJSHa+GvMhmfA5gd1uGqVPOirlhokRLBranawydFZZw/gMBQeP8RMs7MV1y2R22j3ic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587153344297249.03684046992691;
 Fri, 17 Apr 2020 12:55:44 -0700 (PDT)
In-Reply-To: <1587148169-173268-1-git-send-email-fnu.vikram@xilinx.com>
Subject: Re: [[PATCH v2 0/4] Introduce Xlnx ZynqMP CAN controller for QEMU
Message-ID: <158715334271.22793.15278954676283700830@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fnu.vikram@xilinx.com
Date: Fri, 17 Apr 2020 12:55:44 -0700 (PDT)
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
Cc: francisco.iglesias@xilinx.com, jasowang@redhat.com, fnu.vikram@xilinx.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg3MTQ4MTY5LTE3MzI2OC0x
LWdpdC1zZW5kLWVtYWlsLWZudS52aWtyYW1AeGlsaW54LmNvbS8KCgoKSGksCgpUaGlzIHNlcmll
cyBmYWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdl
LWNlbnRvczcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9z
NyBTSE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgdGVzdHMvcXRlc3QvY2Ryb20tdGVzdC5vCiAgQ0MgICAgICB0ZXN0X2FfZjMyX3pfaTMy
X3J4Lm8KICBDQyAgICAgIHRlc3RzL3F0ZXN0L2RldmljZS1pbnRyb3NwZWN0LXRlc3QubwovdG1w
L3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QveGxueC1jYW4tdGVzdC5jOjI3OjI0OiBmYXRhbCBl
cnJvcjogcWVtdS9vc2RlcC5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSAi
cWVtdS9vc2RlcC5oIgogICAgICAgICAgICAgICAgICAgICAgICBeCmNvbXBpbGF0aW9uIHRlcm1p
bmF0ZWQuCi0tLQogIENDICAgICAgdGVzdF9hX2YzMl96X2YxNi5vCiAgQ0MgICAgICB0ZXN0cy9x
dGVzdC9xbXAtY21kLXRlc3QubwogIENDICAgICAgdGVzdHMvcXRlc3QvcW9tLXRlc3QubwptYWtl
OiAqKiogW3Rlc3RzL3F0ZXN0L3hsbngtY2FuLXRlc3RdIEVycm9yIDEKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIHRlc3RfYV9mMzJfel9mNjQubwog
IENDICAgICAgdGVzdF9hX2YzMl96X2V4dEY4MC5vCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vz
c0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1h
bmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUu
aW5zdGFuY2UudXVpZD1hNTM5NGMxNDgxYmM0NWE4YTVjNDk4MzA0MzI5OTM1ZScsICctdScsICcx
MDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1l
JywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAn
Vj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICct
ZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC02Zm10cTM2cC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTE3
LTE1LjUyLjUwLjE0MjY3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zh
ci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0
YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hNTM5
NGMxNDgxYmM0NWE4YTVjNDk4MzA0MzI5OTM1ZQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVy
cm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC02Zm10cTM2cC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRv
czddIEVycm9yIDIKCnJlYWwgICAgMm01My4xNDVzCnVzZXIgICAgMG04LjU1M3MKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1ODcxNDgxNjkt
MTczMjY4LTEtZ2l0LXNlbmQtZW1haWwtZm51LnZpa3JhbUB4aWxpbnguY29tL3Rlc3RpbmcuZG9j
a2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

