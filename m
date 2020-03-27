Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA6CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330BF20748
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330BF20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrCS-0000GW-Hq
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jHrBd-0008FB-Vl
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jHrBZ-0007mA-T3
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:46:21 -0400
Resent-Date: Fri, 27 Mar 2020 11:46:20 -0400
Resent-Message-Id: <E1jHrBZ-0007mA-T3@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21144)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jHrBY-0007lB-7V
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585323941; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JEXCaKeWxft/6Z+8a5nCyi7BXqXY+gstMJgdQJG2Vgrne1/jL3JfFSz8iY0xdafFPa3x47wd+MwHxfTPlmpz/KnBPI/FAp2msQ7lOYlYsgKL8WjxgjiRi033EVmVdplT6xTY7vTVYkp+ZY15qmy1mVXH/o3lU+sc3cyQbLPqfOM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585323941;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JogLSQ5sP02PupECQn3MneNQT1XR6knOYH8M4Y7t8JU=; 
 b=IVH9FnXuywY9LuNriyk1NJDq6FHyPrMtTJRyXolGDBLWpT7CsrU7aS6WlmMUx58nN6G9wWMZcOHBBnOk2FY131ecY79AEgUX+5XBhxOouhVPclKJCt9JfYjrFjTmeQnOgd80la2L9zOGiPrYVKePjcUODOHb+5x7VKetnz/6RTk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585323939685125.94988342776287;
 Fri, 27 Mar 2020 08:45:39 -0700 (PDT)
In-Reply-To: <20200327151841.13877-1-olaf@aepfle.de>
Subject: Re: [PATCH v4] piix: fix xenfv regression,
 add compat machine xenfv-qemu4
Message-ID: <158532393817.31566.2342986500849121087@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: olaf@aepfle.de
Date: Fri, 27 Mar 2020 08:45:39 -0700 (PDT)
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
Cc: olaf@aepfle.de, ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNzE1MTg0MS4xMzg3
Ny0xLW9sYWZAYWVwZmxlLmRlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCnFlbXUtc3lzdGVtLXg4Nl82NDogVGhl
IC1hY2NlbCBhbmQgIi1tYWNoaW5lIGFjY2VsPSIgb3B0aW9ucyBhcmUgaW5jb21wYXRpYmxlCnNv
Y2tldF9hY2NlcHQgZmFpbGVkOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZQoqKgpF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRlc3Rf
aW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAw
ICYmIHMtPnFtcF9mZCA+PSAwKQovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRl
c3QuYzoxNjY6IGtpbGxfcWVtdSgpIHRyaWVkIHRvIHRlcm1pbmF0ZSBRRU1VIHByb2Nlc3MgYnV0
IGVuY291bnRlcmVkIGV4aXQgc3RhdHVzIDEgKGV4cGVjdGVkIDApCkVSUk9SIC0gQmFpbCBvdXQh
IEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjMwMTpxdGVz
dF9pbml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNzZXJ0aW9uIGZhaWxlZDogKHMtPmZkID49
IDAgJiYgcy0+cW1wX2ZkID49IDApCm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJv
ciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBp
b3Rlc3QtcWNvdzI6IDIyMAogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAyMjYKLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWMwODAyYWM3ZDNmYTQxYjdhMTM5OTI0YjRhMzc4
MzE5JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9o
b21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnon
LCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWFhcHR4YmI0L3NyYy9kb2NrZXIt
c3JjLjIwMjAtMDMtMjctMTEuMzEuMzguNzE5MTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpj
ZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9u
LXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9YzA4MDJhYzdkM2ZhNDFiN2ExMzk5MjRiNGEzNzgzMTkKbWFrZVsxXTogKioqIFtk
b2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtYWFwdHhiYjQvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVz
dC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEzbTU5LjQwM3MKdXNlciAgICAwbTgu
MzA2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAyMDAzMjcxNTE4NDEuMTM4NzctMS1vbGFmQGFlcGZsZS5kZS90ZXN0aW5nLmRvY2tlci1x
dWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

