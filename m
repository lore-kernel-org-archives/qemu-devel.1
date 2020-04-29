Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF3EC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6145E205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6145E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTs76-0000FD-GZ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTs5j-00070v-Ku
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTs5e-0004yi-T8
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:09:55 -0400
Resent-Date: Wed, 29 Apr 2020 15:09:55 -0400
Resent-Message-Id: <E1jTs5e-0004yi-T8@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTs37-00031c-12; Wed, 29 Apr 2020 15:07:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588187225; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=niyYrqC3aUJtiisnMbgjI9hMLS8iI4fY3wCFYTukrklThtFyrDqShVAqQav6QTmQwOf6hHwC7wHntilCxZfIFNdGgGD3eN+7tS6Aq8PE+jSjcXoQje2A/IkiS00o38RvhSdImkjdE521DMu+22bI7g59r8a90CNO1sGA250PRU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588187225;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mXRdBE3G0HWtLopkKKEw8PgBvzf0YzSvKFMcE/33P50=; 
 b=As2ZsbKS/QfXOpl7/Tt9GzFIYBkBN8HOyLul5ZfHoOfUJf3vqSBKKaAT3psPV3gLfD4iyLLwdHuqi+hVggASb3TAT5F3SSYU4TaggQ0K8yPjO/0cNECHpi4tFEToLH0lS7RrL0VMNwSOURN/hdex8AIVsWQLD5M2cWrBdjIDYLU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15881872229730.2970267795152495;
 Wed, 29 Apr 2020 12:07:02 -0700 (PDT)
Message-ID: <158818722162.4471.10347903151740616896@45ef0f9c86ae>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
Subject: Re: [PATCH v2 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Wed, 29 Apr 2020 12:07:02 -0700 (PDT)
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
OS0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgTElOSyAgICBxZW11LXN0b3Jh
Z2UtZGFlbW9uCiAgTElOSyAgICBxZW11LWlvCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5j
OiBJbiBmdW5jdGlvbiAnaW1nX2NvbW1pdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5j
OjEwNzE6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdibGtfbmV3
X3dpdGhfYnMnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAg
ICBvbGRfYmFja2luZ19ibGsgPSBibGtfbmV3X3dpdGhfYnMoYnMsIEJMS19QRVJNX1dSSVRFLCBC
TEtfUEVSTV9BTEwsCiAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3
MTo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYmxrX25ld193aXRoX2Jz
JyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6
MTA3MToyNTogZXJyb3I6IGFzc2lnbm1lbnQgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0
aG91dCBhIGNhc3QgWy1XZXJyb3JdCiAgICAgICAgIG9sZF9iYWNraW5nX2JsayA9IGJsa19uZXdf
d2l0aF9icyhicywgQkxLX1BFUk1fV1JJVEUsIEJMS19QRVJNX0FMTCwKICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFr
ZTogKioqIFtxZW11LWltZy5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uCm1ha2U6ICoqKiB3YWl0OiBObyBjaGlsZCBwcm9jZXNzZXMuICBTdG9wLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD01NGMxZThkN2YzOGQ0OTFjODc5YTlmN2ZkNzBiOTNmZCcsICctdScs
ICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1qOThscGVlNi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0
LTI5LTE1LjA0LjIxLjE2NTQ3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01
NGMxZThkN2YzOGQ0OTFjODc5YTlmN2ZkNzBiOTNmZAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1qOThscGVlNi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgMm00MS4xOTJzCnVzZXIgICAgMG04LjA5NXMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI5
MTQxMTI2Ljg1MTU5LTEtbXJlaXR6QHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2Vu
dG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

