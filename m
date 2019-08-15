Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C575DC31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:47:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957A32083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 11:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957A32083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyEDh-00044c-OK
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 07:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1hyECn-0003RF-3x
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1hyECm-0001Py-12
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 07:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1hyECi-0001Mc-VG; Thu, 15 Aug 2019 07:46:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5732309DEE5;
 Thu, 15 Aug 2019 11:46:03 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-173.brq.redhat.com [10.40.204.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96219600CD;
 Thu, 15 Aug 2019 11:45:56 +0000 (UTC)
Date: Thu, 15 Aug 2019 13:45:53 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190815114553.GQ300@andariel.pipo.sk>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2D20dG0OqTzqkNh7"
Content-Disposition: inline
In-Reply-To: <20190815104928.GC7415@linux.fritz.box>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 15 Aug 2019 11:46:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] qapi: deprecate implicit
 filters
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
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2D20dG0OqTzqkNh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 12:49:28 +0200, Kevin Wolf wrote:
> Am 14.08.2019 um 21:27 hat John Snow geschrieben:

[...]

> > example:
> >=20
> > { "return": {},
> >   "deprecated": True,
> >   "warning": "Omitting filter-node-name parameter is deprecated, it will
> > be required in the future"
> > }
> >=20
> > There's no "error" key, so this should be recognized as success by
> > compatible clients, but they'll definitely see the extra information.
> >=20
> > Part of my motivation is to facilitate a more aggressive deprecation of
> > legacy features by ensuring that we are able to rigorously notify users
> > through any means that they need to adjust their scripts.
>=20
> Who would read this, though? In the best case it ends up deep in a
> libvirt log that nobody will look at because there was no error. In the
> more common case, the debug level is configured so that QMP traffic
> isn't even logged.

The best we could do here is to log a warning. Thankfully we have one
central function which always checks the returned JSON from qemu so we
could do that universally.

The would end up in the system log and alternatively also in the VM
log file. I agree with Kevin that the possibility of it being noticed
is rather small.

=46rom my experience users report non-fatal messages mostly only if it is
spamming the system log. One of instances are very unlikely to be
noticed.

In my experience it's better to notify us in libvirt of such change and
we will try our best to fix it.

--2D20dG0OqTzqkNh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl1VRe4ACgkQHGwCByjY
1GqnyhAAv77jwqoJDz2xalb+zsEchufyUnWda/dDCL5jXgULz7VDw6GyAHwQZ9Tu
D0ikCptTJ5SEQhnqvNBVQihnfL1bfwCNFmCOvYULy1aLm7iKSCa10lBh4HZeGUie
rJYTFCLoEcHnE09+fAkwGTSqSc2jAxB6l3UjDdkqMPC3MGk5cEYEB28VHz8X4pRO
ig16pta4cIyk7BnUuPCMYizAUGklKCC5Y5SiE35PrdsW1JK8Hfo4hyoSgJJP2BWR
ZbVNG6ivD19HKaCGUfzyoVyuCNx0Ar4/7MtyDwfDjlGr0xor4feqkRQJ5PNBEQWY
CARpz0dO/v8KGt4OcvZfIowSH6IOZG2Hzz+4Wau68bO3lR3F7/rzhstoeHYGH6vY
SU54EilmcbrLHaM9v8NzARPkulE0b25nGb2TjVtJYtsmYXK4rjy0SS1q00ExSExU
7dpUU38uel0vKVFVw4Rr67mkTD6s9Lc9G9I7WdehZi+ULkZ5OvuMsK85O1tJI3px
prQG7UB0kwA8XtkSn81vTgkU37O9T+KRL7VVYLoC4kkf01beMc4585PLZsXADq8u
YBNVvdnbrJjrcce+bx2sAN0Or7tOyfDQJYEWF6Rq3V57KEWSDgnHGCJDkHzFo3NB
b/QdA3BV+oPJcRAplx2xIf3hu7KrXNF4By1OvUffQuJAxswg798=
=Lzk8
-----END PGP SIGNATURE-----

--2D20dG0OqTzqkNh7--

