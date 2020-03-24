Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C302C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 07:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F37420724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 07:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F37420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGeSM-0006VD-4I
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 03:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGeRn-00062a-N8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 03:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGeRm-0002NO-Hu
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 03:58:03 -0400
Resent-Date: Tue, 24 Mar 2020 03:58:03 -0400
Resent-Message-Id: <E1jGeRm-0002NO-Hu@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGeRj-0002Lt-GI; Tue, 24 Mar 2020 03:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585036663; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MxIKg4a2O0krMmW8IyZILTPAQ1hwV1GwM3tSOtLXpVrI2Poif7ecmWMn+LOpFGs5eFRPZmXrnVs+IWzbdJqW7UD35IXdVxK4x02ny+76ULw4L8iYP+ned5+91VCTXWmT3tFQgB81cM2NtStx2C+6wUQoTARfg6cXv3NGU28o/zc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585036663;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mPq/U4QF7cBKvX/pj/4F8tdRzzFnP5HWatUJJcBsDAs=; 
 b=VDn0BVTk2/2pyZ341ggsf2NSmMbYnQn9L8vrD0kwhzh6fFbLYwejf5hrnvGHDRnPSvpRgmaU8eZ4j8N7GdwsNzM5w1ugurhSAUFTdEeuQ/1WqFPY9xQPA92NlxIoFnDch/mf7BIffBbUzJPnm/eQU+CbWzpk1EUL7Znsi/S9uGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158503666091144.49452165075695;
 Tue, 24 Mar 2020 00:57:40 -0700 (PDT)
In-Reply-To: <20200324074156.5330-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH] iotests: drop group file
Message-ID: <158503665946.9334.11711683169078173597@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Tue, 24 Mar 2020 00:57:40 -0700 (PDT)
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNDA3NDE1Ni41MzMw
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBzX25v
cm1Sb3VuZFBhY2tUb0Y2NC5vCiAgQ0MgICAgICBzX2FkZE1hZ3NGNjQubwogIENDICAgICAgc19z
dWJNYWdzRjY0Lm8KbWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVjay1ibG9jay5zaF0gRXJyb3Ig
MQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgc19t
dWxBZGRGNjQubwogIENDICAgICAgc19ub3JtU3Vibm9ybWFsRXh0RjgwU2lnLm8KLS0tCiAgICBy
YWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFBy
b2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1s
YWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTJiNTgyMjI5YWRkNzQxZjM4N2ZjZjBhODhm
ZjJhM2ZmJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZp
bmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12Jywg
Jy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW90N3V5ZHd0L3NyYy9kb2Nr
ZXItc3JjLjIwMjAtMDMtMjQtMDMuNTQuNTguMjg5MzU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPTJiNTgyMjI5YWRkNzQxZjM4N2ZjZjBhODhmZjJhM2ZmCm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW90N3V5ZHd0L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTQxLjIyNHMKdXNlciAgICAw
bTcuOTQxcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAyMDAzMjQwNzQxNTYuNTMzMC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0
aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

