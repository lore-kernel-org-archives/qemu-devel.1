Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D491C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 19:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CF220796
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 19:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CF220796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK4qh-0007yu-GL
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 15:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK4pn-0007OE-Fq; Sun, 20 Sep 2020 15:17:15 -0400
Resent-Date: Sun, 20 Sep 2020 15:17:15 -0400
Resent-Message-Id: <E1kK4pn-0007OE-Fq@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kK4pk-0003mX-QD; Sun, 20 Sep 2020 15:17:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600629412; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Lx295WHKzoTtsGIcg+W+QrPKBtvlijhj1up3MHvyoN3FNJP+9XJA9bXEUssXvbfEl6Zl/FGRo+PGKVPjg6mC5ajxKRqi8agSNGCsLahPwxH0Z7M7qIWJv1CnyyRxo4m7rpAK9riSP1iEbonCBUjs25iTuO7pkXZdb6OQoL5q9RE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600629412;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=g2A2QuUK2VJ3E0eXTgr/zGuBwGWBUh70uwIajSIH2qg=; 
 b=dPODUMOhjy0FckaMKOS70uL/ZOAldRoHB89/4tzXDBum7E3lW8xAq/+qWTaoWOUeoVOo3kWgag6FUfYTA4j+MM+RhMmGEqlB7euUoYQ4TZf7kD4oPR8HzZ64gKAoti7JP434P5L0CWh1F5cOKkTeC1w3DH/zBoQ/sG7WrnAGgZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600629410180257.59664564760396;
 Sun, 20 Sep 2020 12:16:50 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/arm/raspi: Fix SYS_timer on Linux + misc changes
Message-ID: <160062940832.23907.8004777003360682726@66eaa9a8a123>
In-Reply-To: <20200920175825.417680-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 20 Sep 2020 12:16:50 -0700 (PDT)
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
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKSG9zdCBtYWNoaW5lIGNw
dTogeDg2XzY0ClRhcmdldCBtYWNoaW5lIGNwdSBmYW1pbHk6IHg4NgpUYXJnZXQgbWFjaGluZSBj
cHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6MTA6IFdBUk5JTkc6IE1vZHVsZSB1bnN0YWJs
ZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJkcyBjb21wYXRpYmlsaXR5IGFuZCBt
aWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQcm9ncmFtIHNoIGZvdW5kOiBZRVMK
UHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmluL3B5dGhvbjMpCkNvbmZpZ3VyaW5n
IG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9uCi0tLQpDb21waWxpbmcgQyBvYmplY3QgbGli
cWVtdS1hYXJjaDY0LXNvZnRtbXUuZmEucC9od192aXJ0aW9fdmlydGlvLmMub2JqCkNvbXBpbGlu
ZyBDIG9iamVjdCBsaWJxZW11LWFhcmNoNjQtc29mdG1tdS5mYS5wL2h3X3ZpcnRpb192aXJ0aW8t
bmV0LXBjaS5jLm9iagouLi9zcmMvaHcvYXJtL2JjbTI4MzVfcGVyaXBoZXJhbHMuYzogSW4gZnVu
Y3Rpb24gJ2JjbTI4MzVfcGVyaXBoZXJhbHNfcmVhbGl6ZSc6Ci4uL3NyYy9ody9hcm0vYmNtMjgz
NV9wZXJpcGhlcmFscy5jOjM1NTo0NTogZXJyb3I6ICdUUFhfT0ZGU0VUJyB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiAnVFhQX09GRlNFVCc/CiAg
MzU1IHwgICAgIGNyZWF0ZV91bmltcChzLCAmcy0+dHB4LCAiYmNtMjgzNS10cHgiLCBUUFhfT0ZG
U0VULCAweDEwMDApOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVFhQX09GRlNFVAouLi9zcmMvaHcvYXJtL2JjbTI4MzVfcGVyaXBoZXJh
bHMuYzozNTU6NDU6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVk
IG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCm1ha2U6ICoqKiBbTWFr
ZWZpbGUubmluamE6MTcyODogbGlicWVtdS1hYXJjaDY0LXNvZnRtbXUuZmEucC9od19hcm1fYmNt
MjgzNV9wZXJpcGhlcmFscy5jLm9ial0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5m
aW5pc2hlZCBqb2JzLi4uLgpDb21waWxpbmcgQyBvYmplY3QgbGlicWVtdS1hYXJjaDY0LXNvZnRt
bXUuZmEucC9od192aXJ0aW9fdmlydGlvLXJuZy5jLm9iagpUcmFjZWJhY2sgKG1vc3QgcmVjZW50
IGNhbGwgbGFzdCk6Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tcm0nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPWVlOTJlOTFiYjI4ZTQ4ODE5NjlmMzU1MTVjOTExOWRjJywgJy11JywgJzEwMDEnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zh
ci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNj
YWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtZmdsZmJrX2ovc3JjL2RvY2tlci1zcmMuMjAyMC0wOS0yMC0xNS4xMi41MC4zMTEyMzovdmFy
L3RtcC9xZW11Onoscm8nLCAncWVtdS9mZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVz
dC1taW5ndyddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0
ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1lZTkyZTkxYmIyOGU0ODgxOTY5ZjM1NTE1
YzkxMTlkYwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmlu
ZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1mZ2xmYmtfai9zcmMnCm1h
a2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAz
bTU3LjM1MXMKdXNlciAgICAwbTIwLjIzOHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTIwMTc1ODI1LjQxNzY4MC0xLWY0YnVnQGFt
c2F0Lm9yZy90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

