Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA7C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4634720862
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4634720862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0MC-0006JW-Au
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iG0Kn-0005GU-AN
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iG0Kl-0004wU-7p
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:35:52 -0400
Resent-Date: Thu, 03 Oct 2019 08:35:52 -0400
Resent-Message-Id: <E1iG0Kl-0004wU-7p@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iG0Kk-0004ty-WC
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:35:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570106142; cv=none; d=zoho.com; s=zohoarc; 
 b=AwHVPQbab6uE3wdizsA5JS21qCkjydZwmxq0AxKgwnebNvUDXP1BX7ZxA3yELyA0S5ALNOcAMSaeUUdoWa90J9x0YcpnJhuwIQTz+NQq47f3v5SiVmniBrQ68GLsULF3yRsClaA/nWZAaVk7clz+OOWWzQtzBY3L9m3ZPvjJuFk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570106142;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=SEUNBMfzPxE19t5HEik/K6+R0DbltZkDlD3wI6NK3MQ=; 
 b=oZ67FEC/yPxEZ4r/4KXlAQwVM6D6fNUQ5Sq/Pwwn7YFbJAvMzxY+BeUN9jjC+FsE3j5dyEMK6nouYNBCPRJK5ynQ3aqZEnrigEpud9akh67SaVe+RGrrAj5qu5A/sxHF5HFs64WrjU2PwOweQeyVH20fSYlzy+RfTyrR5tFjBys=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570106140842756.5004121740259;
 Thu, 3 Oct 2019 05:35:40 -0700 (PDT)
Subject: Re: [PATCH] migration: Support gtree migration
In-Reply-To: <20191003114144.30129-1-eric.auger@redhat.com>
Message-ID: <157010613953.27524.261296622550938122@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eric.auger@redhat.com
Date: Thu, 3 Oct 2019 05:35:40 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: eric.auger@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwMzExNDE0NC4zMDEy
OS0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgdGVzdHMv
dGVzdC1pby1jaGFubmVsLWNvbW1hbmQubwogIENDICAgICAgdGVzdHMvdGVzdC1pby1jaGFubmVs
LWJ1ZmZlci5vCiAgQ0MgICAgICB0ZXN0cy90ZXN0LWJhc2U2NC5vCi90bXAvcWVtdS10ZXN0L3Ny
Yy90ZXN0cy90ZXN0LXZtc3RhdGUuYzo4NTI6NTogZXJyb3I6IGluaXRpYWxpemVyIGVsZW1lbnQg
aXMgbm90IGNvbnN0YW50CiAgICAgdm1zdGF0ZV9pbnRlcnZhbCwgLyoga2V5ICAgKi8KICAgICBe
Ci90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LXZtc3RhdGUuYzo4NTI6NTogZXJyb3I6IChu
ZWFyIGluaXRpYWxpemF0aW9uIGZvciAndm1zdGF0ZV9pbnRlcnZhbF9tYXBwaW5nWzBdJykKL3Rt
cC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3Rlc3Qtdm1zdGF0ZS5jOjg1NDoxOiBlcnJvcjogaW5pdGlh
bGl6ZXIgZWxlbWVudCBpcyBub3QgY29uc3RhbnQKIH07CiBeCi90bXAvcWVtdS10ZXN0L3NyYy90
ZXN0cy90ZXN0LXZtc3RhdGUuYzo4NTQ6MTogZXJyb3I6IChuZWFyIGluaXRpYWxpemF0aW9uIGZv
ciAndm1zdGF0ZV9pbnRlcnZhbF9tYXBwaW5nWzFdJykKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3Rz
L3Rlc3Qtdm1zdGF0ZS5jOjkyODoxOiBlcnJvcjogaW5pdGlhbGl6ZXIgZWxlbWVudCBpcyBub3Qg
Y29uc3RhbnQKIH07CiBeCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LXZtc3RhdGUuYzo5
Mjg6MTogZXJyb3I6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciAndm1zdGF0ZV9pZF9kb21haW5b
MV0nKQptYWtlOiAqKiogW3Rlc3RzL3Rlc3Qtdm1zdGF0ZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBX
YWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2Fs
bCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2MiwgaW4g
PG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2Rv
Y2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTI5YmVlYzEw
MjJiNTQ4OWRhYzQ3MDY3ZDBlNzQ1MTExJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQn
LCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LTZjZ25kdmtkL3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMDMtMDguMzEuMzcuMjI1NDA6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTI5YmVlYzEwMjJiNTQ4OWRhYzQ3MDY3ZDBl
NzQ1MTExCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZjZ25kdmtkL3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICA0
bTIuMzM2cwp1c2VyICAgIDBtNy4zODlzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAwMzExNDE0NC4zMDEyOS0xLWVyaWMuYXVnZXJA
cmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0t
LQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNo
ZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRo
YXQuY29t


