Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB8D20866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB8D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9dpV-0006yM-64
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j9dou-0006No-4R
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j9dos-0003z6-Fl
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:52:55 -0500
Resent-Date: Wed, 04 Mar 2020 18:52:55 -0500
Resent-Message-Id: <E1j9dos-0003z6-Fl@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j9dos-0003wC-87; Wed, 04 Mar 2020 18:52:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583365965; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bX4QIkQBwifw498Rvhh3J35vLcXdcaM7c2TIlfY57jX+lnr/9UnYKsqHssTobiHS5O2glvrTFAa2xYuUiKGqqMiC1ubpkvBFqtLPhba5kNS1ENi6dID7OAc1HPngsnees3T7dqqYYnrUWB+iDWWLneHr/fmM/6u4CrBVgehgx+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583365965;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=zRBPA8psJ1uL0AxxUZPleHows8b8vfDU1XJqP9o7Lac=; 
 b=mdncwYiX4x3Xz/+JsJ/tv7rCYPZOvu4iMaLP0UvUw2q5do3lIdJfUylSRhhdQ5+aSZRtkz441pIoWKVnj/5+pnGmNUqDNtG3Qa5KwT3LXDCC7TwxrVU1q8tGEWA6Y1qFC8B6r5hdh6LwWrACDf5qZSxqDL6bvs2iXR8EJluzDpw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583365963326898.1939006752978;
 Wed, 4 Mar 2020 15:52:43 -0800 (PST)
In-Reply-To: <cover.1583362888.git.alistair.francis@wdc.com>
Subject: Re: [PATCH v2 0/3] hw/riscv: Add a serial property to the sifive_u
 machine
Message-ID: <158336596205.21741.18419810065024647085@abdcc9e1aa82>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alistair.francis@wdc.com
Date: Wed, 4 Mar 2020 15:52:43 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTgzMzYyODg4Lmdp
dC5hbGlzdGFpci5mcmFuY2lzQHdkYy5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9
MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9
MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKcWVtdS1zeXN0ZW0teDg2
XzY0OiAtYWNjZWwga3ZtOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBrdm06IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkKcWVtdS1zeXN0ZW0teDg2XzY0OiBmYWxsaW5nIGJhY2sgdG8gdGNnCioqCkVS
Uk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9taWdyYXRpb24taGVscGVycy5jOjEx
OTpjaGVja19taWdyYXRpb25fc3RhdHVzOiBhc3NlcnRpb24gZmFpbGVkIChjdXJyZW50X3N0YXR1
cyAhPSAiY29tcGxldGVkIik6ICgiY29tcGxldGVkIiAhPSAiY29tcGxldGVkIikKRVJST1IgLSBC
YWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi1o
ZWxwZXJzLmM6MTE5OmNoZWNrX21pZ3JhdGlvbl9zdGF0dXM6IGFzc2VydGlvbiBmYWlsZWQgKGN1
cnJlbnRfc3RhdHVzICE9ICJjb21wbGV0ZWQiKTogKCJjb21wbGV0ZWQiICE9ICJjb21wbGV0ZWQi
KQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGlu
ZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwNjEKICBU
RVNUICAgIGlvdGVzdC1xY293MjogMDYyCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9y
KHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1sn
c3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFu
Y2UudXVpZD03ODE4ZjdiYjY4MjM0ZTNkYWVlM2MxODI2ODlhYzBkYicsICctdScsICcxMDAzJywg
Jy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RB
UkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAn
LWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdD
Q0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUv
cWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1mZ3Q2NmQ4Mi9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTA0LTE4LjQw
LjM1Ljk4NDg6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9x
ZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIu
CmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTc4MThmN2JiNjgy
MzRlM2RhZWUzYzE4MjY4OWFjMGRiCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQpt
YWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZn
dDY2ZDgyL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJy
b3IgMgoKcmVhbCAgICAxMm02Ljg0MnMKdXNlciAgICAwbTUuOTE4cwoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU4MzM2Mjg4OC5n
aXQuYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

