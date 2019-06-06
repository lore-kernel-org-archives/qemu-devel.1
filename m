Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D6C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123C920673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 05:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvxOZ0Yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123C920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYlEq-0008Qa-1N
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 01:47:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hYlDt-0007xj-RS
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hYlDs-0007Vv-Hr
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 01:46:01 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hYlDs-0007VY-Bq; Thu, 06 Jun 2019 01:46:00 -0400
Received: by mail-oi1-x243.google.com with SMTP id 203so707834oid.13;
	Wed, 05 Jun 2019 22:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=d0c7qkLAXbMXz/RHiRSYXP1wkY5F+It0gp3SsnVS+IE=;
	b=dvxOZ0Ywb06EWv4bxXNFxJr8aOy1mNU5NnH8nOG2LMB7Ze6us9ajxmwpkx8x29CY4/
	Y4v+9N7riTInNweqGxWHi4a/0K+LyZqDvExc81/2G92WfujB5JbnZpRo2EkW2ichFtjP
	KEf3oeNjBMBmABy24bnqrG8OB7ON7cIWZTv0ivjNCOWtO3pMtV0x0fIouBN+Zy5ia6nF
	pNDHeGvAO79G0DqGVUvOUZOhtd5wRQWOphFGU8kf99YwUqKbX3epJKznWBpKc8ceixxQ
	Ppz6mZoU0ktj2yVnETRy/KFezZS2fIvMLp4vYB5bfioP1ad1WEx1s2NgQ4PGziQHqQfW
	SfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=d0c7qkLAXbMXz/RHiRSYXP1wkY5F+It0gp3SsnVS+IE=;
	b=Ws7+RXu1TK8f9eOCqglf2Pm37xuoXo1OomjCjB2N4KbEbN/q6z5n8DGEf3/+V3tEuU
	NGoj80u0pLGPzVwn1Ormm6DT/GX5zABv2NrvH34IJPARopwYmKEwogWxCgQ3uTIcLqzf
	Khzg5pTVE6VX7xUJMAb2Mm/Kb2/FeKgzEEduwB4SfIm0yo5tVKT/L+cAcxBpxeD1vw/T
	UKQdrSB+RNpSz+EubzM74iMxTp09HQGnkXJwlcIrotrJbX2C3jzV6XGjwUkdZz8O4Fgh
	Rgdr0ZRzokqinYTbd/2lpM41GKxMN1q9xPBVa9FeEVzNH6Uj3W8M+o7nQRkGIA1w/4Bl
	ooGQ==
X-Gm-Message-State: APjAAAU9c1NmRJQs7otc5JQiNObdp7c9q+Xc5Xq32/hQ4ko3MN9kTPg8
	VH4gcrBY3TqsVx0GTFvJhMqsT5iZfNu308QnzNc=
X-Google-Smtp-Source: APXvYqy6CRCDYEgOaMqD8Yjr975s6SBFYfNOH8mp9SGmXwNWGzv1TZSUSv1wbSFVO2Gpd+tdP97FBQLwc+jIaweHgwU=
X-Received: by 2002:aca:3906:: with SMTP id g6mr10513108oia.106.1559799959430; 
	Wed, 05 Jun 2019 22:45:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
	Wed, 5 Jun 2019 22:45:58 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP;
	Wed, 5 Jun 2019 22:45:58 -0700 (PDT)
In-Reply-To: <20190605205706.569-5-richard.henderson@linaro.org>
References: <20190605205706.569-1-richard.henderson@linaro.org>
	<20190605205706.569-5-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 6 Jun 2019 07:45:58 +0200
Message-ID: <CAL1e-=jYwL9bb_YVp28pf=R4Gb0+1MgxYLsO=2927W=CtUrQ-A@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v6 4/6] include/elf: Add defines related to
 notes for GNU systems
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 5, 2019 11:03 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> This is a collection of related

Related to what?

> defines for notes, copied
> from glibc's <elf.h>.  We're not going to use all of these
> right away, but it seemed foolish

I don't think this an appropriate word for a commit message.

