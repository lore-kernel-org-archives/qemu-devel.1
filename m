Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF443C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF77206DB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF77206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ics2E-000882-Kz
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1icrpR-0004PX-4V
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1icrpO-0004bY-VZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:10:00 -0500
Resent-Date: Thu, 05 Dec 2019 09:10:00 -0500
Resent-Message-Id: <E1icrpO-0004bY-VZ@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1icrpO-0004So-MM
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:09:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575554984; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OeBAE/y0b6MaKioCUa1oScbfUJAqwhHAqZPLbNwpfuDKCtmVQYQD2ucrDIHv6y68juAbG5bV2sWHm+xA4O1uFrezSqIMRyDnIhCCezQyptA9oxO5DyYMmTGBYjmBAgvLbTS6xma6fXYM9XEakQua9wZn4ehEOgtsfYPybZT6VkA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575554984;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lucN9eUclCoEw69/wrH8xZ7E0A1YJcrJQh6j3W8wz6M=; 
 b=A4sfBXkpuSrw4Z0oMvMAzvL1D8Hc4qSxEvKPKgic/JnJa7rMde9/u/gD0sHimp2NrG5UGdDYrMI6d54hvlfQkt0OHcpl1R+G8pyYJD7aMCpJ4Np3GDpARzdwx2XF4/qaN8oA2vRBXkEYl+IX8YJFG5bg3fF8z+y7Iu9i31D/UDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575554981686609.6460774169741;
 Thu, 5 Dec 2019 06:09:41 -0800 (PST)
In-Reply-To: <03fbd542d6bae4cf07be56c51d57fc2962720445.1575546855.git.tgolembi@redhat.com>
Subject: Re: [PATCH v6] qga: add command guest-get-devices for reporting
 VirtIO devices
Message-ID: <157555498034.27890.12517932225629858010@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tgolembi@redhat.com
Date: Thu, 5 Dec 2019 06:09:41 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8wM2ZiZDU0MmQ2YmFlNGNmMDdi
ZTU2YzUxZDU3ZmMyOTYyNzIwNDQ1LjE1NzU1NDY4NTUuZ2l0LnRnb2xlbWJpQHJlZGhhdC5jb20v
CgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxk
IHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQg
YmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVw
cm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFz
aApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKICBCVUlMRCAgIHBjLWJpb3Mvb3B0aW9ucm9tL2t2bXZhcGlj
LmltZwogIEJVSUxEICAgcGMtYmlvcy9vcHRpb25yb20vbXVsdGlib290LnJhdwovdG1wL3FlbXUt
dGVzdC9zcmMvcWdhL2NvbW1hbmRzLXdpbjMyLmM6IEluIGZ1bmN0aW9uICdxbXBfZ3Vlc3RfZ2V0
X2RldmljZXMnOgovdG1wL3FlbXUtdGVzdC9zcmMvcWdhL2NvbW1hbmRzLXdpbjMyLmM6MjM4OTox
OTogZXJyb3I6ICdHdWVzdERldmljZUluZm8nIHtha2EgJ3N0cnVjdCBHdWVzdERldmljZUluZm8n
fSBoYXMgbm8gbWVtYmVyIG5hbWVkICd2ZW5kb3JfaWQnCiAgICAgICAgICAgICBkZXZpY2UtPnZl
bmRvcl9pZCA9IGdfYXNjaWlfc3RydG91bGwodmVuZG9yX2lkLCBOVUxMLCAxNik7CiAgICAgICAg
ICAgICAgICAgICBefgovdG1wL3FlbXUtdGVzdC9zcmMvcWdhL2NvbW1hbmRzLXdpbjMyLmM6MjM5
MDoxOTogZXJyb3I6ICdHdWVzdERldmljZUluZm8nIHtha2EgJ3N0cnVjdCBHdWVzdERldmljZUlu
Zm8nfSBoYXMgbm8gbWVtYmVyIG5hbWVkICdkZXZpY2VfaWQnCiAgICAgICAgICAgICBkZXZpY2Ut
PmRldmljZV9pZCA9IGdfYXNjaWlfc3RydG91bGwoZGV2aWNlX2lkLCBOVUxMLCAxNik7CiAgICAg
ICAgICAgICAgICAgICBefgogIEJVSUxEICAgcGMtYmlvcy9vcHRpb25yb20vbGludXhib290LnJh
dwogIEJVSUxEICAgcGMtYmlvcy9vcHRpb25yb20vbGludXhib290X2RtYS5yYXcKICBCVUlMRCAg
IHBjLWJpb3Mvb3B0aW9ucm9tL2t2bXZhcGljLnJhdwogIFNJR04gICAgcGMtYmlvcy9vcHRpb25y
b20vbXVsdGlib290LmJpbgptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6
Njk6IHFnYS9jb21tYW5kcy13aW4zMi5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1
bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBxZW11LWltZy5vCiAgU0lHTiAgICBwYy1iaW9z
L29wdGlvbnJvbS9saW51eGJvb3QuYmluCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9y
KHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1sn
c3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFu
Y2UudXVpZD01ZjIxYTlmNzE0M2U0YTU2YTk4OTEzZDhjNTJjZGE5ZCcsICctdScsICcxMDAxJywg
Jy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RB
UkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAn
LWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0ND
QUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3Fl
bXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtNjQwcXA5cWMvc3JjL2RvY2tlci1zcmMuMjAxOS0xMi0wNS0wOS4wMy41
NC4yNzM1OTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVt
dS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpm
aWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD01ZjIxYTlmNzE0M2U0
YTU2YTk4OTEzZDhjNTJjZGE5ZAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFr
ZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC02NDBx
cDlxYy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3Ig
MgoKcmVhbCAgICA1bTQ3LjMyOXMKdXNlciAgICAwbTkuMDMxcwoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMDNmYmQ1NDJkNmJhZTRjZjA3YmU1
NmM1MWQ1N2ZjMjk2MjcyMDQ0NS4xNTc1NTQ2ODU1LmdpdC50Z29sZW1iaUByZWRoYXQuY29tL3Rl
c3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


