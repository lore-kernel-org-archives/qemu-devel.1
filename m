Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6E2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EA820723
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhqKyTgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EA820723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkU0-0001Gj-RP
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnk9t-0005Xi-9K
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:44:21 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnk9r-0003AZ-GL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:44:20 -0400
Received: by mail-wm1-x341.google.com with SMTP id g21so3527876wmg.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mOg5McH8fdn1WxHrrTudyb6+w1INC2IchovK8MnF2Ps=;
 b=XhqKyTgGxQe8wVnd3ecmyygszyX7Ku5El7mN2ji+AEyJpcZCiAkWckPpcaZZsqqqqV
 HGlH+pXCbpdY5dwYBLcG7jePM936AoUhVT6drFRtkN+YuIerNbHbR9Nrj8UZDxYhZZUP
 Ym00tA9aJkC9D9soWnp3NkMx4dZLlHT0orF82aVAemiDPVddZ5k9XZIAHzL1KvB5eoWC
 i57zqFidiq11FdQ80/+rp4Mori8PuEwX2k6IbgWAhM+9m9FTPwxZNREW49cQSPrnUlhK
 S2AcV2oiioHwse73BM8AqDxColxulUKIX3xm1dKZuTC/zUMimFlNJi01F9plXagGXJPk
 sKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mOg5McH8fdn1WxHrrTudyb6+w1INC2IchovK8MnF2Ps=;
 b=tTO8Nq0O90NE2StNw4qi/mR/Y1LaYjQnAl2wPzRodyKFZGIiI2/hYzN6xrHjlHsWbE
 Uut9v41/AxxbDxlWgnpTVhc1Pmb/mm87eEAT/zRNB+08I+xiMFZ5H/+XppefqcH40NfX
 fbvGpF2t8HyzkzYGVAIqEgglcMLxjBED1ONLSOo1lawnVp5l6a+f97lEIxQP1PtmC9Qy
 seAgnTl1pGG/K7EpL7NqHdjB8Q2jhyugoM63ttGgGnXp04Pl+85UXLKbju6LA+fY8+59
 O/cMWM5TMRieUioKvGZY3sPM065wBq1GeW9Dtnj3Esv8gKbyufA8hwoDsSyA6vA4tnJb
 Yw7g==
X-Gm-Message-State: AOAM533Oey0hTEHwLPZPIieiBSIWHEnqo/66cG7CO/5+nFYZlcxGv/co
 zxrW/vGBMK5pHj46vW4m+B4=
X-Google-Smtp-Source: ABdhPJwI6h3+vQbyt78M8KZ1MtpF1EcCYgv5d8fXrZI59HHMOkp+/B8Qsa10HajBPTpu7qTB3wQtfQ==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr4991167wme.102.1592923457644; 
 Tue, 23 Jun 2020 07:44:17 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c70sm3998051wme.32.2020.06.23.07.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:44:16 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:44:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] Makefile: Compute libraries for libqemuutil.a and
 libvhost-user.a
Message-ID: <20200623144415.GP36568@stefanha-x1.localdomain>
References: <20200616161814.891053-1-dinechin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+gHRqQ1BTyNna/y8"
Content-Disposition: inline
In-Reply-To: <20200616161814.891053-1-dinechin@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+gHRqQ1BTyNna/y8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 06:18:14PM +0200, Christophe de Dinechin wrote:
> In util/Makefile.objs, there is a setting for dbus.o-libs.
> Trying to copy-paste that to add a library for module.o that was was
> not otherwise linked yields link errors on a number of binaries,
> e.g. qemu-ga, with unsatisfied symbols in libqemuutil.a(module.o).
> The reason is that library dependencies are not propagated to the .a
> files automatically.
>=20
> Adding a call to extract-libs to get the libraries for the two .a
> files that are used elsewhere.
>=20
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 2e93068894..5fb0c78a0b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -598,6 +598,8 @@ Makefile: $(version-obj-y)
>  ######################################################################
>  # Build libraries
> =20
> +libqemuutil.a-libs +=3D $(call extract-libs, $(util-obj-y) $(trace-obj-y=
) $(stub-obj-y))
> +libvhost-user.a-libs +=3D $(call extract-libs, $(libvhost-user-obj-y) $(=
util-obj-y) $(stub-obj-y))
>  libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
>  libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)

I wonder if there is GNU Make syntax to avoid duplicating the
dependencies of libqemuutil.a and libvhost-user.a?

Another thing I wonder about: the purpose of the .a files is to compile
all object files and only link those .o files needed by the program
(i.e. a subset of the .a file).

Now that libqemuutil.a-libs is defined, do programs using libqemuutil.a
link libs required by .o files that aren't being used?

For example, say we had util/mp3encoder.o which depends on an MP3
encoder library. A utility like qemu-img does not depend on mp3encoder.o
=66rom libqemuutil.a. Therefore -lmp3enc or whatever shouldn't be on
qemu-img's linker command-line.

--+gHRqQ1BTyNna/y8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yFT4ACgkQnKSrs4Gr
c8iHmQf8CJ4KXfyEtm/5ODqXoPLYj9pnNoJ+EPt0iTv2feNaHkMeABFqiPhSAPIf
oZrnwnKdw4B1C15yXFFqCwjJ8C3AgRJIksnmLPmuVG9C6323SqwlEMsaJFOOHuzU
lHgGneoz1s7mafu1U34Xw5rUhNdQ04+Im/7yiIWwemDXRtj4F6sJk45DzpQcGQ2z
UGSrnxbysQDvq7HpQSau/AyOUaTW7nJVX5anhioZQ7E0zZUOpgeufAVRkF9H/mHX
gFDGT9oTxI2pRzVHHZ+x2qr9ZI94uC+ENPM1UIL37YheY5EYODGXQ0t5GyjRC8Yu
8QOPwYlltrhA/xvzIojuRPm6anyBrw==
=QHsQ
-----END PGP SIGNATURE-----

--+gHRqQ1BTyNna/y8--

