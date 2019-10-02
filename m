Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17884C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E107A2133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 15:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E107A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFgI1-00051Q-N5
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 11:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFgEm-0001as-Nf
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFgEl-0003df-9l
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 11:08:20 -0400
Resent-Date: Wed, 02 Oct 2019 11:08:20 -0400
Resent-Message-Id: <E1iFgEl-0003df-9l@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFgEl-0003cG-4G; Wed, 02 Oct 2019 11:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570028881; cv=none; d=zoho.com; s=zohoarc; 
 b=mH3HPI7YNOb23Zdawi+Kk7QUFkYJEhirPaG69s/dgFzVXBhHyhzGPeKdRMh0BNXr5QbKrrh9jSllhtWzr2Mc/o71ekx/y0Kxe/GFsidtVEuoqJUmfqPlvKxWYz9WdVGDB/nEp+bhrjbdXoDVn+TkMPi7Lpso3jTo8lJxFnIkvfY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570028881;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=xQcNfnriW6+wRZ/cT2btummOLWC+VO0R3uU5oBb3Vx8=; 
 b=hZbFFN6hv4/trU4bht+FGxAUsN6p/DJ2YmjB96/jDS18vy8D9x/fWu5qUq+6hOw+7C0M2ZTzX/mPe3sHWH4482nIap+aswepPtqb42B6znD88TxgomyjW8SBti7FG/ZOpFMWzqqef8wbE6Nk33fr7WIxLvVovJA9nhaZItDQDTQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570028879793507.6924479424248;
 Wed, 2 Oct 2019 08:07:59 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] qcow2: advanced compression options
