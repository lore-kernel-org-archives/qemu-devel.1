Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AB9C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C236C21736
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 20:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C236C21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaQsP-0001NU-RD
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 15:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iaNfM-00005g-6H
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iaNfF-0007Eq-GX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:33:15 -0500
Resent-Date: Thu, 28 Nov 2019 12:33:15 -0500
Resent-Message-Id: <E1iaNfF-0007Eq-GX@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iaNfE-0006vE-VK
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:33:13 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574962382; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FaUDyNssY7gQxlpKIidxYs7ZE1SyZ8QgAFeg2ElzI7dXyCH4pGOREU/a4jKtprjHit61LU6Zr6VYyMO7XihlLMr4Zs4779QJvi4rNkxFytD7Nc73/O3NaATcIMXDtVWry9YY5yaKN6CWlgnSzar7Ggn68PvbDqnc9SzTm0FDgVs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574962382;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=XXyZczlByW7+uAp7bkhqIXnuj3wLyImBQipwPfVfaeI=; 
 b=cwUpTtvuBdUo8h/xeuI4B5snVPTr048pvlNVXP8XZDd3MuQIHI0B7UZDlu7vo7UKQ8Van7Lda8zaw6Nw56biVfCsbljLoW7Sr9ZZpm+U7JDbxmOcxYpukrBg0ew7tuK2g0Mb+dbN1yKRFSP6mQdJ6qNj2f5KghlBUrMyNDcW/CA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574962380826376.6824759218392;
 Thu, 28 Nov 2019 09:33:00 -0800 (PST)
In-Reply-To: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
Subject: Re: [RFC 0/1] ATI R300 emulated grpahics card V2
Message-ID: <157496237968.16987.14457691019374601987@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aaron.zakhrov@gmail.com
Date: Thu, 28 Nov 2019 09:33:00 -0800 (PST)
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
Cc: qemu-devel@nongnu.org, aaron.zakhrov@gmail.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyODA2NDM1MC4yMDcy
Ny0xLWFhcm9uLnpha2hyb3ZAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi90bXAvcWVtdS10ZXN0
L3NyYy9ody9kaXNwbGF5L3hsbnhfZHAuYzo1MDQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGF1
eF9yZXF1ZXN0JwouLi9ody9kaXNwbGF5L2RwY2QubzogSW4gZnVuY3Rpb24gYGRwY2RfaW5pdCc6
Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9kaXNwbGF5L2RwY2QuYzoxNDE6IHVuZGVmaW5lZCByZWZl
cmVuY2UgdG8gYGF1eF9pbml0X21taW8nCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBl
eGl0IHN0YXR1cwptYWtlWzFdOiAqKiogW3FlbXUtc3lzdGVtLWFhcmNoNjRdIEVycm9yIDEKbWFr
ZTogKioqIFthYXJjaDY0LXNvZnRtbXUvYWxsXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCByZWNl
bnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2
MiwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPTYzODJmN2Y1ZGE5ZTQwOGU4NjQ5NDEyYmY0YWFkNzM5JywgJy11
JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0x
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYzZnMnpvZ3Mvc3JjL2RvY2tlci1zcmMuMjAxOS0x
MS0yOC0xMi4zMC4yMS43NjUwOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAn
L3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0
IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD02
MzgyZjdmNWRhOWU0MDhlODY0OTQxMmJmNGFhZDczOQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5d
IEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1jNmcyem9ncy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNl
bnRvczddIEVycm9yIDIKCnJlYWwgICAgMm0zOC40NjdzCnVzZXIgICAgMG04LjI5OHMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTI4
MDY0MzUwLjIwNzI3LTEtYWFyb24uemFraHJvdkBnbWFpbC5jb20vdGVzdGluZy5kb2NrZXItcXVp
Y2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


