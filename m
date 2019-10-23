Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E21CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650FC2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650FC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNFkF-0002kA-8P
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNFiq-0001sH-IY
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNFip-0008U0-2g
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNFio-0008To-Qu
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:26:39 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87CCA83F4C
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 12:26:37 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id q22so7195273wmc.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 05:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kG2VJPWlib/EVgwK7cjcMhWIbOFL3UnY50Xn1k3+8YQ=;
 b=D6dpGT6pTTrsxvAATc0wFDppCJ3EvpG9jOocEKi5H80NrRW0U75iW3bz5OfRGvMt1P
 ykmS5CWNZwR/qYlTOk5GheMes4szULUekis2X5spo6pPoxRejOOpT2zEl/2r4HKnEzvi
 Vzp7HCnE49tkduAFf68yGW44DQRlE/g9CyOADySFvnyTofGcOXKlF4lISoAItFiTB8dI
 xToWoDRHbT84KGe5DeuqrmUnY8Bp0N4uqztyTK8M27EWhX8DcqevRDC16I7OnW/ETcog
 1Caqk00NDiFhY0BB9hRRpqElcEmuchiH2Eke9b/wpPurUxbjCS/KxDCNWMXkum/2fziY
 jBVg==
X-Gm-Message-State: APjAAAXkLF/Hu1FK3guGp5tB6KrvhorZXQmdR1q3Ibj7kqNU0lMUZ1Dv
 i4846KRK8mYDn1dQ2Zm2lKI7K0yERavdJUKpH11xCw7HJSfYKnfNoNujP+4RWRyKLlCqP1VAhmt
 WgT6YjZUNqVQBdKo=
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr7627684wma.17.1571833596316; 
 Wed, 23 Oct 2019 05:26:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5jPTehaexsTYblw4Ojlb/COLFKn/+L/j2Zl89zptSWkjU83ENR0quX++IXYV4oyNCkl703Q==
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr7627666wma.17.1571833596108; 
 Wed, 23 Oct 2019 05:26:36 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id y3sm35088409wro.36.2019.10.23.05.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 05:26:35 -0700 (PDT)
Subject: Re: [PATCH] qemu-options: Rework the help text of the '-display'
 option
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20191023120129.13721-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41420b03-b938-2e62-2b33-5cc63e488fe5@redhat.com>
Date: Wed, 23 Oct 2019 14:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023120129.13721-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 2:01 PM, Thomas Huth wrote:
> Improve the help text of the "-display" option:
>=20
> - Only print the options that we have enabled in the binary
>    (similar to what we do for other options like -netdev already)
>=20
> - The "frame=3Don|off" from "-display sdl" has been removed in commit
>    09bd7ba9f5f7 ("Remove deprecated -no-frame option"), so we should
>    not show this in the help text anymore
>=20
> - The "-display egl-headless" line was missing a "\n" at the end
>=20
> - Indent the default display text in a nicer way
>=20
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   qemu-options.hx | 30 +++++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 996b6fba74..917c54b302 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1526,26 +1526,38 @@ STEXI
>   ETEXI
>  =20
>   DEF("display", HAS_ARG, QEMU_OPTION_display,
> +#if defined(CONFIG_SPICE)
>       "-display spice-app[,gl=3Don|off]\n"
> -    "-display sdl[,frame=3Don|off][,alt_grab=3Don|off][,ctrl_grab=3Don=
|off]\n"
> +#endif
> +#if defined(CONFIG_SDL)
> +    "-display sdl[,alt_grab=3Don|off][,ctrl_grab=3Don|off]\n"
>       "            [,window_close=3Don|off][,gl=3Don|core|es|off]\n"
> +#endif
> +#if defined(CONFIG_GTK)
>       "-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|\n"
> +#endif
> +#if defined(CONFIG_VNC)
>       "-display vnc=3D<display>[,<optargs>]\n"
> +#endif
> +#if defined(CONFIG_CURSES)
>       "-display curses[,charset=3D<encoding>]\n"
> +#endif
> +#if defined(CONFIG_OPENGL)
> +    "-display egl-headless[,rendernode=3D<file>]\n"
> +#endif
>       "-display none\n"
> -    "-display egl-headless[,rendernode=3D<file>]"
> -    "                select display type\n"
> -    "The default display is equivalent to\n"
> +    "                select display backend type\n"
> +    "                The default display is equivalent to\n           =
     "

Easier to understand in 2 lines:

        "                The default display is equivalent to\n"
        "                "

Regardless,
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   #if defined(CONFIG_GTK)
> -            "\t\"-display gtk\"\n"
> +            "\"-display gtk\"\n"
>   #elif defined(CONFIG_SDL)
> -            "\t\"-display sdl\"\n"
> +            "\"-display sdl\"\n"
>   #elif defined(CONFIG_COCOA)
> -            "\t\"-display cocoa\"\n"
> +            "\"-display cocoa\"\n"
>   #elif defined(CONFIG_VNC)
> -            "\t\"-vnc localhost:0,to=3D99,id=3Ddefault\"\n"
> +            "\"-vnc localhost:0,to=3D99,id=3Ddefault\"\n"
>   #else
> -            "\t\"-display none\"\n"
> +            "\"-display none\"\n"
>   #endif
>       , QEMU_ARCH_ALL)
>   STEXI
>=20

