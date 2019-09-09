Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF878C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C202C218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C202C218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Ka7-0005c3-0g
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7KZT-0005Dc-Sm
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:23:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7KZS-000426-Nq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:23:11 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50319)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7KZS-00041Y-FG
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:23:10 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MI4cT-1hskMS1lhP-00FFFC; Mon, 09 Sep 2019 16:22:55 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190908061543.25136-1-f4bug@amsat.org>
 <20190908061543.25136-5-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <046c1718-f938-b16f-5100-36406281f040@vivier.eu>
Date: Mon, 9 Sep 2019 16:22:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190908061543.25136-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jgNiKvEr69ZqmVTEbjOSS0oDo1aPb6RUP4pBaT0Vq2yAG1/C3d1
 LpjX+ccxZcI9QtLSvcVjavBHeC+DPEy5G5OVCINWFJWbyh7Z77pFg3PKQzDgaUajA7dprzr
 1kGeAqp5NEfPLf8qTXwJSvsSeXHfXxX5TyAb8CNLAmVMv6RmV2TzkyNIN2AywJdL56WZDR3
 wLExiQNZ7WfrN/vdFUTlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z3as9F4/NDQ=:jycDfMjx9v8RkvE5OmZT9i
 mG4sk2jyt4KOVM2Y5bABkxQZCmCG07u1SFh67zM4EF/oQMDpGWzCVnug4OI+gbE+ZEeIlAyHP
 gfgHATmV7gnoA4c7tkysarc831zfxwZW3VikIV4osQkaJlxMuVolekhLHjIDaNgCtWvLCzYFg
 c/uajK27tUa84cqAkTZn/RLdXPjAoMdHAs2pu1DmAtDZhfQSgcmXouKZbSm1qLYdR7TYX+ih/
 f2j3gnP4c6fxGKjq/Hm715I+2Ypchg5xg/QJ+Og9IEGL73ox2AU7CS5DK1GNzm1sGGYNm8QpB
 US3zQCMQb1Do6P6lGXVqE25qq5WswMkMRrXcklnOW/1c4VmCgS1CQhy6heCSnWSBAFUvYTRDO
 XolxwGloRv25hwnP1lGEmUlwLfXxhFTkEJDVgbD0xejnbU73NW4cBt+kMESkCitbV7Ab21UbC
 OuA7QGrTJyjmf+3h6+Cc7KRzuNeD63bYWav4fpUPh+6Np6+tvr4QA5spPW3a4aA+k7cvsWgtL
 s4+3C8sNTF/3blbBEoRtWK9xcFTvHAPxBhCbukyxE7w+J74SXbv0nmbMA+ajMveWCY1RYcEvk
 UqqHfyn3UjG5xEcc8IgScsB3sOAtGiNC53sgyzFH3JBUJR/eBEgpZ4XldgPEHDpohTmvRFMt+
 1D6syIb0DOYH1ildBAnoVlJUg4fOxq7r5Ikots8SpGMA/ZW3ItyWCfKUTliXVPwRvYDqgeLkx
 j9o+VOt/JJxknbm3jHIKUOwPomu6/qActVuiRYWX3LldP2dLUxCG/5z0+M4eFXrNV0cuEL7zX
 4PgET+rNBlkBF9BzWNUSNgHcCKTlz8ujenG4KzRUoUwtNyYLpQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v6 4/8] linux-user/syscall: Introduce
 target_sockaddr_nl
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

Le 08/09/2019 à 08:15, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-By: Guido Günther <agx@sigxcpu.org>
> ---
>  linux-user/syscall.c      | 6 ++++--
>  linux-user/syscall_defs.h | 7 +++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8b41a03901..5128312db5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1494,8 +1494,10 @@ static inline abi_long host_to_target_sockaddr(abi_ulong target_addr,
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
> index 0662270300..fcedd0d0fb 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -153,6 +153,13 @@ struct target_sockaddr_un {
>      uint8_t sun_path[108];
>  };
>  
> +struct target_sockaddr_nl {
> +    uint16_t nl_family;     /* AF_NETLINK */
> +    uint16_t __pad;
> +    uint32_t nl_pid;
> +    uint32_t nl_groups;
> +};

You should use abi_ushort and abi_uint to keep alignments good (for
instance m68k aligns on 16bit whereas others on 32bit).

Thanks,
Laurent

