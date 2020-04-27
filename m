Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC0C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F75A206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 18:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F75A206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT8D4-0005bF-OJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 14:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT8CJ-0004bc-8u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jT8CH-0006s9-WC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:09:38 -0400
Resent-Date: Mon, 27 Apr 2020 14:09:38 -0400
Resent-Message-Id: <E1jT8CH-0006s9-WC@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jT8CH-0006rz-Fl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 14:09:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588010966; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MyRGT2HxpP8R0zQGjVKYbWpF3/0ZJ6kVzyZQMPDgX0A1TikDtUwRTbaBbAzLqxO5LJ2tGGy3oDzCb9f2YTStwbuSOtD57NiGPJyyZ/Bjerk5KYMofJ5Z1x+hjhIUmQkWh9ko73sj2uoxrFmvLqT+uQ5d+rPMgurteD8Q12UctxY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588010966;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=3/Ews2PqaNtYwbHUV8XYde2yLGtFJc/Fgh7IFmewNn0=; 
 b=Hka3FKJQO5iy42SIeAWQW8X4drZ5t8YMXhwUv6QK5xSbn2pL4z9on3WegsMz9Xeyja7yL9HLzIRmxYtP+JsonTdbG3zcFxLP0IxHoar2+hfdMlYPxVxPO+bTfQY9X2vgsaUAHKlZz/S8+bbMK88tKHNm3Fse80b6gBWt+O4BiLc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588010964065201.61126104273092;
 Mon, 27 Apr 2020 11:09:24 -0700 (PDT)
In-Reply-To: <20200427152148.283771-1-andrew@daynix.com>
Subject: Re: [PATCH] e1000e: Added ICR clearing by corresponding IMS bit.
Message-ID: <158801096303.15667.2297558445511566197@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrew@daynix.com
Date: Mon, 27 Apr 2020 11:09:24 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 13:53:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyNzE1MjE0OC4yODM3
NzEtMS1hbmRyZXdAZGF5bml4LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90ZXN0LXFj
b3cyOiAxNTgKc29ja2V0X2FjY2VwdCBmYWlsZWQ6IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZh
aWxhYmxlCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5j
OjMwMTpxdGVzdF9pbml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNzZXJ0aW9uIGZhaWxlZDog
KHMtPmZkID49IDAgJiYgcy0+cW1wX2ZkID49IDApCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9x
dGVzdC9saWJxdGVzdC5jOjE2Njoga2lsbF9xZW11KCkgdHJpZWQgdG8gdGVybWluYXRlIFFFTVUg
cHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhwZWN0ZWQgMCkKRVJST1Ig
LSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0
LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVk
OiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1h
YXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE1OQpDb3VsZCBub3QgYWNjZXNzIEtWTSBrZXJuZWwg
bW9kdWxlOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD02NGU0NWY0MWIxOWI0ZWFlYmUyMGRlYmNlZTZmN2YzNicsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1xM3E2dXJuNi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0
LTI3LTEzLjU2LjM2Ljg1ODk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTY0
ZTQ1ZjQxYjE5YjRlYWViZTIwZGViY2VlNmY3ZjM2Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLXEzcTZ1cm42L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2Vu
dG9zN10gRXJyb3IgMgoKcmVhbCAgICAxMm00Ni45NThzCnVzZXIgICAgMG05LjEzOXMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI3
MTUyMTQ4LjI4Mzc3MS0xLWFuZHJld0BkYXluaXguY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNl
bnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5
IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFj
ayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

