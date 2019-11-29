Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A7DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 04:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6372158A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 04:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6372158A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaY3I-0004u0-2m
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 23:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iaY2e-0004Sn-NH
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 23:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iaY2a-0002v3-7r
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 23:38:02 -0500
Resent-Date: Thu, 28 Nov 2019 23:38:01 -0500
Resent-Message-Id: <E1iaY2a-0002v3-7r@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iaY2Z-0002hb-Ma
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 23:37:59 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575002258; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jViyRLeWt5nVJa7eL7h0ClgopD3BRJEZXn1eeP1xZP8Kpi+KgmrcY1+T7o7hF6xtMmT9bFAp9wKcp+zM2RCmDOAQgggXQCDucsBZP5PVyEENZBAQh+job38t3wwFornE8IYOC2m69QROIsAes5B8TyNn8ReeuCdp3tkEWyYa3mg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575002258;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=p/0oc9X3DXd5K4F8GlXTpLkN3DnCZTdrDoVWnJ2VHUc=; 
 b=miGipheqSgt/9Ch3y5sx8jM9mMEggMkHBBKvidQKv/lNdlDhgzKMAfQxW3Rl/KSf059TSZrvVZ5QXSbmKmlH5w/Yqjdl7V5jdkgEXv3vTqT6qdaj9wMI9dXI5m8OFfZP79EPJxnBMBixtxrtzFQalUIJcAPKKmQg75KSzmj3+7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575002256850747.5863864048574;
 Thu, 28 Nov 2019 20:37:36 -0800 (PST)
In-Reply-To: <20191128141518.628245-1-marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
Message-ID: <157500225553.16987.12940073507274968397@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Thu, 28 Nov 2019 20:37:36 -0800 (PST)
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyODE0MTUxOC42Mjgy
NDUtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50
b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hP
V19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IHg4Nl82NC1zb2Z0bW11L2FjY2VsL3RjZy90Y2ctcnVudGltZS1ndmVjLm8KICBDQyAgICAgIHg4
Nl82NC1zb2Z0bW11L2FjY2VsL3RjZy9jcHUtZXhlYy5vCi90bXAvcWVtdS10ZXN0L3NyYy9leGVj
LmM6IEluIGZ1bmN0aW9uICdxZW11X3JhbV9hbGxvY19mcm9tX2ZpbGUnOgovdG1wL3FlbXUtdGVz
dC9zcmMvZXhlYy5jOjIzNjY6MTI6IGVycm9yOiAnY3JlYXRlZCcgbWF5IGJlIHVzZWQgdW5pbml0
aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAg
ICAgICAgIGlmIChjcmVhdGVkKSB7CiAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVp
bmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFtleGVjLm9dIEVycm9yIDEKbWFrZVsx
XTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFhcmNoNjQt
c29mdG1tdS9kaXNhcy5vCiAgR0VOICAgICBhYXJjaDY0LXNvZnRtbXUvZ2Ric3R1Yi14bWwuYwov
dG1wL3FlbXUtdGVzdC9zcmMvZXhlYy5jOiBJbiBmdW5jdGlvbiAncWVtdV9yYW1fYWxsb2NfZnJv
bV9maWxlJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2V4ZWMuYzoyMzY2OjEyOiBlcnJvcjogJ2NyZWF0
ZWQnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1t
YXliZS11bmluaXRpYWxpemVkXQogICAgICAgICBpZiAoY3JlYXRlZCkgewogICAgICAgICAgICBe
CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBb
ZXhlYy5vXSBFcnJvciAxCm1ha2VbMV06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCm1ha2U6ICoqKiBbeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbYWFyY2g2NC1zb2Z0bW11L2Fs
bF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90
ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjIsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhp
dChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkK
c3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdk
b2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1jZTM0ODk0
MmNjMTQ0MjE4YWI2NjUyNjJiNWUyYmYzNCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0
JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICct
ZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICct
ZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1mdHMybXVrcC9zcmMvZG9ja2VyLXNyYy4yMDE5LTExLTI4LTIzLjM1LjA4LjE1NTE0Oi92YXIv
dG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVz
dC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0
ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1jZTM0ODk0MmNjMTQ0MjE4YWI2NjUyNjJi
NWUyYmYzNAptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmlu
ZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1mdHMybXVrcC9zcmMnCm1h
a2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAg
Mm0yNy42MTVzCnVzZXIgICAgMG04LjE0NnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTI4MTQxNTE4LjYyODI0NS0xLW1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t


