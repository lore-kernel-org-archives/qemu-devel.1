Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3190DC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0671B2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0671B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXqc-0001eG-6F
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iUXk3-0001H9-6J
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iUXk1-000576-Rp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:06:03 -0500
Resent-Date: Tue, 12 Nov 2019 10:06:03 -0500
Resent-Message-Id: <E1iUXk1-000576-Rp@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iUXjy-00053W-LJ; Tue, 12 Nov 2019 10:05:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573571135; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JldGtTQRu+vvajXWHg3B65suzuNIQ8z8Xvy4WcqNrJ+SiTO3TG6TtFuS/hnd+JuBHTEPDqiOVvV7R5bMff+MKveXNxu0iMuj4lKgHFTSrmksNrfROz/hkOHcEoATcfwqxwxNmzwrJy8tULyo7AV9KzhQcrb0Jtgzkno+iUIns1w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573571135;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oq50fjH1WzQEaHdUlGKB3RE6IdjGFA/b+r7nAQBRtP0=; 
 b=RnP7+tN6rryes6LFdd/RrEs5pPGpUga0BLlZiF2HfGUv0tD9X7IYo6BFEXCDs5rD9AbrOaR5YuakEvbUml/P1j3DYt757AlfYOFQg6F8diJDjVZpVYg/MDLB1SToJT6AiwaMusXQZCAr+/+ODdo6DY5f2vEq2v52wsB6bFsHrp4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573571133760336.62942015539284;
 Tue, 12 Nov 2019 07:05:33 -0800 (PST)
In-Reply-To: <20191112064058.13275-1-joel@jms.id.au>
Subject: Re: [PATCH 0/4] arm/aspeed: Watchdog and SDRAM fixes
Message-ID: <157357113245.21948.12787121570863380329@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: joel@jms.id.au
Date: Tue, 12 Nov 2019 07:05:33 -0800 (PST)
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExMjA2NDA1OC4xMzI3
NS0xLWpvZWxAam1zLmlkLmF1LwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdl
LWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRvcmEg
Sj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBxZ2EvZ3Vl
c3QtYWdlbnQtY29tbWFuZC1zdGF0ZS5vCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUt
dGVzdC9zcmMvaHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5jOjEzOgovdG1wL3FlbXUtdGVzdC9zcmMv
aHcvd2F0Y2hkb2cvd2R0X2FzcGVlZC5jOiBJbiBmdW5jdGlvbiAnYXNwZWVkX3dkdF90aW1lcl9l
eHBpcmVkJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3dhdGNoZG9nL3dkdF9hc3BlZWQuYzoyMzI6
MzQ6IGVycm9yOiBmb3JtYXQgJyVseCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25nIHVu
c2lnbmVkIGludCcsIGJ1dCBhcmd1bWVudCAyIGhhcyB0eXBlICdod2FkZHInIHtha2EgJ2xvbmcg
bG9uZyB1bnNpZ25lZCBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9XQogICAgIHFlbXVfbG9nX21hc2so
Q1BVX0xPR19SRVNFVCwgIldhdGNoZG9nIHRpbWVyICUwOGx4IGV4cGlyZWQuXG4iLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+CiAgICAgICAgICAgICBzLT5pb21lbS5hZGRyKTsKLS0tCiAgICAgICAgICAgICAgICAgICAg
ICBefn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKICBCVUlMRCAg
IHBjLWJpb3Mvb3B0aW9ucm9tL211bHRpYm9vdC5pbWcKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVz
dC9zcmMvcnVsZXMubWFrOjY5OiBody93YXRjaGRvZy93ZHRfYXNwZWVkLm9dIEVycm9yIDEKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIHFnYS9tYWlu
Lm8KICBCVUlMRCAgIHBjLWJpb3Mvb3B0aW9ucm9tL2xpbnV4Ym9vdC5pbWcKLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWY1MmQ0MzJiMmRkNjRiMDQ4YTZmNDE2NDY2YzAw
MzNkJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hv
bWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtazZfZzNicXYvc3JjL2RvY2tlci1z
cmMuMjAxOS0xMS0xMi0xMC4wMi40OS4xMzAxNjovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpm
ZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFu
Y2UudXVpZD1mNTJkNDMyYjJkZDY0YjA0OGE2ZjQxNjQ2NmMwMDMzZAptYWtlWzFdOiAqKiogW2Rv
Y2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1rNl9nM2Jxdi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0
LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTQyLjkxNHMKdXNlciAgICAwbTcuODYy
cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAxOTExMTIwNjQwNTguMTMyNzUtMS1qb2VsQGptcy5pZC5hdS90ZXN0aW5nLmRvY2tlci1taW5n
d0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

