Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B68C06510
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2ADD208E4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 08:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2ADD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48855 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhs37-0001pD-Ek
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 04:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hhs25-0001Qd-Iz
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hhs24-00087l-IL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:51:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33803)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hhs24-00086a-91
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 04:51:28 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M7rxE-1he2Y23VRa-004yGu; Mon, 01 Jul 2019 10:51:17 +0200
To: qemu-devel@nongnu.org
References: <20190626150855.27446-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <041ca9a5-d62f-5671-e860-d2a438f7a99e@vivier.eu>
Date: Mon, 1 Jul 2019 10:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626150855.27446-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JdiXKVSkC2LsdZvMMmyii0abO/LQ/XfP8dcMCe/xhmheDi2AJwn
 9YbsA8VQ3wRLFrYvFF8n37/S2KX2X5rustiD6Nuq5Fpsnu+mcfHC7RWc99Lbvj3sSZSsOPP
 Dud415ql1AuMgImV/B9UuI2ctVk4cmCz1Lz9hWjMnMpFcrmd/rEUyHrhCSGoOcwYidRkgUf
 IxUJw1GvqO+N3Sih9p5Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YHiVZikIPUw=:sVz8IKYcM0tplT37mUJwrH
 YBUctv5Ubz/XsJM1s12RQsIp7xb20mrjT1ry9gLMwmRO/JDX/yQ1owud/3Xnh2hvJgMk50RsX
 4+xmjVgi09jQyZsjipy9g3BBA67M7SBp94V/WA59QeGNMQMyjvd//TtO1pe62+UvoZNAHxjRs
 CBtLwf5CESPum1c7F+fEzI8A8Funfh47RBjL7gpOIzWOZEtXKSdjhSzfDDFD5sbr2Jy9HmDG7
 eIr6A1h11EW4cr97p/53lIc16amz1PT+jjBLy+mqXGyGA0PTZak7E6brJtakFBPP40k7JxVkx
 LF3VxwFhxRy4NrrcqzKTjK+q5boqUaJj4I5GeYwTzmq/aLhgTCegJKZjxI50ntUImUI8I55Ix
 RrBEucnWWsCt7bmouWrkuPgDz+zGf32K8EbnFY7gdLjvM4XYxMQOnBghWUPc5JuIAGWz5roZs
 oo76hPUYoCbTtmX0Vul33fOY5UT3/K15QeFvL8WN8S/8Fntd6NefIoSRTp8hN6DBQ8nv9tO2l
 8S22WIUoMYl4498XNlMIsUX1T2Q4K7BHM5UL75/1LWlo6jp+FJvp9NzTEes61mg+hubI8qqUw
 Ajcjv2pbe0RyT0Um1cQ6QHaqBUEMnPllYyJUCHMf8p4DHWehgM1oGsNJWwqAf06UJTd0dCtn5
 CzXuoLFTGiAuZi/JWEH6vn6IuTvsu9UxlkzCzPGCReQ6IkAUzto5cL182MpfQcgkyxZ2odKIn
 rbafEmhkmValO4aHjfnSeoU51L7xYqBbZxS8Mb9mwFJfpexCj8W9pcgLawQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [PATCH] linux-user: move
 QEMU_IFLA_BR_MULTI_BOOLOPT to the good function
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/06/2019 à 17:08, Laurent Vivier a écrit :
> QEMU_IFLA_BR_MULTI_BOOLOPT has been added to the wrong function
> host_to_target_slave_data_bridge_nlattr(). Move it to
> host_to_target_data_bridge_nlattr().
> 
> This fixes following error:
>   Unknown QEMU_IFLA_BR type 46
> 
> Fixes: 61b463fbf6cb ("linux-user: add new netlink types")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/fd-trans.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index 612819c1b1ec..60077ce5319d 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -483,6 +483,12 @@ static abi_long host_to_target_data_bridge_nlattr(struct nlattr *nlattr,
>      case QEMU_IFLA_BR_ROOT_ID:
>      case QEMU_IFLA_BR_BRIDGE_ID:
>          break;
> +    /* br_boolopt_multi { uint32_t, uint32_t } */
> +    case QEMU_IFLA_BR_MULTI_BOOLOPT:
> +        u32 = NLA_DATA(nlattr);
> +        u32[0] = tswap32(u32[0]); /* optval */
> +        u32[1] = tswap32(u32[1]); /* optmask */
> +        break;
>      default:
>          gemu_log("Unknown QEMU_IFLA_BR type %d\n", nlattr->nla_type);
>          break;
> @@ -546,12 +552,6 @@ static abi_long host_to_target_slave_data_bridge_nlattr(struct nlattr *nlattr,
>      case QEMU_IFLA_BRPORT_ROOT_ID:
>      case QEMU_IFLA_BRPORT_BRIDGE_ID:
>          break;
> -    /* br_boolopt_multi { uint32_t, uint32_t } */
> -    case QEMU_IFLA_BR_MULTI_BOOLOPT:
> -        u32 = NLA_DATA(nlattr);
> -        u32[0] = tswap32(u32[0]); /* optval */
> -        u32[1] = tswap32(u32[1]); /* optmask */
> -        break;
>      default:
>          gemu_log("Unknown QEMU_IFLA_BRPORT type %d\n", nlattr->nla_type);
>          break;
> 

Applied to my linux-user branch.

Thanks,
Laurent


