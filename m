Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131E5C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D5932083B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 13:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D5932083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heJNF-0001Dq-AT
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 09:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47893)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1heJL1-0000N8-1g
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:12:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1heJKx-0003rG-VZ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:12:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1heJKx-0003RI-RV
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 09:12:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id w79so4597288oif.10
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 06:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YINBaTWXEbwhgYdzi7qGBLBSGn/mqw703doVZgSBy30=;
 b=RAn4kiby19uPde9BAvrhcImGdpQZ/XF6qZ1KDhPBd+MTE+vhk16P3MGKpF7BUvJxAH
 0Yf41tMJFRNGOSnH+ABnxu/mpgx5cvcLMWuLvNXn7npSSaTbFLgtTWJrbSJCqFvYcArp
 Dzpjy8ZriQCN6UiCUJ7p0VHnt3cRM9gaXPmgGsjr2X7asB+rlU9lEuAg3FZO+uYb8NTP
 h5dlw/YnuVqwzRYcMw9LNzUXbBU3RAV7o53+Txu96EkW3jels1dH036uAxHz2Y+s5K+5
 y6f218qFGiJuhGM1Mjj6yaDKMOoMA0u5e9LV8Vr47bEt8vhmpQrwV8AMNP1lRpqP4irp
 28/A==
X-Gm-Message-State: APjAAAUhVa99SXD3/G4OOe391aOib1tBg3OS9xVE1DIBejHS0DII1p5h
 cdLFA81cZJOIYug6p0OvOpo8Dsm+0sO0HIA37BCV/Q==
X-Google-Smtp-Source: APXvYqzGDafFUCVt02tDf1ti+gLtiBvg+kKeR2OYtqoTjIwQwb1elsG2baNKuG8eU6Q6DAwrKf5w+QCP5y4OW1Rle+w=
X-Received: by 2002:aca:ec0f:: with SMTP id k15mr2585061oih.13.1561122709400; 
 Fri, 21 Jun 2019 06:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190621130544.18860-1-lvivier@redhat.com>
In-Reply-To: <20190621130544.18860-1-lvivier@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 21 Jun 2019 15:11:38 +0200
Message-ID: <CAMxuvaw61P8yEmfi_Gaumccz7ybjRha=2Xxiybg0T8nKGaOZtw@mail.gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
Subject: Re: [Qemu-devel] [PATCH] configure: linux-user doesn't need neither
 fdt nor slirp
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Jun 21, 2019 at 3:05 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> if softmmu is not enabled, we disable by default fdt and
> slirp as they are only used by -softmmu targets.
>
> A side effect is the git submodules are not cloned
> if they are not needed.
>
> Clone and build can be forced with --enable-fdt and
> --enable-slirp.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

lgtm
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  configure | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/configure b/configure
> index b091b82cb371..4b3853298c79 100755
> --- a/configure
> +++ b/configure
> @@ -4066,6 +4066,11 @@ if test "$fdt_required" =3D "yes"; then
>    fdt=3Dyes
>  fi
>
> +# linux-user doesn't need fdt
> +if test -z "$fdt" -a "$softmmu" !=3D "yes" ; then
> +    fdt=3D"no"
> +fi
> +
>  if test "$fdt" !=3D "no" ; then
>    fdt_libs=3D"-lfdt"
>    # explicitly check for libfdt_env.h as it is missing in some stable in=
stalls
> @@ -5923,6 +5928,11 @@ fi
>  ##########################################
>  # check for slirp
>
> +# linux-user doesn't need slirp
> +if test -z "$slirp" -a "$softmmu" !=3D "yes" ; then
> +    slirp=3D"no"
> +fi
> +
>  case "$slirp" in
>    "" | yes)
>      if $pkg_config slirp; then
> --
> 2.21.0
>

