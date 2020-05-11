Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8877C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D10206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlPpfqzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D10206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9Zc-0008Ir-L2
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY9Yf-0006vb-3B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:37:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jY9Yd-0003wx-R3
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:37:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so5364333wru.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cwMvU6pARgmOuXz5ufvJA4b3nMMJPY70/D0/ZmCvpK0=;
 b=ZlPpfqzWfqgSvI+5aMXNd8cq8bBje4rCDqK/SI+z4jykgu3ocnhGd4nsxWIlfZ+3ZU
 ODVeWY57zgj1ni9Kui5E+Jy3Tlo+CyVKnahNw2R2hqZXkhCY5jiEg/NoFMO5sBB4nkDE
 XQCy8bDJTZu9MvX+GhIDUnUfNd0r2Un54Qc2p7FuL/BA12OAxk2YzDQA0QExWA51+djF
 H1dRhrczvwdM7PZ25XQeASjAyIWoNtDARfFE1BQyhuvoOYWBAqZIA8MN8Cbv5v972vZb
 iz+a8nKynSB8InvLTHi9pebC54u77wSVbxCoYwy77se846CS0Rky0DX5kKKY9LXO9LEn
 oDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cwMvU6pARgmOuXz5ufvJA4b3nMMJPY70/D0/ZmCvpK0=;
 b=ZyTYcgsYXEkO7B4L9THEhO80ugsc65fj+FXEzCESzaZ+UkiUq1H1IuEpl0GBNDzxTi
 EZggd43vhyNvTdTzL1Jl+5WQPORJKL34j3AC0J80PH9Mtp6W34mhW64YQXgBFNHrS43P
 +ZojW+qvKqDZr4anLFA/FXg9MjmfjK8O/CGRwhusffeLyAHUsV0Fbszd9DheFe5JC+YY
 2rtyEh+W2pXU7IVTVCcTuSlXfl1tZL1PPDL9+bHVRIgHGJQ1RTPd84GVj3w6u9Wk4x4l
 WmU6tq8LJr3LT/+kU2qbQXzrK/kasqTOAuW9heW1xmHOk2EbfSjLQRFHuu3VJNdLHFGv
 Gu4g==
X-Gm-Message-State: AGi0PubrQdk6oDN0FD/QXrpYSvg3AYTHpDsoyXG64horkJTjqOHH657m
 EhnkTPRxShqAFBcdYRZQOo8=
X-Google-Smtp-Source: APiQypLrNtKhj8s598Sz5d21SW+cjw4XbcCy1xqZLt5RwHEex2Olcwdox8bIawur3mHxR5V3+g1ZUg==
X-Received: by 2002:a5d:6541:: with SMTP id z1mr19563926wrv.264.1589207846564; 
 Mon, 11 May 2020 07:37:26 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g6sm1895657wrp.75.2020.05.11.07.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 07:37:24 -0700 (PDT)
Date: Mon, 11 May 2020 15:37:23 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: John G Johnson <john.g.johnson@oracle.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200511143723.GB182627@stefanha-x1.localdomain>
References: <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200430114041.GN2084570@redhat.com>
 <MW2PR02MB37238FD8B5930EB45B533BFF8BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <F64E2C4A-ED0D-43AE-8A34-C6693DDFF93A@nutanix.com>
 <20200501152825.GA3356@redhat.com>
 <20200504094521.GA354891@stefanha-x1.localdomain>
 <1A84D74A-333F-46BB-B743-E103348B83E2@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <1A84D74A-333F-46BB-B743-E103348B83E2@oracle.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>, "Liu,
 Changpeng" <changpeng.liu@intel.com>, "Zhang, Tina" <tina.zhang@intel.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 10:49:11AM -0700, John G Johnson wrote:
>=20
>=20
> > On May 4, 2020, at 2:45 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >=20
> > On Fri, May 01, 2020 at 04:28:25PM +0100, Daniel P. Berrang=C3=A9 wrote:
> >> On Fri, May 01, 2020 at 03:01:01PM +0000, Felipe Franciosi wrote:
> >>> Hi,
> >>>=20
> >>>> On Apr 30, 2020, at 4:20 PM, Thanos Makatos <thanos.makatos@nutanix.=
com> wrote:
> >>>>=20
> >>>>>>> More importantly, considering:
> >>>>>>> a) Marc-Andr=C3=A9's comments about data alignment etc., and
> >>>>>>> b) the possibility to run the server on another guest or host,
> >>>>>>> we won't be able to use native VFIO types. If we do want to suppo=
rt that
> >>>>>>> then
> >>>>>>> we'll have to redefine all data formats, similar to
> >>>>>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> >>>>>>> 3A__github.com_qemu_qemu_blob_master_docs_interop_vhost-
> >>>>>>>=20
> >>>>> 2Duser.rst&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvt=
w6
> >>>>>>>=20
> >>>>> ogtti46atk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJ
> >>>>>>> W7NMgRg&s=3D1d_kB7VWQ-
> >>>>> 8d4t6Ikga5KSVwws4vwiVMvTyWVaS6PRU&e=3D .
> >>>>>>>=20
> >>>>>>> So the protocol will be more like an enhanced version of the Vhos=
t-user
> >>>>>>> protocol
> >>>>>>> than VFIO. I'm fine with either direction (VFIO vs. enhanced Vhos=
t-user),
> >>>>>>> so we need to decide before proceeding as the request format is
> >>>>>>> substantially
> >>>>>>> different.
> >>>>>>=20
> >>>>>> Regarding the ability to use the protocol on non-AF_UNIX sockets, =
we can
> >>>>>> support this future use case without unnecessarily complicating the
> >>>>> protocol by
> >>>>>> defining the C structs and stating that data alignment and endiann=
ess for
> >>>>> the
> >>>>>> non AF_UNIX case must be the one used by GCC on a x86_64 bit machi=
ne,
> >>>>> or can
> >>>>>> be overridden as required.
> >>>>>=20
> >>>>> Defining it to be x86_64 semantics is effectively saying "we're not=
 going
