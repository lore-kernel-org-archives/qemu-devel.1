Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F8AC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754A820857
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 20:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754A820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS4fH-0006lJ-I8
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 16:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jS4eW-00069r-4X
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jS4eS-0006an-V5
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:10:23 -0400
Resent-Date: Fri, 24 Apr 2020 16:10:23 -0400
Resent-Message-Id: <E1jS4eS-0006an-V5@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jS4eS-0006HF-BT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 16:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587759007; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FFKxt8pzxHweo82TkBFQmskYChnnTysfnrGE6QdRuB1dMyxEom5EYjjytBW5vlvoqvKCNNHBr1x2/5A4fDX6OVZsj6XM2W2Jong7ZHrfsdKT9qk7DHnt/UstQDcIzFk3kjt9qUoNN0ZAF0AFxZe7aaRH1dvdfLkZZLF0ZavyiXM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587759007;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yBg4AUVFNQ0wN8gl9MALUFsedlYwQr+hVRLrGiITh98=; 
 b=CEjnvdTGu6Mspv4nikd3p23Q2AncLkpVE2XrSgTK+H7FpGlKi3sQxkjQmEvwclj8Nj69knreEv6Nuw+JJgu1gZ7/NuOYpnN3fqk2HUrDrW4msODu3Em6qLIvepD0FmHCX4bBDarl0eKVVjX4sT7iscYe14qFVuk1FluOI672ykQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587759003133141.208146042537;
 Fri, 24 Apr 2020 13:10:03 -0700 (PDT)
In-Reply-To: <20200424173914.2957-1-alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] translate-all: include guest address in out_asm output
Message-ID: <158775900179.22435.15423613904486491269@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 24 Apr 2020 13:10:03 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 16:10:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyNDE3MzkxNC4yOTU3
LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tl
ci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dA
ZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAg
YWFyY2g2NC1zb2Z0bW11L2h3L2FybS9weGEyeHhfcGljLm8KICBDQyAgICAgIGFhcmNoNjQtc29m
dG1tdS9ody9hcm0vZGlnaWMubwovdG1wL3FlbXUtdGVzdC9zcmMvYWNjZWwvdGNnL3RyYW5zbGF0
ZS1hbGwuYzogSW4gZnVuY3Rpb24gJ3RiX2dlbl9jb2RlJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Fj
Y2VsL3RjZy90cmFuc2xhdGUtYWxsLmM6MTgwNjo0MzogZXJyb3I6IGZvcm1hdCAnJWxkJyBleHBl
Y3RzIGFyZ3VtZW50IG9mIHR5cGUgJ2xvbmcgaW50JywgYnV0IGFyZ3VtZW50IDIgaGFzIHR5cGUg
J3NpemVfdCcge2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1d
CiAgICAgICAgICAgICBxZW11X2xvZygiICBwcm9sb2d1ZTogW3NpemU9JWxkXVxuIiwgaW5zbl9z
dGFydCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5eICAgICAg
fn5+fn5+fn5+fgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICVsbGQK
L3RtcC9xZW11LXRlc3Qvc3JjL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxsLmM6MTgyNzozOTogZXJy
b3I6IGZvcm1hdCAnJWxkJyBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUgJ2xvbmcgaW50JywgYnV0
IGFyZ3VtZW50IDIgaGFzIHR5cGUgJ3NpemVfdCcge2FrYSAnbG9uZyBsb25nIHVuc2lnbmVkIGlu
dCd9IFstV2Vycm9yPWZvcm1hdD1dCiAgICAgICAgICAgICBxZW11X2xvZygiICBkYXRhOiBbc2l6
ZT0lbGRdXG4iLCBkYXRhX3NpemUpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfn5eICAgICAgfn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAlbGxkCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06
ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogYWNjZWwvdGNnL3RyYW5zbGF0
ZS1hbGwub10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2FybS9vbWFwMS5vCiAgQ0MgICAgICB4
ODZfNjQtc29mdG1tdS9nZGJzdHViLXhtbC5vCi90bXAvcWVtdS10ZXN0L3NyYy9hY2NlbC90Y2cv
dHJhbnNsYXRlLWFsbC5jOiBJbiBmdW5jdGlvbiAndGJfZ2VuX2NvZGUnOgovdG1wL3FlbXUtdGVz
dC9zcmMvYWNjZWwvdGNnL3RyYW5zbGF0ZS1hbGwuYzoxODA2OjQzOiBlcnJvcjogZm9ybWF0ICcl
bGQnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAnbG9uZyBpbnQnLCBidXQgYXJndW1lbnQgMiBo
YXMgdHlwZSAnc2l6ZV90JyB7YWthICdsb25nIGxvbmcgdW5zaWduZWQgaW50J30gWy1XZXJyb3I9
Zm9ybWF0PV0KICAgICAgICAgICAgIHFlbXVfbG9nKCIgIHByb2xvZ3VlOiBbc2l6ZT0lbGRdXG4i
LCBpbnNuX3N0YXJ0KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+
fl4gICAgICB+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJWxsZAovdG1wL3FlbXUtdGVzdC9zcmMvYWNjZWwvdGNnL3RyYW5zbGF0ZS1hbGwuYzoxODI3
OjM5OiBlcnJvcjogZm9ybWF0ICclbGQnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAnbG9uZyBp
bnQnLCBidXQgYXJndW1lbnQgMiBoYXMgdHlwZSAnc2l6ZV90JyB7YWthICdsb25nIGxvbmcgdW5z
aWduZWQgaW50J30gWy1XZXJyb3I9Zm9ybWF0PV0KICAgICAgICAgICAgIHFlbXVfbG9nKCIgIGRh
dGE6IFtzaXplPSVsZF1cbiIsIGRhdGFfc2l6ZSk7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB+fl4gICAgICB+fn5+fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICVsbGQKY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMK
bWFrZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBhY2NlbC90Y2cv
dHJhbnNsYXRlLWFsbC5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbTWFrZWZpbGU6NTI3OiB4ODZfNjQtc29mdG1tdS9hbGxd
IEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTog
KioqIFtNYWtlZmlsZTo1Mjc6IGFhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5w
eSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJh
aXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJv
Y2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxh
YmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NzEwNjcxZjg3MjA0NDE5NDlkZjQyMzc4NDk4
MWMxNjInLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmlu
ZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJF
X09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywg
J1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcv
aG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnon
LCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZyc29vd3NoL3NyYy9kb2NrZXIt
c3JjLjIwMjAtMDQtMjQtMTYuMDcuMTAuMjA3MDk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6
ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9u
LXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9NzEwNjcxZjg3MjA0NDE5NDlkZjQyMzc4NDk4MWMxNjIKbWFrZVsxXTogKioqIFtk
b2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtZnJzb293c2gvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVz
dC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm01Mi41ODJzCnVzZXIgICAgMG04Ljky
OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwNDI0MTczOTE0LjI5NTctMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9j
a2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

