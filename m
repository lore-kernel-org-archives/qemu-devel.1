Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C5C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF65C2078D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlAGZu48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF65C2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlPl-0005mh-Ux
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlPB-0005Lu-1b
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:08:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlP8-0006fF-1R
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:08:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id e16so18064881wrm.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UN4vDU7Zxaun8qN370m7umMecCi2aFPEKEqBE+cfQ7U=;
 b=AlAGZu48r67BT/8MRJj5tN7xwmI02l3wG39wW9DKghB+BekBhjr8XHNv6uyQK23czI
 ryndZZFHTzh3hJRc+Lp9dVd2SisNIexnLbswYyHr79dTJvKzyY6IyzriFNNK9oP9TWkU
 csmAQ6X73Tt1Lfl2fCoyDNRYDQopVvCUvP8q9BztniRIVwjsmXlJQ30rV4KGaqcmzc6M
 x5FFbEzlPiUKvNFpEztn8AhVkGpE4kwy50J0pU6fIKtrNFuu3ZsvYrDk8mV/yvBuIeAW
 aDPZ7l/Tw0aK5dk+H06pRj2Ck+PckLPtndApNKdoaR1OQPwSmsi72lnXzurekAxaDmZj
 aXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UN4vDU7Zxaun8qN370m7umMecCi2aFPEKEqBE+cfQ7U=;
 b=Gl+mx04mTmU6GzkwStVy8nRi1IWymTzv5e4phtj1htzJ+7JKTCMlGvCKZef1p7RxUY
 vkQgUa4DGJP3nVtHMt0MSYyzDIL5VZh29RtNI2Nl8/A8ELXIZpWawy/NlEhagaywrMww
 8h6rMe/aeTd8MTkLJB2+yDg4fFioSo3ST3EpFNXrSoHHVAo5hZDGImv+T4V2+K2MP/xd
 YuQhwR9r0izB87O3l528fjLu9NWAXElOBjQm3TfesvN1Lqj4MGYR5Mrs0ydHG6i0MIPQ
 8jrBcSOPeZV8W7uYssfMV6ZMs5Cfr+tPjm31IIk89Ur0HgAyr2ySEuwnTLZ6xoMgA+qH
 P6WQ==
X-Gm-Message-State: AOAM533dn7anfVJiS0ujrCmRDpwyixZtGi4leKUfzMLaCbP4AjuajMSo
 zn8M2FUZ10Cmm8j5OsaAxKc=
X-Google-Smtp-Source: ABdhPJyUT9HhMOTR7Zpy5eD4HZGjR1y1qBTCZaD1qMTx9fdsGPlQO3BtEbvlqxJJp/3JYQ+WpgRAEw==
X-Received: by 2002:adf:8162:: with SMTP id 89mr15586840wrm.237.1600078088301; 
 Mon, 14 Sep 2020 03:08:08 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a127sm19011796wmh.34.2020.09.14.03.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 03:08:07 -0700 (PDT)
Date: Mon, 14 Sep 2020 11:08:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1895399 <1895399@bugs.launchpad.net>
Subject: Re: [Bug 1895399] [NEW] Docfix: add missing virtiofsd cache default
 'auto'
Message-ID: <20200914100806.GC579094@stefanha-x1.localdomain>
References: <159992963448.16886.7579356964954187024.malonedeb@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <159992963448.16886.7579356964954187024.malonedeb@soybean.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x432.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2020 at 04:53:54PM -0000, Harry Coin wrote:
> Public bug reported:
>=20
> The usage command line for virtiofsd has:
>=20
> void fuse_cmdline_help(void)
> {
>     printf("    -h   --help                print help\n"
> ...
>            "    -o cache=3D<mode>            cache mode. could be one of =
\"auto, "
>            "always, none\"\n"
>            "                               default: auto\n"
>=20
>=20
> But the default: auto info is missing from the man page.  I suggest this =
patch:
>=20
> --- docs/tools/virtiofsd.rst    2020-09-10 18:07:45.380430677 -0500
> +++ /tmp/virtiofsd.rst  2020-09-12 11:48:10.440815204 -0500
> @@ -106,6 +106,7 @@
>    forbids the FUSE client from caching to achieve best coherency at the =
cost of
>    performance.  ``auto`` acts similar to NFS with a 1 second metadata ca=
che
>    timeout.  ``always`` sets a long cache lifetime at the expense of cohe=
rency.
> +  The default is ``auto``.
> =20
>  Examples
>  --------
>=20

Thanks, that looks good.

Please either submit a patch
(https://wiki.qemu.org/Contribute/SubmitAPatch) or reply with a line in
the following format so I can send a patch on your behalf:

  Signed-off-by: Full Name <your@email.com>

The "Signed-off-by:" tag indicates that you are contributing under the
Developer Certificate of Origin (https://developercertificate.org/) that
QEMU, Linux, and other open source projects use.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fQQYACgkQnKSrs4Gr
c8hnKwgAlBWFfqZcA9NSofL1z1SpxyMhdMsfyXggS0zODs1R3RT3X6Pcew4iWKo2
R+y2ayHTGpXEqx9K2utmnDN9F0gTW2IiQbXGmqY+DvfGN81J+uQRY9oDDfPDd/g1
aFC7J24VHQRW628dHjvYxSbCz3Sqgjfpit6CJKFDm+1JFuHhLK0i3L1r2XATtDHQ
GiBeE+JRFURmAYMXjAocznngULhgGE4bhthnwwb3tL/9FQMCVtyqEveRYl/YqI5j
G4CUmi+kDExUaz5n65Q8EWh4nCNtfK2ljMjIrwd0jUSgG9aX1uZhf/1JlwIoOsFb
U37L67C0drSGiEhy9l2UKbmhVb6Afw==
=tp/q
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--

