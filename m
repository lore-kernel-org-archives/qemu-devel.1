Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D40C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884292086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884292086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadMY-00083s-JP
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iad5M-0002WK-4l
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iad5H-0007dp-0R
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:01:09 -0500
Resent-Date: Fri, 29 Nov 2019 05:01:09 -0500
Resent-Message-Id: <E1iad5H-0007dp-0R@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iad5G-0007aE-KQ; Fri, 29 Nov 2019 05:01:06 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575021651; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oC0dfWd5ouv04Ulh6+8aH4HSTxgmEOmBnM0zhD+QyVFxYVPohAwFJj0TJ+CfPDSjuke8/MQmaNDlDKpsyc5fuXBZEoxNbwO/3sEOpY7iAYRJp40YkCoCdutk6JMnFrpp9HkKIJd02054BitVLUngktmkxm73pcQyQNyVQMRDx54=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575021651;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lmC0ekj7FHp3rlil9w2RXyIsGDpnc7kdLalFg5kimLw=; 
 b=RZCBlYMq778KVcJBVWElHGVZzOUumdJDxipDyYG4j/19v/ybTOgkM72J0aGQvEUa3aIkdcXCl0A1g11JqWWr+dTRVl7W9qKI3olfWTuRmuWpamCNnM2aubM0fiW5eFu6BlmxapAjh455VuGaeGNfYEy++k6hYLfT27ugwRB4eOI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157502165060666.5327089328598;
 Fri, 29 Nov 2019 02:00:50 -0800 (PST)
In-Reply-To: <2b7a42487a5d4a258062bd209a0d13fa@SVR-IES-MBX-03.mgc.mentorg.com>
Subject: Re: RE: [PATCH] Updating the GEM MAC IP to properly filter out the
 multicast addresses
Message-ID: <157502164943.26997.4420518369702620170@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Bilal_Wasim@mentor.com
Date: Fri, 29 Nov 2019 02:00:50 -0800 (PST)
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
Cc: edgar.iglesias@gmail.com, alistair@alistair23.me, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yYjdhNDI0ODdhNWQ0YTI1ODA2
MmJkMjA5YTBkMTNmYUBTVlItSUVTLU1CWC0wMy5tZ2MubWVudG9yZy5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFJFOiBbUEFUQ0hdIFVw
ZGF0aW5nIHRoZSBHRU0gTUFDIElQIHRvIHByb3Blcmx5IGZpbHRlciBvdXQgdGhlIG11bHRpY2Fz
dCBhZGRyZXNzZXMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDJiN2E0MjQ4N2E1ZDRhMjU4MDYy
YmQyMDlhMGQxM2ZhQFNWUi1JRVMtTUJYLTAzLm1nYy5tZW50b3JnLmNvbQoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
ZGE2MjdmMiBVcGRhdGluZyB0aGUgR0VNIE1BQyBJUCB0byBwcm9wZXJseSBmaWx0ZXIgb3V0IHRo
ZSBtdWx0aWNhc3QgYWRkcmVzc2VzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogbGluZSBv
dmVyIDkwIGNoYXJhY3RlcnMKIzM2OiBGSUxFOiBody9uZXQvY2FkZW5jZV9nZW0uYzozMTk6Cisv
KiBJRUVFIGhhcyBzcGVjaWZpZWQgdGhhdCB0aGUgbW9zdCBzaWduaWZpY2FudCBiaXQgb2YgdGhl
IG1vc3Qgc2lnbmlmaWNhbnQgYnl0ZSBiZSB1c2VkIGZvcgoKV0FSTklORzogQmxvY2sgY29tbWVu
dHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzM2OiBGSUxFOiBody9uZXQv
Y2FkZW5jZV9nZW0uYzozMTk6CisvKiBJRUVFIGhhcyBzcGVjaWZpZWQgdGhhdCB0aGUgbW9zdCBz
aWduaWZpY2FudCBiaXQgb2YgdGhlIG1vc3Qgc2lnbmlmaWNhbnQgYnl0ZSBiZSB1c2VkIGZvcgoK
V0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgdHJhaWxpbmcgKi8gb24gYSBzZXBhcmF0ZSBs
aW5lCiMzODogRklMRTogaHcvbmV0L2NhZGVuY2VfZ2VtLmM6MzIxOgorICogSWYgaXRzIGEgMSwg
dGhhdCBtZWFucyBtdWx0aWNhc3QsIDAgbWVhbnMgdW5pY2FzdC4gICAqLwoKdG90YWw6IDEgZXJy
b3JzLCAyIHdhcm5pbmdzLCA1NCBsaW5lcyBjaGVja2VkCgpDb21taXQgZGE2MjdmMmEyY2I1IChV
cGRhdGluZyB0aGUgR0VNIE1BQyBJUCB0byBwcm9wZXJseSBmaWx0ZXIgb3V0IHRoZSBtdWx0aWNh
c3QgYWRkcmVzc2VzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yYjdhNDI0ODdhNWQ0YTI1ODA2MmJk
MjA5YTBkMTNmYUBTVlItSUVTLU1CWC0wMy5tZ2MubWVudG9yZy5jb20vdGVzdGluZy5jaGVja3Bh
dGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


