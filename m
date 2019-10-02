Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C0C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0916721848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0916721848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiNZ-0007VX-0y
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFiHH-0000pM-Tw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFiHF-0005eO-DX
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:19:03 -0400
Resent-Date: Wed, 02 Oct 2019 13:19:02 -0400
Resent-Message-Id: <E1iFiHF-0005eO-DX@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFiH9-0005cq-TS; Wed, 02 Oct 2019 13:18:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570036723; cv=none; d=zoho.com; s=zohoarc; 
 b=aW6OCAJrLwEJweC7jIcwv8vAR3Ra/oSKySBOQlo4xvTFGn2ibSJUEl3o7bXJsSNrsHuSfNmCUZd1AgeBTCjfCs4KjfcT2He2KvQwiMPzOOTfw8b8v9lLTE8jSO8vMUAT363X6Bg2/SLu0qtHESJO/Z6f07oFV0Gg8i2f5AtE5dE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570036723;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=yzKTJT5UW8MqcBXelWOwNVK46tSR1UmroZmN5sGsF6o=; 
 b=UVNK3n1O5PVMaw47AyQYFzs2bLIHHg6rUjYEZLlcuEkpMaKVpSEfb3fS8+fjRi2trQji3jNRYTG4uQ5nXuhL70ZwzqiK6/kTLJx5ZsbIb982/PLDoL1Dzt2mxYJul6t44NhlIIBVEe212g9mqn7aDAIlVusc2r7d/u6OSs793F4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570036722891745.0505682504679;
 Wed, 2 Oct 2019 10:18:42 -0700 (PDT)
