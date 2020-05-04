Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23892C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0A32071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYlSREXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0A32071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXgC-0003js-3L
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVXfE-0002h0-4D
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:45:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVXfC-00021o-9l
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:45:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id 188so7697523wmc.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rdjRnjDgEd5MLSsVrfdzNA63HT7a1i6368GNb97xbM4=;
 b=UYlSREXenF3VfP7yQN6O6CKjPgYnOJIxbVqnEMMURfDBrZF5muxSaHr8gKn1wmouXf
 Oxlm+MURodATNoXdo/RN3IeJw0yyv9E1ZD3cPSIAZ/AVfsKH/ThJFH+6ApOHlZGWGmbQ
 meV279JSTSejyLpWSbjac8BtCMkfZmiyGrMitptlSRLIYoX9h6bmqamFCb1WK+su84Pv
 hATffYFEqlhvXyaN0fiZONNXBih31mO8WXCWLGGcqmnq1n7HkmHATxSweUdQf8NXBjk8
 NUJQKKqxRVHV6xvRYmj+SMDIEo40MvQK655ztVrtYqIv2wN6HI6Uk38fzjyhHsK3h/zR
 Ca9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rdjRnjDgEd5MLSsVrfdzNA63HT7a1i6368GNb97xbM4=;
 b=A0hdiGQTzppJHGnYX3CKSfxjQy22KjlS1gsy6nufTixA6QrYwIFBEkhQ1mpjISJWoj
 jzvaxciLIBq6jE/rUuU2FxeCTPmkJ82xCo2pG3wVwRQBtokseWGDMP5OWkVIdaUccBCP
 BT0TfNycGq0Ds5H7J5MofdybMf6880KBmupI6nvmjtKefI93UpLcz19DA3mjFITR05zh
 b2SkLED7j1d8LxpKdHd+fI1Am9WpRlCoNPolthE9qahfUyPsokF1gRgJyOlQb8RXUzL6
 TNEB9OtTScBGrDSeB2vEJLTl+FOO/Qff07/iG/Ix5PWT66b5KIbW9RjHLgyrje2tTs2k
 rPqQ==
X-Gm-Message-State: AGi0PuY8GOuVKAKqSTnbb5HOg7TGV0ZL5dlbU/BRm6eqCfbvHemUrhGe
 obbu1Smq06auCxNOe9IUH1c=
X-Google-Smtp-Source: APiQypKujxnHsQFrudJgTwfGscUQNu/4dvwCQTT4OYJFxQyOmxQKXHtBr3xwr3jnxFEqNfnwa786RA==
X-Received: by 2002:a05:600c:2645:: with SMTP id
 5mr13476259wmy.168.1588585524765; 
 Mon, 04 May 2020 02:45:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y11sm16838888wrh.59.2020.05.04.02.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:45:23 -0700 (PDT)
Date: Mon, 4 May 2020 10:45:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200504094521.GA354891@stefanha-x1.localdomain>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200422152930.GC47385@stefanha-x1.localdomain>
 <MW2PR02MB372340D8EF74A43D64E67B728BAF0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <MW2PR02MB372319618A59DA06851BBFB48BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <20200430114041.GN2084570@redhat.com>
 <MW2PR02MB37238FD8B5930EB45B533BFF8BAA0@MW2PR02MB3723.namprd02.prod.outlook.com>
 <F64E2C4A-ED0D-43AE-8A34-C6693DDFF93A@nutanix.com>
 <20200501152825.GA3356@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20200501152825.GA3356@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
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
 John G Johnson <john.g.johnson@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 "Harris, James R" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 04:28:25PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, May 01, 2020 at 03:01:01PM +0000, Felipe Franciosi wrote:
> > Hi,
> >=20
> > > On Apr 30, 2020, at 4:20 PM, Thanos Makatos <thanos.makatos@nutanix.c=
om> wrote:
> > >=20
> > >>>> More importantly, considering:
> > >>>> a) Marc-Andr=E9's comments about data alignment etc., and
> > >>>> b) the possibility to run the server on another guest or host,
> > >>>> we won't be able to use native VFIO types. If we do want to suppor=
t that
> > >>>> then
> > >>>> we'll have to redefine all data formats, similar to
> > >>>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > >>>> 3A__github.com_qemu_qemu_blob_master_docs_interop_vhost-
> > >>>>=20
> > >> 2Duser.rst&d=3DDwIFAw&c=3Ds883GpUCOChKOHiocYtGcg&r=3DXTpYsh5Ps2zJvtw6
> > >>>>=20
> > >> ogtti46atk736SI4vgsJiUKIyDE&m=3DlJC7YeMMsAaVsr99tmTYncQdjEfOXiJQkRkJ
> > >>>> W7NMgRg&s=3D1d_kB7VWQ-
> > >> 8d4t6Ikga5KSVwws4vwiVMvTyWVaS6PRU&e=3D .
> > >>>>=20
> > >>>> So the protocol will be more like an enhanced version of the Vhost=
-user
> > >>>> protocol
> > >>>> than VFIO. I'm fine with either direction (VFIO vs. enhanced Vhost=
-user),
> > >>>> so we need to decide before proceeding as the request format is
> > >>>> substantially
> > >>>> different.
> > >>>=20
> > >>> Regarding the ability to use the protocol on non-AF_UNIX sockets, w=
e can
> > >>> support this future use case without unnecessarily complicating the
> > >> protocol by
> > >>> defining the C structs and stating that data alignment and endianne=
ss for
> > >> the
> > >>> non AF_UNIX case must be the one used by GCC on a x86_64 bit machin=
e,
> > >> or can
> > >>> be overridden as required.
> > >>=20
> > >> Defining it to be x86_64 semantics is effectively saying "we're not =
going
> > >> to do anything and it is up to other arch maintainers to fix the ine=
vitable
> > >> portability problems that arise".
> > >=20
> > > Pretty much.
> > >=20
> > >> Since this is a new protocol should we take the opportunity to model=
 it
