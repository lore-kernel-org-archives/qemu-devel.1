Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF47CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 12:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 805EB2190F
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 12:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805EB2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMA6S-0005Iq-Jv
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 08:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMA5c-0004pL-MX
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 08:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMA5b-0003yy-7b
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 08:13:40 -0400
Resent-Date: Sun, 20 Oct 2019 08:13:40 -0400
Resent-Message-Id: <E1iMA5b-0003yy-7b@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMA5a-0003xD-2P
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 08:13:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571573600; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MoCHUY8iTJ9D1IUIWKAHafspqrpBQFT5INE0VIFCTVQBpmR0NAQwKEpBtMsDkWGm71dyo8omEYmzvDdEBq3z75f70KrR2Ud0ujIJmf0cjXPwIEsUWxuz6cAEuhhgeuWPfoorT2vnt6Hlt0dQ7QtJoyVaha+1y9poSyuygGsOvWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571573600;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DwnOLZ5nB4xhwWefCGxil/BwkpQq4wbB8JpxlNfJlm4=; 
 b=I0UOqgAEEmOTEbepsloq7xdqMDXobGvBSlDTWULWNl8C2BTXoyDM6I1+C8aXt+zGNwTnjSd0u/WSIH2sg6TLszAk/E8LCvL+qXxJ+ag5D3kxXWDz/7xjPXfz+NL/MZ1y5SPK4CYPeFxz5NMMMnLjQktg3rgQM/ykH1B2z1zaEfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571573599991606.6435414492414;
 Sun, 20 Oct 2019 05:13:19 -0700 (PDT)
In-Reply-To: <20191020111125.27659-1-tao3.xu@intel.com>
Subject: Re: [PATCH v13 00/12] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
Message-ID: <157157359827.24734.15662324450185905637@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Sun, 20 Oct 2019 05:13:19 -0700 (PDT)
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, tao3.xu@intel.com,
 fan.du@intel.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMDExMTEyNS4yNzY1
OS0xLXRhbzMueHVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkxvb2tpbmcgZm9yIGV4cGVjdGVk
IGZpbGUgJ3Rlc3RzL2RhdGEvYWNwaS9wYy9TUkFULmFjcGlobWF0JwpMb29raW5nIGZvciBleHBl
Y3RlZCBmaWxlICd0ZXN0cy9kYXRhL2FjcGkvcGMvU1JBVCcKKioKRVJST1I6L3RtcC9xZW11LXRl
c3Qvc3JjL3Rlc3RzL2Jpb3MtdGFibGVzLXRlc3QuYzozNTQ6bG9hZF9leHBlY3RlZF9hbWw6IGFz
c2VydGlvbiBmYWlsZWQ6IChleHBfc2R0LmFtbF9maWxlKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJP
UjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvYmlvcy10YWJsZXMtdGVzdC5jOjM1NDpsb2FkX2V4
cGVjdGVkX2FtbDogYXNzZXJ0aW9uIGZhaWxlZDogKGV4cF9zZHQuYW1sX2ZpbGUpCm1ha2U6ICoq
KiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZp
bmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAzNgogIFRFU1QgICAgaW90
ZXN0LXFjb3cyOiAwMzcKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwg
Y21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1u
JywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTFh
NjIyZGJkYzgyMzQxZjQ5OTcwY2Q5MjIwM2Q5YmNkJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0
eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9
JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0
JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9
L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2Vy
LWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtNmk4bjRvOW0vc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0yMC0wOC4wMy4yMi4xNjExNTov
dmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywg
J3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0t
ZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MWE2MjJkYmRjODIzNDFmNDk5NzBj
ZDkyMjAzZDliY2QKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExl
YXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNmk4bjRvOW0vc3Jj
JwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFs
ICAgIDltNTYuNjE0cwp1c2VyICAgIDBtNi41OTFzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAyMDExMTEyNS4yNzY1OS0xLXRhbzMu
eHVAaW50ZWwuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


