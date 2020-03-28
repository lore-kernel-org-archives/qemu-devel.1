Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4F2C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C162073B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 15:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C162073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIDaj-0005yo-VR
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 11:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jIDVQ-0002mf-Ij
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jIDVO-0005bO-V5
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:36:16 -0400
Resent-Date: Sat, 28 Mar 2020 11:36:16 -0400
Resent-Message-Id: <E1jIDVO-0005bO-V5@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jIDVO-0005XM-NN
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 11:36:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585409758; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SNbfsdM0MZs7+C3kHTyhvYtYMF02Ph5zMsWmjv6IwFV2OOoB3Xs1Q3FuO4gr2wZBHG5UOZY8z+73ByeB5cl+DwgXsnYN1KBmm96hEO5Bl+q7dybT7gxPP7+vgestt3elmy9pA6ozjCe3WIT2qHmBCJVhFj8rORtfOTVmWdsjEnI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585409758;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vV5n7NTGUlY3VjgtvPmIuUC0w/ubqrwROgwK279yLL4=; 
 b=cwFXT2tIG9zBPER1SEQrK8SINkdeZ3muo7mEKNAHbPuf9zvb4qEII0dIIkDVzRO/cWUnTrN6bDliW6jSpJIMYXlS3TrXxFvK9vU4Jo3F2d1t8f6mZonyhTiTAZpme4yFnOTU4e9dsTSvMkR9Y15P1evVhZmZrrRM0CkqeNGiNg4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585409756440254.40118642752418;
 Sat, 28 Mar 2020 08:35:56 -0700 (PDT)
In-Reply-To: <20200328114014.6362-1-alex-krasikov@yandex-team.ru>
Subject: Re: [RFC PATCH] crypto/secret: support fetching secrets from Linux
 keyring
Message-ID: <158540975528.5043.7448864057255020656@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex-krasikov@yandex-team.ru
Date: Sat, 28 Mar 2020 08:35:56 -0700 (PDT)
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyODExNDAxNC42MzYy
LTEtYWxleC1rcmFzaWtvdkB5YW5kZXgtdGVhbS5ydS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtl
IGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
bWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgY2hhcmRldi9jaGFyLXJpbmdidWYubwogIENDICAgICAgY2hhcmRldi9jaGFyLXNlcmlh
bC5vCiAgQ0MgICAgICBjaGFyZGV2L2NoYXItc29ja2V0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Ny
eXB0by9zZWNyZXQuYzoyMjoxMDogZmF0YWwgZXJyb3I6IGFzbS91bmlzdGQuaDogTm8gc3VjaCBm
aWxlIG9yIGRpcmVjdG9yeQogI2luY2x1ZGUgPGFzbS91bmlzdGQuaD4KICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+CmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRl
c3Qvc3JjL3J1bGVzLm1hazo2OTogY3J5cHRvL3NlY3JldC5vXSBFcnJvciAxCm1ha2U6ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2Fs
bCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4g
PG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2Rv
Y2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTQ5NjExMTZh
ZGExMTRjNWQ5M2U1MThlYjFlOWQ4Njg1JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQn
LCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3Rt
cC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
cmdxNmp3N2gvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0yOC0xMS4zNC4wNS4xOTkwMjovdmFyL3Rt
cC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1t
aW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9
bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD00OTYxMTE2YWRhMTE0YzVkOTNlNTE4ZWIxZTlk
ODY4NQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBk
aXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1yZ3E2anc3aC9zcmMnCm1ha2U6
ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAxbTQ5
LjE3NnMKdXNlciAgICAwbTcuNjc3cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMjgxMTQwMTQuNjM2Mi0xLWFsZXgta3Jhc2lrb3ZA
eWFuZGV4LXRlYW0ucnUvdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

