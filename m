Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2BFC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E551F2073B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 08:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E551F2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJYsg-0004di-Uy
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 04:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJYs5-00049G-6h
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJYs4-0001eJ-0G
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 04:37:13 -0400
Resent-Date: Wed, 01 Apr 2020 04:37:13 -0400
Resent-Message-Id: <E1jJYs4-0001eJ-0G@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJYs3-0001bW-OI; Wed, 01 Apr 2020 04:37:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585730226; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X5x6ArHbU9egnQOCoMaWMBng60ytphdcEr28H3iBpJmSWJeLxk76EhCFLw5FasSLb0QK5zUujWZjqZQZIgVIKe+ITiSr/Zn+SmjjvqM9G330mZMzW1q3oJ1AIdog3rolh9GCFc9akWHtRzW6WzDPARCyE2xI53dlvHk7px1OQew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585730226;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gKUDbHPnWGqVsvUfa1QtvznFnk73pnAF3ZR5TshRk9c=; 
 b=UsGEOOsG+CD/hqkAWn1HGf8CYBxz9S/hX0nRkCSpBpRmLiKBKp1pk7NpParNAU4gREsh/S/YM3Oe5osjGLJ14I42dYan1BEpMv8VtK1KSvIHqh2j3w7yxqEg8k+3eXes1K96NtC8JwNhn/w6DoqXKmt/k9w08Y9EA7jElDYe5PU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585730223901872.4240482701856;
 Wed, 1 Apr 2020 01:37:03 -0700 (PDT)
In-Reply-To: <20200331222442.273158-1-eblake@redhat.com>
Subject: Re: [PATCH for-5.0?] qemu-img: Report convert errors by bytes,
 not sectors
Message-ID: <158573022281.20343.5043751376694656513@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Wed, 1 Apr 2020 01:37:03 -0700 (PDT)
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMzMTIyMjQ0Mi4yNzMx
NTgtMS1lYmxha2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEJVSUxEICAgcGMtYmlvcy9v
cHRpb25yb20vcHZoLnJhdwogIFNJR04gICAgcGMtYmlvcy9vcHRpb25yb20vcHZoLmJpbgovdG1w
L3FlbXUtdGVzdC9zcmMvcWVtdS1pbWcuYzogSW4gZnVuY3Rpb24gJ2NvbnZlcnRfY29fZG9fY29w
eSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjE5Mjk6MzA6IGVycm9yOiBmb3JtYXQg
JyVsZCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25nIGludCcsIGJ1dCBhcmd1bWVudCAy
IGhhcyB0eXBlICdsb25nIGxvbmcgdW5zaWduZWQgaW50JyBbLVdlcnJvcj1mb3JtYXQ9XQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJlcnJvcigtcmV0KSk7CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTk1OTozMDog
ZXJyb3I6IGZvcm1hdCAnJWxkJyBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUgJ2xvbmcgaW50Jywg
YnV0IGFyZ3VtZW50IDIgaGFzIHR5cGUgJ2xvbmcgbG9uZyB1bnNpZ25lZCBpbnQnIFstV2Vycm9y
PWZvcm1hdD1dCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmVycm9yKC1yZXQpKTsK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogW3FlbXUtaW1nLm9dIEVycm9yIDEKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBp
biA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDExY2My
ZDYyMWI4NDQ5ZjhmNTg4YTEzZTM4MDFiZTAnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAn
LWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAn
LWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFy
L3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNj
YWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtNGwzZ2g2cWIvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0wMS0wNC4zNS4wNC40OTkwOi92YXIv
dG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVz
dC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0
ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0wMTFjYzJkNjIxYjg0NDlmOGY1ODhhMTNl
MzgwMWJlMAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmlu
ZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC00bDNnaDZxYi9zcmMnCm1h
a2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAg
MW01OS4yOThzCnVzZXIgICAgMG04LjAyNXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzMxMjIyNDQyLjI3MzE1OC0xLWVibGFrZUBy
ZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

