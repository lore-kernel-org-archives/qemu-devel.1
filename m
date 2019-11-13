Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3449EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 07:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0445C21D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 07:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0445C21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUmmK-0004Pa-3B
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 02:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iUmlW-0003zU-VI
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 02:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iUmlV-0007gy-BV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 02:08:34 -0500
Resent-Date: Wed, 13 Nov 2019 02:08:34 -0500
Resent-Message-Id: <E1iUmlV-0007gy-BV@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iUmlV-0007gU-3k
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 02:08:33 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573628869; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RwqXNJRpIB/oXkYtjPfhptfzZVl4lwENbeee3f4Xo3zEuEp0NBCeooX5CuUjWhZ+2r6/6Wxy64HKD5FWZrRMcXl9lERKfUl9BSiyp8YY0eEeT5P0tLn/wrAvolpCcCgrBo1pTjoKkmozFJumduNNxlxdYCbmBsccyOkdnQqwIW8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573628869;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=uI1Zjn4waVf8HzK8of9aMMOMIpecJfn+EzY9h6rFijw=; 
 b=bDbp3WW5lS3FoOuhOPJ6N7UBUIVgmucZXHPXu/m3mwBM30ezxAH7OJ1hMRSr81XpiahQedTJZIizD32mzNpkNThNyEGX0vAtlAf1ncH9tct9vSrpVwWb/v285d9tdVLsaZkFGERHLOyiArevn7uv/vxY3U7VeuE6fQiusZSibzo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573628868679477.03515597001444;
 Tue, 12 Nov 2019 23:07:48 -0800 (PST)
In-Reply-To: <20191112164051.16404-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/2] TCG plugin doc updates
Message-ID: <157362886690.25875.4648107888456712623@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Tue, 12 Nov 2019 23:07:48 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.58
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, alex.bennee@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExMjE2NDA1MS4xNjQw
NC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IHV0aWwvdGhyZWFkLXBvb2wubwogIENDICAgICAgdXRpbC9xZW11LXRpbWVyLm8KCldhcm5pbmcs
IHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0L3NyYy9kb2NzL2RldmVsL2luZGV4LnJz
dDoxMzp0b2N0cmVlIGNvbnRhaW5zIHJlZmVyZW5jZSB0byBub25leGlzdGluZyBkb2N1bWVudCAn
cGx1Z2lucycKICBDQyAgICAgIHV0aWwvbWFpbi1sb29wLm8KICBDQyAgICAgIHV0aWwvYWlvLXdp
bjMyLm8KLS0tCiAgQ0MgICAgICB1dGlsL2Vycm9yLm8KICBDQyAgICAgIHV0aWwvcWVtdS1lcnJv
ci5vCiAgQ0MgICAgICB1dGlsL3FlbXUtcHJpbnQubwptYWtlOiAqKiogW01ha2VmaWxlOjEwMTg6
IGRvY3MvZGV2ZWwvaW5kZXguaHRtbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmls
ZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+Ci0tLQog
ICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxs
ZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywg
Jy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD01NjMxOGUwYmQ0OTA0YmE2ODY2Yzlm
YmY5MGE1ZjNiMycsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5j
b25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05G
SUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAn
LWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2Fj
aGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZ2Q4YXphdWIvc3JjL2Rv
Y2tlci1zcmMuMjAxOS0xMS0xMy0wMi4wNS41Ni4yMjMwMjovdmFyL3RtcC9xZW11Onoscm8nLCAn
cWVtdTpmZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5l
ZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUu
aW5zdGFuY2UudXVpZD01NjMxOGUwYmQ0OTA0YmE2ODY2YzlmYmY5MGE1ZjNiMwptYWtlWzFdOiAq
KiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1nZDhhemF1Yi9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1
bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAxbTUyLjE4N3MKdXNlciAgICAw
bTguMzU4cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAxOTExMTIxNjQwNTEuMTY0MDQtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3Rp
bmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

