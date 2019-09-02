Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603F3C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 07:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B07521881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 07:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B07521881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4gLA-0007Al-Ae
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 03:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4gKM-0006gQ-Kz
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 03:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4gKI-00033u-C6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 03:00:36 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i4gKG-0002us-JP; Mon, 02 Sep 2019 03:00:32 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08657701|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.037772-0.00142417-0.960804; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03267; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=13; RT=13; SR=0;
 TI=SMTPD_---.FNL1kpD_1567407618; 
Received: from 172.16.28.187(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FNL1kpD_1567407618)
 by smtp.aliyun-inc.com(10.147.41.138);
 Mon, 02 Sep 2019 15:00:21 +0800
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair23@gmail.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAKmqyKMDmaABGWyLZD2R-4J8=jM6hry6Bfmu498+UZzQtxsTMA@mail.gmail.com>
 <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
 <dbea4015-fcfa-e223-cb6a-bf5dee270912@linaro.org>
From: liuzhiwei <zhiwei_liu@c-sky.com>
Message-ID: <2c94fc5b-1637-949d-3fc7-7e9da29523d9@c-sky.com>
Date: Mon, 2 Sep 2019 14:54:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <dbea4015-fcfa-e223-cb6a-bf5dee270912@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/29 下午11:14, Richard Henderson wrote:
> On 8/29/19 5:00 AM, liuzhiwei wrote:
>> Maybe there is some better test method or some forced test cases in QEMU. Could
>> you give me some advice for testing?
> If you have hardware, or another simulator, RISU is very good
> for testing these sorts of things.
>
> See https://git.linaro.org/people/pmaydell/risu.git
>
> You'll need to write new support for RISC-V, but it's not hard
> and we can help out with that.
>
>
> r~
>
Hi, Richard

Thank you for your advice.  I will run test cases in Spike for cross 
validation at first.

Best Regards,
Zhiwei