In-Reply-To: <1570026166-748566-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Message-ID: <157002887811.27524.14084063094227153021@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Wed, 2 Oct 2019 08:07:59 -0700 (PDT)
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
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQg
QVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKICBDQyAgICAgIGJsb2NrL3F1b3J1bS5vCiAgQ0MgICAgICBibG9jay9ibGtk
ZWJ1Zy5vCiAgQ0MgICAgICBibG9jay9ibGt2ZXJpZnkubwovdG1wL3FlbXUtdGVzdC9zcmMvYmxv
Y2svcWNvdzIuYzo0MDc3OjY0OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUgJ0Fpb1Rhc2snOyBk
aWQgeW91IG1lYW4gJ0Fpb1dhaXQnPwogc3RhdGljIGNvcm91dGluZV9mbiBpbnQgcWNvdzJfY29f
cHdyaXRldl9jb21wcmVzc2VkX3Rhc2tfZW50cnkoQWlvVGFzayAqdGFzaykKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEFpb1dhaXQKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6IEluIGZ1
bmN0aW9uICdxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfcGFydCc6Ci90bXAvcWVtdS10ZXN0
L3NyYy9ibG9jay9xY293Mi5jOjQwOTg6NTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lICdBaW9U
YXNrUG9vbCcKICAgICBBaW9UYXNrUG9vbCAqYWlvID0gTlVMTDsKICAgICBefn5+fn5+fn5+fgov
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTIzOjIxOiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bvb2xfc3RhdHVzJyBbLVdlcnJvcj1p
bXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICB3aGlsZSAoYnl0ZXMgJiYgYWlvX3Rh
c2tfcG9vbF9zdGF0dXMoYWlvKSA9PSAwKSB7CiAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMjM6MjE6IGVy
cm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdhaW9fdGFza19wb29sX3N0YXR1cycg
Wy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi5j
OjQxMzA6MTk6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYWlvX3Rh
c2tfcG9vbF9uZXcnOyBkaWQgeW91IG1lYW4gJ2Fpb190aW1lcl9uZXcnPyBbLVdlcnJvcj1pbXBs
aWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICAgICAgICAgIGFpbyA9IGFpb190YXNrX3Bv
b2xfbmV3KFFDT1cyX01BWF9XT1JLRVJTKTsKICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+
fn5+fn5+CiAgICAgICAgICAgICAgICAgICBhaW9fdGltZXJfbmV3Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9ibG9jay9xY293Mi5jOjQxMzA6MTk6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9u
IG9mICdhaW9fdGFza19wb29sX25ldycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9xY293Mi5jOjQxMzA6Mzc6IGVycm9yOiAnUUNPVzJfTUFYX1dPUktF
UlMnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFu
ICdRQ09XMl9NQVhfVEhSRUFEUyc/CiAgICAgICAgICAgICBhaW8gPSBhaW9fdGFza19wb29sX25l
dyhRQ09XMl9NQVhfV09SS0VSUyk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fn5+fgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UUNPVzJfTUFYX1RIUkVBRFMKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDEzMDoz
Nzogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNl
IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2Nr
L3Fjb3cyLmM6NDEzMzoxNTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
ICdxY293Ml9hZGRfdGFzayc7IGRpZCB5b3UgbWVhbiAncWNvdzJfZG9fb3Blbic/IFstV2Vycm9y
PWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICByZXQgPSBxY293Ml9hZGRf
dGFzayhicywgYWlvLCBxY293Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFza19lbnRyeSwKICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn4KICAgICAgICAgICAgICAgcWNvdzJfZG9fb3Blbgov
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTMzOjE1OiBlcnJvcjogbmVzdGVkIGV4
dGVybiBkZWNsYXJhdGlvbiBvZiAncWNvdzJfYWRkX3Rhc2snIFstV2Vycm9yPW5lc3RlZC1leHRl
cm5zXQovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzo0MTMzOjM5OiBlcnJvcjogJ3Fj
b3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF90YXNrX2VudHJ5JyB1bmRlY2xhcmVkIChmaXJzdCB1
c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiAncWNvdzJfY29fcHdyaXRldl9jb21w
cmVzc2VkX3Rhc2snPwogICAgICAgICByZXQgPSBxY293Ml9hZGRfdGFzayhicywgYWlvLCBxY293
Ml9jb19wd3JpdGV2X2NvbXByZXNzZWRfdGFza19lbnRyeSwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWNvdzJfY29fcHdyaXRldl9j
b21wcmVzc2VkX3Rhc2sKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDE0NTo5OiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Fpb190YXNrX3Bvb2xfd2Fp
dF9hbGwnIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICBh
aW9fdGFza19wb29sX3dhaXRfYWxsKGFpbyk7CiAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLmM6NDE0NTo5OiBlcnJvcjogbmVzdGVk
IGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYWlvX3Rhc2tfcG9vbF93YWl0X2FsbCcgWy1XZXJyb3I9
bmVzdGVkLWV4dGVybnNdCkF0IHRvcCBsZXZlbDoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fj
b3cyLmM6NDAxMjoxOiBlcnJvcjogJ3Fjb3cyX2NvX3B3cml0ZXZfY29tcHJlc3NlZF90YXNrJyBk
ZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtZnVuY3Rpb25dCiBxY293Ml9jb19w
d3JpdGV2X2NvbXByZXNzZWRfdGFzayhCbG9ja0RyaXZlclN0YXRlICpicywKIF5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMg
ZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogYmxvY2sv
cWNvdzIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2Nr
ZXIvZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD1iNGVhZDBhMzI0ZTk0OWMxOWI4OTQxM2I0MjY1OGYzNCcsICct
dScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXdfc2Zsa3ExL3NyYy9kb2NrZXItc3JjLjIwMTkt
MTAtMDItMTEuMDUuNTkuMjk4Nzg6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
YjRlYWQwYTMyNGU5NDljMTliODk0MTNiNDI2NThmMzQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtd19zZmxrcTEvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0Bm
ZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMW01MC42NDRzCnVzZXIgICAgMG03LjcwOXMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NzAwMjYx
NjYtNzQ4NTY2LTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNv
bS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


