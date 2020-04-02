Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960FC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A687A2063A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 07:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A687A2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJuZs-0003Hm-Im
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 03:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJuZE-0002q5-RJ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJuZD-0001yO-5j
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:47:12 -0400
Resent-Date: Thu, 02 Apr 2020 03:47:12 -0400
Resent-Message-Id: <E1jJuZD-0001yO-5j@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJuZC-0001vw-R8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 03:47:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585813618; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cQyRLbVTmVRoDrH1kO01katH4YIQvhZZlU9bAkCR+XppDI7uUfMBIHkWkCCVCWAaos25fszVeK+Ha4tBY/4dNkPWQTHKN47Mnk1G5EMbbsXiDw75gjxhV3rlawQAw3HW+ylV53U8CXErfbv0lcZIs3ZG0twcyNOhrhAPlfxDFfw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585813618;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+DCNfbjhMCnhPf+JSBRNGCR9lDASw1U54iNasz9F0T4=; 
 b=bai8JdV2Sm5meEvVEZlQGf4Lx1lpbdbuf8sF5XtAcB1EE00DVNf6hZ4I7BwmM/JGMVJS4H2WC+j+ylSosGb/6Nkr0TZ8VXcpjZrXkSdw+od32nvjbTm/ycuGrSm3fn/i7G2nS1bfgPxpp2R3a9wFAkgYlG0vcUw98Q40BbNaG8M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585813614066792.1904812443086;
 Thu, 2 Apr 2020 00:46:54 -0700 (PDT)
In-Reply-To: <20200402065035.GA15477@simran-Inspiron-5558>
Subject: Re: [PATCH v2] lockable: Replace locks with lock guard macros
Message-ID: <158581361299.23425.3705455741401423957@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: singhalsimran0@gmail.com
Date: Thu, 2 Apr 2020 00:46:54 -0700 (PDT)
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
Cc: stefanha@gmail.com, jusual@mail.ru, qemu-devel@nongnu.org,
 yuval.shaia.ml@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMjA2NTAzNS5HQTE1
NDc3QHNpbXJhbi1JbnNwaXJvbi01NTU4LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
ICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L2kzODYvcGNfcGlpeC5vCiAgQ0MgICAgICB4ODZf
NjQtc29mdG1tdS9ody9pMzg2L3BjX3EzNS5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9ody9p
Mzg2L21pY3Jvdm0ubwovdG1wL3FlbXUtdGVzdC9zcmMvaHcvaHlwZXJ2L2h5cGVydi5jOjQ5NTo1
OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJfXycg
Wy1XZXJyb3IsLVd1bnVzZWQtdmFyaWFibGVdCiAgICBRRU1VX0xPQ0tfR1VBUkQoJmhhbmRsZXJz
X211dGV4KTsKICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9sb2NrYWJsZS5o
OjE3MzoyOTogbm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAnUUVNVV9MT0NLX0dVQVJEJwotLS0K
PHNjcmF0Y2ggc3BhY2U+OjI0OjE6IG5vdGU6IGV4cGFuZGVkIGZyb20gaGVyZQpxZW11X2xvY2th
YmxlX2F1dG9fX0NPVU5URVJfXwpeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9oeXBlcnYvaHlwZXJ2
LmM6NTY4OjU6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUgJ3FlbXVfbG9ja2FibGVfYXV0b19fQ09V
TlRFUl9fJyBbLVdlcnJvciwtV3VudXNlZC12YXJpYWJsZV0KICAgIFFFTVVfTE9DS19HVUFSRCgm
aGFuZGxlcnNfbXV0ZXgpOwogICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2xv
Y2thYmxlLmg6MTczOjI5OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdRRU1VX0xPQ0tfR1VB
UkQnCi0tLQpxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJfXwpeCjIgZXJyb3JzIGdlbmVyYXRl
ZC4KbWFrZVsxXTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9oeXBl
cnYvaHlwZXJ2Lm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3JkbWEvcmRtYV9ybS5jOjE1MDo1OiBlcnJv
cjogdW51c2VkIHZhcmlhYmxlICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5URVJfXycgWy1XZXJy
b3IsLVd1bnVzZWQtdmFyaWFibGVdCiAgICBRRU1VX0xPQ0tfR1VBUkQoJnRibC0+bG9jayk7CiAg
ICBeCi90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvbG9ja2FibGUuaDoxNzM6Mjk6IG5v
dGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ1FFTVVfTE9DS19HVUFSRCcKLS0tCnFlbXVfbG9ja2Fi
bGVfYXV0b19fQ09VTlRFUl9fCl4KMSBlcnJvciBnZW5lcmF0ZWQuCm1ha2VbMV06ICoqKiBbL3Rt
cC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogaHcvcmRtYS9yZG1hX3JtLm9dIEVycm9yIDEK
bWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IHg4Nl82NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFj
ZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9j
a2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD01Mjg5MTNjNWZiZGQ0ZTQyYmYxOTQ2
MTY4NDQyZjM0YycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82NC1zb2Z0bW11JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3Rt
cC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
aGc3d3pqdGQvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0wMi0wMy40My4xMy40NDc1Oi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LWRl
YnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1s
YWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTUyODkxM2M1ZmJkZDRlNDJiZjE5NDYxNjg0NDJm
MzRjCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRp
cmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWhnN3d6anRkL3NyYycKbWFrZTog
KioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDNtNDAu
MTkzcwp1c2VyICAgIDBtOC4wODRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQwMjA2NTAzNS5HQTE1NDc3QHNpbXJhbi1JbnNwaXJv
bi01NTU4L3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

