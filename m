Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4853C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34EC206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34EC206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQgR-0005cC-Qp
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTQbb-0003gA-F4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTQZe-0005w8-51
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:48:58 -0400
Resent-Date: Tue, 28 Apr 2020 09:48:58 -0400
Resent-Message-Id: <E1jTQZe-0005w8-51@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTQWK-0003ef-Mk; Tue, 28 Apr 2020 09:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588081406; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mJvjVLx9IbfmLjPxhtah/J/W0bioJbN9KCewE/6ntVt7ocbcyTk/vC20oMqZ8X6mQInxyn0N/6tPXyLTmOlAdmRfSGbVmjJwCnCwqZj5+11Hdngsa0WV/wO6e+c7UpzLNUlBiomEYOTRz/Bs7rJwWOwNyq07fGwK3LdKvbu6U78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588081406;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SUVFi8TKmATYx3prLAQYgggz3a1u2Bs4dXORmkhPva0=; 
 b=F6BnAGJdEWB80sCM9/FtVFCuwEHmKZOX82qlu0yqeTxXLQF0tH1LolikJtVVbuhp6J6nofN2z4D7oPPWNkkD34DeqXT6mO91V6iz+4yFKIgH1mKo9rcguADlBWf4DeymTnIWPaoENnZzPWFRrNGzQHx97AvnyiCOoJ2piJb9DmQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588081405426361.0576464259759;
 Tue, 28 Apr 2020 06:43:25 -0700 (PDT)
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Message-ID: <158808140424.30407.602092042167419410@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Tue, 28 Apr 2020 06:43:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:39:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODEzMjYyOS43OTY3
NTMtMS1tcmVpdHpAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEJVSUxEICAgcGMtYmlvcy9v
cHRpb25yb20vcHZoLnJhdwogIFNJR04gICAgcGMtYmlvcy9vcHRpb25yb20vcHZoLmJpbgovdG1w
L3FlbXUtdGVzdC9zcmMvcWVtdS1pbWcuYzogSW4gZnVuY3Rpb24gJ2ltZ19jb21taXQnOgovdG1w
L3FlbXUtdGVzdC9zcmMvcWVtdS1pbWcuYzoxMDcxOjk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJh
dGlvbiBvZiBmdW5jdGlvbiAnYmxrX25ld193aXRoX2JzJyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5j
dGlvbi1kZWNsYXJhdGlvbl0KICAgICAgICAgb2xkX2JhY2tpbmdfYmxrID0gYmxrX25ld193aXRo
X2JzKGJzLCBCTEtfUEVSTV9XUklURSwgQkxLX1BFUk1fQUxMLAogICAgICAgICBeCi90bXAvcWVt
dS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6OTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFy
YXRpb24gb2YgJ2Jsa19uZXdfd2l0aF9icycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAv
cWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6MjU6IGVycm9yOiBhc3NpZ25tZW50IG1ha2Vz
IHBvaW50ZXIgZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0IFstV2Vycm9yXQogICAgICAgICBv
bGRfYmFja2luZ19ibGsgPSBibGtfbmV3X3dpdGhfYnMoYnMsIEJMS19QRVJNX1dSSVRFLCBCTEtf
UEVSTV9BTEwsCiAgICAgICAgICAgICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJl
aW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbcWVtdS1pbWcub10gRXJyb3IgMQptYWtl
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVj
ZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2
NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUs
IGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICct
bicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0y
ZDMyZGE4NTMzMWM0ZDUxYjQ2MzIyNjIzNjk1ODZkMScsICctdScsICcxMDAzJywgJy0tc2VjdXJp
dHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNU
PScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0x
NCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElS
PS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2Nr
ZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1tdHZxNXhrNS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTI4LTA5LjQwLjI3LjEyNzUz
Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4n
LCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9
LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0yZDMyZGE4NTMzMWM0ZDUxYjQ2
MzIyNjIzNjk1ODZkMQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTog
TGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1tdHZxNXhrNS9z
cmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJl
YWwgICAgMm01OC4wMjhzCnVzZXIgICAgMG04LjM5M3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI4MTMyNjI5Ljc5Njc1My0xLW1y
ZWl0ekByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

