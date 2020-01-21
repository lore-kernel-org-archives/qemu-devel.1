Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B91C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BD6217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GuQkFXPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BD6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itziS-0007JT-8b
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 15:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1itzhb-0006r4-G0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1itzhV-0005tf-LT
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:00:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47048
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1itzhV-0005rZ-9f
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579636836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X7LoFPiZ4qvENEZvG3fOpxSynwKLFyM5hBsxT/V5Swk=;
 b=GuQkFXPM11YQtQQoB9ZltTTGbdTYdzyGASObfQQTRCUNbdJDXxAc3fTRPCqFo8KDPan7MY
 EYr256SWkaAhoCz6yk2iMh/ru1jX7rZJ75wv5N/eg9IBkJsNFMaYYo0rvfQa4JU3Wkvcik
 P8dM/Lk6fUE43PpJ76XI+HoYAZc4/6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-8x_7aPpRN8Wd4TEukS0jFQ-1; Tue, 21 Jan 2020 15:00:34 -0500
X-MC-Unique: 8x_7aPpRN8Wd4TEukS0jFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96A08DB60;
 Tue, 21 Jan 2020 20:00:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 695E510013A7;
 Tue, 21 Jan 2020 20:00:22 +0000 (UTC)
Date: Tue, 21 Jan 2020 15:00:19 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20200121200019.GA22131@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
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
Cc: Jeff Nelson <jen@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 02:33:54PM +0000, Peter Maydell wrote:
> On Mon, 2 Dec 2019 at 14:06, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > RFC: QEMU Gating CI
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This RFC attempts to address most of the issues described in
> > "Requirements/GatinCI"[1].  An also relevant write up is the "State of
> > QEMU CI as we enter 4.0"[2].
> >
> > The general approach is one to minimize the infrastructure maintenance
> > and development burden, leveraging as much as possible "other people's"
> > infrastructure and code.  GitLab's CI/CD platform is the most relevant
> > component dealt with here.
>=20
> Happy New Year! Now we're in 2020, any chance of an update on
> plans/progress here? I would very much like to be able to hand
> processing of pull requests over to somebody else after the
> 5.0 cycle, if not before. (I'm quite tempted to make that a
> hard deadline and just say that somebody else will have to
> pick it up for 5.1, regardless...)
>=20
> thanks
> -- PMM
>=20

Hi Peter,

Happy New Year too!

As an status update, I have some work queued up related to this work
that I need to do some minor polishing and then post to the mailing
list.  That has to do with the changes to container definition files,
and the most basic changes to the GitLab YAML configuration files to
achieve a first stage of implementation.

We'd also have to coordinate access to the existing machines in use,
so that we can validate that this proposal will work.  Just to be
extra clear, I'm available to this initial configuration on the
machines that are currently running the tests, provided you think it's
a good idea.  Also, that would also be helpful to me, as I'm learning
a lot of this stuff as I go, and there's always some tricky new
details on different environments.

PS: I'm actually on the road, but I should be settle by Tomorrow, and
I expect to resume work on this the following day.

Best Regards,
- Cleber.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl4nWFEACgkQZX6NM6Xy
CfNMYw/+LQxVdd0QEOe4gI47cD8IFK0/qwkNDYhCXstIq5NQbRptKtPv632PayXZ
B8rryeb52rIsLJTNGIvFInyrnDlbaRQLXFsBuOF1I2Tj5e3bmlbZERTbCHsLkBEl
aoTp3Gs01qzPp2jbSySqnmPIq71Ko/zy9dsYBxw+l+jYCmu3X5VHLpPDWRwrxtnd
Y8hP1HXwVxOD0/2xKScthDrtL2VnRVGu34iDQvVio1TSw/+s5MOeVtLPr/JdNmzi
U+IWVWI2JKoXb0sD2SC+3mmAE5dPc1J9KUzrcJeZQTnUy7v6xQzQi++wc4aTxQ8e
Dc2RTlklo1yzcvQxJn05ypwdrlKyL0KXaLYLmeBi2Xk+sDJrnfQ0djAn4NXUbfpN
w2Pm4IiuAfLytUDDDjUFoA4/rTxVP0UVY5WVR8nwN0fCnT0359e6kBXZNdo3JnA5
T7cc05ehnTLkSVJZaO98CXXKKJvEzbwOVOJKuSVSYsPpHBKiz0/suXQ6+ljqOcbr
aVATEG9Tu6NEsitf7HJiEjb3RlS+h2Y0sUohHtTZLV56yyxFlM6Uvg4JQLqLmx3S
z/FP9djfENsrlApMwY9nezgW4En/XxhU2Ynv9WvYBiIHKyA1DRL4cDUyjtQhpN26
ni97+zBn17opszZ0U5t/IACsQdEUnrTStK4ws7xJzkM1Mr7vxdg=
=iM9N
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


