Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF88C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 22:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B544205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 22:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B544205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUHMN-0003bg-Op
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 18:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUHL6-0002Dd-Kd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 18:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUHKv-0007M5-Dz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 18:07:27 -0400
Resent-Date: Thu, 30 Apr 2020 18:07:27 -0400
Resent-Message-Id: <E1jUHKv-0007M5-Dz@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUHKt-00074E-BZ; Thu, 30 Apr 2020 18:07:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588284426; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XbPEu4TYLBkl8vMay04A/hKGqNOV0oSFtqsBY3tRAfY4G0d2ofVlPHZROJMtUb4/qdCzljB4g2q01tJm10W9ZvaVti9mreSoXxyD/M++J8f1W3pvf+d2QnvwOX6x7jZDDPbMHhf6ZsOMeZwQVSdeyICsRRTbEuP1EFBIKZvywtM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588284426;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WtWNP8Lgt8ZsWi8/i6K9pEuaKLa9puJ5Q6MyYCrRtto=; 
 b=bSPtxDHft5JoODpAgR0suV5Xv+MjYphETiG/7W9/0Ok8f104HnTdvbQXVuHpUh3255InCaAkvrXmG6KAvSHQfGxB74OZ5YUIF4exxUgm1QIguDruG0f+H4y7SmyIzRJ/Tph9UJVG6p//0eSmOxf8UKQ8xgsqjcy6AlUgCZglqzw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588284424608981.3537481280223;
 Thu, 30 Apr 2020 15:07:04 -0700 (PDT)
Message-ID: <158828442348.4471.2357536509933664831@45ef0f9c86ae>
In-Reply-To: <20200430113915.19550-1-jcmvbkbc@gmail.com>
Subject: Re: [PATCH] target/xtensa: work around missing SR definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jcmvbkbc@gmail.com
Date: Thu, 30 Apr 2020 15:07:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 16:09:40
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
Cc: jcmvbkbc@gmail.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQzMDExMzkxNS4xOTU1
MC0xLWpjbXZia2JjQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2stdW5p
dDogdGVzdHMvdGVzdC1xaHQtcGFyCnNvY2tldF9hY2NlcHQgZmFpbGVkOiBSZXNvdXJjZSB0ZW1w
b3JhcmlseSB1bmF2YWlsYWJsZQoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRl
c3QvbGlicXRlc3QuYzozMDE6cXRlc3RfaW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2Vy
dGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAwICYmIHMtPnFtcF9mZCA+PSAwKQovdG1wL3FlbXUtdGVz
dC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoxNjY6IGtpbGxfcWVtdSgpIHRyaWVkIHRvIHRl
cm1pbmF0ZSBRRU1VIHByb2Nlc3MgYnV0IGVuY291bnRlcmVkIGV4aXQgc3RhdHVzIDEgKGV4cGVj
dGVkIDApCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9x
dGVzdC9saWJxdGVzdC5jOjMwMTpxdGVzdF9pbml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNz
ZXJ0aW9uIGZhaWxlZDogKHMtPmZkID49IDAgJiYgcy0+cW1wX2ZkID49IDApCm1ha2U6ICoqKiBb
Y2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5p
c2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1iaXRvcHMKICBU
RVNUICAgIGlvdGVzdC1xY293MjogMDI1Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9y
KHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1sn
c3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFu
Y2UudXVpZD01ZjE3ZGQ2N2Y1ZDk0MmVkYWMxZDA2MTYxODNiMzI2MicsICctdScsICcxMDAzJywg
Jy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RB
UkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAn
LWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdD
Q0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC0wNHkwb3M3bi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTMwLTE3LjUw
LjIyLjE5ODk2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAv
cWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAy
LgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01ZjE3ZGQ2N2Y1
ZDk0MmVkYWMxZDA2MTYxODNiMzI2MgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEK
bWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0w
NHkwb3M3bi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVy
cm9yIDIKCnJlYWwgICAgMTZtNDEuNDYzcwp1c2VyICAgIDBtOS41MjJzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQzMDExMzkxNS4x
OTU1MC0xLWpjbXZia2JjQGdtYWlsLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

