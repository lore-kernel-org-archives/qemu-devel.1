Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC1AC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D24E20708
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 23:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D24E20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNmSg-0005lx-NY
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 19:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jNmSA-0005HJ-BH
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jNmS8-0005Hd-Uu
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 19:55:54 -0400
Resent-Date: Sun, 12 Apr 2020 19:55:54 -0400
Resent-Message-Id: <E1jNmS8-0005Hd-Uu@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jNmS8-0005H1-NC; Sun, 12 Apr 2020 19:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586735724; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iMmfd86giM5AAtRD2azPrcjagPInW6NiNv8bOe+R0Ma41FoN0gHmqDm9S7WHkx/HQYrfDsyg2DiIU99HEzSi4E0AMZ1AsVIUGXUKPFJuXcdXJERijEo7U97tNIGiVPV4AjHsC7OKxlrfZI0gAWBRiCH0Ti1fXTT9WCoVfV/vvhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586735724;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yp4xD/c5ybfsiCUxiaeTs5BAx0ZPf2mrkJMrq8k2hAU=; 
 b=TcgVJVZlcKPltJAJlxGvRxNkxGrlAKYAV0swimxPhMESTLZjrUkdephCBDD9/PAMA12ivePyFCZTRabRq8kzwBvhELOL9SK9/WtEIpiVaO5KxYg3kyAxwdyIA0+tPW0vGe6k3HLfZj/XIeMUtDcAb9zFlz9qCnmlxrarYA9UH+E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586735721731811.6150967316491;
 Sun, 12 Apr 2020 16:55:21 -0700 (PDT)
In-Reply-To: <20200412212943.4117-1-f4bug@amsat.org>
Subject: Re: [PATCH 0/3] hw: Use qdev gpio rather than qemu_allocate_irqs()
Message-ID: <158673572022.24582.7003752481719955060@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 12 Apr 2020 16:55:21 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 aleksandar.qemu.devel@gmail.com, shorne@gmail.com, jsnow@redhat.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxMjIxMjk0My40MTE3
LTEtZjRidWdAYW1zYXQub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCnFlbXUtc3lzdGVtLWFhcmNoNjQ6IGZh
bGxpbmcgYmFjayB0byB0Y2cKQnJva2VuIHBpcGUKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0
ZXN0L2xpYnF0ZXN0LmM6MTc1OiBraWxsX3FlbXUoKSBkZXRlY3RlZCBRRU1VIGRlYXRoIGZyb20g
c2lnbmFsIDExIChTZWdtZW50YXRpb24gZmF1bHQpIChjb3JlIGR1bXBlZCkKRVJST1IgLSB0b28g
ZmV3IHRlc3RzIHJ1biAoZXhwZWN0ZWQgNzQsIGdvdCAwKQogIFRFU1QgICAgaW90ZXN0LXFjb3cy
OiAwMTkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3Rz
L3Rlc3QtcmN1LXRhaWxxCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyMAotLS0KICBURVNUICAg
IGlvdGVzdC1xY293MjogMTU4CkJyb2tlbiBwaXBlCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9x
dGVzdC9saWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0ZWN0ZWQgUUVNVSBkZWF0aCBmcm9t
IHNpZ25hbCAxMSAoU2VnbWVudGF0aW9uIGZhdWx0KSAoY29yZSBkdW1wZWQpCkVSUk9SIC0gdG9v
IGZldyB0ZXN0cyBydW4gKGV4cGVjdGVkIDY1LCBnb3QgNikKbWFrZTogKioqIFtjaGVjay1xdGVz
dC1hYXJjaDY0XSBFcnJvciAxCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE1OQogIFRFU1QgICAg
aW90ZXN0LXFjb3cyOiAxNjEKICBURVNUICAgIGlvdGVzdC1xY293MjogMTcwCi0tLQogICAgcmFp
c2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9j
ZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFi
ZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0xMDNkOTFlZTI4MWQ0MWIyYmI0YmM2MjlmZDdi
YmMxMicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5l
ZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVf
T1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAn
U0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcv
aG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6
JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1qamtsamg4NC9zcmMvZG9ja2Vy
LXNyYy4yMDIwLTA0LTEyLTE5LjQwLjUwLjEwMzQ3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11
OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD0xMDNkOTFlZTI4MWQ0MWIyYmI0YmM2MjlmZDdiYmMxMgptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1qamtsamg4NC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTRtMzAuMzU4cwp1c2VyICAgIDBt
OC44OTVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDIwMDQxMjIxMjk0My40MTE3LTEtZjRidWdAYW1zYXQub3JnL3Rlc3RpbmcuZG9ja2Vy
LXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

