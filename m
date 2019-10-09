Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EE1C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 22:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB0E620B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 22:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB0E620B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIKt9-00042N-Ru
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 18:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIKsI-0003QO-C8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIKsG-00082Q-3x
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 18:56:05 -0400
Resent-Date: Wed, 09 Oct 2019 18:56:05 -0400
Resent-Message-Id: <E1iIKsG-00082Q-3x@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIKsE-00080P-WE; Wed, 09 Oct 2019 18:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570661749; cv=none; d=zoho.com; s=zohoarc; 
 b=IbLBR7pOqJ5glt/YczriJHDZEG6r7mMKcbwS8iGMyDk4HV/naE3mZ7h4Zk70ZzcvUFD1WB44moyZHvxbwvfJb6uIZXdGQboMuEWlXKh344r7sCmDuvhaqqxgprMsKpe3PRdSiHmdRZg5LzKI3ItYRjm6AXfOXNyccDZPYpMuHGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570661749;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zm6qNVZ2o2J4kNDR7yAtuttemhMADY3W/BPGZvUyQnc=; 
 b=jHB7GNY7xGINli9YSCKDqbUAOYmQf9e3itM0tlld9xUWjEaKkH0tVvcnZbTYrKznuKoc3VlV5fRYduwvZQ/V6g46ylKQR2dsccg1//m4KkMt8TTP/BsmxhVMO5KDo5To4Glh0QaZTYnPucqSegCOr7LQZnAlzu/s1WJxx1F5pZY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570661746983111.23669555286313;
 Wed, 9 Oct 2019 15:55:46 -0700 (PDT)
In-Reply-To: <20191009164459.8209-1-msmarduch@digitalocean.com>
Subject: Re: [PATCHv2 0/2] log guest name and memory error type AO,
 AR for MCEs 
Message-ID: <157066174528.7138.14434697809199041276@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: msmarduch@digitalocean.com
Date: Wed, 9 Oct 2019 15:55:46 -0700 (PDT)
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
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, mtosatti@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, msmarduch@digitalocean.com,
 pbonzini@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwOTE2NDQ1OS44MjA5
LTEtbXNtYXJkdWNoQGRpZ2l0YWxvY2Vhbi5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBk
b2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAg
ICAgIHV0aWwvaGJpdG1hcC5vCiAgQ0MgICAgICB1dGlsL2ZpZm84Lm8KCkVuY29kaW5nIGVycm9y
OgondXRmLTgnIGNvZGVjIGNhbid0IGRlY29kZSBieXRlIDB4OTUgaW4gcG9zaXRpb24gNzk5OiBp
bnZhbGlkIHN0YXJ0IGJ5dGUKVGhlIGZ1bGwgdHJhY2ViYWNrIGhhcyBiZWVuIHNhdmVkIGluIC90
bXAvc3BoaW54LWVyci1xc2ZjZDkyeS5sb2csIGlmIHlvdSB3YW50IHRvIHJlcG9ydCB0aGUgaXNz
dWUgdG8gdGhlIGRldmVsb3BlcnMuCiAgQ0MgICAgICB1dGlsL2NhY2hlaW5mby5vCi0tLQogIEND
ICAgICAgdXRpbC9pZC5vCiAgQ0MgICAgICB1dGlsL2lvdi5vCiAgQ0MgICAgICB1dGlsL3FlbXUt
Y29uZmlnLm8KbWFrZTogKioqIFtNYWtlZmlsZTo5OTQ6IGRvY3MvaW50ZXJvcC9pbmRleC5odG1s
XSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNl
YmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2Nr
ZXIucHkiLCBsaW5lIDY2MiwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNz
RXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFu
ZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5p
bnN0YW5jZS51dWlkPWM4Mjc0YThhOTIyZDRkMmM4MWIxNGI2YjVjMDkwMmNhJywgJy11JywgJzEw
MDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUn
LCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdW
PScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNh
Y2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtdmRrN2Zlejkvc3JjL2RvY2tlci1zcmMuMjAxOS0xMC0wOS0x
OC41My4wOS4xNzU0MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1jODI3NGE4
YTkyMmQ0ZDJjODFiMTRiNmI1YzA5MDJjYQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC12ZGs3ZmV6OS9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0g
RXJyb3IgMgoKcmVhbCAgICAybTM2LjY0M3MKdXNlciAgICAwbTcuMjU5cwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMDkxNjQ0NTku
ODIwOS0xLW1zbWFyZHVjaEBkaWdpdGFsb2NlYW4uY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZl
ZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


