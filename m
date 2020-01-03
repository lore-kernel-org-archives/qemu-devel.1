Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD48FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9074217F4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 16:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgPmNtjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9074217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inPN1-0005Zm-Og
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 11:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1inPME-0004lL-Rk
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1inPMD-0007dR-CQ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:59:26 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1inPMD-0007bH-2M
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:59:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id d73so8790705wmd.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wA6EK79giMER1Ca0PtrxyLb7P77jiivLi1XYR7Sb1ks=;
 b=JgPmNtjL5tnV3s4vDkuQ6NVuK0IRfbolIb7rAQ50cC/8H+Yb6QVbcxs3p/isvse3q7
 SXrQJY7nx6vpYtFjCFnYxDPJZ2H+zsQZViyBBxYjLl1w27vH/IJNc9XTmgXJ9f02qdKs
 jkH5oVGoisUecPeBNjhX/NCaWNpeSNAFhh77M6wtKKJ5iXjd4yYxpR6/oyYxhmlXcpq6
 q8QYGCceEmzARr6KdAwdoaBg13e4rS/I9sqMKciyuhAPiegC+61LRbmz5k9kVpoASFnQ
 rSqRcW5l8mt8hIIwTfUojNHVtfUzn9oxjmf16Bbf0oAiyduHn2XZBQ3cxC2pZMgllpxi
 SIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wA6EK79giMER1Ca0PtrxyLb7P77jiivLi1XYR7Sb1ks=;
 b=G95pVwRWZe1cBqYVOqsPfnvvlzrFJiqHlkPA8Xq+HyCNbni3sV2KcBLG9ED4fcQba+
 5Sj2Y3dDkId3W8nZLvBJLUGNS7v2VaArtcTQjG0kfyP3g76ug5xOya6hvxAB2UQIZXlK
 X8BM9iRqCb3JvrWygaB0mYaijMeiGMRWokWmeN8AS+J9YBc1IppSVIYfFP1asK37Qqo0
 b3TfkawEVDR+NlLz2rV+hphPy6N9SjHYzr9T0Afdlipr9EskqeUJzKjINk9O1C0mvzYR
 NTpsiMh8k92sNAUhnOI8yvhH/ZSmRfFM52FQdNjZlld1qwljnQRi/SGI3RO8mEWj/GwE
 a2iA==
X-Gm-Message-State: APjAAAXtCSuKe+HYulgIGsvnI+rFJMuqIMcKrUjA7OhE2jDDXJrItusb
 iNLM6hvYN196bWdJijAItG0=
X-Google-Smtp-Source: APXvYqzo3kWdKXjvfiSRoEs/9/gq2i9Mikmj7qoRWEyRbd3lkIiAQwf9uWydLCS74/SO3HFBGK3edQ==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr20079691wmj.100.1578067163485; 
 Fri, 03 Jan 2020 07:59:23 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c4sm12404407wml.7.2020.01.03.07.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 07:59:22 -0800 (PST)
Date: Fri, 3 Jan 2020 15:59:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200103155920.GB281236@stefanha-x1.localdomain>
References: <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <20191220102237.GA1699760@redhat.com>
 <20200102104255.GF121208@stefanha-x1.localdomain>
 <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <C4F6A4B0-607A-4BEE-B722-8F5447F1ADB7@nutanix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 11:03:22AM +0000, Felipe Franciosi wrote:
