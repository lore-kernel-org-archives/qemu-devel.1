Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A7C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D43120873
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94PG-0003KW-P6
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j94OL-0002Mw-IV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j94OK-0003kI-HS
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:03:09 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46657)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j94OK-0003k8-8c; Tue, 03 Mar 2020 05:03:08 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MeCxj-1jh21h0HgN-00bLZw; Tue, 03 Mar 2020 11:02:54 +0100
Subject: Re: [PATCH] hw/nios2/boot: Remove dead code (big endian check)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200225115140.10023-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7671cb2b-965c-ead3-92f0-9ecfa0500f6a@vivier.eu>
Date: Tue, 3 Mar 2020 11:02:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225115140.10023-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+pXMbzew0B9HB8ZkrL6HdGMsrSQc4wfcijPa6HcT8Kd1X1YkwZ2
 u46HpMypBJtjwrliTByElDDfq+A/idi/1y4fsiCe+KK6Z1u91pQubbDRbYutbItwp1Hn4eE
 WS+BhPFiWDEMUyT9DD2sEpfM3MQHIT+KTw0JkPt2PccqDnqnwcWRz8n83vzkZdF78ZpGeca
 1OXM/glUKb6+mdZgDSavQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:326kxxqNPxY=:FzX/IIZvogPWtAUR3cY7I3
 NIWAblvFHG6KWN494ZnT3nqzk0RcvS9Nu+HyHo0m5DssYqAfYAuOY0IvskxiobRgRuyoCuzQ+
 8EhAoPNhghh1bUwf9G0xCyZdIaToH03u2CKkGnDv8qq6q9XlKBS+ftRlinj1kF9cxvBMc4C+w
 JRCNn+k5ROvn4gvVot8H78KXWKXbpmI6PDIaEufKaobNNG04kzAfoNKxErSJ1lWvffEJdti45
 XmgdeQFA5d8CIicTwOXoQCgF5ELjZOtdJGtHYuPogk39BWhVZ9zEOin/8lGApvSFiNaFQQNzJ
 ik+1KM2cURobsfQu0vto1NG523WMc2IHYSngh5iu5eVHKu7X78y77uMjwJ6mxgfUJ5hGxGuIo
 V3T/I1dPt5mig216jK2VwglMXk4vXlVXx0rBqSHnPwVHOQ9XGuIIdl9eMH0EApGnJY+uZS3G9
 MDH6tnM0P6bwNVOtB5Vdx4l0Q/NzSih1beRl1LmMzdGIv9kg9GdVmRR1AyelgwDYUZaT5WEkq
 Fv8KkipEdwH+oSPVW1orU6TWjsRSn41mGRU3D0/lzEAOKKObyEywMFvtodYwyWF7ij9HV8dHQ
 J6TautyZUNjhaT0+3rYPnTL6jYA5SZla1zcTeaXhL0ytPWRoghm1uVoZ67fmlPn1GURxpKDw0
 btF9VV1ENUdWksUR7eHvttJl22lIu6UR3yvHOXZTQfiBH9neE6QHJXK1d1+NC5K/rTkd8BdZP
 dSYC22DSuWqrwgfRPcq4auc24l3t0hqoMf/oG+JGXSAk/HJHMlcJodyVkvxAnBQc6xMAwhhIT
 C2+fs0N1Bx/Mykopj3JTiwnzcXEeVble2pE7iqm7YrpDjIfmAlFz4DcITFqaq/iir1R/y5Q
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jenner <andrew@codesourcery.com>, qemu-trivial@nongnu.org,
 Chris Wulff <crwulff@gmail.com>, Julian Brown <julian@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/02/2020 à 12:51, Philippe Mathieu-Daudé a écrit :
> We only build the little-endian softmmu configuration (all
> Nios II processors are only little endian). Checking for
> big endian is pointless, remove the unused code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/nios2/boot.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
> index 88224aa84c..000f8205d6 100644
> --- a/hw/nios2/boot.c
> +++ b/hw/nios2/boot.c
> @@ -140,16 +140,11 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>      if (kernel_filename) {
>          int kernel_size, fdt_size;
>          uint64_t entry, low, high;
> -        int big_endian = 0;
> -
> -#ifdef TARGET_WORDS_BIGENDIAN
> -        big_endian = 1;
> -#endif
>  
>          /* Boots a kernel elf binary. */
>          kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
>                                 &entry, &low, &high, NULL,
> -                               big_endian, EM_ALTERA_NIOS2, 0, 0);
> +                               0, EM_ALTERA_NIOS2, 0, 0);
>          if ((uint32_t)entry == 0xc0000000) {
>              /*
>               * The Nios II processor reference guide documents that the
> @@ -160,7 +155,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base,
>              kernel_size = load_elf(kernel_filename, NULL,
>                                     translate_kernel_address, NULL,
>                                     &entry, NULL, NULL, NULL,
> -                                   big_endian, EM_ALTERA_NIOS2, 0, 0);
> +                                   0, EM_ALTERA_NIOS2, 0, 0);
>              boot_info.bootstrap_pc = ddr_base + 0xc0000000 +
>                  (entry & 0x07ffffff);
>          } else {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

