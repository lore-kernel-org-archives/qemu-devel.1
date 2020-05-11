Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ADAC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225F2207DD
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMKMwzHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225F2207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5AF-0003QH-AP
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jY58t-00022q-Jr; Mon, 11 May 2020 05:54:35 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jY58s-00057Q-Aw; Mon, 11 May 2020 05:54:35 -0400
Received: by mail-lj1-x243.google.com with SMTP id e25so8757572ljg.5;
 Mon, 11 May 2020 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=tiyyfkVX+Vv+hcjnSdTeDu1LOtGQ32sOhl+9tc0AzN0=;
 b=fMKMwzHKAL+cC6GYL7w6Jo1hhb5zYEWOu+Hm1gsRT7aE0QuTlXpXlcee6I1vIfHTZC
 Vo9VeSvSNJboZSAY84hXz1eBveXwKvejjHIovRw4E9UfTyYUg71VuDjwlGLgEGTSpzey
 gcCq7dQYd/ajywcWswVmaM5wJQSPlaC4vZTjAmuEVpU5L83wA3QvdbZMz8izaqS5NSTm
 oofor2fr+mK8xGjfS7pD7W4SNCyqQdNEB4eWGL+hLA7IQg4UbP2qqb7gMdvDlICBAqFs
 zW7MSa0A1LOrKMzwxLhYfNPT4H0V3Gf4h4sUii3tJFgofR40LLf6Q3o+UA9GeDOw8op9
 sqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=tiyyfkVX+Vv+hcjnSdTeDu1LOtGQ32sOhl+9tc0AzN0=;
 b=WEPW0aSCwLU83LGS3fa2z9m74sg/lmQSoYb/v6UHHZwODAW59gGPDM0phRW4tikb8e
 yxN65x9cMhIXE+vsZvA7ovCupP6pdLYmbxeKlO0/CoUqhASEYqtB385GckZbp/TJFLrK
 FZ7uyhhVhQiqMwGXDF9V/5lHaCH8fUdAnRo6Z1sPOrzPZigh/ksVRnTnKmCKGHtmNm2J
 T2O2a+ZhaEtyRk2LgnYaQQM+o4ZYCKLrNLh5SwTuVcmtXASd4tDA0MqUyveY49c5WRXC
 MiP+jvqOy1+jCfc/vIfin9DMxm0rXu82K+DDv7LRmXfJcYdf7oP9pNeQNlKSyIR5rCk8
 9PJw==
X-Gm-Message-State: AOAM532o4zcFMw/qreivL4hVqtq8c1i0Moq3VmnhebzE5nargEAuVRqt
 9k2T008lN7OogSe14m0Lahg=
X-Google-Smtp-Source: ABdhPJz+MtRuntfrRkEMQVanEs2Ehicxuu4xy5lCw5aWu+zWimC9nOZPengQVdTQtuxI9wjfgHFNyQ==
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr9855811ljc.292.1589190871093; 
 Mon, 11 May 2020 02:54:31 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id s7sm10412923lfb.40.2020.05.11.02.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 02:54:29 -0700 (PDT)
Date: Mon, 11 May 2020 11:54:13 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 02/11] sysemu/accel: Restrict machine methods to
 system-mode
Message-ID: <20200511095413.GS5519@toto>
References: <20200509130910.26335-1-f4bug@amsat.org>
 <20200509130910.26335-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200509130910.26335-3-f4bug@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 09, 2020 at 03:09:01PM +0200, Philippe Mathieu-Daudé wrote:
> Restrict init_machine(), setup_post() and has_memory()
> to system-mode.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/sysemu/accel.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
> index 47e5788530..e08b8ab8fa 100644
> --- a/include/sysemu/accel.h
> +++ b/include/sysemu/accel.h
> @@ -37,10 +37,12 @@ typedef struct AccelClass {
>      /*< public >*/
>  
>      const char *name;
> +#ifndef CONFIG_USER_ONLY
>      int (*init_machine)(MachineState *ms);
>      void (*setup_post)(MachineState *ms, AccelState *accel);
>      bool (*has_memory)(MachineState *ms, AddressSpace *as,
>                         hwaddr start_addr, hwaddr size);
> +#endif
>      bool *allowed;
>      /*
>       * Array of global properties that would be applied when specific
> -- 
> 2.21.3
> 

