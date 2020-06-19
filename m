Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1C4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F97D21924
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F97D21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIMz-0004YA-O9
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmILe-0002yl-S5
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:50:30 -0400
Resent-Date: Fri, 19 Jun 2020 10:50:30 -0400
Resent-Message-Id: <E1jmILe-0002yl-S5@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmILc-0003W7-7x
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:50:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592578215; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cHKH22aUNRSTi+0SFjsQvjK1PdjyWdDmrxw4rkGk08xFCy4qcycERi9mUPtcEcquHhw0t8xbCPCQ4inrJX6v3V2h0WQX57wWW6/tPu94Zhj2lxoX8680UbHgAE8/1y2Xk/e0u6eJS68DNhMqkQakn74rnl5ZxGeEsUKUPhiY9Zk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592578215;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=3aE2Ff/049rR25KW5R2mEQGkzcdD0SJQxP2A9cQCFEU=; 
 b=VPGxUQzxlhln0sC0p4GBBgWriMDxK/hFV8Fba+xanpaDAkrUNM590WEPK8cks1vM2c+XTmBUleCAJ+v1L3Rj3KLiXBfxAseFhXPZlV9PSfGGEgfo1e/ka0q6SDk8VZd38/A4VXbYo7ktjj9Cfkyjz2pOR1cQkGgSG57vRLsvcoM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159257821272282.35505608739754;
 Fri, 19 Jun 2020 07:50:12 -0700 (PDT)
Message-ID: <159257821134.2784.18219083983698800306@d1fd068a5071>
Subject: Re: [RFC PATCH] docs/devel: add some notes on tcg-icount for
 developers
In-Reply-To: <20200619135844.23307-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 19 Jun 2020 07:50:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 10:14:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dovgaluk@ispras.ru, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxOTEzNTg0NC4yMzMw
Ny0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IGNyeXB0by90bHNjcmVkc3g1MDkubwogIENDICAgICAgY3J5cHRvL3Rsc3Nlc3Npb24ubwoKV2Fy
bmluZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3MvZGV2ZWwvdGNn
LWljb3VudC5yc3Q6ZG9jdW1lbnQgaXNuJ3QgaW5jbHVkZWQgaW4gYW55IHRvY3RyZWUKICBDQyAg
ICAgIGNyeXB0by9zZWNyZXRfY29tbW9uLm8KICBDQyAgICAgIGNyeXB0by9zZWNyZXQubwotLS0K
ICBDQyAgICAgIHFvbS9xb20tcW9iamVjdC5vCiAgQ0MgICAgICBxb20vb2JqZWN0X2ludGVyZmFj
ZXMubwogIENDICAgICAgcWVtdS1pby5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTA4ODogZG9jcy9k
ZXZlbC9pbmRleC5odG1sXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVk
IGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rl
c3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2OSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlz
ZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nl
c3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJl
bCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTIyZDVhNTFjNDk3MzRmMGZiZmNhODM3YTliYTIw
MzY4JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVk
JywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9P
UFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdT
SE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hv
bWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eics
ICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcl9kOGRjOWovc3JjL2RvY2tlci1z
cmMuMjAyMC0wNi0xOS0xMC40Ny4yNi4zMTIyMDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpm
ZWRvcmEnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1taW5ndyddJyByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFu
Y2UudXVpZD0yMmQ1YTUxYzQ5NzM0ZjBmYmZjYTgzN2E5YmEyMDM2OAptYWtlWzFdOiAqKiogW2Rv
Y2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3Bh
dGNoZXctdGVzdGVyLXRtcC1yX2Q4ZGM5ai9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0
LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoKcmVhbCAgICAybTQ0LjM3OHMKdXNlciAgICAwbTguNDIy
cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAyMDA2MTkxMzU4NDQuMjMzMDctMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9j
a2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

