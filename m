Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEBC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BFC222C0
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s18VArqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BFC222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGPBO-0005Mu-DF
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 11:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iGP9o-0004HP-Tz
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iGP9n-0003VC-S1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:06:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iGP9k-0003SQ-Vm; Fri, 04 Oct 2019 11:06:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id w12so7665865wro.5;
 Fri, 04 Oct 2019 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MwZ+yNToxAG0mmkNQUqHJHPucysJCxrNVrHjmuue2k8=;
 b=s18VArqxZ11iQTRHXHvH1/FWsfovu8J6Ax4E584BWUR3TjHbBfpZATuedwZSBr9qL1
 laTm8LBerrt3la+PuMowIWoEG0PF1lb0ixpTQwWc7TqDJeF9lTvUf7FqEGbFcT1EaFQ+
 uarfbGk7glqOpr/W7Zm2mZAOMKticyStXSfzzMAOFOATUsxFVS7pRsG4a//LcpH/OhoU
 YGKR++1LnpjfVdOhcDl65fJJaqbh0NjCbITlB1Gp8KXvaK1UPhNxDmOxqiQ7IAcyB5F0
 VtTnAdMXr2kZArtOKqaAEL8FNnSVGpGwFh6eucP1HTqO3qa9boO+rxfMhDO9c7D2rRMF
 p/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MwZ+yNToxAG0mmkNQUqHJHPucysJCxrNVrHjmuue2k8=;
 b=pxc5gXiBQtuFu0PHJl0Q8Zg/iy4cIrObEL260DCqXO5h02JEWfZuDxdkGYQdtKaiGU
 5x/0uY7piP8IpIlX3eX2BvjI4l2/4QV7WIRlMTdaBww8IBUKsTHvY1RbcuNWW7sDjkB3
 eFC4WxyJs++jtS47MKaeErYfFOlvmCq76zBLbVvKZTHnGFAt2gLZbNV6ViiZim+Raa4y
 /HaE7CM7DAj27uIcmGHR6qvu8jZwUURatAXXLDtCVgm0LWcq3z1qvxG4TjYCFup/mDOk
 1/zsbs4lhhEdlQPp79x5ELl1+Ro/zoyu1EIkaEV9fFXU9eIBbZPYPJ+sSAd/D3kJhjKt
 hEXA==
X-Gm-Message-State: APjAAAWKIUWgd76F+7srLx6dT2C7ai8hnFEJiq6b0NSqBc8cyKZeb+Zk
 2kk0QS46STe+HtD3bdwVMMY=
X-Google-Smtp-Source: APXvYqwLhYOQ4861U0D8yl4rWpE8F9x0NwBPOrZvUJxcDk5QFE2XSG/iCCZMezW3svKTRkyZMbOTjA==
X-Received: by 2002:adf:ea0d:: with SMTP id q13mr1733683wrm.111.1570201565356; 
 Fri, 04 Oct 2019 08:06:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d78sm7758399wmd.47.2019.10.04.08.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 08:06:03 -0700 (PDT)
Date: Fri, 4 Oct 2019 16:06:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Julia Suvorova <jusual@mail.ru>
Subject: Re: [Qemu-devel] [PATCH v9 07/17] blockdev: adds bdrv_parse_aio to
 use io_uring
Message-ID: <20191004150601.GA11748@stefanha-x1.localdomain>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
 <20190801234031.29561-8-mehta.aaru20@gmail.com>
 <CAMDeoFUMSupka-F+TCHSq+1UMd_UbNXFyPwzdC738BSmNWXi2w@mail.gmail.com>
 <CAEg9+6Kwn2Fw8X+v5r9eMTitiG9e4bjdfKwtxX2pu23JQe_5_w@mail.gmail.com>
 <CAMDeoFW6PBWhfkdB0=wDmW_oDkgDPcygkKDu44qD=8dWDZwW=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <CAMDeoFW6PBWhfkdB0=wDmW_oDkgDPcygkKDu44qD=8dWDZwW=g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 02:49:51PM +0200, Julia Suvorova via Qemu-devel wro=
te:
> On Wed, Aug 7, 2019 at 2:06 PM Aarushi Mehta <mehta.aaru20@gmail.com> wro=
te:
> >
> >
> >
> > On Wed, 7 Aug, 2019, 17:15 Julia Suvorova, <jusual@mail.ru> wrote:
> >>
> >> On Fri, Aug 2, 2019 at 1:41 AM Aarushi Mehta <mehta.aaru20@gmail.com> =
wrote:
> >> > +int bdrv_parse_aio(const char *mode, int *flags)
> >> > +{
> >> > +    if (!strcmp(mode, "threads")) {
> >> > +        /* do nothing, default */
> >> > +    } else if (!strcmp(mode, "native")) {
> >> > +        *flags |=3D BDRV_O_NATIVE_AIO;
> >>
> >> This 'if' should be covered with CONFIG_LINUX_AIO.
> >
> >
> > The aio=3Dnative definition is shared with Windows hosts' native aio an=
d will break if it was covered.
> >
> > file-posix handles the case.
>=20
> Fair enough. Then you can remove all ifdefs for io_uring from
> raw_open_common in file-posix.c as this case was already checked here.

This is not possible since the BLOCKDEV_AIO_OPTIONS_IO_URING enum
constant is conditional in the QAPI schema:

  { 'enum': 'BlockdevAioOptions',
    'data': [ 'threads', 'native',
              { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' =
} ] }

The code can only use BLOCKDEV_AIO_OPTIONS_IO_URING if
CONFIG_LINUX_IO_URING was defined, so we cannot drop the #ifdefs in
raw_open_common().

Stefan

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2XX9kACgkQnKSrs4Gr
c8hrlAf+JAyn+uO55Chsj5BWGFLLj//ftu/sUmmue87N9OhElC67azdMfNdPcOf+
/3lQRlhw8Dumqxr9kGdVKzoh4RdLq3JQIXE/vPLrLvvQtaWKyk2pQPHVcUYadLxn
ghBtSQFqE9f+mTCc7OpTwR6wPBfhq09mI2DBFTiSBnM+vy1IAGVIcIpeE9AwQD5q
jIJ7uaJE9xt0LpuFQklyxXVmVZy11M7DqOQlYfv9eMcRxGjSxNjBpfzPGZaCoCPj
fOlZlyRWnZR2JcapYINVZ8bgARrieS1p5qLZ1+duTB80O4lNkXHpbJYWjVrWyWkP
8S4clwtDp5f/xf3Vt21srwfgMjytmw==
=s02l
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

