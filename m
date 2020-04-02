Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0245BC2BA15
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE57C20678
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE57C20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK6GR-0005wQ-V7
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 16:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jK6FK-000518-Cl
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jK6FI-00026I-Ru
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:25 -0400
Resent-Date: Thu, 02 Apr 2020 16:15:25 -0400
Resent-Message-Id: <E1jK6FI-00026I-Ru@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jK6FI-00024i-Jw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585858509; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EiLbOUoaKxQLz+V+i2Vq/1Amp5rRKb70/UEWuiZAkZEVCs7q/HBDW/6n6p6E/QT/80RFJx9F2OtBZxRyh3P+yLUopgIwPWo/NAnk9dzOn/MZd9D0rhIUzRqsD8IyAcVaDk3TrI/KUPyow3UGkaTESPhe4+90tAI9nDk9osLVBH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585858509;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=q/Mrs6gCxbtRxE1dFwUvPpaZo6r9LutOkFm0qhl0KtY=; 
 b=mYncnfuIewyAq7HJBfTX7CP2D2yhJ/oQuPz/WIc9fb/lQZuVbIEvBawWdkTLNkPlOGQtbFzStYkB/UGMLU+m1YEcGd0rEehWfG4aMSF9WDDFu9IX3SoZrweO/4nA6EzL5Z/FgYLJr72p6P0hYhWhvBVSH8O76+s+hdJTeL3LU6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585858505345216.2162909464929;
 Thu, 2 Apr 2020 13:15:05 -0700 (PDT)
In-Reply-To: <20200402182848.GA3023@simran-Inspiron-5558>
Subject: Re: [PATCH v3] qobject: json-streamer: Change bracket_count to
 brace_count
Message-ID: <158585850434.23425.10565789324152977573@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: singhalsimran0@gmail.com
Date: Thu, 2 Apr 2020 13:15:05 -0700 (PDT)
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
Cc: stefanha@gmail.com, jusual@mail.ru, qemu-devel@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMjE4Mjg0OC5HQTMw
MjNAc2ltcmFuLUluc3Bpcm9uLTU1NTgvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxk
IHRlc3Qgb24gRnJlZUJTRCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxs
IGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0
byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIK
IyBicmFuY2gKaWYgcWVtdS1zeXN0ZW0teDg2XzY0IC0taGVscCA+L2Rldi9udWxsIDI+JjE7IHRo
ZW4KICBRRU1VPXFlbXUtc3lzdGVtLXg4Nl82NAplbGlmIC91c3IvbGliZXhlYy9xZW11LWt2bSAt
LWhlbHAgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgUUVNVT0vdXNyL2xpYmV4ZWMvcWVtdS1rdm0K
ZWxzZQogIGV4aXQgMQpmaQptYWtlIHZtLWJ1aWxkLWZyZWVic2QgSj0yMSBRRU1VPSRRRU1VCmV4
aXQgMAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQwMjE4Mjg0OC5HQTMwMjNAc2ltcmFu
LUluc3Bpcm9uLTU1NTgvdGVzdGluZy5GcmVlQlNELz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

