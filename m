Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8E2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C6B2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C6B2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOx6-00045k-It
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joOvx-0003Dq-UQ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:16:41 -0400
Resent-Date: Thu, 25 Jun 2020 06:16:41 -0400
Resent-Message-Id: <E1joOvx-0003Dq-UQ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joOvv-0004AM-P9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:16:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593080193; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BmgBelbeyeXc5dnYJRZdoWWJdCc+c67aU/umJLpxQrlcbVU/xyZN8aIZnFFQhkAHiXcI7BeCvVoZ4834v2jcykgHwHVSiLVR84R7iZSqbItbJuCYbJkdoKkWcpxPVbHKiTHkijVHwDFCAKwKJCEfGkUpxdhZgqi0W3h32RfTyEg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593080193;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=J66z8AY7X7ZKIou/dLJ/muUecW7YFMlCrkZ24WU6Jjw=; 
 b=DZbFGEvOa6RMG9iEd78HthVOJP9yaQ99wJhZTvRKvDsO2pt6XmnuuIV5XsFGmWtKko4ppCzd3Qyc4KYPZbJEtUFGj7rhWiSeG6/TEXyulHgYrKzI4SEULHKnl3WGGBuFycghUO4UoaWpbx9QOviLK5pHoT0+S8Y9V+WOzJFaxiM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593080192069721.4918132148701;
 Thu, 25 Jun 2020 03:16:32 -0700 (PDT)
Message-ID: <159308019061.21628.3941512270240117514@d1fd068a5071>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
In-Reply-To: <20200625100430.22407-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mhartmay@linux.ibm.com
Date: Thu, 25 Jun 2020 03:16:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 06:13:13
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, stefanha@redhat.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNTEwMDQzMC4yMjQw
Ny0xLW1oYXJ0bWF5QGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHFnYS9x
YXBpLWdlbmVyYXRlZC9xZ2EtcWFwaS1jb21tYW5kcy5vCiAgQ0MgICAgICBxZ2EvcWFwaS1nZW5l
cmF0ZWQvcWdhLXFhcGktaW5pdC1jb21tYW5kcy5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1w
L3FlbXUtdGVzdC9zcmMvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYzo0NDow
OgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L29zZGVwLmg6MzI6Mjc6IGZhdGFsIGVy
cm9yOiBjb25maWctdGFyZ2V0Lmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRl
ICJjb25maWctdGFyZ2V0LmgiCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KY29tcGlsYXRp
b24gdGVybWluYXRlZC4KLS0tCiAgQlVJTEQgICBwYy1iaW9zL29wdGlvbnJvbS9saW51eGJvb3Rf
ZG1hLnJhdwogIFNJR04gICAgcGMtYmlvcy9vcHRpb25yb20vcHZoLmJpbgogIFNJR04gICAgcGMt
Ymlvcy9vcHRpb25yb20vbGludXhib290X2RtYS5iaW4KbWFrZTogKioqIFtjb250cmliL2xpYnZo
b3N0LXVzZXIvbGlidmhvc3QtdXNlci5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1
bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBG
aWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2OSwgaW4gPG1vZHVsZT4KLS0t
CiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNh
bGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4n
LCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTc2MzgyNzdiNzUzNjQ3ODk5ZmNi
MGMzMWVmMDg2MzA1JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11
bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NP
TkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScs
ICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywg
Jy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9j
Y2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdXVlbnM4MTQvc3Jj
L2RvY2tlci1zcmMuMjAyMC0wNi0yNS0wNi4xMy40MS4xNzcxMjovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9NzYzODI3N2I3NTM2NDc4OTlmY2IwYzMxZWYwODYzMDUKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdXVlbnM4MTQvc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDJtNDkuNTQ0cwp1c2Vy
ICAgIDBtOC44OTJzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDYyNTEwMDQzMC4yMjQwNy0xLW1oYXJ0bWF5QGxpbnV4LmlibS5jb20v
dGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