Subject: Re: [PULL v2 0/4] Block layer patches
In-Reply-To: <20191002161851.1016-1-kwolf@redhat.com>
Message-ID: <157003672169.27524.8849361480034357202@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwolf@redhat.com
Date: Wed, 2 Oct 2019 10:18:42 -0700 (PDT)
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwMjE2MTg1MS4xMDE2
LTEta3dvbGZAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgotVGVzdGluZzoKLVFFTVUgWC5ZLlog
bW9uaXRvciAtIHR5cGUgJ2hlbHAnIGZvciBtb3JlIGluZm9ybWF0aW9uCi0ocWVtdSkgc2F2ZXZt
IHNuYXAwCi1FcnJvcjogTm8gYmxvY2sgZGV2aWNlIGNhbiBhY2NlcHQgc25hcHNob3RzCi0ocWVt
dSkgaW5mbyBzbmFwc2hvdHMKLU5vIGF2YWlsYWJsZSBibG9jayBkZXZpY2Ugc3VwcG9ydHMgc25h
cHNob3RzCi0ocWVtdSkgbG9hZHZtIHNuYXAwCi1FcnJvcjogTm8gYmxvY2sgZGV2aWNlIHN1cHBv
cnRzIHNuYXBzaG90cwotKHFlbXUpIHF1aXQKK1VzYWdlOiBzZWQgW09QVElPTl0uLi4ge3Njcmlw
dC1vbmx5LWlmLW5vLW90aGVyLXNjcmlwdH0gW2lucHV0LWZpbGVdLi4uCiAKLS0tCi1UZXN0aW5n
OiAtZHJpdmUgZHJpdmVyPWZpbGUsZmlsZT1URVNUX0RJUi90LklNR0ZNVCxpZj1ub25lCi1RRU1V
IFguWS5aIG1vbml0b3IgLSB0eXBlICdoZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbgotKHFlbXUp
IHNhdmV2bSBzbmFwMAotRXJyb3I6IERldmljZSAnbm9uZTAnIGlzIHdyaXRhYmxlIGJ1dCBkb2Vz
IG5vdCBzdXBwb3J0IHNuYXBzaG90cwotKHFlbXUpIGluZm8gc25hcHNob3RzCi1ObyBhdmFpbGFi
bGUgYmxvY2sgZGV2aWNlIHN1cHBvcnRzIHNuYXBzaG90cwotKHFlbXUpIGxvYWR2bSBzbmFwMAot
RXJyb3I6IERldmljZSAnbm9uZTAnIGlzIHdyaXRhYmxlIGJ1dCBkb2VzIG5vdCBzdXBwb3J0IHNu
YXBzaG90cwotKHFlbXUpIHF1aXQKLQotRm9ybWF0dGluZyAnVEVTVF9ESVIvdC5JTUdGTVQnLCBm
bXQ9SU1HRk1UIHNpemU9MTM0MjE3NzI4Ci0tLQotVGVzdGluZzogLWRyaXZlIGRyaXZlcj1maWxl
LGZpbGU9VEVTVF9ESVIvdC5JTUdGTVQsaWY9dmlydGlvCi1RRU1VIFguWS5aIG1vbml0b3IgLSB0
eXBlICdoZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbgotKHFlbXUpIHNhdmV2bSBzbmFwMAotRXJy
b3I6IERldmljZSAndmlydGlvMCcgaXMgd3JpdGFibGUgYnV0IGRvZXMgbm90IHN1cHBvcnQgc25h
cHNob3RzCi0ocWVtdSkgaW5mbyBzbmFwc2hvdHMKLU5vIGF2YWlsYWJsZSBibG9jayBkZXZpY2Ug
c3VwcG9ydHMgc25hcHNob3RzCi0ocWVtdSkgbG9hZHZtIHNuYXAwCi1FcnJvcjogRGV2aWNlICd2
aXJ0aW8wJyBpcyB3cml0YWJsZSBidXQgZG9lcyBub3Qgc3VwcG9ydCBzbmFwc2hvdHMKLShxZW11
KSBxdWl0Ci0KLUZvcm1hdHRpbmcgJ1RFU1RfRElSL3QuSU1HRk1UJywgZm10PUlNR0ZNVCBzaXpl
PTEzNDIxNzcyOAotLS0KLVRlc3Rpbmc6IC1ibG9ja2RldiBkcml2ZXI9ZmlsZSxmaWxlbmFtZT1U
RVNUX0RJUi90LklNR0ZNVCxub2RlLW5hbWU9ZmlsZQotUUVNVSBYLlkuWiBtb25pdG9yIC0gdHlw
ZSAnaGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24KLShxZW11KSBzYXZldm0gc25hcDAKLUVycm9y
OiBEZXZpY2UgJycgaXMgd3JpdGFibGUgYnV0IGRvZXMgbm90IHN1cHBvcnQgc25hcHNob3RzCi0o
cWVtdSkgaW5mbyBzbmFwc2hvdHMKLU5vIGF2YWlsYWJsZSBibG9jayBkZXZpY2Ugc3VwcG9ydHMg
c25hcHNob3RzCi0ocWVtdSkgbG9hZHZtIHNuYXAwCi1FcnJvcjogRGV2aWNlICcnIGlzIHdyaXRh
YmxlIGJ1dCBkb2VzIG5vdCBzdXBwb3J0IHNuYXBzaG90cwotKHFlbXUpIHF1aXQKLQotRm9ybWF0
dGluZyAnVEVTVF9ESVIvdC5JTUdGTVQnLCBmbXQ9SU1HRk1UIHNpemU9MTM0MjE3NzI4Ci0tLQog
KioqIGRvbmUKRmFpbHVyZXM6IDI2NwpGYWlsZWQgMSBvZiAxMDggaW90ZXN0cwptYWtlOiAqKiog
W2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNl
bnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2
MiwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPTkyNzI2MTg3YTBiZDQ5NWM5YmQ5NjE4ZjgxNWJhN2JiJywgJy11
JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0x
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaXJ2ZDN5Mnovc3JjL2RvY2tlci1zcmMuMjAxOS0x
MC0wMi0xMy4wOC41Mi4xNTEzMTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3Jywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
OTI3MjYxODdhMGJkNDk1YzliZDk2MThmODE1YmE3YmIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtaXJ2ZDN5Mnovc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0Bj
ZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDltNTAuMjA1cwp1c2VyICAgIDBtOC4zMDNzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAw
MjE2MTg1MS4xMDE2LTEta3dvbGZAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50
b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


