Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A12C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D18F222C4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 17:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D18F222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGRHx-0003YC-Jc
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 13:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iGRHA-00030D-GV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iGRH8-0007OO-Sm
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:21:56 -0400
Resent-Date: Fri, 04 Oct 2019 13:21:56 -0400
Resent-Message-Id: <E1iGRH8-0007OO-Sm@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iGRH8-0007N2-LO
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 13:21:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570209695; cv=none; d=zoho.com; s=zohoarc; 
 b=FucAPdRI2OSYmkc4eCnxH4w85eHyIFT63gazf7tWvnZzdlNLYy1b1HHrfr8qL2GADQ8HcOJFrRgsmG6yq2r756fKrrwU9mSSqG47Qp4JiXJbQOyyz6mZHAk/hadugA5k/0IaHut8P6qg5EScbqevBz3YGsZuSBz6GArnz8+in2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570209695;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Cgv/L+6doEdB2hQJhrzHtwKrEV0kNQe4NSg6b/1bSbs=; 
 b=CrKePBFQqvkYVirAFI42XcVCKYAuPUlNaD2KDS6m0R0zlmqVxRf2UXcaOViZDHzazgO9Zd1J0+wCYdz/blMC2vUMrRmw50AburYtr8pT1LoUTZWssppLTW6PKzssnFPxHOhG+ev47U9htYn8OzcVCw83iqSlHLvgT5wH+a5n6qM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570209694572918.6568261133801;
 Fri, 4 Oct 2019 10:21:34 -0700 (PDT)
Subject: Re: [PATCH v6 00/10] Introduce the microvm machine type
In-Reply-To: <20191004093752.16564-1-slp@redhat.com>
Message-ID: <157020969258.31166.12339648498600507707@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: slp@redhat.com
Date: Fri, 4 Oct 2019 10:21:34 -0700 (PDT)
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
Cc: ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwNDA5Mzc1Mi4xNjU2
NC0xLXNscEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCnFlbXUtc3lzdGVtLXg4Nl82NDogbWlz
c2luZyBrZXJuZWwgaW1hZ2UgZmlsZSBuYW1lLCByZXF1aXJlZCBieSBtaWNyb3ZtCkJyb2tlbiBw
aXBlCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9saWJxdGVzdC5jOjE0MDoga2lsbF9xZW11KCkg
dHJpZWQgdG8gdGVybWluYXRlIFFFTVUgcHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0
dXMgMSAoZXhwZWN0ZWQgMCkKRVJST1IgLSB0b28gZmV3IHRlc3RzIHJ1biAoZXhwZWN0ZWQgNywg
Z290IDQpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxCm1ha2U6ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE1
OQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxNjEKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPTQ3OWE0MmVlOGQ3NjQzMjdiZmIzOTI0MDY5YzhlMmRjJywgJy11JywgJzEw
MDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1l
JywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNh
Y2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtMGRmYl9kc3Qvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0wNC0x
My4xMC41MC40ODk0Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD00NzlhNDJl
ZThkNzY0MzI3YmZiMzkyNDA2OWM4ZTJkYwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC0wZGZiX2RzdC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczdd
IEVycm9yIDIKCnJlYWwgICAgMTBtNDIuODMxcwp1c2VyICAgIDBtOC41MDBzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAwNDA5Mzc1
Mi4xNjU2NC0xLXNscEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


