Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE9C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4022064A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4022064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXmf-0001Ov-5S
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIXdO-0006Ch-Qg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIXdN-0001W0-20
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 08:33:34 -0400
Resent-Date: Thu, 10 Oct 2019 08:33:34 -0400
Resent-Message-Id: <E1iIXdN-0001W0-20@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIXdM-0001Vo-Qf; Thu, 10 Oct 2019 08:33:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570710804; cv=none; d=zoho.com; s=zohoarc; 
 b=Jth9Umw1SaLPqUntiyM+N5WzSAL9xSd8ii470AvWO8eu7utbSzrlWP6HAI9yRPWiMxGfzwIxzfNvajQmOBeG9wlVz73F83byyFPObXNFYFID09HxgCUEFFoTXKl2nMlQ35W7wWVYK5Z7cTNWCF8S8l/BH4OjNZ4+bN5xGsidu20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570710804;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=XbQ58X9xW7Uqdxkcc9Yo/qnDb32nRp5oqvYjDj3Ry/s=; 
 b=FKz7g2YC3Rbj1JZEEllHhSYn74MIdo/hG3tWR6xzbA7IWpsQn/WdjWsKFqR2xScEEk8KEu0TPyJjw+E9MRIyKRAgehFG0W+HIoIq0/f0gIzaEuG4Pwd8s+TSzdbQnkkbQJWucIIIzWV0BoOTRb9eE/30fSslndpdpxazHa0/caQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570710802228450.0882761261963;
 Thu, 10 Oct 2019 05:33:22 -0700 (PDT)
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
Subject: Re: [PULL 00/31] s390x/tcg update
Message-ID: <157071080075.7138.17215740269377233027@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@redhat.com
Date: Thu, 10 Oct 2019 05:33:22 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, david@redhat.com,
 cohuck@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMDExMzM1Ni41MDE3
LTEtZGF2aWRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFn
ZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3Jh
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgc3R1YnMv
cGNfbWFkdF9jcHVfZW50cnkubwogIENDICAgICAgc3R1YnMvdm1nZW5pZC5vCiAgQ0MgICAgICBz
dHVicy94ZW4tY29tbW9uLm8KbWFrZTogKioqIFtNYWtlZmlsZTo5OTQ6IGRvY3MvaW50ZXJvcC9p
bmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoqKiBEZWxldGluZyBmaWxlICdkb2NzL2ludGVyb3Av
aW5kZXguaHRtbCcKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJh
Y2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9YWMzNGVjYWQzZTUzNGRmOGIwZWFjYmIyMTUyNTYzZTgnLCAnLXUnLCAn
MTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICct
ZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXdrMW90ZHViL3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMTAt
MDguMzEuMDcuMTA0MTM6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YWMzNGVj
YWQzZTUzNGRmOGIwZWFjYmIyMTUyNTYzZTgKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtd2sxb3RkdWIvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFd
IEVycm9yIDIKCnJlYWwgICAgMm0xMi40OThzCnVzZXIgICAgMG02LjY2NHMKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDEwMTEzMzU2
LjUwMTctMS1kYXZpZEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==


