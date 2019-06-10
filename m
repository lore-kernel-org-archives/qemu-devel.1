Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBBC5ACC3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C246B207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C246B207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47046 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haLCk-0001pz-Ek
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57996)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1haL3r-0005uP-Fa
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1haL3m-0004LG-7O
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:14:08 -0400
Resent-Date: Mon, 10 Jun 2019 10:14:07 -0400
Resent-Message-Id: <E1haL3m-0004LG-7O@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1haL3J-0003wu-6I; Mon, 10 Jun 2019 10:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560175948; cv=none; d=zoho.com; s=zohoarc; 
 b=oTUdb6aNblaIAmEFO2r2RFmgBW92jm7q8tD59bKzwjqy51F03X5XsAeZ++t5enWkCK0pzk7beHgWRkaRrX/ECQjIVGRzGqgQW5yeba6k8cv19gsYhqESLoz7E0NPlYeICpMQ3EQLF9EUZzP8m73O+fCs5qto1yv/M+fxdU01r4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560175948;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=a+kqpzXuZcjxPTP2c/ZR5DQPt3ngdHDMg6kl21VqaRs=; 
 b=ZhJSEcWLqoSlT7g5jPiGzVHxLt3/ssGcnmQEpS3jVuIerq0kmqAU1oTlYgM+gBIST7w+PKdrLcpb5azESD1VzPLxxssRniPyVg4klJspYV65Knx63gHJgVbAYGGMAMgaPFrzBm1aPLLnR54l0d8cxp5lpBHxrBZ1FP3/YfJNAGk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560175945452536.9042011722687;
 Mon, 10 Jun 2019 07:12:25 -0700 (PDT)
In-Reply-To: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
Message-ID: <156017594400.32260.17113600352824722663@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lizhengui@huawei.com
Date: Mon, 10 Jun 2019 07:12:25 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] file-posix: unlock qemu_global_mutex
 before pread when attach disk
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
Cc: kwolf@redhat.com, lizhengui@huawei.com, qemu-block@nongnu.org,
 eric.fangyi@huawei.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 jiangyiwen@huawei.com, stefanha@redhat.com, wangjie88@huawei.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYwMTczNjg0LTYyNjQtMS1n
aXQtc2VuZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gZmls
ZS1wb3NpeDogdW5sb2NrIHFlbXVfZ2xvYmFsX211dGV4IGJlZm9yZSBwcmVhZCB3aGVuIGF0dGFj
aCBkaXNrClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNTYwMTczNjg0LTYyNjQtMS1naXQtc2Vu
ZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAq
IFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMTU2MDE3MzY4NC02MjY0LTEtZ2l0LXNl
bmQtZW1haWwtbGl6aGVuZ3VpQGh1YXdlaS5jb20gLT4gcGF0Y2hldy8xNTYwMTczNjg0LTYyNjQt
MS1naXQtc2VuZC1lbWFpbC1saXpoZW5ndWlAaHVhd2VpLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBi
cmFuY2ggJ3Rlc3QnCmE1NTQ5MDU1YTMgZmlsZS1wb3NpeDogdW5sb2NrIHFlbXVfZ2xvYmFsX211
dGV4IGJlZm9yZSBwcmVhZCB3aGVuIGF0dGFjaCBkaXNrCgo9PT0gT1VUUFVUIEJFR0lOID09PQpF
UlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAg
d2FybmluZ3MsIDkgbGluZXMgY2hlY2tlZAoKQ29tbWl0IGE1NTQ5MDU1YTMwZCAoZmlsZS1wb3Np
eDogdW5sb2NrIHFlbXVfZ2xvYmFsX211dGV4IGJlZm9yZSBwcmVhZCB3aGVuIGF0dGFjaCBkaXNr
KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTYwMTczNjg0LTYyNjQtMS1naXQtc2VuZC1lbWFpbC1s
aXpoZW5ndWlAaHVhd2VpLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


