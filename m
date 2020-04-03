Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CF5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:03:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A92520737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuhG8RQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A92520737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKL3A-0007LH-Kc
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jKL2Z-0006vP-AQ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jKL2Y-00029E-1o
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:03:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jKL2X-00028f-Mc
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:03:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id e9so7404101wme.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=X1eIWeKVH755NCWFhZnNjMoq3qNaBWGdjfwtLj9dcDk=;
 b=UuhG8RQIjnLzaYG1lrk8289Oig80q0g1xvdqAR54s3E72YFp16sg2CX7/X4aSeAVYf
 oL92PmEFAQKGLfo58hhQ5eHoRR64dFo5e4uWkfbeIOwZeXrypnL3r4QOEUDaIzqY2661
 b9HD2GiqRgt1R7aE/mFtYuJHj56Z264eBNL9duRD8Xr4PlqVohB7W1MCqC8+aD0iz+MJ
 CNaRsmWApprOyl8hoNkL8+Xu91wVm5LOnhDoq0xzw7PDY7n3nqKBggF/fHXJe64HF3E3
 +WNhtapWambXxTWB1WZYC1r/m1OIIngmJ3G5CJsVPOsyMl5FFwLOF/VPWL30wUk8jH+l
 IXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X1eIWeKVH755NCWFhZnNjMoq3qNaBWGdjfwtLj9dcDk=;
 b=nNVo4eKusLCiPHoUOjBrntpOjUQRUUAy4nHwcquomx9RBn/TOVWsw/vrFe2+337Wn/
 YWKKc84uYstp8r0F+euIZVsD/u8IDHf8KI8pfEyDSkPDndL5rfeZTAb7ZJsaBpCBER0z
 oibD9WuEhux8Y+kF9vTcjeScEqgUq6gQOUrBi1A6zjwa8AbBqWFDEGXv2tJFxOuFrCaX
 I5yQ9+kJZV216r+7HhMPg07/k87xRizlEKrIcWrSlfkXWDvPw02L/4xGthwznD0tepbi
 4y/KAPlYIAkgw0IsWdWRfXmA7ZHZRLGFCWkC4yoSawwgz0pIJQk0NtBilqP7fiFV3sjq
 0Lkw==
X-Gm-Message-State: AGi0PuY+VJqCk77GMZ00GQYmmCrG/gHdzd5O30BGxoj1tSaBKhsf196Z
 dOXhIVoYqTGpF23SoDHwHtA=
X-Google-Smtp-Source: APiQypIzjAwsXCK8WSTqrvGzPNxgZeRPkHCiSj4/HULZKwr/hWjZCr0aSp0dwWAqISXL27xwbfDZEQ==
X-Received: by 2002:a1c:e30b:: with SMTP id a11mr7945466wmh.7.1585915392092;
 Fri, 03 Apr 2020 05:03:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e8sm3841402wrw.40.2020.04.03.05.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 05:03:10 -0700 (PDT)
Date: Fri, 3 Apr 2020 13:03:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200403120308.GB146016@stefanha-x1.localdomain>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MN2PR02MB620500A5010B71F1C0D8695E8BC90@MN2PR02MB6205.namprd02.prod.outlook.com>
 <CAJ+F1CLU4kPK1Tw3X7oTAWtUp0Q4Q=wm3-Uj-_2JO09vq0paBg@mail.gmail.com>
 <20200402101942.GF28280@stefanha-x1.localdomain>
 <20200402104645.GF423991@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <20200402104645.GF423991@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2020 at 11:46:45AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Apr 02, 2020 at 11:19:42AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Apr 01, 2020 at 06:58:20PM +0200, Marc-Andr=E9 Lureau wrote:
> > > On Wed, Apr 1, 2020 at 5:51 PM Thanos Makatos
> > > <thanos.makatos@nutanix.com> wrote:
> > > > > > Bear in mind that since this is just a PoC lots of things can b=
reak, e.g. some
> > > > > > system call not intercepted etc.
> > > > >
> > > > > Cool, I had a quick look at libvfio and how the transport integra=
tes
> > > > > into libmuser.  The integration on the libmuser side is nice and =
small.
> > > > >
> > > > > It seems likely that there will be several different implementati=
ons of
> > > > > the vfio-over-socket device side (server):
> > > > > 1. libmuser
> > > > > 2. A Rust equivalent to libmuser
> > > > > 3. Maybe a native QEMU implementation for multi-process QEMU (I t=
hink JJ
> > > > >    has been investigating this?)
> > > > >
> > > > > In order to interoperate we'll need to maintain a protocol
> > > > > specification.  Mayb You and JJ could put that together and CC th=
e vfio,
> > > > > rust-vmm, and QEMU communities for discussion?
> > > >
> > > > Sure, I can start by drafting a design doc and share it.
> > >=20
> > > ok! I am quite amazed you went this far with a ldpreload hack. This
> > > demonstrates some limits of gpl projects, if it was necessary.
> > >=20
> > > I think with this work, and the muser experience, you have a pretty
> > > good idea of what the protocol could look like. My approach, as I
> > > remember, was a quite straightforward VFIO over socket translation,
> > > while trying to see if it could share some aspects with vhost-user,
> > > such as memory handling etc.
> > >=20
> > > To contrast with the work done on qemu-mp series, I'd also prefer we
> > > focus our work on a vfio-like protocol, before trying to see how qemu
> > > code and interface could be changed over multiple binaries etc. We
> > > will start with some limitations, similar to the one that apply to
> > > VFIO: migration, introspection, managements etc are mostly left out
> > > for now. (iow, qemu-mp is trying to do too many things simultaneously)
> >=20
> > qemu-mp has been cut down significantly in order to make it
> > non-invasive.  The model is now much cleaner:
> > 1. No monitor command or command-line option forwarding.  The device
> >    emulation program has its own command-line and monitor that QEMU
> >    doesn't know about.
> > 2. No per-device proxy objects.  A single RemotePCIDevice is added to
> >    QEMU.  In the current patch series it only supports the LSI SCSI
> >    controller but once the socket protocol is changed to
> >    vfio-over-socket it will be possible to use any PCI device.
> >=20
> > We recently agreed on dropping live migration to further reduce the
> > patch series.  If you have specific suggestions, please post reviews on
> > the latest patch series.
>=20
> To clarify - the decision was to *temporarily* drop live migration, to
> make the initial patch series smaller and thus easier to merge. It does
> ultimately need live migration, so there would be followup patch series
> to provide migration support, after the initial merge.

Yes.  Live migration should come from the VFIO protocol and/or vmstate
DBus.  There is no need to implement it in a qemu-mp-specific way.

Stefan

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6HJfwACgkQnKSrs4Gr
c8g0uQf8D4QhfuGEYDXwFrBG8zihRFJML0NH5H2g7q+ytq3/hD2ZGl8Uk/EWfjZd
9kkRzLFVaP92AxOrmExBgjyGAp93QCc8jsSWEL9l7Htb11tMP1IK9uEaZlhSimxR
cjTTtpbaOf/p4UjBgBX6o3i/tW4Tlr5a2Q2/UwN8wlriPX+xz9CNIDxo2/bdCYRu
erjDYUctqkJ4CXkFgeNqyOfZnj+6nxsbHg+NLJhteISnjhBtraMwnSuF8OUi+q+s
o8UNlbCTDHtiqfc3cuQr7KHk/wudsaUcpxkNQMiltIogHM8BWMMT+1WNmcy9xYzK
WuWdg7kh52g3FebIhX6NjmFc+MnwXw==
=iXlg
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

