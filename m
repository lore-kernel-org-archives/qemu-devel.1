Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12449C54E4B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06BE20708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06BE20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwO5-0003Ei-U5
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWwNJ-0001oT-6I; Fri, 08 May 2020 02:20:45 -0400
Resent-Date: Fri, 08 May 2020 02:20:45 -0400
Resent-Message-Id: <E1jWwNJ-0001oT-6I@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWwNH-0002sP-Jq; Fri, 08 May 2020 02:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588918799; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lIDFJlaH5Zo1qoZARDY2dhpWXsn523QQBY8SW0dQDXr0CtsS3NWOmSHVIZpR7ViAWwdxj8wLlzhNaYN3/gipQqWYL7HtJCCu9/udCVJUznzhDfsKvrNqpqQnSFlEhDGWr5h5gU7/QkgBKZrNn34SXMypfU8XdZ6RA1siNllq7Mg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588918799;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=j1gMUo+yQvy7l7bT6H+VvMXdGd/6Gbmvo48AnY6aD8I=; 
 b=UKGxBmLmnWQQTTK1BixokkVGgCZdDgnJhvNem6IHf97oT1xbGE+yAFmG7aiBGt1EJ91oY590/+GLl3Hjh+bp/Opf2B0QkuCkjSnxm+rwwFaT2xhI0Inq6uok34nPQFUy1vsFnrt0e4nMtX794vaTf+lgWm6m0BWjg1effH9QgC0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588918797501363.59800078474245;
 Thu, 7 May 2020 23:19:57 -0700 (PDT)
Message-ID: <158891879462.29923.12514159203613805238@45ef0f9c86ae>
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
Subject: Re: [PATCH 00/10] exec: Shear 'exec/ram_addr.h' and make NVMe device
 target-agnostic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Thu, 7 May 2020 23:19:57 -0700 (PDT)
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org,
 mst@redhat.com, qemu-s390x@nongnu.org, cohuck@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 quintela@redhat.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au, kbusch@kernel.org, pbonzini@redhat.com,
 mreitz@redhat.com, philmd@redhat.com, borntraeger@de.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNzE3Mzk1OC4yNTg5
NC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay1xdGVz
dC1hYXJjaDY0OiB0ZXN0cy9xdGVzdC9hcm0tY3B1LWZlYXR1cmVzCkJyb2tlbiBwaXBlCi90bXAv
cWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0
ZWN0ZWQgUUVNVSBkZWF0aCBmcm9tIHNpZ25hbCA2IChBYm9ydGVkKSAoY29yZSBkdW1wZWQpCkVS
Uk9SIC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4cGVjdGVkIDUsIGdvdCAwKQptYWtlOiAqKiogW2No
ZWNrLXF0ZXN0LWFhcmNoNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNo
ZWQgam9icy4uLi4KICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL2NoZWNrLWJsb2NrLXFkaWN0
CiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWNoYXIKLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPWFhMDUxNjBhYzhlZjRhOGFhYmIwMjhkYjYyZTk3OGRjJywg
Jy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3Bh
dGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdics
ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtc2ozeV90c2cvc3JjL2RvY2tlci1zcmMuMjAy
MC0wNS0wOC0wMi4wNS40My4yMzgwMjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3
JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8g
ZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9YWEwNTE2MGFjOGVmNGE4YWFiYjAyOGRiNjJlOTc4ZGMKbWFrZVsxXTogKioqIFtkb2NrZXIt
cnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtc2ozeV90c2cvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlj
a0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE0bTEyLjE4MXMKdXNlciAgICAwbTkuNDUxcwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA1MDcxNzM5NTguMjU4OTQtMS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlj
a0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxs
eSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