> to cherry-pick only the
> ones we need now.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/elf.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/include/elf.h b/include/elf.h
> index ea7708a4ea..6f3eada36f 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -1650,6 +1650,54 @@ typedef struct elf64_shdr {
>  #define NT_ARM_HW_WATCH 0x403           /* ARM hardware watchpoint
registers */
>  #define NT_ARM_SYSTEM_CALL      0x404   /* ARM system call number */
>
> +/* Defined note types for GNU systems.  */
> +
> +#define NT_GNU_ABI_TAG          1       /* ABI information */
> +#define NT_GNU_HWCAP            2       /* Synthetic hwcap information */
> +#define NT_GNU_BUILD_ID         3       /* Build ID */
> +#define NT_GNU_GOLD_VERSION     4       /* Version of ld.gold */
> +#define NT_GNU_PROPERTY_TYPE_0  5       /* Program property */
> +
> +/* Values used in GNU .note.gnu.property notes
(NT_GNU_PROPERTY_TYPE_0).  */
> +
> +#define GNU_PROPERTY_STACK_SIZE                 1
> +#define GNU_PROPERTY_NO_COPY_ON_PROTECTED       2
> +
> +#define GNU_PROPERTY_LOPROC                     0xc0000000
> +#define GNU_PROPERTY_HIPROC                     0xdfffffff
> +#define GNU_PROPERTY_LOUSER                     0xe0000000
> +#define GNU_PROPERTY_HIUSER                     0xffffffff
> +
> +#define GNU_PROPERTY_X86_ISA_1_USED             0xc0000000
> +#define GNU_PROPERTY_X86_ISA_1_NEEDED           0xc0000001
> +
> +#define GNU_PROPERTY_X86_ISA_1_486              (1U << 0)
> +#define GNU_PROPERTY_X86_ISA_1_586              (1U << 1)
> +#define GNU_PROPERTY_X86_ISA_1_686              (1U << 2)
> +#define GNU_PROPERTY_X86_ISA_1_SSE              (1U << 3)
> +#define GNU_PROPERTY_X86_ISA_1_SSE2             (1U << 4)
> +#define GNU_PROPERTY_X86_ISA_1_SSE3             (1U << 5)
> +#define GNU_PROPERTY_X86_ISA_1_SSSE3            (1U << 6)
> +#define GNU_PROPERTY_X86_ISA_1_SSE4_1           (1U << 7)
> +#define GNU_PROPERTY_X86_ISA_1_SSE4_2           (1U << 8)
> +#define GNU_PROPERTY_X86_ISA_1_AVX              (1U << 9)
> +#define GNU_PROPERTY_X86_ISA_1_AVX2             (1U << 10)
> +#define GNU_PROPERTY_X86_ISA_1_AVX512F          (1U << 11)
> +#define GNU_PROPERTY_X86_ISA_1_AVX512CD         (1U << 12)
> +#define GNU_PROPERTY_X86_ISA_1_AVX512ER         (1U << 13)
> +#define GNU_PROPERTY_X86_ISA_1_AVX512PF         (1U << 14)
> +#define GNU_PROPERTY_X86_ISA_1_AVX512VL         (1U << 15)
> +#define GNU_PROPERTY_X86_ISA_1_AVX512DQ         (1U << 16)
> +#define GNU_PROPERTY_X86_ISA_1_AVX512BW         (1U << 17)
> +
> +#define GNU_PROPERTY_X86_FEATURE_1_AND          0xc0000002
> +#define GNU_PROPERTY_X86_FEATURE_1_IBT          (1U << 0)
> +#define GNU_PROPERTY_X86_FEATURE_1_SHSTK        (1U << 1)
> +
> +#define GNU_PROPERTY_AARCH64_FEATURE_1_AND      0xc0000000
> +#define GNU_PROPERTY_AARCH64_FEATURE_1_BTI      (1u << 0)
> +#define GNU_PROPERTY_AARCH64_FEATURE_1_PAC      (1u << 1)
> +
>  /*
>   * Physical entry point into the kernel.
>   *
> --
> 2.17.1
>
>
