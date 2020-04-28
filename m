Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E064DC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EDF206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EDF206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRhP-0002DC-Sz
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTRgW-00013Q-Oo
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTRgV-0005Fj-MV
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:58:08 -0400
Resent-Date: Tue, 28 Apr 2020 10:58:07 -0400
Resent-Message-Id: <E1jTRgV-0005Fj-MV@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTRgP-0005EK-2M; Tue, 28 Apr 2020 10:58:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588085873; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CgZ8sLP+kYA3Qe6gebzDChNOWi6bmzyE6mwbPAdLf++qcrf07BFVROurbAlL28/zhOPsBZPZjmIAm84sXbMLTGX86baELh5yV4b2liSMgN4tapT1bXELBPPniEQPtudc9Lq0EUWJ1Adr/BMixzYawGU/5YZFL8wt5Sde7OicGWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588085873;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=htl0v6wWvdjzNpdB1mY+aIp7Ox0ttEWHIURKcD6RIgc=; 
 b=e07nd12v+BU8NtnJskI/NGqROvljq82f4AF+WH5SY214RuEmBfJD5B6TgeJ4y+V43Frv6nuMchW1HK12TSkginUVloraxyH3RPtiKGe4XhIgMM7M111zKeDxyvcgUduztrhYOaQUyzUhqn54xwq6ia124vA1wkKInXgY4tFKWic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588085871404392.80522370871574;
 Tue, 28 Apr 2020 07:57:51 -0700 (PDT)
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Message-ID: <158808587025.30407.5267663114219680105@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Tue, 28 Apr 2020 07:57:51 -0700 (PDT)
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
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFNJR04gICAgcGMtYmlvcy9v
cHRpb25yb20vbGludXhib290LmJpbgogIFNJR04gICAgcGMtYmlvcy9vcHRpb25yb20va3ZtdmFw
aWMuYmluCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOiBJbiBmdW5jdGlvbiAnaW1nX2Nv
bW1pdCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6OTogZXJyb3I6IGltcGxp
Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdibGtfbmV3X3dpdGhfYnMnIFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICBvbGRfYmFja2luZ19ibGsgPSBi
bGtfbmV3X3dpdGhfYnMoYnMsIEJMS19QRVJNX1dSSVRFLCBCTEtfUEVSTV9BTEwsCiAgICAgICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3MTo5OiBlcnJvcjogbmVzdGVkIGV4
dGVybiBkZWNsYXJhdGlvbiBvZiAnYmxrX25ld193aXRoX2JzJyBbLVdlcnJvcj1uZXN0ZWQtZXh0
ZXJuc10KL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3MToyNTogZXJyb3I6IGFzc2ln
bm1lbnQgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QgWy1XZXJyb3Jd
CiAgICAgICAgIG9sZF9iYWNraW5nX2JsayA9IGJsa19uZXdfd2l0aF9icyhicywgQkxLX1BFUk1f
V1JJVEUsIEJMS19QRVJNX0FMTCwKICAgICAgICAgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwg
d2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFtxZW11LWltZy5vXSBF
cnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIu
cHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPTQ2YTk2ZDM5NzYxYzQ3Mjk4YTJkMWVhZmZkODcwZGRlJywgJy11JywgJzEwMDEn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtNXkxYTNyb3kvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0yOC0xMC41
NS4wMS4xNzUzODovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NDZhOTZkMzk3
NjFjNDcyOThhMmQxZWFmZmQ4NzBkZGUKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
NXkxYTNyb3kvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDJtNDkuOTQxcwp1c2VyICAgIDBtOC41MDJzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQyODEzMjYyOS43
OTY3NTMtMS1tcmVpdHpAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

