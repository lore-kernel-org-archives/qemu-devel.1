Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6D4C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED8920643
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED8920643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHqs-0005HF-6z
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipHWf-0002WZ-Go
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipHWd-0003cN-RN
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:01:57 -0500
Resent-Date: Wed, 08 Jan 2020 15:01:57 -0500
Resent-Message-Id: <E1ipHWd-0003cN-RN@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipHWd-0003ac-JH
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:01:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1578513706; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=chM7O7rv7V2O3HTUUNfQD3nFevsKUxlEb7yoQxwh8yOJ4RFQWol9ZTxo1wB+xfhr0NjZv0/4uuW1f2CHsci0gN9ndXP7pJg0HiHVLi80fcxLNB0D28i1EXLW5J01+Utebkxp5udqPtA1+iS1iuSdUPplroPNDBJ9Z1a2jNDQ7GE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1578513706;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xXJOLqAkzb9pl13WK9piRpn39/w5+tqgtXdEcYEg/QI=; 
 b=L1KHhaVyIjr4KxMJohE/OBeheMxHeCDjvInFccrR142mLPOXhVBCpDLNKXP/VH7JWTRujlaXskb+sYPEXlQYcBBexKQIWrilHv2FegwOa79L7bo5C/hNWPIS1+A3FXKzQQStChPLYb3v0M0F1tfeglDBJGqhnhPEHy7QNI8j7Fs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578513703795564.866566677624;
 Wed, 8 Jan 2020 12:01:43 -0800 (PST)
In-Reply-To: <642f73c78a99258dc134e3879a0287db8ef176c0.1578497245.git.tgolembi@redhat.com>
Subject: Re: [PATCH v8] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <157851370234.6690.7910519642221702597@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tgolembi@redhat.com
Date: Wed, 8 Jan 2020 12:01:43 -0800 (PST)
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
Cc: marcandre.lureau@redhat.com, tgolembi@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS82NDJmNzNjNzhhOTkyNThkYzEz
NGUzODc5YTAyODdkYjhlZjE3NmMwLjE1Nzg0OTcyNDUuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20v
CgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxk
IHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQg
YmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVw
cm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFz
aApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHg4Nl82NC1zb2Z0bW11L2h3L3ZpcnRpby92
aXJ0aW8taW5wdXQtcGNpLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9pbnRjL2V4eW5v
czQyMTBfY29tYmluZXIubwovdG1wL3FlbXUtdGVzdC9zcmMvcWdhL2NvbW1hbmRzLXdpbjMyLmM6
IEluIGZ1bmN0aW9uICdnYV9nZXRfaGFyZHdhcmVfaWRzJzoKL3RtcC9xZW11LXRlc3Qvc3JjL3Fn
YS9jb21tYW5kcy13aW4zMi5jOjIzMDI6MTE6IGVycm9yOiB1bnVzZWQgdmFyaWFibGUgJ2h3X2lk
cycgWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQogICAgIEdTdHJ2IGh3X2lkcyA9IE5VTEw7CiAg
ICAgICAgICAgXn5+fn5+Ci90bXAvcWVtdS10ZXN0L3NyYy9xZ2EvY29tbWFuZHMtd2luMzIuYzog
SW4gZnVuY3Rpb24gJ3FtcF9ndWVzdF9nZXRfZGV2aWNlcyc6Ci90bXAvcWVtdS10ZXN0L3NyYy9x
Z2EvY29tbWFuZHMtd2luMzIuYzoyNDQzOjE6IGVycm9yOiBsYWJlbCAnb3V0JyBkZWZpbmVkIGJ1
dCBub3QgdXNlZCBbLVdlcnJvcj11bnVzZWQtbGFiZWxdCiBvdXQ6CiBefn4KY2MxOiBhbGwgd2Fy
bmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9z
cmMvcnVsZXMubWFrOjY5OiBxZ2EvY29tbWFuZHMtd2luMzIub10gRXJyb3IgMQptYWtlOiAqKiog
V2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11
L2h3L2ludGMvb21hcF9pbnRjLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9pbnRjL2Jj
bTI4MzVfaWMubwotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzE2NTc2
ZGE1OWI3NDg0OWExZmE4YTliOGI3NGY4YmUnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAn
LWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAn
LWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC02MzFkc2U3My9zcmMvZG9ja2VyLXNyYy4yMDIwLTAxLTA4LTE0LjU4LjU4Ljc4NTQ6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
bWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzE2NTc2ZGE1OWI3NDg0OWExZmE4YTliOGI3
NGY4YmUKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNjMxZHNlNzMvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm00
NC41ODNzCnVzZXIgICAgMG04LjAwNHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzY0MmY3M2M3OGE5OTI1OGRjMTM0ZTM4NzlhMDI4N2RiOGVm
MTc2YzAuMTU3ODQ5NzI0NS5naXQudGdvbGVtYmlAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1t
aW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


