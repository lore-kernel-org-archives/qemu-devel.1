Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859EDC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589C220787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589C220787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctXP-0001Dw-F7
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jctWJ-0000SH-LS; Sun, 24 May 2020 12:30:40 -0400
Resent-Date: Sun, 24 May 2020 12:30:39 -0400
Resent-Message-Id: <E1jctWJ-0000SH-LS@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jctWG-0003oI-Gx; Sun, 24 May 2020 12:30:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590337792; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VM1yjG1AoUqMyFfVIzxXUl0y8u20X9GYPfkUthG5MuuTryS1NAKozIX0gSpncM6xizpn30oo9vrba4MUTCHmqKI05mi9RB05f6HhwmAYzTFCIgVAJxGoTY8+d7PPljHslugEnROQBojEF+rf0VOFWkndwVjNe2lMGAGeg1SUPP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590337792;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=h9doAkdGX2Juo8ciejhGTCauOWgG/wL+2e2WM+jq+c0=; 
 b=coPaq0f4+rK9hZP6lWB2KXie5KANpVbtKUNOk7XUpYVyqKbYioeLDVg68NlaXsEgEYyEPowFIvPkr/nwIQ9I8TV7HCAFtLFH4ih7iUwOqXZ3d5IXgdNESrL0il+PuDpiFAzP1cRzCe+Pv9H5gcyPcDpq0GJ5y8CHFfZaNrK3bOs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590337790254929.0114470584662;
 Sun, 24 May 2020 09:29:50 -0700 (PDT)
Message-ID: <159033778879.25024.12369387132048351376@45ef0f9c86ae>
In-Reply-To: <cover.1590331741.git.berto@igalia.com>
Subject: Re: [PATCH v6 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Sun, 24 May 2020 09:29:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 12:30:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwMzMxNzQxLmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay9xZWQtdGFi
bGUubwogIENDICAgICAgYmxvY2svcWVkLWNsdXN0ZXIubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxv
Y2svcWNvdzItY2x1c3Rlci5jOiBJbiBmdW5jdGlvbiAncWNvdzJfZ2V0X2hvc3Rfb2Zmc2V0JzoK
L3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NzM6MTk6IGVycm9yOiAn
ZXhwZWN0ZWRfdHlwZScgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9u
IFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgICAgIH0gZWxzZSBpZiAodHlwZSAh
PSBleHBlY3RlZF90eXBlKSB7CiAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ5OjI1OiBub3RlOiAnZXhwZWN0ZWRfdHlwZScgd2Fz
IGRlY2xhcmVkIGhlcmUKICAgICBRQ293MlN1YmNsdXN0ZXJUeXBlIGV4cGVjdGVkX3R5cGUsIHR5
cGU7CiAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9x
Y293Mi1jbHVzdGVyLmM6NDc1OjE5OiBlcnJvcjogJ2NoZWNrX29mZnNldCcgbWF5IGJlIHVzZWQg
dW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6
ZWRdCiAgICAgICAgIH0gZWxzZSBpZiAoY2hlY2tfb2Zmc2V0KSB7CiAgICAgICAgICAgICAgICAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ3OjEwOiBub3Rl
OiAnY2hlY2tfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAgIGJvb2wgY2hlY2tfb2Zmc2V0
OwogICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ3
NjoyOTogZXJyb3I6ICdleHBlY3RlZF9vZmZzZXQnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQg
aW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICAg
ICAgZXhwZWN0ZWRfb2Zmc2V0ICs9IHMtPmNsdXN0ZXJfc2l6ZTsKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDQ4
OjE0OiBub3RlOiAnZXhwZWN0ZWRfb2Zmc2V0JyB3YXMgZGVjbGFyZWQgaGVyZQogICAgIHVpbnQ2
NF90IGV4cGVjdGVkX29mZnNldDsKICAgICAgICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJl
aW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbYmxvY2svcWNvdzItY2x1c3Rlci5vXSBF
cnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIu
cHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPTVkNWMxYTNlYzIwYzQ3MzNiMmI0OWNmYThjMjUxOTBlJywgJy11JywgJzEwMDMn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWtlOGgyeWVvL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjQtMTIu
MjcuMjIuMjM1NjQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTVkNWMxYTNl
YzIwYzQ3MzNiMmI0OWNmYThjMjUxOTBlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LWtlOGgyeWVvL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10g
RXJyb3IgMgoKcmVhbCAgICAybTI4LjA0MXMKdXNlciAgICAwbTguNTg4cwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU5MDMzMTc0
MS5naXQuYmVydG9AaWdhbGlhLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

