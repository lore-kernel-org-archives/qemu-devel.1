Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E1CECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D123206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 20:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D123206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIITs-00055a-2c
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 16:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iIFdP-0001K8-Nb
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iIFdO-0003Ua-JG
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 13:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iIFdJ-0003Rp-KQ; Wed, 09 Oct 2019 13:20:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE659315C00D;
 Wed,  9 Oct 2019 17:20:14 +0000 (UTC)
Received: from localhost (ovpn-116-110.ams2.redhat.com [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C00815DA8C;
 Wed,  9 Oct 2019 17:20:11 +0000 (UTC)
Date: Wed, 9 Oct 2019 18:20:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Subject: Re: [RFC PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if
 F_CONFIG_WCE is also advertised
Message-ID: <20191009172010.GC13568@stefanha-x1.localdomain>
References: <1568980590-806043-1-git-send-email-wrfsh@yandex-team.ru>
 <20191008132416.GA28104@stefanha-x1.localdomain>
 <f7d2c01d-1676-f02c-e538-f924282eb6a5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <f7d2c01d-1676-f02c-e538-f924282eb6a5@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 09 Oct 2019 17:20:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, yc-core@yandex-team.ru,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 03:37:35PM +0300, Evgeny Yakovlev wrote:
> On 08.10.2019 16:24, Stefan Hajnoczi wrote:
> > On Fri, Sep 20, 2019 at 02:56:30PM +0300, Evgeny Yakovlev wrote:
> > The motivation for this change looks correct but this patch may cause
> > host_features to change across live migration to a newer QEMU version.
> > If the guest accesses VIRTIO_PCI_HOST_FEATURES before and after live
> > migration it may see different values, which is unexpected.
> >=20
> > The safe way of introducing guest-visible changes like this is to make
> > the change conditional on the machine type version so that old guests
> > see old behavior and new guests see new behavior.
> >=20
> > Live migration compatibility can be guaranteed by adding a new property
> > to virtio_blk_properties[]:
> >=20
> >    DEFINE_PROP_BOOL("enable-wce-if-config-wce", VirtIOBlock,
> >                     conf.enable_wce_if_config_wce, true),
> >=20
> > Then tweak the patch:
> >=20
> >    if (blk_enable_write_cache(s->blk) ||
> >        (s->conf.enable_wce_if_config_wce &&
> >         virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE))) {
> >=20
> > And finally disable enable_wce_if_config_wce for older machine types to
> > retain compatibility:
> >=20
> >    GlobalProperty hw_compat_4_2[] =3D {
> >        { "virtio-blk-device", "enable-wce-if-config-wce", "off" },
> >    };
> >=20
> > (I have omitted some steps like defining
> > VirtIOBlkConf.enable_wce_if_config_wce field and hooking up
> > hw_compat_4_2[], but you can figure that out from the existing code.)
>=20
>=20
> Why don't we just migrate host_features? That will ensure they are the sa=
me.
> And messing up device config on destination is bad anyway.

Traditionally QEMU has not migrated host state/objects.  Instead it
relies on the destination QEMU command-line producing exactly the same
host state as on the source host.

A problem with migration host state is that it's impossible to offer
host features that are unavailable on the destination host (they cannot
be "migrated").

Stefan

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2eFsoACgkQnKSrs4Gr
c8jPpwf/eXvpKxHnLXmJOBBG27Zx0upI63OMv5bLd6D7QOB8xxUG5VWAMCWKXMMw
iYoqgc4JCG+pWwYvmjDXNbh2yMhoYA1hDJ8SPMeINJ/9OAVB0sCWlwds0cE1U19h
xm4MO7BZO/BmCP2vIDQqaRSENmD8o4vncNrfHWtpadPrnhXDWZPEDhGGPsf+LEBh
pApOfigZ74x5CcbAftyWt1I+ufWWrVeZsVsseKsp7/I6SZqo5U1CwRQoRQXa16a4
LeVx6jnBN1FxVcNNNWRerJOxC2REzWtqwMEriXlxAN31D0xPtNv77WeA1/Y9L8bx
EAnugkRQyY2XpxYk8hxDGpc7YIL8Vw==
=T3v7
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

