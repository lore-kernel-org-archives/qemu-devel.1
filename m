Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C944EC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986A4208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986A4208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWvaI-0001aP-RJ
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 01:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWvZi-00019n-1I
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:29:30 -0400
Resent-Date: Fri, 08 May 2020 01:29:30 -0400
Resent-Message-Id: <E1jWvZi-00019n-1I@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWvZg-0004DE-5N
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:29:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588915714; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gGOLUL5jv1FqajGDS9KQXITm2iGvRqwwcft3VSyDoaqc0SQuIMwP1X48RDUGfEMdzXZU9PCqnYOuwBejtGILhVWzXzQZF7j4o8zR2+4D0ZpjsuemOkDDAxtm07rl9ftMqPB6wO66xr4xy5moRVrhctKeg3HoZ/pdG66O3MterLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588915714;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=n7E/tdChMElF0r6ONrCQIBFdxsWeY+gIjsdn0eo3/6M=; 
 b=mts2fZ0Pq2nOGyXAK53IVO+dEfE8xgKfJO9LNTa7A/LpWtIrB09L+cttv0eVKE79dYmjH3au5i5gvr75G5e+Dpwb2hRE4ERRfVrimLLNuBAsKebalzj9VtPrQaU20CJK3AGhAFVgPiv3yaLUQZh/l2siOq/20eu4PBT0lPsQigs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588915712512575.8488904048985;
 Thu, 7 May 2020 22:28:32 -0700 (PDT)
Message-ID: <158891571032.29923.11626722130579684161@45ef0f9c86ae>
In-Reply-To: <20200507155813.16169-1-philmd@redhat.com>
Subject: Re: [PATCH] accel: Move Xen accelerator code under accel/xen/
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Thu, 7 May 2020 22:28:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 23:43:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: sstabellini@kernel.org, ehabkost@redhat.com, quintela@redhat.com,
 paul@xen.org, dgilbert@redhat.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org, aleksandar.qemu.devel@gmail.com,
 mst@redhat.com, pbonzini@redhat.com, anthony.perard@citrix.com,
 imammedo@redhat.com, philmd@redhat.com, aurelien@aurel32.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNzE1NTgxMy4xNjE2
OS0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi90bXAvcWVtdS10ZXN0L3NyYy90
ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0ZWN0ZWQgUUVNVSBkZWF0
aCBmcm9tIHNpZ25hbCA2IChBYm9ydGVkKSAoY29yZSBkdW1wZWQpCiAgVEVTVCAgICBjaGVjay11
bml0OiB0ZXN0cy9jaGVjay1xZGljdAogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMDcKRVJST1Ig
LSB0b28gZmV3IHRlc3RzIHJ1biAoZXhwZWN0ZWQgNSwgZ290IDApCm1ha2U6ICoqKiBbY2hlY2st
cXRlc3QtYWFyY2g2NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLgogIFRFU1QgICAgY2hlY2stcXRlc3QteDg2XzY0OiB0ZXN0cy9xdGVzdC9mZGMtdGVz
dAogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvY2hlY2stYmxvY2stcWRpY3QKLS0tCiAgICBy
YWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFBy
b2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1s
YWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWU1OTRiOTc0OTQwNDQ0OTY4Yjc3Zjk0MjQz
MTBjYTNjJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZp
bmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VS
RV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScs
ICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12Jywg
Jy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hl
OnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXAybjRvcGUyL3NyYy9kb2Nr
ZXItc3JjLjIwMjAtMDUtMDgtMDEuMTUuMTQuMjE2MTg6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVk
IG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5p
bnN0YW5jZS51dWlkPWU1OTRiOTc0OTQwNDQ0OTY4Yjc3Zjk0MjQzMTBjYTNjCm1ha2VbMV06ICoq
KiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXAybjRvcGUyL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVu
LXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAxM20xNi4yNzZzCnVzZXIgICAg
MG04LjE4NXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAwNTA3MTU1ODEzLjE2MTY5LTEtcGhpbG1kQHJlZGhhdC5jb20vdGVzdGluZy5k
b2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

