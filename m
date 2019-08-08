Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6821C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7848321479
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7848321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvf6s-0004IL-OZ
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54441)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hvf68-0003Mk-8i
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1hvf67-0005kE-3U
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:52:40 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1hvf66-0005eZ-OC; Thu, 08 Aug 2019 05:52:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1129829|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.265738-0.0165207-0.717741; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03277; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.F8QE5-D_1565257629; 
Received: from 172.16.28.186(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.F8QE5-D_1565257629)
 by smtp.aliyun-inc.com(10.147.42.16); Thu, 08 Aug 2019 17:47:12 +0800
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
From: liuzhiwei <zhiwei_liu@c-sky.com>
Message-ID: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
Date: Thu, 8 Aug 2019 17:39:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: [Qemu-devel] RISC-V: Vector && DSP Extension
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
Cc: palmer@sifive.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 bastian@mail.uni-paderborn.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

    My workmate  and I have been working on Vector & Dsp extension, and 
I'd like to share develop status  with folks.

    The spec references for  Vector extension is riscv-v-spec-0.7.1, and 
riscv-p-spec-0.5 for DSP extension. The code of vector extension is 
ready and under testing,  the first patch will be sent about two weeks 
later. After that we will forward working on DSP extension, and send the 
first patch in middle  October.

     Could the maintainers  tell me whether the specs referenced are 
appropriate? Is anyone working on these extensions?  I'd like to get 
your status, and maybe discuss questions and work togather.

Best Regards

LIU Zhiwei



