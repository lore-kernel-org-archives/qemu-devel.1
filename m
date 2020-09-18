Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E506FC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69D120874
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69D120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHyF-0006Cy-36
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJHvc-0003hS-QI; Fri, 18 Sep 2020 11:04:00 -0400
Resent-Date: Fri, 18 Sep 2020 11:04:00 -0400
Resent-Message-Id: <E1kJHvc-0003hS-QI@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJHvY-00082t-HZ; Fri, 18 Sep 2020 11:04:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600441419; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U9MTxLcpTF0+cqtj3f1Qld14a9uu/PRDYRg6I7aSZdDf1/ccL52JSy6wvetqHCPWb77D8R1WWuPY4MgJvP2jIXp6g2RekGUy9aGi5JOBo4NUixWqIvAn4l3XQRrUb0xY5GOA03K0qM5zDZGiQr/C/XpQIC8dQZYFwRMSj5cfFGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600441419;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DjWPCci+NtaRCicU4n5yUHwGHIIp7ltJjkpOjvCxXy4=; 
 b=mxevKEHDAfF0tLtERMtQ6Sra5YrrIzSMKJEUtofNc/mHOuo0HMbP92TPENW39WgfBzRdItmiBmG9ugwYX2Dhxc6IXBGlbC+O0wi/ngTrDmMDYBox/+g+dO9Z4WNWDO+qN0/T7YikHA8IX8g6Aqo0VNcTZ1VOfuzP3xV92Ad/2Uc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600441419266113.11221122737277;
 Fri, 18 Sep 2020 08:03:39 -0700 (PDT)
Subject: Re: [PATCH] xen: rework pci_piix3_xen_ide_unplug
Message-ID: <160044141773.8478.11884277035033315344@66eaa9a8a123>
In-Reply-To: <20200918145256.1886250-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Fri, 18 Sep 2020 08:03:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 09:36:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sstabellini@kernel.org, qemu-block@nongnu.org, paul@xen.org,
 qemu-devel@nongnu.org, anthony.perard@citrix.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxODE0NTI1Ni4xODg2
MjUwLTEtYW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKTi9BLiBJbnRlcm5hbCBlcnJvciB3aGlsZSByZWFkaW5nIGxv
ZyBmaWxlCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAyMDA5MTgxNDUyNTYuMTg4NjI1MC0xLWFudGhvbnkucGVyYXJkQGNpdHJpeC5jb20v
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

