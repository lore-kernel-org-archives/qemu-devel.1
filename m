Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207CCC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7D720637
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7D720637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYMG-0007TR-3b
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iZYAM-00031z-8c
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iZYAI-0006iL-I2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:33:53 -0500
Resent-Date: Tue, 26 Nov 2019 05:33:51 -0500
Resent-Message-Id: <E1iZYAI-0006iL-I2@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iZYAI-0006gj-91
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:33:50 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574764385; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gKLimMF1PS9qx80R3iT/EnfAW+TENs/7KTaCr5ErsnSAC8nD0gEnvgaaLG8HinIHAOTzR1QMQ8WmQsZm9Rmb+WiZIbw3R42Pf0ly/hw2/rFr7F2D94XTAmjaM4LrlSU39/+WOB+ZNL/d63NIibVqwePhgy+FVgJu/emr0g3KebU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574764385;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4Hg+6acknztSxkk1XXynSdoyPl2trR0LMbBAHb1kRpQ=; 
 b=jN3T/UbGJ1zb0dJdigqExoPATgefE0GNleHewa1WdjINYbXNvPVvyg9qMExFr/GWLJpfaahvHhkPijwbaNOHvmH9Z0AQSvR1sWf+0IfPvURCzlL4wxZpc0cOWbPfYNPOSolJ/oDUxJnR4TWbhnrxVeylBuUDoALuJ71J9AhO7/k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574764383634138.33074800024394;
 Tue, 26 Nov 2019 02:33:03 -0800 (PST)
In-Reply-To: <20191126100914.5150-1-prashantbhole.linux@gmail.com>
Subject: Re: [RFC 0/3] Qemu: virtio-net XDP offload
Message-ID: <157476438124.31055.4199785471534349367@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: prashantbhole.linux@gmail.com
Date: Tue, 26 Nov 2019 02:33:03 -0800 (PST)
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
Cc: songliubraving@fb.com, jakub.kicinski@netronome.com, hawk@kernel.org,
 daniel@iogearbox.net, mst@redhat.com, netdev@vger.kernel.org,
 jasowang@redhat.com, john.fastabend@gmail.com, qemu-devel@nongnu.org,
 ast@kernel.org, davem@davemloft.net, prashantbhole.linux@gmail.com,
 kvm@vger.kernel.org, yhs@fb.com, andriin@fb.com, kafai@fb.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyNjEwMDkxNC41MTUw
LTEtcHJhc2hhbnRiaG9sZS5saW51eEBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50
b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hP
V19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IHVpL2lucHV0LWtleW1hcC5vCiAgQ0MgICAgICB1aS9pbnB1dC1sZWdhY3kubwogIENDICAgICAg
dWkva2JkLXN0YXRlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL25ldC90YXAtbGludXguYzozNDoyMTog
ZmF0YWwgZXJyb3I6IGJwZi9icGYuaDogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQogI2luY2x1
ZGUgPGJwZi9icGYuaD4KICAgICAgICAgICAgICAgICAgICAgXgpjb21waWxhdGlvbiB0ZXJtaW5h
dGVkLgotLS0KICBTSUdOICAgIHBjLWJpb3Mvb3B0aW9ucm9tL2xpbnV4Ym9vdC5iaW4KICBTSUdO
ICAgIHBjLWJpb3Mvb3B0aW9ucm9tL2t2bXZhcGljLmJpbgogIEJVSUxEICAgcGMtYmlvcy9vcHRp
b25yb20vbGludXhib290X2RtYS5pbWcKbWFrZTogKioqIFtuZXQvdGFwLWxpbnV4Lm9dIEVycm9y
IDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBCVUlMRCAgIHBj
LWJpb3Mvb3B0aW9ucm9tL3B2aC5pbWcKICBCVUlMRCAgIHBjLWJpb3Mvb3B0aW9ucm9tL2xpbnV4
Ym9vdF9kbWEucmF3Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1iZTg0
OWJmZWQwMmQ0ZWE3YjE5Zjc3NDZmZTAzN2JkNScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92
YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1j
Y2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLTNkMnozd2wzL3NyYy9kb2NrZXItc3JjLjIwMTktMTEtMjYtMDUuMzEuMDUuMjE3MDg6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWJlODQ5YmZlZDAyZDRlYTdiMTlmNzc0
NmZlMDM3YmQ1Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTNkMnozd2wzL3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAxbTU2LjQ0N3MKdXNlciAgICAwbTguNTE5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMjYxMDA5MTQuNTE1MC0xLXByYXNoYW50
YmhvbGUubGludXhAZ21haWwuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


