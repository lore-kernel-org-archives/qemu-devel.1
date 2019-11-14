Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF3CC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0E7206E4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 03:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0E7206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV5Op-0004mo-S3
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 22:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iV5NJ-0003uG-B2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iV5NH-0001Vr-4j
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 22:00:48 -0500
Resent-Date: Wed, 13 Nov 2019 22:00:48 -0500
Resent-Message-Id: <E1iV5NH-0001Vr-4j@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iV5NG-0001UW-Qq; Wed, 13 Nov 2019 22:00:47 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573700436; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZmptpQQuQUb8zso2xwwItMZXC5bdK6kCw11U+7E0rp5wU+i5O5muyQnPtGWVMGTP/3Awo+JuVthQUQCcw3zjnrSjrYSdxlM8jj9LWfX/+N91HnDiJgIFBvzMurFjpZ1GGA6yTh3UWpnuolfRnc0HWKCKymx6Nj580VhGth9MreU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573700436;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=q8p8wPxv8IXRKZzhZfFyjD33ZiNYvphJnWOte/mkEas=; 
 b=APz8ITlBUs8K0zxs17iyvHi0DNVf/MZCD158Jasv3H0lKcaf2A69Pu7BG+Ds/PFf/tk3f98KRAlTczKZKPG0Snw5MsfWVwunU9x/irnUq/rmlMncww1NvsPFroO2ubpbUu7ZTmUbqizDeN00HweAKAK2735mRUVxv0xnFsDhD5o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573700433007376.0659209480964;
 Wed, 13 Nov 2019 19:00:33 -0800 (PST)
In-Reply-To: <20191114024635.11363-1-eblake@redhat.com>
Subject: Re: [PATCH v3 for-4.2 0/4] Better NBD string length handling
Message-ID: <157370043192.25875.12348439356190898901@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Wed, 13 Nov 2019 19:00:33 -0800 (PST)
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExNDAyNDYzNS4xMTM2
My0xLWVibGFrZUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWlt
YWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgICAgICAgICAgICAg
ICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L29zZGVwLmg6MTQwLAogICAg
ICAgICAgICAgICAgIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL25iZC9zZXJ2ZXIuYzoyMDoKL3Rt
cC9xZW11LXRlc3Qvc3JjL25iZC9zZXJ2ZXIuYzogSW4gZnVuY3Rpb24gJ25iZF9uZWdvdGlhdGVf
aGFuZGxlX2V4cG9ydF9uYW1lJzoKL3Vzci94ODZfNjQtdzY0LW1pbmd3MzIvc3lzLXJvb3QvbWlu
Z3cvaW5jbHVkZS9nbGliLTIuMC9nbGliL2dsaWItYXV0b2NsZWFudXBzLmg6Mjg6MzogZXJyb3I6
ICduYW1lJyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJy
b3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgZ19mcmVlICgqcHApOwogICBefn5+fn5+fn5+fn4K
L3RtcC9xZW11LXRlc3Qvc3JjL25iZC9zZXJ2ZXIuYzo0MzU6MjI6IG5vdGU6ICduYW1lJyB3YXMg
ZGVjbGFyZWQgaGVyZQogICAgIGdfYXV0b2ZyZWUgY2hhciAqbmFtZTsKICAgICAgICAgICAgICAg
ICAgICAgIF5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFr
ZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBuYmQvc2VydmVyLm9dIEVy
cm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNr
IChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5w
eSIsIGxpbmUgNjYyLCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9OTYwZjU3Mjc3NTA0NGZiZGJkNzRhZGNhZmY1OTcxMmUnLCAnLXUnLCAnMTAwMycs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdD
Q0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC0wN2t4aTN5Xy9zcmMvZG9ja2VyLXNyYy4yMDE5LTExLTEzLTIxLjU3
LjU4LjI0NTM2Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9x
ZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIu
CmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTk2MGY1NzI3NzUw
NDRmYmRiZDc0YWRjYWZmNTk3MTJlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTA3
a3hpM3lfL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJv
ciAyCgpyZWFsICAgIDJtMzMuODM2cwp1c2VyICAgIDBtNy41OTJzCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTExNDAyNDYzNS4xMTM2
My0xLWVibGFrZUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

