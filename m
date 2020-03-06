Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE7C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B512084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=koconnor.net header.i=@koconnor.net header.b="O3IaqgE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B512084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koconnor.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADG6-0000Z7-GM
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin@koconnor.net>) id 1jADEV-0007ad-Cx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin@koconnor.net>) id 1jADEU-0004OJ-56
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:41:43 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:42342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1jADET-0004Ad-Pz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:41:42 -0500
Received: by mail-qv1-xf44.google.com with SMTP id e7so909070qvy.9
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koconnor.net; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=e89Tvray7YiNpoTtdaLsmyepCvFKuGHFgOaCRzKTkco=;
 b=O3IaqgE2Tnz3x50pP6XaUbUr3bswL48Nh5mRfEVjCxGtqyJs7uilysZMn/B+RzwFcY
 i5ScWQb+21JX9jP/h0S4Hc1FPePQUNFHwvAdCBtZWYDqWwqE5to8RHFTpg38FmdgFb5s
 0tOqXW/uTuxLbBUqxJYup2POWEyFICS7grwvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e89Tvray7YiNpoTtdaLsmyepCvFKuGHFgOaCRzKTkco=;
 b=Ycubj3l3Alrxry0ODSH5r4GmcTMw4B5IW+My8A/YljYgnbPJGiuIh55LUOGxzavLa0
 YZaUiBlBnDEFcqglmWWXPXUJpNu6v35WHI7v0HXOv2E+Ak0z+tHCFvGlLOSDH4+GVXpp
 k46y5WOKWzpPpmcC2XD19VOXG6b7JoCDxVkaHBod2rJHvy35I+DIkPgdhFoyGgURll0h
 ACUhq5ay2q4SJfdww8AqnwfeFjUVB3gS8xTY93Yqxmg8vgBTv35bf80NUOTh66SA3Bnj
 Jh633JoS/W6B1cHxp6HSRazJHgB78IHGReLnqpqxG14+JwmM3Dm92uTVqfAGwkBl5KzL
 070Q==
X-Gm-Message-State: ANhLgQ3S15OrVkivPj8dVwOMVMvFAD19RJRzrNLOFn2+8lkRbVWe2TuW
 DE+IEbomc27w0K8FOyzr8ifPhQ==
X-Google-Smtp-Source: ADFU+vsXt3ZkyWJJYZbEdI8zLDIBQ2sX5FIo7n3lA0guXgWaPINV8hq/fzEvrqjNun+1ePZNIYFXwQ==
X-Received: by 2002:a05:6214:15c7:: with SMTP id
 p7mr2793028qvz.59.1583502100823; 
 Fri, 06 Mar 2020 05:41:40 -0800 (PST)
Received: from localhost ([64.9.245.135])
 by smtp.gmail.com with ESMTPSA id o2sm17431247qkd.93.2020.03.06.05.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:41:39 -0800 (PST)
Date: Fri, 6 Mar 2020 08:41:39 -0500
From: Kevin O'Connor <kevin@koconnor.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] sercon: vbe modeset is int 10h function 4f02 not 4f00
Message-ID: <20200306134139.GD12821@morn.lan>
References: <20200306090321.24811-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306090321.24811-1-kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: seabios@seabios.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 06, 2020 at 10:03:21AM +0100, Gerd Hoffmann wrote:
> Fixes console redirection for NetBSD primary bootloader.
> 
> https://bugs.launchpad.net/bugs/1743191
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  src/sercon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sercon.c b/src/sercon.c
> index a5dadb7261af..66a1f2412e77 100644
> --- a/src/sercon.c
> +++ b/src/sercon.c
> @@ -464,7 +464,7 @@ static void sercon_104f(struct bregs *regs)
>          regs->ax = 0x0100;
>      } else {
>          // Disable sercon entry point on any vesa modeset
> -        if (regs->al == 0x00)
> +        if (regs->al == 0x02)
>              SET_LOW(sercon_enable, 0);
>      }
>  }

Reviewed-by: Kevin O'Connor <kevin@koconnor.net>

-Kevin

