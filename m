Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA7DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 23:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0252206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 23:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0252206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPae8-0004Ld-Qa
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 19:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jPadS-0003cC-GZ
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 19:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jPadQ-0007he-8V
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 19:43:01 -0400
Resent-Date: Fri, 17 Apr 2020 19:43:01 -0400
Resent-Message-Id: <E1jPadQ-0007he-8V@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jPadQ-0007cF-2E
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 19:43:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587166951; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=G+5BEK5L95NeaXTIpDJ0btyedxEfijE9Tpb+wjTp649u2euomoWzyb7ADvKXh9jx37wIr0Fn4WnKk0uwalGMnUlyvSAkT8FkBGKCEVPfX2yOsZXBbi7Tgx4qWaBptx7nxFCjA+2EcKhUgeIr55tKMfEh2reJnGy+0q5ngGCx4+Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587166951;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=B66VasDEKopQEm6VWhaXETHzzMl8fMDRnWf79EhjiZM=; 
 b=OM5KTIS13h11FnhaHctEtEEwypyTf5/ysKyJgOHiV6HL7WVNIn7PrwID9MIANoepdtELbk4iSxh4EZsvSzgTZdsiQXEADuMMGqc0ISyEtiTWr9ZriYSgUjIijtMK+E8gNzqhYDmUQIsGKtcLTkwSEzKF4pgeni2h6t83vvQw1sQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158716694828942.07654532084155;
 Fri, 17 Apr 2020 16:42:28 -0700 (PDT)
In-Reply-To: <20200417191022.5247-1-edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 0/6] target-microblaze: Misc configurability #2
Message-ID: <158716694636.22793.15430909726591916671@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: edgar.iglesias@gmail.com
Date: Fri, 17 Apr 2020 16:42:28 -0700 (PDT)
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, sstabellini@kernel.org, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNzE5MTAyMi41MjQ3
LTEtZWRnYXIuaWdsZXNpYXNAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCisrKyAvdG1wL3FlbXUt
dGVzdC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMvMDQxLm91dC5iYWQgMjAyMC0wNC0xNyAyMzoz
NTozMy4yOTg4Njc5MDcgKzAwMDAKQEAgLTEsNSArMSwzMCBAQAotLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLgorV0FSTklORzpxZW11Lm1hY2hpbmU6cWVtdSByZWNlaXZlZCBz
aWduYWwgOTogL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLy4uLy4uL3g4
Nl82NC1zb2Z0bW11L3FlbXUtc3lzdGVtLXg4Nl82NCAtZGlzcGxheSBub25lIC12Z2Egbm9uZSAt
Y2hhcmRldiBzb2NrZXQsaWQ9bW9uLHBhdGg9L3RtcC90bXAuZEtYSlVhbURSQy9xZW11LTIyMTc0
LW1vbml0b3Iuc29jayAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAtcXRlc3QgdW5peDpw
YXRoPS90bXAvdG1wLmRLWEpVYW1EUkMvcWVtdS0yMjE3NC1xdGVzdC5zb2NrIC1hY2NlbCBxdGVz
dCAtbm9kZWZhdWx0cyAtZGlzcGxheSBub25lIC1hY2NlbCBxdGVzdCAtZHJpdmUgaWY9dmlydGlv
LGlkPWRyaXZlMCxmaWxlPS90bXAvcWVtdS10ZXN0L3Rlc3QuaW1nLGZvcm1hdD1xY293MixjYWNo
ZT13cml0ZWJhY2ssYWlvPXRocmVhZHMsbm9kZS1uYW1lPXRvcCxiYWNraW5nLm5vZGUtbmFtZT1i
YXNlIC1kcml2ZSBpZj1pZGUsaWQ9ZHJpdmUxLG1lZGlhPWNkcm9tCisuLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li5FLi4uLi4uLi4uLi4uLi4uLi4uCis9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CitFUlJPUjogdGVzdF9wYXVzZSAo
X19tYWluX18uVGVzdFNpbmdsZURyaXZlVW5hbGlnbmVkTGVuZ3RoKQorLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQor
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgorICBGaWxlICIwNDEiLCBsaW5lIDEw
OCwgaW4gdGVzdF9wYXVzZQotLS0KIFJhbiA5NCB0ZXN0cwogCi1PSworRkFJTEVEIChlcnJvcnM9
MSkKICBURVNUICAgIGlvdGVzdC1xY293MjogMDQyCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0
MwpxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNjZWwga3ZtOiBpbnZhbGlkIGFjY2VsZXJhdG9yIGt2
bQotLS0KTm90IHJ1bjogMjU5CkZhaWx1cmVzOiAwNDEKRmFpbGVkIDEgb2YgMTE3IGlvdGVzdHMK
bWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3IgMQptYWtlOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRlc3QtYWFy
Y2g2NDogdGVzdHMvcXRlc3QvcW9zLXRlc3QKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Nzk1ODIxODgzYTg5
NDYyMDliMzc1YzY0Mjc3ZjZhN2InLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9j
Y2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92
YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1vOXRx
bGtwcy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTE3LTE5LjI4LjA1LjI0Mzg6L3Zhci90bXAvcWVt
dTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNr
J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJl
bD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTc5NTgyMTg4M2E4OTQ2MjA5YjM3NWM2NDI3N2Y2YTdi
Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW85dHFsa3BzL3NyYycKbWFrZTogKioq
IFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxNG0yMS45
OTFzCnVzZXIgICAgMG04Ljc2OHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDE3MTkxMDIyLjUyNDctMS1lZGdhci5pZ2xlc2lhc0Bn
bWFpbC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

