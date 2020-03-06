Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC09BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F39E2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F39E2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35633 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABbC-0002yR-Lf
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jABaG-00025L-Ad
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jABaD-0002mx-Oy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:56:02 -0500
Resent-Date: Fri, 06 Mar 2020 06:56:02 -0500
Resent-Message-Id: <E1jABaD-0002mx-Oy@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21167)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jABaD-0002lU-GY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:56:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583495756; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FVcWif9bomixlv1HVAxqsmpndHELD/HH0dwAcI/x4IKxGNyZPDB1+iQYNgNUZCuLofRRrxSNaqnWgx9vE0mbCGT9AICwI09p5e1imlO9InTeupQM9wRDVMluPzZaJvq2l/s2c5eexroEKb+jj8hiWNuvYgTiBMkGzKvDIsEEV74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583495756;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RpwVR7DYFxPzpM0KSD1fyVzlNE73l5vutWpxIJtZvcA=; 
 b=PGqLfd69qHqqFfSJg7QMtHYjdZAbYvkcQqHWPd9kiI6YWcdFnWSo1dmPik3A1CMDp1YcptDBiS78EW0Z3MJVLcFUzEv4bwT+0eogrxPlDYw1WSpKWDA91+EsC/rKmPOmxGmWh9v/WraR53QQUFRlGthzTjBrmTPWAb2JtmGnd+A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583495755541956.3326981011636;
 Fri, 6 Mar 2020 03:55:55 -0800 (PST)
In-Reply-To: <20200306110959.29461-1-peter.maydell@linaro.org>
Subject: Re: [PULL 00/33] docs queue
Message-ID: <158349575451.14509.318244585322315288@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Fri, 6 Mar 2020 03:55:55 -0800 (PST)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwNjExMDk1OS4yOTQ2
MS0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGaWxlOiAi
L3RtcC9xZW11LW5zaXNccWVtdS1kb2MuaHRtbCIgLT4gbm8gZmlsZXMgZm91bmQuClVzYWdlOiBG
aWxlIFsvbm9uZmF0YWxdIFsvYV0gKFsvcl0gWy94IGZpbGVzcGVjIFsuLi5dXSBmaWxlc3BlYyBb
Li4uXSB8CiAgIC9vbmFtZT1vdXRmaWxlIG9uZV9maWxlX29ubHkpCkVycm9yIGluIHNjcmlwdCAi
L3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUubnNpIiBvbiBsaW5lIDE4MCAtLSBhYm9ydGluZyBjcmVh
dGlvbiBwcm9jZXNzCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTE2MjogcWVtdS1zZXR1cC00LjIuNTAu
ZXhlXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIu
L3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5l
eGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21k
KQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywg
J2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWUzMGZl
ZWMxMzJlNTRiMmNhOTAyNDYxMTc5OWVlMjc5JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1v
cHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9Jywg
Jy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0Jywg
Jy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFy
L3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC00ajV6NjNibC9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTA2LTA2LjUxLjQ2LjIwMDU4Oi92YXIv
dG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWUzMGZlZWMxMzJlNTRiMmNhOTAyNDYxMTc5
OWVlMjc5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTRqNXo2M2JsL3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDRt
Ny44NTNzCnVzZXIgICAgMG02LjAxOXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzA2MTEwOTU5LjI5NDYxLTEtcGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

