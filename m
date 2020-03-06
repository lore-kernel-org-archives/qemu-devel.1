Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C83C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279BF24671
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279BF24671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACfZ-0001pU-AC
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jACew-0001JF-E7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jACet-0003wn-TP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:04:57 -0500
Resent-Date: Fri, 06 Mar 2020 08:04:57 -0500
Resent-Message-Id: <E1jACet-0003wn-TP@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jACet-0003hv-LM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:04:55 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583499877; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NOZOgkr5RLOjRRUn/YtdGVHVTmCptXhxtY2TUrYHdqKzjBGBGj3mkKEQfhHffkPNlQnxEnHSE3bHTW3groEZQTxNSTh+OJXfnVe4v0BUf0Qr/MwkVKvGPf+fbViFHIwWwQpOEmKNM5rR8PkMwZAqXvmAIQH/7nFJGm/Y0CDDF2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583499877;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HgFVB9uvE6197YcFbfrWqZxxpW1LU3aRIz6q8Se6p9o=; 
 b=AceGdbC9hY7JMLd58wHd/EO3e8sQVQXTleA2Naxq+ge6hZcvbZsbaEzdTgxGOmO1dSZLj+zHb9k1KVrLAbwpSyyNN3+MU9c74NPi8Eh5QcNp5byYMAN1GqDd++pi1oZSIckB79vbiPkQReoSzJX4eABIQU0cA/v7LD7UIx0hJZI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583499874197344.925068085053;
 Fri, 6 Mar 2020 05:04:34 -0800 (PST)
In-Reply-To: <158349633705.1237488.8895481990204796135.stgit@bahia.lan>
Subject: Re: [PATCH] 9p/proxy: Fix export_flags
Message-ID: <158349987298.14529.13594208466433957287@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: groug@kaod.org
Date: Fri, 6 Mar 2020 05:04:34 -0800 (PST)
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
Cc: pbonzini@redhat.com, qemu_oss@crudebyte.com, qemu-devel@nongnu.org,
 stgraber@ubuntu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTgzNDk2MzM3MDUuMTIzNzQ4
OC44ODk1NDgxOTkwMjA0Nzk2MTM1LnN0Z2l0QGJhaGlhLmxhbi8KCgoKSGksCgpUaGlzIHNlcmll
cyBmYWlsZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQg
dGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUg
RG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4K
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82
NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2Vy
LXRlc3QtbWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpGaWxlOiAiL3RtcC9xZW11LW5zaXNccWVtdS1kb2MuaHRtbCIgLT4gbm8gZmlsZXMgZm91bmQu
ClVzYWdlOiBGaWxlIFsvbm9uZmF0YWxdIFsvYV0gKFsvcl0gWy94IGZpbGVzcGVjIFsuLi5dXSBm
aWxlc3BlYyBbLi4uXSB8CiAgIC9vbmFtZT1vdXRmaWxlIG9uZV9maWxlX29ubHkpCkVycm9yIGlu
IHNjcmlwdCAiL3RtcC9xZW11LXRlc3Qvc3JjL3FlbXUubnNpIiBvbiBsaW5lIDE4MCAtLSBhYm9y
dGluZyBjcmVhdGlvbiBwcm9jZXNzCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTE2MjogcWVtdS1zZXR1
cC00LjIuNTAuZXhlXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToK
ICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4K
ICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0
Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRv
JywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51
dWlkPTVhMmYyZWYzNDZkZTQ4ZDliN2E5YmExYTRkYjQyZmNiJywgJy11JywgJzEwMDEnLCAnLS1z
ZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VU
X0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScs
ICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hF
X0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1k
b2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC1pMnN2N3lyai9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTA2LTA4LjAwLjUzLjE2
NjkzOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTVhMmYyZWYzNDZkZTQ4ZDli
N2E5YmExYTRkYjQyZmNiCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWkyc3Y3eXJq
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpy
ZWFsICAgIDNtNDAuMzI2cwp1c2VyICAgIDBtOC42OTBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTgzNDk2MzM3MDUuMTIzNzQ4OC44ODk1
NDgxOTkwMjA0Nzk2MTM1LnN0Z2l0QGJhaGlhLmxhbi90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRv
cmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

