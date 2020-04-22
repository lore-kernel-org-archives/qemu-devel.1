Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3656C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:40:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960BA20781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 21:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960BA20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRN6g-0000iL-Oc
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 17:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRN5w-0000Fi-Tr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRN5v-0002Mw-Jy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:39:48 -0400
Resent-Date: Wed, 22 Apr 2020 17:39:48 -0400
Resent-Message-Id: <E1jRN5v-0002Mw-Jy@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRN5v-0002IE-2N
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 17:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587591577; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YTUDF4fq4Z+GVBN63wQJ/o3916r3LF/Ei7Du0NJxdcgFErAiUfq2Fl+PSO/mSabeSEpZPWZQ1rJHmZpHEqx5QJycICil+PBAV3EFfAHxD9LBr4KCqQVpFwdySQt2v++boZRYvBZ8y71q+UcWEvhLF9r8IWMCarWls1eGr67TIAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587591577;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ldU30gAwP7Nn7IR+SkmxbTkzRNrG5AXnWYTf04bZJsA=; 
 b=a8rgL9Z7LGeZgu8/TI1XTtDi2lkQ7iXgRv8da/m6aAFijQyf0zKo7yBlhlYL1vPTYdfVCVbkMVe879J3OGI0qVEluadCunTPfpypjuUc+AmhBduhrnX1cnWWejiuGqAYWDPpbzHSQRBD6PYQBfMX40ANMsWI31gmX66K/wx+nI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587591576646810.3686831507958;
 Wed, 22 Apr 2020 14:39:36 -0700 (PDT)
In-Reply-To: <20200422171305.10923-1-jonathan.derrick@intel.com>
Subject: Re: [PATCH for QEMU] hw/vfio: Add VMD Passthrough Quirk
Message-ID: <158759157524.3922.10142073039172739954@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jonathan.derrick@intel.com
Date: Wed, 22 Apr 2020 14:39:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 14:26:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, helgaas@kernel.org,
 andrzej.jakowski@intel.com, jonathan.derrick@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMjE3MTMwNS4xMDky
