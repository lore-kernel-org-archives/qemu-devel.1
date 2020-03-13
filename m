Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5FAC5ACBF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C38B2074A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C38B2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCrjW-00053J-E3
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCris-0004VF-Az
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCriq-0008My-RY
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:20:01 -0400
Resent-Date: Fri, 13 Mar 2020 17:20:01 -0400
Resent-Message-Id: <E1jCriq-0008My-RY@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCriq-0008FY-JP; Fri, 13 Mar 2020 17:20:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584134378; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b1nbbO99J2FtPa84WvcrbkBmUQi4rTt3vaY2/Kf1UVn6i/V8NfiUGOtNr4hHCRIKCqdrGaT19LErppLsaWNrmvH+csAvBQ8Qg0lJcatrtlcai5dyC0E+Q1/cLs5h6q0Jw432qDF+e5hvAVolFVbukqkVrDy33cJEg1Fm33oTPlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584134378;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=efC+Cp0TMOAJ8nOL0SZSOWVFD/g5F8RBvTFzuKGdMvY=; 
 b=VirCxz4WvDr3pFak972aLpgQe/wUVH3Ymm3+/AozhSTa8qDhBkHy/Z/pm2dlpkHRv/zy9ZV8b0qrGgAbFJ2YtLn9GdBPOL1cG761SQd+TZQ9bLrJyzs+xJcV+E0o+lp25pVlOkk/PoSTSiNKSyjoaCBULmwdp9OPYvU4VcmvtSI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584134376862439.75095409616324;
 Fri, 13 Mar 2020 14:19:36 -0700 (PDT)
In-Reply-To: <20200313184153.11275-1-philmd@redhat.com>
Subject: Re: [PATCH 0/9] user-mode: Prune build dependencies (part 2)
Message-ID: <158413437453.16773.6942591846889093601@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Fri, 13 Mar 2020 14:19:36 -0700 (PDT)
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, rth@twiddle.net, ben@skyportsystems.com,
 pl@kamp.de, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 ronniesahlberg@gmail.com, marcandre.lureau@redhat.com, imammedo@redhat.com,
 mreitz@redhat.com, philmd@redhat.com, dgilbert@redhat.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMzE4NDE1My4xMTI3
NS0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgTElOSyAgICB2aG9zdC11c2Vy
LWlucHV0CnFhcGkvcWFwaS1jb21tYW5kcy1jaGFyLm86IEluIGZ1bmN0aW9uIGBxbXBfbWFyc2hh
bF9hZGRfY2xpZW50JzoKL3RtcC9xZW11LXRlc3QvYnVpbGQvcWFwaS9xYXBpLWNvbW1hbmRzLWNo
YXIuYzo0MDQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHFtcF9hZGRfY2xpZW50Jwpjb2xsZWN0
MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFtxZW11LXN0b3Jh
Z2UtZGFlbW9uXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCiAgR0VOICAgICB4ODZfNjQtc29mdG1tdS9jb25maWctdGFyZ2V0LmgKICBHRU4gICAgIHg4
Nl82NC1zb2Z0bW11L2htcC1jb21tYW5kcy5oCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vy
cm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQg
J1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5z
dGFuY2UudXVpZD03OWZkM2RjZWQzOGM0YTY2YmViNTJhMjFhZjVlY2U5YScsICctdScsICcxMDAx
JywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywg
J1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0n
LCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScs
ICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWV1MzN2OXAxL3NyYy9kb2NrZXItc3JjLjIwMjAtMDMtMTMtMTcu
MTYuMDYuMTg4MDA6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTc5ZmQzZGNl
ZDM4YzRhNjZiZWI1MmEyMWFmNWVjZTlhCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWV1MzN2OXAxL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10g
RXJyb3IgMgoKcmVhbCAgICAzbTI4Ljg4NnMKdXNlciAgICAwbTguNTkycwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMTMxODQxNTMu
MTEyNzUtMS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

