Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55E0C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0B02075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0B02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYTzB-0007WH-SP
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 07:21:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYTyJ-000710-14
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYTyI-0006IX-47
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:20:47 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hYTyH-00062I-RB
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:20:46 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1Mz9pT-1gcPaV3Sxn-00wEj1; Wed, 05 Jun 2019 13:15:36 +0200
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190604203351.27778-1-richard.henderson@linaro.org>
	<20190604203351.27778-17-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <2ec5f1d4-85df-6087-679d-d84aae12f03c@vivier.eu>
Date: Wed, 5 Jun 2019 13:15:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604203351.27778-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IvEvcXryEquxf3yl8SXZ1LKejyu9ZTqa9OCtPfacWdaj/qBMZS5
	1YOVj4Xe5SECjPAOg8owlYQ4CVELE696FzhQRHeKIzP2cFoHzBTsyQhDOgD0Ef+zmuq4U8T
	5dLmdC6YOvMcfyJLPqeG65VQUXnX5qyQKkkOdTL4xoO+OUXpx118t2/YF8x+u1mRE/+FVqR
	RSsdgsM7tOBC7nQmls8hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ft/GGXHjlYQ=:NmIwyiuGP2Kwi4C56mDgYz
	HagCiFpkPqU+IbEsc7+08bJRDMPHf/5bm1Q4OOdRMG3vq6Z/NxLQP2GVy6oCM5vKNaLphuLdZ
	mscwthvazfCkRbG4OeYQ2/g6gmAtkdHGHbsTC7HpPd1ioEmkICB40WR9ZYyDUzwtgDRCsTWUy
	up5ApmvrgVM47bI4WUyJdfrMIZS4GeQZClH20WGXO2ucKTPq3R2lckZEMDLt4twbCJt2cD5uZ
	uNM3KnFrzuF6o8bsg4wzgouuI0zZEZkJ/eVvZhvoPAzaQeqYKrGsMzYtBveNs/kd5E7T2zBLE
	gPTqxjy5JMxFrPRGQCYeMeJzteMzM6kJJ1QSUB258UsZPDWlXe9gdq754i1I6MCNigagHcz+4
	oaAk+iwrwHlwV/svYJFBjSjfMVs7e7CuwI+8hg+Raag3BmdPk+dIQYxIpTi64z+Nxu9BPg7M0
	vp6B2Ak0xDooX89slboel0SmGuld+ljzBzmZmgKjXnOXeahvhSec1KWKdsmhzlGQ6ozY+hTfO
	IaUmqy0BmxR9+1PUJr86xYGXDm6J1J8/n4J3I0Y9SzolwcWMLhmM08Qo6+Iiu3ndH0IoGsqd6
	avXvQodS66UcC9/hN7SaWt2/eZhy5H5VlLFK/APpgB2hq/usDfOLNoOYsoWajJtQXfRqOnips
	c8RwZ3rkOcajQ28g0d1IqnBjeK5anNINyhD3QSmkDJ0kFaaswKGZ9bbUJjJiw2Y5yurZ/uXbg
	nKsY3hBIH82CYV2tgeyaihR4n1IniXlxY/WYM76QIudZdzzSUWh2wIIKMK+XmkyiSsMsZiw1f
	aMOxiNhxsKsmST5SXHI25W/Neo0Ww==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH v4 16/39] target/m68k: Use env_cpu,
 env_archcpu
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/06/2019 à 22:33, Richard Henderson a écrit :
> Cleanup in the boilerplate that each target must define.
> Replace m68k_env_get_cpu with env_archcpu.  The combination
> CPU(m68k_env_get_cpu) should have used ENV_GET_CPU to begin;
> use env_cpu now.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/m68k/target_cpu.h |  2 +-
>  target/m68k/cpu.h            |  5 -----
>  linux-user/m68k-sim.c        |  3 +--
>  linux-user/m68k/cpu_loop.c   |  2 +-
>  target/m68k/helper.c         | 33 ++++++++++++---------------------
>  target/m68k/m68k-semi.c      |  4 ++--
>  target/m68k/op_helper.c      | 12 ++++++------
>  target/m68k/translate.c      |  4 +---
>  8 files changed, 24 insertions(+), 41 deletions(-)
> 

There is no use of env_archcpu() in this patch, perhaps the comment can
be updated.

Acked-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent


