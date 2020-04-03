Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C72C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 22:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CC72078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 22:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CC72078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKUT2-00020H-72
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 18:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jKUSQ-0001Te-Hb
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jKUSO-00042W-EE
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 18:06:34 -0400
Resent-Date: Fri, 03 Apr 2020 18:06:33 -0400
Resent-Message-Id: <E1jKUSO-00042W-EE@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jKUSO-0003op-8c; Fri, 03 Apr 2020 18:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585951560; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F6wTKfLzhK9QQvg1Lpk7s3XgJ+ieKU0wWyWTHFWpe7lxoit6FvN1Xu3PshqfXlIjFEYl8EG75y02zissvwmfAUl4br7huFwGnnQmE0l1qejNSIYN/zFie8r7EQVnQdc5bLO8T3HPT+a9uiPa7s+vYSI5adDfhpW5wf92pIwtKCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585951560;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=anN9rBDg8ejAv1llTRJ02SWlQ8Pa2QYXsnmqxge67JA=; 
 b=j+4ZM8mdaGGSfXNjoZh7SJuCX9Om2f9jAd/ufUk3tdMaw+FUHAYffZVgcOCxcBcsQ0oR2AhECzJNEs7y+uVClr+her/8FbqEzuAQz+NmR6XiQEDZm23GX2pnIoGqh0iw1LFFhnkXrkR40shZTOxN7NbbsA3jmEAx7wvIKg3Xcl8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585951555766346.3132265350256;
 Fri, 3 Apr 2020 15:05:55 -0700 (PDT)
In-Reply-To: <20200403140018.13531-1-imammedo@redhat.com>
Subject: Re: [PATCH] nvdimm-utils: clean up headers and add license comment
Message-ID: <158595155390.23425.667478371661962835@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: imammedo@redhat.com
Date: Fri, 3 Apr 2020 15:05:55 -0700 (PDT)
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, sbhat@linux.ibm.com,
 aik@ozlabs.ru, groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMzE0MDAxOC4xMzUz
MS0xLWltYW1tZWRvQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKLS0tIC90bXAvcWVtdS10ZXN0
L3NyYy90ZXN0cy9xZW11LWlvdGVzdHMvMDQwLm91dCAgICAgICAyMDIwLTA0LTAzIDEzOjU0OjMw
LjAwMDAwMDAwMCArMDAwMAorKysgL3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rl
c3RzLzA0MC5vdXQuYmFkIDIwMjAtMDQtMDMgMjE6NTg6MDIuNDk0MDc4NzAyICswMDAwCkBAIC0x
LDMgKzEsNSBAQAorV0FSTklORzpxZW11Lm1hY2hpbmU6cWVtdSByZWNlaXZlZCBzaWduYWwgOTog
L3RtcC9xZW11LXRlc3QvYnVpbGQvdGVzdHMvcWVtdS1pb3Rlc3RzLy4uLy4uL3g4Nl82NC1zb2Z0
bW11L3FlbXUtc3lzdGVtLXg4Nl82NCAtZGlzcGxheSBub25lIC12Z2Egbm9uZSAtY2hhcmRldiBz
b2NrZXQsaWQ9bW9uLHBhdGg9L3RtcC90bXAuWlZKQWtkc1l5OS9xZW11LTIwNjI0LW1vbml0b3Iu
c29jayAtbW9uIGNoYXJkZXY9bW9uLG1vZGU9Y29udHJvbCAtcXRlc3QgdW5peDpwYXRoPS90bXAv
dG1wLlpWSkFrZHNZeTkvcWVtdS0yMDYyNC1xdGVzdC5zb2NrIC1hY2NlbCBxdGVzdCAtbm9kZWZh
dWx0cyAtZGlzcGxheSBub25lIC1hY2NlbCBxdGVzdCAtZHJpdmUgaWY9bm9uZSxpZD1kcml2ZTAs
ZmlsZT0vdG1wL3FlbXUtdGVzdC90ZXN0LmltZyxmb3JtYXQ9cWNvdzIsY2FjaGU9d3JpdGViYWNr
LGFpbz10aHJlYWRzLG5vZGUtbmFtZT10b3AsYmFja2luZy5ub2RlLW5hbWU9bWlkLGJhY2tpbmcu
YmFja2luZy5ub2RlLW5hbWU9YmFzZSAtZGV2aWNlIHZpcnRpby1zY3NpLXBjaSAtZGV2aWNlIHNj
c2ktaGQsaWQ9c2NzaTAsZHJpdmU9ZHJpdmUwCitXQVJOSU5HOnFlbXUubWFjaGluZTpxZW11IHJl
Y2VpdmVkIHNpZ25hbCA5OiAvdG1wL3FlbXUtdGVzdC9idWlsZC90ZXN0cy9xZW11LWlvdGVzdHMv
Li4vLi4veDg2XzY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0teDg2XzY0IC1kaXNwbGF5IG5vbmUgLXZn
YSBub25lIC1jaGFyZGV2IHNvY2tldCxpZD1tb24scGF0aD0vdG1wL3RtcC5aVkpBa2RzWXk5L3Fl
bXUtMjA2MjQtbW9uaXRvci5zb2NrIC1tb24gY2hhcmRldj1tb24sbW9kZT1jb250cm9sIC1xdGVz
dCB1bml4OnBhdGg9L3RtcC90bXAuWlZKQWtkc1l5OS9xZW11LTIwNjI0LXF0ZXN0LnNvY2sgLWFj
Y2VsIHF0ZXN0IC1ub2RlZmF1bHRzIC1kaXNwbGF5IG5vbmUgLWFjY2VsIHF0ZXN0IC1kcml2ZSBp
Zj1ub25lLGlkPWRyaXZlMCxmaWxlPS90bXAvcWVtdS10ZXN0L3Rlc3QuaW1nLGZvcm1hdD1xY293
MixjYWNoZT13cml0ZWJhY2ssYWlvPXRocmVhZHMsbm9kZS1uYW1lPXRvcCxiYWNraW5nLm5vZGUt
bmFtZT1taWQsYmFja2luZy5iYWNraW5nLm5vZGUtbmFtZT1iYXNlIC1kZXZpY2UgdmlydGlvLXNj
c2ktcGNpIC1kZXZpY2Ugc2NzaS1oZCxpZD1zY3NpMCxkcml2ZT1kcml2ZTAKIC4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uCiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiBSYW4gNTkgdGVzdHMKLS0tCk5vdCBydW46IDI1OQpGYWlsdXJlczogMDQwCkZhaWxl
ZCAxIG9mIDExNiBpb3Rlc3RzCm1ha2U6ICoqKiBbY2hlY2stdGVzdHMvY2hlY2stYmxvY2suc2hd
IEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVz
dHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQo
bWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZjgzMjQ3YzYz
YzYyNDI1NThhZWQ1MmVjYjFmZjBiZmQnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3Rt
cC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
OHQxZ21iczUvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0wMy0xNy41MS40Ny4xMTUzODovdmFyL3Rt
cC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
cXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZjgzMjQ3YzYzYzYyNDI1NThhZWQ1MmVjYjFm
ZjBiZmQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOHQxZ21iczUvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE0
bTcuMzA2cwp1c2VyICAgIDBtOS4zMDRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQwMzE0MDAxOC4xMzUzMS0xLWltYW1tZWRvQHJl
ZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

