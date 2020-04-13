Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BBC2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 00:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7486620708
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 00:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7486620708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNnAb-0006F7-Jp
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 20:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jNnA1-0005df-Os
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 20:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jNnA0-0005qc-8W
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 20:41:13 -0400
Resent-Date: Sun, 12 Apr 2020 20:41:13 -0400
Resent-Message-Id: <E1jNnA0-0005qc-8W@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jNnA0-0005pl-1D; Sun, 12 Apr 2020 20:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586738401; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TAa4hD7glGhPZC4CUy5bvYcs28EurTc51MKmuUTOA1WYJJSDAOwrv4AoCbbJxk9ZymLlPpxKastTouASIwlPBa0KHdMbqq3ChgOVv47vE6LMPdwiEdpS3jNgzYuFLVxEEo5X7Qakn528u9R+sUk3wvg0f5Wuf9IM9HRdbjU9ors=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586738401;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=V3j6Mnhyu7zXzu5q1EP1mH3AOGTvNzzUrss2N7jacJ8=; 
 b=Fu7MQjNdLguvbafMYMU/RvqgZ+z7MPktIfmp/JEUgW6zue/AGQFYkMd1+xRlzg8qR3b/4JjQ3QnBq/wP+RefZ5FX0OKrv9ZmD0OUewB6XyP1c/KrzNu4/pbkqparAroit9ptSB5mB3zBUpTXOs1yXDH3bN9G8pU+OsPQyt1xyxI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586738398626207.21748152433838;
 Sun, 12 Apr 2020 17:39:58 -0700 (PDT)
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
Subject: Re: [PATCH-for-5.1 v3 00/24] various: Fix error-propagation with
 Coccinelle scripts (part 1)
Message-ID: <158673839497.24582.16303937590417582232@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 12 Apr 2020 17:39:58 -0700 (PDT)
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
Cc: fam@euphon.net, peter.maydell@linaro.org, sagark@eecs.berkeley.edu,
 mst@redhat.com, codyprime@gmail.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, Alistair.Francis@wdc.com, edgar.iglesias@gmail.com,
 mreitz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, joel@jms.id.au,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au, philmd@redhat.com,
 ehabkost@redhat.com, jcd@tribudubois.net, xiechanglong.d@gmail.com,
 alistair@alistair23.me, b.galvani@gmail.com, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, clg@kaod.org, qemu-ppc@nongnu.org, rth@twiddle.net,
 kwolf@redhat.com, qemu-riscv@nongnu.org, andrew@aj.id.au,
 wencongyang2@huawei.com, f4bug@amsat.org, sundeep.lkml@gmail.com,
 palmer@dabbelt.com, kbastian@mail.uni-paderborn.de, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxMjIyMzYxOS4xMTI4
NC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpSQU1CbG9jayAic3JhbSBBIiBhbHJl
YWR5IHJlZ2lzdGVyZWQsIGFib3J0IQpCcm9rZW4gcGlwZQovdG1wL3FlbXUtdGVzdC9zcmMvdGVz
dHMvcXRlc3QvbGlicXRlc3QuYzoxNzU6IGtpbGxfcWVtdSgpIGRldGVjdGVkIFFFTVUgZGVhdGgg
ZnJvbSBzaWduYWwgNiAoQWJvcnRlZCkgKGNvcmUgZHVtcGVkKQpFUlJPUiAtIHRvbyBmZXcgdGVz
dHMgcnVuIChleHBlY3RlZCA2LCBnb3QgNSkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0
XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVT
VCAgICBpb3Rlc3QtcWNvdzI6IDE3OQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxODEKLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWFiYzRmMDkwODJhODQ0MGViODE2Njg2
ZDdmOWQ3YTk4JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2Fj
aGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOTlrYndlcmIvc3JjL2Rv
Y2tlci1zcmMuMjAyMC0wNC0xMi0yMC4yNy4yMy43MDkyOi92YXIvdG1wL3FlbXU6eixybycsICdx
ZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5l
ZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUu
aW5zdGFuY2UudXVpZD1hYmM0ZjA5MDgyYTg0NDBlYjgxNjY4NmQ3ZjlkN2E5OAptYWtlWzFdOiAq
KiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC05OWtid2VyYi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1
bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTJtMzIuODg3cwp1c2VyICAg
IDBtOS40NDFzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDQxMjIyMzYxOS4xMTI4NC0xLWY0YnVnQGFtc2F0Lm9yZy90ZXN0aW5nLmRv
Y2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