> >>>>> to do anything and it is up to other arch maintainers to fix the in=
evitable
> >>>>> portability problems that arise".
> >>>>=20
> >>>> Pretty much.
> >>>>=20
> >>>>> Since this is a new protocol should we take the opportunity to mode=
l it
> >>>>> explicitly in some common standard RPC protocol language. This woul=
d have
> >>>>> the benefit of allowing implementors to use off the shelf APIs for =
their
> >>>>> wire protocol marshalling, and eliminate questions about endianness=
 and
> >>>>> alignment across architectures.
> >>>>=20
> >>>> The problem is that we haven't defined the scope very well. My initi=
al impression=20
> >>>> was that we should use the existing VFIO structs and constants, howe=
ver that's=20
> >>>> impossible if we're to support non AF_UNIX. We need consensus on thi=
s, we're=20
> >>>> open to ideas how to do this.
> >>>=20
> >>> Thanos has a point.
> >>>=20
> >>> From https://wiki.qemu.org/Features/MultiProcessQEMU, which I believe
> >>> was written by Stefan, I read:
> >>>=20
> >>>> Inventing a new device emulation protocol from scratch has many
> >>>> disadvantages. VFIO could be used as the protocol to avoid reinventi=
ng
> >>>> the wheel ...
> >>>=20
> >>> At the same time, this appears to be incompatible with the (new?)
> >>> requirement of supporting device emulation which may run in non-VFIO
> >>> compliant OSs or even across OSs (ie. via TCP or similar).
> >>=20
> >> To be clear, I don't have any opinion on whether we need to support
> >> cross-OS/TCP or not.
> >>=20
> >> I'm merely saying that if we do decide to support cross-OS/TCP, then
> >> I think we need a more explicitly modelled protocol, instead of relying
> >> on serialization of C structs.
> >>=20
> >> There could be benefits to an explicitly modelled protocol, even for
> >> local only usage, if we want to more easily support non-C languages
> >> doing serialization, but again I don't have a strong opinion on whether
> >> that's neccessary to worry about or not.
> >>=20
> >> So I guess largely the question boils down to setting the scope of
> >> what we want to be able to achieve in terms of RPC endpoints.
> >=20
> > The protocol relies on both file descriptor and memory mapping. These
> > are hard to achieve with networking.
> >=20
> > I think the closest would be using RDMA to accelerate memory access and
> > switching to a network notification mechanism instead of eventfd.
> >=20
> > Sooner or later someone will probably try this. I don't think it makes
> > sense to define this transport in detail now if there are no users, but
> > we should try to make it possible to add it in the future, if necessary.
> >=20
> > Another use case that is interesting and not yet directly addressed is:
> > how can another VM play the role of the device? This is important in
> > compute cloud environments where everything is a VM and running a
> > process on the host is not possible.
> >=20
>=20
> 	Cross-VM is not a lot different from networking.  You can=E2=80=99t
> use AF_UNIX; and AF_VSOCK and AF_INET do not support FD passing.
> You=E2=80=99d either have to add FD passing to AF_VSOCK, which will have
> some security issues, or fall back to message passing that will
> degrade performance.

In the approach where vfio-user terminates in the device VMM and the
device guest uses a new virtio-vhost-user style device we can continue
to use AF_UNIX with file descriptor passing on the host. The vfio-user
protocol doesn't need to be extended like it would for AF_VSOCK/AF_INET.

   Driver guest                              Device guest
        ^                                         ^
	| PCI device             virtio-vfio-user |
	v                                         v
    Driver VMM  <---- vfio-user AF_UNIX ----> Device VMM

It does not require changing the vfio-user protocol because the driver
VMM is talking to a regular vfio-user device process that happens to be
the device VMM.

The trick is that the device VMM makes the shared memory accessible as
VIRTIO shared memory regions (already in the VIRTIO spec) and eventfds
as VIRTIO doorbells/interrupts (proposed by not yet added to the VIRTIO
spec). This allows the device guest to directly access these resources
so it can DMA to the driver guest's RAM, inject interrupts, and receive
doorbell notifications.

Stefan

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl65YyMACgkQnKSrs4Gr
c8gLZwf/fAZYWycuOXX6cvnekISRKmUa4uvwHEN3ftiM8/tjGiEqjGko4pi79vzP
D7bVwHhKfHWAFun9BGnBjH/EQ/TsjXcyDwZiOcLyZVtHRsC8BWB9xkxMqXpHU1XN
BbtAu5O2uPgJnNYSEsc8zW3HJgblZcNOluxAI1cZEqdyLs3vkxM6M/6OBZRLTZpi
OgD2YuxD8kU5N1aVVaJD3zZx6beRXZP8JlO0B0xfWpqdLCaALQIa7/9wehSUx5uo
9sPfbLhPoVKXrX5gVYlnba0ydkwLYG/ch0lI+xU9QYRCRixKqbDHj3/T91Bc4Ddf
a05DgTSipUHnCoUilsPhYz7U7Ma1bw==
=xk66
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

