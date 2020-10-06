Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC55C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8195206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tm+H8+Nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8195206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPpm4-0002t0-Qa
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPpdV-0001qw-UO
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:16:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kPpdU-0005Rz-Hj
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 12:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602000980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbvU50KZ6DvG0rDyrLl3m+b/TByAhitB5xpbVpxSNZw=;
 b=Tm+H8+NnbtNI2PRzLkD4UdG9fUKdrWvSZiA1qMFjhY0PMbnkes1c2+B+p9FiXg5CwB8gVR
 2Q5d90uU2WuVmrSz2QbpZREN5aZsXtXLSIza0Vvh5LiMtlZrW42WdTOJrnOw5Ip1plNc4K
 osW3MSDiAAdDy/3Bo1qk03jX0n+Xy50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-udYr28c1OKeeqJWZVOm9Og-1; Tue, 06 Oct 2020 12:16:15 -0400
X-MC-Unique: udYr28c1OKeeqJWZVOm9Og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E3431029D24;
 Tue,  6 Oct 2020 16:16:14 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-197.ams2.redhat.com
 [10.36.113.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 036C67664A;
 Tue,  6 Oct 2020 16:16:05 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201006153636.2383248-1-philmd@redhat.com>
 <20201006153636.2383248-2-philmd@redhat.com>
 <134bbd15-c53c-7686-a36d-f02a81b56e0d@linaro.org>
 <e7348766-7210-23f8-ab4e-b5985c279909@redhat.com>
 <1df30292-4bff-eb71-f8a6-afa05c08ba11@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1e605c9c-f539-7a00-7e2a-e62d84f1d378@redhat.com>
Date: Tue, 6 Oct 2020 18:16:05 +0200
MIME-Version: 1.0
In-Reply-To: <1df30292-4bff-eb71-f8a6-afa05c08ba11@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/06/20 18:08, Philippe Mathieu-Daudé wrote:
> On 10/6/20 6:04 PM, Laszlo Ersek wrote:
>> On 10/06/20 17:51, Richard Henderson wrote:
>>> On 10/6/20 10:36 AM, Philippe Mathieu-Daudé wrote:
>>>> +++ b/hw/nvram/fw_cfg-interface.c
>>>> @@ -0,0 +1,15 @@
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/nvram/fw_cfg.h"
>>>
>>> License boilerplate missing.
>>>
>>> r~
>>>
>>
>> Hrmpf, so easy to forget about that, especially in review :/
> 
> Although easily scriptable if we consider SPDX identifiers...

... Hm, "scripts/checkpatch.pl" already checks for SPDX, but only as an
exception to the ban on "//" comments :) See commit 8d061278d385
("checkpatch: allow SPDX-License-Identifier", 2019-06-03).

Laszlo


