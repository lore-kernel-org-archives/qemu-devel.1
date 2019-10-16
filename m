Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC7FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7448B207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7448B207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlLN-0006oH-Ld
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKlKk-0006Oa-Rn
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKlKi-0001N0-Ck
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:35:29 -0400
Resent-Date: Wed, 16 Oct 2019 11:35:29 -0400
Resent-Message-Id: <E1iKlKi-0001N0-Ck@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKlKi-0001M7-5Q
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:35:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571240104; cv=none; d=zoho.com; s=zohoarc; 
 b=IRGpmkBymMI/RrcPSPPR030rbbp13e+oIr4JxZR7NIzV2FiQbtiJi8c/iWhMvQwmVCASd6aZaDUoYEFDOvvUinmWyLo+1BkFQSxN16UMHYRZaPpgNlUeCu2QIsl7t21JCrdHveRd2jcjdjrgraDUb8NDrd82zyztFpsP6ydGKwc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571240104;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WJF3Up8t41izx+1IoteYApuuGkk925J9N9VJ2b/v91U=; 
 b=ar6CW3hA4gyTjtYkUph1rq68/Vh+bO4hkygfTGoxYUkO5TIX68ABhkSK2gY1CcQXQ7aw97Qqx+sXBeF2EIiJ37smrRf6VmaxHJwNjvspVsrQe7k9yPLCU9lZ6W1969lRkReb3K8hAL8aS7Ax1uhpJPPrgW0KZLPdtrpA6fg+N8w=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571240103775357.9645061792405;
 Wed, 16 Oct 2019 08:35:03 -0700 (PDT)
In-Reply-To: <20191016112209.9024-1-chen.zhang@intel.com>
Subject: Re: [RFC PATCH 0/4] Introduce Advanced Watch Dog module
Message-ID: <157124010247.15388.11052477009886074916@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: chen.zhang@intel.com
Date: Wed, 16 Oct 2019 08:35:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: pbonzini@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 qemu-devel@nongnu.org, chen.zhang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNjExMjIwOS45MDI0
LTEtY2hlbi56aGFuZ0BpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQ2xvbmUgb2YgJ2h0dHBzOi8v
Z2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0JyBpbnRvIHN1Ym1vZHVsZSBwYXRoICdkdGMnIGZhaWxl
ZApmYWlsZWQgdG8gdXBkYXRlIHN1Ym1vZHVsZSBkdGMKU3VibW9kdWxlICdkdGMnIChodHRwczov
L2dpdC5xZW11Lm9yZy9naXQvZHRjLmdpdCkgdW5yZWdpc3RlcmVkIGZvciBwYXRoICdkdGMnCm1h
a2VbMV06ICoqKiBbL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTJlcTY5dTMzL3NyYy9kb2Nr
ZXItc3JjLjIwMTktMTAtMTYtMTEuMzQuNTkuMTAxMjNdIEVycm9yIDEKbWFrZVsxXTogTGVhdmlu
ZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0yZXE2OXUzMy9zcmMnCm1h
a2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAg
MG0zLjc2MnMKdXNlciAgICAwbTIuMzQ5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMTYxMTIyMDkuOTAyNC0xLWNoZW4uemhhbmdA
aW50ZWwuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


