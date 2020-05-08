Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E025BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A648D20708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4Bm9NJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A648D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX3Jc-0007vw-OG
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <changbin.du@gmail.com>)
 id 1jX3Io-0006qO-JJ
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:44:34 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <changbin.du@gmail.com>)
 id 1jX3In-0007Uh-9i
 for qemu-devel@nongnu.org; Fri, 08 May 2020 09:44:34 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a5so4291207pjh.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=F+E75ICeA2GJwn0vXrw85dqpoWG2OQuILd1/YbbgQc8=;
 b=G4Bm9NJEcskRvbkASpDLuHDKWSiiofFFy5M2+8s9eqyi8NCwn6kX9zx1Qd580Av5pg
 a/TtUZ3Fcd8Vc4BW1+U2bm9Fd1Ey5PCMaJ7208BhsVatUtda4K3K0KtAjJ8PoGNHVK+c
 4wKZ20mD4FcGpuq+LxAl1o2LksP9XDiz/a1vc+1utddcFqYLnhxZ6Q4dHwb0fkHwIjMe
 TLoqBJI1yLasgef4m6bv0cabUDyV61Ao3pp5aTONNzzTz4HVf1dPmyw8RqyF3GSl3FPL
 r0ShlDBX8L6HSkaYJOCDo08v8EvdC+zBpIYqIiYUeTTnLwoNGCX0RoIZWxpXGBm19UKS
 +iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F+E75ICeA2GJwn0vXrw85dqpoWG2OQuILd1/YbbgQc8=;
 b=GAR5siUq0nmRfSpXoSHYZzsBRF7dW7cQZxbFVbqNjF87o5EfA0UzTO7wWgsRSQBdIe
 6n5RDDN4pZpfN12yXiSBefNSJkPUhjkwSe3oK6EqlPkmuSZXdIPrhDacUBiEDpRhri6s
 uv5Gfi1CRqYSOxIvntmZKQfb4Gtk1pwDa+ABf1hNpC3EP2sTieE6Fp0G2kkZxDrYpjbi
 By3kBPz9leY0mcnh3dFHKiumoF65iKNgWmbCjr7aZf8etMGnmV6v55+sFbYUcClCj3NB
 KRTfwFXEXtYiMj+869Ad1Tz37FappELdtnsGMANMqhiSlUtlmLxnHadLFvF0JqG5UnxH
 I2Iw==
X-Gm-Message-State: AGi0Pua/gTUQlKeo5XStlCKrakmn4ZKpkvZa/KLBrn+to8L8Kuo7P7RU
 Hy4kmPtxHHEz0PPrsL/7b/c=
X-Google-Smtp-Source: APiQypI0YFlTMT8v39OGI4MFeE15GFt3Mncf5M6kpZkYsrgG5GewU9Oj/kbMGmQCTujA6z5UwHQtvg==
X-Received: by 2002:a17:902:bc8c:: with SMTP id
 bb12mr2414760plb.142.1588945471350; 
 Fri, 08 May 2020 06:44:31 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id m6sm2515648pjo.5.2020.05.08.06.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 06:44:30 -0700 (PDT)
Date: Fri, 8 May 2020 21:44:24 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH v2] ui/sdl2: fix segment fault caused by null pointer
 dereference
Message-ID: <20200508134424.dg44xm7lt4ahqftn@mail.google.com>
References: <20200427132412.17909-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427132412.17909-1-changbin.du@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=changbin.du@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hello, is this ready to merge now?

On Mon, Apr 27, 2020 at 09:24:12PM +0800, Changbin Du wrote:
> I found SDL_GetWindowFromID() sometimes return NULL when I start qemu via
> ssh forwarding even the window has been crated already. I am not sure
> whether this is a bug of SDL, but we'd better check it carefully.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> ---
> v2: fix typo.
> ---
>  ui/sdl2.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/ui/sdl2.c b/ui/sdl2.c
> index 3c9424eb42..61c7956da3 100644
> --- a/ui/sdl2.c
> +++ b/ui/sdl2.c
> @@ -332,6 +332,10 @@ static void handle_keydown(SDL_Event *ev)
>      int gui_key_modifier_pressed = get_mod_state();
>      int gui_keysym = 0;
>  
> +    if (!scon) {
> +        return;
> +    }
> +
>      if (!scon->ignore_hotkeys && gui_key_modifier_pressed && !ev->key.repeat) {
>          switch (ev->key.keysym.scancode) {
>          case SDL_SCANCODE_2:
> @@ -412,6 +416,10 @@ static void handle_keyup(SDL_Event *ev)
>  {
>      struct sdl2_console *scon = get_scon_from_window(ev->key.windowID);
>  
> +    if (!scon) {
> +        return;
> +    }
> +
>      scon->ignore_hotkeys = false;
>      sdl2_process_key(scon, &ev->key);
>  }
> @@ -421,6 +429,10 @@ static void handle_textinput(SDL_Event *ev)
>      struct sdl2_console *scon = get_scon_from_window(ev->text.windowID);
>      QemuConsole *con = scon ? scon->dcl.con : NULL;
>  
> +    if (!con) {
> +        return;
> +    }
> +
>      if (qemu_console_is_graphic(con)) {
>          return;
>      }
> -- 
> 2.25.1
> 

-- 
Cheers,
Changbin Du

