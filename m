Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91100C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A84920767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 17:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLcUQuzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A84920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtaNH-0007Zm-Ln
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 13:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtaMP-0006ep-9L; Thu, 09 Jul 2020 13:29:25 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:36031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtaMN-0005sV-Py; Thu, 09 Jul 2020 13:29:24 -0400
Received: by mail-il1-x143.google.com with SMTP id x9so2735294ila.3;
 Thu, 09 Jul 2020 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kg3vulcViJ5NZ8i32SzvI/Z/cX1arq3vsxxMMfhISXA=;
 b=pLcUQuzuvbaclDPNj/S9PnAmB8/qre6Ee4ZDdwN0lQGSDsAt8v2P/PBOV0Nk3hLnBt
 2WdraSRkw2Yre4CN4eHeeQZdY0psy6J6cTnv0MwwxY3erC0MeTTYyzdt9VXj6PYEwAvz
 dL6yjT1rrmrLrdG5XCxGdOSYfLMZh8UwJxkIUubHBl0fZaOYMbRhf6lPUXDM5XlmlQL3
 Z4+u0nFMUki90mNHCvweML2WI/qr38MPoXCuT30DnWylL2azT7qflsurDMTWBzf4Yday
 xncpKGNs6GwF6vgEMXkvqDvu642SfRlxMxqegvFLym7wSN//DRb6ioNXORT1Xk5TqUA6
 QcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kg3vulcViJ5NZ8i32SzvI/Z/cX1arq3vsxxMMfhISXA=;
 b=uaMKhzWYdDKS0k/WT4eyHRYGpAWdP9M6kYp/P8rNXcjJEa0URLnEKgjuRF8h14EPTm
 NqNdgqysHHfL2jPWsN478cR+R4ndlZ8mGqgAokfPvJMw1f2oecDbCbRpisxFK9ZWuIhI
 vDLYZJ+HaE+TGoaSgC3nSrA7sRmJ70bfcdLv3eOTEcg7zFZ+G8LUYHIcRB1qIWK4HUf7
 ByYA6tUVELyOTEYPQPCB0dgfblYe14L6V1Z1NCkkiC4VPb2f/K2p8pZfSuu+5gksAmkI
 pdph4irime8U0UbYtFAibgpY3fIoMB3nKwYHCCgmSCXboaGw6TWBMSFCq4M/yigY6QB1
 IBHg==
X-Gm-Message-State: AOAM531FrHfQrSav1qA7Rb9k+9W6oYj9lrDfnVNEsxiA9CIXJj2IpwjK
 xmg4qwC13GD0uOpyM648fdIEDYnMm/crwyK0lcE=
X-Google-Smtp-Source: ABdhPJxXRl17MyjGzspS+tKx2ihM/zFWxiJ1R8X8BA1JssGEdWRAjucDieJ6bsxvzP5iRj7yHSetM6zbY9+1lNuX+34=
X-Received: by 2002:a92:bb84:: with SMTP id x4mr49473932ilk.177.1594315762593; 
 Thu, 09 Jul 2020 10:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200707062308.4531-1-f4bug@amsat.org>
 <772cb98e-865c-0c75-ffa2-60773a6df2dd@vivier.eu>
In-Reply-To: <772cb98e-865c-0c75-ffa2-60773a6df2dd@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2020 10:19:31 -0700
Message-ID: <CAKmqyKOebG+=vFMXoNKA+4A__hq5srKV6oGa1TOcmiaLYUgTww@mail.gmail.com>
Subject: Re: [PATCH] hw/register: Document register_init_block @memory_size
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 5:43 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 07/07/2020 =C3=A0 08:23, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> > Document the 'memory_size' argument of register_init_block().
> >
> > Fixes: a74229597e ("register: Add block initialise helper")
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  include/hw/register.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/hw/register.h b/include/hw/register.h
> > index 5d2c565ae0..fdac5e69b5 100644
> > --- a/include/hw/register.h
> > +++ b/include/hw/register.h
> > @@ -181,6 +181,7 @@ uint64_t register_read_memory(void *opaque, hwaddr =
addr, unsigned size);
> >   * @data: Array to use for register data, must already be allocated
> >   * @ops: Memory region ops to access registers.
> >   * @debug enabled: turn on/off verbose debug information
> > + * @memory_size: Size of the memory region
> >   * returns: A structure containing all of the registers and an initial=
ized
> >   *          memory region (r_array->mem) the caller should add to a co=
ntainer.
> >   */
> >
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Can this go via the trivial tree?

Alistair

>

