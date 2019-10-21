Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F70CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9498A20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9498A20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXin-0001R3-NU
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMXhX-0000YA-Gp
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMXhS-0003YM-HD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:26:23 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44931)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMXhS-0003Xy-82
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:26:18 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M2NqA-1iJo8x1VJ0-003usW; Mon, 21 Oct 2019 15:26:13 +0200
Subject: Re: [PATCH v8 4/9] linux-user/syscall: Introduce target_sockaddr_nl
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191021114857.20538-1-f4bug@amsat.org>
 <20191021114857.20538-5-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <511f29d8-b9d7-f6c8-e60d-4bcb4e089ad6@vivier.eu>
Date: Mon, 21 Oct 2019 15:26:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021114857.20538-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DUp7b1UZ/pMXYbaRgduBh6dwCM9RL0p/BfseHCj4xwPR7ZB8j8l
 PCI1rEpplW+8MtOFPH29z59a9/lYHfpzyrfg2PVmeDJG+jZxjc7Rrik25r5s0qiDHi3R6RE
 S5PqlZMRdk0Zn8aFeGlsbheKIkfazR9afrOAqqOjRuZeHhdQFyhf/qgj0ykP90Qo5OwGWIN
 sIxtLvENhVRBiFxLR50uQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XgdviKMJ0c0=:uCT7sjYZDMh89fQMhlfKJt
 sEOh8/cmlOKGH2qnIHI3OO6q7n/IY7nJ4dJOlHVX9gLRM6WZnjFOb3KHB3KIKIbo8X/059ske
 /uDWBhRzynx3ObpIuuWfj4L3gGCZh1R3maXuMp51nWgoij6zk9wNTUfvocwZTJgZd5XyEu+gt
 Mq0FmQNryjn/we/7VWIbcA2dcMqXujnmmJhfyFf2UV+QavTXbL5dDVvz4DBu0Hdn6DYOyUtc+
 OntSkwuNMmCd47rqeG0V/6ppZrfvxZC25ClzmlWZ/RlqJIHJoWfnVBFDvqKS18syWRUeym+e3
 kv2eKzYgY++1wLz608BPWVwZ6U4swl1/Rgqzn0kKLukQhEXyCoDjLaDjAraoF4ugYoF1a2Rfi
 npx+h9bmi6ngeT/WEhwoFZ7+kYjrbMeppeKb7TapgI0X+HG6bq6js3CMx4x7c7VYJkhjps/UX
 ddabpppVQc1lmTNg/USSQ2y6yKcP/1OVZWAhLbsF3Uc4bOdKCbihxUStMksCMpglP93aj19GW
 aWWwKpyZ47QsOPOwMblmq8spuolsLfV9Y06KygsPE0rA4iOsycYkyDwt0Q2lyag2QP4qgkf5s
 2yzZtOJRRuXw5/ud/9KxbabOY+UPxpmMpIkDzcRuIeNKiFSHRBnwJXqAClhLUr6jva2Mt5jJU
 XY6eiUc601pfb+4LmvOZ9hImMoabDayTranquCGa56YSY7OQP/c6Qt7bJ9/Fzstr/Bu1FsXof
 W3jbFLeLasSRUqWKztnbqjh04NtAnQkp5DXbs2uz7f32INFN0qNZy7f82dl6kGZs8yLblM5uC
 1NxSnsBFRxSioQd5K4I1wAHfFZdUcLxHBZQO8sA+3FN9fd1nZy1VBu8ZLqR9pB3sFcnTikcPp
 Ucft02ctvGnmr6lr15XbG3zm+mgXYrTDXn40x6rXY=
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

Le 21/10/2019 à 13:48, Philippe Mathieu-Daudé a écrit :
> Tested-By: Guido Günther <agx@sigxcpu.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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

Applied to my linux-user branch.

Thanks,
Laurent

