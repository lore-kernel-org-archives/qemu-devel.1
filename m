Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700BFC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349EA2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349EA2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRdAD-00069E-Fm
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:44:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hRd9A-0005be-Fi
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hRd99-0006uO-5g
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>)
	id 1hRd93-0006Ui-9M; Fri, 17 May 2019 09:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D38BE6699E;
	Fri, 17 May 2019 13:43:11 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-198.brq.redhat.com [10.40.204.198])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 344CA78575;
	Fri, 17 May 2019 13:43:06 +0000 (UTC)
Date: Fri, 17 May 2019 15:43:02 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190517134302.GH2240@andariel.pipo.sk>
References: <20190408143543.3982-1-kwolf@redhat.com>
	<20190408143543.3982-2-kwolf@redhat.com>
	<87d0ljjd3f.fsf@dusky.pond.sub.org>
	<20190515105846.GB7508@localhost.localdomain>
	<87k1er6d76.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <87k1er6d76.fsf@dusky.pond.sub.org>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 17 May 2019 13:43:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] qapi: Support features for structs
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 15:48:29 +0200, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
> > Am 18.04.2019 um 22:03 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:

[...]

> > Do you expect libvirt to check a full list of all QMP commands, types,
> > etc. it ever uses against the schema after starting a VM or something
> > like that?
>=20
> I'm merely responding to demand.
>=20
> Subject: Minutes of KVM Forum BoF on deprecating stuff
> Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
>=20
> * We need to communicate "you're using something that is deprecated".
>   How?  Right now, we print a deprecation message.  Okay when humans use
>   QEMU directly in a shell.  However, when QEMU sits at the bottom of a
>   software stack, the message will likely end up in a log file that is
>   effectively write-only.
> =20
>   - The one way to get people read log files is crashing their
>     application.  A command line option --future could make QEMU crash
>     right after printing a deprecation message.  This could help with
>     finding use of deprecated features in a testing environment.
>=20
>   - A less destructive way to grab people's attention is to make things
>     run really, really slow: have QEMU go to sleep for a while after
>     printing a deprecation message.
>    =20
>   - We can also pass the buck to the next layer up: emit a QMP event.
>=20
>     Sadly, by the time the next layer connects to QMP, plenty of stuff
>     already happened.  We'd have to buffer deprecation events somehow.
>=20
>     What would libvirt do with such an event?  Log it, taint the domain,
>     emit a (libvirt) event to pass it on to the next layer up.
>=20
>   - A completely different idea is to have a configuratin linter.  To
>     support doing this at the libvirt level, QEMU could expose "is
>     deprecated" in interface introspection.  Feels feasible for QMP,
>     where we already have sufficiently expressive introspection.  For
>     CLI, we'd first have to provide that (but we want that anyway).

=46rom all of the above, the most important bit is still that the libvirt
developers at first identify sooner rather than later that something is
deprecated. That way we can either make sure to not use it any longer if
there's a compatible replacement or perhaps add the aforementioned
linter to print a warning that the config may not be supported in some
time.

The linter will still require us seeing what is deprecated, so marking
that in the schema is useful. There are two dimensions to this though.
QMP is the first, where introspection is awesome. Then there is command
line and it's various commands which don't have QMP counterparts and
that doesn't work that well there.

In normal operation there's not much we can do here as refusing to use
deprecated attributes or commands would cause regressions. In the test
suite we are already validating the output of some of our tests against
the QMP schema so making those fail when they are deprecated is
certainly possible but not very likely to ever catch something as our
QMP tests are exremely basic.

It would be much more potent to have something like this to allow
validating the command line automatically, but this would require using
some structured format first. Without that it's really up to us
implementing a check for every unsupported feature as we figure out it's
deprecated rather than having it done automatically.

Things got way better after we got CC'd on the deprecation document,
since we can make sure that we don't use the particular removed thing.

There are still a few things that are not addressed which were present
before this was happening. E.g. we don't specify the full NUMA topology
on the commandline and get an angry message back on the command line.
This is going on for almost a year now and nobody complained. Stderr
messages are ineffective.

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlzeumQACgkQHGwCByjY
1GqNqBAAlT2gQxF1YkWQIPi9Jh50p7lxZCGBchUZeyJZmZavLL3VSto3c6+00r1R
HX7lGr0HM4K6u5H3xmLlvE1Rytetj204hjKfd8JsAT52CbUcryKnfeWUPfYTslAk
1h/xQcjYOg4Kco3q0sQwtI0OKFNfsvX1nXBiUKlR9ksqo7r/B4T9fljFAOrLrFTt
4eGE29auKQ+iXAqlrXgJPyffeXAkgh99SkWGKYfY3mWaK2vwfwWt3vHthJJqlhJb
JzZXqxQzpxOLGNHpd153HwiuPCVQzVJaf+L4tGp3yvlIMtBEEdCxGnNh2z0w2Q47
QJkJqTDk1+xhY5Ovi3ja/VUhggxr09GJx7apgIf5XQgXYVyrgJaGpp9/DnrRKNGU
5To2/2ark3tp8bB/5k0S4gceaRc1k3lnDgtHCg7E5lXogJBBcYZPHMlx4Pc8Z92r
hcQo/hhKPra6pWSI5P9O256NqFQvL0ILIbHyT4QWa6i2ZLqcHS9893mJF+BI6aNz
m1BqlKisisVGY7S2uSLMRNS+jnXeE3KBgp4J7tXd6zegbmURuEiwfiQ7Mux78FPr
bnnLnLtp+sOPRduJDctsq9xWCpE645mGkZ2TwS5q/e6TSvkYX0lH0T+HM7jyMsrW
sTMJEDcYbWNbKGy2uj6GSnb5ae/tZp5pgcGRAwJ4fEjFXEr6DPw=
=IGEK
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--

