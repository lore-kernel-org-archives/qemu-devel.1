Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF72C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E235620673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9rdyelc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E235620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8zD-0006la-6s
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:18:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8yD-0006QE-P6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8yB-00029n-HB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:17:33 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8y6-0001n6-L9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:17:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id v23so8606795oif.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iLxeVG5xKmJOlgK+ON/aG4uYlirirPGntRnAHDuxbiQ=;
	b=F9rdyelcCm//WTaKf1iMx/2ZPqWWgzVC6TXpN0YYdmVRbLw+haszjR2Cd2p/shpCGR
	+LDuTaOtyCZdM7xilIOhTU7xKqw0cItz0GndgkbXQOZIrsyM3xLSRVt45CerzElJSm+w
	qMt5n9sRdnDzmLL2bNrCSZGuink8qN/kpWjdCFvSSL2RYoiFMI8ukR26IbK6XYQHTqRC
	5oOuQtUTDRd9AKZtuuQuAHeJE4/pGgcOwzHuTE6n1yhGonOzABCLNzfBiVkJmnahwCsW
	0HaEz7w2GCx3SpryF+qqD5nfTL1Ptm+CMBiUxSz5wvz1DlGjr70LmFNCLHOHXEpxRa19
	Dbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iLxeVG5xKmJOlgK+ON/aG4uYlirirPGntRnAHDuxbiQ=;
	b=GcG2HmF+btW+WMGQeH9UDPY1/zBZ4X0ZwnUSBQYGNKRoQswbdDL9HteGO1CVQVGqiM
	c7x7nvBHqQ5YVQchzWEslFWSifJFs2efRbB1DtD8mSsOvNwZiORw742tMdeL7gJrjeaO
	e2P39/k2u6yIx4KDSYzy1qlvF9edW48g/WIgWzA92/jO34kBdo7PrxunD/gIgEaOg+Zg
	ElgWB9KNy193cVlvjA22WfQ3POduPqGyr5+464ZHcqIsbbDzmrPjwh/vLFwKR9cJofmH
	Li3n8pLYE+AJcbg9wyq5t14co+0zUoqfGJfiXSiwqN8wX1rlzruKa4nsdnMFYyPjAyFC
	2kFg==
X-Gm-Message-State: APjAAAXtz0aTjCugbKRjitloo+DKBAsnx/YSTF7cxu2Sm84z9peP4z6s
	0CmFV4q9iH4pNLDkUdXwgQ84IyvP+UXu8xbgTClOb8VN0g8=
X-Google-Smtp-Source: APXvYqxZLYKZVbkA0lgokvEr4779vT+ah+Jej2UzfEU+60DOWQITiJCWIOquFMVCsWbnnlLMaPbuw8gAifuF4OwzHmw=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr4173451oie.48.1556554632936; 
	Mon, 29 Apr 2019 09:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-4-richard.henderson@linaro.org>
In-Reply-To: <20190330005900.17282-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:17:01 +0100
Message-ID:
 <CAFEAcA-3qrQXk9iMY_9VZSLzdnn=EzzYOqhe61UQKYn-w__3Zw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v4 3/4] linux-user: Parse
 NT_GNU_PROPERTY_TYPE_0 notes
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429161701.l9bpQCTcl0yOAkB9IBl34N5OT336QqFGQga-gMwm560@z>

On Sat, 30 Mar 2019 at 00:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
> which indicates that the image should be mapped with guarded pages.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 79 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 11 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..12ee96e5d4 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -116,6 +116,10 @@ typedef abi_uint        target_gid_t;
>  #endif
>  typedef abi_int         target_pid_t;
>
> +
> +#define TARGET_NT_GNU_PROPERTY_TYPE_0  5
> +
> +
>  #ifdef TARGET_I386
>
>  #define ELF_PLATFORM get_elf_platform()
> @@ -543,6 +547,10 @@ static const char *get_elf_platform(void)
>  # define ELF_PLATFORM    "aarch64"
>  #endif
>
> +#define TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_AND  0xc0000000
> +#define TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_BTI  (1u << 0)
> +#define TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_PAC  (1u << 1)
> +
>  static inline void init_thread(struct target_pt_regs *regs,
>                                 struct image_info *infop)
>  {
> @@ -2252,7 +2260,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>      struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
>      struct elf_phdr *phdr;
>      abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
> -    int i, retval;
> +    int i, retval, prot_exec = PROT_EXEC;
>      const char *errmsg;
>
>      /* First of all, some simple consistency checks */
> @@ -2287,17 +2295,66 @@ static void load_elf_image(const char *image_name, int image_fd,
>      loaddr = -1, hiaddr = 0;
>      info->alignment = 0;
>      for (i = 0; i < ehdr->e_phnum; ++i) {
> -        if (phdr[i].p_type == PT_LOAD) {
> -            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
> -            if (a < loaddr) {
> -                loaddr = a;
> +        struct elf_phdr *eppnt = phdr + i;
> +
> +        switch (eppnt->p_type) {
> +        case PT_LOAD:
> +            {

I think you have an extra layer of indent here that we usually
don't do for switch statement cases.


> +#ifdef BSWAP_NEEDED
> +                for (i = 0; i < ARRAY_SIZE(note); ++i) {
> +                    bswap32s(note + i);
> +                }
> +#endif
> +#ifdef HOST_WORDS_BIGENDIAN
> +                gnu0 = 'G' << 24 | 'N' << 16 | 'U' << 8;
> +#else
> +                gnu0 = 'G' | 'N' << 8 | 'U' << 16;
> +#endif

#define GNU0_MAGIC const_le32('G' | 'N' << 8 | 'U' << 16)

and then you can avoid the #ifdef HOST_WORDS_BIGENDIAN?

> +
> +                if (note[0] != 4 ||     /* namesz */
> +                    note[1] < 12 ||     /* descsz -- may include padding */
> +                    note[2] != TARGET_NT_GNU_PROPERTY_TYPE_0 ||  /* type */
> +                    note[3] != gnu0) {  /* name */
> +                    break;
> +                }
> +#ifdef TARGET_AARCH64
> +                if (note[4] == TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_AND &&
> +                    note[5] == 4 &&
> +                    (note[6] & TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
> +                    prot_exec |= TARGET_PROT_BTI;
> +                }
> +#endif
>              }
> -            ++info->nsegs;
> -            info->alignment |= phdr[i].p_align;
> +            break;
>          }
>      }
>
> @@ -2359,7 +2416,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>
>              if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
>              if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
> -            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
> +            if (eppnt->p_flags & PF_X) elf_prot |= prot_exec;
>
>              vaddr = load_bias + eppnt->p_vaddr;
>              vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
> --
> 2.17.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

