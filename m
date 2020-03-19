Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD475C4332E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807ED20724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 19:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807ED20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF11v-0002t1-Kd
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 15:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jF118-0002Pg-Ik
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jF117-0002Vi-Di
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 15:39:46 -0400
Resent-Date: Thu, 19 Mar 2020 15:39:46 -0400
Resent-Message-Id: <E1jF117-0002Vi-Di@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jF114-0002Tg-Ir; Thu, 19 Mar 2020 15:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584646765; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YMRMfFgrPDaQrTuA9jU2PizAA1zX7Z18qsj/KZkukMfYyuOaYFrWJuOkJaz/mBsjTm0+kKFbSUTGQbHpql594DMmc8ts94HPG2cGc2eL8YZ0YDlvKF/wUAELxB4mjbMpyVH6jZewc7KpffeFN4gBBS8VppOYLzdSslDarjowDjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584646765;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PpjOlKC9eBj8js4QMmhUMZcOpnRcJuw+B9cUG4lUceY=; 
 b=J1mq7tmxDB5KHr7E1XRV1a1PmcH/f+hkxlWTDxNqvFhyrAZ7WfbPIUyMWFS9MEG8gb8yANYcB2CUf3WzWgzW75NZiuD0srZn++/52hDce6pVMRdwJGHyQlc0bzkI/BmN/8il3CLYn8wPFSwggjGbQc4eIW4bdhm1ty0spWn8ht0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584646762709698.89267632852;
 Thu, 19 Mar 2020 12:39:22 -0700 (PDT)
In-Reply-To: <20200319161925.1818377-2-dnbrdsky@gmail.com>
Subject: Re: [PATCH] lockable: replaced locks with lock guard macros where
 appropriate
Message-ID: <158464676094.8988.14433696028016433212@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dnbrdsky@gmail.com
Date: Thu, 19 Mar 2020 12:39:22 -0700 (PDT)
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 stefanha@gmail.com, pl@kamp.de, armbru@redhat.com, qemu-devel@nongnu.org,
 dnbrdsky@gmail.com, alex.williamson@redhat.com, kraxel@redhat.com,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, mreitz@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxOTE2MTkyNS4xODE4
Mzc3LTItZG5icmRza3lAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUg
ZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rpbmcg
Y29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3Rh
bGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9pMmMv
dHJhY2UubwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcmN1
LmM6MzQ6MDoKL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcmN1LmM6IEluIGZ1bmN0aW9uICdzeW5j
aHJvbml6ZV9yY3UnOgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xZW11L2xvY2thYmxlLmg6
MTczOjI5OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mICdxZW11X2xvY2thYmxlX2F1dG9fX0NPVU5U
RVJfXycKICAgICBnX2F1dG9wdHIoUWVtdUxvY2thYmxlKSBxZW11X2xvY2thYmxlX2F1dG8jI19f
Q09VTlRFUl9fID0gXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRl
c3Qvc3JjL3V0aWwvcmN1LmM6MTUyOjU6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnUUVN
VV9MT0NLX0dVQVJEJwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL3V0aWwvcmN1LmM6MTQ1OjU6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnUUVNVV9MT0NLX0dVQVJEJwogICAgIFFFTVVfTE9D
S19HVUFSRCgmcmN1X3N5bmNfbG9jayk7CiAgICAgXgptYWtlOiAqKiogW3V0aWwvcmN1Lm9dIEVy
cm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAg
IGh3L2kzODYvdHJhY2UubwpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1hOTMzZmUxM2VlMjY0MmQ0YmM4MGE2
ZmEyZTgxMTA0MycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICct
dicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2Nj
YWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC11ZWEyZnZ2Mi9zcmMv
ZG9ja2VyLXNyYy4yMDIwLTAzLTE5LTE1LjM3LjQwLjE2OTIzOi92YXIvdG1wL3FlbXU6eixybycs
ICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1
cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFl
bXUuaW5zdGFuY2UudXVpZD1hOTMzZmUxM2VlMjY0MmQ0YmM4MGE2ZmEyZTgxMTA0MwptYWtlWzFd
OiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC11ZWEyZnZ2Mi9zcmMnCm1ha2U6ICoqKiBbZG9ja2Vy
LXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMW00MC45NjNzCnVzZXIg
ICAgMG04LjIzM3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3
Lm9yZy9sb2dzLzIwMjAwMzE5MTYxOTI1LjE4MTgzNzctMi1kbmJyZHNreUBnbWFpbC5jb20vdGVz
dGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

