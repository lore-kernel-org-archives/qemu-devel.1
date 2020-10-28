Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C6C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2260A2462E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJGEB8Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2260A2462E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjXq-0005fk-34
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kXjWo-00057K-Kn; Wed, 28 Oct 2020 07:22:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kXjWm-0001Q7-Vs; Wed, 28 Oct 2020 07:22:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so1447707wrg.12;
 Wed, 28 Oct 2020 04:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PoB1j83fPqHYj31EkTkWJz/I+p7LKOL058p39XpVVIM=;
 b=FJGEB8CsU9IetbERHxG58qv5J1U5dZeDSrdsoONbw71bhtcEe5bLcMbci1/ukHvRll
 HBxUnD6a0E6pWXPV9PdP+p7KZTyGLEkAlyQmbmu/souF3Cyyyt1ZQ9cGH5bbw8KDykBu
 /wsixvfGqqR8YwusjQDI3UCpfM62aelBWa1pi1z7pzyqjB9qZc+vX0ZQgYJdxaIDdH7k
 9GeGzjaFlyYUW0903WxB2Akqo5k6r9L5n3uj+jlm+N776xlbRaQAjIINhOa6RVFG76/I
 rewNmjvA1OGdapKNJFjc0eKAD/92K1gpdTicMpJzOi/a8DShfhSbih7+fQ3EQQCSWXaK
 wIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PoB1j83fPqHYj31EkTkWJz/I+p7LKOL058p39XpVVIM=;
 b=FQwr2fes0JMciOVBNRK6PA8Un8Z2yBBmdSKobheb3r4HiIcgEODotjHu8qih8jInbo
 7mZY1iaRRh36Sz+UJtoqHeN/fWz5JxF5HZ/T9HnOeDi5ROrHsoPCKci6h5w0Ri8s0T/l
 mutdoz5mBzTWDUTROAYRmGuv12EwuIg40S48jlIPCLem0gKcO0H/0BOqQUDaLkx1SrK4
 flGyJYAEVtvDLJJ4qYucpxwS7TdzV0DGigl3m+htpsjy2azOl1G+3Q9ZsmE4RqhmF4xi
 CRJJm2/zqu0WMUbEOxZfSZR6LdGwb1Bb43wm1bh7wp5bVVvKL+VHtzYckk0qY7tf8/dJ
 fuHg==
X-Gm-Message-State: AOAM533qZqNYRYkrAh1K0u/qwIaAQz/3jA40lrlZGja90CiD7zI+8ZFn
 CK9ABMKSIV7mHW+e0ifA/nw=
X-Google-Smtp-Source: ABdhPJxFyq5XfuIYYLNJQFbbWzZHHyMmagUtE0gpuMiwuIR3Peblk7Kc/d1SyodW0PFPx47rWrgySg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr8962077wrp.394.1603884122551; 
 Wed, 28 Oct 2020 04:22:02 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 71sm6645667wrm.20.2020.10.28.04.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 04:22:01 -0700 (PDT)
Date: Wed, 28 Oct 2020 11:22:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 1/7] configure: option to disable host block devices
Message-ID: <20201028112200.GF221115@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-2-j@getutm.app>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3yNHWXBV/QO9xKNm"
Content-Disposition: inline
In-Reply-To: <20201028030701.14086-2-j@getutm.app>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "open list:raw" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3yNHWXBV/QO9xKNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 08:06:55PM -0700, Joelle van Dyne wrote:
> Some hosts (iOS) have a sandboxed filesystem and do not provide low-level
> APIs for interfacing with host block devices.
>=20
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  configure          | 4 ++++
>  meson.build        | 1 +
>  block/file-posix.c | 8 +++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)

A change along these lines is needed in qapi/block-core.json:

  { 'enum': 'BlockdevDriver',
    ...
    { 'name': 'host_device', 'if': 'defined(CONFIG_HOST_BLOCK_DEVICE)' }

That way the QAPI schema reflects the QEMU binary's actual features.

>=20
> diff --git a/configure b/configure
> index 71bbe82ac5..4e68a5fefe 100755
> --- a/configure
> +++ b/configure
> @@ -448,6 +448,7 @@ ninja=3D""
>  skip_meson=3Dno
>  gettext=3D""
>  mirror_jit=3D"no"
> +host_block_device_support=3D"yes"
> =20
>  bogus_os=3D"no"
>  malloc_trim=3D"auto"
> @@ -5901,6 +5902,9 @@ if test "$default_devices" =3D "yes" ; then
>  else
>    echo "CONFIG_MINIKCONF_MODE=3D--allnoconfig" >> $config_host_mak
>  fi
> +if test "$host_block_device_support" =3D "yes" ; then
> +  echo "CONFIG_HOST_BLOCK_DEVICE=3Dy" >> $config_host_mak
> +fi
>  if test "$debug_tcg" =3D "yes" ; then
>    echo "CONFIG_DEBUG_TCG=3Dy" >> $config_host_mak
>  fi

How do you disable CONFIG_HOST_BLOCK_DEVICE? There is no ./configure
--disable-host-block-device option.

--3yNHWXBV/QO9xKNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZVFgACgkQnKSrs4Gr
c8iYuwf/X50i0Xui3Cc5eLsManskv0iFpWSa+g5gmn+i98jSJrwFSU8m/2oD09Vv
FTpNGl6tGXUcFkArQF41F+5vdpJMf5X+hldY1TarHfZLzHXxYTGh+OyHkhi0/Cio
vay6vJGu6uYNshaGuFXGg2psJlTQ2BZ0NcxJ3LVvAH2kSMzy8nULEdi7hsVOsET+
VwrylhjoD4yKRABVY011m7fyw2MHx17p8mIthQY1plUWLUeF4Uf9RQUHB0O1kxh9
lbNKW7L9AWE2q3U6Ci70Km/axhNKwjgP4ZAp93plfw+XLBnHJ5MAtFuyEk4VkQh4
N4mPpdskn9RFhc1bc8QO6nDTzdQR3w==
=a7BG
-----END PGP SIGNATURE-----

--3yNHWXBV/QO9xKNm--

