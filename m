Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1666CC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA5321852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 11:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA5321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iABZs-0007lm-44
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 07:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iABYs-0006r1-4J
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iABYr-0003Lv-1H
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 07:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iABYo-0003KS-AI; Tue, 17 Sep 2019 07:22:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D7338666C;
 Tue, 17 Sep 2019 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-202.ams2.redhat.com
 [10.36.116.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F99608C2;
 Tue, 17 Sep 2019 11:22:13 +0000 (UTC)
Date: Tue, 17 Sep 2019 13:22:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190917112212.GB4824@localhost.localdomain>
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-7-mreitz@redhat.com>
 <44f97011-4a02-7832-c253-d43474f79d44@redhat.com>
 <a829185c-7c09-5afe-1479-15054ad59807@redhat.com>
 <33f60f4e-8156-e46f-8500-79b0982348b2@redhat.com>
 <c38acedf-d3db-384f-4aea-967ef3f87fdd@redhat.com>
 <20190917084012.GA4824@localhost.localdomain>
 <e9c8a9f5-80d9-b003-8036-0ba8df352ec3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <e9c8a9f5-80d9-b003-8036-0ba8df352ec3@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 17 Sep 2019 11:22:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/8] iotests: Test driver whitelisting
 in 093
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.09.2019 um 13:07 hat Max Reitz geschrieben:
> On 17.09.19 10:40, Kevin Wolf wrote:
> > Am 17.09.2019 um 10:18 hat Max Reitz geschrieben:
> >> On 13.09.19 20:30, John Snow wrote:
> >>> I'd still like to define func_wrapper with a nod to the type constrai=
nt
> >>> it has:
> >>>
> >>> def func_wrapper(instance: iotests.QMPTestCase, *args, **kwargs):
> >>>     [...]
> >>>
> >>>
> >>> Then, you'd write:
> >>>
> >>> if callable(required_formats):
> >>>     fmts =3D required_formats(instance)
> >>> else:
> >>>     fmts =3D required_formats
> >>
> >> Yep, that anyway.  (Although I didn=E2=80=99t know about the =E2=80=9C=
param: type=E2=80=9D
> >> syntax and put that constraint in a comment instead.  Thanks again :-))
> >=20
> > Note that function annotations are Python 3 only, so we can't use that
> > syntax yet anyway. If you want to use type hints that are understood by
> > tools (like mypy) and compatible with Python 2, you have to use
> > something like this (feel free to be more specific than Any):
>=20
> Do we really feel like staying compatible with Python 2, though?

Feel like it? No.

It's more that we are compelled to do so because we only deprecated it
in 4.1.

Kevin

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdgMHkAAoJEH8JsnLIjy/W9g0QALk5RR+ggy/ZrS0mORZDo9BT
5WpH2Qni8aAwBI6ZGNeB7BZ+6uASTbV4IwJbkZGVUSOHzyRxjrovusli7VGcUl0i
SvW+Ftw9E8fa3EDvxeWLgzJbDePmCQ5wUQy60EPLlV9Y1RJMF1Z+IvMVADJrmcLn
VjEBRccpZUeBcFm7MGSdEm9qYXvJqK5fqp8XSZvOGkoo+t/6HaHjVTcdofzFZRFL
B4vVMWo3rUYyNyf+LAV0BAjk7XAouWG1IQdn2hG2MAMYLSir2BaTS2K9KhFYmZBx
pSDWY9vrvRaYVaF2CUsbJ/7hvjVh+nq8LmY6oWKxtQ2UIYqxTp3YnM42yW+qVS7t
GD2jfLFIh8J9x5BQHTztK+Onk0D5n7+u20TcuK/5LiBfaHTyKc4i9VxH/whAqElP
kD25Fj24ra2O+nbPxMw4OFroIvcmPYwBqvS+x1tCNVOXSA4GeH2xVL+hbhM3M8l2
tKchTse65HzF40jYsnPXyymzYr08kL3r53VUXq9XkbssiFB2u0ryVSI+280fDquP
5g3Ibf8UccuQyGtsyseF35alRdZImKp3Mxpho9t4xmV4+mxovIXA8YhwrZYygX23
DkBumYZPKDJQ4iLIlUReE0e754PESLXhfAe1TSp54478/SQmQUizwFTmMTNNvbif
YoagqM0eWgYIfxG96CH6
=sCU8
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

