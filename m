Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF3C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2C62051A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2C62051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHQw-0007j3-Bf
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1izHQN-0007Ej-Lh
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1izHQL-0001YK-Rf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:56:47 -0500
Resent-Date: Wed, 05 Feb 2020 04:56:47 -0500
Resent-Message-Id: <E1izHQL-0001YK-Rf@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1izHQL-0001D1-Is
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:56:45 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580896590162561.9186532537159;
 Wed, 5 Feb 2020 01:56:30 -0800 (PST)
In-Reply-To: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
Subject: Re: [RFC PATCH v2 0/9] Add an interVM memory sharing device
Message-ID: <158089658883.7235.12181984308299716112@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: i.kotrasinsk@partner.samsung.com
Date: Wed, 5 Feb 2020 01:56:30 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: peter.maydell@linaro.org, i.kotrasinsk@partner.samsung.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTgwODk1MTg1LTI0MzQxLTEt
Z2l0LXNlbmQtZW1haWwtaS5rb3RyYXNpbnNrQHBhcnRuZXIuc2Ftc3VuZy5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQg
QVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2JhbGxvb24ubwogIENDICAgICAg
eDg2XzY0LXNvZnRtbXUvaW9wb3J0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL21lbW9yeS5jOiBJbiBm
dW5jdGlvbiAnbWVtb3J5X3JlZ2lvbl9maW5kX2ZsYXRfcmFuZ2VfcmN1JzoKL3RtcC9xZW11LXRl
c3Qvc3JjL21lbW9yeS5jOjI2MDg6MzE6IGVycm9yOiBtaXNzaW5nIGJyYWNlcyBhcm91bmQgaW5p
dGlhbGl6ZXIgWy1XZXJyb3I9bWlzc2luZy1icmFjZXNdCiAgICAgTWVtb3J5UmVnaW9uU2VjdGlv
biByZXQgPSB7IC5tciA9IE5VTEwsIC5zaXplID0gMCB9OwogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHsgfQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtl
WzFdOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IG1lbW9yeS5vXSBFcnJv
ciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAg
ICB4ODZfNjQtc29mdG1tdS9xdGVzdC5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9tZW1vcnku
bwotLS0KICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2R1bXAvd2luX2R1bXAubwogIENDICAgICAg
eDg2XzY0LXNvZnRtbXUvaHcvYmxvY2svdmlydGlvLWJsay5vCi90bXAvcWVtdS10ZXN0L3NyYy9t
ZW1vcnkuYzogSW4gZnVuY3Rpb24gJ21lbW9yeV9yZWdpb25fZmluZF9mbGF0X3JhbmdlX3JjdSc6
Ci90bXAvcWVtdS10ZXN0L3NyYy9tZW1vcnkuYzoyNjA4OjMxOiBlcnJvcjogbWlzc2luZyBicmFj
ZXMgYXJvdW5kIGluaXRpYWxpemVyIFstV2Vycm9yPW1pc3NpbmctYnJhY2VzXQogICAgIE1lbW9y
eVJlZ2lvblNlY3Rpb24gcmV0ID0geyAubXIgPSBOVUxMLCAuc2l6ZSA9IDAgfTsKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB7IH0KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnMKbWFrZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBt
ZW1vcnkub10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgptYWtlOiAqKiogW01ha2VmaWxlOjQ5NTogYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3Ig
MgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW01h
a2VmaWxlOjQ5NTogeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5l
IDY2MiwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPTM3YTkzZTE5NzY3NjRjMjY4YzM0NzZhZDdjYWRiMDU4Jywg
Jy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0
Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12Jywg
Jy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0xajZjbWJvYy9zcmMvZG9ja2VyLXNyYy4yMDIw
LTAyLTA1LTA0LjQ2LjExLjE0MTc6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
MzdhOTNlMTk3Njc2NGMyNjhjMzQ3NmFkN2NhZGIwNTgKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtMWo2Y21ib2Mvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0Bm
ZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMTBtMTcuODcwcwp1c2VyICAgIDBtOC4zNzdzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTgwODk1
MTg1LTI0MzQxLTEtZ2l0LXNlbmQtZW1haWwtaS5rb3RyYXNpbnNrQHBhcnRuZXIuc2Ftc3VuZy5j
b20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

