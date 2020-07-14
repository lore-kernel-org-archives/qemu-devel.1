Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87248C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8C622453
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8C622453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvKN6-0001wN-MA
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvKMS-0001X1-DA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:48:40 -0400
Resent-Date: Tue, 14 Jul 2020 08:48:40 -0400
Resent-Message-Id: <E1jvKMS-0001X1-DA@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvKMP-0002QJ-Uz
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:48:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594730876; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E/g5r03H7sLEVwXk7PnWWK56WucOh18soIHhoA5CI3IaLQp7GXQQw35V4lfrMWLF2xCR2+ax/4Fszitetq33qzD5zE1fNlRurvmxaIXnu05Us3PPqqONU7PIHvoEupdQskex7Kag+LpHHErW+yBR4m+f5zCp2UFDZ1MIQ+UFfcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594730876;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=qBU0xoURdnBk0i/U866AOl8tqtqrMIlA7Abv51yisyc=; 
 b=fjZXlO+K2TbtOfwI6/PhB8KyUu2ZrGsk7K36nbm2E9c9oFTDgrYwWaC+AiDfFXHHAczNXrgDopQFQTyRMh1LVaxLiA3iRohqTh9ypvkoSOuYEWlVjTxn5x6z4GcXeUNXGl/KDOvafIL/m41Gb/fPdMlswKvHh0xetYpPaA6F1Ug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594730873495641.381467304823;
 Tue, 14 Jul 2020 05:47:53 -0700 (PDT)
Subject: Re: [PATCH v1 0/6] CTU CAN FD core support
Message-ID: <159473087133.2008.6283012861257625888@07a7f0d89f7d>
In-Reply-To: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pisa@cmp.felk.cvut.cz
Date: Tue, 14 Jul 2020 05:47:53 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 08:48:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: marex@denx.de, jnovak@fel.cvut.cz, stefanha@gmail.com,
 deniz.eren@icloud.com, qemu-devel@nongnu.org, armbru@redhat.com,
 o.rempel@pengutronix.de, frederic.konrad@adacore.com, jan.kiszka@siemens.com,
 charvj10@fel.cvut.cz, socketcan@hartkopp.net, pbonzini@redhat.com,
 ondrej.ille@gmail.com, pisa@cmp.felk.cvut.cz
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTk0NzI1NjQ3Lmdp
dC5waXNhQGNtcC5mZWxrLmN2dXQuY3ovCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGh3
L3Njc2kvbXB0ZW5kaWFuLm8KICBDQyAgICAgIGh3L3Njc2kvbWVnYXNhcy5vCi90bXAvcWVtdS10
ZXN0L3NyYy9ody9uZXQvY2FuL2N0dWNhbl9wY2kuYzogSW4gZnVuY3Rpb24gJ2N0dWNhbl9wY2lf
aWRfY3JhX2lvX3JlYWQnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L2Nhbi9jdHVjYW5fcGNp
LmM6MTA1OjIwOiBlcnJvcjogZm9ybWF0ICclbHgnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAn
bG9uZyB1bnNpZ25lZCBpbnQnLCBidXQgYXJndW1lbnQgMiBoYXMgdHlwZSAnaHdhZGRyJyB7YWth
ICdsb25nIGxvbmcgdW5zaWduZWQgaW50J30gWy1XZXJyb3I9Zm9ybWF0PV0KICAxMDUgfCAgICAg
cHJpbnRmKCJhZGRyPSVseCxzaXplPSV4LHRtcD0lbHhcbiIsIGFkZHIsIHNpemUsIHRtcCk7CiAg
ICAgIHwgICAgICAgICAgICAgICAgICB+fl4gICAgICAgICAgICAgICAgICAgICB+fn5+CiAgICAg
IHwgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICB8CiAgICAgIHwgICAg
ICAgICAgICAgICAgICAgIGxvbmcgdW5zaWduZWQgaW50ICAgICBod2FkZHIge2FrYSBsb25nIGxv
bmcgdW5zaWduZWQgaW50fQogICAgICB8ICAgICAgICAgICAgICAgICAgJWxseAovdG1wL3FlbXUt
dGVzdC9zcmMvaHcvbmV0L2Nhbi9jdHVjYW5fcGNpLmM6MTA1OjM2OiBlcnJvcjogZm9ybWF0ICcl
bHgnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAnbG9uZyB1bnNpZ25lZCBpbnQnLCBidXQgYXJn
dW1lbnQgNCBoYXMgdHlwZSAndWludDY0X3QnIHtha2EgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQn
fSBbLVdlcnJvcj1mb3JtYXQ9XQogIDEwNSB8ICAgICBwcmludGYoImFkZHI9JWx4LHNpemU9JXgs
dG1wPSVseFxuIiwgYWRkciwgc2l6ZSwgdG1wKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB+fl4gICAgICAgICAgICAgICAgIH5+fgogICAgICB8ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgfAotLS0KICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAlbGx4CmNjMTogYWxsIHdhcm5pbmdzIGJl
aW5nIHRyZWF0ZWQgYXMgZXJyb3JzCiAgQ0MgICAgICBody9zY3NpL3Ztd19wdnNjc2kubwptYWtl
OiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L25ldC9jYW4vY3R1Y2Fu
X3BjaS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tl
ci9kb2NrZXIucHkiLCBsaW5lIDcwMiwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPWY1Nzc0NDkxMjU1YzQzNDM5ZGY2NzZmYTYwZTc4OTQyJywgJy11
JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0n
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOGs4dGh4dmQvc3JjL2RvY2tlci1zcmMuMjAyMC0w
Ny0xNC0wOC40My40MS40OTc2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2ZlZG9yYScsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWY1
Nzc0NDkxMjU1YzQzNDM5ZGY2NzZmYTYwZTc4OTQyCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLThrOHRoeHZkL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVk
b3JhXSBFcnJvciAyCgpyZWFsICAgIDRtMTAuMTIwcwp1c2VyICAgIDBtOC4xMjZzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy9jb3Zlci4xNTk0
NzI1NjQ3LmdpdC5waXNhQGNtcC5mZWxrLmN2dXQuY3ovdGVzdGluZy5kb2NrZXItbWluZ3dAZmVk
b3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

