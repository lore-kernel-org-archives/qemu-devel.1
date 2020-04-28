Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC15C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912E3206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E3206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQX8-000827-LA
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTQWT-0007Kr-8J
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTQWD-0003Z3-OY
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:43:40 -0400
Resent-Date: Tue, 28 Apr 2020 09:43:39 -0400
Resent-Message-Id: <E1jTQWD-0003Z3-OY@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTQS0-0001xN-2L; Tue, 28 Apr 2020 09:39:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588081135; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b0Y9ix4pLM4Qq86v0T3mDtLfYYpSq+W6a16hG+6kPh00kumaQZSEs2xwxfVKi0kn6i50RpBHDUB4t+vvy26yIJTBD4hexfJvQQAr1j2Hr2PdGoox0hXC9aJdJDibQuNbhEWzgq6lmoj2iIsYFgX7i7jo6+JSo2PoXGyVB5U8c7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588081135;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IBEesiWM82fp4fHIKGUafdJ5DlWpgK1kIMSkDG/Oy6Y=; 
 b=fSOc1PyRA6Xb3XjJnF39dR5Q8OsZGDIGB0Qs/rIri8yP3hkDZDH/zFw7rTHTg7j261aEaeEHYBeNzLFq30WuUF9JN9rv2BHaacT7dHb8kfYjxVC0S+1N98QRt1nfxKUfuuQjXc53GgT7Adui4hUjlzqjJhBEAzxopNMNhmNFvOA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158808113454551.6063730957992;
 Tue, 28 Apr 2020 06:38:54 -0700 (PDT)
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Message-ID: <158808113321.30407.2614862410102124566@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Tue, 28 Apr 2020 06:38:54 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:39:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODEzMjYyOS43OTY3
NTMtMS1tcmVpdHpAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9
eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
U0lHTiAgICBwYy1iaW9zL29wdGlvbnJvbS9rdm12YXBpYy5iaW4KICBCVUlMRCAgIHBjLWJpb3Mv
b3B0aW9ucm9tL3B2aC5yYXcKICBTSUdOICAgIHBjLWJpb3Mvb3B0aW9ucm9tL3B2aC5iaW4KL3Rt
cC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3MToyNzogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uICdibGtfbmV3X3dpdGhfYnMnIGlzIGludmFsaWQgaW4gQzk5IFst
V2Vycm9yLC1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgICAgb2xkX2JhY2tp
bmdfYmxrID0gYmxrX25ld193aXRoX2JzKGJzLCBCTEtfUEVSTV9XUklURSwgQkxLX1BFUk1fQUxM
LAogICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1n
LmM6MTA3MToyNzogZXJyb3I6IHRoaXMgZnVuY3Rpb24gZGVjbGFyYXRpb24gaXMgbm90IGEgcHJv
dG90eXBlIFstV2Vycm9yLC1Xc3RyaWN0LXByb3RvdHlwZXNdCi90bXAvcWVtdS10ZXN0L3NyYy9x
ZW11LWltZy5jOjEwNzE6MjU6IGVycm9yOiBpbmNvbXBhdGlibGUgaW50ZWdlciB0byBwb2ludGVy
IGNvbnZlcnNpb24gYXNzaWduaW5nIHRvICdCbG9ja0JhY2tlbmQgKicgKGFrYSAnc3RydWN0IEJs
b2NrQmFja2VuZCAqJykgZnJvbSAnaW50JyBbLVdlcnJvciwtV2ludC1jb252ZXJzaW9uXQogICAg
ICAgIG9sZF9iYWNraW5nX2JsayA9IGJsa19uZXdfd2l0aF9icyhicywgQkxLX1BFUk1fV1JJVEUs
IEJMS19QRVJNX0FMTCwKICAgICAgICAgICAgICAgICAgICAgICAgXiB+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CjMgZXJyb3JzIGdlbmVyYXRlZC4KbWFr
ZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBxZW11LWltZy5vXSBFcnJv
ciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAo
bW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHki
LCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3Io
cmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydz
dWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5j
ZS51dWlkPTE4OTZkMmIxZjEwNDQwOTFiODMyYmUzMTNkNjZhYzZlJywgJy11JywgJzEwMDMnLCAn
LS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFS
R0VUX0xJU1Q9eDg2XzY0LXNvZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9Jywg
Jy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5W
PScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRj
aGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12Jywg
Jy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1mcWw5dGk1aC9zcmMvZG9ja2VyLXNyYy4yMDIw
LTA0LTI4LTA5LjM0LjAwLjUzMzI6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
MTg5NmQyYjFmMTA0NDA5MWI4MzJiZTMxM2Q2NmFjNmUKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtZnFsOXRpNWgvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0Bm
ZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG00NC4xOTRzCnVzZXIgICAgMG04LjA4NHMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI4
MTMyNjI5Ljc5Njc1My0xLW1yZWl0ekByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

