Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32172C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EA120842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EA120842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFUM6-0003Px-VJ
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFUKx-0002mL-8T
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFUKv-0007fV-M3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:25:55 -0400
Resent-Date: Tue, 01 Oct 2019 22:25:55 -0400
Resent-Message-Id: <E1iFUKv-0007fV-M3@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFUKv-0007ds-Fr; Tue, 01 Oct 2019 22:25:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569983140; cv=none; d=zoho.com; s=zohoarc; 
 b=cYXCzeZfG9dONGzfpbjn8Rq2LQ7rxIkkztFwVTSPcymHEEy/sbcdO9+hA3TOS1Kzv6vOOkS0MfAa8hOm0agJ1EAreMUa0JSnmQ/j6c5Mnur1bdUZAD3V81XjqAca7w6CNKPCHED3c7sHVZ97QAtZ+ZQg27rQzOrdlLvm2Id0h5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569983140;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=ULF0qvesr9rkk6oPkX+G7W8EYHyrx7VCfzLRu5Wpd5A=; 
 b=oNHos8OQ0/iXo5GheN0qrjhERHHsF1x1SKdnVMD34F3mIf3dnefnv/rGIMz2Tw1v3nblWghGtWL0aAyCHPdrc0FhY8nbwheFTaYkBOBgrGub/pykeMSjTwxhnzc5u3i8ACk//GyPnG1blCUElqIuuZMvxE9iTAcQD4l5S+ux1RA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569983138875598.1728476984092;
 Tue, 1 Oct 2019 19:25:38 -0700 (PDT)
Subject: Re: [PATCH 0/6] qcow2: advanced compression options
In-Reply-To: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Message-ID: <156998313681.27524.1197553152157634376@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Tue, 1 Oct 2019 19:25:38 -0700 (PDT)
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY5OTU4MDQwLTY5NzIyMC0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQg
QVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKICBDQyAgICAgIGJsb2NrL3FlZC10YWJsZS5vCiAgQ0MgICAgICBibG9jay9x
ZWQtY2x1c3Rlci5vCiAgQ0MgICAgICBibG9jay9xZWQtY2hlY2subwovdG1wL3FlbXUtdGVzdC9z
cmMvYmxvY2svcWNvdzIuYzo0MDc3OjY0OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ0Fpb1Rh
c2snOyBkaWQgeW91IG1lYW4gJ0Fpb1dhaXQnPwogc3RhdGljIGNvcm91dGluZV9mbiBpbnQgcWNv
dzJfY29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2tfZW50cnkoQWlvVGFzayAqdGFzaykKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEFpb1dhaXQKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6
IEluIGZ1bmN0aW9uICdxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfcGFydCc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQwOTg6NTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1l
ICdBaW9UYXNrUG9vbCcKICAgICBBaW9UYXNrUG9vbCAqYWlvID0gTlVMTDsKICAgICBefn5+fn5+
fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTIzOjIxOiBlcnJvcjogaW1w
bGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bvb2xfc3RhdHVzJyBbLVdl
cnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICB3aGlsZSAoYnl0ZXMgJiYg
YWlvX3Rhc2tfcG9vbF9zdGF0dXMoYWlvKSA9PSAwKSB7CiAgICAgICAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMjM6
MjE6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdhaW9fdGFza19wb29sX3N0
YXR1cycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9x
Y293Mi5jOjQxMzA6MTk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAn
YWlvX3Rhc2tfcG9vbF9uZXcnOyBkaWQgeW91IG1lYW4gJ2Fpb190aW1lcl9uZXcnPyBbLVdlcnJv
cj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICAgICAgICAgIGFpbyA9IGFpb190
YXNrX3Bvb2xfbmV3KFFDT1cyX01BWF9XT1JLRVJTKTsKICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+CiAgICAgICAgICAgICAgICAgICBhaW9fdGltZXJfbmV3Ci90bXAvcWVtdS10
ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMzA6MTk6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xh
cmF0aW9uIG9mICdhaW9fdGFza19wb29sX25ldycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90
bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMzA6Mzc6IGVycm9yOiAnUUNPVzJfTUFY
X1dPUktFUlMnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlv
dSBtZWFuICdRQ09XMl9NQVhfVEhSRUFEUyc/CiAgICAgICAgICAgICBhaW8gPSBhaW9fdGFza19w
b29sX25ldyhRQ09XMl9NQVhfV09SS0VSUyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUUNPVzJfTUFYX1RIUkVBRFMKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6
NDEzMDozNzogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25s
eSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2Jsb2NrL3Fjb3cyLmM6NDEzMzoxNTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uICdxY293Ml9hZGRfdGFzayc7IGRpZCB5b3UgbWVhbiAncWNvdzJfZG9fb3Blbic/IFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICByZXQgPSBxY293
Ml9hZGRfdGFzayhicywgYWlvLCBxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFza19lbnRy
eSwKICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4KICAgICAgICAgICAgICAgcWNvdzJfZG9f
b3BlbgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTMzOjE1OiBlcnJvcjogbmVz
dGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAncWNvdzJfYWRkX3Rhc2snIFstV2Vycm9yPW5lc3Rl
ZC1leHRlcm5zXQovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTMzOjM5OiBlcnJv
cjogJ3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF90YXNrX2VudHJ5JyB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiAncWNvdzJfY29fcHdyaXRl
dl9jb21wcmVzc2VkX3Rhc2snPwogICAgICAgICByZXQgPSBxY293Ml9hZGRfdGFzayhicywgYWlv
LCBxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFza19lbnRyeSwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWNvdzJfY29fcHdy
aXRldl9jb21wcmVzc2VkX3Rhc2sKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDE0
NTo5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bv
b2xfd2FpdF9hbGwnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAg
ICAgICBhaW9fdGFza19wb29sX3dhaXRfYWxsKGFpbyk7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDE0NTo5OiBlcnJvcjog
bmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYWlvX3Rhc2tfcG9vbF93YWl0X2FsbCcgWy1X
ZXJyb3I9bmVzdGVkLWV4dGVybnNdCkF0IHRvcCBsZXZlbDoKL3RtcC9xZW11LXRlc3Qvc3JjL2Js
b2NrL3Fjb3cyLmM6NDAxMjoxOiBlcnJvcjogJ3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF90
YXNrJyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rpb25dCiBxY293
Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFzayhCbG9ja0RyaXZlclN0YXRlICpicywKIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0
ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTog
YmxvY2svcWNvdzIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0
cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD01ZTQzZTZlNGFiNzg0YzMyYTk2ZjYxOGEyOWI3Y2Vl
ZicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BU
Uz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hP
V19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21l
L3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXl1Ynhrd3BqL3NyYy9kb2NrZXItc3Jj
LjIwMTktMTAtMDEtMjIuMjMuMjguMTA0Nzg6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVk
b3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9NWU0M2U2ZTRhYjc4NGMzMmE5NmY2MThhMjliN2NlZWYKbWFrZVsxXTogKioqIFtkb2Nr
ZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAteXVieGt3cGovc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1t
aW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm05LjYyMnMKdXNlciAgICAwbTcuNzc3cwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2
OTk1ODA0MC02OTcyMjAtMS1naXQtc2VuZC1lbWFpbC1hbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96
em8uY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


