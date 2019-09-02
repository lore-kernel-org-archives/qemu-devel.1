Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE27C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 08:24:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F385021744
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 08:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F385021744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4hdZ-0005Ls-Vm
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 04:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4hcd-0004pA-PV
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 04:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4hcc-00036E-DN
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 04:23:35 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:43997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i4hcb-0002vL-R1; Mon, 02 Sep 2019 04:23:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04862976|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.222551-0.0564094-0.721039; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03305; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=12; RT=12; SR=0;
 TI=SMTPD_---.FNOJ5Rr_1567412601; 
Received: from 172.16.28.187(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FNOJ5Rr_1567412601)
 by smtp.aliyun-inc.com(10.147.42.241);
 Mon, 02 Sep 2019 16:23:25 +0800
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAEiOBXXofjrY2=sjuMDb9dTV2fk9yUVKnr+qmf+7mg9vki6OCw@mail.gmail.com>
From: liuzhiwei <zhiwei_liu@c-sky.com>
Message-ID: <50e65c74-1bf2-0732-e40e-63b6b30ca18c@c-sky.com>
Date: Mon, 2 Sep 2019 16:17:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEiOBXXofjrY2=sjuMDb9dTV2fk9yUVKnr+qmf+7mg9vki6OCw@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH] RISCV: support riscv vector
 extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, riku.voipio@iki.fi,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, laurent@vivier.eu,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/29 下午10:06, Chih-Min Chao wrote:
> Hi Liuzhiwei,
>
> Some comments:
>      1. vector extension allows flexible implementation. It is better 
> to describe the limitation of current implementation (such as 
> vlen/elen/slen) , supported sections and unsupported features.
Thanks!  All mentioned will be in patch V2.
>      2. there should be cfg.ext_v  to turn on  vector extension from 
> command line
I will add the vector extension to cpu "any".  Is it all right?
>      3. from license
>            It should be   "Copyright  (c) 2019 C-SKY Limited, All 
> rights reserved."  but not  "2011 ~ 2019"
>
> It is huge work wait and thanks for your contribution.
>
> chihmin
>
> On Wed, Aug 28, 2019 at 3:06 PM liuzhiwei <zhiwei_liu@c-sky.com 
> <mailto:zhiwei_liu@c-sky.com>> wrote:
>
>     Change-Id: I3cf891bc400713b95f47ecca82b1bf773f3dcb25
>     Signed-off-by: liuzhiwei <zhiwei_liu@c-sky.com
>     <mailto:zhiwei_liu@c-sky.com>>
>     ---
>      fpu/softfloat.c                         |   119 +
>      include/fpu/softfloat.h                 |     4 +
>      linux-user/riscv/cpu_loop.c             |     8 +-
>      target/riscv/Makefile.objs              |     2 +-
>      target/riscv/cpu.h                      |    30 +
>      target/riscv/cpu_bits.h                 |    15 +
>      target/riscv/cpu_helper.c               |     7 +
>      target/riscv/csr.c                      |    65 +-
>      target/riscv/helper.h                   |   354 +
>      target/riscv/insn32.decode              |   374 +-
>      target/riscv/insn_trans/trans_rvv.inc.c |   484 +
>      target/riscv/translate.c                |     1 +
>      target/riscv/vector_helper.c            | 26563
>     ++++++++++++++++++++++++++++++
>      13 files changed, 28017 insertions(+), 9 deletions(-)
>      create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
>      create mode 100644 target/riscv/vector_helper.c
>
>
