Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9551DC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE50221EC
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE50221EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTs92-0002ox-Gs
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTs7M-000144-8V
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTs7L-0006Qx-IK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:11:36 -0400
Resent-Date: Wed, 29 Apr 2020 15:11:35 -0400
Resent-Message-Id: <E1jTs7L-0006Qx-IK@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTs7I-0005nM-8D; Wed, 29 Apr 2020 15:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588187486; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iJ6EBm2Z/6RxyZDNB/MQOxQUOUM/RO/hlRNRM0yDH7SxUuss9SfR+N0nOWj0hLq9ItZzMf3cztAJefPWzExbegQeNxWTdeQkvxeu/+897b8cLgH/yqiZTdOXBUlX9r6g48q5Ws79AL7mtR/cB7IpX+b2/zuFW+nG5WXlC0vq2O0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588187486;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gV7GMETRTE6Z99Rg+xsIWsO4qBpkpVbHJlLq4B0CNik=; 
 b=I8PFP11myb72Lv3ZtS03mbw757xVMKFnO8TfaTA8PpoaZWvvKWSRauMXC9v+PPvc2Cd/60ano6Lt1a7sTSkrNoB9OhMCyIiFHFnCPsPKydSLzPBX2t0uDAJVK861RId6SzbwSBGJOGrXmDEVFMnOKp2yqp3UdnFO9Wg5U6qcN6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588187483471346.6162145878078;
 Wed, 29 Apr 2020 12:11:23 -0700 (PDT)
Message-ID: <158818748238.4471.9675447049802013413@45ef0f9c86ae>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
Subject: Re: [PATCH v2 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Wed, 29 Apr 2020 12:11:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:03:04
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyOTE0MTEyNi44NTE1
OS0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBC
VUlMRCAgIHBjLWJpb3Mvb3B0aW9ucm9tL2xpbnV4Ym9vdF9kbWEucmF3CiAgQlVJTEQgICBwYy1i
aW9zL29wdGlvbnJvbS9rdm12YXBpYy5yYXcKICBMSU5LICAgIHFlbXUtZWRpZAovdG1wL3FlbXUt
dGVzdC9zcmMvcWVtdS1pbWcuYzoxMDcxOjI3OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24gJ2Jsa19uZXdfd2l0aF9icycgaXMgaW52YWxpZCBpbiBDOTkgWy1XZXJyb3Is
LVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICAgICBvbGRfYmFja2luZ19ibGsg
PSBibGtfbmV3X3dpdGhfYnMoYnMsIEJMS19QRVJNX1dSSVRFLCBCTEtfUEVSTV9BTEwsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS1pbWcuYzoxMDcx
OjI3OiBlcnJvcjogdGhpcyBmdW5jdGlvbiBkZWNsYXJhdGlvbiBpcyBub3QgYSBwcm90b3R5cGUg
Wy1XZXJyb3IsLVdzdHJpY3QtcHJvdG90eXBlc10KL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1n
LmM6MTA3MToyNTogZXJyb3I6IGluY29tcGF0aWJsZSBpbnRlZ2VyIHRvIHBvaW50ZXIgY29udmVy
c2lvbiBhc3NpZ25pbmcgdG8gJ0Jsb2NrQmFja2VuZCAqJyAoYWthICdzdHJ1Y3QgQmxvY2tCYWNr
ZW5kIConKSBmcm9tICdpbnQnIFstV2Vycm9yLC1XaW50LWNvbnZlcnNpb25dCiAgICAgICAgb2xk
X2JhY2tpbmdfYmxrID0gYmxrX25ld193aXRoX2JzKGJzLCBCTEtfUEVSTV9XUklURSwgQkxLX1BF
Uk1fQUxMLAogICAgICAgICAgICAgICAgICAgICAgICBeIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KMyBlcnJvcnMgZ2VuZXJhdGVkLgotLS0KICBTSUdO
ICAgIHBjLWJpb3Mvb3B0aW9ucm9tL2xpbnV4Ym9vdC5iaW4KICBTSUdOICAgIHBjLWJpb3Mvb3B0
aW9ucm9tL2xpbnV4Ym9vdF9kbWEuYmluCiAgU0lHTiAgICBwYy1iaW9zL29wdGlvbnJvbS9rdm12
YXBpYy5iaW4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBxZW11
LWltZy5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgQlVJTEQgICBwYy1iaW9zL29wdGlvbnJvbS9wdmguaW1nCiAgQlVJTEQgICBwYy1iaW9zL29w
dGlvbnJvbS9wdmgucmF3Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUs
IGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICct
bicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1k
MTNiMDI0YTIyODE0MTdiOWM4YTg2M2QyYmJjZmVjMycsICctdScsICcxMDAzJywgJy0tc2VjdXJp
dHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNU
PXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNh
Y2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtajQ4N19rdWgvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0yOS0x
NS4wNy4zMi4yNzIzMTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1kMTNiMDI0
YTIyODE0MTdiOWM4YTg2M2QyYmJjZmVjMwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1qNDg3X2t1aC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0g
RXJyb3IgMgoKcmVhbCAgICAzbTUxLjAxOXMKdXNlciAgICAwbTcuOTQ3cwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjkxNDExMjYu
ODUxNTktMS1tcmVpdHpAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

