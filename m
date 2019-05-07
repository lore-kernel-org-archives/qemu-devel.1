Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89626C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628AA2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 17:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628AA2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50803 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO4IZ-0006Nc-EM
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 13:54:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hO4GV-0005Jo-ES
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hO4GU-0005Vj-Cu
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:52:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hO4GU-0005V1-7W
	for qemu-devel@nongnu.org; Tue, 07 May 2019 13:52:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so4523447plj.11
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 10:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=cYprQMWktnww3CUSan+0ugetvPRquyZiZq8dJoeUsHE=;
	b=lmogmx4z2ci7oZNmk5oap+Alb6PI8113Ll8wyq3v2rAqtql6Y/sPDH3IvBtMNj7zpC
	io9w5FP5YxOFFMbctH3JDVnNsak7rzNYOZKTQmf0wwHCfbonnHQ2Jxzg4gvsg8cvUHbL
	/oep1o84fHc4RsXqTSqTPozTeOQN0H5ENwrkNhIMz2cTiUNWMdmEFhLSNWtGrQJeI/Pv
	5YmiWkOZ/2bBwkxS/8RRC7xJAnN33f3sdyv0hySk6D2VWzT1lz80BAnDpsysvEIKJovT
	vEWymXrEBMQf2Ru7BG9AoZFEB0ngk2Bm8tnv+7LpS/Zz2vueY90tpKP17Ub9iYD+pmG8
	2qrg==
X-Gm-Message-State: APjAAAWqdJqgO3NAhan+Wq+42wwuJJwyPZ1wcsd/pG00o2z7rlgm7clT
	HJ3YTE26m1KHMVm7uxXzegREDMawuJI=
X-Google-Smtp-Source: APXvYqzRlyo7Sa9ZDMUJv8ycBxHkq2ETTa+Ny+MP/FrKdrsigBL6kr6QNlsqR30MA//UKOSwoVpm+w==
X-Received: by 2002:a17:902:8f93:: with SMTP id
	z19mr34015284plo.108.1557251547998; 
	Tue, 07 May 2019 10:52:27 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	f14sm20340508pgj.24.2019.05.07.10.52.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 07 May 2019 10:52:27 -0700 (PDT)
Date: Tue, 07 May 2019 10:52:27 -0700 (PDT)
X-Google-Original-Date: Tue, 07 May 2019 10:18:29 PDT (-0700)
In-Reply-To: <CANnJOVHd1aFR2tiORJmZ2h3xa+t8djToUEom4WSy=4vBcOjegg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: fintelia@gmail.com
Message-ID: <mhng-29822037-900e-4149-aa85-36cbc1db4972@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [PATCH for 4.1] target/riscv: More accurate
 handling of `sip` CSR
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org, sagark@eecs.berkeley.edu,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06 May 2019 08:52:43 PDT (-0700), fintelia@gmail.com wrote:
> According to the spec, "All bits besides SSIP, USIP, and UEIP in the sip
> register are read-only." Further, if an interrupt is not delegated to mode
> x,
> then "the corresponding bits in xip [...] should appear to be hardwired to
> zero. This patch implements both of those requirements.
>
> Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
> ---
>  target/riscv/csr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 1ec1222da1..fff7d834e8 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -246,6 +246,7 @@ static const target_ulong sstatus_v1_9_mask =
> SSTATUS_SIE | SSTATUS_SPIE |
>  static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>      SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
>      SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
> +static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP |
> MIP_UEIP;
>
>  #if defined(TARGET_RISCV32)
>  static const char valid_vm_1_09[16] = {
> @@ -694,8 +695,10 @@ static int write_sbadaddr(CPURISCVState *env, int
> csrno, target_ulong val)
>  static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
>                     target_ulong new_value, target_ulong write_mask)
>  {
> -    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> -                   write_mask & env->mideleg);
> +    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> +                      write_mask & env->mideleg & sip_writable_mask);
> +    *ret_value &= env->mideleg;
> +    return ret;
>  }
>
>  /* Supervisor Protection and Translation */

This patch (and your previous one) don't apply for me.  I don't see the
git-send-email tags in your messages, are you trying to do something like paste
them into gmail?  If so I think they're getting line wrapped.

