Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D157CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF64206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 18:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF64206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHtyd-0000SA-Se
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 14:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jHty4-0008Tm-1x
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jHty2-0005aE-3u
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:44:31 -0400
Resent-Date: Fri, 27 Mar 2020 14:44:31 -0400
Resent-Message-Id: <E1jHty2-0005aE-3u@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jHty1-0005Xq-Up; Fri, 27 Mar 2020 14:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585334662; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MijE+36uQucHHP2TmR5PE1ldFzZjNl5QrV+K1blcADLvmGabIZfYZIWTA2IuNS/PxnBkRNW14zZXblQMK1i5HjwT0Nuw5zOSBlJNBxZkLUyVFR99RyxAZvFLx/FRzFxlPmeqK13xvSSBrd2zuJnPIUwKm+kfZ5wTl+dqAToM0a4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585334662;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=pI23XKnk5B6HzM8UZMjeAeB7PlWdyMAfwmGqtVtbrgI=; 
 b=ie1IzR+F9XYVBz09qvhRqq2k3OjVOs6zc9VaZe2ivVRNc/nvyXA+Ud7ZmE6Fdm8yWoLDYibFrEcjwz8nTQIZqVWCZPDG04vy7nyAzJDyIx6Q/gucP2CfxFfKrKnUj8b4qJJUGmhDOFHmigyPVL9wCvnKYqQ/0jpGphqZyQfTsPI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585334659582736.7489855528029;
 Fri, 27 Mar 2020 11:44:19 -0700 (PDT)
In-Reply-To: <20200327161936.2225989-1-eblake@redhat.com>
Subject: Re: [PATCH 0/3] nbd: Try for cleaner TLS shutdown
Message-ID: <158533465841.31566.2702359822258807377@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: eblake@redhat.com
Date: Fri, 27 Mar 2020 11:44:19 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNzE2MTkzNi4yMjI1
OTg5LTEtZWJsYWtlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKaW8vY2hhbm5lbC10bHMubzog
SW4gZnVuY3Rpb24gYHFpb19jaGFubmVsX3Rsc19zaHV0ZG93bic6Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9pby9jaGFubmVsLXRscy5jOjM3MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcWNyeXB0b190
bHNfc2Vzc2lvbl9zaHV0ZG93bicKL3RtcC9xZW11LXRlc3Qvc3JjL2lvL2NoYW5uZWwtdGxzLmM6
Mzc2OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBxY3J5cHRvX3Rsc19zZXNzaW9uX3NodXRkb3du
Jwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFtz
Y3NpL3FlbXUtcHItaGVscGVyXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uCmlvL2NoYW5uZWwtdGxzLm86IEluIGZ1bmN0aW9uIGBxaW9fY2hhbm5lbF90
bHNfc2h1dGRvd24nOgovdG1wL3FlbXUtdGVzdC9zcmMvaW8vY2hhbm5lbC10bHMuYzozNzM6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYHFjcnlwdG9fdGxzX3Nlc3Npb25fc2h1dGRvd24nCi90bXAv
cWVtdS10ZXN0L3NyYy9pby9jaGFubmVsLXRscy5jOjM3NjogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgcWNyeXB0b190bHNfc2Vzc2lvbl9zaHV0ZG93bicKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1
cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2U6ICoqKiBbcWVtdS1uYmRdIEVycm9yIDEKaW8vY2hhbm5l
bC10bHMubzogSW4gZnVuY3Rpb24gYHFpb19jaGFubmVsX3Rsc19zaHV0ZG93bic6Ci90bXAvcWVt
dS10ZXN0L3NyYy9pby9jaGFubmVsLXRscy5jOjM3MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
cWNyeXB0b190bHNfc2Vzc2lvbl9zaHV0ZG93bicKL3RtcC9xZW11LXRlc3Qvc3JjL2lvL2NoYW5u
ZWwtdGxzLmM6Mzc2OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBxY3J5cHRvX3Rsc19zZXNzaW9u
X3NodXRkb3duJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFr
ZTogKioqIFtxZW11LWlvXSBFcnJvciAxCmlvL2NoYW5uZWwtdGxzLm86IEluIGZ1bmN0aW9uIGBx
aW9fY2hhbm5lbF90bHNfc2h1dGRvd24nOgovdG1wL3FlbXUtdGVzdC9zcmMvaW8vY2hhbm5lbC10
bHMuYzozNzM6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHFjcnlwdG9fdGxzX3Nlc3Npb25fc2h1
dGRvd24nCi90bXAvcWVtdS10ZXN0L3NyYy9pby9jaGFubmVsLXRscy5jOjM3NjogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBgcWNyeXB0b190bHNfc2Vzc2lvbl9zaHV0ZG93bicKY29sbGVjdDI6IGVy
cm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2U6ICoqKiBbcWVtdS1zdG9yYWdlLWRh
ZW1vbl0gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAi
Li90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAgICBzeXMu
ZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD04OWQ4
ODliZDlkZDg0YTY1OTJlNTI2Yjk2N2Y2YThjYycsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92
YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC14dGtjeHhteS9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTI3LTE0LjQyLjA0LjI5MjM4Oi92
YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAn
dGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1m
aWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD04OWQ4ODliZDlkZDg0YTY1OTJlNTI2
Yjk2N2Y2YThjYwptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVh
dmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC14dGtjeHhteS9zcmMn
Cm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwg
ICAgMm0xMy40ODdzCnVzZXIgICAgMG04LjQxOXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMzI3MTYxOTM2LjIyMjU5ODktMS1lYmxh
a2VAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

