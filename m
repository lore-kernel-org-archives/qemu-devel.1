Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF185C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE72206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 02:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE72206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOXlu-0004nY-ID
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 22:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jOXlP-0004Oo-1p
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jOXlN-000756-Ka
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:26:54 -0400
Resent-Date: Tue, 14 Apr 2020 22:26:54 -0400
Resent-Message-Id: <E1jOXlN-000756-Ka@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jOXlN-00074R-D6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 22:26:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586917576; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fcw9Sp1Mcy1dXLiEZUKxKwdFl2GXO4PD1w+Uh5I+gZT56QnAysnV4Cl2lNgP8W1Ag+LmDwSb1kdbw4xmO6NG2I3jBWPHFNUP7aPP5YQOf0oQJNERMmLkoJGRbQy3Ds3ltOe0sz2HYwX+Jn+1K4buaIYwt/42B6qoXW2hpLNozCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586917576;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=22FKAwiueT0P3fqVDk5WlGRs4kqwiU/FPig0SeeCt6E=; 
 b=KNb05NtKekSPit+XQuZsnYi8uRc8NVHO74wDYWBFateP5/WfRYSY357uphjC5jDYMsi8kuJ0sJ7RcT66yE6/G2SVSpam/zZmqyQqizdaENBBv/8CdWPHDADrPqUEOF6v062bK0+Ps13fb/AvbdmBkNA2lxQFsPgdGJxSXgo8O1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158691757395817.425352301788166;
 Tue, 14 Apr 2020 19:26:13 -0700 (PDT)
In-Reply-To: <20200415005938.23895-1-alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 00/26] VM introspection
Message-ID: <158691757140.27250.1512043180094131572@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alazar@bitdefender.com
Date: Tue, 14 Apr 2020 19:26:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: tamas@tklengyel.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 jan.kiszka@siemens.com, samuel.lauren@iki.fi, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alazar@bitdefender.com,
 quintela@redhat.com, patrick.colp@oracle.com, mathieu.tarral@protonmail.com,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 rth@twiddle.net, mdontu@bitdefender.com, dgilbert@redhat.com,
 marian.c.rotariu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNTAwNTkzOC4yMzg5
NS0xLWFsYXphckBiaXRkZWZlbmRlci5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IGJsb2NrL2Jsa2xvZ3dyaXRlcy5vCiAgQ0MgICAgICBibG9jay9ibG9jay1iYWNrZW5kLm8KCldh
cm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0L3NyYy9kb2NzLy4uL3FlbXUt
b3B0aW9ucy5oeDo1MDQxOklubGluZSBsaXRlcmFsIHN0YXJ0LXN0cmluZyB3aXRob3V0IGVuZC1z
dHJpbmcuCgpXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9j
cy8uLi9xZW11LW9wdGlvbnMuaHg6NTA0MTpJbmxpbmUgbGl0ZXJhbCBzdGFydC1zdHJpbmcgd2l0
aG91dCBlbmQtc3RyaW5nLgogIENDICAgICAgYmxvY2svc25hcHNob3QubwogIENDICAgICAgYmxv
Y2svcWFwaS5vCi0tLQogIENDICAgICAgYmxvY2svZmlsZS13aW4zMi5vCiAgQ0MgICAgICBibG9j
ay9udWxsLm8KICBDQyAgICAgIGJsb2NrL21pcnJvci5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTEx
NTogLmRvY3Nfc3lzdGVtX3FlbXUuMV9kb2NzX3N5c3RlbV9xZW11LWJsb2NrLWRyaXZlcnMuN19k
b2NzX3N5c3RlbV9xZW11LWNwdS1tb2RlbHMuNy5zZW50aW5lbC5dIEVycm9yIDIKbWFrZTogKioq
IERlbGV0aW5nIGZpbGUgJy5kb2NzX3N5c3RlbV9xZW11LjFfZG9jc19zeXN0ZW1fcWVtdS1ibG9j
ay1kcml2ZXJzLjdfZG9jc19zeXN0ZW1fcWVtdS1jcHUtbW9kZWxzLjcuc2VudGluZWwuJwptYWtl
OiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW01ha2VmaWxl
OjExMDQ6IGRvY3Mvc3lzdGVtL2luZGV4Lmh0bWxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJl
Y2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUg
NjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxl
ZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9y
OiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2Nv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9OTk5OWM1ODNjZmU2NDU4OGExNzRhZjM2ZWY2ZDI5YzMnLCAn
LXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1y
bScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9Jywg
Jy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5W
PScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRj
aGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTZ4b2hmNF80L3NyYy9kb2NrZXItc3JjLjIwMjAt
MDQtMTQtMjIuMjMuMjguMjU2MjY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
OTk5OWM1ODNjZmU2NDU4OGExNzRhZjM2ZWY2ZDI5YzMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtNnhvaGY0XzQvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0Bm
ZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm00My4xNDZzCnVzZXIgICAgMG02Ljk1OHMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDE1
MDA1OTM4LjIzODk1LTEtYWxhemFyQGJpdGRlZmVuZGVyLmNvbS90ZXN0aW5nLmRvY2tlci1taW5n
d0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

