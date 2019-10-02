Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5398C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:10:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794522133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794522133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgGf-0003cg-8f
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFgEG-0000tX-Kb
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFgEE-0003Ey-Ic
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:07:48 -0400
Resent-Date: Wed, 02 Oct 2019 11:07:47 -0400
Resent-Message-Id: <E1iFgEE-0003Ey-Ic@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFgEE-0003Dt-Ar; Wed, 02 Oct 2019 11:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570028836; cv=none; d=zoho.com; s=zohoarc; 
 b=Wm9XsESQ0EETPks5E4wz2Mg2Bot5wlJEog2l713mSSNIiFYhFBy1Qnn5ExyQmUQc3Lg33sbgDYAxciLG3JVKUweG3EWMc2O9m4H1btYmMIerT1ybPwSPKjW5SXHw0MDkTZVzTsCz3WJL7bRi6R/C0XP7Vm4KQtZgiFpb6gEAwYg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570028836;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=p47+nkCeGNXlpMTngY/tZwxI5wdy+4nzzl2uHuLVYgU=; 
 b=iVwHNqnP7ZGSmvtuLYCg5eMmanaVov9CzPod0lfgYuXvStYoZdiyq1aYG4HNhu3bF7Dmzuiw4f1cMO7dSEUHFE4EJc3CK/3UjgwMkbR+FqrIsPkD0YUJMHHdwOwazFplovZ6dgDpn6SZdCqFIZhPtFAzb4Sje9n0Gg4cFaKwyHM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570028835471979.9303738420437;
 Wed, 2 Oct 2019 08:07:15 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] qcow2: advanced compression options
In-Reply-To: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Message-ID: <157002883347.27524.13510585852065141081@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Wed, 2 Oct 2019 08:07:15 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.55
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcwMDI2MTY2LTc0ODU2Ni0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRv
Y2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1
aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIGJsb2NrL3BhcmFsbGVscy5vCiAgQ0MgICAgICBibG9jay9ibGtsb2d3
cml0ZXMubwogIENDICAgICAgYmxvY2svYmxvY2stYmFja2VuZC5vCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ibG9jay9xY293Mi5jOjQwNzc6NjQ6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSAnQWlvVGFz
aycKIHN0YXRpYyBjb3JvdXRpbmVfZm4gaW50IHFjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF90
YXNrX2VudHJ5KEFpb1Rhc2sgKnRhc2spCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9j
ay9xY293Mi5jOiBJbiBmdW5jdGlvbiAncWNvdzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3BhcnQn
OgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MDk4OjU6IGVycm9yOiB1bmtub3du
IHR5cGUgbmFtZSAnQWlvVGFza1Bvb2wnCiAgICAgQWlvVGFza1Bvb2wgKmFpbyA9IE5VTEw7CiAg
ICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTIzOjU6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYWlvX3Rhc2tfcG9vbF9zdGF0dXMnIFstV2Vy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgIHdoaWxlIChieXRlcyAmJiBh
aW9fdGFza19wb29sX3N0YXR1cyhhaW8pID09IDApIHsKICAgICBeCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ibG9jay9xY293Mi5jOjQxMjM6NTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24g
b2YgJ2Fpb190YXNrX3Bvb2xfc3RhdHVzJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9x
ZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDEzMDoxMzogZXJyb3I6IGltcGxpY2l0IGRlY2xh
cmF0aW9uIG9mIGZ1bmN0aW9uICdhaW9fdGFza19wb29sX25ldycgWy1XZXJyb3I9aW1wbGljaXQt
ZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgICAgICAgICBhaW8gPSBhaW9fdGFza19wb29sX25l
dyhRQ09XMl9NQVhfV09SS0VSUyk7CiAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9i
bG9jay9xY293Mi5jOjQxMzA6MTM6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9m
ICdhaW9fdGFza19wb29sX25ldycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVtdS10
ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMzA6Mzc6IGVycm9yOiAnUUNPVzJfTUFYX1dPUktFUlMn
IHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogICAgICAgICAgICAgYWlv
ID0gYWlvX3Rhc2tfcG9vbF9uZXcoUUNPVzJfTUFYX1dPUktFUlMpOwogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0
MTMwOjM3OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5
IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svcWNvdzIuYzo0MTMzOjk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5j
dGlvbiAncWNvdzJfYWRkX3Rhc2snIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0
aW9uXQogICAgICAgICByZXQgPSBxY293Ml9hZGRfdGFzayhicywgYWlvLCBxY293Ml9jb19wd3Jp
dGV2X2NvbXByZXNzZWRfdGFza19lbnRyeSwKICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svcWNvdzIuYzo0MTMzOjk6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9m
ICdxY293Ml9hZGRfdGFzaycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVtdS10ZXN0
L3NyYy9ibG9jay9xY293Mi5jOjQxMzM6Mzk6IGVycm9yOiAncWNvdzJfY29fcHdyaXRldl9jb21w
cmVzc2VkX3Rhc2tfZW50cnknIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQogICAgICAgICByZXQgPSBxY293Ml9hZGRfdGFzayhicywgYWlvLCBxY293Ml9jb19wd3JpdGV2
X2NvbXByZXNzZWRfdGFza19lbnRyeSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTQ1Ojk6IGVycm9yOiBp
bXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYWlvX3Rhc2tfcG9vbF93YWl0X2FsbCcg
Wy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgICAgIGFpb190YXNr
X3Bvb2xfd2FpdF9hbGwoYWlvKTsKICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
cWNvdzIuYzo0MTQ1Ojk6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdhaW9f
dGFza19wb29sX3dhaXRfYWxsJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KL3RtcC9xZW11LXRl
c3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6IEF0IHRvcCBsZXZlbDoKL3RtcC9xZW11LXRlc3Qvc3JjL2Js
b2NrL3Fjb3cyLmM6NDAxMjoxOiBlcnJvcjogJ3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF90
YXNrJyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rpb25dCiBxY293
Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFzayhCbG9ja0RyaXZlclN0YXRlICpicywKIF4KY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFtibG9jay9x
Y293Mi5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tl
ci9kb2NrZXIucHkiLCBsaW5lIDY2MiwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPTRhMGZhOTgxY2RiNzRiNDg5NDZmNjJkM2RmOTU2YmYxJywgJy11
JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0x
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtemsxdDBwd2wvc3JjL2RvY2tlci1zcmMuMjAxOS0x
MC0wMi0xMS4wNS4zNC4yODA5NDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3Jywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
NGEwZmE5ODFjZGI3NGI0ODk0NmY2MmQzZGY5NTZiZjEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtemsxdDBwd2wvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0Bj
ZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDFtMzkuMjY4cwp1c2VyICAgIDBtNy45ODRzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTcwMDI2
MTY2LTc0ODU2Ni0xLWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5j
b20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


