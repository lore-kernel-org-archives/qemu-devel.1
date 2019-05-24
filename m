Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B91C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3932221773
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH4VZeRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3932221773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53641 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU92r-0006bJ-ER
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:11:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hU91B-0005Ao-7q
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hU8qq-0003mY-SW
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:59:09 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hU8qq-0003l2-N8
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:59:08 -0400
Received: by mail-oi1-x244.google.com with SMTP id t187so6803886oie.10
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=q5Yzfz83BJocSxYw7esOF2AooMYiDrJYJKhfVgh8T2Q=;
	b=HH4VZeRQFEpUGFFomRFbClph6PaZ0e9caLB31SEyImqUmCM9wZy7XmUV0T21irQ00q
	xOhmuLiNO4csmv386XF2JD+7QPyrJv47WrQ1d4+jrfttRzmHUWihrZPLXimalWywl6oO
	X/LsOy2/i9MV4vHRrzP/1CbxBjUOZIpoOStl2ZrZWeZSjkWgvGhrMy5mZLby0o4DwmFa
	u7zK3bflu4Y017mXDABsCQQ5OUiSe/2SShUroS+KGGnulmX0ODE+UFcPMxghEw7o35bC
	Nho/BbWIi4zcqRGu4SMhX2MnRsFJtWaKpnjk2ih5EO3R+r7xXI8LSAy3PFTsGcPghmUZ
	qaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=q5Yzfz83BJocSxYw7esOF2AooMYiDrJYJKhfVgh8T2Q=;
	b=MLLfUmL66xYE5MwFM8at9gJrNslOFk4czbNGNWrJvK2wQU3elf0YOo1jctLBvGwe97
	Xn8TALowUpNko5D+6dm4R6JrQQUsj2QL9OveWiYrs4mH6Oq9+eYkdMsEYW8s2XWF14SR
	/6LYN0+VysjgH1eK3NIYksNqbmIR42GHr6JstJu3hN5kbKwFc7uIDnopJMhDIoA3yIBV
	jv0rGGRerC9MC13l7eO3iTu2wzzlsEA9n1C7UbJHQ/wKXw951Ms2dzmFG26mj/ncMbnR
	y7PmltXyw+XYYX+kXttbq8uakmLzW88aJRJkD062lnOSLNRn/LjvF6kdpHMFZiSYhPBP
	+Jgg==
X-Gm-Message-State: APjAAAVPQnRXs249VHMAmgK46/klA8bQqRcsm3YqkCE6GDRRRtW0GwQ/
	lS0W4hMcmIB8yoZMNlN3pQJZu5WMqdQ9feehvR0=
X-Google-Smtp-Source: APXvYqwJiesz9Km/RxSTbpt1g2ydYUzVOrm9WvjVbcQ3bzEJe5nsZoSkLwuPkMWELlmxSuINK7TXIbrvun8XT89CtQY=
X-Received: by 2002:aca:f582:: with SMTP id t124mr6436740oih.56.1558699148044; 
	Fri, 24 May 2019 04:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-3-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-3-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 19:58:31 +0800
Message-ID: <CAKXe6S+bQ+UVz-apizKzp0E2OWxy288r9YJK7WBL8Qnz_ACQ=g@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 02/20] hw/i386/pc: Use size_t type to
 hold/return a size of array
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
Cc: Yang Zhong <yang.zhong@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	Samuel Ortiz <sameo@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:37=E5=86=99=E9=81=
=93=EF=BC=9A

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/i386/pc.c         | 4 ++--
>  include/hw/i386/pc.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index fc38b59d2d..df8600ac24 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -104,7 +104,7 @@ struct e820_table {
>
>  static struct e820_table e820_reserve;
>  static struct e820_entry *e820_table;
> -static unsigned e820_entries;
> +static size_t e820_entries;
>  struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
>
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
> @@ -897,7 +897,7 @@ int e820_add_entry(uint64_t address, uint64_t length,
> uint32_t type)
>      return e820_entries;
>  }
>
> -int e820_get_num_entries(void)
> +size_t e820_get_num_entries(void)
>  {
>      return e820_entries;
>  }
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index ad3a75d8fa..28b19173b0 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -290,7 +290,7 @@ void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>  #define E820_UNUSABLE   5
>
>  int e820_add_entry(uint64_t, uint64_t, uint32_t);
> -int e820_get_num_entries(void);
> +size_t e820_get_num_entries(void);
>  bool e820_get_entry(unsigned int, uint32_t, uint64_t *, uint64_t *);
>
>  extern GlobalProperty pc_compat_4_0[];
> --
> 2.20.1
>
>
>
