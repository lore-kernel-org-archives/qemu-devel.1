Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7596AC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 19:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0AD218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 19:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0AD218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iznHs-0004xI-E1
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 14:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iznHJ-0004NZ-Ts
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iznHH-0003qH-Cc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:57:33 -0500
Resent-Date: Thu, 06 Feb 2020 14:57:33 -0500
Resent-Message-Id: <E1iznHH-0003qH-Cc@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iznHH-0003kk-39
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 14:57:31 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581018969935501.9666108356928;
 Thu, 6 Feb 2020 11:56:09 -0800 (PST)
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
Subject: Re: [PATCH 00/29] Convert QAPI doc comments to generate rST instead
 of texinfo
Message-ID: <158101896929.19404.639362435298132958@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Thu, 6 Feb 2020 11:56:09 -0800 (PST)
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
Cc: berrange@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIwNjE3MzA0MC4xNzMz
Ny0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdGVz
dHMvdGVzdC1xYXBpLWNvbW1hbmRzLm8KICBDQyAgICAgIHRlc3RzL3Rlc3Qtc3RyaW5nLWlucHV0
LXZpc2l0b3IubwogIENDICAgICAgdGVzdHMvdGVzdC1zdHJpbmctb3V0cHV0LXZpc2l0b3Iubwpk
b2MtZ29vZCBGQUlMCi0tLSAvdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcWFwaS1zY2hlbWEvZG9j
LWdvb2Qub3V0CisrKyAKQEAgLTEsMTk5ICswLDAgQEAKLS0tCisrKyAKQEAgLTAsMCArMSBAQAor
ZG9jLWdvb2QuanNvbjoxMDQ6MTogdW5leHBlY3RlZCBkZS1pbmRlbnQKbWFrZTogKioqIFtjaGVj
ay10ZXN0cy9xYXBpLXNjaGVtYS9mcm9udGVuZF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgdGVzdHMvdGVzdC1xbXAtZXZlbnQubwpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD1hYzhlOGRiZjU5M2M0MmUzODU3MjE1NTQ3NTljYjI1MicsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15OWhfa3c0ci9zcmMvZG9ja2VyLXNyYy4yMDIwLTAy
LTA2LTE0LjUzLjUxLjExNTM3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1h
YzhlOGRiZjU5M2M0MmUzODU3MjE1NTQ3NTljYjI1MgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC15OWhfa3c0ci9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgMm0xNy42NTFzCnVzZXIgICAgMG03LjY1M3MKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjA2
MTczMDQwLjE3MzM3LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9ja2VyLXF1
aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

