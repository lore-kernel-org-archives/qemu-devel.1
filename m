Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850F5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEE720679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEE720679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUqc-0001Cb-MO
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgUmd-0002X5-K2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:54:23 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jgUmc-0000d9-9s
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:54:23 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N8ojI-1isKoG44rm-015sV6; Wed, 03 Jun 2020 16:54:19 +0200
Subject: Re: [PATCH 5/5] linux-user: Add strace support for printing arguments
 of fallocate()
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200602115331.1659-1-filip.bozuta@syrmia.com>
 <20200602115331.1659-6-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fc9e6b01-82e7-c50c-f19c-d2a7e0209802@vivier.eu>
Date: Wed, 3 Jun 2020 16:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602115331.1659-6-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bSArjMDeGBOjyEZH+b6gYsyI0OM10ni3PNRa69Q+YyRmvA0CI04
 TCi9biQ2+Tfq1er/uDCXpG+8GmHi7Bq9CXNRekFDEknDXdCHxEK32KSzauZH9ZHCXsJhAde
 2mGXNGG3IwATdGrSwILZdasiSxY1jUlVXRv8c/P8AEHnx1aqSqJyXgJF8/CLH/613mA3E+f
 rYsQhQpdWmfPJCLKvPoHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+T63v/8FQ6A=:dtCl6tQWxN3hkAT+Z8T8ME
 c3YeWbEDzGeEIFQgW7AXpeNpAYoKU/al5Z0dHtkFg+gURjy4YsBKUJdOGHq2h9nj01OeEQ7Yu
 S+mAXB8repsRqkRYJBJ04cp3K4a3UXYDM4oyPSonb/skiErf+r9FCZF0/95OrWlZ7Kn79ehU/
 DX8iuNlVzQMRHc4qlKKGjz4PJDiWpAVMD+weWuenWEQxaz8EfA8CER6PiD6e+xABsP66vXDfv
 lFTAZXy2Nc1/SsStkMWi7S8CPCKFsS4DtVZKosrsVW09p3UC+BnvtZ9xn7IQwIWNU1LZYXRSo
 5DMy3c1hYTJhdzvC5nL8zWFHU7hjjTf9LmGSBK+tD66eCxLdR0KpkwZII/5reGnEZvnpH5P0D
 vYAAeyivHCzH/U5S2eRYbdEfPO944bu/svvs+ywo0+6qK+ShC5ujW/Vcm6f2OfdXYUn1PehbL
 gd85RPvExlo/YRlFqLIU4DaNZvZ1xPtOjqa3Tz+mCoZ85/v8zbeynj9jp9we2QqRbm1JPBT00
 wFpL4H8wd+0EsiqtZcReVuYHjw5j6c6icGNeMStlP9iJBr7UccQEKHETUMdCw3cZ3LhJX34HO
 Ew0T0wy/NQeoqn2MdblFRYRQe4C3ZU2DxGarlBYYgM+QCslcIpjv2LgkHvfqLr7x0fkdnLca+
 TuM+viGOr/UgZmcoCNpdyRRFyb1Ui2NDEaflLESBze1FUePP4HU4j7jpUkYCQoOTrTUtFVUDX
 7gQsmv8eT1kf1RzjRQzQPW3A0OEGNxP7kQkkTRtiYPK/1fNgC4bRxXaB4pgY72XHrz3SUkBZX
 foA2BlXd3/PGi6apHS+MC0Ok8WwymMijG3LYySM7ebepdRLykIotkpQxYndEG/wRjhXSFTI
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 10:44:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/06/2020 à 13:53, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> This patch implements strace argument printing functionality for following syscall:
> 
>     *fallocate - manipulate file space
> 
>         int fallocate(int fd, int mode, off_t offset, off_t len)
>         man page: https://www.man7.org/linux/man-pages/man2/fallocate.2.html
> 
> Implementation notes:
> 
>     This syscall's second argument "mode" is composed of predefined values
>     which represent flags that determine the type of operation that is
>     to be performed on the file space. For that reason, a printing
>     function "print_fallocate" was stated in file "strace.list". This printing
>     function uses an already existing function "print_flags()" to print flags of
>     the "mode" argument. These flags are stated inside an array "falloc_flags"
>     that contains values of type "struct flags". These values are instantiated
>     using an existing macro "FLAG_GENERIC()". Most of these flags are defined
>     after kernel version 3.0 which is why they are enwrapped in an #ifdef
>     directive.
>     The syscall's third ant fourth argument are of type "off_t" which can
>     cause variations between 32/64-bit architectures. To handle this variation,
>     function "target_offset64()" was copied from file "strace.c" and used in
>     "print_fallocate" to print "off_t" arguments for 32-bit architectures.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
>  linux-user/strace.list |  2 +-
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 542bfdeb91..3998a00bb4 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -34,6 +34,22 @@ struct syscallname {
>  #define UNUSED
>  #endif
>  
> +#if TARGET_ABI_BITS == 32
> +static inline uint64_t target_offset64(uint32_t word0, uint32_t word1)
> +{
> +#ifdef TARGET_WORDS_BIGENDIAN
> +    return ((uint64_t)word0 << 32) | word1;
> +#else
> +    return ((uint64_t)word1 << 32) | word0;
> +#endif
> +}
> +#else /* TARGET_ABI_BITS == 32 */
> +static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
> +{
> +    return word0;
> +}
> +#endif /* TARGET_ABI_BITS != 32 */
> +

Rather than copying that from syscall.c perhaps you can move the
definition from linux-user/syscall.c to linux-user/qemu.h?

>  /*
>   * Structure used to translate flag values into strings.  This is
>   * similar that is in the actual strace tool.
> @@ -1097,6 +1113,26 @@ UNUSED static struct flags statx_mask[] = {
>      FLAG_END,
>  };
>  
> +UNUSED static struct flags falloc_flags[] = {
> +    FLAG_GENERIC(FALLOC_FL_KEEP_SIZE),
> +    FLAG_GENERIC(FALLOC_FL_PUNCH_HOLE),
> +#ifdef FALLOC_FL_NO_HIDE_STALE
> +    FLAG_GENERIC(FALLOC_FL_NO_HIDE_STALE),
> +#endif
> +#ifdef FALLOC_FL_COLLAPSE_RANGE
> +    FLAG_GENERIC(FALLOC_FL_COLLAPSE_RANGE),
> +#endif
> +#ifdef FALLOC_FL_ZERO_RANGE
> +    FLAG_GENERIC(FALLOC_FL_ZERO_RANGE),
> +#endif
> +#ifdef FALLOC_FL_INSERT_RANGE
> +    FLAG_GENERIC(FALLOC_FL_INSERT_RANGE),
> +#endif
> +#ifdef FALLOC_FL_UNSHARE_RANGE
> +    FLAG_GENERIC(FALLOC_FL_UNSHARE_RANGE),
> +#endif
> +};
> +
>  /*
>   * print_xxx utility functions.  These are used to print syscall
>   * parameters in certain format.  All of these have parameter
> @@ -1514,6 +1550,26 @@ print_faccessat(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_fallocate
> +static void
> +print_fallocate(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +    print_flags(falloc_flags, arg1, 0);
> +#if TARGET_ABI_BITS == 32
> +    print_raw_param("%ld", target_offset64(arg2, arg3), 0);
> +    print_raw_param("%ld", target_offset64(arg4, arg5), 1);

target_offset64 returns uint64_t so use PRIu64 rather than "%ld"

> +#else
> +    print_raw_param("%ld", arg2, 0);
> +    print_raw_param("%ld", arg3, 1);

TARGET_ABI_FMT_ld rather than "%ld"

> +#endif
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_fchmodat
>  static void
>  print_fchmodat(const struct syscallname *name,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index b72f757d3f..d7458ce884 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -182,7 +182,7 @@
>  { TARGET_NR_fadvise64_64, "fadvise64_64" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fallocate
> -{ TARGET_NR_fallocate, "fallocate" , NULL, NULL, NULL },
> +{ TARGET_NR_fallocate, "fallocate" , NULL, print_fallocate, NULL },
>  #endif
>  #ifdef TARGET_NR_fanotify_init
>  { TARGET_NR_fanotify_init, "fanotify_init" , NULL, NULL, NULL },
> 

Thanks,
Laurent

