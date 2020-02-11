Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC8C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7752A206ED
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7752A206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1aQd-00004w-Ns
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j1aP5-0006mx-2w
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j1aP3-0004Fm-PM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:36:58 -0500
Resent-Date: Tue, 11 Feb 2020 13:36:58 -0500
Resent-Message-Id: <E1j1aP3-0004Fm-PM@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j1aP3-00047S-HX
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:36:57 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1581446209; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nVnclkDcRkLNquwUudn7qwLTR0UhYdbUSjKkyp9K07h//kdg7y1ekOgDV6MSlSenMusM7nEZ+OvwKHL1OXFSHY81lCmCgWOQC0VH8tZgPDjuNGkpyVMspL4IL4llbKng40nme9NfG8UmZKokkxA1uU4hqqupudq3Jtrs5AO1gjs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1581446209;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4IQaD9qde+8QNTu3+5Txz9AZKMOSdm67txd0TExZLQg=; 
 b=YhnSjeB/RnTHzP1lFM+Fv3apHzkt4ULcvohxu6UQJOs163BcydmnVpbwSEoZ5rVar/lW+pT0N/vZ1/FP0H6m0tx2BtE9CsNM4HF15nR++oXoLaf5FrXBJciYwsCvM2hs9OOjWUYUzI3vXUt7BYwPTKmoNcibhdYTr0Atbuu/0Kk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1581446207276550.7718058893702;
 Tue, 11 Feb 2020 10:36:47 -0800 (PST)
In-Reply-To: <20200211175516.10716-1-pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: check for availability of MSR_IA32_UCODE_REV
 as an emulated MSR
Message-ID: <158144620617.7519.8581186859525916946@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 11 Feb 2020 10:36:47 -0800 (PST)
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
Cc: alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxMTE3NTUxNi4xMDcx
Ni0xLXBib256aW5pQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKcWVtdS1zeXN0ZW0teDg2XzY0
OiAtYWNjZWwga3ZtOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBrdm06IE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkKcWVtdS1zeXN0ZW0teDg2XzY0OiBmYWxsaW5nIGJhY2sgdG8gdGNnCioqCkVSUk9S
Oi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9taWdyYXRpb24taGVscGVycy5jOjExOTpj
aGVja19taWdyYXRpb25fc3RhdHVzOiBhc3NlcnRpb24gZmFpbGVkIChjdXJyZW50X3N0YXR1cyAh
PSAiY29tcGxldGVkIik6ICgiY29tcGxldGVkIiAhPSAiY29tcGxldGVkIikKRVJST1IgLSBCYWls
IG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi1oZWxw
ZXJzLmM6MTE5OmNoZWNrX21pZ3JhdGlvbl9zdGF0dXM6IGFzc2VydGlvbiBmYWlsZWQgKGN1cnJl
bnRfc3RhdHVzICE9ICJjb21wbGV0ZWQiKTogKCJjb21wbGV0ZWQiICE9ICJjb21wbGV0ZWQiKQpt
YWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwODAKICBURVNU
ICAgIGlvdGVzdC1xY293MjogMDg2Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD1kNzQ4ZmI4N2U1NGI0NGU5YjViMzRkOTcyYzMxZTEwNCcsICctdScsICcxMDAxJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11
LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLWM3aXV5MG9sL3NyYy9kb2NrZXItc3JjLjIwMjAtMDItMTEtMTMuMjUuMDYu
NjMwNTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUv
cnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmls
dGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZDc0OGZiODdlNTRiNDRl
OWI1YjM0ZDk3MmMzMWUxMDQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2Vb
MV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYzdpdXkw
b2wvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAy
CgpyZWFsICAgIDExbTQwLjI3NXMKdXNlciAgICAwbTguNTMxcwoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAyMTExNzU1MTYuMTA3MTYt
MS1wYm9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

