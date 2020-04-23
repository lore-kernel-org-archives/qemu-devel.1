Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18808C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0232075A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0232075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXwH-0004jq-3y
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRXvZ-0004AU-3m
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jRXvY-0004DR-Mw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:13:48 -0400
Resent-Date: Thu, 23 Apr 2020 05:13:48 -0400
Resent-Message-Id: <E1jRXvY-0004DR-Mw@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jRXvW-0003w4-7H; Thu, 23 Apr 2020 05:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587633210; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VVSGFYuiacgtCVG/Cr0OwEZN2WfMMzrs7p6JD9uuNUPvMgZPRAeJuKIwa4W7sMgvC3Ijrikg4aXW7l82yE/SkMm+EvHwaHCchtmwvq4aNhCZ6JWqcO6QeGjaTEPxilx37RyKrr3HrgFMAv2bN+xgY0qtzYBEDIXNI0lMt1EB8X8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587633210;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lVcquTCP4j4rjMQfIarQX/W9zv5y8Yc+42wtUUDGOBw=; 
 b=QshwM3Dv4laGOlm0nq3jZs3qxFFPiKuy87//LaZE4Cm8VsjOU4okI6Ms/WM75ST61jKwixbbQFr+Q4wxUdzfuUrIikrpAfyoY/1nudqcEENi0ZlpjfZ1zoDKXVOOWU4AV2SC2a829ZRelS62VMhpAAmIzG/+p9LHd0X9lcunxO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587633209047725.916656049011;
 Thu, 23 Apr 2020 02:13:29 -0700 (PDT)
In-Reply-To: <20200423090118.11199-1-geert+renesas@glider.be>
Subject: Re: [PATCH QEMU v2 0/5] Add a GPIO backend
Message-ID: <158763320718.4520.18138029284746846177@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: geert+renesas@glider.be
Date: Thu, 23 Apr 2020 02:13:29 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:13:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: peter.maydell@linaro.org, geert+renesas@glider.be, linus.walleij@linaro.org,
 magnus.damm@gmail.com, qemu-devel@nongnu.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 qemu-arm@nongnu.org, graf@amazon.com, pbonzini@redhat.com,
 bartekgola@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMzA5MDExOC4xMTE5
OS0xLWdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQK
dGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2Fu
IHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3Jh
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRf
TElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKICBDQyAgICAgIGNoYXJkZXYvY2hhci1waXBlLm8KICBDQyAgICAgIGNoYXJkZXYvY2hhci1w
dHkubwoKV2FybmluZywgdHJlYXRlZCBhcyBlcnJvcjoKL3RtcC9xZW11LXRlc3Qvc3JjL2RvY3Mv
Li4vcWVtdS1vcHRpb25zLmh4Ojg4MTpVbmV4cGVjdGVkIGluZGVudGF0aW9uLgogIENDICAgICAg
Y2hhcmRldi9jaGFyLXJpbmdidWYubwogIENDICAgICAgY2hhcmRldi9jaGFyLXNlcmlhbC5vCgpX
YXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOgovdG1wL3FlbXUtdGVzdC9zcmMvZG9jcy8uLi9xZW11
LW9wdGlvbnMuaHg6ODgxOlVuZXhwZWN0ZWQgaW5kZW50YXRpb24uCiAgQ0MgICAgICBjaGFyZGV2
L2NoYXItc29ja2V0Lm8KICBDQyAgICAgIGNoYXJkZXYvY2hhci1zdGRpby5vCi0tLQogIENDICAg
ICAgYmxvY2tkZXYtbmJkLm8KICBDQyAgICAgIGlvdGhyZWFkLm8KICBDQyAgICAgIGpvYi1xbXAu
bwptYWtlOiAqKiogW01ha2VmaWxlOjExMTU6IC5kb2NzX3N5c3RlbV9xZW11LjFfZG9jc19zeXN0
ZW1fcWVtdS1ibG9jay1kcml2ZXJzLjdfZG9jc19zeXN0ZW1fcWVtdS1jcHUtbW9kZWxzLjcuc2Vu
dGluZWwuXSBFcnJvciAyCm1ha2U6ICoqKiBEZWxldGluZyBmaWxlICcuZG9jc19zeXN0ZW1fcWVt
dS4xX2RvY3Nfc3lzdGVtX3FlbXUtYmxvY2stZHJpdmVycy43X2RvY3Nfc3lzdGVtX3FlbXUtY3B1
LW1vZGVscy43LnNlbnRpbmVsLicKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9i
cy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZToxMTA0OiBkb2NzL3N5c3RlbS9pbmRleC5odG1sXSBF
cnJvciAyClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3Rz
L2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1h
aW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTU4M2IxMGUxOTJk
ODQxZWE5ODVmZTk0NzRlOWNjZTViJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNv
ZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1k
b2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC00MXhiN2JlXy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTIzLTA1LjA5LjU2LjEw
MjQ4Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTU4M2IxMGUxOTJkODQxZWE5
ODVmZTk0NzRlOWNjZTViCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTQxeGI3YmVf
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVkb3JhXSBFcnJvciAyCgpy
ZWFsICAgIDNtMzAuMjMycwp1c2VyICAgIDBtOC40NTdzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQyMzA5MDExOC4xMTE5OS0xLWdl
ZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlL3Rlc3RpbmcuYXNhbi8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

