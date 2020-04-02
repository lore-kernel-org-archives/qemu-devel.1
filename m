Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962A5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1D7206E9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 20:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1D7206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK6Gp-0006ql-K7
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 16:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jK6Fq-0005T8-R6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jK6Fp-0002VS-8h
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:58 -0400
Resent-Date: Thu, 02 Apr 2020 16:15:58 -0400
Resent-Message-Id: <E1jK6Fp-0002VS-8h@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jK6Fp-0002V1-1F
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 16:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585858547; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YCuGlasiRHwYoRcmKXCe9edXQc61WWVz5wSEh1/6vGvPHVdpRPX0MIH5Ac6K76SYzq6bbFcz25LUGEx1NwhpYDZmUhcXHbTNnTJlJ8HpfNrOcWLTj+B+jTwTZQGULNh9yTG18YPAKvR3O2U3elJ2fGuPdFD8NQMz7FbjuKPjZp0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585858547;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Coe3SF9P1jb4kjGx65390WMCvxqj9f6ZL8OrAm8UZTU=; 
 b=gJ4iqCV3Jun0DxdinsZsyae+o17EKEEuxn+AW3cNLG4iQVk4swxFIz65drP14g/qM3mx0PkJRghe/g0Kd0eCKolP4SsbseLgyU2Xg09kksJpAFFp/oIJmTRvmMUJq7QO5T1XnHgzzDhcfvO6c1t/FUHBT+BSZbKMNapJAVZc1hM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585858544998688.6962021107939;
 Thu, 2 Apr 2020 13:15:44 -0700 (PDT)
In-Reply-To: <20200402182848.GA3023@simran-Inspiron-5558>
Subject: Re: [PATCH v3] qobject: json-streamer: Change bracket_count to
 brace_count
Message-ID: <158585854437.23425.480039564390151225@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: singhalsimran0@gmail.com
Date: Thu, 2 Apr 2020 13:15:44 -0700 (PDT)
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
MjNAc2ltcmFuLUluc3Bpcm9uLTU1NTgvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2M10gcW9iamVjdDoganNvbi1zdHJlYW1lcjog
Q2hhbmdlIGJyYWNrZXRfY291bnQgdG8gYnJhY2VfY291bnQKTWVzc2FnZS1pZDogMjAyMDA0MDIx
ODI4NDguR0EzMDIzQHNpbXJhbi1JbnNwaXJvbi01NTU4ClR5cGU6IHNlcmllcwoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKZmF0YWw6IHVuYWJsZSB0byBhY2Nlc3MgJ2h0dHBzOi8vZ2l0
aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdS8nOiBUaGUgcmVxdWVzdGVkIFVSTCByZXR1cm5l
ZCBlcnJvcjogNTA0CmVycm9yOiBDb3VsZCBub3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIxNjRk
MWRlZjdmNDRiZDg4ODcxMzM4NApUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAg
RmlsZSAicGF0Y2hldy10ZXN0ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA1MjEsIGluIHRlc3Rf
b25lCiAgICBnaXRfY2xvbmVfcmVwbyhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2Ys
IFRydWUpCiAgRmlsZSAicGF0Y2hldy10ZXN0ZXIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA0OCwg
aW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN0ZG91dD1sb2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIv
b3B0L3JoL3JoLXB5dGhvbjM2L3Jvb3QvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJwcm9jZXNzLnB5
IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihy
ZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ2dp
dCcsICdyZW1vdGUnLCAnYWRkJywgJy1mJywgJy0tbWlycm9yPWZldGNoJywgJzNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEuCgoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0
MDIxODI4NDguR0EzMDIzQHNpbXJhbi1JbnNwaXJvbi01NTU4L3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

