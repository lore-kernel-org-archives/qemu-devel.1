Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3247CC3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5DB2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCXYkh6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5DB2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98ZK-0001se-W4
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:30:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j98Yf-0001Ms-8o
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:30:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j98Ya-00015M-AD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:30:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36868
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j98YZ-00012m-4J
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583245798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XTz8Vx78PMY59g1FgioZZUO+0EihYKzyR+NMz76nnE=;
 b=DCXYkh6O3N0q5+iVbLWQs4EQw//vaK9E+b3Mc7hVuamRk2VrN4PFwKK4P6WH1O/A8ms1I+
 grx/6Sgvjkg2AJiBS6BuMBIK1VHlIeUGY/3WZm6O8HPBX6P2dnZb+JQK+Mpm/kotd8JjPf
 2yRq7JHwZh6OA7bVm3jYkFONTTcvLoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-vjxwJxCXM6Onv3K9T5pEqw-1; Tue, 03 Mar 2020 09:29:55 -0500
X-MC-Unique: vjxwJxCXM6Onv3K9T5pEqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE92DDBE6;
 Tue,  3 Mar 2020 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-15.rdu2.redhat.com
 [10.10.123.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE3355C1D6;
 Tue,  3 Mar 2020 14:29:52 +0000 (UTC)
Date: Tue, 3 Mar 2020 09:29:50 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux
 logos displayed on framebuffer
Message-ID: <20200303142950.GA24302@localhost.localdomain>
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAFEAcA_ZL8kd+DaHz-debq7A2simEdB8GNzty890sfc=SjrByw@mail.gmail.com>
 <BN6PR2201MB12519E5CF54B5C921CD4404AC6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <741a03d4-4aa0-4782-771b-98468042c060@redhat.com>
 <CAP+75-WyFM7jKmBxiti5PMSJskmztQ7RLrTK72aW9LiLAWh+cw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP+75-WyFM7jKmBxiti5PMSJskmztQ7RLrTK72aW9LiLAWh+cw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 01:55:35PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Cleber,
>

Hi Phil!

>  On Tue, Mar 3, 2020 at 12:40 AM Philippe Mathieu-Daud=E9
> <philmd@redhat.com> wrote:
> > On 3/2/20 9:58 PM, Aleksandar Markovic wrote:
> > >> From: Peter Maydell <peter.maydell@linaro.org>
> > >> Sent: Monday, March 2, 2020 9:26 PM
> > >> To: Aleksandar Markovic
> > >> Cc: QEMU Developers; Aleksandar Markovic; Philippe Mathieu-Daud=E9
> > >> Subject: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple T=
ux logos displayed on framebuffer
> > >>
> > >> On Thu, 27 Feb 2020 at 13:28, Aleksandar Markovic
> > >> <aleksandar.markovic@rt-rk.com> wrote:
> > >>>
> > >>> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > >>>
> > >>> Add a test that verifies that each core properly displays the Tux
> > >>> logo on the framebuffer device.
> > >>>
> > >>> We simply follow the OpenCV "Template Matching with Multiple Object=
s"
> > >>> tutorial, replacing Lionel Messi by Tux:
> > >>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.=
html
> > >>
> > >> Hi -- this doesn't seem to work on my system:
> > >>
> > >
> > > Thank you for bringing this to our attention.
> > >
> > > It looks like an honest mistake to me. Too bad
> > > none of us tested the case of environment like
> > > yours, even though it looked reasonable to test it.
> >
> > I'm sorry I missed that, I'm pretty sure I tested it as we noticed this
> > "bug" in Avocado more than 1 year ago already (bug =3D class decorator =
not
> > working).
>=20
> I see in commit 2fe6f4d9ba you moved the @skip decorators to the setUp() =
method.
> Is this a kind of kludge to not use it on all the test_*() methods?
> (since we can not use it on an AvocadoTest class)
>

Yes, that was a workaround for a previous Avocado limitation.  As I said
on another thread, on Avocado >=3D 76.0 it's possible to just decorate the
entire class.

- Cleber.

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5eadwACgkQZX6NM6Xy
CfOxFg//RYjbjtJGQvGPh5cnW+6jnCwghL92o+Ymg7gZb8uzYxqd6bQINfha9Fcx
CMZfjNNO+nGs9XtVKyelpYUnRMcq6rbBmSrLaplG3CELpSUDd32jyNZuK0k9XK1L
10wBCGB8cQFQ9GhpmJr+VYPMkDwcBAHyTfEDVAF0Ax65z0iw+md3Jxy5k0FuaFI1
GJ6GSAZmxXKbRMT8DFReSiZSQH5nCncBtBTb4qUl1SqCD7iIU5tEPhXVZhu2FTH/
zFxgk3CKmDeLJFHx9jFeJ25zwLm8365W3SVvJLfjz9qTlyCLNOuEiu4Eyf7Pcosg
jSyEM5ufpgO7g21waLDnCDHrsSX3haKjIoI0OW0y9fqUcZFvZ0kgxMRobUick64t
/ijxaSe2/HLwrXm7PKJd/5ZBV4Nf6qJlGKetcaHo4RkGChD2NWWobG0Xy+1qlLys
YqAfH+kiuHApVXxsZ42bsrWLZdVJ5dnIetCPhKu5MGBBqKSTDY26FSptxRnARUkR
iZcoPdZUzOdZuWeqYkA99DPc3lGEYDntE0Qpu87FyK5tdEu+lROLvMH7/Oexlez8
V6YFe0pRoTJpyuGx+cruh+iXQqWhhXsNHfWB7Z2EjhURFQX7bL6eNsrQiGCv3cN/
ocZ/yVTswLp6dnyG+mPcgCpuOjn/FXhMgv+/RHOwmZdlnmOc4Q4=
=pCfU
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


