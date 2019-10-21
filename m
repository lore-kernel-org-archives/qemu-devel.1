Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C55CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C3120679
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C3120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXF5-0007lm-Tt
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMXEE-0006od-Ji
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMXED-0006Sm-Dh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:56:06 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMXED-0006SW-4l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:56:05 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MgiPE-1hoJOg2KDs-00h9TM; Mon, 21 Oct 2019 14:55:54 +0200
Subject: Re: [PATCH v8 9/9] linux-user/syscall: Align target_sockaddr fields
 using ABI types
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191021114857.20538-1-f4bug@amsat.org>
 <20191021114857.20538-10-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b8ae9397-be42-6c6b-370a-6f7877a54f08@vivier.eu>
Date: Mon, 21 Oct 2019 14:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021114857.20538-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wF4CxulHcxx2bqSpZlQT4PYyOr4zRRhp/ccvdPId9w8V821Pydt
 +pvQB/5NRLJqHpqHEK0MjPA/UXVACeLwKEeCqgcTUuUBGRSQjestk7FvJn5L1HRLJPX9fJs
 dURBQe4gCs6wva2cppuHhqW0LQSlV1vwvnJrFJN0Ojvwpf1ULAX8oK/rd1e9eY9mtqwpCM7
 bOJkicAjNrw5/zBjbIAhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2C0xclk1+1Y=:inl+A9erp0xihQJ7uWIr1l
 DEWeo2qC//+2DIblpQrpkpM5sDKk7ReVzIoF5wObbRbWB5V3WxAufdgaGBsOJUpslOfKsLeZ9
 IWEb/tbA+94ZfZo5hfMcuuQ9zCAvJ+c/o/p74MEUlMNwYnBDzPLw5dDW0r5hHFu6TJ0F8uN69
 i07CWqkcjlz8QB45zjki1YLcTZvFCxGTaWLfhJi1yoXYGjl9o5DgAfeJhYIJzL9hGhLODqf8c
 jyLkPTGkM991AydHWl+XEpwvYoReZV2bo58hT05shIbrqctk8sig60dHImeOUSNEcYLuAe+Om
 JibZany30VgQnbK2clp9kUUNUfUyVvstp5rTx5RSuVuPfemZvI6AbTIluI039KQ9PDdwDMe6z
 F3712lypgU45nNalsG+1/q+ozObPeYWLq5n9qjl5DL5d6lKT4nWWV0kqOFTmrYuDeBDE7p2o6
 t7qPXXB6FF6Qeb+dTHP3/ZFQnn1yLKEaBNsOqK0JE3S0ZzVZYLjBF39RN1EN6KsaAw5G/Fh6h
 ZB63H1oFCSwuYaHtkYNv5pm3BIMPYuLeGtH+80q1MTuTygrewkEv68rBuMYCYf0D7Zm7Dnmy6
 GUO776ZUPteZDDond2fBzYwPeCbLDbc9Me4kJpsEGyGCm+IlurNhau/Zv7W44PkqN1/3+pZ+f
 fu/bh7NxsK6erpO68oR+O+RLfmxgSeREGSVAqb85D42roArCIbjZ2uUYCQqP8zdGZ4kGMyjk0
 Y66YVm1H9kvLYEcV50Ekcxv9o1XyA60ael06uPkLUHcEoY1nw536+kZYzT57d7+/EhdH/uH8T
 G+6E1FQ2S05LhUOkY5YWM0ETkl7CFptgGMSfMlKPw8L9RrAyLSXsl3Rh1ekZ9FTiVTl5szxy8
 fqR2vpzkh6VW8no+vR3yXGNtRFkm1KBEG2O/8O12U=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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

Le 21/10/2019 à 13:48, Philippe Mathieu-Daudé a écrit :
> Target architectures align types differently for instance m68k
> aligns on 16bit whereas others on 32bit).
> Use ABI types to keep alignments good.
> 
> Suggested-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v8: Use abi_int for target_sockaddr_ll.sll_ifindex
> ---
>  linux-user/syscall_defs.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 7694d72446..98c2119de9 100644
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
> +    abi_int    sll_ifindex;  /* Interface number */
> +    abi_ushort sll_hatype;   /* ARP hardware type */
> +    uint8_t    sll_pkttype;  /* Packet type */
> +    uint8_t    sll_halen;    /* Length of address */
> +    uint8_t    sll_addr[8];  /* Physical layer address */
>  };
>  
>  struct target_sockaddr_un {
> -    uint16_t su_family;
> +    abi_ushort su_family;
>      uint8_t sun_path[108];
>  };
>  
> @@ -161,24 +161,24 @@ struct target_sockaddr_nl {
>  };
>  
>  struct target_in_addr {
> -    uint32_t s_addr; /* big endian */
> +    abi_uint s_addr; /* big endian */
>  };
>  
>  struct target_sockaddr_in {
> -  uint16_t sin_family;
> -  int16_t sin_port; /* big endian */
> +  abi_ushort sin_family;
> +  abi_short sin_port; /* big endian */
>    struct target_in_addr sin_addr;
>    uint8_t __pad[sizeof(struct target_sockaddr) -
> -                sizeof(uint16_t) - sizeof(int16_t) -
> +                sizeof(abi_ushort) - sizeof(abi_short) -
>                  sizeof(struct target_in_addr)];
>  };
>  
>  struct target_sockaddr_in6 {
> -    uint16_t sin6_family;
> -    uint16_t sin6_port; /* big endian */
> -    uint32_t sin6_flowinfo; /* big endian */
> +    abi_ushort sin6_family;
> +    abi_ushort sin6_port; /* big endian */
> +    abi_uint sin6_flowinfo; /* big endian */
>      struct in6_addr sin6_addr; /* IPv6 address, big endian */
> -    uint32_t sin6_scope_id;
> +    abi_uint sin6_scope_id;
>  };
>  
>  struct target_sock_filter {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


