Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7027C282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8672C2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 21:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdRnoUGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8672C2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33164 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHaeY-0003GO-Nv
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 17:02:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHacp-0002NF-QV
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaco-0002od-QC
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 17:00:47 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hHaco-0002oA-J4; Fri, 19 Apr 2019 17:00:46 -0400
Received: by mail-lf1-x143.google.com with SMTP id t11so4783651lfl.12;
	Fri, 19 Apr 2019 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Mz1bCypkezkmEmclBAnq3+wYam+9PGnTBmgR/1AT72g=;
	b=LdRnoUGNfEzU+8RINjnWqqkSyHzpwB2x9WeDT+0hiCrG1ZscSP3gUlTfkZ+b+BG3BX
	pgdhMay9NYFyBB2ENhRS4gKavNFIXd3Wd1QDKeuhfI5eRxCquptAf4eztDaUWypY7Q6u
	T2lnH5tabOKhAd5IFEqY0gS2SXdRh2YAFJNqkC+xr5TLYYjqtoHgmcAupJlYKZOnuyUW
	tJMcEVjw3sgYAdcfrA8H5rkyWBZDCzsyT47j5EAWI5fKhP8Br8coNi6UOGlSivNWItH5
	7hXu9dGnud6Du13ZPHmaOFAFQo7FUFH8gB6uX9VTU24q1ab3RvC5CbkhY9DMDFZYnobG
	0m1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Mz1bCypkezkmEmclBAnq3+wYam+9PGnTBmgR/1AT72g=;
	b=gvhA+IajD5HwFowEtoWz63JnlsjqpaN576V/9LSSUfV72pFDj8NUJxNhr3RYIgW0DO
	BrnRnjbmfk5d15xnu2hqLCezQGD9Ss8CGSCLVHfLcbVTgUJzn5h6YyVFqpZuKWgOHWf5
	WDvOBzC7RKmTrzhiUbvCPqdr4s5hbWeZuE6wtzD1Jh37S6UM5+1aiz72bxiJAdPfBM42
	g5FEqPWx8sTw9Qq5E0jX3PvKGCGndbMoK+OrPTGZ9eqa/feU8Tl93Tn3gmns8/geeayx
	YDx8SDhY5IYSpwA6mkum3QatxB2RH1PMuxq0Vd/b3QNZ4k9ScoyTZDXpuk5T2TVa38DS
	breQ==
X-Gm-Message-State: APjAAAWDTpuY/w3Q6YhQMKtTdyM2JxB/vfjk+gUBt9lxdFC++PDWRwA/
	Z8+ViFPHCnNu1kAJsXF+47cFP1opJvE9f865Ejs=
X-Google-Smtp-Source: APXvYqyRR6DzW1qCvhOHMR6P6dXSYES6461ojp+1YylifXf7nPtGHZ8/hgQ+URHgyxld4nETg5I2ZzmzTf1zJdY7FXM=
X-Received: by 2002:a19:a40f:: with SMTP id q15mr1581220lfc.121.1555707645301; 
	Fri, 19 Apr 2019 14:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190419061429.17695-1-ehabkost@redhat.com>
	<20190419061429.17695-3-ehabkost@redhat.com>
In-Reply-To: <20190419061429.17695-3-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 14:00:18 -0700
Message-ID:
 <CAKmqyKO-djrG6QWXKeEMPNPvdXaVx14iWE7Cgq9TVh8C5_Ytpw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH 2/7] riscv: Don't split CPU model string
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419210018.1m-K90BvxFK3_FiZPAAyg0kjmvxEvDr3uvb7KxgvV-E@z>

On Thu, Apr 18, 2019 at 11:20 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> CPUClass::class_by_name is called after the CPU model name and
> options were already split, there's no need to split the string
> again.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Alistair Francis <Alistair.Francis@wdc.com>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: qemu-riscv@nongnu.org
> ---
>  target/riscv/cpu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d61bce6d55..5e97a83c80 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -179,12 +179,9 @@ static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
>      char *typename;
> -    char **cpuname;
>
> -    cpuname = g_strsplit(cpu_model, ",", 1);
> -    typename = g_strdup_printf(RISCV_CPU_TYPE_NAME("%s"), cpuname[0]);
> +    typename = g_strdup_printf(RISCV_CPU_TYPE_NAME("%s"), cpu_model);
>      oc = object_class_by_name(typename);
> -    g_strfreev(cpuname);
>      g_free(typename);
>      if (!oc || !object_class_dynamic_cast(oc, TYPE_RISCV_CPU) ||
>          object_class_is_abstract(oc)) {
> --
> 2.18.0.rc1.1.g3f1ff2140
>
>

