Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BDBC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9068206D3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9068206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNT1-0002wt-WA
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieNSQ-0002SR-N0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieNSP-0001GK-Kl
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:08:30 -0500
Resent-Date: Mon, 09 Dec 2019 13:08:30 -0500
Resent-Message-Id: <E1ieNSP-0001GK-Kl@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21011)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieNSM-00016e-NY; Mon, 09 Dec 2019 13:08:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575914889; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HsXj5h8AIKy6NE4Smnwpbs7R+cfnhWGliuxzF1pK137v1oquQT1WQ+nWHJRbF1JIuXlkiOngPxvkAJJgIV1zBs1pZMIgFs58sZp1unqUk0vDEjPs9lr5azzYZUeRhp5dO3ZHnVjPYh+S3pAXFyDcq/yNRzdiRyGLYOtye2FtOQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575914889;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=sBGymazN6YGgs8S/9gdg1z7hpxoAy0Uf5Qvfwh8MYww=; 
 b=LKbjVFHF1xFYBXDreZlrcQTIWQllPG93g2HkmZ1jhVuqT4NdizRoqQLrN0/pqn0yW+2p9hzyb2k0yuuiDGtKDA2x4Q4l+jxvaDKH71ravNU3V014mT+hh8XL3uOgjzemc8bXaGwWIilrynlgrr8WBCkaTRXeVZkGq5wuoR9Jbgo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575914889156384.82932510369983;
 Mon, 9 Dec 2019 10:08:09 -0800 (PST)
In-Reply-To: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
Subject: Re: [for-5.0 PATCH] ppc: Make PPCVirtualHypervisor an incomplete type
Message-ID: <157591488816.7675.17244780792824596591@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: groug@kaod.org
Date: Mon, 9 Dec 2019 10:08:09 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc1ODk4MDgwNDEuMjExODIu
MTgxMjE2NTU5NTkxMTUwMTEzNTMuc3RnaXRAYmFoaWEubGFuLwoKCgpIaSwKClRoaXMgc2VyaWVz
IGZhaWxlZCB0aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0
aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBE
b2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoK
PT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0
Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXIt
dGVzdC1taW5nd0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClN1Ym1vZHVsZSAnZHRjJyAoaHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L2R0Yy5naXQpIHJlZ2lz
dGVyZWQgZm9yIHBhdGggJ2R0YycKQ2xvbmluZyBpbnRvICdkdGMnLi4uCnJlbW90ZTogQ291bnRp
bmcgb2JqZWN0czogNTI4MCwgZG9uZS4gICAgICAgIAplcnJvcjogUlBDIGZhaWxlZDsgcmVzdWx0
PTE4LCBIVFRQIGNvZGUgPSAyMDAKZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBl
Y3RlZGx5CmZhdGFsOiBwcm90b2NvbCBlcnJvcjogYmFkIHBhY2sgaGVhZGVyCkNsb25lIG9mICdo
dHRwczovL2dpdC5xZW11Lm9yZy9naXQvZHRjLmdpdCcgaW50byBzdWJtb2R1bGUgcGF0aCAnZHRj
JyBmYWlsZWQKZmFpbGVkIHRvIHVwZGF0ZSBzdWJtb2R1bGUgZHRjClN1Ym1vZHVsZSAnZHRjJyAo
aHR0cHM6Ly9naXQucWVtdS5vcmcvZ2l0L2R0Yy5naXQpIHVucmVnaXN0ZXJlZCBmb3IgcGF0aCAn
ZHRjJwptYWtlWzFdOiAqKiogWy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1vNmY4d3JfZi9z
cmMvZG9ja2VyLXNyYy4yMDE5LTEyLTA5LTEzLjAzLjUyLjEyNjU1XSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbzZmOHdyX2Yv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJl
YWwgICAgNG0xNi43MDhzCnVzZXIgICAgMG0yLjUzMHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1NzU4OTgwODA0MS4yMTE4Mi4xODEyMTY1
NTk1OTExNTAxMTM1My5zdGdpdEBiYWhpYS5sYW4vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3Jh
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


