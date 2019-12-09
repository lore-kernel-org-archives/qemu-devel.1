Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD02C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612B0205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612B0205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieODU-0000D3-Ax
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieO6j-0000YV-EO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieO6h-0005zB-VV
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:50:09 -0500
Resent-Date: Mon, 09 Dec 2019 13:50:09 -0500
Resent-Message-Id: <E1ieO6h-0005zB-VV@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieO6h-0005wB-Na
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:50:07 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575917392; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V98KN0t2WKNFb1Zr5Ah2IM+39LwRAHnIuUwl5V78N3n58qI36FfNth45WeNWbXUJm+7wuhji20qIrx+qScDjKveVRIU1nuTC5/B2/4CnizZOvzNZDOOb7EiMp/dKSuHdJKogv2tgJwm3uwPKbQhRJ8WguqDJS03hdaeF/loZiew=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575917392;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NGGBVe99txQfOsq9cZq1irlEdHWrvh+3aiYwy3FvxE4=; 
 b=DRNYiZnpzcpWxmx9KQ7AeM1BAR+D97qRPj6saMygJkHoqWRGVqUd8E7K6XKe6wddquQ+Wxd2/OaQCst20pZYYCinIfPoMKgDoz/K29yG440ZL35YQO0OT8wz80nZfp3gnU5263+VONsNw0Gxwr1NDBVC8KSneUKeVYDODumCAEk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575917391331182.37874226413294;
 Mon, 9 Dec 2019 10:49:51 -0800 (PST)
In-Reply-To: <20191209095002.32194-1-philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 v3 0/6] hw/pci-host: Add Kconfig selector for IGD
 PCIe pass-through
Message-ID: <157591738957.7675.17320249356246930041@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Mon, 9 Dec 2019 10:49:51 -0800 (PST)
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
Cc: thuth@redhat.com, sstabellini@kernel.org, paul@xen.org, mst@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com,
 xen-devel@lists.xenproject.org, anthony.perard@citrix.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwOTA5NTAwMi4zMjE5
NC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWlt
YWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN1Ym1vZHVsZSAnZHRj
JyAoaHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L2R0Yy5naXQpIHJlZ2lzdGVyZWQgZm9yIHBhdGgg
J2R0YycKQ2xvbmluZyBpbnRvICdkdGMnLi4uCnJlbW90ZTogQ291bnRpbmcgb2JqZWN0czogNTI4
MCwgZG9uZS4gICAgICAgIAplcnJvcjogUlBDIGZhaWxlZDsgcmVzdWx0PTE4LCBIVFRQIGNvZGUg
PSAyMDAKZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBlY3RlZGx5CmZhdGFsOiBw
cm90b2NvbCBlcnJvcjogYmFkIHBhY2sgaGVhZGVyCkNsb25lIG9mICdodHRwczovL2dpdC5xZW11
Lm9yZy9naXQvZHRjLmdpdCcgaW50byBzdWJtb2R1bGUgcGF0aCAnZHRjJyBmYWlsZWQKZmFpbGVk
IHRvIHVwZGF0ZSBzdWJtb2R1bGUgZHRjClN1Ym1vZHVsZSAnZHRjJyAoaHR0cHM6Ly9naXQucWVt
dS5vcmcvZ2l0L2R0Yy5naXQpIHVucmVnaXN0ZXJlZCBmb3IgcGF0aCAnZHRjJwptYWtlWzFdOiAq
KiogWy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC13NHc4bGkxdS9zcmMvZG9ja2VyLXNyYy4y
MDE5LTEyLTA5LTEzLjQ0LjMyLjExOTM0XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdzR3OGxpMXUvc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNW0xNy44MTNz
CnVzZXIgICAgMG0yLjQ3MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9w
YXRjaGV3Lm9yZy9sb2dzLzIwMTkxMjA5MDk1MDAyLjMyMTk0LTEtcGhpbG1kQHJlZGhhdC5jb20v
dGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


