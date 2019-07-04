Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7F6C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACDD2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACDD2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiywv-0005u2-Uv
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45081)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hiyvJ-0004wi-Hb
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hiyvI-0007ii-5B
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:25:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hiyvH-0007i6-VE
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20F813082141
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 10:25:03 +0000 (UTC)
Received: from localhost (ovpn-117-206.ams2.redhat.com [10.36.117.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29C9318666;
 Thu,  4 Jul 2019 10:24:57 +0000 (UTC)
Date: Thu, 4 Jul 2019 11:24:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190704102457.GE1609@stefanha-x1.localdomain>
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline
In-Reply-To: <20190703172501.GI23082@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 04 Jul 2019 10:25:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 06:25:01PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jul 03, 2019 at 07:10:05PM +0200, Philippe Mathieu-Daud=E9 wrote:
> > @@ -306,6 +308,13 @@ bool trace_init_backends(void)
> >      openlog(NULL, LOG_PID, LOG_DAEMON);
> >  #endif
> > =20
> > +    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
> > +    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
> > +    trace_env =3D getenv("QEMU_TRACE_EVENTS");
> > +    if (trace_env) {
> > +        trace_enable_events(trace_env);
> > +    }
> > +
>=20
> I don't think it is a nice idea to add this via environment variables
> to QEMU itself. Why not modify libqtest qtest_init_without_qmp_handshake
> to read the env vars and then pass a suitable -trace arg when spawning
> QEMU ?

What is the concern about adding these environment variables to QEMU?

It is convenient to be able to use tracing even if QEMU is invoked by
something you cannot modify/control.

The main issues I see with environment variables are:

1. Security.  Is there a scenario where an attacker can use environment
   variables to influence the behavior of a QEMU process running at a
   different trust level?

2. Name collision.  What is the chance that existing users already
   define environment variables with these names and that unexpected
   behavior could result?

Stefan

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0d0/gACgkQnKSrs4Gr
c8gfRAgAiJrSe50/73/fBgUZPX1dxFwOp45fo85+HUjB7NdhUUOXGD7KOCEfEtbD
28wupfDcpzXof6VmviFry/fYCVv+FE42h+6KbN81cDekrqxYVxJJHlEVrchciMrJ
nDV4np3B52XlnmnzZBXNhjvBKq4nAOYWe6aiE/oBtBzNbAht+3603Ow9eLGLoA3j
4e/A/tYjeAUcy78U4ryJRnJm8o46OmAEAbHndemdObDaNvxcUHfxXtw8/IN6A/yb
Scp02E/CZiTVTbQt+0/1BdG7klk2stZd6+M6k1C9lp4dm0/An1HhPOfIlHQ4e5Fy
Z2zuTeEUmGUMv7mdmU83gktPHj+bgQ==
=tOb0
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--

