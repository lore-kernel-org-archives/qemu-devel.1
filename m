Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08C1C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 08:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA9821850
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 08:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA9821850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJDDu-0000co-Kk
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 04:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJDDB-0000CM-PS
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 04:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJDD7-0002aq-Lr
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 04:57:17 -0400
Resent-Date: Sat, 12 Oct 2019 04:57:16 -0400
Resent-Message-Id: <E1iJDD7-0002aq-Lr@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJDD6-0002aK-AX
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 04:57:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570870603; cv=none; d=zoho.com; s=zohoarc; 
 b=CsshCGcrmYnmdGg1zOMycKJBZGIsY7QBQ9OMf9mOv2a5HA/AlG9wlC6bL/EGlTKKiCWW0dQk05bwgmaDxDd23TsZQBCYAqyOmogKtQC6y6EoIEvmI3zmVuQz17phz2G50WGAco2eoQ/E3c0vG0YSnXzZQb602ScBPRXeFPrfUB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570870603;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+E1MoPFyvKaFnLEQ0nrd7sF9uVSJim0jEbrydLIeX0k=; 
 b=AkmYeC+2mK41aM+ACfyh1c5B5sIIWv/xjtcc42WTicEQ9kFhYrXzYuuJX/lESZ8eIt5VU00ZH9HMYdWACJdHV5tIsPTC1xvsmN7vQzSD1sRJ1qGeJFI4I/SLzgEYtAhFmbG2KYaqs3hOUBNA1yaeXIhP4nphwW0vmAi+PiSHeTQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570870601476561.2722199144392;
 Sat, 12 Oct 2019 01:56:41 -0700 (PDT)
In-Reply-To: <20191012024748.127135-1-xiaoyao.li@intel.com>
Subject: Re: [PATCH v3] target/i386: Add Snowridge-v2 (no MPX) CPU model
Message-ID: <157087059993.19261.12706853972165466894@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: xiaoyao.li@intel.com
Date: Sat, 12 Oct 2019 01:56:41 -0700 (PDT)
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
Cc: ehabkost@redhat.com, mst@redhat.com, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMjAyNDc0OC4xMjcx
MzUtMS14aWFveWFvLmxpQGludGVsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tl
ci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dA
ZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
c3R1YnMvbWFjaGluZS1pbml0LWRvbmUubwogIENDICAgICAgc3R1YnMvbWlnci1ibG9ja2VyLm8K
ICBDQyAgICAgIHN0dWJzL2NoYW5nZS1zdGF0ZS1oYW5kbGVyLm8KbWFrZTogKioqIFtNYWtlZmls
ZTo5OTQ6IGRvY3MvaW50ZXJvcC9pbmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5n
IGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0
KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2MiwgaW4gPG1vZHVs
ZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9j
ZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcics
ICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWFmY2ZjZWZhNDM5YzQw
ZjlhZDUzMjI0OWE1MDU4ZjIwJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2Vj
Y29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VY
VFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RF
QlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2Fj
aGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFy
L3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcmZibTBx
aXgvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0xMi0wNC41NC4zOC4xOTQzOTovdmFyL3RtcC9xZW11
Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndydd
JyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1hZmNmY2VmYTQzOWM0MGY5YWQ1MzIyNDlhNTA1OGYyMApt
YWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rv
cnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1yZmJtMHFpeC9zcmMnCm1ha2U6ICoqKiBb
ZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTEuOTY1cwp1
c2VyICAgIDBtNy42MzhzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDE5MTAxMjAyNDc0OC4xMjcxMzUtMS14aWFveWFvLmxpQGludGVsLmNv
bS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


