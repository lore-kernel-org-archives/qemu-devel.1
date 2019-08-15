Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1CFC32759
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 07:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A612084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 07:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A612084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyASh-0000kF-64
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 03:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1hyARk-000093-Gi
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1hyARj-0001KO-5g
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 03:45:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1hyARf-0001Dp-7F; Thu, 15 Aug 2019 03:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 497CF308A9E0;
 Thu, 15 Aug 2019 07:45:13 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-173.brq.redhat.com [10.40.204.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 626DE825F7;
 Thu, 15 Aug 2019 07:45:02 +0000 (UTC)
Date: Thu, 15 Aug 2019 09:44:59 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190815074459.GN300@andariel.pipo.sk>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-2-vsementsov@virtuozzo.com>
 <6c40950f-c8b8-f9c7-6187-aa282e1a2d30@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
Content-Disposition: inline
In-Reply-To: <6c40950f-c8b8-f9c7-6187-aa282e1a2d30@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 15 Aug 2019 07:45:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH 1/2] qapi: deprecate drive-mirror
 and drive-backup
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2019 at 15:22:15 -0400, John Snow wrote:
>=20
>=20
> On 8/14/19 6:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> > It's hard and not necessary to maintain outdated versions of these
> > commands.
> >=20
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  qemu-deprecated.texi  |  4 ++++
> >  qapi/block-core.json  |  4 ++++
> >  qapi/transaction.json |  2 +-
> >  blockdev.c            | 10 ++++++++++
> >  4 files changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > index fff07bb2a3..2753fafd0b 100644
> > --- a/qemu-deprecated.texi
> > +++ b/qemu-deprecated.texi
> > @@ -179,6 +179,10 @@ and accurate ``query-qmp-schema'' command.
> >  Character devices creating sockets in client mode should not specify
> >  the 'wait' field, which is only applicable to sockets in server mode
> > =20
> > +@subsection drive-mirror, drive-backup and drive-backup transaction ac=
tion (since 4.2)
> > +
> > +Use blockdev-mirror and blockdev-backup instead.
> > +
> >  @section Human Monitor Protocol (HMP) commands
> > =20
> >  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (=
since 3.1)

[...]

> > @@ -3831,6 +3838,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **e=
rrp)
> >      const char *format =3D arg->format;
> >      int ret;
> > =20
> > +    warn_report("drive-mirror command is deprecated and will disappear=
 in "
> > +                "future. Use blockdev-mirror instead");
> > +
> >      bs =3D qmp_get_root_bs(arg->device, errp);
> >      if (!bs) {
> >          return;
> >=20
>=20
> Hm!
>=20
> I wonder if this is ever-so-slightly too soon for our friends over at
> the libvirt project.
>=20
> I don't think they have fully moved away from the non-blockdev
> interfaces *just yet*, and I might encourage seeing the first full
> libvirt release that does support and use it before we start the
> deprecation clock.
>=20
> (Juuuust in case.)
>=20
> That's just me being very, very cautious though.
>=20
> Peter Krempa, how do you feel about this?

Thanks for the heads up!

Currently libvirt does not use 'drive-backup' at all so that one can be
deprecated immediately.

In case of 'drive-mirror' the situation is a bit more complex:

Libvirt uses 'drive-mirror' currently in the following places

1) virDomainBlockCopy API
With blockdev integration enabled this will go away. Pathces are being
reviewed:

https://www.redhat.com/archives/libvir-list/2019-August/msg00295.html

2) VM migration with non-shared storage
Currently uses 'drive-mirror' in most cases but there is pre-existing
integration for blockdev-mirror for nbd+tls. I need to make sure that
the blockdev version will be used unconditionally once the integration
is enabled. This is a TODO.

There is also one gotcha. In case when an 'sd' card device is used for
the VM, libvirt disables all of blockdev, because SD cards can't be
expressed with blockdev. There's too many code paths which would need
checking to be worth it. To be fair, I'm not even sure when a sd card
can be emulated by qemu as all of my basic tests failed and I did not
care more.

For libvirt to enable blockdev there's one more part missing and that's
snapshot integration. I'm currently testing patches to integrate it with
external snapshots, which should be posted soon.

I also found a bug in qemu, which prevents creation of internal
snapshots when -blockdev is used:

When savevm HMP command is used (via QMP->HMP bridge) qemu invokes
save_snapshot(), which calls bdrv_all_can_snapshot(). That function uses
bdrv_next() to iterate all nodes which correspond to a block backend
first, but then also iterates any other node which is monitor-owned.

Since with blockdev all nodes including the ones for the 'file' protocol
are monitor-owned, and 'file' does not support snapshots that check
fails. A simple hack of skipping the second part in bdrv_next() allows
to do a snapshot actually. Kevin told me that the idea is that also
non-attached nodes should be considered for internal snapshod which is
okay in my opinion, but given how the snapshot works for the files
attached to backeds (and also in pre-blockdev use) only the top level of
a chain should ever be considered for snapshot.

So the summary is, that I'm pretty hopeful that we should be able to get
rid of all reasonable uses of drive-mirror very soon after I finish
snapshot integration. The only question is how much
we care about SD card users being able to do a drive-mirror in the
future.

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl1VDXgACgkQHGwCByjY
1GoIuxAAjgkp5aIsMW+QCV0eXTnN+LBQBXJMuiCvfPU95MtChDi1Ukc5fEHXG+7W
D6Qa3/QnhXdSRVTZKc4FJrvePnfbp+DvBjJP1yj39a+Q2NTVGIJzo0AqZZhWVVcT
R9QrlcfHgNOlG18xVSHhVkFiEg7hzd6H2kuf/SoAgyRSrZZUoG07KlV3xu5sxdIq
V8LhxO8SB2fHYfBBLUvVdtpDPOevimr1rgGJme29IuWeyx0nLv+ZtIBQmaRDemtJ
rlMzresgcCgpPYJo51eYbQ/5R7NmQXdpfkw8mD6N78Zd2agW0wRkppiImBKqXPGg
Ufm2FUTjkJnvlG5qHAnOQcj/FoIcx74O6CZsLnH9dbzdnWaCJnP6R+NpFUhUhExt
W0A77bel8bKvqSKchdDgke1YBTXuFoAjqje+UodzHloGsq2B1HHUusecc0KZvENP
57ukHnSW7BgdRY7nEODwpZS3OQq7Ja/9WqwOKEvOaUJROU7k4zwQahaQsCeqK3Mv
wvTW9+bv0UCCwxrsVkAjTPMftnlgI5SfVPou/3ecj2uhaXiyj8wVujNKZrYaJGZz
Esg8XnZU29wax00Zhz2KgrzElEqaMzRF52vZiVmSqMTIOUSCbM1Et5kd4SmD5xtF
n+VmTXv+LnfxbElJNgh+G6fqBD50qxm1ixVPVSNTDcBw5meYZyA=
=ZzNS
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--

