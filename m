Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F701C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461E52189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461E52189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Kna-0002m3-BM
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 09:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1i3KlX-0001WJ-9n
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1i3KlU-00011X-V4
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1i3KlU-00010Z-O7; Thu, 29 Aug 2019 09:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 802893084031;
 Thu, 29 Aug 2019 13:47:03 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3AE26107E;
 Thu, 29 Aug 2019 13:46:42 +0000 (UTC)
Date: Thu, 29 Aug 2019 15:46:40 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190829134640.GK13714@angien.pipo.sk>
References: <20190816170750.23910-1-ehabkost@redhat.com>
 <871rx5eq8j.fsf@dusky.pond.sub.org>
 <20190828143524.GA7642@habkost.net>
 <20190828185718.0e4eced8@redhat.com>
 <20190829131225.GJ13714@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+278g007AL/ykmV8"
Content-Disposition: inline
In-Reply-To: <20190829131225.GJ13714@angien.pipo.sk>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 29 Aug 2019 13:47:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] pc: Don't make die-id mandatory unless
 necessary
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Vanderson Martins do Rosario <vandersonmr2@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 Erik Skultety <eskultet@redhat.com>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+278g007AL/ykmV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 15:12:33 +0200, Peter Krempa wrote:
> On Wed, Aug 28, 2019 at 18:57:18 +0200, Igor Mammedov wrote:
> > On Wed, 28 Aug 2019 11:35:24 -0300

[...]

> > Also if we would need to change implicit values logic down the road
> > it would be a pain like with any default parameters in QEMU, which is
> > a good reason against relaxing rule.
>=20
> Hi,
>=20
> after a discussion with Igor I'm preparing patches which take the
> 'props' verbatim and use it for hotplug. It's a fairly simple change in
> libvirt. Originally I've opted to reconstruct the props from internal
> data since it was simpler as the values were already parsed into
> internal structures anyways.
>=20
> With some persuation we could even get it into libvirt during the freeze
> so that with new libvirt the released stuff will not break any more.

https://www.redhat.com/archives/libvir-list/2019-August/msg01322.html


--+278g007AL/ykmV8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl1n1z0ACgkQHGwCByjY
1GoZ7g/8DhHcLxun10rHBzM0xesojn3bgKmsP4A+h8CeEvZxHNAZ3qXc/6hZRRD3
izfSLmhEtT0OoRwZh/10V5OAtVSXPC1sqDd/JmjxWpkymhXddujKrWMcjPf0wZlA
xFJBCgse9g7ErYmy2UgZr6twVRrCC7uqi5gSKlyl3QoBJiB1EXibrKX6kn1jFzZx
mgntbS36wul9Y2kXUBmUm2UC0GXjhZfYyOeBupItlqmlU6FinrdIqAGQykbhsmge
HhU962eemL57njM6bfLl0FZ2IiWl424a16U24PGr/YeHrG31yH76dAD2fI958kXl
qFXQYar7zDsEOiw6EFwEP2PYDV/UIXYJhOweByMAdxoW/bU4rTvzzJyK995t0/NP
QeOqJrDkMecDdbdrQK2K4uKI7Wh7CMNWM3cFbBmjOSxBz53fHOjsunHO8sm2EAJR
Pf5WSI37t5T+GgcRR/hq/qUDhDmkmW639aWHFrlvIhj4JTQjjLKMDZllYk5fXayo
p9Nt9bzzj31clb539uan7fO4jOotblbaShAyFGpUN+ZChAY+WMaPEA8jCQUN9lTn
h1TR1u8TAT7R/5I/3JAGV0qJfMErnyWscMMGneKIPKVSp/9kQAJ1fquMAqXm/bWo
wHVd5OsmZqv2oYBL1lvVS/hK/3wLZP7fGT3deAEnSax54MkpI8A=
=gNUl
-----END PGP SIGNATURE-----

--+278g007AL/ykmV8--

