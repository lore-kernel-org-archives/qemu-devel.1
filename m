Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A01C33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 05:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B448A21556
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 05:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B448A21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqsB0-0000UE-Pd
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 00:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iqsAR-0008VW-QJ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 00:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iqsAQ-0004qc-9m
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 00:21:35 -0500
Resent-Date: Mon, 13 Jan 2020 00:21:35 -0500
Resent-Message-Id: <E1iqsAQ-0004qc-9m@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iqsAQ-0004p8-1o
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 00:21:34 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578892879432273.0177186081702;
 Sun, 12 Jan 2020 21:21:19 -0800 (PST)
In-Reply-To: <20200113045704.12318-1-coiby.xu@gmail.com>
Subject: Re: [PATCH v1 0/5] vhost-user block device backend implementation
Message-ID: <157889287819.17824.5639853317020239861@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: coiby.xu@gmail.com
Date: Sun, 12 Jan 2020 21:21:19 -0800 (PST)
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 qemu-devel@nongnu.org, coiby.xu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExMzA0NTcwNC4xMjMx
OC0xLWNvaWJ5Lnh1QGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgY2hh
cmRldi9jaGFyLXJpbmdidWYubwogIENDICAgICAgY2hhcmRldi9jaGFyLXNlcmlhbC5vCiAgQ0Mg
ICAgICBjaGFyZGV2L2NoYXItc29ja2V0Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL2NvbnRyaWIvbGli
dmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmM6MjY6MTA6IGZhdGFsIGVycm9yOiBzeXMvc29ja2V0
Lmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+CiAg
ICAgICAgICBefn5+fn5+fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiog
Wy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGNvbnRyaWIvbGlidmhvc3QtdXNlci9s
aWJ2aG9zdC11c2VyLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L2Jsb2NrL3Zob3N0LXVzZXIuaDozLAogICAgICAgICAgICAgICAgIGZyb20gL3RtcC9xZW11LXRl
c3Qvc3JjL2Jsb2NrZGV2LXZ1LmM6MjoKL3RtcC9xZW11LXRlc3Qvc3JjL2NvbnRyaWIvbGlidmhv
c3QtdXNlci9saWJ2aG9zdC11c2VyLmg6MjA6MTA6IGZhdGFsIGVycm9yOiBzeXMvcG9sbC5oOiBO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSA8c3lzL3BvbGwuaD4KICAgICAgICAg
IF5+fn5+fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiogWy90bXAvcWVt
dS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrZGV2LXZ1Lm9dIEVycm9yIDEKSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2Jsb2NrL3Zob3N0LXVzZXIu
aDozLAogICAgICAgICAgICAgICAgIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUtdnUuYzoy
MjoKL3RtcC9xZW11LXRlc3Qvc3JjL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2Vy
Lmg6MjA6MTA6IGZhdGFsIGVycm9yOiBzeXMvcG9sbC5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0
b3J5CiAjaW5jbHVkZSA8c3lzL3BvbGwuaD4KICAgICAgICAgIF5+fn5+fn5+fn5+fgpjb21waWxh
dGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6
Njk6IHFlbXUtdnUub10gRXJyb3IgMQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRl
c3Qvc3JjL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLWdsaWIuaDoxOSwKICAg
ICAgICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9jb250cmliL2xpYnZob3N0LXVz
ZXIvbGlidmhvc3QtdXNlci1nbGliLmM6MTc6Ci90bXAvcWVtdS10ZXN0L3NyYy9jb250cmliL2xp
YnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5oOjIwOjEwOiBmYXRhbCBlcnJvcjogc3lzL3BvbGwu
aDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQogI2luY2x1ZGUgPHN5cy9wb2xsLmg+CiAgICAg
ICAgICBefn5+fn5+fn5+fn4KY29tcGlsYXRpb24gdGVybWluYXRlZC4KbWFrZTogKioqIFsvdG1w
L3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBjb250cmliL2xpYnZob3N0LXVzZXIvbGlidmhv
c3QtdXNlci1nbGliLm9dIEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
OgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9kdWxl
PgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1
ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9NWEyN2E5YjFmODE2NDljODg1ODhiMjY1MDBhMjQ2MGUnLCAnLXUnLCAnMTAwMycsICct
LXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJH
RVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1l
JywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC16MG02dnc1Mi9zcmMvZG9ja2VyLXNyYy4yMDIwLTAxLTEzLTAwLjE5LjE3
LjIwNDgzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11
L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZp
bHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTVhMjdhOWIxZjgxNjQ5
Yzg4NTg4YjI2NTAwYTI0NjBlCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtl
WzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXowbTZ2
dzUyL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAy
CgpyZWFsICAgIDJtMS4xMjhzCnVzZXIgICAgMG02LjcwNnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTEzMDQ1NzA0LjEyMzE4LTEt
Y29pYnkueHVAZ21haWwuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


