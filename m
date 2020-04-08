Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB228C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825102072A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 06:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825102072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM4NZ-0005rL-Ji
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 02:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jM4N1-0005RP-VI
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jM4N0-00021J-Kt
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:39:31 -0400
Resent-Date: Wed, 08 Apr 2020 02:39:31 -0400
Resent-Message-Id: <E1jM4N0-00021J-Kt@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jM4N0-00020z-Cz
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 02:39:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586327965; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JxgnB2ASBoxwN0hOFUtUZQSPWMbRcxgvhYNX2nO5pOx7JzKlf3vkQDYFhm4qmLeEv4loaTfu/3wiZTFypaJs8wvRP0LUBIPJ/HQ8sja3br4rprXZroK9WUCu4sIaURew5ij/t0F14qkArCEQl6e5ZuZQZMbDTUE+LKpU+qMUBRg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586327965;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=QWM5eNxsm6Uvm84AgpS/8I84rRopVHcGiCjS7xQz16M=; 
 b=gg7ZV9MMmR+yWWLJPYrhOKlDh4WNua1dZWeJH/OSbTgvNNOBGcwxTvc82H1zTzs5pBDUVJzKDDO4eQxmXpHQ53KHSaaWlTHDbPryMts4/bvxrZiQdmprYZg/YdZf/iPVb3pbb8cT6d4XMbaQyv8WN2RXfNuqFJMmJfin+qqkSLo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586327964337157.56220619258545;
 Tue, 7 Apr 2020 23:39:24 -0700 (PDT)
In-Reply-To: <20200408003552.58095-1-mansourweb@gmail.com>
Subject: Re: [PATCH] When updating the PFLASH file contents,
 we should check for a possible failure of blk_pwrite(). Similar to
 3a68829 commit
Message-ID: <158632796323.16886.15138679494927835799@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mansourweb@gmail.com
Date: Tue, 7 Apr 2020 23:39:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: mansourweb@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwODAwMzU1Mi41ODA5
NS0xLW1hbnNvdXJ3ZWJAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9jb3Jl
L3FkZXYtZncubwogIENDICAgICAgaHcvY29yZS9mdy1wYXRoLXByb3ZpZGVyLm8KL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L2Jsb2NrL3BmbGFzaF9jZmkwMi5jOiBJbiBmdW5jdGlvbiAncGZsYXNoX3Vw
ZGF0ZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9wZmxhc2hfY2ZpMDIuYzo0MDU6Njog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdlcnJvcl9yZXBvcnQnIFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICBlcnJvcl9yZXBvcnQo
IkNvdWxkIG5vdCB1cGRhdGUgUEZMQVNIOiAlcyIsIHN0cmVycm9yKC1yZXQpKTsKICAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svcGZsYXNoX2NmaTAyLmM6NDA1OjY6IGVycm9yOiBu
ZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdlcnJvcl9yZXBvcnQnIFstV2Vycm9yPW5lc3Rl
ZC1leHRlcm5zXQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwogIEND
ICAgICAgaHcvY29yZS9ubWkubwptYWtlOiAqKiogW2h3L2Jsb2NrL3BmbGFzaF9jZmkwMi5vXSBF
cnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIu
cHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPTliNjY1YWRkZTZhNTQxODNiYzg5MTEwYjQyMDBjZWZiJywgJy11JywgJzEwMDMn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLXdmYXoxb2c0L3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMDgtMDIu
MzYuNDQuMzE0MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OWI2NjVhZGRl
NmE1NDE4M2JjODkxMTBiNDIwMGNlZmIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
d2ZhejFvZzQvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDJtMzkuNjkwcwp1c2VyICAgIDBtOC42NzhzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQwODAwMzU1Mi41
ODA5NS0xLW1hbnNvdXJ3ZWJAZ21haWwuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

