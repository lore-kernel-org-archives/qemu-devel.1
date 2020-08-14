Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE301C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80CC20771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80CC20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6eBK-000741-1r
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6eAe-0006TT-Au; Fri, 14 Aug 2020 14:11:16 -0400
Resent-Date: Fri, 14 Aug 2020 14:11:16 -0400
Resent-Message-Id: <E1k6eAe-0006TT-Au@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6eAa-0004sn-SS; Fri, 14 Aug 2020 14:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597428638; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LkxbnH2VWKcvbQrzdqx79n8jHPDvvQ6r4v2MoTqNEP3S9aPEUXTfPntbS8riY8xO8lIeQqDXxXy9aUM1fBQl+yylk5DmGbufPbomdMWjKs/lUkNkOTRkFIVQs+DeB7Yc3aOp5e7hbkivF58/BpUS+MTw8gElhGRuulIrY+dgjnI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597428638;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=3WQ/sYsZGKmWGvICEm4yk6yBK3bgTO3NCBJ4DZNW+d8=; 
 b=FAVDMhM9AeHAqBIBBLBH6QZX/ZHZycPXeA+73s1YZ0jVfJYEeN2zI/nRx8Kc6YPKEEpXVXsvZ+CPhURqJeyqjhTR4P22wNAEOL6zRexcwyE1dsND3DL/wiolFBvbaI5P6rSghpQU2QTEF9pJSM1jmHU5cqo07WFi8U/vY+VlZMg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597428631629197.05788517949736;
 Fri, 14 Aug 2020 11:10:31 -0700 (PDT)
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
Message-ID: <159742862975.7155.16347016576483852972@66eaa9a8a123>
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: bmeng.cn@gmail.com
Date: Fri, 14 Aug 2020 11:10:31 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 12:16:06
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
Cc: peter.maydell@linaro.org, alistair@alistair23.me, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, sagark@eecs.berkeley.edu, bin.meng@windriver.com,
 kbastian@mail.uni-paderborn.de, jasowang@redhat.com, palmerdabbelt@google.com,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair.Francis@wdc.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk3NDIzMjU2LTE0ODQ3LTEt
Z2l0LXNlbmQtZW1haWwtYm1lbmcuY25AZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZh
aWxlZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhl
IHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9j
a2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2Vu
dG9zNyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNI
T1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAg
ICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWNoYXIKVW5leHBlY3RlZCBlcnJvciBpbiBvYmplY3Rf
cHJvcGVydHlfdHJ5X2FkZCgpIGF0IC90bXAvcWVtdS10ZXN0L3NyYy9xb20vb2JqZWN0LmM6MTE4
MToKYXR0ZW1wdCB0byBhZGQgZHVwbGljYXRlIHByb3BlcnR5ICdzZXJpYWwtaWQnIHRvIG9iamVj
dCAodHlwZSAnY29udGFpbmVyJykKRVJST1IgdGVzdC1jaGFyIC0gdG9vIGZldyB0ZXN0cyBydW4g
KGV4cGVjdGVkIDM4LCBnb3QgOSkKbWFrZTogKioqIFtjaGVjay11bml0XSBFcnJvciAxCm1ha2U6
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBjaGVjay1xdGVz
dC14ODZfNjQ6IHRlc3RzL3F0ZXN0L2hkLWdlby10ZXN0CnFlbXUtc3lzdGVtLWFhcmNoNjQ6IC1h
Y2NlbCBrdm06IGludmFsaWQgYWNjZWxlcmF0b3Iga3ZtCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD01ZDg3ZWQ0YjMyMTA0ZDNmYTMwMGY4OTI0OGU1OTgwOScsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1va3JyOWtibC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4
LTE0LTEzLjU2LjU1LjEyMjUxOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01
ZDg3ZWQ0YjMyMTA0ZDNmYTMwMGY4OTI0OGU1OTgwOQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1va3JyOWtibC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgMTNtMzUuMzAwcwp1c2VyICAgIDBtOC4yNjZzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTk3NDIz
MjU2LTE0ODQ3LTEtZ2l0LXNlbmQtZW1haWwtYm1lbmcuY25AZ21haWwuY29tL3Rlc3RpbmcuZG9j
a2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

