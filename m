Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F4C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 19:21:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A504F207D3
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 19:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A504F207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK4uL-00019L-Id
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 15:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK4tZ-0000VK-SI; Sun, 20 Sep 2020 15:21:09 -0400
Resent-Date: Sun, 20 Sep 2020 15:21:09 -0400
Resent-Message-Id: <E1kK4tZ-0000VK-SI@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK4tX-0004D7-GS; Sun, 20 Sep 2020 15:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600629653; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JHSyG1Q17JjCWARZQGTYtqJNxtfXtdW9OFiJ3B7UZ2o2rhSTrk4MLA8IT0vh+9gxxdrRHaFQlUfWOvKeERZoCi2HaTjxAYhEipdBk/yRGm12IMx/yzje+Yr9ViU8pDqWW26J5eUEbp/YkJnk8eW+xX64QZZFi+xb94bcLsl6nKw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600629653;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rnMz9lyYv1IQKm6/ZbDUT6i8GWfmeDTtqWBBUq/02Fw=; 
 b=A5a2ef5/AmbGbcPXmJBCLWh9rXPEcN6VvoYNzzp5KpgAIFCPfdC3t+dfSw7nTLtYj1iny5HM1x+ARk+i//MxDxL9KAIeYQD4WB9t4Fv9qvirDECdq9UI9BaFgw3AS31N/zaG+15wgYkYPmPDwXPN6JUc1XXqUA35F+SKdbkzCOY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600629650358653.2532792225796;
 Sun, 20 Sep 2020 12:20:50 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/arm/raspi: Fix SYS_timer on Linux + misc changes
Message-ID: <160062964873.23907.1805407191412457120@66eaa9a8a123>
In-Reply-To: <20200920175825.417680-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 20 Sep 2020 12:20:50 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 14:03:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Andrew.Baumann@microsoft.com, pauldzim@gmail.com, nieklinnenbank@gmail.com,
 qemu-arm@nongnu.org, luc.michel@greensocs.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMDE3NTgyNS40MTc2
ODAtMS1mNGJ1Z0BhbXNhdC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQyBsaW5rZXIgZm9yIHRoZSBob3N0
IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhvc3QgbWFjaGluZSBjcHUgZmFtaWx5OiB4ODZf
NjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWlsZDoxMDogV0FSTklO
RzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNv
bXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dy
YW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0
aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tCkNvbXBp
bGluZyBDIG9iamVjdCBsaWJxZW11LWFhcmNoNjQtc29mdG1tdS5mYS5wL2h3X2FybV9vbWFwMS5j
Lm8KQ29tcGlsaW5nIEMgb2JqZWN0IGxpYnFlbXUtYWFyY2g2NC1zb2Z0bW11LmZhLnAvaHdfYXJt
X21zZjItc29jLmMubwouLi9zcmMvaHcvYXJtL2JjbTI4MzVfcGVyaXBoZXJhbHMuYzogSW4gZnVu
Y3Rpb24gJ2JjbTI4MzVfcGVyaXBoZXJhbHNfcmVhbGl6ZSc6Ci4uL3NyYy9ody9hcm0vYmNtMjgz
NV9wZXJpcGhlcmFscy5jOjM1NTo0NTogZXJyb3I6ICdUUFhfT0ZGU0VUJyB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICBjcmVhdGVfdW5pbXAocywgJnMtPnRweCwg
ImJjbTI4MzUtdHB4IiwgVFBYX09GRlNFVCwgMHgxMDAwKTsKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXgouLi9zcmMvaHcvYXJtL2JjbTI4MzVfcGVyaXBoZXJh
bHMuYzozNTU6NDU6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVk
IG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCm1ha2U6ICoqKiBbbGli
cWVtdS1hYXJjaDY0LXNvZnRtbXUuZmEucC9od19hcm1fYmNtMjgzNV9wZXJpcGhlcmFscy5jLm9d
IEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tl
ci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NF
cnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5k
ICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLXJtJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD0wNDU3N2Y1NDNlMjA0NjBjYjJmYWFjY2YxN2E3ZTc3MicsICct
dScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctZScs
ICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9
JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNh
Y2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAtMTJfMzU2N3Qvc3JjL2RvY2tlci1zcmMuMjAyMC0wOS0yMC0x
NS4xNy4zMS41MDkxOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2NlbnRvczcnLCAnL3Zhci90
bXAvcWVtdS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1
cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0wNDU3N2Y1
NDNlMjA0NjBjYjJmYWFjY2YxN2E3ZTc3MgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9y
IDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC0xMl8zNTY3dC9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczdd
IEVycm9yIDIKCnJlYWwgICAgM20xNy4xODZzCnVzZXIgICAgMG0xOC4yMDVzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyMDE3NTgy
NS40MTc2ODAtMS1mNGJ1Z0BhbXNhdC5vcmcvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

