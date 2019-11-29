Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD1EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1B92176D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 02:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1B92176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaVt9-0004gY-0R
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 21:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iaVKX-0006QW-4F
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:44:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iaVKQ-0008Nu-6q
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:44:18 -0500
Resent-Date: Thu, 28 Nov 2019 20:44:17 -0500
Resent-Message-Id: <E1iaVKQ-0008Nu-6q@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iaVKP-00083f-Ta
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 20:44:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574991820; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OD2HYTdxxDU8za0K/m4kvLareprauUh6FEPo4iICQr4SWozn8wcp5Z4tDH4NYKr+LDK4XdWubeRhu7M4ag4au/gy2Fv8T5bwjMGyExLigSeyk33236haBgyCrCZRo/aBk8bEawx1ai/GiKr9RvnxhT4c4bDbwG4JQp8/DMRuM2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574991820;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=kcVAQCPGcGWRgY1VeU8xcHJHYTNW+/MqZLHfdAlLLnE=; 
 b=O6C6JoC9JbO/XMKBrWMUheYTqtfHzoKCyYQbWoPPZmZqA7M+KASdEYp6iFYjDVcYtG7nkqesS43HebljiQLaigmL6v8AUxtYnkfe5V1C8PCUBKQpTYCqe5EwFtOzaNjClAJewmhnzUwm8XDttdiIGkQgRhdpNvNqYMVOh8bSgfc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574991818860728.400347341399;
 Thu, 28 Nov 2019 17:43:38 -0800 (PST)
In-Reply-To: <20191128082109.30081-1-tao3.xu@intel.com>
Subject: Re: [PATCH v19 0/8] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <157499181690.16987.17391243282624212978@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Thu, 28 Nov 2019 17:43:38 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, sw@weilnetz.de, tao3.xu@intel.com, fan.du@intel.com,
 armbru@redhat.com, mdroth@linux.vnet.ibm.com, jingqi.liu@intel.com,
 imammedo@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyODA4MjEwOS4zMDA4
MS0xLXRhbzMueHVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDE3MApCcm9rZW4gcGlwZQovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvbGlicXRlc3QuYzox
NDk6IGtpbGxfcWVtdSgpIGRldGVjdGVkIFFFTVUgZGVhdGggZnJvbSBzaWduYWwgOCAoRmxvYXRp
bmcgcG9pbnQgZXhjZXB0aW9uKSAoY29yZSBkdW1wZWQpCkVSUk9SIC0gdG9vIGZldyB0ZXN0cyBy
dW4gKGV4cGVjdGVkIDksIGdvdCA4KQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJy
b3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAg
aW90ZXN0LXFjb3cyOiAxNzIKICBURVNUICAgIGlvdGVzdC1xY293MjogMTc0Ci0tLQogICAgcmFp
c2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9j
ZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFi
ZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1lYTljNGIyZmEyMzc0YmVkYmQ2ZTFkOTFlMGU1
MTg4NCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5l
ZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVf
T1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAn
U0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcv
aG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15eTllazY5MC9zcmMvZG9ja2Vy
LXNyYy4yMDE5LTExLTI4LTIwLjMyLjI0LjI3Mjc3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11
OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD1lYTljNGIyZmEyMzc0YmVkYmQ2ZTFkOTFlMGU1MTg4NAptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC15eTllazY5MC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTFtMTIuOTE1cwp1c2VyICAgIDBt
OC4xMDFzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE5MTEyODA4MjEwOS4zMDA4MS0xLXRhbzMueHVAaW50ZWwuY29tL3Rlc3RpbmcuZG9j
a2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


