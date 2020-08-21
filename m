Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D46C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA1620720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA1620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k933D-0001R3-Sy
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 05:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k932V-0000rf-Td; Fri, 21 Aug 2020 05:08:47 -0400
Resent-Date: Fri, 21 Aug 2020 05:08:47 -0400
Resent-Message-Id: <E1k932V-0000rf-Td@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k932T-0000u1-7Q; Fri, 21 Aug 2020 05:08:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598000910; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b/nPUhHnJ7KyyPdACJ8duCj2w+7vGAKjM0/aisTakVFIjtdQ8Ue24LhwLhHnx3495QAEunkmTZOXMCcgKpuwswqy1uXQpX2VUcQYKOUEEDtHDSjOchZxJv/PAQ7kzLqOwIFQLvC1sY7ZBnnFJzhU3zOXH2VdVSxhkav+Gjh18C4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598000910;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SUx9td7tRxWBycnBuX9UqkG6RxsdV2PWiBT5D+HS6vo=; 
 b=RNnZqNsp7ufrHvpgLAynySTPnYM2tLlgHRWDLw12YfQ610Db8+ofXMXh745TPjjuX+/kSG+KJ+8KwJ6JHkkoHDSCE3xS8wI8QHKtTX4yfjoviFScb7tVToqOAl+4gAI63TdACBIk4ogPQR6h9zDRt2/wVBR4VYZ9Znx5rV58MeI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15980009082081001.6626114745343;
 Fri, 21 Aug 2020 02:08:28 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/sbsa-ref: fix typo breaking PCIe IRQs
Message-ID: <159800090688.18714.2270521033691750020@66eaa9a8a123>
In-Reply-To: <20200821083853.356490-1-graeme@nuviainc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: graeme@nuviainc.com
Date: Fri, 21 Aug 2020 02:08:28 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:08:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: graeme@nuviainc.com, peter.maydell@linaro.org, rad@semihalf.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, leif@nuviainc.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgyMTA4Mzg1My4zNTY0
OTAtMS1ncmFlbWVAbnV2aWFpbmMuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay11
bml0OiB0ZXN0cy90ZXN0LWNoYXIKVW5leHBlY3RlZCBlcnJvciBpbiBvYmplY3RfcHJvcGVydHlf
dHJ5X2FkZCgpIGF0IC90bXAvcWVtdS10ZXN0L3NyYy9xb20vb2JqZWN0LmM6MTE4MToKYXR0ZW1w
dCB0byBhZGQgZHVwbGljYXRlIHByb3BlcnR5ICdzZXJpYWwtaWQnIHRvIG9iamVjdCAodHlwZSAn
Y29udGFpbmVyJykKRVJST1IgdGVzdC1jaGFyIC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4cGVjdGVk
IDM4LCBnb3QgOSkKbWFrZTogKioqIFtjaGVjay11bml0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyOQog
IFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy9xdGVzdC9oZC1nZW8tdGVzdAotLS0K
ICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2Fs
bGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bics
ICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZDAyMDU0MWQ4Mjc4NGNiMmFjODA0
OTk0MjIwYmE0ZWMnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVu
Y29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09O
RklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9Jywg
Jy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAn
LXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2Nj
YWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1xNGZkNmNrcC9zcmMv
ZG9ja2VyLXNyYy4yMDIwLTA4LTIxLTA0LjUyLjI5LjI5MDY3Oi92YXIvdG1wL3FlbXU6eixybycs
ICdxZW11L2NlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFl
bXUuaW5zdGFuY2UudXVpZD1kMDIwNTQxZDgyNzg0Y2IyYWM4MDQ5OTQyMjBiYTRlYwptYWtlWzFd
OiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1xNGZkNmNrcC9zcmMnCm1ha2U6ICoqKiBbZG9ja2Vy
LXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTVtNTguNjg3cwp1c2Vy
ICAgIDBtOS4wMjVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDgyMTA4Mzg1My4zNTY0OTAtMS1ncmFlbWVAbnV2aWFpbmMuY29tL3Rl
c3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

