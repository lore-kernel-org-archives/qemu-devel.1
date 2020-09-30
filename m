Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28711C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F012076B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F012076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdPm-0006XL-DX
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 10:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kNdOJ-0005jY-D8; Wed, 30 Sep 2020 10:47:37 -0400
Resent-Date: Wed, 30 Sep 2020 10:47:35 -0400
Resent-Message-Id: <E1kNdOJ-0005jY-D8@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kNdOE-0003e5-Pl; Wed, 30 Sep 2020 10:47:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601477238; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DnjoN7nBp+vkOHozV5rtQPXrZ5mhJnYO1wDjRFyK+mftBSjnQHaEGZ3P9T2Snos9sSsqa3q49yjzBocLKVKzV3Mv/srBYeGMzBm4I+NEfyapy/oqXK2AgyrCtey5rem/12m71qyNnv/usTnPyQx3gOm9Lasaewlxbc7dCnT4JAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601477238;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=0zB4RF5fZA5uIV9tvt4kQs/ghIId2HHvcnauqcwM0H4=; 
 b=h9apgsHz7C+suvdaL7YXSB2Nj3OefD/Jb2JzQjKtrzEVVJzOsLbjZH2VMA1OlCFiJ/Q09iFB6w7MmKkCeqsPjeJzSEp4mngLvcsG7HaNGNHlW3RmjlVtRrrBGZLSBCJGBMDy/qAfVdT9W7Cpd02feyBLLp8KDxBMp1vcNsC1ayE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601477237119370.4315546986014;
 Wed, 30 Sep 2020 07:47:17 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/block/m25p80: Fix Numonyx flash dummy cycle
 register behavior
Message-ID: <160147723474.8147.174177879064026797@66eaa9a8a123>
In-Reply-To: <1601425716-204629-1-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: joe.komlodi@xilinx.com
Date: Wed, 30 Sep 2020 07:47:17 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 10:47:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.373, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alistair@alistair23.me,
 qemu-devel@nongnu.org, mreitz@redhat.com, francisco.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAxNDI1NzE2LTIwNDYyOS0x
LWdpdC1zZW5kLWVtYWlsLWtvbWxvZGlAeGlsaW54LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTi9BLiBJbnRlcm5hbCBlcnJvciB3aGlsZSByZWFkaW5n
IGxvZyBmaWxlCgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMTYwMTQyNTcxNi0yMDQ2MjktMS1naXQtc2VuZC1lbWFpbC1rb21sb2RpQHhpbGlu
eC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