My0xLWpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxl
ZCB0aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9z
NyBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1df
RU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBz
dHVicy91dWlkLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGh3L3ZmaW8vdHJhY2UuYzo1OjA6Cmh3
L3ZmaW8vdHJhY2UuaDogSW4gZnVuY3Rpb24gJ19ub2NoZWNrX190cmFjZV92ZmlvX3BjaV92bWRf
cXVpcmtfc2hhZG93X3JlZ3MnOgpody92ZmlvL3RyYWNlLmg6MjM0ODo5OiBlcnJvcjogc3RyYXkg
J1wnIGluIHByb2dyYW0KICAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2ZmlvX3BjaV92
bWRfcXVpcmtfc2hhZG93X3JlZ3MgIiAiJXMgbWVtYmFyMV9waHlzPTB4JSJQUkl4NjQiIG1lbWJh
cjJfcGh5cz0weCUiUFJJeDY0IiAiXG4iLAogICAgICAgICBeCmh3L3ZmaW8vdHJhY2UuaDoyMzQ4
OjEyMTogZXJyb3I6IGV4cGVjdGVkICcpJyBiZWZvcmUgJ24nCiAgICAgICAgIHFlbXVfbG9nKCIl
ZEAlenUuJTA2enU6dmZpb19wY2lfdm1kX3F1aXJrX3NoYWRvd19yZWdzICIgIiVzIG1lbWJhcjFf
cGh5cz0weCUiUFJJeDY0IiBtZW1iYXIyX3BoeXM9MHglIlBSSXg2NCIgIlxuIiwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
aHcvdmZpby90cmFjZS5oOjIzNDg6MTIyOiBlcnJvcjogbWlzc2luZyB0ZXJtaW5hdGluZyAiIGNo
YXJhY3RlciBbLVdlcnJvcl0KICAgICAgICAgcWVtdV9sb2coIiVkQCV6dS4lMDZ6dTp2ZmlvX3Bj
aV92bWRfcXVpcmtfc2hhZG93X3JlZ3MgIiAiJXMgbWVtYmFyMV9waHlzPTB4JSJQUkl4NjQiIG1l
bWJhcjJfcGh5cz0weCUiUFJJeDY0IiAiXG4iLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KaHcvdmZpby90cmFjZS5oOjIz
NDg6MTIxOiBlcnJvcjogbWlzc2luZyB0ZXJtaW5hdGluZyAiIGNoYXJhY3RlcgogICAgICAgICBx
ZW11X2xvZygiJWRAJXp1LiUwNnp1OnZmaW9fcGNpX3ZtZF9xdWlya19zaGFkb3dfcmVncyAiICIl
cyBtZW1iYXIxX3BoeXM9MHglIlBSSXg2NCIgbWVtYmFyMl9waHlzPTB4JSJQUkl4NjQiICJcbiIs
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeCmh3L3ZmaW8vdHJhY2UuaDoyMzUxOjE4OiBlcnJvcjogZm9ybWF0ICclZCcgZXhw
ZWN0cyBhIG1hdGNoaW5nICdpbnQnIGFyZ3VtZW50IFstV2Vycm9yPWZvcm1hdD1dCiAgICAgICAg
ICAgICAgICAgICwgbmFtZSwgbWIxLCBtYjIpOwogICAgICAgICAgICAgICAgICBeCmh3L3ZmaW8v
dHJhY2UuaDoyMzUxOjE4OiBlcnJvcjogZm9ybWF0ICclenUnIGV4cGVjdHMgYSBtYXRjaGluZyAn
c2l6ZV90JyBhcmd1bWVudCBbLVdlcnJvcj1mb3JtYXQ9XQpody92ZmlvL3RyYWNlLmg6MjM1MTox
ODogZXJyb3I6IGZvcm1hdCAnJXp1JyBleHBlY3RzIGEgbWF0Y2hpbmcgJ3NpemVfdCcgYXJndW1l
bnQgWy1XZXJyb3I9Zm9ybWF0PV0KaHcvdmZpby90cmFjZS5oOjIzNTE6MTg6IGVycm9yOiBmb3Jt
YXQgJyVzJyBleHBlY3RzIGEgbWF0Y2hpbmcgJ2NoYXIgKicgYXJndW1lbnQgWy1XZXJyb3I9Zm9y
bWF0PV0KaHcvdmZpby90cmFjZS5oOjIzNTE6MTg6IGVycm9yOiBmb3JtYXQgJyVseCcgZXhwZWN0
cyBhIG1hdGNoaW5nICdsb25nIHVuc2lnbmVkIGludCcgYXJndW1lbnQgWy1XZXJyb3I9Zm9ybWF0
PV0KaHcvdmZpby90cmFjZS5oOjIzNTE6MTg6IGVycm9yOiBmb3JtYXQgJyVseCcgZXhwZWN0cyBh
IG1hdGNoaW5nICdsb25nIHVuc2lnbmVkIGludCcgYXJndW1lbnQgWy1XZXJyb3I9Zm9ybWF0PV0K
ICBDQyAgICAgIHN0dWJzL3ZtLXN0b3AubwpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVk
IGFzIGVycm9ycwogIENDICAgICAgc3R1YnMvdm1zdGF0ZS5vCm1ha2U6ICoqKiBbaHcvdmZpby90
cmFjZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgQ0MgICAgICBzdHVicy9mZC1yZWdpc3Rlci5vClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2Fs
bCBsYXN0KToKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2Rv
Y2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWRiNTM0ZmQz
ZWI3MTQ5OWJiMGRjNTIxNjg0Y2Y1Y2I2JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQn
LCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LXVjZV9nZDdxL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMjItMTcuMzcuMTguMTQ1NDg6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWRiNTM0ZmQzZWI3MTQ5OWJiMGRjNTIxNjg0
Y2Y1Y2I2Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXVjZV9nZDdxL3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAy
bTE3LjE0MnMKdXNlciAgICAwbTguMjEwcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjIxNzEzMDUuMTA5MjMtMS1qb25hdGhhbi5k
ZXJyaWNrQGludGVsLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

