Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C84C4CECC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF19B206D9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNT6xcCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF19B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTADZ-00023h-Rd
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 16:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTAC7-0000WL-Rl
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jTAC7-0000xR-1L
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:17:35 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:46346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jTAC6-0000vG-JM; Mon, 27 Apr 2020 16:17:34 -0400
Received: by mail-il1-x144.google.com with SMTP id x2so18057115ilp.13;
 Mon, 27 Apr 2020 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oAvZ5gj6xLua6e/c7b1iZR0wzMC/YFb04cZhMcsMCvw=;
 b=pNT6xcCIi0yMLDCxlMKz9gf0akTApPAEYc0uaD7mNOlanJULQs30iODtwdWnNz8sL4
 RdOiaI5tGxyZYpPBpF8r81WcCJjd3BQyR+CFqFlb3MH3NyhLzj7IlwECgSyV8n2okvoz
 NRs/yEPzYkoyS1NJMDNamiNuHHhxVHi3GNicikfLCPt2NVCX2IFlSkR3fiFLx6sLVrsv
 LSc1fuTAg+OzxEYAKbieKgEB2A7X+vMles7KYtzBRxJlB43idz0kTHSWsrb321NV644o
 wJfP283F9BfTFVKKGtPnFzrKPaZpzIYsz1Uc94wDOKYNGYp9jCkU9MiqKZTm4oQXyP9q
 5A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oAvZ5gj6xLua6e/c7b1iZR0wzMC/YFb04cZhMcsMCvw=;
 b=g3oE1K3QNhJ+lSFjnzdJca0E5+l+1TB+hXZgNonx7dlHB6O0jUJ9E2kaRWEbGqavFK
 C/6GYHUrsbZwD3TcZrkFcPGgdLodaxMs2gv54swNv82O2yszWDx7JwGogMCtjtOmI6Oy
 g1vNor+aShj29/SiKDALW6uZi4Ksqhc446V+fJvEr6V2zzW5DIgNwS0ZCKIuhEpbaokN
 AI/aEl++G3JIw23pi2kxmnK0Tlkqrz+d+LC3oMf8agq/Vjy7tHsf+gTCG+jlVZkQnPda
 j9tfbmjmqHZP8O9TNFB10NewqNHJH+pnBOOOHzOMuWmEmAkzvTkY2JRepuT+T+vu0DSr
 y7kA==
X-Gm-Message-State: AGi0PuY8SdeK7wtJWRRwcHzMSX2jJvCPH74FfcKneF9Bc1T6wxC/bAaS
 NSNuyC4Hn4kBs5DV5/sfYLXjyE6IMKwG321sd8A=
X-Google-Smtp-Source: APiQypJGQG5tE1j8h9DTGpLAL8bU9KoQm5jT/H+qHLotlX+Q8bhDVQtBY2KcgqMJDe/v/IbPRNztwX2TydfJs25avE0=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr23485349ilq.131.1588018653308; 
 Mon, 27 Apr 2020 13:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200427181649.26851-1-edgar.iglesias@gmail.com>
 <20200427181649.26851-3-edgar.iglesias@gmail.com>
In-Reply-To: <20200427181649.26851-3-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 Apr 2020 13:08:55 -0700
Message-ID: <CAKmqyKNFUL31QNh6vpOg65YuOd-=bPa334BJzdH_UO4+kHOZrw@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] hw/arm: versal: Move misplaced comment
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 27, 2020 at 11:25 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Move misplaced comment.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/xlnx-versal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index c73b2fe755..cc696e44c0 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -36,7 +36,6 @@ static void versal_create_apu_cpus(Versal *s)
>
>          obj = object_new(XLNX_VERSAL_ACPU_TYPE);
>          if (!obj) {
> -            /* Secondary CPUs start in PSCI powered-down state */
>              error_report("Unable to create apu.cpu[%d] of type %s",
>                           i, XLNX_VERSAL_ACPU_TYPE);
>              exit(EXIT_FAILURE);
> @@ -49,6 +48,7 @@ static void versal_create_apu_cpus(Versal *s)
>          object_property_set_int(obj, s->cfg.psci_conduit,
>                                  "psci-conduit", &error_abort);
>          if (i) {
> +            /* Secondary CPUs start in PSCI powered-down state */
>              object_property_set_bool(obj, true,
>                                       "start-powered-off", &error_abort);
>          }
> --
> 2.20.1
>
>

