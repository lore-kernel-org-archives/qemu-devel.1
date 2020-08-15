Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A71C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072332310F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072332310F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xyV-00060Z-9K
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6xve-0001yK-32
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:17:06 -0400
Resent-Date: Sat, 15 Aug 2020 11:17:06 -0400
Resent-Message-Id: <E1k6xve-0001yK-32@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6xvZ-0001eH-SC
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597504611; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NSATkHUNeQVkEmg+vh9Ci0MTQjkP7BEjscaX9/wYklvYpzMyB0iLI/d4hWVVGXY3FZOlXoXXjUZRPsZTkRP5ps5L2F5CtvlwD4uSUqmxgU2/c44PnkD/QADr064QLSKjapuriLZkV/nzI1VHZEEpBv21Q+Z8sFghzGiccLpAtyo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597504611;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gZQNbp7wnBRo5skkuFkrCvtI1fdvRLdGuJjCJr/pwlU=; 
 b=egTGHNbNKg3OpCb3iWKeDkfEculELCe5UKV//kz4Y1Q+wAuoo/3nBN996O0WLOpzuCYmH5gyOrVCreCsDm221X+MH6gP0W7rAF0GcRPHXW1cmX+mw3hKsrUrWaSYeJaHTs4SBQGjerwSLZKBx3yez+MiMTZ9Ai9yLeg3e00jxwE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597504607337478.68156212775943;
 Sat, 15 Aug 2020 08:16:47 -0700 (PDT)
Subject: Re: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
Message-ID: <159750460630.7155.8519395038959578037@66eaa9a8a123>
In-Reply-To: <20200815130046.5344-1-rohit.shinde12194@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rohit.shinde12194@gmail.com
Date: Sat, 15 Aug 2020 08:16:47 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/15 11:03:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: mdroth@linux.vnet.ibm.com, rohit.shinde12194@gmail.com,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNTEzMDA0Ni41MzQ0
LTEtcm9oaXQuc2hpbmRlMTIxOTRAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9z
NyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1df
RU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBx
YXBpL3FhcGktdmlzaXQtYmxvY2subwogIENDICAgICAgcWFwaS9xYXBpLXZpc2l0LWNoYXIubwov
dG1wL3FlbXUtdGVzdC9zcmMvcWFwaS9vcHRzLXZpc2l0b3IuYzogSW4gZnVuY3Rpb24gJ29wdHNf
bmV4dF9saXN0JzoKL3RtcC9xZW11LXRlc3Qvc3JjL3FhcGkvb3B0cy12aXNpdG9yLmM6MjY5Ojk6
IGVycm9yOiBlbXB0eSBkZWNsYXJhdGlvbiBbLVdlcnJvcl0KICAgICAgICAgX19hdHRyaWJ1dGVf
XygoZmFsbHRocm91Z2gpKTsKICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlOiAqKiogW3FhcGkvb3B0cy12aXNpdG9yLm9dIEVycm9yIDEKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJl
Y2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUg
NzA5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2Rl
LCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAn
LW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
MGIzNThjMjQ1YmZiNGYxZWJjYzQ3YmQ2NjBmMjQzZDMnLCAnLXUnLCAnMTAwMycsICctLXNlY3Vy
aXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElT
VD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9
MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJ
Uj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9j
a2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtaGJmcDk1N3Avc3JjL2RvY2tlci1zcmMuMjAyMC0wOC0xNS0xMS4xNC40NC4xNTAy
NjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MGIzNThjMjQ1YmZiNGYxZWJj
YzQ3YmQ2NjBmMjQzZDMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaGJmcDk1N3Av
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpy
ZWFsICAgIDJtMi4yNDlzCnVzZXIgICAgMG03Ljg3MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwODE1MTMwMDQ2LjUzNDQtMS1yb2hp
dC5zaGluZGUxMjE5NEBnbWFpbC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

