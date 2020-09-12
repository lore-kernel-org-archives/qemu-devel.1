Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BFC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753A6207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 23:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753A6207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHEi5-0005d0-IH
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 19:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kHEhU-00057x-RT; Sat, 12 Sep 2020 19:12:56 -0400
Resent-Date: Sat, 12 Sep 2020 19:12:56 -0400
Resent-Message-Id: <E1kHEhU-00057x-RT@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kHEhS-0007iv-Ko; Sat, 12 Sep 2020 19:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599952361; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YZbGKfgi0zFWWTlhfIigXsqX0dwJJ+FcavJITKpDjyKE6eh2SAhNgPDYuUq1pXCJMS8fu5I2p63vwrhsjgSyRVMgLYMtGxp3l6Y/qUArI7/VtksdoB5NBlYE8U8SqxHw5WztbLpbNIDIp5RlgseiKa7bEVuDNi1UImjN8Bjb7kY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599952361;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=EIKtIxgjLI2eeqkd+AHkApGSi7N8xNZFH7piX/Zw+RY=; 
 b=Z5oqkxzzmpCqC4Rgbi2PCT7jpgpSCHsF4e2ho55QQlIFnQATMsLKDoJ+/MUVB/E3DiLBIf/pvmTeLJkxC1ED4eGSfR9B3UtsiSTlo+EXlpOv4JiHH8Ep4Cwm0NhCAKT9Wh4SHdCcGTogZSieR4PcQRsuE2Y3bxAXIjbnMMQLfgE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599952359378993.6626980469503;
 Sat, 12 Sep 2020 16:12:39 -0700 (PDT)
Subject: Re: [PATCH v2 00/15] hw/block/nvme: Support Namespace Types and Zoned
 Namespace Command Set
Message-ID: <159995235761.32613.15025608201008649356@66eaa9a8a123>
In-Reply-To: <20200912225430.1772-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dmitry.fomichev@wdc.com
Date: Sat, 12 Sep 2020 16:12:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 19:07:14
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
Cc: fam@euphon.net, kwolf@redhat.com, damien.lemoal@wdc.com,
 qemu-block@nongnu.org, niklas.cassel@wdc.com, dmitry.fomichev@wdc.com,
 k.jensen@samsung.com, qemu-devel@nongnu.org, alistair.francis@wdc.com,
 kbusch@kernel.org, philmd@redhat.com, mlevitsky@redhat.com,
 matias.bjorling@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxMjIyNTQzMC4xNzcy
LTEtZG1pdHJ5LmZvbWljaGV2QHdkYy5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk4vQS4gSW50ZXJuYWwgZXJyb3Igd2hpbGUgcmVhZGluZyBsb2cgZmls
ZQoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dz
LzIwMjAwOTEyMjI1NDMwLjE3NzItMS1kbWl0cnkuZm9taWNoZXZAd2RjLmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

