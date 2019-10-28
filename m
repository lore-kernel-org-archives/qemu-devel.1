Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22679CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 09:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAB62184C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 09:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAB62184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP1hi-00044b-Vp
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 05:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iP1dP-0005dz-Ia
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iP1dM-0004BB-Un
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:48:22 -0400
Resent-Date: Mon, 28 Oct 2019 05:48:22 -0400
Resent-Message-Id: <E1iP1dM-0004BB-Un@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iP1dM-0004AI-MT
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:48:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572256059; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ET/icw2yhlRqU+uyQzs3jS1V8Q2x/mZKckZeSNPfxpGP2eXavZ5pzoVeBpj7Yp+IVcHQSTLlKck6bAUfkddNsd9L3HEXLfZd6W6gBwJMowGoPZIV9PPU1SMJn/qfqwEdy9URIjrrEaoGESskmlbQ5T0lkYMk+i4SuwTUV1jMDWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572256059;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=R/wvFqs/Wd5m/5EDUDJtat9DnHO6CIgr5lolaBjCnUo=; 
 b=P3XuE8rR7O7p515RvwBrEhSW9b7YKS+ZOCJJniiFre9WbQ0EY+MeAMZ9CZm7glrQHOS1xs77JlqENw3nV4BcMnBBAIZYs0VE3kN/QtBktlsRDPx5YGhk9RjXSB08+pEG1977Rm5JF0S6pCxeCvr2zhQlULP67mzan2cfTBXrsTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157225605747477.89060775736255;
 Mon, 28 Oct 2019 02:47:37 -0700 (PDT)
In-Reply-To: <20191028073441.6448-1-philmd@redhat.com>
Subject: Re: [PATCH 00/26] tests/acceptance: Queue for 4.2
Message-ID: <157225605580.4191.4349195077914533217@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Mon, 28 Oct 2019 02:47:37 -0700 (PDT)
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
Cc: fam@euphon.net, kamil@netbsd.org, ehabkost@redhat.com,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, chouteau@adacore.com,
 frederic.konrad@adacore.com, wainersm@redhat.com, crosa@redhat.com,
 aleksandar.rikalo@rt-rk.com, philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyODA3MzQ0MS42NDQ4
LTEtcGhpbG1kQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHFhcGkv
cWFwaS10eXBlcy1xb20ubwogIENDICAgICAgcWFwaS9xYXBpLXR5cGVzLXJkbWEubwoKV2Fybmlu
ZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvZGV2ZWwvdGVzdGlu
Zy5yc3Q6NjI5OlRpdGxlIHVuZGVybGluZSB0b28gc2hvcnQuCgpUaGUgYGBhdm9jYWRvX3FlbXUu
TWFjaGluZVRlc3RgYCBiYXNlIHRlc3QgY2xhc3MKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KICBDQyAgICAgIHFhcGkvcWFwaS10eXBlcy1yb2NrZXIubwogIENDICAg
ICAgcWFwaS9xYXBpLXR5cGVzLXJ1bi1zdGF0ZS5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTAwMTog
ZG9jcy9kZXZlbC9pbmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZp
bmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxl
ICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2MiwgaW4gPG1vZHVsZT4KLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTNkMjA2YWRhYTZiNjQ1ZGU4YTEwOGEy
ZGNjM2FiNDU4JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYn
LCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNo
ZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1iN2x1NTNkcy9zcmMvZG9j
a2VyLXNyYy4yMDE5LTEwLTI4LTA1LjQ1LjQ0LjU2MTU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQg
bm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9M2QyMDZhZGFhNmI2NDVkZThhMTA4YTJkY2MzYWI0NTgKbWFrZVsxXTogKioq
IFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtYjdsdTUzZHMvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4t
dGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMW01Mi4wMDhzCnVzZXIgICAgMG03
Ljk2MnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMTkxMDI4MDczNDQxLjY0NDgtMS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tl
ci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


