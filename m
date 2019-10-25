Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D93CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 18:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154C62084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 18:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154C62084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO4Dr-0007nF-96
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 14:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iO4Ck-0006AA-0Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 14:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iO4Cg-0001dw-8i
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 14:20:52 -0400
Resent-Date: Fri, 25 Oct 2019 14:20:51 -0400
Resent-Message-Id: <E1iO4Cg-0001dw-8i@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iO4Ce-0001bZ-E5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 14:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572027646; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hjH3b6vlHeaCjMMbK/ZSminbj8LFxXyxcsiX8Vspv66TG152814IZDr2DwoLntN4ZQqskQ5a8FG8/tu2tIo/oB54OJmYkA5JMlJPwgSbbwA0uVuNXeFfZVitIaZMAyJmcjneQLJG1tCQCgniYkVPhFC96113JXlcryib4ce61pk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572027646;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=n6Ux1MGUOM50Zh4Kw8wQh8yQWuTEnMdYcLd/pXlWASU=; 
 b=IOjpW3Aks/ovXWulZvzNEAU/ngqllRTwAxAV/UrWFOqQmW5RFgAUZmMrt8lSnjnhlcbjq4EHd4tnkpBA+R7RSb8n+5DfmZ3zwB2KRc05d0P+TwAwcCbM6bp6MS5bG+fVkPsDgmzBHItz8W1zGRTIJWgSAjCdVYTLgRuvU4u1an0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 15720276443541008.2926218362556;
 Fri, 25 Oct 2019 11:20:44 -0700 (PDT)
In-Reply-To: <20191024224622.12371-1-keithp@keithp.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
Message-ID: <157202764352.8606.14080749114741094121@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: keithp@keithp.com
Date: Fri, 25 Oct 2019 11:20:44 -0700 (PDT)
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyNDIyNDYyMi4xMjM3
MS0xLWtlaXRocEBrZWl0aHAuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWlt
YWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJj
aDY0LXNvZnRtbXUvdGFyZ2V0L2FybS90cmFuc2xhdGUtc3ZlLm8KLi4vdmwubzogSW4gZnVuY3Rp
b24gYHFlbXVfbWFpbic6Ci90bXAvcWVtdS10ZXN0L3NyYy92bC5jOjQzODU6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYHFlbXVfc2VtaWhvc3RpbmdfY29uc29sZV9pbml0Jwpjb2xsZWN0MjogZXJy
b3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDY6
IHFlbXUtc3lzdGVtLXg4Nl82NHcuZXhlXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDgy
OiB4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KICBMSU5LICAgIGFhcmNoNjQtc29mdG1tdS9xZW11LXN5c3RlbS1hYXJj
aDY0dy5leGUKICBHRU4gICAgIGFhcmNoNjQtc29mdG1tdS9xZW11LXN5c3RlbS1hYXJjaDY0LmV4
ZQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nl
c3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywg
J3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzgwMjNhZjdkMTdmNDlj
Mzg5YTlkYmI3YzIyOTJhNmUnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNj
b21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhU
UkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVC
VUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNo
ZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90
bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXd1cno0aGh0
L3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMjUtMTQuMTcuNTEuMjA3NDovdmFyL3RtcC9xZW11Onos
cm8nLCAncWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyBy
ZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29t
LnFlbXUuaW5zdGFuY2UudXVpZD1jODAyM2FmN2QxN2Y0OWMzODlhOWRiYjdjMjI5MmE2ZQptYWtl
WzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rvcnkg
YC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13dXJ6NGhodC9zcmMnCm1ha2U6ICoqKiBbZG9j
a2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTUyLjU5OXMKdXNl
ciAgICAwbTguNDcycwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAxOTEwMjQyMjQ2MjIuMTIzNzEtMS1rZWl0aHBAa2VpdGhwLmNvbS90ZXN0
aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


