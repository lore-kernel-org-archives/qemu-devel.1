Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93164C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6926C20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 08:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6926C20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0Y6-0004M5-OE
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 04:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hw0XY-0003Lj-3N
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hw0XV-000174-VI
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:46:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hw0XT-0000vS-SM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 04:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 174364E8AC;
 Fri,  9 Aug 2019 08:46:12 +0000 (UTC)
Received: from localhost (ovpn-116-125.ams2.redhat.com [10.36.116.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB7CC5D9DC;
 Fri,  9 Aug 2019 08:46:06 +0000 (UTC)
Date: Fri, 9 Aug 2019 09:46:05 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190809084605.GE25286@stefanha-x1.localdomain>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
 <20190807071445.4109-2-bala24@linux.ibm.com>
 <5839fa4e-b6f3-9547-e71d-50be75c4f9fc@redhat.com>
 <20190808101013.GD1999@stefanha-x1.localdomain>
 <20190808105307.GE2534@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <20190808105307.GE2534@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 09 Aug 2019 08:46:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: Peter Maydell <peter.maydell@linaro.org>, maddy@linux.vnet.ibm.com,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com, clg@kaod.org,
 hari@linux.vnet.ibm.com, pbonzini@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 11:53:07AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Aug 08, 2019 at 11:10:13AM +0100, Stefan Hajnoczi wrote:
> > On Wed, Aug 07, 2019 at 12:20:47PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > > > +void python_args_clean(char *args[], int nargs)
> > > > +{
> > > > +    for (int i =3D 0; i < nargs; i++) {
> > > > +        g_free(args[i]);
> > > > +    }
> > > > +}
> > > >=20
> > >=20
> > > Wondering about security, is this feature safe to enable in production
> > > environment? It seems to bypass all the hard effort to harden QEMU se=
curity.
> >=20
> > This seems like a feature that distros would not enable.  Only users
> > building QEMU from source could enable it.
>=20
> Well that's true when this scripting is only used from one obscure ppc
> device. Once merged though, its inevitable that people will want to
> extend scripting to more & more parts of QEMU code. This is a big can
> of worms...

When it gets used in new contexts it will be necessary to address
problems or accept that it is unsuitable for those use cases.  Starting
simple and dealing with challenges as and when necessary seems okay to
me.

I think we should give features a chance in QEMU if there is a
maintainer to support them.  I don't want to use this feature myself and
I see lots of issues with it for my use cases, but if it is compiled out
and doesn't place many requirements on code that does not use it, let's
give it a chance.

My main concern is licensing.  I think the QEMU Python API should be GPL
licensed because these scripts are executing as part of the QEMU
process.

Beyond that, let's see if people find this feature useful.  Maybe it
will die and be removed, maybe it will become popular and we'll have to
change our perspective :).

Stefan

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1NMs0ACgkQnKSrs4Gr
c8jz7wgAp3isgnapUAhkRT2BDo8Ix7oQWlNeP6HTfyKrr0blJv0rX0e05s/hm6YP
q5MkF7lAmDfM1+4hovPO/Jq/2j+mUSH7AAPhv37VwVHaO36j55LDL/FcXIKpMNDF
G9QnQ8V0j88ggY7SkFTo4bXJ/ys4OVwqHz6rqSjh+tBAUlPmIoVFLIogixw+J+5A
8OQz8CMmOMyjiLk9q5Gh1aHwl0EuyVDrfi6RGWyr/hWusqnk2EkZplL50bzgWi9F
OKAWkd8X/yHFqoQo3vwofGcvd450daNrTWh7eHXWeBD9PmgIgpQc693krr0Y+XAc
0SVkdVhP80G/paEQ16Qsfpaw4KzDXw==
=yF+N
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--

