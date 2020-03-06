Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80861C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A84A20848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A84A20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADDw-0006GU-Jg
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jADD6-0005Td-5d
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jADD4-0002IT-Gx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:40:15 -0500
Resent-Date: Fri, 06 Mar 2020 08:40:15 -0500
Resent-Message-Id: <E1jADD4-0002IT-Gx@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jADD4-0001wj-7e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:40:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583501999; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GrbCC4o7p+pEMA8zt7ieNo8DmAX90we7HXlpa6OjBGH91RCpC3yKvCX5xGdNwx6ySrc+1FWk5/IiEoOPnsxA1Fv9Esw2PeBN9J1uRwmj3jUmRnTBS9HAKapynDrIzxkm/vSdzc22nOfeusbyt31XRGS4Mmg80+D5Ntqi7WyPMtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583501999;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IGxHQ+EX5UVp1JXtB5fMpdaEDT2EqJlvz1z5BWQskMY=; 
 b=B+KYf2WrcoRtDK3JlZI9gGE8AxUyBcrAQlAIDhUTqTCAAxpJXuUJSWyol5QyfuKntPZEQ2s7kJz6gbsaIlFQ5hn187goLa9WGhJYsgnK3TOohiwTLQyYruQ2zkoQJ5lnB/rECuya2rq4lIFdWdFaI+5qVQ8/w+hiLrSTSxtTMsg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583501996993966.6885888090575;
 Fri, 6 Mar 2020 05:39:56 -0800 (PST)
In-Reply-To: <20200306120735.24457-1-jingqi.liu@intel.com>
Subject: Re: [PATCH] util: fix to check if target OS is linux in
 util/mmap-alloc.c
Message-ID: <158350199555.14529.11886087445555494002@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jingqi.liu@intel.com
Date: Fri, 6 Mar 2020 05:39:56 -0800 (PST)
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
Cc: peter.maydell@linaro.org, jtomko@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwNjEyMDczNS4yNDQ1
Ny0xLWppbmdxaS5saXVAaW50ZWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2Vy
LWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0Bm
ZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZpbGU6ICIvdG1w
L3FlbXUtbnNpc1xxZW11LWRvYy5odG1sIiAtPiBubyBmaWxlcyBmb3VuZC4KVXNhZ2U6IEZpbGUg
Wy9ub25mYXRhbF0gWy9hXSAoWy9yXSBbL3ggZmlsZXNwZWMgWy4uLl1dIGZpbGVzcGVjIFsuLi5d
IHwKICAgL29uYW1lPW91dGZpbGUgb25lX2ZpbGVfb25seSkKRXJyb3IgaW4gc2NyaXB0ICIvdG1w
L3FlbXUtdGVzdC9zcmMvcWVtdS5uc2kiIG9uIGxpbmUgMTgwIC0tIGFib3J0aW5nIGNyZWF0aW9u
IHByb2Nlc3MKbWFrZTogKioqIFtNYWtlZmlsZToxMTYyOiBxZW11LXNldHVwLTQuMi41MC5leGVd
IEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVz
dHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQo
bWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MTI5NjM3Y2E0
MjVmNGZhZTgyMzM0OWNkMmVhM2Q0YjAnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1w
L2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hl
Oi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1s
Y2FpZmk3Ny9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTA2LTA4LjM2LjI5LjUyNzg6L3Zhci90bXAv
cWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWlu
Z3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxh
YmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MTI5NjM3Y2E0MjVmNGZhZTgyMzM0OWNkMmVhM2Q0
YjAKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbGNhaWZpNzcvc3JjJwptYWtlOiAq
KiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgM20yNi41
MzRzCnVzZXIgICAgMG03LjkyNnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzA2MTIwNzM1LjI0NDU3LTEtamluZ3FpLmxpdUBpbnRl
bC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFp
bCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3Jn
L10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

