Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C195C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D562F2071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D562F2071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgQt-00035z-U4
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRgQH-0002SZ-3V
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRgQG-0000K7-Ca
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:18:04 -0400
Resent-Date: Thu, 23 Apr 2020 14:18:04 -0400
Resent-Message-Id: <E1jRgQG-0000K7-Ca@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRgQF-0000Ha-SX
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:18:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587665879; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lfql5SGh/uyN1kNqLoUL1m00MLWjPdyqLV3Q+6bvXwSRHpFkiwApuHZvTlm63PH8qdWAdrcV046JyhRHSl5XU/n9cPrXfcvxC8VfESy/SjUIV8WK8grlFCnWR5qpf/CN5V4ZQi9QBiGMPz3UA7KKZqdLQHsXhUN4iUJpPXGlytI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587665879;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oIVH+EcqA3NHSuU5q/znZblSLPkM2Af01KJSiHQyQhA=; 
 b=AygppIsurjbHIPwY0M5jIqK78rykiFiDG0n2kf0/hBEziX3T1Pdw1ycfcCQPXgYz6nmrgUerAB7118CmLqidXL3N3w/Bx3EScpQJHRiJJs3/nLSP9I4eGba1yxGH+3t67OCmWIsLNxdltDGbF8L7TsxthixKDF5NUekvOLhjcx0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158766587782240.43015617939386;
 Thu, 23 Apr 2020 11:17:57 -0700 (PDT)
In-Reply-To: <20200423170557.31106-1-alex.bennee@linaro.org>
Subject: Re: [PATCH for 5.1 v1 00/14] guest_base, gdbstub and Travis
Message-ID: <158766587683.10590.2989731040751262090@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Thu, 23 Apr 2020 11:17:57 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 14:15:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzE3MDU1Ny4zMTEw
Ni0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQ2xlYXJlZCBkaXJlY3Rv
cnkgJ3NsaXJwJwpTdWJtb2R1bGUgJ3NsaXJwJyAoaHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L2xp
YnNsaXJwLmdpdCkgdW5yZWdpc3RlcmVkIGZvciBwYXRoICdzbGlycCcKU3VibW9kdWxlICd1aS9r
ZXljb2RlbWFwZGInIChodHRwczovL2dpdC5xZW11Lm9yZy9naXQva2V5Y29kZW1hcGRiLmdpdCkg
dW5yZWdpc3RlcmVkIGZvciBwYXRoICd1aS9rZXljb2RlbWFwZGInCm1ha2VbMV06ICoqKiBbL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJoaWc5OXNfL3NyYy9kb2NrZXItc3JjLjIwMjAtMDQt
MjMtMTQuMTUuNTYuMTI3NzZdIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1yaGlnOTlzXy9zcmMnCm1ha2U6ICoqKiBbZG9ja2Vy
LXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMm0wLjkyN3MKdXNlciAg
ICAwbTUuMjc1cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDA0MjMxNzA1NTcuMzExMDYtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rl
c3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

