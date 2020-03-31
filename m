Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9649C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA5720714
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA5720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJC4S-0000fQ-Pk
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJC3C-0006x9-39
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJC3A-0002xb-Gc
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:15:09 -0400
Resent-Date: Tue, 31 Mar 2020 04:15:09 -0400
Resent-Message-Id: <E1jJC3A-0002xb-Gc@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJC3A-0002vS-8u; Tue, 31 Mar 2020 04:15:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585642499; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LEipwQAF1HtlXIv5NSLK/IZB+lw3u9CRtm/vdr3opNy4Y5lRd2bwKWhk9fEDyOXa13+Vvo69Mx2TcRwBgQE5zj2hqfxPiHVoqj0ORhKJmstXTm7qUkfCtYWT3JbK/X+eho/WTzfGYZVy45OwfVDgr7/2GWHwrQ6BWUyy6Yxtt+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585642499;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=hVqiA7Zq6QQE5hrtAt9PCEeCFnfjDIy1iCE1jXLHGl4=; 
 b=AtyJCbfI+kTBwokfYfhLHW/g910KQSlaCAi1GeSgXJmBhe7aLS4Pw1aHjUxoUzAt12oCV8hufYSuBSNbEIHz71SdhXtpEigbMaUXrmuvdrl49PJMbHp4dXZ+TIdNcTLw0XfIbXK1LPjRiKSjeQD/dkxNzb3l8BB0HrqsS2/hamk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585642498938882.971416998907;
 Tue, 31 Mar 2020 01:14:58 -0700 (PDT)
In-Reply-To: <20200331035456.6494-3-richard.henderson@linaro.org>
Subject: Re: [PATCH for-5.0] tcg/i386: Fix INDEX_op_dup2_vec
Message-ID: <158564249764.16271.9295994622086895356@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 31 Mar 2020 01:14:58 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMzMTAzNTQ1Ni42NDk0
LTMtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRv
czcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9X
X0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgotLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgorLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLkUuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLgorPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQorRVJST1I6IHRlc3RfcGF1c2UgKF9fbWFpbl9fLlRl
c3RTaW5nbGVCbG9ja2RldikKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KK1RyYWNlYmFjayAobW9zdCByZWNlbnQg
Y2FsbCBsYXN0KToKKyAgRmlsZSAiMDQxIiwgbGluZSAxMDgsIGluIHRlc3RfcGF1c2UKLS0tCiBS
YW4gOTQgdGVzdHMKIAotT0sKK0ZBSUxFRCAoZXJyb3JzPTEpCiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDA0MgpxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNjZWwga3ZtOiBpbnZhbGlkIGFjY2VsZXJh
dG9yIGt2bQpxZW11LXN5c3RlbS1hYXJjaDY0OiBmYWxsaW5nIGJhY2sgdG8gdGNnCi0tLQpOb3Qg
cnVuOiAyNTkKRmFpbHVyZXM6IDA0MQpGYWlsZWQgMSBvZiAxMTYgaW90ZXN0cwptYWtlOiAqKiog
W2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZv
ciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay1xdGVzdC1hYXJjaDY0OiB0ZXN0
cy9xdGVzdC9xb3MtdGVzdApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1kMDRmOWZiZDZkNzg0MTIyYTFlOTZl
OTJmMmM5ZjIyNicsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICct
dicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTdnamU2eDdrL3NyYy9k
b2NrZXItc3JjLjIwMjAtMDMtMzEtMDQuMDAuMzEuNDczOi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5l
ZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUu
aW5zdGFuY2UudXVpZD1kMDRmOWZiZDZkNzg0MTIyYTFlOTZlOTJmMmM5ZjIyNgptYWtlWzFdOiAq
KiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC03Z2plNng3ay9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1
bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTRtMjcuMTAwcwp1c2VyICAg
IDBtOS4wNjVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDMzMTAzNTQ1Ni42NDk0LTMtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
Zy90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

