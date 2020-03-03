Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3959C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C73E20863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C73E20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94Wf-00006e-QH
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j94Vb-0007Ai-3t
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j94VZ-00062n-Kg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:10:38 -0500
Resent-Date: Tue, 03 Mar 2020 05:10:38 -0500
Resent-Message-Id: <E1j94VZ-00062n-Kg@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j94VZ-00062G-CV; Tue, 03 Mar 2020 05:10:37 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583230154; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hF05EEDZ/R/RRCiWySf+ahfHfJVv0aSgb8m+jgmudZPbHpwWXUncuFooyiccbKQerxJ9cMKbuWULi32cXZcJRZsu5F6ZKyzDNXZC53Rr3X7urg4Am9XLjIPZ7+HdCurKF/b+iwcxXu22bGCv3AdR8PtE1ormIWr1uFu3m11Pwko=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583230154;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7cRha4H6zR8EzAsY+tgWYdZgtgoXcQBzPnkrUERbfWU=; 
 b=bGd2zPP0cR6br5+F/fqdbLoWgG9RmdT9qN0S7Mmk/ort2wRXm33ww5nLvLg6FfYyTb5lo3Bk9ymFWMZ5DlT9kEHQ66zFolUTgDpdT3yT2AIL+eeyNvbR6qUnlHMSzmh2S54kOda+URZO4oqrc6zDe65zLg2EiFXLLTi4KATUI5w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583230151847454.90347562379486;
 Tue, 3 Mar 2020 02:09:11 -0800 (PST)
In-Reply-To: <20200303100511.5498-1-peter.maydell@linaro.org>
Subject: Re: [PATCH] cpu: Use DeviceClass reset instead of a special CPUClass
 reset
Message-ID: <158323014888.8962.13276626887115773596@abdcc9e1aa82>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Tue, 3 Mar 2020 02:09:11 -0800 (PST)
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
Cc: crwulff@gmail.com, sagark@eecs.berkeley.edu, david@redhat.com,
 green@moxielogic.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 jcmvbkbc@gmail.com, Alistair.Francis@wdc.com, edgar.iglesias@gmail.com,
 marex@denx.de, palmer@dabbelt.com, aleksandar.rikalo@rt-rk.com,
 rth@twiddle.net, atar4qemu@gmail.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, shorne@gmail.com,
 david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 michael@walle.cc, qemu-ppc@nongnu.org, amarkovic@wavecomp.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwMzEwMDUxMS41NDk4
LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9j
a2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMDMx
MDA1MTEuNTQ5OC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy90ZXN0aW5nLmRvY2tlci1taW5n
d0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

