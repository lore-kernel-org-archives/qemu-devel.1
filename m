Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42914CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A0B2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A0B2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUEM-0001XW-76
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMUCl-0008Dn-KV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMUCk-0001a2-2p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:42:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMUCj-0001Zi-Pq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:42:22 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M27Bp-1iK0AC1d1t-002ZyG; Mon, 21 Oct 2019 11:42:09 +0200
Subject: Re: [PATCH v7 4/9] linux-user/syscall: Introduce target_sockaddr_nl
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190915213924.22223-1-f4bug@amsat.org>
 <20190915213924.22223-5-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f1beaa1c-8cbf-7e22-a612-8881ffaf00b5@vivier.eu>
Date: Mon, 21 Oct 2019 11:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190915213924.22223-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GCuTiymO/cKIfFRqyElk7uWc2sZ9uIMoJ5x25muejFXdf45CG3n
 aPC+yBiZGxRiFB/HQbL5ESWUMe78zo1KrG++k1GMNYJDzLD8/ICNVO3nvnzbJKbAmkocmLk
 70SucMebPkIOKGf177Q4xoEp8fjeYZBOVHcfkRJx/vkfoixd3zZXq7xJlf3w3DxL36Lyx8I
 hGqY1+rnlhX6KS2cak5wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LcnF701ZLdM=:JeM/4Mvh61cjMpICfd5Tid
 SVCsBen1Tv/aepEdk0dYqMku6IA4paeaJciKEEOvXg84gZYhFgdCPOSwiTQwSeK8qPoPfGvrx
 8rOjNNPmiuSnSqZ6OEGE9jHHY1+6FCRJj2B0PkftNBs3NaFgAAcIQ2lZIGzqu1dJRtttxfvEJ
 sExkza4EnCOMgRAFngxdsUNK6GvS5hrr/3MTu0RtUcg1DIdUClqJdV457wLK4tZVfxdBcTslx
 meRHtRvW+LCcoyL+ndPlChu1OVoU1ynLDjZswQqlL0nuHe6dFj4gB4tzQGhSFtrUCK1sg6KZi
 Ey1nRxHuKFS3BncFJ1CpF6Ob4LIa5FEillVpkpeX6O/2bXJ/0zVLQj+vhliVGJKmXBT/fAe8N
 VXcu51bgFF4nwrPByzue73GWJJiBaZ6IAzZpJJhvVr9Y4qBi9ve4GSYKtYx19XxeaCAmv3l6J
 +dDH8iUIPh5tmOZYt3w/2VaxLyEUYX0mYM//FWzjuhC5CBIg0slkT9HVaCh28soFC4SrdbMni
 97n4e+uyXS/zUbHLBja2ySvumEd5A0nxMSSZkBpOh/rh1zBHoQE6p7gAfpodDxUFyHa8mm5qY
 25AlqIgIvJFw6j3JFXm266exXX2IUAQGyLdDV+S0+b4l92ZbaLNaum3vHYEdYEL+xmPCvjj8C
 fQL7MOsuaFnEVxmlvS3WufKcAeGOvBO18CtNiDSBGMArVsmRSL/piuEtnNkAwFc7pyglfbkT0
 VOuaXleQ2atgLgB+GqZote8ZVyMj5afiq8PGj6VAHN1y5oaupjuBL5+LOHyuaftr1kgx2cLW5
 jUik3H9wIqpOF5MZbXFJA/ORVkffDpzwQzCalpgc7zmD75Fmu0d0Hw7z5EM7EgMsq35doI71n
 ThECnKFyCGOYKXSSe/Fcha0KSSBD7wCSgK2ngDrV8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/09/2019 à 23:39, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
> v7: use abi_ushort and abi_uint to keep alignments good (lvivier)
> ---
>  linux-user/syscall.c      | 6 ++++--
>  linux-user/syscall_defs.h | 7 +++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e2af3c1494..f1ab81b917 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1496,8 +1496,10 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
>          sizeof(target_saddr->sa_family)) {
>          target_saddr->sa_family = tswap16(addr->sa_family);
>      }
> -    if (addr->sa_family == AF_NETLINK && len >= sizeof(struct sockaddr_nl)) {
> -        struct sockaddr_nl *target_nl = (struct sockaddr_nl *)target_saddr;
> +    if (addr->sa_family == AF_NETLINK &&
> +        len >= sizeof(struct target_sockaddr_nl)) {
> +        struct target_sockaddr_nl *target_nl =
> +               (struct target_sockaddr_nl *)target_saddr;
>          target_nl->nl_pid = tswap32(target_nl->nl_pid);
>          target_nl->nl_groups = tswap32(target_nl->nl_groups);
>      } else if (addr->sa_family == AF_PACKET) {
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index fa69c6ab8d..7694d72446 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -153,6 +153,13 @@ struct target_sockaddr_un {
>      uint8_t sun_path[108];
>  };
>  
> +struct target_sockaddr_nl {
> +    abi_ushort nl_family;   /* AF_NETLINK */
> +    abi_ushort __pad;
> +    abi_uint nl_pid;
> +    abi_uint nl_groups;
> +};
> +
>  struct target_in_addr {
>      uint32_t s_addr; /* big endian */
>  };
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

