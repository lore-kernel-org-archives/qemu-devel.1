Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5206FC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244352076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244352076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYGR-0006NH-A9
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRYFo-0005p8-TH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRYFo-0003sj-D9
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:34:44 -0400
Resent-Date: Thu, 23 Apr 2020 05:34:44 -0400
Resent-Message-Id: <E1jRYFo-0003sj-D9@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRYFk-0003i5-Kb; Thu, 23 Apr 2020 05:34:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587634465; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kLB8eYIs24Svm9w+TUCYqeK1xdeSPAbKkszqvuq7KNJ5SR4ChyR+bJG7QV5ck6YEwLbSDulExz4vYaH42oDrMf0jyqhVwMaBxVHes9iK6Nnws4U5E6zZTM3zfYwslwMi2k3GUgurvGpH/ZjEhHpw+ZokLb5hOvACY4oycO78XMM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587634465;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4dUD7e/KfxW6eb9ttR9esGd+AT1SiWrjlpLujn4g91w=; 
 b=Q5zchtDEC6TWwwvWugQgBdi+WRIFpz8oWF9WaC9QeGBVRpD72a4Azm5qAyAVkrDS2uUHKGN7Fp9BaTcwIqs6mgn49ff44geTYyRh1LGhgepKeJi+mktEcmsjsTsYHbsYrCvcH0XmpkJHdBwsNiIbP5pFt+cUAaJjP1xBpUx1Gjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587634463565546.17772855945;
 Thu, 23 Apr 2020 02:34:23 -0700 (PDT)
In-Reply-To: <20200423090118.11199-1-geert+renesas@glider.be>
Subject: Re: [PATCH QEMU v2 0/5] Add a GPIO backend
Message-ID: <158763446157.4520.17561448359481961775@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: geert+renesas@glider.be
Date: Thu, 23 Apr 2020 02:34:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:13:42
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
Cc: peter.maydell@linaro.org, geert+renesas@glider.be, linus.walleij@linaro.org,
 magnus.damm@gmail.com, qemu-devel@nongnu.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 qemu-arm@nongnu.org, graf@amazon.com, pbonzini@redhat.com,
 bartekgola@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzA5MDExOC4xMTE5
OS0xLWdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQK
dGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2Fu
IHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3Jh
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKICBDQyAgICAgIGh3LzlwZnMvOXAtc3ludGgubwogIENDICAgICAgaHcvOXBmcy85cC1wcm94
eS5vCgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8u
Li9xZW11LW9wdGlvbnMuaHg6ODgxOlVuZXhwZWN0ZWQgaW5kZW50YXRpb24uCiAgQ0MgICAgICBo
dy85cGZzL3hlbi05cC1iYWNrZW5kLm8KCldhcm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAv
cWVtdS10ZXN0L3NyYy9kb2NzLy4uL3FlbXUtb3B0aW9ucy5oeDo4ODE6VW5leHBlY3RlZCBpbmRl
bnRhdGlvbi4KICBDQyAgICAgIGh3L2FjcGkvY29yZS5vCiAgQ0MgICAgICBody9hY3BpL3BpaXg0
Lm8KICBDQyAgICAgIGh3L2FjcGkvcGNpaHAubwogIENDICAgICAgaHcvYWNwaS9pY2g5Lm8KICBD
QyAgICAgIGh3L2FjcGkvdGNvLm8KbWFrZTogKioqIFtNYWtlZmlsZToxMTA0OiBkb2NzL3N5c3Rl
bS9pbmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTExNTogLmRvY3Nfc3lzdGVtX3FlbXUuMV9kb2Nz
X3N5c3RlbV9xZW11LWJsb2NrLWRyaXZlcnMuN19kb2NzX3N5c3RlbV9xZW11LWNwdS1tb2RlbHMu
Ny5zZW50aW5lbC5dIEVycm9yIDIKbWFrZTogKioqIERlbGV0aW5nIGZpbGUgJy5kb2NzX3N5c3Rl
bV9xZW11LjFfZG9jc19zeXN0ZW1fcWVtdS1ibG9jay1kcml2ZXJzLjdfZG9jc19zeXN0ZW1fcWVt
dS1jcHUtbW9kZWxzLjcuc2VudGluZWwuJwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFz
dCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1
bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJv
Y2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXIn
LCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD03OTk5MTEyOGQ4MDI0
MGYzODIyNzllMmMwNTlmNDNmMicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3Nl
Y2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0
bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJ
Uj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9j
a2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtYW1sZnMyNGUvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0yMy0wNS4yOS4zOC4yMjY2
MTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4n
LCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9
LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD03OTk5MTEyOGQ4MDI0MGYzODIy
NzllMmMwNTlmNDNmMgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTog
TGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1hbWxmczI0ZS9z
cmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3IgMgoKcmVh
bCAgICA0bTQzLjA1M3MKdXNlciAgICAwbTUuMTA2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjMwOTAxMTguMTExOTktMS1nZWVy
dCtyZW5lc2FzQGdsaWRlci5iZS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

