Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8719C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B381C217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kI90U1T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B381C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYBO-0003dS-IH
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itY1I-0000Ji-E8
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itY18-0001lF-1e
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:27:06 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1itY16-0001j7-Gs; Mon, 20 Jan 2020 09:27:00 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so29805222wrh.5;
 Mon, 20 Jan 2020 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=DfoCOTX4iCBiDkyTxuiHsgALNXSpEZBt0l6dJz1RRTo=;
 b=kI90U1T+C24u3j9DJY2V255fAq5mz3sWJ7fqzVBnn6icehJW3SSUl4CpckiEqTXBOf
 +ApDVeZAun3qa5wlYHpsrMfMHZvODbtPRO303mUGr2+it5UHqaKFOxsuYoGU9c05sMBq
 vPweHW6Wf6m+63wN3Y+rNsMaKeWgmWTgHzr89KkIKUFg2E42Hk9v1ud24zgeQYu0Ue2S
 z/DbXQN7HLGFIMudeWRpTMaAc9jQ9Ihjen7MH0fGmrz0uWRouFLJli6ux+GCrSrYzkH1
 t9R+n4IYayPOHxAohnd4jI4uF4wqDiDp4+AEnaAUVeQKFiGNBI5nPdAzKRuzbCtH+AKd
 n/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DfoCOTX4iCBiDkyTxuiHsgALNXSpEZBt0l6dJz1RRTo=;
 b=gzD6k++9YmotcryptntJPrNQfUq/tve8U5fJgS0JsnEKpavkJnf1eJa+b611dhX5dv
 oRpRQcWJICk8yB6aO8MPsAFFiEH4NP3/s1yEXFlNY+yqY03uxfkfTKvS0nrM+kKArVrH
 /Kv80cEEo49i6wybCAoq2079UBCybTKo3RbcD49k7uezliLKnGOV615OGWL9LOKwZTBt
 IbpgZpXqvUlUbCo0SJLCTfMK/LHiZaSzPFlEVNjU+/iuppsUn9JT1yzGnHMZJ8CixguL
 MfXES2tSEaG21YSZSAukuk6/OaPmA7vUSVsMNn2FIt9fCeZRnzNm55erPyaAgg0ofv/9
 iAtw==
X-Gm-Message-State: APjAAAUVkJaKJHcocH74UDjccshqnLsp5Px6UMWJetkbflIdCEWHY6QQ
 zd1N/3jMVHGTjeWfKXXiPVY=
X-Google-Smtp-Source: APXvYqzlIS54xbAAFPv6oaFLWbyaIRypqAzdAGnKMFWaryNnm5XoH4eFoSL3Dcy/SB5Z4UooEDvPGQ==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr17578935wro.281.1579530417616; 
 Mon, 20 Jan 2020 06:26:57 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d8sm46811905wrx.71.2020.01.20.06.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 06:26:56 -0800 (PST)
Date: Mon, 20 Jan 2020 14:26:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/3] convert qemu-nbd, qemu-block-drivers to rST
Message-ID: <20200120142655.GG345995@stefanha-x1.localdomain>
References: <20200116141511.16849-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <20200116141511.16849-1-peter.maydell@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 02:15:08PM +0000, Peter Maydell wrote:
> This patchset converts the qemu-nbd and qemu-block-drivers
> documentation from texinfo to rST. For both of these,
> currently the documentation is in texinfo, which we present
> to the user as:
>  * a manpage
>  * a section of the qemu-doc HTML documentation
>=20
> The conversion results in the docs being in rST format,
> presented to the user as:
>  * a manpage
>  * a section of one of the Sphinx manuals (interop/
>    for qemu-nbd, and system/ for qemu-block-drivers)
>=20
> The first patch is the same as the "qemu-nbd: Convert invocation
> documentation to rST" patch I sent a couple of days ago, except that
> I have folded some of the long Makefile lines as Eric suggested.
>=20
> Patch 2 creates the new 'system' manual; this has always
> been in our plan for the docs as described in
> https://wiki.qemu.org/Features/Documentation
> but this is the first point where we have some actual
> content for it.
>=20
> Patch 3 converts the qemu-block-drivers docs/manpage.  As noted in
> the commit message for that patch, this requires dropping a minor
> cross-reference from the '-cdrom' option documentation to this
> (because they're no longer in the same big texinfo document).  There
> is also a slightly ugly compromise in the manpage output in order to
> provide better HTML output, which is forced on us by limitations in
> Sphinx.
>=20
> Apologies for the size of patch 3, but a single big-bang conversion
> of this 1000 page document seemed better than artificially trying to
> split it somehow, since only one of the two formats can actually
> produce the manpage at once.
>=20
> PS: the old docs/qemu-block-drivers.texi is not covered by
> any MAINTAINERS section, so I haven't added the new
> docs/system/qemu-block-drivers.rst anywhere either.
> Perhaps it should go in the "Block layer core" section?
>=20
> thanks
> -- PMM
>=20
> Peter Maydell (3):
>   qemu-nbd: Convert invocation documentation to rST
>   docs: Create stub system manual
>   qemu-block-drivers: Convert to rST
>=20
>  Makefile                               |  37 +-
>  MAINTAINERS                            |   1 +
>  docs/interop/conf.py                   |   4 +-
>  docs/interop/index.rst                 |   1 +
>  docs/interop/qemu-nbd.rst              | 263 +++++++
>  docs/interop/qemu-option-trace.rst.inc |  30 +
>  docs/qemu-block-drivers.texi           | 889 ----------------------
>  docs/{interop =3D> system}/conf.py       |  10 +-
>  docs/system/index.rst                  |  17 +
>  docs/system/qemu-block-drivers.rst     | 985 +++++++++++++++++++++++++
>  qemu-doc.texi                          |  18 -
>  qemu-nbd.texi                          | 214 ------
>  qemu-option-trace.texi                 |   4 +
>  qemu-options.hx                        |   2 +-
>  14 files changed, 1336 insertions(+), 1139 deletions(-)
>  create mode 100644 docs/interop/qemu-nbd.rst
>  create mode 100644 docs/interop/qemu-option-trace.rst.inc
>  delete mode 100644 docs/qemu-block-drivers.texi
>  copy docs/{interop =3D> system}/conf.py (64%)
>  create mode 100644 docs/system/index.rst
>  create mode 100644 docs/system/qemu-block-drivers.rst
>  delete mode 100644 qemu-nbd.texi
>=20
> --=20
> 2.20.1
>=20
>=20

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4luK8ACgkQnKSrs4Gr
c8jw2Qf/bAgg5etcH2/0lqT9v4Lsj7pcOLQe48g1cVXD+nR9sgDZrmvw4zb3GiOv
0pCq8MQYP0QW4GhOY21YHyxU0FZhl7zMHVy6y4KHPpevbO+73L97u0hQnGwJdC3o
pC/Lz5hfbsXyqXPKFYe6fM5qHK6PsXD2TwNbCq+mrEnGn8IH/ar3Dr2bmzvJdwdd
NoDAGpHSd6IrXqVEJUruQVs5oVoI49Lg2gO1h5XBkSGD2nTgAOduTakixcCurVxu
Xm5FGuJeN6RXyMLZyIijL7W0ZeZtcknyPWwu2ai0goTdlRt+sJY/K++H9OEiVzFG
9S9hvHb5iH4v32gSn+HXlg2XTNIh0A==
=XvRf
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--

