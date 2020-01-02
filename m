Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F742C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADD621655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXCeO1Jz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADD621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imxxg-0007nO-Em
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 05:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1imxwX-0006Jp-Sq
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1imxwS-0005SG-O9
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:43:05 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1imxwS-0005RV-Ef
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:43:00 -0500
Received: by mail-wr1-x444.google.com with SMTP id q10so38789456wrm.11
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sgMX9yWh9HlfiMNpnCHUjHcaypmIRTv26soxoxnGPwI=;
 b=hXCeO1JzIV9stVNn7usEKpRkBbpus+3AokkWhy42aVGn3MgDWPsYbn5uYzZCog0Go9
 7EwPVCgvin1fK951HrUfBD/gTRfgkZGDhRgCRHCJbBgxt+DhgRKVsgUlSEuKhg2Ka3/8
 lCYuUDIP5p1s2m9dDOXTHqwY9GYmKP+esQlTa8xjpPhOL0K5mtMHoV7W7pdm79zaSDXm
 3ix5ysOyYtGywQJEyV16ibkdDfCt8iE8ZI6hzcYHt2CS25TTGPnZcG20zPxByjcqFgYo
 X988CohIJOuErbuwQfxW/Bj77y8RCnNF3iLWPcknwhWN8XxfUUCGA7Ie+T9a5HUzLDAk
 I4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sgMX9yWh9HlfiMNpnCHUjHcaypmIRTv26soxoxnGPwI=;
 b=EWlAPLRigcH+ZA84Pp1zSiV3jRMqcEZqM/YGHoPNYKI0cZY05zKjaqkgAhjJg5LKLZ
 Fv7fA8vlgLuFzVkgc5qu6XZPNZtFa+v60AvR9KyouDFBORyd+mvh73RBtqZMNE7Tplkd
 YOO5cpl3jqxany49hpa3UfgwQl+X8ThPbEXVfgdmwAgi3HEGOEs2n6CVqW26qXUi47h1
 seVyPnxWbsq+EEP7Nttq5H9SK1+rHjlmWdC0WP8OL7yM23gAWjPhGb7pYRdOTdx/0nAC
 xJiV8X8t5je+3puiE6KX5sBHpnQtRQSUermEFoPV7KSD1s/+KoAuSssdpFzAyKbW6fS0
 aK/Q==
X-Gm-Message-State: APjAAAWJKR5fSPe/0OuJ+m86iGdkLp7SOOzpztK12mchNLLIZMKnSBpS
 c/c4iY/7YgO5ApBHnhB48Nc=
X-Google-Smtp-Source: APXvYqxVeaopDwk3q2hKhgR7+8isk+5pRzV7aKiI6vZWt7xvaHvLzAtYe0LJC7BRAO3c9E2z+0i7nQ==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr82457456wrq.134.1577961778904; 
 Thu, 02 Jan 2020 02:42:58 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v8sm55462292wrw.2.2020.01.02.02.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 02:42:57 -0800 (PST)
Date: Thu, 2 Jan 2020 10:42:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200102104255.GF121208@stefanha-x1.localdomain>
References: <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
 <20191220102237.GA1699760@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20191220102237.GA1699760@redhat.com>
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
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 10:22:37AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Dec 20, 2019 at 09:47:12AM +0000, Stefan Hajnoczi wrote:
> > On Thu, Dec 19, 2019 at 12:55:04PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > > On Thu, Dec 19, 2019 at 12:33:15PM +0000, Felipe Franciosi wrote:
> > > > > On Dec 19, 2019, at 11:55 AM, Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
> > > > > On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi wrote:
> > > > >>> On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> > > > >>> On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrot=
e:
> > > > >>>>> On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@or=
acle.com> wrote:
> > > > >>>>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Haj=
noczi wrote:
> > > > To be clear: I'm very happy to have a userspace-only option for thi=
s,
> > > > I just don't want to ditch the kernel module (yet, anyway). :)
> > >=20
> > > If it doesn't create too large of a burden to support both, then I th=
ink
> > > it is very desirable. IIUC, this is saying a kernel based solution as=
 the
> > > optimized/optimal solution, and userspace UNIX socket based option as=
 the
> > > generic "works everywhere" fallback solution.
> >=20
> > I'm slightly in favor of the kernel implementation because it keeps us
> > better aligned with VFIO.  That means solving problems in one place only
> > and less reinventing the wheel.
> >=20
> > Knowing that a userspace implementation is possible is a plus though.
> > Maybe that option will become attractive in the future and someone will
> > develop it.  In fact, a userspace implementation may be a cool Google
> > Summer of Code project idea that I'd like to co-mentor.
>=20
> If it is technically viable as an approach, then I think  we should be
> treating a fully unprivileged muser-over-UNIX socket as a higher priority
> than just "maybe a GSoC student will want todo it".
>=20
> Libvirt is getting strong message from KubeVirt project that they want to
> be running both libvirtd and QEMU fully unprivileged. This allows their
> containers to be unprivileged. Anything that requires privileges requires
> jumping through extra hoops writing custom code in KubeVirt to do things
> outside libvirt in side loaded privileged containers and this limits how
> where those features can be used.

Okay this makes sense.

There needs to be a consensus on whether to go with a qdev-over-socket
approach that is QEMU-specific and strongly discourages third-party
device distribution or a muser-over-socket approach that offers a stable
API for VMM interoperability and third-party device distribution.

Interoperability between VMMs and also DPDK/SPDK is important because
they form today's open source virtualization community.  No one project
or codebase covers all use cases or interesting developments.  If we are
short-sighted and prevent collaboration then we'll become isolated.

On the other hand, I'm personally opposed to proprietary vendors that
contribute very little to open source.  We make that easier by offering
a stable API for third-party devices.  A stable API discourages open
source contributions while allowing proprietary vendors to benefit from
the work that the open source community is doing.

One way to choose a position is to balance up the open source vs
proprietary applications of a stable API.  At this point in time I think
the DPDK/SPDK and rust-vmm communities bring enough to the table that
it's worth fostering collaboration through a stable API.  The benefit of
having the stable API is large enough that the disadvantage of making
life easier for proprietary vendors can be accepted.

This is just a more elaborate explanation for the "the cat is out of the
bag" comments that have already been made on licensing.  Does anyone
still disagree or want to discuss further?

If there is agreement that a stable API is okay then I think the
practical way to do this is to first merge a cleaned-up version of
multi-process QEMU as an unstable experimental API.  Once it's being
tested and used we can write a protocol specification and publish it as
a stable interface when the spec has addressed most use cases.

Does this sound good?

Stefan

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4NyS8ACgkQnKSrs4Gr
c8jQQwf+NNr2DvF3faeed8IgZ9OJmRh3ElfhqBBzSMf2jDTJesmnwO8dPC7vJxKG
C7w6b4DNDb1mQX5E24MQqKib7MPWDgEecN2R7c1jtLTLhRgnNdoGYiHMiNrOuGjA
+kE+CxnS+TcGGgheEOIZHLL1NXo0nQNsRoRwG4DUhXB4oM79VMySP4NvXy6jqfzP
RTEssoshQ3Xq5Q3CGzLurF1VKN/+WuB36Jppp41vhWCHLcNyy2mX4pZLIR4a/Ygl
zKG6Vgu17hJUFKl+ttRp52aV1Ana5vRbIIIC8BE8wKCV1yvyPXtSm1wBDKMe5xfX
kTTH+sDEZoScGdSG/i9TPMr1/2MaQw==
=N0JB
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--

