Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE44EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8863A214DA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8863A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvtj-0001Fy-Sk
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgvS5-0000e6-Ba
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgvS3-00024B-DH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:18:25 -0400
Resent-Date: Fri, 28 Jun 2019 14:18:24 -0400
Resent-Message-Id: <E1hgvS3-00024B-DH@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21431)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgvS3-0001kR-6R
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:18:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561745822; cv=none; d=zoho.com; s=zohoarc; 
 b=OTGIEF1KL/khbgaGpYoSEVkGA5sCGV6lvqU5X/oacaQ3K+erTMQ+8iBvVEepH/QQ/56ipwhijaGkTb+vSUUS7ruVSpS5vJclf5HsOHsx/wQGZFmMqWLoBYGqKa3IcKGZTEzh081bER6fkKre+E1GO2XnfQlC008/2fgFJe2ql7g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561745822;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=r6gZQLxzQzNW+Wk1EUOsfuvYxRwyjmzqtuZ2MqTnrvI=; 
 b=TaZpGWou1KFIDU0Qtz3U/0F+pdjMPGbvfB/RfK+Ho+xSso8XlYILKzseGcqRwRlRK+lRPIgHyx9evCjITNAQXvpiyC8RnDO+LZbWgQ1fqxiwNelhg9DdaWUdl2JwegQvMj+9mKduT50kx6Tv4rcoQZdrebyzrL2PBPbQdGW9gXo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561745811048337.4033016903942;
 Fri, 28 Jun 2019 11:16:51 -0700 (PDT)
Message-ID: <156174580959.16285.8555577984625596770@c4a48874b076>
In-Reply-To: <20190628115349.60293-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: slp@redhat.com
Date: Fri, 28 Jun 2019 11:16:51 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/4] Introduce the microvm machine type
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
Cc: ehabkost@redhat.com, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYyODExNTM0OS42MDI5
My0xLXNscEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0ZXN0
IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUgaW52
b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEgY29t
bWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJyYW5j
aApzZXQgLWUKCmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0gUEFD
S0FHRVMgPT09IgpycG0gLXFhCgplY2hvCmVjaG8gIj09PSBVTkFNRSA9PT0iCnVuYW1lIC1hCgpD
Qz0kSE9NRS9iaW4vY2MKSU5TVEFMTD0kUFdEL2luc3RhbGwKQlVJTEQ9JFBXRC9idWlsZApta2Rp
ciAtcCAkQlVJTEQgJElOU1RBTEwKU1JDPSRQV0QKY2QgJEJVSUxECiRTUkMvY29uZmlndXJlIC0t
Y2M9JENDIC0tcHJlZml4PSRJTlNUQUxMCm1ha2UgLWo0CiMgWFhYOiB3ZSBuZWVkIHJlbGlhYmxl
IGNsZWFuIHVwCiMgbWFrZSBjaGVjayAtajQgVj0xCm1ha2UgaW5zdGFsbAo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKICBDQyAgICAgIGkzODYtc29mdG1tdS9ody9pMzg2L21pY3Jvdm0ubwogIEND
ICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L21pc2MvZXh5bm9zNDIxMF9ybmcubwogIENDICAgICAg
bG0zMi1zb2Z0bW11L2dkYnN0dWIubwovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAta3Q3NjI5
Ymsvc3JjL2h3L2kzODYvbWljcm92bS5jOjQzOjEwOiBmYXRhbCBlcnJvcjogYXNtL2Jvb3RwYXJh
bS5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAgIDQzIHwgI2luY2x1ZGUgPGFzbS9ib290
cGFyYW0uaD4KICAgICAgfCAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fgpjb21waWxhdGlvbiB0
ZXJtaW5hdGVkLgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTA2MjgxMTUzNDkuNjAyOTMtMS1zbHBAcmVkaGF0LmNvbS90ZXN0aW5nLnMz
OTB4Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


