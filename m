Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A09EC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D062E2086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D062E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXaw-0007GS-0R
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 01:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFXZq-0006RR-Jq
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFXZo-0000IB-WB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:53:30 -0400
Resent-Date: Wed, 02 Oct 2019 01:53:30 -0400
Resent-Message-Id: <E1iFXZo-0000IB-WB@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFXZo-0000Gj-47; Wed, 02 Oct 2019 01:53:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569995579; cv=none; d=zoho.com; s=zohoarc; 
 b=WEY9939NYCSLu1pZatMVfJMjwQBca1IMHnDy+TY+vyPj88TwGExqj4f5EXc3GycCj9FeIMqjJk7roQYPnSDMBaEGjTlz+7cjYDisGsoM0I1PXMcSBrFcLHTfQIxWILAnZISSIOBhd811Alx69AAnRa718aUUzsKprQEVuAO0A2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569995579;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=OMQckSrc0zMsfobiWuelQuY3H6Xwss384w1HyC5SbAM=; 
 b=aC9MJsbcmDnh/9D72SwbScBAv3l2sv825FQ2x7wG+/FcvSv/AhoiqrSaEgMmr2JWRtjZpDRJGSXw6Xpg7lg41vITST3Uc/F17QnXqveRlLLl6VwqyoIOUbXbz+CjRqun8YV9Kp1yM6PvP8T24/6sC2nr372T6h1nP2ISelpOe2M=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569995578311279.5071980563381;
 Tue, 1 Oct 2019 22:52:58 -0700 (PDT)
Subject: Re: [PULL 0/8] Ide patches
In-Reply-To: <20191001235552.17790-1-jsnow@redhat.com>
Message-ID: <156999557604.27524.5156776835937752350@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Tue, 1 Oct 2019 22:52:58 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: fam@euphon.net, peter.maydell@linaro.org, thuth@redhat.com,
 lersek@redhat.com, qemu-block@nongnu.org, mst@redhat.com, lvivier@redhat.com,
 jsnow@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 arei.gonglei@huawei.com, kraxel@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwMTIzNTU1Mi4xNzc5
MC0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTAwMTIzNTU1Mi4xNzc5MC0x
LWpzbm93QHJlZGhhdC5jb20KU3ViamVjdDogW1BVTEwgMC84XSBJZGUgcGF0Y2hlcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwox
ZjliNDAxIGhkLWdlby10ZXN0OiBBZGQgdGVzdHMgZm9yIGxjaHMgb3ZlcnJpZGUKN2JmZGRhNCBi
b290ZGV2aWNlOiBGV19DRkcgaW50ZXJmYWNlIGZvciBMQ0hTIHZhbHVlcwpiNmZlYjY0IGJvb3Rk
ZXZpY2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNfbGlzdAphYjYwYWEwIGJvb3RkZXZpY2U6
IEdhdGhlciBMQ0hTIGZyb20gYWxsIHJlbGV2YW50IGRldmljZXMKZTEyYTgzOSBzY3NpOiBQcm9w
YWdhdGUgdW5yZWFsaXplKCkgY2FsbGJhY2sgdG8gc2NzaS1oZAplNmYyMWYzIGJvb3RkZXZpY2U6
IEFkZCBpbnRlcmZhY2UgdG8gZ2F0aGVyIExDSFMKNDAxMjBmNCBibG9jazogU3VwcG9ydCBwcm92
aWRpbmcgTENIUyBmcm9tIHVzZXIKYWRjZjU2ZCBibG9jazogUmVmYWN0b3IgbWFjcm9zIC0gZml4
IHRhYmJpbmcKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgYWRjZjU2
ZDA4MGM5IChibG9jazogUmVmYWN0b3IgbWFjcm9zIC0gZml4IHRhYmJpbmcpCkVSUk9SOiBNYWNy
b3Mgd2l0aCBjb21wbGV4IHZhbHVlcyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gcGFyZW50aGVzaXMK
IzU3OiBGSUxFOiBpbmNsdWRlL2h3L2Jsb2NrL2Jsb2NrLmg6NjU6CisjZGVmaW5lIERFRklORV9C
TE9DS19DSFNfUFJPUEVSVElFUyhfc3RhdGUsIF9jb25mKSAgICAgICAgICAgICAgICAgICAgICBc
CisgICAgREVGSU5FX1BST1BfVUlOVDMyKCJjeWxzIiwgX3N0YXRlLCBfY29uZi5jeWxzLCAwKSwg
ICAgICAgICAgICAgICAgICBcCisgICAgREVGSU5FX1BST1BfVUlOVDMyKCJoZWFkcyIsIF9zdGF0
ZSwgX2NvbmYuaGVhZHMsIDApLCAgICAgICAgICAgICAgICBcCiAgICAgREVGSU5FX1BST1BfVUlO
VDMyKCJzZWNzIiwgX3N0YXRlLCBfY29uZi5zZWNzLCAwKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAzNyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzggaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCjIvOCBDaGVja2luZyBjb21taXQgNDAxMjBmNDRiNDRmIChibG9jazogU3VwcG9ydCBw
cm92aWRpbmcgTENIUyBmcm9tIHVzZXIpCjMvOCBDaGVja2luZyBjb21taXQgZTZmMjFmMzVkZWJm
IChib290ZGV2aWNlOiBBZGQgaW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hTKQo0LzggQ2hlY2tpbmcg
Y29tbWl0IGUxMmE4MzlkMmIxMiAoc2NzaTogUHJvcGFnYXRlIHVucmVhbGl6ZSgpIGNhbGxiYWNr
IHRvIHNjc2ktaGQpCjUvOCBDaGVja2luZyBjb21taXQgYWI2MGFhMGY1MWE1IChib290ZGV2aWNl
OiBHYXRoZXIgTENIUyBmcm9tIGFsbCByZWxldmFudCBkZXZpY2VzKQo2LzggQ2hlY2tpbmcgY29t
bWl0IGI2ZmViNjRlYmFlZiAoYm9vdGRldmljZTogUmVmYWN0b3IgZ2V0X2Jvb3RfZGV2aWNlc19s
aXN0KQo3LzggQ2hlY2tpbmcgY29tbWl0IDdiZmRkYTRlYWFmNCAoYm9vdGRldmljZTogRldfQ0ZH
IGludGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMpCjgvOCBDaGVja2luZyBjb21taXQgMWY5YjQwMTE5
NWJjIChoZC1nZW8tdGVzdDogQWRkIHRlc3RzIGZvciBsY2hzIG92ZXJyaWRlKQpXQVJOSU5HOiBC
bG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNjUwOiBG
SUxFOiB0ZXN0cy9oZC1nZW8tdGVzdC5jOjEwMDM6CisgICAgICAgICAgICAgICAgICAgICAgICJz
a2lwcGluZyBoZC1nZW8vb3ZlcnJpZGUvKiB0ZXN0cyIpOwoKdG90YWw6IDAgZXJyb3JzLCAxIHdh
cm5pbmdzLCA2MTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC84IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6
IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMTkxMDAxMjM1NTUyLjE3NzkwLTEtanNub3dAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


