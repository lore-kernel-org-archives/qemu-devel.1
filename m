Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF4ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F68220684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F68220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUUP-0005KE-Lg
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMUTK-0004Nv-1f
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMUTI-0007pH-V4
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:59:29 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49573)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMUTI-0007oy-MD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:59:28 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MNKyQ-1igw3l3Uvi-00Oo7F; Mon, 21 Oct 2019 11:59:24 +0200
Subject: Re: [RFC PATCH v7 9/9] linux-user/syscall: Align target_sockaddr
 fields using ABI types
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190915213924.22223-1-f4bug@amsat.org>
 <20190915213924.22223-10-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a475bea5-c942-f64a-4519-52fb53faac9b@vivier.eu>
Date: Mon, 21 Oct 2019 11:59:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190915213924.22223-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fxfLnuO3eJ244xAje2x4qkzh5a/viUkCcsN4kC8x9W7lOElbuBp
 rrFXvpaMS1JSV3nplW/QuloZIpoaMfFb4AqVpnD+RP4guaZJUXOwYRlYV1+2/HXStBU9nrc
 cmNwGSDLZFuofwrYYxswmp/gc49pfDXX0FFrR8ic5LcrZyC7+38r5gtT5xYpX8+iitIcBL8
 y6Eryc0TXpFRiIH66SMvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5pe1sKWwj0o=:FjL7fEbg4toD33HOB88YWG
 LUCq5X6l8L+Rc3Yq04ixqMkeh6ZSt2hBbidVny8QPzNhjfTT4RX124W0yciGXEbCTdbgBWEwY
 mP7R9pRLXGZi1jnZX0ba7LEOGqKMmeRcQsuIPp1GzUVIRWDKqmFonliscyyAv/KbQt/KKbzBk
 24pzyBBG/EubywzQArouw082FzMiEYe6rx41HjxBr1c3nDhcszUYRLtwuUFR0xGCQMENaokpQ
 vpMkHidOz8Aotkftmn5LqeKnq7/nNmJWK6sjT5/IvCgC00jxSYh6fq2fzJ/JAGUJAQ9DwFZKA
 AxVphNzmyzvIhy3hWs6xrPca/Q0CLZeXzWn++/VVrphi2hlZjPPHCclG9nhAFIydXqAks17uE
 6ddFFH8hjRhZq/oja75LOweV7lh9/sI2dM388AN/TaIQV36a9F3UwAnYSKApCGleszPEr+ZBC
 ZwF8lswOngDBMO1LH8QRd2ze8r92QI5HmDg9VOlaLfL/zjztmic8axD5M7cFcSeO4198aoHaU
 FS46EoUie7DOu3bn4VYUZhEKVmGZwRRuwtpDMYmy7Bk+meogzGGTt+kHJJEcNL0f49OAlH6RA
 SWq04LNByCMywrOCkMAfddIqy7uGfZL2q4d3cbAgUzGZtnc2RexW1DvPGQN4aUSWx0dbS/ojr
 5M+o4KLSY4kWpt72EJK4K+clibivnNV0cWnMNdpcqAghOrWvDoMr2OA54n809ss8YSep6xFji
 Gjr9CnK9/u5NoQ0Po6OIMpoQrksiZz4/eiZqH0xCpLnCR/wY3C4xBj7orhc/CJAAfIqZu0dXW
 PQ7GYcfGzJ1FMZ3KWYX0RJEHWaAptmgBwPcBiRDPTgPehn/L1dzwa9tVexGuCl4yjsyA3Q3vB
 /UMECOkoBW1ukeGODavEPJtjc72CT8VgIY/wlIAEk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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

Le 15/09/2019 à 23:39, Philippe Mathieu-Daudé a écrit :
> Target architectures align types differently for instance
> m68k aligns on 16bit whereas others on 32bit).
> Use ABI types to keep alignments good.
> 
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> RFC: Is target_sockaddr_ll.sll_ifindex of type abi_int?
> 
>  linux-user/syscall_defs.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 7694d72446..852d4498e0 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -134,22 +134,22 @@
>  #define TARGET_IOWRU(type,nr)	TARGET_IOC(TARGET_IOC_READ|TARGET_IOC_WRITE,(type),(nr),TARGET_IOC_SIZEMASK)
>  
>  struct target_sockaddr {
> -    uint16_t sa_family;
> +    abi_ushort sa_family;
>      uint8_t sa_data[14];
>  };
>  
>  struct target_sockaddr_ll {
> -    uint16_t sll_family;   /* Always AF_PACKET */
> -    uint16_t sll_protocol; /* Physical layer protocol */
> -    int      sll_ifindex;  /* Interface number */
> -    uint16_t sll_hatype;   /* ARP hardware type */
> -    uint8_t  sll_pkttype;  /* Packet type */
> -    uint8_t  sll_halen;    /* Length of address */
> -    uint8_t  sll_addr[8];  /* Physical layer address */
> +    abi_ushort sll_family;   /* Always AF_PACKET */
> +    abi_ushort sll_protocol; /* Physical layer protocol */
> +    int        sll_ifindex;  /* Interface number */

abi_int would be better.

Thanks,
Laurent