> > On Jan 2, 2020, at 10:42 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Fri, Dec 20, 2019 at 10:22:37AM +0000, Daniel P. Berrang=C3=A9 wrote:
> >> On Fri, Dec 20, 2019 at 09:47:12AM +0000, Stefan Hajnoczi wrote:
> >>> On Thu, Dec 19, 2019 at 12:55:04PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> >>>> On Thu, Dec 19, 2019 at 12:33:15PM +0000, Felipe Franciosi wrote:
> >>>>>> On Dec 19, 2019, at 11:55 AM, Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> >>>>>> On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi wrote:
> >>>>>>>> On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
> >>>>>>>> On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> >>>>>>>>>> On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@ora=
cle.com> wrote:
> >>>>>>>>>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajn=
oczi wrote:
> >>>>> To be clear: I'm very happy to have a userspace-only option for thi=
s,
> >>>>> I just don't want to ditch the kernel module (yet, anyway). :)
> >>>>=20
> >>>> If it doesn't create too large of a burden to support both, then I t=
hink
> >>>> it is very desirable. IIUC, this is saying a kernel based solution a=
s the
> >>>> optimized/optimal solution, and userspace UNIX socket based option a=
s the
> >>>> generic "works everywhere" fallback solution.
> >>>=20
> >>> I'm slightly in favor of the kernel implementation because it keeps us
> >>> better aligned with VFIO.  That means solving problems in one place o=
nly
> >>> and less reinventing the wheel.
> >>>=20
> >>> Knowing that a userspace implementation is possible is a plus though.
> >>> Maybe that option will become attractive in the future and someone wi=
ll
> >>> develop it.  In fact, a userspace implementation may be a cool Google
> >>> Summer of Code project idea that I'd like to co-mentor.
> >>=20
> >> If it is technically viable as an approach, then I think  we should be
> >> treating a fully unprivileged muser-over-UNIX socket as a higher prior=
ity
> >> than just "maybe a GSoC student will want todo it".
> >>=20
> >> Libvirt is getting strong message from KubeVirt project that they want=
 to
> >> be running both libvirtd and QEMU fully unprivileged. This allows their
> >> containers to be unprivileged. Anything that requires privileges requi=
res
> >> jumping through extra hoops writing custom code in KubeVirt to do thin=
gs
> >> outside libvirt in side loaded privileged containers and this limits h=
ow
> >> where those features can be used.
> >=20
> > Okay this makes sense.
> >=20
> > There needs to be a consensus on whether to go with a qdev-over-socket
> > approach that is QEMU-specific and strongly discourages third-party
> > device distribution or a muser-over-socket approach that offers a stable
> > API for VMM interoperability and third-party device distribution.
>=20
> The reason I dislike yet another offloading protocol (ie. there is
> vhost, there is vfio, and then there would be qdev-over-socket) is
> that we keep reinventing the wheel. I very much prefer picking
> something solid (eg. VFIO) and keep investing on it.

I like the idea of sticking close to VFIO too.  The first step is
figuring out whether VFIO can be mapped to a UNIX domain socket protocol
and many non-VFIO protocol messages are required.  Hopefully that extra
non-VFIO stuff isn't too large.

If implementations can use the kernel uapi vfio header files then we're
on track for compatibility with VFIO.

> > This is just a more elaborate explanation for the "the cat is out of the
> > bag" comments that have already been made on licensing.  Does anyone
> > still disagree or want to discuss further?
> >=20
> > If there is agreement that a stable API is okay then I think the
> > practical way to do this is to first merge a cleaned-up version of
> > multi-process QEMU as an unstable experimental API.  Once it's being
> > tested and used we can write a protocol specification and publish it as
> > a stable interface when the spec has addressed most use cases.
> >=20
> > Does this sound good?
>=20
> In that case, wouldn't it be preferable to revive our proposal from
> Edinburgh (KVM Forum 2018)? Our prototypes moved more of the Qemu VFIO
> code to "common" and added a "user" backend underneath it, similar to
> how vhost-user-scsi moved some of vhost-scsi to vhost-scsi-common and
> added vhost-user-scsi. It was centric on PCI, but it doesn't have to
> be. The other side can be implemented in libmuser for facilitating things.

That sounds good.

Stefan

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PZNgACgkQnKSrs4Gr
c8gKCwf+MJ7jrbS90Jexw3wPcOJUvaTFGaw5LO0GBvc63GjV1o3VWW7vByPtvorb
f1CjBg67tXO/InLB8QF2GHEPQpHjZFmPZMRR5rL9/SAv7//5rgYnTpMc0kVzCFMf
iMq36uC36xV7YzDhh/lNBY2R3WYSLx4fhlZJ2F+Ud2bZscE7PN2OrjTtzoAGz8Fc
A9a3bOXZo/f58EFqXIlsanvSXs8cqZSd3K5Pllay7bf9KO1JEpDRVPLkJMYJRAzy
e4NO6N+GiPZraZhxyug1Z5/ZArXEpHc0upH7QUv/Zq1ldjf0xRxbcVwU+Y6j7x1Q
CtWBk3bY8UElkvo81fm8otwpZx0mSQ==
=wCd+
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

