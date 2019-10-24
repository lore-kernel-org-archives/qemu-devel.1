Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F5ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B30720659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B30720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhBq-0005iG-5C
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNh9l-0002cb-Gh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNh9j-0002EM-UN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:44:17 -0400
Resent-Date: Thu, 24 Oct 2019 13:44:17 -0400
Resent-Message-Id: <E1iNh9j-0002EM-UN@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNh9j-0002EC-Ms; Thu, 24 Oct 2019 13:44:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571939032; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q1uMC9cdjAg5k6jPzI8re46jIBo+MJ+BvtuuLGutUprjTUg78ENdK6jfV6fYnZRDsvxBU8o0SEtQqpzGnGuh9zRK+wizPUt6D4EA1IqyfpL9L+6CXo6YDBH9TPNCIwwJIjDsRPrmAuh/WaWD68iBGdeHShjqy1wpYopUHu0mlCk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571939032;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4Rk43Y9w57kJAvGVSvrB0RJmDJrtaweEh771DHro3Bc=; 
 b=hzjtnrnOaqgDL/SGJU+pqxKXrtfN299Fer7a+z+MsrlLT4jSfaIpGcMp9Ms+cGpb20CAQxwV5iJARwCHUps2EekIGXB/xETc+59g7PX4eUu4oCxuiM+svLT99gkRNvaCovPzTEJB4+YLPhOFhrRC7hS0rV+5HXTF5SuYaY+JYP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571939030276913.0451988225368;
 Thu, 24 Oct 2019 10:43:50 -0700 (PDT)
In-Reply-To: <20191023192640.13125-1-keithp@keithp.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v3)
Message-ID: <157193902885.8606.12537127027528133435@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: keithp@keithp.com
Date: Thu, 24 Oct 2019 10:43:50 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, keithp@keithp.com, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, laurent@vivier.eu, qemu-arm@nongnu.org,
 pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMzE5MjY0MC4xMzEy
NS0xLWtlaXRocEBrZWl0aHAuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
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
J3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MjA3NTUzMmVhMGExNGNk
MjliZWNiOGUxMTA0Njk3OWYnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNj
b21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhU
UkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVC
VUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNo
ZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIv
dG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC02MmNnYzl4
eS9zcmMvZG9ja2VyLXNyYy4yMDE5LTEwLTI0LTEzLjQwLjM1LjIzMzg5Oi92YXIvdG1wL3FlbXU6
eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10n
IHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1j
b20ucWVtdS5pbnN0YW5jZS51dWlkPTIwNzU1MzJlYTBhMTRjZDI5YmVjYjhlMTEwNDY5NzlmCm1h
a2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9y
eSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTYyY2djOXh5L3NyYycKbWFrZTogKioqIFtk
b2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDNtMTQuNDE5cwp1
c2VyICAgIDBtNy4wNTZzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDE5MTAyMzE5MjY0MC4xMzEyNS0xLWtlaXRocEBrZWl0aHAuY29tL3Rl
c3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


