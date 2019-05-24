Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646AFC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D84220644
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlIZ/axH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D84220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUA2A-0008To-30
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:14:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUA0g-0007aO-4B
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hU9zX-0002Zd-KI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:12:12 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hU9zW-0002Vw-OH
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:12:11 -0400
Received: by mail-oi1-x241.google.com with SMTP id y10so6975006oia.8
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=cm6/LN3d3ZQ2+SycKgkiEPWzS+SUf9/nU1vzxFor2i4=;
	b=BlIZ/axHDIzNjSSV63Tx3iNy+2eb7xbkJ1NSjWYQB53mF2ygAjTxDNqP06dwinS5Jc
	mR5SfpFC0NsGv6c46FJzsORStSRiI4PbnrejG/Qc4RYpIC1lSTo4z+vco3kP1z6z2DWV
	sp4BPbG+6PhltZQluoUYi5RvOf+02Blt7URKUAznGh9tq87aygTwp6uuBKsCbnoMBxDR
	hdoIt+A0wPGAup4+QIedanv0O1PBRTTX02xaJQMwN3MmMi8V1PBaTfmS+bu336ETZBUh
	KtIhF+GS/jVkziafq/YgOqnvVAj0v7i6/LtXwYGRsBxi0J+0CSHmkTseOU7ljxzMPSEl
	c5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=cm6/LN3d3ZQ2+SycKgkiEPWzS+SUf9/nU1vzxFor2i4=;
	b=Rl9KooA5+sfTMknvMsRILSb4zbpL4+1PxkHwH8UA3Sf6duGEByRbG+49zkbpOz3wFX
	1A54odgEUindJA2ejYNtFnb2nwYdruj/n74GjJUZkGHNw0Ku/kdodcONoBc1DAI7ZM0p
	sRpgG7sBmYy65ETavfNirJFcf6ORPw3dQ+Ihymoxvofk3C+UhL+ZuIUSDT4uATfK13UD
	nzWmIUBT3L2Bee2ovvrqVdE2VWaJdlXY6HSW3hxTuoG72wQkQm5TlPsozSfBBvY+evKz
	JfyzrltZyXFsmeztK4SZbHdC4ItNq77K0vsLLX7QBIrBGxeiSJD8L8hwbmZs6hVu9jdD
	jIEA==
X-Gm-Message-State: APjAAAXXn3RH7htG95PJ1asuaurgtPuMfICRnCjGJo1KRn2EfC99rQ+q
	OEu7PY45JW0ma6BfxaDJ+lC0A2UxP5ijFQa0HGA=
X-Google-Smtp-Source: APXvYqy1RMEBkmc0kJjgf812nrcu3dKF6oCAHz41DsfF7xFnf4IlNZITjGqTSFwc0GJx685NoIxZ+EkeUHuIYXIVhhU=
X-Received: by 2002:aca:fc43:: with SMTP id a64mr931699oii.129.1558703527235; 
	Fri, 24 May 2019 06:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-7-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-7-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 21:11:30 +0800
Message-ID: <CAKXe6S+PeYbOCcDzqpHxgvrqqfgH7GVnYtpJrcLYFJbxzN5aew@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 06/20] hw/i386/pc: Use
 e820_get_num_entries() to access e820_entries
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
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:48=E5=86=99=E9=81=
=93=EF=BC=9A

> To be able to extract the e820* code out of this file (in the next
> patch), access e820_entries with its correct helper.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>



> ---
>  hw/i386/pc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ac8343c728..2e195049a5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1022,7 +1022,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as=
,
> PCMachineState *pcms)
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_E820_TABLE,
>                       &e820_reserve, sizeof(e820_reserve));
>      fw_cfg_add_file(fw_cfg, "etc/e820", e820_table,
> -                    sizeof(struct e820_entry) * e820_entries);
> +                    sizeof(struct e820_entry) * e820_get_num_entries());
>
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_cfg, sizeof(hpet_cfg));
>      /* allocate memory for the NUMA channel: one (64bit) word for the
> number
> --
> 2.20.1
>
>
>
