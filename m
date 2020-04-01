Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410DDC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F408B2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F408B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJYpM-0002OC-4w
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 04:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJYom-0001rB-Ii
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJYoj-0006Yp-2S
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:33:47 -0400
Resent-Date: Wed, 01 Apr 2020 04:33:47 -0400
Resent-Message-Id: <E1jJYoj-0006Yp-2S@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJYoi-0006WL-R7; Wed, 01 Apr 2020 04:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585730017; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Tt8CpCL1OdfEkApNsS7bmwTzxwfi2yR17PxTvlc+71+zhPQ83s6p69v1M4SmS4xROgOw49zkGyoVbiQO/XOtURpz3yrqXnCbLolc9c/jht1iPhDclt3INtfhwvToBq/xmNdgJ2cSqV4S3NVyiCKryUv5cC2Lp1+gwz2SbE5VCEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585730017;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=LrRACZdv9AtNjAtBTf1pLdMutUPGjSImCvCk379hTgA=; 
 b=SCANabNs9aO0LIH1vIDc6O0FDQxfhraUKNrGjz0UXM6Qx/TYfV2J3AOMIsZzOcrq6Sk1be6uEhhTIl6sQJ9Qv/Ayj48w5W5f0zw4CRIDvt2AetXMZvkr3NbljW86QAnTDVSGzN6h6wvBk0ukzkaz5OZNHrD62ZBRoV7oJCwimaA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585730015019260.88486222901236;
 Wed, 1 Apr 2020 01:33:35 -0700 (PDT)
In-Reply-To: <20200331222442.273158-1-eblake@redhat.com>
Subject: Re: [PATCH for-5.0?] qemu-img: Report convert errors by bytes,
 not sectors
Message-ID: <158573001353.20343.7334679986961252833@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Wed, 1 Apr 2020 01:33:35 -0700 (PDT)
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMzMTIyMjQ0Mi4yNzMx
NTgtMS1lYmxha2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9
eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
QlVJTEQgICBwYy1iaW9zL29wdGlvbnJvbS9wdmguaW1nCiAgQlVJTEQgICBwYy1iaW9zL29wdGlv
bnJvbS9wdmgucmF3CiAgU0lHTiAgICBwYy1iaW9zL29wdGlvbnJvbS9wdmguYmluCi90bXAvcWVt
dS10ZXN0L3NyYy9xZW11LWltZy5jOjE5Mjg6Mzg6IGVycm9yOiBmb3JtYXQgc3BlY2lmaWVzIHR5
cGUgJ2xvbmcnIGJ1dCB0aGUgYXJndW1lbnQgaGFzIHR5cGUgJ3Vuc2lnbmVkIGxvbmcgbG9uZycg
Wy1XZXJyb3IsLVdmb3JtYXRdCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIjogJXMiLCBz
ZWN0b3JfbnVtICogQkRSVl9TRUNUT1JfU0laRSwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9xZW11LWltZy5jOjE5NTg6Mzg6IGVycm9yOiBmb3JtYXQgc3BlY2lmaWVzIHR5cGUgJ2xvbmcn
IGJ1dCB0aGUgYXJndW1lbnQgaGFzIHR5cGUgJ3Vuc2lnbmVkIGxvbmcgbG9uZycgWy1XZXJyb3Is
LVdmb3JtYXRdCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIjogJXMiLCBzZWN0b3JfbnVt
ICogQkRSVl9TRUNUT1JfU0laRSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CjIgZXJyb3JzIGdlbmVyYXRlZC4KbWFrZTog
KioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBxZW11LWltZy5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9z
dCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBs
aW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0
Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRv
JywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPWYwMjA4MWQ1OWIyYTQzNDk4NTc2YWE4YjYyOWQyMzMwJywgJy11JywgJzEwMDMnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VU
X0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1qX2hkM3dyNS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0
LTAxLTA0LjI5LjE5LjMxMTc0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWYw
MjA4MWQ1OWIyYTQzNDk4NTc2YWE4YjYyOWQyMzMwCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLWpfaGQzd3I1L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVk
b3JhXSBFcnJvciAyCgpyZWFsICAgIDRtMTIuODIxcwp1c2VyICAgIDBtOC4xOTRzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMzMTIy
MjQ0Mi4yNzMxNTgtMS1lYmxha2VAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

