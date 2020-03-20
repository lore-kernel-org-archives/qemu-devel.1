Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76229C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AFF620739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 13:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFF620739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFHwX-0006Zl-DY
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 09:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jFHvw-00060l-1M
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jFHvu-0005eG-QX
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:43:31 -0400
Resent-Date: Fri, 20 Mar 2020 09:43:31 -0400
Resent-Message-Id: <E1jFHvu-0005eG-QX@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jFHvu-0005dv-He
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 09:43:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584711805; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NYbpBBu9HSZUuwF67EcLkToCnryCnbRHFQ86JTTbhC98hb/0bufpzfRPTJkIH3cAp+4fPP8+Ekr8NwDAphS2kM092z5exTloZZFV2gUFPvg6JUXqh6Gdb3JhH6DATaB7dYr0H2SLoMPeot8oYkMwm86c7aE32mkG01nDgwEApPg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584711805;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WDIO2qHaMIjqjHsXGY/blPdnBOqA9b05mKU1JSN/EgQ=; 
 b=YWSqFzNvPAu2WgbMwq4hrR0W31wjFPI0avU7M/NWs9wQr4O66IKNxZZd54J7tHeDQvApSe7hkUbCys1qFmEKgPKz974htvonFph71/g3E80d6uy0BqcmOchjtEd/3rvgN6hEiM4Qxv4hOgqStsB0uXFGgJ74m9wU8qckA33AFac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584711803954277.6137036493409;
 Fri, 20 Mar 2020 06:43:23 -0700 (PDT)
In-Reply-To: <20200320123137.1937091-1-dnbrdsky@gmail.com>
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
Message-ID: <158471180295.15515.1369533827289907154@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dnbrdsky@gmail.com
Date: Fri, 20 Mar 2020 06:43:23 -0700 (PDT)
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
Cc: dnbrdsky@gmail.com, stefanha@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyMDEyMzEzNy4xOTM3
MDkxLTEtZG5icmRza3lAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
YXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhl
aXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHBy
b2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElT
VD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
ICBDQyAgICAgIHV0aWwvbW9kdWxlLm8KICBDQyAgICAgIHV0aWwvaG9zdC11dGlscy5vCiAgQ0Mg
ICAgICB1dGlsL2JpdG1hcC5vCi90bXAvcWVtdS10ZXN0L3NyYy91dGlsL3RocmVhZC1wb29sLmM6
MjEzOjU6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUgJ3FlbXVfbG9ja2FibGVfYXV0bzEnIFstV2Vy
cm9yLC1XdW51c2VkLXZhcmlhYmxlXQogICAgUUVNVV9MT0NLX0dVQVJEKCZwb29sLT5sb2NrKTsK
ICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9sb2NrYWJsZS5oOjE3MzoyOTog
bm90ZTogZXhwYW5kZWQgZnJvbSBtYWNybyAnUUVNVV9MT0NLX0dVQVJEJwotLS0KcWVtdV9sb2Nr
YWJsZV9hdXRvMQpeCjEgZXJyb3IgZ2VuZXJhdGVkLgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0
L3NyYy9ydWxlcy5tYWs6Njk6IHV0aWwvdGhyZWFkLXBvb2wub10gRXJyb3IgMQptYWtlOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGlu
IDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkK
c3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdk
b2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD04MzM4NDU1
NGQ1NTI0YTQxYjM4YTJmODBjNDhjMmYzMCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0
JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPXg4Nl82
NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICct
ZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NB
Q0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3Fl
bXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtem9xNHBxZ2kvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0yMC0wOS4zOS41
Ni4yMDI4MjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVt
dS9ydW4nLCAndGVzdC1kZWJ1ZyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpm
aWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04MzM4NDU1NGQ1NTI0
YTQxYjM4YTJmODBjNDhjMmYzMAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFr
ZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC16b3E0
cHFnaS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LWRlYnVnQGZlZG9yYV0gRXJyb3Ig
MgoKcmVhbCAgICAzbTI2Ljg5M3MKdXNlciAgICAwbTguMzc1cwoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMjAxMjMxMzcuMTkzNzA5
MS0xLWRuYnJkc2t5QGdtYWlsLmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

