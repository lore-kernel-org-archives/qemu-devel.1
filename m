Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC49C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C569206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C569206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTS8s-0001pH-9d
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:27:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTS7y-00009h-5f
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTRnp-0001nv-7q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:09:27 -0400
Resent-Date: Tue, 28 Apr 2020 11:09:27 -0400
Resent-Message-Id: <E1jTRnp-0001nv-7q@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTRko-0007W5-3q; Tue, 28 Apr 2020 11:02:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588086141; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kLOFX3fdE37LaB2SF1wYZ9ifwF0WbThRjAQY6y3sz5K6T1Uv3p/7blRw+o1CAJOxySPJ18YIgLrBmOEQcvC9T2f3vJhN+nZqUL0zNFVIjyvJW7m5NDsmQLmOxNByyMk4vjf7lr4W/dSh6N76KcgBtnw8sVlAekImepXnaTziJZw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588086141;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TwUm04n6uNyWAofRMvgjOv0IUyqBvEBctwzIihSI8A8=; 
 b=HSJwVpdvexn2DYlJtmp2uYNdYCWpRsc6drwISu3wPCMoKkSC+lJehtlPuLn58JL/8qaSKNoVDKFeYVF4vaxdFg3QtFR+EQYtDEOnwi2sioeyYMrSr3j3GP0ToaN+i23DZ0phPwkU50r9TLyIOOvKR15m+X9Pm3hAE2g7G9WZzu0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588086137912483.5973250650337;
 Tue, 28 Apr 2020 08:02:17 -0700 (PDT)
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Message-ID: <158808613667.30407.3704417958092475390@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Tue, 28 Apr 2020 08:02:17 -0700 (PDT)
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
NTMtMS1tcmVpdHpAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFNJR04gICAgcGMt
Ymlvcy9vcHRpb25yb20vbGludXhib290LmJpbgogIFNJR04gICAgcGMtYmlvcy9vcHRpb25yb20v
a3ZtdmFwaWMuYmluCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOiBJbiBmdW5jdGlvbiAn
aW1nX2NvbW1pdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6Mjc6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYmxrX25ld193aXRoX2JzJzsgZGlk
IHlvdSBtZWFuICdibGtfZ2V0X3N0YXRzJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVj
bGFyYXRpb25dCiAgICAgICAgIG9sZF9iYWNraW5nX2JsayA9IGJsa19uZXdfd2l0aF9icyhicywg
QkxLX1BFUk1fV1JJVEUsIEJMS19QRVJNX0FMTCwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAgICAgIGJsa19nZXRfc3RhdHMK
L3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3MToyNzogZXJyb3I6IG5lc3RlZCBleHRl
cm4gZGVjbGFyYXRpb24gb2YgJ2Jsa19uZXdfd2l0aF9icycgWy1XZXJyb3I9bmVzdGVkLWV4dGVy
bnNdCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6MjU6IGVycm9yOiBhc3NpZ25t
ZW50IHRvICdCbG9ja0JhY2tlbmQgKicge2FrYSAnc3RydWN0IEJsb2NrQmFja2VuZCAqJ30gZnJv
bSAnaW50JyBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdCBbLVdlcnJv
cj1pbnQtY29udmVyc2lvbl0KICAgICAgICAgb2xkX2JhY2tpbmdfYmxrID0gYmxrX25ld193aXRo
X2JzKGJzLCBCTEtfUEVSTV9XUklURSwgQkxLX1BFUk1fQUxMLAogICAgICAgICAgICAgICAgICAg
ICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAq
KiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHFlbXUtaW1nLm9dIEVycm9yIDEK
bWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0
IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxp
bmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9Y2U4MzA1ZTIyZDljNDVlZDkwZWMyZGM0M2Q3ZjFjYzMnLCAnLXUnLCAnMTAwMScsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWt6bzAxNndqL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMjgtMTAuNTguNDUuMjcz
ODU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Y2U4MzA1ZTIyZDljNDVlZDkw
ZWMyZGM0M2Q3ZjFjYzMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAta3pvMDE2d2ov
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJl
YWwgICAgM20zMS40NTBzCnVzZXIgICAgMG04Ljk3OHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI4MTMyNjI5Ljc5Njc1My0xLW1y
ZWl0ekByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

