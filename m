Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569D7FA372C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273ED21848
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 01:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273ED21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSWIy-00041K-9d
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 20:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSWIJ-0003bs-1P
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSWIH-0004Ha-3w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:09:02 -0500
Resent-Date: Wed, 06 Nov 2019 20:09:02 -0500
Resent-Message-Id: <E1iSWIH-0004Ha-3w@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSWIG-0004HI-SZ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 20:09:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573088931; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C6Vz8yk/WKZo9rUv8Ho7m8pX3xdpyxrfMB+Ece3pXCktYVTBtpLgu+p1VKWH10kGw4diOETrNqz2HI4qY5b9AQLFKXWtFhdXgHG4nMSrFWLVnt8vb8jMtUybsoi1F3ho4MFv1ylN1uZjX/iTnBhbdTEGahAZuBBTuZKdtHsWBLo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573088931;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qkhc35mD2vparqPYp/Z4EI05HhTn09K9Q9/oFyQFdVw=; 
 b=UBnruHFrDOy99yM5FbR/JB9Dr7vj1t8HocPFMtpFiNVKbOcuKl+fZn5UyFLq331n2SZcVOigQPT6O26ql0Gs4D+toDmVefrVwNg868XzQ/P2swnONYJhfifU24T2rAWn2zbrDOefRTY/1IXC5iP1LLkWibEvLYBc3+eFsUGnLUU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573088929237537.1079416749777;
 Wed, 6 Nov 2019 17:08:49 -0800 (PST)
In-Reply-To: <20191106130309.6737-1-jandryuk@gmail.com>
Subject: Re: [PATCH] qmp: Reset mon->commands on CHR_EVENT_CLOSED
Message-ID: <157308892815.21358.10901801479118764429@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jandryuk@gmail.com
Date: Wed, 6 Nov 2019 17:08:49 -0800 (PST)
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
Cc: jandryuk@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNjEzMDMwOS42NzM3
LTEtamFuZHJ5dWtAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDI2OApGYWlsdXJlczogMDYwIDA3MSAxNzYgMTg0CkZhaWxlZCA0IG9mIDEwOCBpb3Rlc3Rz
Cm1ha2U6ICoqKiBbY2hlY2stdGVzdHMvY2hlY2stYmxvY2suc2hdIEVycm9yIDEKVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5w
eSIsIGxpbmUgNjYyLCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxh
YmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Y2I3MDdiY2UwYzNjNDU2ZDhlY2VjNzBhZWIw
OGZkZGMnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmlu
ZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJF
X09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywg
J1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAn
L2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbXhsNV9qZWMvc3JjL2RvY2tl
ci1zcmMuMjAxOS0xMS0wNi0xOS41NS40Ny4yMDczNjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQg
bm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9Y2I3MDdiY2UwYzNjNDU2ZDhlY2VjNzBhZWIwOGZkZGMKbWFrZVsxXTogKioq
IFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtbXhsNV9qZWMvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4t
dGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEzbTEuODEwcwp1c2VyICAgIDBt
OC4zNzFzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE5MTEwNjEzMDMwOS42NzM3LTEtamFuZHJ5dWtAZ21haWwuY29tL3Rlc3RpbmcuZG9j
a2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


