Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ED6C35642
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF7A222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF7A222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j53Mx-0001cQ-No
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j53MO-0001BC-9Z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j53MM-0004Op-FD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:08:31 -0500
Resent-Date: Fri, 21 Feb 2020 03:08:31 -0500
Resent-Message-Id: <E1j53MM-0004Op-FD@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j53MM-0004DM-5t
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:08:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582272498; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E4tN4WYJo3p6K+IaIY9ie/HONe22xNxPXfdwk/dDPNlb8xzDPoVoLMtZjQ9rkhos7lSxlvMYTwjLCqg0V8zxhTh69Fb82nMMyVAlgytxMVxRozxpNXiKDDC+XZCx5PpurgcSFLop6okkS6woHa94aSS/8KlUbDgu8BB57/udEY8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582272498;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=UAXFcmHoDhRmni+1cQrCssoLBajHQDnfvrjZivx3LfQ=; 
 b=FJSe+yZWJku9tAOTyrpNOLq9G20N7/xk7Ez/QS9Gat+DxUoks7394q0JVyTJUUcdlbpAE2stkrmIVguy8B4DbMNmLNLaPGuc650My+SCr6QOzgK4xij6gfaRyx7XMg3JVGHhlMqTVzqcpBo8Qt2VLs0Yc4nk/W0Vf7QATggNiok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582272496879842.3244392800112;
 Fri, 21 Feb 2020 00:08:16 -0800 (PST)
In-Reply-To: <20200221065015.337915-1-jasper.lowell@bt.com>
Subject: Re: [PATCH] hw/ide: Remove status register read side effect
Message-ID: <158227249585.712.3062745536245409439@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jasper.lowell@bt.com
Date: Fri, 21 Feb 2020 00:08:16 -0800 (PST)
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, jasper.lowell@bt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIyMTA2NTAxNS4zMzc5
MTUtMS1qYXNwZXIubG93ZWxsQGJ0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hlY2st
cXRlc3QteDg2XzY0OiB0ZXN0cy9xdGVzdC9pZGUtdGVzdAogIFRFU1QgICAgY2hlY2stdW5pdDog
dGVzdHMvdGVzdC1pb3YKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2lk
ZS10ZXN0LmM6Mjk0OnNlbmRfZG1hX3JlcXVlc3Q6IGFzc2VydGlvbiBmYWlsZWQ6ICghcXRlc3Rf
Z2V0X2lycShxdHMsIElERV9QUklNQVJZX0lSUSkpCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90
bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9pZGUtdGVzdC5jOjI5NDpzZW5kX2RtYV9yZXF1
ZXN0OiBhc3NlcnRpb24gZmFpbGVkOiAoIXF0ZXN0X2dldF9pcnEocXRzLCBJREVfUFJJTUFSWV9J
UlEpKQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMv
dGVzdC1iaXRtYXAKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtYWlvCi0tLQogIFRF
U1QgICAgaW90ZXN0LXFjb3cyOiAyODMKRmFpbHVyZXM6IDE2MQpGYWlsZWQgMSBvZiAxMTYgaW90
ZXN0cwptYWtlOiAqKiogW2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTMzNDk5ODZhYjgzODQ5ZDViNDc1ZGQx
MDFiZWQ0ZjA1JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWd3NV9fZ2l5L3NyYy9k
b2NrZXItc3JjLjIwMjAtMDItMjEtMDIuNTQuNDguMjc4Mjg6L3Zhci90bXAvcWVtdTp6LHJvJywg
J3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVy
bmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVt
dS5pbnN0YW5jZS51dWlkPTMzNDk5ODZhYjgzODQ5ZDViNDc1ZGQxMDFiZWQ0ZjA1Cm1ha2VbMV06
ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWd3NV9fZ2l5L3NyYycKbWFrZTogKioqIFtkb2NrZXIt
cnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxM20yNy4xODZzCnVzZXIg
ICAgMG05LjA1NHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwMjIxMDY1MDE1LjMzNzkxNS0xLWphc3Blci5sb3dlbGxAYnQuY29tL3Rl
c3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

