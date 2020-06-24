Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3905C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769F32082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769F32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5ZY-00014t-Nx
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jo5Ys-0000LQ-Jo
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:35:34 -0400
Resent-Date: Wed, 24 Jun 2020 09:35:34 -0400
Resent-Message-Id: <E1jo5Ys-0000LQ-Jo@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jo5Yp-00061e-9d
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:35:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593005717; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LkU2luzE3XtnkFT5ouN8AUIDHb3sSeDoRcuK0gMjIaTru84/m9toA6ezUsxvWon7W4L5zf4nziQYyWFxmc74/osgrHQLsKMvYCc7r0cZPGHvoZ3GHeztSYwsmMKF1Cny2kiDTrG3Ztms15u61Rv+NjddlwWDDShuNvCO4bswq98=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593005717;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qnlUsuKSUx96Z+1uy0gbvRnASBWE/s8ELgibsqv8ZVc=; 
 b=XKPICJxndTGZpUFlBKHC+8H6xzqlg8IBSbvmBCfVEPKMUK5yKXdPkT/O/nUzuALDRc4MgsXR0/u6AAVNLY5SEJjoDksYDz+DFuI0R+WKuvKYDEHBqtnwepv1v+CavqrrYyvzhriTvgsPtbHpA22MHioDOX0hooZfuQdonOvmfrg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593005714435588.6064612443033;
 Wed, 24 Jun 2020 06:35:14 -0700 (PDT)
Message-ID: <159300571296.6613.13304084890286151375@d1fd068a5071>
Subject: Re: [PATCH v2 0/2] Avoid abort on QMP attempt to add an object with
 duplicate id
In-Reply-To: <20200624124301.7112-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Wed, 24 Jun 2020 06:35:14 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 09:35:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNDEyNDMwMS43MTEy
LTEtZXJpYy5hdWdlckByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBpb3Rlc3Qt
cWNvdzI6IDExNAogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxMTcKKioKRVJST1I6L3RtcC9xZW11
LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L3FtcC1jbWQtdGVzdC5jOjIyNTp0ZXN0X29iamVjdF9hZGRf
d2l0aF9kdXBsaWNhdGVfaWQ6IGFzc2VydGlvbiBmYWlsZWQ6IChxZGljdF9oYXNrZXkocmVzcCwg
InJldHVybiIpKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVz
dHMvcXRlc3QvcW1wLWNtZC10ZXN0LmM6MjI1OnRlc3Rfb2JqZWN0X2FkZF93aXRoX2R1cGxpY2F0
ZV9pZDogYXNzZXJ0aW9uIGZhaWxlZDogKHFkaWN0X2hhc2tleShyZXNwLCAicmV0dXJuIikpCm1h
a2U6ICoqKiBbY2hlY2stcXRlc3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxMjAKICBURVNU
ICAgIGlvdGVzdC1xY293MjogMTI2Ci0tLQogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0
ZXN0cy9xdGVzdC9xbXAtdGVzdAogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy9x
dGVzdC9xbXAtY21kLXRlc3QKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0
L3FtcC1jbWQtdGVzdC5jOjIyNTp0ZXN0X29iamVjdF9hZGRfd2l0aF9kdXBsaWNhdGVfaWQ6IGFz
c2VydGlvbiBmYWlsZWQ6IChxZGljdF9oYXNrZXkocmVzcCwgInJldHVybiIpKQpFUlJPUiAtIEJh
aWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvcW1wLWNtZC10ZXN0
LmM6MjI1OnRlc3Rfb2JqZWN0X2FkZF93aXRoX2R1cGxpY2F0ZV9pZDogYXNzZXJ0aW9uIGZhaWxl
ZDogKHFkaWN0X2hhc2tleShyZXNwLCAicmV0dXJuIikpCm1ha2U6ICoqKiBbY2hlY2stcXRlc3Qt
eDg2XzY0XSBFcnJvciAxCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDIyMAogIFRFU1QgICAgaW90
ZXN0LXFjb3cyOiAyMjYKICBURVNUICAgIGlvdGVzdC1xY293MjogMjI5Ci0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1kNmNiM2QwNjljN2E0NGVjYmY1YjAyYzE3YTM5ZTg4
NCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BU
Uz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hP
V19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6Jywg
Jy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1saXRhaWltdC9zcmMvZG9ja2VyLXNy
Yy4yMDIwLTA2LTI0LTA5LjE4LjQ3LjkxNDk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2Vu
dG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16
ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5j
ZS51dWlkPWQ2Y2IzZDA2OWM3YTQ0ZWNiZjViMDJjMTdhMzllODg0Cm1ha2VbMV06ICoqKiBbZG9j
a2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLWxpdGFpaW10L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3Qt
cXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxNm0yNS4yMDBzCnVzZXIgICAgMG01LjUx
OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwNjI0MTI0MzAxLjcxMTItMS1lcmljLmF1Z2VyQHJlZGhhdC5jb20vdGVzdGluZy5kb2Nr
ZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

