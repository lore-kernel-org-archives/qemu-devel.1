Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE14EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D84D2224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukJKUn2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D84D2224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQaG-0002Fc-2X
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUQYA-00010F-Ou; Mon, 19 Oct 2020 04:29:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUQY3-0004aB-Rs; Mon, 19 Oct 2020 04:29:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id a72so9398855wme.5;
 Mon, 19 Oct 2020 01:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GEARRo0wy+RP7Fj/JfONUu9+xerXxS/Pp4hGL/zTO/o=;
 b=ukJKUn2Pm1Q5Ix/z5PxnQJleITmMTyz2hME62edjvIk+UQM2SqXnCVeqOSO3tGUqou
 NQEATokGv2L34U+EmBXNnaCnUffSoIuHr/msjgzmfEwib9QedXfG3ZRIcXTHJTujvPwj
 ufIYvP9Xyy3PBZQO04XiCmJbU0MPAOLZOKCFeyGjF9W34w/L8hS7VrjB4Xt4dS2oM619
 DFGxhLDecmn4X5CiHeBqIEcGE00hOafjMDz69xOj3PRqrNZiT5L7KHOl4KoF71ikFSUI
 DI0cnF0B1mXey1b5Hy7t7yA9l6FL+kEF0IO6H4BLGoS17+KldhVSnCDxK7WLmFA8FtxD
 1mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GEARRo0wy+RP7Fj/JfONUu9+xerXxS/Pp4hGL/zTO/o=;
 b=XqS2HeXnSfs6M+U1mK81+kWhmxT3nj2E2YjlWWgrm/prwfxGxYwe1Y3FzgdnrWVKqy
 4WHYXq0gwPM/f/zroOYoF8/4zoaPKNo6Nn7EL3cgYm6+GRReInu4JBW+O1WvqVHt2G+K
 uAegiciVSRVp1Tu0cXmyZ+msAh0vkRBkTrxpqBzoyzoUAefRcvVlr2Sos1CjsWncjfgy
 wDVE/y1vtW654izGu0R21QcCk2WWT2Wo2u8fXVyfe2bJeSfdSFgf99IUh3u3Kk44v+Oe
 aIjVh42Ig+CGuWPovcEL9hbcvapuHPPhus5q8QU/GxxoxVVjJuCwRs6WBkdIxY3JDgFP
 lOBg==
X-Gm-Message-State: AOAM533zNFHRtQuZaUU+m08ZaCYSAL+0tVRJ+1xzZi0hb0k2pqvJ2tHC
 cwpySJckEzEsrGLRZ6ZflTc=
X-Google-Smtp-Source: ABdhPJxIb0iMjNEj/WP3Dhep+qL/ZBwAcH3wW9bs7EwOj1uUuDHkyr6ZIXFzpLlGxCbnn/enPrs6gg==
X-Received: by 2002:a05:600c:d5:: with SMTP id
 u21mr16891909wmm.28.1603096180856; 
 Mon, 19 Oct 2020 01:29:40 -0700 (PDT)
Received: from [192.168.1.36] (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id g17sm10078630wrw.37.2020.10.19.01.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 01:29:40 -0700 (PDT)
Subject: Re: [PATCH] docs/system: Deprecate raspi2/raspi3 machine aliases
To: qemu-devel@nongnu.org
References: <20201019082121.1544550-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8cd54e7f-4f81-0d03-16a2-349364d71f85@amsat.org>
Date: Mon, 19 Oct 2020 10:29:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201019082121.1544550-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: libvir-list@redhat.com, qemu-arm@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 10:21 AM, Philippe Mathieu-Daudé wrote:
> Since commit aa35ec2213b ("hw/arm/raspi: Use more
> specific machine names") the raspi2/raspi3 machines
> have been renamed as raspi2b/raspi3b.
> 
> As more Raspberry Pi 2/3 models are emulated, in order
> to avoid confusion deprecate the raspi2/raspi3 machine
> aliases.

Note that the raspi3ap (posted yesterday) is a closer match
to what we model than the raspi3b. But the B model has 1GB
of RAM, while the A+ has 512MB. As a bigger amount of RAM
is probably more useful to our users, I'm not suggesting
replacing the raspi3 alias.

> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   docs/system/deprecated.rst | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 905628f3a0c..f0c7aaeb2ff 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -355,6 +355,11 @@ This machine has been renamed ``fuloong2e``.
>   These machine types are very old and likely can not be used for live migration
>   from old QEMU versions anymore. A newer machine type should be used instead.
>   
> +Raspberry Pi ``raspi2`` and ``raspi3`` machines (since 5.2)
> +'''''''''''''''''''''''''''''''''''''
> +
> +These machines have been respectively renamed ``raspi2b`` and ``raspi3b``.
> +
>   Device options
>   --------------
>   
> 

