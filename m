Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F3C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBA0214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 13:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4YIJbMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBA0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04GZ-0000DZ-34
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 09:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45301)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i04FT-0007Ut-6F
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i04FR-0006sV-V5
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:32:30 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i04FR-0006s9-Pf
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 09:32:29 -0400
Received: by mail-oi1-x242.google.com with SMTP id o6so4061145oic.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z2BViK2QdjCxdZh5z4oPHwBzGkXOPBN9gYNow4cOE1w=;
 b=Z4YIJbMBP2cIlysP1ywSFoj78QAILApDorgW6/7yBfxB7p9YKvc0UVT2YhfeEorK45
 SosIFhj5ZkXaIChI17wYCPIDwpZSGFs9qpvdwZ4pGn77HOVmx2RQg8kqyibsqngdzHqx
 /cg26Aa+j3Y4rQv35v+d11eU+bWW6bf6basQWmZeglaHWt2cBA/14f+q2nJnEmf5173q
 hsZfguWs7fy2gJgS405FxXfKHMKcg1fUuXHJug2WP4E7NvQwmGXUQqNWyRj0voY2tUUu
 1e94COmp9/FE7jj4aH31y168+YP//6oI72rlDnF78Nibk9wPn4qODdLRRA9e6o1Vq/ZL
 pw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z2BViK2QdjCxdZh5z4oPHwBzGkXOPBN9gYNow4cOE1w=;
 b=I57HlvwYMg5+cJw4UT50y3XfHF8Fk9kZaro9IXJXXv5ZZqBhaVCj9DgEvCV/FX6c/q
 AIf/+3kPERs544wQvkOuQ5fQNtil40YPjpEKg6NshI6fOgyqOyNl/tQZBwChCYEnGFNN
 /KIw3MqEFfsam622bXNpktTJ9o0RgFGb1uX6Wnmc3Rq/m0McRAP9XBWjB8Qca62TQ4/z
 4U8CG7ClXrmftmEUesP5WbvmsAUdmbWqIggdlZJmLfO85e76ZgXrtvpBErje0WFPJlcM
 ypX+1HXi6xDrSf1uv6c4Yy79nKtu3rhh9AiBJrsVP/LZ2E/J2ZqORNQBwkDZr8D179k1
 LKNA==
X-Gm-Message-State: APjAAAVhnRDYelMTnIx61czJwGO/Zh+NCXyGaOrnDw0LJlOSkcwUhWPv
 183hmdthPVN5z79cgkK5ivmb9AkPKD8j0ekZfPEIUA==
X-Google-Smtp-Source: APXvYqxUQXymDGt5CYPFk3EB78I+UMUVvdY4BzOKmClVxRjW17vCAQ3vi0B8K1lGdM2DI7Txw7I+h5d0o9DZau53bGA=
X-Received: by 2002:a54:4718:: with SMTP id k24mr11464oik.146.1566307948752;
 Tue, 20 Aug 2019 06:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180621062605.941-1-alex.bennee@linaro.org>
 <20180621062605.941-3-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 14:32:17 +0100
Message-ID: <CAFEAcA-1Uc6qgTSeQGvG3oV-FQwcAC6AKFKz3Fd_uFmTvGG_mw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL v2 02/57] configure: add support for
 --cross-cc-FOO
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
Cc: Alexander Graf <agraf@suse.de>, "Daniel P. Berrange" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Jun 2018 at 07:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This allows us to specify cross compilers for our guests. This is
> useful for building test images/programs. Currently we re-run the
> compile test for each target. I couldn't think of a way to cache the
> value for a given arch without getting messier configure code.
>
> The cross compiler for the guest is visible to each target as
> CROSS_CC_GUEST in config-target.mak. This is quoted to handle the case
> of --cc=3D"ccache gcc".
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Hi -- this is an old commit from last year, but I've just noticed
(by code inspection) a bug in it:

> diff --git a/configure b/configure
> index a5fd46c9d4..ab189067cb 100755
> --- a/configure
> +++ b/configure
> @@ -458,6 +458,13 @@ vxhs=3D""
>  libxml2=3D""
>  docker=3D"no"
>
> +# cross compilers defaults, can be overridden with --cross-cc-ARCH
> +cross_cc_aarch64=3D"aarch64-linux-gnu-gcc"
> +cross_cc_arm=3D"arm-linux-gnueabihf-gcc"
> +cross_cc_powerpc=3D"powerpc-linux-gnu-gcc"
> +
> +enabled_cross_compilers=3D""
> +
>  supported_cpu=3D"no"
>  supported_os=3D"no"
>  bogus_os=3D"no"
> @@ -488,6 +495,11 @@ for opt do
>    ;;
>    --disable-debug-info) debug_info=3D"no"
>    ;;
> +  --cross-cc-*[!a-zA-Z0-9_-]*=3D*) error_exit "Passed bad --cross-cc-FOO=
 option"
> +  ;;
> +  --cross-cc-*) cc_arch=3D${opt#--cross-cc-}; cc_arch=3D${cc_arch%%=3D*}
> +                eval "cross_cc_${cc_arch}=3D\$optarg"
> +  ;;
>    esac
>  done
>  # OS specific
> @@ -676,30 +688,37 @@ case "$cpu" in
>    ppc|ppc64|s390|s390x|sparc64|x32)
>      cpu=3D"$cpu"
>      supported_cpu=3D"yes"
> +    eval "cross_cc_${cpu}=3D\$host_cc"
>    ;;
>    i386|i486|i586|i686|i86pc|BePC)
>      cpu=3D"i386"
>      supported_cpu=3D"yes"
> +    cross_cc_i386=3D$host_cc
>    ;;

In the various arms of this switch, we use $host_cc.
Unfortunately, we don't process the --host-cc=3D option
until further down in the script, so this will only ever use
the default ("cc") even if the user tries to override it on
the configure command line. For this to work we need to
pull the handling of --host-cc=3D up into the "parse CC options
first" option handling code.

thanks
-- PMM

