Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88124C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E21207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcwGFZV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E21207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUrQ-0002bA-TV
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itUUX-0005Dc-5x
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:41:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itUUW-0005Ux-0P
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:41:09 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:39121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itUUV-0005U6-M6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:41:07 -0500
Received: by mail-wr1-x42c.google.com with SMTP id y11so28975415wrt.6
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wHSf4hpjOYkPo29+7kwbZybvl7dOvlQu+eUAlnPqBco=;
 b=gcwGFZV9TpV7keq6wIEJQz2Dw/t0kJTOEOXghGtznM3ekIQJEVxeDvzqyhwfXVtoUT
 xmGDXjhFa1hlafg6r8O32vBhUF99inL/MZeH0GljEYU3kV31dWXHW9vZ1w2QzRmz5SP4
 +Fu0pBcFiKMuzqQ30tuBxF4F7kIvDyHzLDKgsIl12vs85GwM+rQO+RT4Iyp7Kup3r+kw
 kxM8xOGyyTrm26qCW4louxVJlDJHzkdxOsbxA/U/uhq6n9Oi6cQiFwDCuCNJO2wCbERD
 RSNSvvsKHGyYkQD/7bDS77xpN3p5b0TryEbqW/o9gZ5FM5uaxJob2DloRVTBKGku0RdQ
 uTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wHSf4hpjOYkPo29+7kwbZybvl7dOvlQu+eUAlnPqBco=;
 b=Eu4M33BFpLc4gXh8wUP71Upelcze1NGDr10CPI5MYNCfubtUqAaRTdTNqB8wwOVkJe
 BXUtUjl9g8vRfNjZVoewCKIdtyulj/XxhNJQj8EhL0TN6g5gQ7UJ4mNgth2u3hmNCd11
 s7HUFiw12+FuEAi1SoztJ0nPt3nOdWVFUYYjLn8yvSeU01nAjHMB6ssWj+n54xZT6+kM
 BgeBADm/VYQMRWtNe0AzpHhgZIYlOkPvIpHTOP2BpgprY2/6PCyXMpCyMamrG3awAP1+
 ThGGV4MFOI7z1E6Y031ZmVPiC4aVTPzxPZe6pkjwYNprXFs3j22cblQJjkQ2imjAu0Ru
 aFNQ==
X-Gm-Message-State: APjAAAWZiiz9c2mna+1bJln+xfnEjYsfbePCMXBwxWjN06w1Y1tOKsCq
 HuC8Q4mQMkhrotBjzna9GL4=
X-Google-Smtp-Source: APXvYqzhVdjrCtqgnQCIqheQnHy1B/xdBetWSZHL0Nk8G9eD7o7aAOhJvhDXJbOptWF108oi1HJB6Q==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr17181966wrc.84.1579516865219; 
 Mon, 20 Jan 2020 02:41:05 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z3sm46945298wrs.94.2020.01.20.02.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 02:41:04 -0800 (PST)
Date: Mon, 20 Jan 2020 10:41:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: Feedback on multi-process QEMU muser prototype
Message-ID: <20200120104103.GE345995@stefanha-x1.localdomain>
References: <CAJSP0QWUfHyAk-xLFA1-sWSU7CvB4yKu0=Okoc7wcv7TinmXWg@mail.gmail.com>
 <75F8F7A2-0925-4010-97EA-F135C873087F@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <75F8F7A2-0925-4010-97EA-F135C873087F@nutanix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 10:58:38AM +0000, Felipe Franciosi wrote:
> > On Jan 14, 2020, at 3:22 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >=20
> > I haven't seen the link to the muser prototype shared on the list yet,
> > so I'm taking the liberty of posting it for discussion:
> > https://github.com/oracle/qemu/tree/multi-process-qemu-v0.4.1-muser
> >=20
> > Great that a lot of the multi-process patch series is no longer
> > necessary.  The muser approach requires less code in QEMU.
> >=20
> > The following points came to mind:
> >=20
> > 1. Configure PCI configuration space, BARs, and MSI/IRQs based on the P=
CIDevice
> >   instead of hard-coding the LSI SCSI controller's specifics.  That way=
 any
> >   PCIDevice can run as an muser device.
> >=20
> > 2. Integrate with QEMU's event loop instead of spawning threads and cal=
ling
> >   lm_ctx_run().  The event loop should monitor the muser fd for activit=
y using
> >   aio_set_fd_handler() and then call into libmuser to handle the event.=
  This
> >   will avoid thread model problems in the future and also allow true
> >   multi-threading (IOThreads).
>=20
> Allowing muser to be used like that is in our to-do list.
>=20
> (+ Thanos / Swapnil).
>=20
> We have to extend muser.ko to allow the device file descriptor to be
> "pollable".  Let me know how soon you want to see that so we can
> prioritise accordingly or assist someone in doing the work.

Last I talked with the multi-process QEMU team the discussion was about
moving forward with the existing QEMU patches and then moving to
VFIO-over-socket.  libmuser makes a nice library API for device emulator
programs and I think it will be revisited when VFIO-over-socket
integration begins.

This makes the pollable fd less of a priority for QEMU at the moment.

Stefan

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4lg78ACgkQnKSrs4Gr
c8j8Qgf+JpWTg/ko60R2vvJWD9yrG++9hreQ46P/8a9mYoeXxzyrEwgihBem2u8b
oAKvXW9UY32uwtzsrVCly9sxoD8eYymKvOVXQvxTkCbjj+W7bE6R/ZfMIpG5BW+5
SUIDzBDJ0NiVsFLNBZ2/uN/rAXb5+DojW7XLOqRaYmY62esMY/1VXUQETgZTwTLA
YwEzGhZAaa3jTrBTsS7+6kvz5raZO5aFSiwcrPdqfse1N5IxvyuYFUawpbt1cOcr
VM70+P7FKDnS46925ht5YBhQz9SBqCAt+wldbcdewOf1tky1bMYBkRH5bVDE2B2P
BlC9sQKnInbWq2iTU7R+n0CyOOpZ1g==
=UHI8
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

