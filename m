Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1B2C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4055F21479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4055F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54625 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOj8K-0006SA-Fs
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:30:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hOj6x-0005ds-2A
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hOj6w-0005B0-4H
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:29:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>)
	id 1hOj6t-00058D-Oc; Thu, 09 May 2019 09:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E10DF7DCC2;
	Thu,  9 May 2019 13:29:17 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F8E600D4;
	Thu,  9 May 2019 13:29:16 +0000 (UTC)
Date: Thu, 9 May 2019 15:29:13 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190509132913.GF10858@angien.pipo.sk>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
	<20190507083615.as7shlq7fwjgwz54@steredhat>
	<8736lp5fxg.fsf@dusky.pond.sub.org>
	<20190509082646.lrfllcqszjlmnyfe@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <20190509082646.lrfllcqszjlmnyfe@steredhat>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 09 May 2019 13:29:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Use of PreallocMode in block drivers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 10:26:46 +0200, Stefano Garzarella wrote:
> On Wed, May 08, 2019 at 01:44:27PM +0200, Markus Armbruster wrote:
> > Stefano Garzarella <sgarzare@redhat.com> writes:
> >=20
> > > On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
> > >> Cc: Peter for a libvirt perspective.
> > >>=20
> > >> Stefano Garzarella <sgarzare@redhat.com> writes:
> > >>=20
> > >> > This patch adds the support of preallocation (off/full) for the RBD
> > >> > block driver.
> > >> > If available, we use rbd_writesame() to quickly fill the image when
> > >> > full preallocation is required.
> > >> >
> > >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >> > ---
> > >> >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++=
-----
> > >> >  qapi/block-core.json |   4 +-
> > >> >  2 files changed, 136 insertions(+), 17 deletions(-)

[...]


> > >> >  ##
> > >> >  # @BlockdevVmdkSubformat:
> > >>=20
> > >> The non-support of values 'metadata' and 'falloc' is not visible in
> > >> introspection, only in documentation.  No reason to block this patch=
, as
> > >> the other block drivers have the same introspection weakness (only
> > >> sheepdog and vdi bother to document).
> > >>=20
> > >> Should we address the introspection weakness?  Only if there's a use=
 for
> > >> the information, I think.
> > >
> > > If the management applications will use that information (or maybe al=
so
> > > our help pages), could be useful to have an array of 'PreallocMode'
> > > supported per-driver.
> >=20
> > Ideally, query-qmp-schema would show only the supported values.
> >=20
> > Not hard to do, just tedious: we'd get a number of sub-enums in addition
> > to the full one, and we'd have to map from sub-enum to the full one.
> >=20
> > QAPI language support for sub-enums would remove most of the tedium.
> > Not worthwhile unless the need for sub-enums is actually common.
>=20
> I should study better the QMP and QAPI to understand how to implement
> the sub-enums.
>=20
> If you agree, I'll put it as a background task, until somebody from
> management applications tell us his interest.

Sorry for the late response. Libvirt currently does not deal that much
with the preallocation settings. Preallocation isn't in current state
implemented at all for 'blockdev-create' and only the 'metadata' and
'falloc' modes are used in the storage driver via qemu-img.

We currently hardcode the knowledge for which formats actually support
it internally.

I'd say it's not criticall to expose this in the QMP schema but
obviously if we'll ever need to use it for a recent enough qemu it's
welcome to have a way to check.

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlzUKycACgkQHGwCByjY
1GrNExAAzwwgpXzAb5TZfXNCz9qzvoQJlCn3JPx4+BOnzG453YX+XOLpl+yH9+d7
ngZfDsrvo++D5MZJcjkgHZK1QtJ7t8dwv5xCW/PZCLfTlpqHBIj5DAsIxmwWYGDi
8cAU++ryg90rvFoDNSCVfkdPYDNYRMBAn0RcKFDglKI/iiaEIHP+2LZeSyRY0ISJ
LCXs+YG12vQywsXB+yxHQa9jscVLn8n+4nd10PVPc3okBfpVO4mKblTCcHGHcG8D
OqtnMT+mlswLrTaxCbVpOyYKc/LtvumV0X/aqZzQzbgghisYwrkjcDlNAPnBfq/B
M1NoLYEg+xtodqL1uC+AWmgBih6h5+kbkbkSnxdLPmhrXoxobZLG/9RykLeuV9oo
WbicOEHwS3+2MUqNhpF7ZCaw/2KoDsK+KUywCkAup8JHZEWwcQziHswRB0NwFBmm
U+5WGIRLIPhdjrO0YnogLUDxAIAlCKUGq3k8MpeEw2RPKoL2W+fO/FBWDSiFB9qE
1b/wRX8irT/d6in+7VCViEp4DFL6w0MQVmWJaopM+S+rCKJRZMlUGluifaaatSZa
NSdC8tBETrDTWLglvV6YfFwAokQz8r6SvsuuZLJyHDD7ykQV2nlPRSU8ckm5iWyv
ubmxsuQF2SaOH8ftUzOQB8o/fceSpJYzary7G2Ps4YGtUCIQh/4=
=4VAC
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--

