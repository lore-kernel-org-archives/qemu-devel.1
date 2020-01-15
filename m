Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C98C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6232084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 19:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6232084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irob4-0000OW-1W
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 14:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iroW3-0001Je-EP
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iroW1-00066i-90
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:39:47 -0500
Resent-Date: Wed, 15 Jan 2020 14:39:47 -0500
Resent-Message-Id: <E1iroW1-00066i-90@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iroW1-00065T-1N
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 14:39:45 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157911717475746.28844896268515;
 Wed, 15 Jan 2020 11:39:34 -0800 (PST)
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
Subject: Re: [PATCH v2 00/86] refactor main RAM allocation to use hostmem
 backend
Message-ID: <157911717375.8290.17349808340085664729@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Wed, 15 Jan 2020 11:39:34 -0800 (PST)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc5MTAwODYxLTczNjkyLTEt
Z2l0LXNlbmQtZW1haWwtaW1hbW1lZG9AcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBm
YWlsZWQgdGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRo
ZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERv
Y2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNl
bnRvczcgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBT
SE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1Qg
ICAgaW90ZXN0LXFjb3cyOiAxODQKc29ja2V0X2FjY2VwdCBmYWlsZWQ6IFJlc291cmNlIHRlbXBv
cmFyaWx5IHVuYXZhaWxhYmxlCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVz
dC9saWJxdGVzdC5jOjI3MjpxdGVzdF9pbml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNzZXJ0
aW9uIGZhaWxlZDogKHMtPmZkID49IDAgJiYgcy0+cW1wX2ZkID49IDApCi90bXAvcWVtdS10ZXN0
L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE0MDoga2lsbF9xZW11KCkgdHJpZWQgdG8gdGVy
bWluYXRlIFFFTVUgcHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhwZWN0
ZWQgMCkKRVJST1IgLSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0
ZXN0L2xpYnF0ZXN0LmM6MjcyOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3Nl
cnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKICBURVNUICAgIGlv
dGVzdC1xY293MjogMTg2Cm1ha2U6ICoqKiBbY2hlY2stcXRlc3QteDg2XzY0XSBFcnJvciAxCm1h
a2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3Qt
cWNvdzI6IDE4NwogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxOTAKLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPTIyNjY2YjMzZjg2OTQ1NTM4NjExMWI4MzliNGQ0OTRjJywg
Jy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYn
LCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTJ0YW5vczhfL3NyYy9kb2NrZXItc3JjLjIw
MjAtMDEtMTUtMTQuMjguNDYuNDg0NDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3
JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8g
ZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9MjI2NjZiMzNmODY5NDU1Mzg2MTExYjgzOWI0ZDQ5NGMKbWFrZVsxXTogKioqIFtkb2NrZXIt
cnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtMnRhbm9zOF8vc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlj
a0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDEwbTQ3LjU2M3MKdXNlciAgICAwbTguMjgzcwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3
OTEwMDg2MS03MzY5Mi0xLWdpdC1zZW5kLWVtYWlsLWltYW1tZWRvQHJlZGhhdC5jb20vdGVzdGlu
Zy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


