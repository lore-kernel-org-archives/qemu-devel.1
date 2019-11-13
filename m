Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080A2C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB29222BD
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 10:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB29222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUqKL-0005wy-St
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 05:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUqJG-000523-8B
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUqJF-0007fz-4c
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:55:38 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:58295)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUqJE-0007Xy-Rn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 05:55:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N3K9E-1hm3dr3QEk-010OQk; Wed, 13 Nov 2019 11:55:29 +0100
Subject: Re: [PATCH] enable translating statx syscalls on more arches
To: Andrew Kelley <andrew@ziglang.org>
References: <7fc7a64e-cb52-fab6-5739-807b40be9c1d@ziglang.org>
 <66c80f5a-253a-722b-6f99-4e5b82078d1b@ziglang.org>
 <CAL1e-=iemtSNCyS1O6vfe1QL5EYP5tbKhZPAYJF8YQ4USPMFww@mail.gmail.com>
 <CAL1e-=hf6Z4cdZ-kfY=vg6fXWLX1Vo9R604AvDwxj7rFoXB2Tg@mail.gmail.com>
 <7e108b25-565a-1047-4979-f29b3e930d1c@vivier.eu>
 <CAL1e-=hL1aDmw1q8sApbAyH=oGuzynpcW5M2DAaWV0rZgDtzFw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9debab16-3ea6-60fc-bb17-430c110463a5@vivier.eu>
Date: Wed, 13 Nov 2019 11:55:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hL1aDmw1q8sApbAyH=oGuzynpcW5M2DAaWV0rZgDtzFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nv6JlQmp1yQvLadpqDSNs0fdlHv3wqnHOBRmQE1VSl7GmIK6Pmw
 UYsckKkcEL4ispAK0bHfRIlo5U1rQCiFUKIbhlY4kWaP7fjJeDci7MPsU0myRPh5s4HX5CY
 yh8fkqhz1TKtWN28VPwMNN9O7VLj/pkmYlkfGthHlgMTyxRCTAiGjJIqvKHc7DGUQ/0DxUl
 eoPJmqHr6OjSMXEHUM92Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r7LBulE6GXU=:UOuXoHoLAG29be4dtJK9HX
 eo7pvLHwy5RyEKeefTLlfGXSih3Pr9XT6VVnQy+rDy6DWPWtRGsfCkMI1Its/ylIVcPF+o50z
 WdGDGIH/SU9vxVlXov+5LeK0mRRsLc/8Ptdw2ElQVHuGgTDycTwiFXbgkkP84EQKDOHuoOOuB
 8KcduX3FSr09nJgs3uv2N93Ou1v0Hd4n3JM8uftPo7rzrw5LQV/QtlYPgqdFxTp1WxT6lOTMK
 6kdkS/DnykY+3yyWXfmMXcZhAhy+AADhRmO5v4bhAZqej65SDrADHDsaKdGzrdRkNbItcBkwo
 Y3CYvj04tXmZvSH5hRgHSpoGCmszYjP5C2XFxhOMo2vgowVIGLCMUSvbSeuXRad94g3hg1mGf
 g6lHy1WvIYXR6BL/+HiNw4en2jnyXZir1Y5h0tkZjTLloDB6AbuHpz2wtX3ftSnpnsuw9aTjC
 3ZQtbzX89YT+pwF+nWP+BDym+siIuh1obDowS27RfpbqXjSDhZXXU3jYo2vSg+sA8u83qNdqo
 DSYArznFVnyP4V9eMX/XHt7urEkqzfpdnFhdhuFY1oUbxikhD2/cgL8hTQNGqeVlNNXidncHJ
 TBDmMHj592k6Tzceq87s0xjqPCNNktmeo9rRtcWMOuUsskJnPozOqv24xvPJ+OnvXMeswQv6A
 oljV3U1Vz+fQYWeX7Iar8RkvMq34dCOe0MAEbexFqzZE9TkKVEg5tFYsjKAPxw7OZHCDQM4cq
 K1aSm8+h9fsFFPrsjy5AOX4hjFfdttO683fw5NHYku+Zb04hnVXWkLjcmgp7hSrf/4uS2H594
 TGgdzmYQllKRfAeUA1OXF59Cqey1bZd8GvQhVlU+ecbjaTx23YrxQPZ81g/yBJjmjmwxlaNKh
 C57ZeQLy/ZcS4J7Ku38JxX43D1FwynDdHLmGKinZw=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/11/2019 à 10:55, Aleksandar Markovic a écrit :
> 
> 
> On Tuesday, November 12, 2019, Andrew Kelley <andrew@ziglang.org
> <mailto:andrew@ziglang.org>> wrote:
> 
>     ping
> 
> 
> 
> Hello, Andrew.
> 
> I just want to advise you to send, if possible, a new version of the
> patch, addressing whatt said in his review. It is better if you send it
> sooner rather than later, given the stage of our dev cycle.
> 
> For MIPS parts:
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
> <mailto:amarkovic@wavecomp.com>>
> 

The i386 part breaks the build because it defines TARGET_NR_arch_prctl
and in linux-user/syscall.c we have:

    #ifdef TARGET_NR_arch_prctl
        case TARGET_NR_arch_prctl:
    #if defined(TARGET_I386) && !defined(TARGET_ABI32)
            return do_arch_prctl(cpu_env, arg1, arg2);
    #else
    #error unreachable
    #endif
    #endif

Thanks,
Laurent


