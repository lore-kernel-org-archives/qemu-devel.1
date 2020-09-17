Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441CEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D081D20715
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D081D20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIpFf-0000eJ-WD
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kIp89-0007Xm-6f; Thu, 17 Sep 2020 04:19:01 -0400
Resent-Date: Thu, 17 Sep 2020 04:19:01 -0400
Resent-Message-Id: <E1kIp89-0007Xm-6f@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kIp85-0002QL-2q; Thu, 17 Sep 2020 04:19:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600330720; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VwovdL/NF1rB2i/0GGlrbQaeT1GcJjHT0HqDZqvsICT2qm6orRcRbz5gZwGokejI54/215Eh2T11vmr6+DJvj7CqZhEpHx19jCX3t/k9B8K6knH8rMW2OqZCy3gnpxfmFUeuwPzDoJBQDKSSNfJ5tO7m1F/AB0ALRI+1YCsy808=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600330720;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=QevXtWuQwPhv6vCPy3sGCxGVaGqfRIg2FXrSSC5XvKo=; 
 b=nmq0ja0zfaiBy6ttEfCftuLDV7Y+VVtoDjpIKL4FLkoT+U0daPN3f1OV83vw7SjhIglxJCrxAct0uJJbhOp2VBjhDa90eknoVjQJZthakhx7xVp/aGVLhnVA0M8K2qwPChLF7Ln3Mcrw76KfyVSJykMQuXgIaLCgKZzDKoBGvIs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600330718964214.50998951796635;
 Thu, 17 Sep 2020 01:18:38 -0700 (PDT)
Subject: Re: [PATCH V3 00/10] fix some comment spelling errors
Message-ID: <160033071783.8478.1753087388976639895@66eaa9a8a123>
In-Reply-To: <20200917075029.313-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: zhaolichang@huawei.com
Date: Thu, 17 Sep 2020 01:18:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 04:18:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, zhaolichang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxNzA3NTAyOS4zMTMt
MS16aGFvbGljaGFuZ0BodWF3ZWkuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWls
ZCB0ZXN0IG9uIEZyZWVCU0QgaG9zdC4gUGxlYXNlIGZpbmQgdGhlIGRldGFpbHMgYmVsb3cuCgoK
CgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAyMDA5MTcwNzUwMjkuMzEzLTEtemhhb2xpY2hhbmdAaHVhd2VpLmNvbS90ZXN0aW5nLkZyZWVC
U0QvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