> > >> explicitly in some common standard RPC protocol language. This would=
 have
> > >> the benefit of allowing implementors to use off the shelf APIs for t=
heir
> > >> wire protocol marshalling, and eliminate questions about endianness =
and
> > >> alignment across architectures.
> > >=20
> > > The problem is that we haven't defined the scope very well. My initia=
l impression=20
> > > was that we should use the existing VFIO structs and constants, howev=
er that's=20
> > > impossible if we're to support non AF_UNIX. We need consensus on this=
, we're=20
> > > open to ideas how to do this.
> >=20
> > Thanos has a point.
> >=20
> > From https://wiki.qemu.org/Features/MultiProcessQEMU, which I believe
> > was written by Stefan, I read:
> >=20
> > > Inventing a new device emulation protocol from scratch has many
> > > disadvantages. VFIO could be used as the protocol to avoid reinventing
> > > the wheel ...
> >=20
> > At the same time, this appears to be incompatible with the (new?)
> > requirement of supporting device emulation which may run in non-VFIO
> > compliant OSs or even across OSs (ie. via TCP or similar).
>=20
> To be clear, I don't have any opinion on whether we need to support
> cross-OS/TCP or not.
>=20
> I'm merely saying that if we do decide to support cross-OS/TCP, then
> I think we need a more explicitly modelled protocol, instead of relying
> on serialization of C structs.
>=20
> There could be benefits to an explicitly modelled protocol, even for
> local only usage, if we want to more easily support non-C languages
> doing serialization, but again I don't have a strong opinion on whether
> that's neccessary to worry about or not.
>=20
> So I guess largely the question boils down to setting the scope of
> what we want to be able to achieve in terms of RPC endpoints.

The protocol relies on both file descriptor and memory mapping. These
are hard to achieve with networking.

I think the closest would be using RDMA to accelerate memory access and
switching to a network notification mechanism instead of eventfd.

Sooner or later someone will probably try this. I don't think it makes
sense to define this transport in detail now if there are no users, but
we should try to make it possible to add it in the future, if necessary.

Another use case that is interesting and not yet directly addressed is:
how can another VM play the role of the device? This is important in
compute cloud environments where everything is a VM and running a
process on the host is not possible.

The virtio-vhost-user prototype showed that it's possible to add this on
top of an existing vhost-user style protocol by terminating the
connection in the device VMM and then communicating with the device
using a new VIRTIO device. Maybe that's the way to do it here too and we
don't need to worry about explicitly designing that into the vfio-user
protocol, but if anyone has other approaches in mind then let's discuss
them now.

Finally, I think the goal of integrating this new protocol into the
existing vfio component of VMMs is a good idea. Sticking closely to the
<linux/vfio.h> interface will help in this regard. The further away we
get, the harder it will be to fit it into the vfio code in existing VMMs
and the harder it will be for users to configure the VMM along the lines
for how vfio works today.

Stefan

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6v5DEACgkQnKSrs4Gr
c8jDkwf/UC/k3+NLuyDhtSnQHdZ1di2M+jJUM8FTNHAs1orZN+E7duRUPl1lz0qp
h0EnVZSXEM8QR561/uen9LGYHrCeqgdrksWiuTYPBX+U5o2dSgR8qmQdbFrGb9Aj
jyZzDYKFnOJC7MedOABlzw1xAI24aWCRa62jYTSsYrOySdjbBuVp9le0ywbcpmO8
ckh/3wTK9RvoFWCg2UwAgv8O14YiV7u87RpTorKCNTJFGi4zudCLdwZ2rMxCGBkS
UboNgQJRYgi4jAXpeTZDoN9KlCm25K67Wk6pA+8BIjrPBxN5XGd/fpn+2QnuPaq8
MUZ3iDTZt9VxTG1AJKA2E93DJDZOAg==
=Qjoc
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

