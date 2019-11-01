Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B99DCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBCA208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 12:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBCA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQVeG-0007Sb-99
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 08:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iQVcg-00067z-5P
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iQVca-0006o3-Kz
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 08:01:45 -0400
Resent-Date: Fri, 01 Nov 2019 08:01:45 -0400
Resent-Message-Id: <E1iQVca-0006o3-Kz@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iQVca-0006kZ-D9; Fri, 01 Nov 2019 08:01:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572609680; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eK3rhbvc9Ke05AvCj2Zyj10PDJxgVg191hAcWDZhSoMRWDEORQ75SoVL/XBIFtPi/N5WYRTC+XtCJFC09uwQ6L98VDqebtktUGFd7S+pTIejohyR7+WM0r5bsjp9pYfPR8gsnIhU6B27q3pZr8csrQPvC6bJXYEgNE8Fgo8beD8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572609680;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=T++H83sSwtBJ4X02+3lIWcqT5603KG9JI5Gl25Lu4xM=; 
 b=O5TPfdQh7+wop6Oyg9w/56AkM5vFZTbEW+WJcQwlyJPPu3dDIzyCZ7tamVIs2fUWokg9CyXYpB88l4xC1wDr2h1+gW70fy/V+QJ0LKMHsgFtL/ljxEjkDmdazx/kR/q0nWa55PpcIeBua+s7qtKzkKvLx9HDeodtfMbtAU6AZUw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572609678113103.3370246499004;
 Fri, 1 Nov 2019 05:01:18 -0700 (PDT)
In-Reply-To: <20191101103232.3692818-1-luc.michel@greensocs.com>
Subject: Re: [PATCH] hw/arm/pxa2xx: rebuild hflags cache when modifying CPU
 state
Message-ID: <157260967693.11413.16298730643618763413@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: luc.michel@greensocs.com
Date: Fri, 1 Nov 2019 05:01:18 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwMTEwMzIzMi4zNjky
ODE4LTEtbHVjLm1pY2hlbEBncmVlbnNvY3MuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9z
NyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1df
RU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBh
YXJjaDY0LXNvZnRtbXUvaHcvYXJtL2FsbHdpbm5lci1hMTAubwogIENDICAgICAgYWFyY2g2NC1z
b2Z0bW11L2h3L2FybS9jdWJpZWJvYXJkLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2FybS9weGEy
eHguYzogSW4gZnVuY3Rpb24gJ3B4YTJ4eF9wd3Jtb2RlX3dyaXRlJzoKL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L2FybS9weGEyeHguYzozMDk6OTogZXJyb3I6IGluY29tcGF0aWJsZSB0eXBlIGZvciBh
cmd1bWVudCAxIG9mICdhcm1fcmVidWlsZF9oZmxhZ3MnCiAgICAgICAgIGFybV9yZWJ1aWxkX2hm
bGFncyhzLT5jcHUtPmVudik7CiAgICAgICAgIF4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAv
cWVtdS10ZXN0L3NyYy9ody9hcm0vcHhhMnh4LmM6MTU6MDoKL3RtcC9xZW11LXRlc3Qvc3JjL3Rh
cmdldC9hcm0vY3B1Lmg6MzMwNDo2OiBub3RlOiBleHBlY3RlZCAnc3RydWN0IENQVUFSTVN0YXRl
IConIGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlICdDUFVBUk1TdGF0ZScKIHZvaWQgYXJtX3JlYnVp
bGRfaGZsYWdzKENQVUFSTVN0YXRlICplbnYpOwogICAgICBeCm1ha2VbMV06ICoqKiBbaHcvYXJt
L3B4YTJ4eC5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpv
YnMuLi4uCm1ha2U6ICoqKiBbYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgptYWtlOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIExJTksgICAgeDg2XzY0LXNvZnRtbXUv
cWVtdS1zeXN0ZW0teDg2XzY0ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKLS0t
CiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNh
bGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4n
LCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWY3MWZhNWJhYzQ0MjRkZWY4NDVi
Njc3YWFkN2YxOTlhJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11
bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NP
TkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScs
ICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywg
Jy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAv
Y2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZfdGxma3FyL3Ny
Yy9kb2NrZXItc3JjLjIwMTktMTEtMDEtMDcuNTcuNDAuMTk4OTc6L3Zhci90bXAvcWVtdTp6LHJv
JywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJl
dHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20u
cWVtdS5pbnN0YW5jZS51dWlkPWY3MWZhNWJhYzQ0MjRkZWY4NDViNjc3YWFkN2YxOTlhCm1ha2Vb
MV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBg
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZfdGxma3FyL3NyYycKbWFrZTogKioqIFtkb2Nr
ZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTM2LjY4MHMKdXNl
ciAgICAwbTcuMTg2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAxOTExMDExMDMyMzIuMzY5MjgxOC0xLWx1Yy5taWNoZWxAZ3JlZW5zb2Nz
LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


