Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E8CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8662621D7D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 12:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8662621D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRbjS-0005Ri-Ln
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 07:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iRbif-0004tx-Gm
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iRbie-0006G4-1G
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 07:44:29 -0500
Resent-Date: Mon, 04 Nov 2019 07:44:29 -0500
Resent-Message-Id: <E1iRbie-0006G4-1G@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iRbid-0006C3-Gy; Mon, 04 Nov 2019 07:44:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572871412; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZGGX4IiQmFpfjgydc5Xn3ayaHUnZg5ayc1LgN+2EPAEWadlQ72zdOWTHjWwWf463miX0+AQduBQOwrZZGDWGqGQg9RXjYQU/UgNLOTWKMHHGwVhJAg9XdayW3ORX/ipIds8MeKjQhM9LJCYoJCwmZ0pT2Q7XjsREIdqT1UkQTYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572871412;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6Ln4BdVwFHO2I5x/J3dmCMdBNcZGsmz/4+6/IHcamSs=; 
 b=OXHSlHABKLoE/hqE1f3/eQLMEHQH+AidsnP2yoeYe4Qz5s3+azo1sI0zcMwQEpMxEKYXYqKdTAGrp1j35ct3daqdXcwBags9mh6M4a5BqzIHRxGHBO4zaAlBTofir9euc9yn3DpsM7i+6pE+Qegqzwhyq/2ev0FbQnnXK9GOLWA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572871409656174.88674502333663;
 Mon, 4 Nov 2019 04:43:29 -0800 (PST)
In-Reply-To: <20191104121458.29208-1-zhengxiang9@huawei.com>
Subject: Re: [PATCH v21 0/6] Add ARMv8 RAS virtualization support in QEMU
Message-ID: <157287140443.27285.11755911437215821061@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhengxiang9@huawei.com
Date: Mon, 4 Nov 2019 04:43:29 -0800 (PST)
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, gengdongjiu@huawei.com,
 shannon.zhaosl@gmail.com, zhengxiang9@huawei.com, qemu-arm@nongnu.org,
 james.morse@arm.com, jonathan.cameron@huawei.com, imammedo@redhat.com,
 pbonzini@redhat.com, xuwei5@huawei.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNDEyMTQ1OC4yOTIw
OC0xLXpoZW5neGlhbmc5QGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBURVNUICAgIGNoZWNr
LXVuaXQ6IHRlc3RzL3Rlc3QtdGhyb3R0bGUKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rl
c3QtdGhyZWFkLXBvb2wKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlv
bi10ZXN0LmM6OTAzOndhaXRfZm9yX21pZ3JhdGlvbl9mYWlsOiBhc3NlcnRpb24gZmFpbGVkOiAo
IXN0cmNtcChzdGF0dXMsICJzZXR1cCIpIHx8ICFzdHJjbXAoc3RhdHVzLCAiZmFpbGVkIikgfHwg
KGFsbG93X2FjdGl2ZSAmJiAhc3RyY21wKHN0YXR1cywgImFjdGl2ZSIpKSkKRVJST1IgLSBCYWls
IG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL21pZ3JhdGlvbi10ZXN0LmM6OTAz
OndhaXRfZm9yX21pZ3JhdGlvbl9mYWlsOiBhc3NlcnRpb24gZmFpbGVkOiAoIXN0cmNtcChzdGF0
dXMsICJzZXR1cCIpIHx8ICFzdHJjbXAoc3RhdHVzLCAiZmFpbGVkIikgfHwgKGFsbG93X2FjdGl2
ZSAmJiAhc3RyY21wKHN0YXR1cywgImFjdGl2ZSIpKSkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1h
YXJjaDY0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
CiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWhiaXRtYXAKICBURVNUICAgIGlvdGVz
dC1xY293MjogMDEzCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0yNjA3
YWIzYWExOGY0ZTY1OGUyMWVjMjQ4ZGQ4MGMwYycsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92
YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1j
Y2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLWd6MnQ4eTZtL3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMDQtMDcuMzIuMjAuOTU3NTovdmFy
L3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rl
c3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmls
dGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MjYwN2FiM2FhMThmNGU2NThlMjFlYzI0
OGRkODBjMGMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZp
bmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZ3oydDh5Nm0vc3JjJwpt
YWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAg
IDExbTQuNjkzcwp1c2VyICAgIDBtOC45MTRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTEwNDEyMTQ1OC4yOTIwOC0xLXpoZW5neGlh
bmc5QGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


