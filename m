Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5026FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A4D2074A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A4D2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCrf0-0003eq-AW
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jCreC-00039S-8P
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jCreA-0007v6-P5
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:15:11 -0400
Resent-Date: Fri, 13 Mar 2020 17:15:11 -0400
Resent-Message-Id: <E1jCreA-0007v6-P5@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jCre6-0007tP-Ig; Fri, 13 Mar 2020 17:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584134071; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jhm8CxGQIfWeGaq4opPE8BO7XIHO0+RECoX6OvEdEhwYnEQg1lqK4bzoxCSyY0u2CBtfjTLiE4AN92dhcIIHUUlScN7vryapnLvwJVJOVo+AS9OyOL2MmF3gWCOWuv8ZIsJQZC96QDrt9S5JOpTSCQxPPaHMDUWSs0HGIMJud8k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584134071;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SQOA3GBXTReDjTgyIVc6aBtFK/qu+i6gylwAuXLcz3Y=; 
 b=bvInSAr3w8JjrqM77izpU+cqwqoiwIrhbZtcZVuDtJC/bMaDi88Mb3k8TXJFGQkiKSWteml9h0EXSvsFxHmXtWJjUNyABzFry4VmapthYWqYTo7wsrPCTT3LZ0y70RmIZYaeivEPqIcssF+D//GjSNZCI5cpvVoNyQy79yl6qkA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15841340696611003.6725708612325;
 Fri, 13 Mar 2020 14:14:29 -0700 (PDT)
In-Reply-To: <20200313184153.11275-1-philmd@redhat.com>
Subject: Re: [PATCH 0/9] user-mode: Prune build dependencies (part 2)
Message-ID: <158413406692.16773.10870771250680069237@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Fri, 13 Mar 2020 14:14:29 -0700 (PDT)
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, rth@twiddle.net, ben@skyportsystems.com,
 pl@kamp.de, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com,
 ronniesahlberg@gmail.com, marcandre.lureau@redhat.com, imammedo@redhat.com,
 mreitz@redhat.com, philmd@redhat.com, dgilbert@redhat.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMzE4NDE1My4xMTI3
NS0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNh
biBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIg
b3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2Jh
Ymx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBM
SU5LICAgIHFlbXUtaW1nCi91c3IvYmluL2xkOiBxYXBpL3FhcGktY29tbWFuZHMtY2hhci5vOiBp
biBmdW5jdGlvbiBgcW1wX21hcnNoYWxfYWRkX2NsaWVudCc6Ci90bXAvcWVtdS10ZXN0L2J1aWxk
L3FhcGkvcWFwaS1jb21tYW5kcy1jaGFyLmM6NDA0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBx
bXBfYWRkX2NsaWVudCcKY2xhbmctODogZXJyb3I6IGxpbmtlciBjb21tYW5kIGZhaWxlZCB3aXRo
IGV4aXQgY29kZSAxICh1c2UgLXYgdG8gc2VlIGludm9jYXRpb24pCm1ha2U6ICoqKiBbL3RtcC9x
ZW11LXRlc3Qvc3JjL3J1bGVzLm1hazoxMjQ6IHFlbXUtc3RvcmFnZS1kYWVtb25dIEVycm9yIDEK
bWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0
IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxp
bmUgNjY0LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9NTFlMTQwODY1MzJjNDE5YjkzYmJjNzBhYWE2MDYyYTQnLCAnLXUnLCAnMTAwMScsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9Jywg
Jy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcv
LmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtXzRxcW96ZmQvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0x
My0xNy4xMC4xMC44MDk4Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTUxZTE0
MDg2NTMyYzQxOWI5M2JiYzcwYWFhNjA2MmE0Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLV80cXFvemZkL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVkb3Jh
XSBFcnJvciAyCgpyZWFsICAgIDRtMTcuNjgycwp1c2VyICAgIDBtOC4xOTBzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMxMzE4NDE1
My4xMTI3NS0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

