Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1DFC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6C920842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 02:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6C920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFUKM-00020f-5x
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 22:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFUJQ-0001XD-4D
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFUJO-0005QF-77
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 22:24:19 -0400
Resent-Date: Tue, 01 Oct 2019 22:24:19 -0400
Resent-Message-Id: <E1iFUJO-0005QF-77@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21414)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFUJN-0005Mi-Gk; Tue, 01 Oct 2019 22:24:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569983032; cv=none; d=zoho.com; s=zohoarc; 
 b=FCSMc46v2jQd3j+cRht12HUt7MP0hpNSv9hoObnh+swL6UedRBQfJKYgNlBdGkdf++wh2NupYzLLlcwvrX2Vlh3imMIqbnfcWv+iI4izBpO4XGbrAy8JwL3RitoYnPoAO4JntiIsiWcYdFRs0mIM75GXodWTlsrNYY4BGA4tfm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569983032;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=EBOLe3v2tu4uWMg9XpFPgGT2B5A8ftfgqPSKkG7HiEs=; 
 b=HrvLY1biwvMwrN0tzNtjTfQO1pqy02YcUsi2vhy1mnoCGezUxFMaybndpC8XykBK6Rnn8n2NafCQo0YjVsvkDqmZuDZJyt+vXfV/jjWsHyAe1XpncY0/lTPuWWmHWzyUkZLjh4rqHRnvprbX6kzUoqFkq97L6OaP3L1L2gjeeYM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569983029937772.810819090622;
 Tue, 1 Oct 2019 19:23:49 -0700 (PDT)
Subject: Re: [PATCH 0/6] qcow2: advanced compression options
In-Reply-To: <1569958040-697220-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Message-ID: <156998302778.27524.10178584773785001083@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Tue, 1 Oct 2019 19:23:49 -0700 (PDT)
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
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRv
Y2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1
aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIGJsb2NrL3FlZC1sMi1jYWNoZS5vCiAgQ0MgICAgICBibG9jay9xZWQt
dGFibGUubwogIENDICAgICAgYmxvY2svcWVkLWNsdXN0ZXIubwovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svcWNvdzIuYzo0MDc3OjY0OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ0Fpb1Rhc2sn
CiBzdGF0aWMgY29yb3V0aW5lX2ZuIGludCBxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFz
a19lbnRyeShBaW9UYXNrICp0YXNrKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
cWNvdzIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF9wYXJ0JzoK
L3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDA5ODo1OiBlcnJvcjogdW5rbm93biB0
eXBlIG5hbWUgJ0Fpb1Rhc2tQb29sJwogICAgIEFpb1Rhc2tQb29sICphaW8gPSBOVUxMOwogICAg
IF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDEyMzo1OiBlcnJvcjogaW1wbGlj
aXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bvb2xfc3RhdHVzJyBbLVdlcnJv
cj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICB3aGlsZSAoYnl0ZXMgJiYgYWlv
X3Rhc2tfcG9vbF9zdGF0dXMoYWlvKSA9PSAwKSB7CiAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svcWNvdzIuYzo0MTIzOjU6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9m
ICdhaW9fdGFza19wb29sX3N0YXR1cycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMzA6MTM6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJh
dGlvbiBvZiBmdW5jdGlvbiAnYWlvX3Rhc2tfcG9vbF9uZXcnIFstV2Vycm9yPWltcGxpY2l0LWZ1
bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICAgICAgYWlvID0gYWlvX3Rhc2tfcG9vbF9uZXco
UUNPVzJfTUFYX1dPUktFUlMpOwogICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxv
Y2svcWNvdzIuYzo0MTMwOjEzOiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAn
YWlvX3Rhc2tfcG9vbF9uZXcnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svcWNvdzIuYzo0MTMwOjM3OiBlcnJvcjogJ1FDT1cyX01BWF9XT1JLRVJTJyB1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICAgICAgICAgIGFpbyA9
IGFpb190YXNrX3Bvb2xfbmV3KFFDT1cyX01BWF9XT1JLRVJTKTsKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDEz
MDozNzogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBv
bmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KL3RtcC9xZW11LXRlc3Qvc3JjL2Js
b2NrL3Fjb3cyLmM6NDEzMzo5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rp
b24gJ3Fjb3cyX2FkZF90YXNrJyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0KICAgICAgICAgcmV0ID0gcWNvdzJfYWRkX3Rhc2soYnMsIGFpbywgcWNvdzJfY29fcHdyaXRl
dl9jb21wcmVzc2VkX3Rhc2tfZW50cnksCiAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Js
b2NrL3Fjb3cyLmM6NDEzMzo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAn
cWNvdzJfYWRkX3Rhc2snIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQovdG1wL3FlbXUtdGVzdC9z
cmMvYmxvY2svcWNvdzIuYzo0MTMzOjM5OiBlcnJvcjogJ3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJl
c3NlZF90YXNrX2VudHJ5JyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikK
ICAgICAgICAgcmV0ID0gcWNvdzJfYWRkX3Rhc2soYnMsIGFpbywgcWNvdzJfY29fcHdyaXRldl9j
b21wcmVzc2VkX3Rhc2tfZW50cnksCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDE0NTo5OiBlcnJvcjogaW1w
bGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bvb2xfd2FpdF9hbGwnIFst
V2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICBhaW9fdGFza19w
b29sX3dhaXRfYWxsKGFpbyk7CiAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fj
b3cyLmM6NDE0NTo5OiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYWlvX3Rh
c2tfcG9vbF93YWl0X2FsbCcgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVtdS10ZXN0
L3NyYy9ibG9jay9xY293Mi5jOiBBdCB0b3AgbGV2ZWw6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9j
ay9xY293Mi5jOjQwMTI6MTogZXJyb3I6ICdxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFz
aycgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XZXJyb3I9dW51c2VkLWZ1bmN0aW9uXQogcWNvdzJf
Y29fcHdyaXRldl9jb21wcmVzc2VkX3Rhc2soQmxvY2tEcml2ZXJTdGF0ZSAqYnMsCiBeCmNjMTog
YWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbYmxvY2svcWNv
dzIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD1jMGZmNmRkNmZiM2Y0NmQxYjljMDdhMTA2YzlkZDI2YScsICctdScs
ICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLThtX25lYmFiL3NyYy9kb2NrZXItc3JjLjIwMTktMTAt
MDEtMjIuMjIuMDguNjQ1NTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92
YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBz
dGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzBm
ZjZkZDZmYjNmNDZkMWI5YzA3YTEwNmM5ZGQyNmEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBF
cnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rl
ci10bXAtOG1fbmViYWIvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50
b3M3XSBFcnJvciAyCgpyZWFsICAgIDFtNDAuMzkwcwp1c2VyICAgIDBtOC45NjZzCgoKVGhlIGZ1
bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTY5OTU4MDQw
LTY5NzIyMC0xLWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20v
dGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


