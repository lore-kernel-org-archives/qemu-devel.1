Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E8C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5812921019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5812921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fwH-00079q-EL
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7fv6-0006VK-T1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7fv5-0004bp-TU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 09:10:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7fuz-0004Rg-N7; Tue, 10 Sep 2019 09:10:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CF5FE883D7;
 Tue, 10 Sep 2019 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-217.ams2.redhat.com
 [10.36.116.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C65D85D9DC;
 Tue, 10 Sep 2019 13:10:47 +0000 (UTC)
Date: Tue, 10 Sep 2019 15:10:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190910131046.GH4446@localhost.localdomain>
References: <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
 <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
 <20190910104748.GC4446@localhost.localdomain>
 <00aa6729-5fa0-31e0-8af5-1a91ae034f28@redhat.com>
 <20190910124805.GF4446@localhost.localdomain>
 <fa2bf3a5-a440-bc89-1896-87f0802e974d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <fa2bf3a5-a440-bc89-1896-87f0802e974d@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 10 Sep 2019 13:10:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 04/42] block: Add child access functions
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.09.2019 um 14:59 hat Max Reitz geschrieben:
> On 10.09.19 14:48, Kevin Wolf wrote:
> > Am 10.09.2019 um 13:36 hat Max Reitz geschrieben:
> >> On 10.09.19 12:47, Kevin Wolf wrote:
> >>> Am 10.09.2019 um 11:14 hat Max Reitz geschrieben:
> >>>> Maybe we should stop declaring Quorum a filter and then rename the
> >>>> bdrv_recurse_is_first_non_filter() to, I don=E2=80=99t know,
> >>>> bdrv_recurse_can_be_replaced_by_mirror()?
> >>>
> >>> Why not.
> >>
> >> It feels difficult to do in this series because this is a whole new can
> >> of worms.
> >>
> >> In patch 35, I actually replace the mirror use case by
> >> is_filtered_child().  So it looks to me as if that should not be done,
> >> because I should instead fix bdrv_recurse_is_first_non_filter() (and
> >> rename it), because quorum does allow replacing its children by mirror,
> >> even if it does not act as a filter for them.
> >>
> >> OTOH, there are other users of bdrv_is_first_non_filter().  Those are
> >> qmp_block_resize() and external_snapshot_prepare(), who throw an error
> >> if that returns false.
> >>
> >> I think that=E2=80=99s just wrong.  First of all, I don=E2=80=99t even=
 know why we have
> >> that restriction anymore (I can imagine why it used to make sense befo=
re
> >> the permission system).  qmp_block_resize() should always work as long
> >> as it can get BLK_PERM_RESIZE; and I don=E2=80=99t know why the parent=
s of some
> >> node would care if you take a snapshot of their child.
> >=20
> > Hm, doesn't it make sense in a way for qmp_block_resize() at least? It
> > means that you can't resize just a filter, but you need to resize the
> > image that actually provides the data for the filter.
>=20
> Filters generally implement .bdrv_truncate() by passing it through, so
> it should be fine.

Good point.

Then checking bdrv_is_first_non_filter() probably just forbids the only
command that would actually work correctly (resizing the top-level
filter).

Kevin

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdd6DWAAoJEH8JsnLIjy/Wo5MQAKzSo3w+C+sCp+dzVDOjDxNn
uh7QiHaDE9lelI5gnjO7F40zDMqFjGjMylyZvDs5TrapGySdjMK3R8KeZS2lJbBl
gxiL+XuqxMH+IDv01vIABEpMH/mGNEDwicrNPNUaRw2Sub/X+W5o7k9o92LqEPIA
nS1FGEfwWjpLdEUom1vIScW/xOfwWuPW/46l0cSg8m9xgeSw+6nBNYFkpGpD0ipa
orxCeN2+UFzSnSmw1P+URiSBe3rQXnL2qsFDWD1+tfaydIruOYsWGhTkFAxP9u6P
ISRomEZYhiF0s6YFe7bl70dt22plwqf/Sl8d2j5XRkSrEVubbCN1Lgmf/Dc8CCGj
ZWZTbc0+6onyfIxcKDdUlsAL6l99U9RISt0lyKphw32HIgZx6MLqIimz8BWDS3Yb
OTMj5A9YOF4xY0Ecpq6c35apLzCNxrjpl5t2kqOKhOcCDaZHJhK4amsbbimT+Cso
LHXt5weOYpeOA5T4QodQkCLPZ/kACuMO73RuVMC9ydOprkSVqGX0ZYUlU5s/sVr0
xNzHLzFGFLxxvxBLToX6U3hBivZ2C3aKeBO+g6HawmjWV3b8+sBaSeTuYL1xGFAH
97Y6iPrKMg0UvpPgcCkg6lnVP7kXuKcH1itzgLwuc07Zar/QejtHRFafpXR3sXJB
Z4Iy2iCHwAA7ufRnOO8L
=zMJI
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--

