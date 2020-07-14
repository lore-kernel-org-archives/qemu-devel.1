Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BE4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3E62242B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3E62242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOFA-0000BW-5r
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvOEV-00083r-Eb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:56:43 -0400
Resent-Date: Tue, 14 Jul 2020 12:56:43 -0400
Resent-Message-Id: <E1jvOEV-00083r-Eb@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvOES-0000ZI-Be
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:56:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594745791; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NDvYtxpFvXiD0DRe2lMQOp3TesWe+5OQqfxom5rMfH97eexUQI66f3akNPe3J4ysZu9lz1qJb8z+99mV9ppESr8XUWEmBdqeLZpXjHoiNEwtFnSkZdhxh/XnHVIh1VYtVgtZUYUMD5f2k3n05FkMHkm1/ElsFoGK7/zYlBkegiU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594745791;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ml7CFBKqRZwZ+6Uv0DoyHupvTdQwA1YIOqej4x+RJ1M=; 
 b=mP5D1Mtsf02/cJMsQ17Rv45rjkJu3Jb94OxPvwBJQMfy+MuuihUxlMpKCJZSpbcWBvM3z59ncngLA8B6BjHopnbVR+6XMUwDLUQxjSXtixag5NDxDWJPlK2oiRo7uSaw9mTcJAPRKALlM3Kw0WDriw3FGYSqO3muh1AhT/KUHwA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594745789179278.1389165505093;
 Tue, 14 Jul 2020 09:56:29 -0700 (PDT)
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
Message-ID: <159474578789.11884.16490874844484193586@07a7f0d89f7d>
In-Reply-To: <20200714162659.1017432-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Tue, 14 Jul 2020 09:56:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:56:38
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDE2MjY1OS4xMDE3
NDMyLTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tl
ci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dA
ZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
YXV0aHovdHJhY2UubwogIENDICAgICAgYmxvY2svdHJhY2UubwoKV2FybmluZywgdHJlYXRlZCBh
cyBlcnJvcjoKLi4vc3JjL2RvY3MvcWVtdS1vcHRpb24tdHJhY2UucnN0LmluYzoyMTpEdXBsaWNh
dGUgZXhwbGljaXQgdGFyZ2V0IG5hbWU6ICJjbWRvcHRpb24tcWVtdS1pbWctdHJhY2UiLgogIEND
ICAgICAgaW8vdHJhY2UubwogIENDICAgICAgbmJkL3RyYWNlLm8KICBDQyAgICAgIHNjc2kvdHJh
Y2UubwogIENDICAgICAgYXVkaW8vdHJhY2UubwoKV2FybmluZywgdHJlYXRlZCBhcyBlcnJvcjoK
Li4vc3JjL2RvY3MvcWVtdS1vcHRpb24tdHJhY2UucnN0LmluYzoyMTpEdXBsaWNhdGUgZXhwbGlj
aXQgdGFyZ2V0IG5hbWU6ICJjbWRvcHRpb24tcWVtdS1pbWctdHJhY2UiLgogIENDICAgICAgY2hh
cmRldi90cmFjZS5vCiAgQ0MgICAgICBody85cGZzL3RyYWNlLm8KLS0tCiAgQ0MgICAgICBody9o
eXBlcnYvdHJhY2UubwogIENDICAgICAgaHcvaTJjL3RyYWNlLm8KICBDQyAgICAgIGh3L2kzODYv
dHJhY2UubwptYWtlOiAqKiogW01ha2VmaWxlOjExMDI6IGRvY3MvdG9vbHMvaW5kZXguaHRtbF0g
RXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAq
KiogW01ha2VmaWxlOjExMTI6IC5kb2NzX3Rvb2xzX3FlbXUtaW1nLjFfZG9jc190b29sc19xZW11
LW5iZC44X2RvY3NfdG9vbHNfcWVtdS10cmFjZS1zdGFwLjFfZG9jc190b29sc192aXJ0aW9mc2Qu
MV9kb2NzX3Rvb2xzX3ZpcnRmcy1wcm94eS1oZWxwZXIuMS5zZW50aW5lbC5dIEVycm9yIDIKbWFr
ZTogKioqIERlbGV0aW5nIGZpbGUgJy5kb2NzX3Rvb2xzX3FlbXUtaW1nLjFfZG9jc190b29sc19x
ZW11LW5iZC44X2RvY3NfdG9vbHNfcWVtdS10cmFjZS1zdGFwLjFfZG9jc190b29sc192aXJ0aW9m
c2QuMV9kb2NzX3Rvb2xzX3ZpcnRmcy1wcm94eS1oZWxwZXIuMS5zZW50aW5lbC4nCgpXYXJuaW5n
LCB0cmVhdGVkIGFzIGVycm9yOgouLi9zcmMvZG9jcy9xZW11LW9wdGlvbi10cmFjZS5yc3QuaW5j
OjIxOkR1cGxpY2F0ZSBleHBsaWNpdCB0YXJnZXQgbmFtZTogImNtZG9wdGlvbi10cmFjZSIuCm1h
a2U6ICoqKiBbTWFrZWZpbGU6MTExMDogLmRvY3Nfc3lzdGVtX3FlbXUuMV9kb2NzX3N5c3RlbV9x
ZW11LWJsb2NrLWRyaXZlcnMuN19kb2NzX3N5c3RlbV9xZW11LWNwdS1tb2RlbHMuNy5zZW50aW5l
bC5dIEVycm9yIDIKbWFrZTogKioqIERlbGV0aW5nIGZpbGUgJy5kb2NzX3N5c3RlbV9xZW11LjFf
ZG9jc19zeXN0ZW1fcWVtdS1ibG9jay1kcml2ZXJzLjdfZG9jc19zeXN0ZW1fcWVtdS1jcHUtbW9k
ZWxzLjcuc2VudGluZWwuJwoKV2FybmluZywgdHJlYXRlZCBhcyBlcnJvcjoKLi4vc3JjL2RvY3Mv
cWVtdS1vcHRpb24tdHJhY2UucnN0LmluYzoyMTpEdXBsaWNhdGUgZXhwbGljaXQgdGFyZ2V0IG5h
bWU6ICJjbWRvcHRpb24tdHJhY2UiLgptYWtlOiAqKiogW01ha2VmaWxlOjEwOTk6IGRvY3Mvc3lz
dGVtL2luZGV4Lmh0bWxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
OgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzAyLCBpbiA8bW9kdWxl
PgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9NzQ5NzZiMTljZmFhNGMwN2E0MzBiODhlNGEwMGNkZWMnLCAnLXUnLCAnMTAwMycsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1l
JywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC11bTU4ejlrMS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTE0LTEyLjUzLjI4
Ljc5Mjk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvZmVkb3JhJywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NzQ5NzZiMTljZmFhNGMw
N2E0MzBiODhlNGEwMGNkZWMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdW01OHo5
azEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIK
CnJlYWwgICAgM20wLjkxMnMKdXNlciAgICAwbTguMDE5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3MTQxNjI2NTkuMTAxNzQzMi0x
LWJlcnJhbmdlQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t

