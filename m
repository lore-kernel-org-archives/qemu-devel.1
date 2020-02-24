Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D027C38BE0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4433B20838
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 19:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4433B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6JEf-0005Dx-Ea
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 14:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j6JE4-0004ca-U5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j6JE2-0001Lz-QV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 14:17:08 -0500
Resent-Date: Mon, 24 Feb 2020 14:17:07 -0500
Resent-Message-Id: <E1j6JE2-0001Lz-QV@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j6JE1-0001JH-FM; Mon, 24 Feb 2020 14:17:06 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582571810; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oEbDLCyhVrnMQTNpasLjnjC0ctFwkmoAB/SThLRP8caIgTlZlfe7/zZx5xzdNc+uZFI8MpPVrawOmN+6DYAXoHbg2gNutZV6LmCviD0/ctn+AFoWArLU4QBXULkq9lOR9fs6I2sgi9zRhd+4f1jZ7h3I7dVDsbC61i05ErJXJco=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582571810;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=w4rZ9K+FDadgh4A3FjLDkqDk9zsbozG/qn0aox1kzhE=; 
 b=QKO5s/sd8ZVGUXa5U+xscM31k4m/8S0ozJ+KEMlYnuhHw0ty/8CUv1xY8z82iVz/h/5BkEeDwMa0WBVKcvUWxPd0z9eQxWhxWLitoXE6bRqEA4dUNSTcocaxopq4ArSsh5zBxtSyl4mTNWUpwfvH+c1cd203luvIZcsUM5bVcFU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582571808840430.0547574500098;
 Mon, 24 Feb 2020 11:16:48 -0800 (PST)
In-Reply-To: <20200224170301.246623-1-damien.hedde@greensocs.com>
Subject: Re: [PATCH v7 0/9] Clock framework API
Message-ID: <158257180673.10132.9769642807925986716@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: damien.hedde@greensocs.com
Date: Mon, 24 Feb 2020 11:16:48 -0800 (PST)
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIyNDE3MDMwMS4yNDY2
MjMtMS1kYW1pZW4uaGVkZGVAZ3JlZW5zb2NzLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtl
IGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
bWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgbmV0L3RyYWNlLm8KICBDQyAgICAgIHVpL3RyYWNlLm8KCldhcm5pbmcsIHRyZWF0ZWQg
YXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0L3NyYy9kb2NzL2RldmVsL2Nsb2Nrcy5yc3Q6NjM6VW5l
eHBlY3RlZCBpbmRlbnRhdGlvbi4KICBDQyAgICAgIGh3L2NvcmUvdHJhY2UubwogIENDICAgICAg
aHcvZGlzcGxheS90cmFjZS5vCi0tLQogIENDICAgICAgc3R1YnMvZHVtcC5vCiAgQ0MgICAgICBz
dHVicy9lcnJvci1wcmludGYubwogIENDICAgICAgc3R1YnMvZmRzZXQubwptYWtlOiAqKiogW01h
a2VmaWxlOjEwNjE6IGRvY3MvZGV2ZWwvaW5kZXguaHRtbF0gRXJyb3IgMgptYWtlOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwg
bGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxt
b2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2Nr
ZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD04OWRiZDlhNzA4
NjY0ZGE1ODRmY2VmMjBkMDkxZThjYicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0Jywg
J3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScs
ICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScs
ICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6
L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTJ2
aDJmejMzL3NyYy9kb2NrZXItc3JjLjIwMjAtMDItMjQtMTQuMTQuMTAuODkwOi92YXIvdG1wL3Fl
bXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3
J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJl
bD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTg5ZGJkOWE3MDg2NjRkYTU4NGZjZWYyMGQwOTFlOGNi
Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVj
dG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTJ2aDJmejMzL3NyYycKbWFrZTogKioq
IFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDJtMzYuODgz
cwp1c2VyICAgIDBtOC4wNzVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDIwMDIyNDE3MDMwMS4yNDY2MjMtMS1kYW1pZW4uaGVkZGVAZ3Jl
ZW5zb2NzLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

