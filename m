Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FE5C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 21:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD87A206D8
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 21:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD87A206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzRMg-0000SW-1u
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 17:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jzRLc-0007vd-M8; Sat, 25 Jul 2020 17:04:48 -0400
Resent-Date: Sat, 25 Jul 2020 17:04:48 -0400
Resent-Message-Id: <E1jzRLc-0007vd-M8@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jzRLa-0005e3-JC; Sat, 25 Jul 2020 17:04:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1595711070; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hXIzdyg0F4femJHUPizA1DGUdgFmYPxyLIQge0lrowdoZULc54i4NS3+7t6x3NR2mE7Co/3C8nOIaUUYCgIDxPObA9fI3zgcYdXxbGPEs+EzjwN4j/GZpg5tcBtBSDgwjDE/zhhAq/BjRnJB6ov6SD/K3rfTjQ/p3T8LlXZ4JWc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1595711070;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1QbnIIm1eaEALOvqpv1GJurDFSoN7c1tFKKDOja+M/0=; 
 b=IWSl6n3kceXjfI4uTK8/5X2pzUYRRTB6Uo2DxvJYjR9OE7mpNaKcHygudG3Zlx2tQT0QfJPafYiCjJfyrMT48ArM3L9uXxf/LrStEnORLCCp3SUelKtipHlgrEHTRHvWgTAJNmSKzRPqsBPP0zTVUAZHpYy3kzrjUOxSqVvOt1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1595711066904480.1487423367794;
 Sat, 25 Jul 2020 14:04:26 -0700 (PDT)
Subject: Re: [PATCH] target/ppc: Fix SPE unavailable exception triggering
Message-ID: <159571106573.5803.10225718797605515810@66eaa9a8a123>
In-Reply-To: <20200725191436.31828-1-matthieu.bucchianeri@leostella.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: matthieu.bucchianeri@leostella.com
Date: Sat, 25 Jul 2020 14:04:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 17:04:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 matthieu.bucchianeri@leostella.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcyNTE5MTQzNi4zMTgy
OC0xLW1hdHRoaWV1LmJ1Y2NoaWFuZXJpQGxlb3N0ZWxsYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJp
ZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24gRnJlZUJTRCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0
YWlscyBiZWxvdy4KCgoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDIwMDcyNTE5MTQzNi4zMTgyOC0xLW1hdHRoaWV1LmJ1Y2NoaWFuZXJp
QGxlb3N0ZWxsYS5jb20vdGVzdGluZy5GcmVlQlNELz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

