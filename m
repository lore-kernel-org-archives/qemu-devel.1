Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C1C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 727EB21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 06:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727EB21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLhTD-0006mw-IM
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 02:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLhSQ-0006Kl-22
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:43:50 -0400
Resent-Date: Fri, 25 Sep 2020 02:43:50 -0400
Resent-Message-Id: <E1kLhSQ-0006Kl-22@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLhSN-0006pH-7C
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 02:43:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601016221; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gDv28Mjy/BFGhw+7Zjf5v5SfI21ob0onySekpOhAJ2qmSzsetX+OB8dvr77P65MXRVMtL6ouYlbMnOHJVb6uKTUavXyyzMf8EX3s9LM0HyYO7pywe2NQZ+Zt/gxsafeCO/XhE+nJKR1YRLXM3J+YWIT3DaKas8RHX4ph2cKpdMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601016221;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SOzhTuqIbUn5uG3sFf3892bOGb+M346xOJRfPvJTcPM=; 
 b=dGyqnj6PBup2BmgEJyDcq1bFDnK9ZMk99SOGmwYMawNv3U7OaJoFBjZsIy84MRU6rpLkOm5rt+DTGiqWyY85FaBP2ZW6n5YoHmkbEd0LJ3daZS/kYRKMDEisjDRtjjIih+pANEkm8iA4tDOt9EScW4FCZqqyAxAZs/pw6uzwO8E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 160101621881147.03227944468574;
 Thu, 24 Sep 2020 23:43:38 -0700 (PDT)
Subject: Re: [PATCH] build: Build and install the info manual.
Message-ID: <160101621766.12744.13622913661456671172@66eaa9a8a123>
In-Reply-To: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: maxim.cournoyer@gmail.com
Date: Thu, 24 Sep 2020 23:43:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:31:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, maxim.cournoyer@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNTAyNDE0My4yNjQ5
Mi0xLW1heGltLmNvdXJub3llckBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBk
b2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKSG9zdCBt
YWNoaW5lIGNwdTogeDg2XzY0ClRhcmdldCBtYWNoaW5lIGNwdSBmYW1pbHk6IHg4NgpUYXJnZXQg
bWFjaGluZSBjcHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6MTA6IFdBUk5JTkc6IE1vZHVs
ZSB1bnN0YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJkcyBjb21wYXRpYmls
aXR5IGFuZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQcm9ncmFtIHNoIGZv
dW5kOiBZRVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmluL3B5dGhvbjMpCkNv
bmZpZ3VyaW5nIG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9uCi0tLQptYWtlWzFdOiBOb3Ro
aW5nIHRvIGJlIGRvbmUgZm9yICdhbGwnLgptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL3Rt
cC9xZW11LXRlc3Qvc3JjL3NsaXJwJwpHZW5lcmF0aW5nIG5zaXMgd2l0aCBhIGN1c3RvbSBjb21t
YW5kCm1ha2VbMV06IHdhcm5pbmc6IGpvYnNlcnZlciB1bmF2YWlsYWJsZTogdXNpbmcgLWoxLiAg
QWRkICcrJyB0byBwYXJlbnQgbWFrZSBydWxlLgptYWtlWzFdOiBFbnRlcmluZyBkaXJlY3Rvcnkg
Jy90bXAvcWVtdS10ZXN0L2J1aWxkJwptYWtlWzJdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy90bXAv
cWVtdS10ZXN0L3NyYy9zbGlycCcKbWFrZVsyXTogTm90aGluZyB0byBiZSBkb25lIGZvciAnYWxs
Jy4KLS0tCkhvc3QgbWFjaGluZSBjcHU6IGkzODYKVGFyZ2V0IG1hY2hpbmUgY3B1IGZhbWlseTog
eDg2ClRhcmdldCBtYWNoaW5lIGNwdTogaTM4NgouLi9zcmMvbWVzb24uYnVpbGQ6MTA6IFdBUk5J
Tkc6IE1vZHVsZSB1bnN0YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJkcyBj
b21wYXRpYmlsaXR5IGFuZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQcm9n
cmFtIHNoIGZvdW5kOiBZRVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmluL3B5
dGhvbjMpCkNvbmZpZ3VyaW5nIG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9uCi0tLQogICAg
cmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQ
cm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0t
cm0nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWEwYjJkYTRiNzY0ZDQ5MGM5
YTkzYTg4MGViMjI5ZjUxJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29t
cD11bmNvbmZpbmVkJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdV
UkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUn
LCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12Jywg
Jy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6
eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZ2dfN2xtbzcvc3JjL2RvY2tl
ci1zcmMuMjAyMC0wOS0yNS0wMi4zMi4zMC4yNDM1MTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVt
dS9mZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBu
b24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5z
dGFuY2UudXVpZD1hMGIyZGE0Yjc2NGQ0OTBjOWE5M2E4ODBlYjIyOWY1MQptYWtlWzFdOiAqKiog
W2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC1nZ183bG1vNy9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10
ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAxMW01LjgyNHMKdXNlciAgICAwbTE5
LjcxNnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMjAwOTI1MDI0MTQzLjI2NDkyLTEtbWF4aW0uY291cm5veWVyQGdtYWlsLmNvbS90ZXN0
aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

