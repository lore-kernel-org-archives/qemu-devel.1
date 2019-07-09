Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E90C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63119214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63119214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkl9M-00054k-JP
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hkl8S-0004ax-7V
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hkl8Q-0004XS-8b
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hkl8P-0004H4-Q8
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:05:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 80E8D308A98C
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2019 07:58:23 +0000 (UTC)
Received: from localhost (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E456719C68;
 Tue,  9 Jul 2019 07:58:18 +0000 (UTC)
Date: Tue, 9 Jul 2019 09:58:16 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190709075816.GA25663@stefanha-x1.localdomain>
References: <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
 <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
 <87d0iok4ai.fsf@dusky.pond.sub.org>
 <c4997dee-932c-eb57-23b9-4b51e8856f91@redhat.com>
 <874l3zhktx.fsf@dusky.pond.sub.org>
 <20190708093400.GB3082@redhat.com>
 <e396d430-1e6e-2e0b-454b-5c4208756742@redhat.com>
 <20190708103804.GG3082@redhat.com>
 <87r26zah4k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <87r26zah4k.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 09 Jul 2019 07:58:23 +0000 (UTC)
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2019 at 07:53:15AM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>=20
> > On Mon, Jul 08, 2019 at 12:27:12PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> [...]
> >> Anyway, to stop bikeshedding this thread, can you add few lines about
> >> why not use getenv() in the HACKING?
> >
> > I don't actually think the getenv thing is a security issue in any case.
> > If there was a security problem exploitable via getenv, then the bug wo=
uld
> > lie in the application invoking QEMU for not ensuring the ENV contents
> > were safe before exec'ing QEMU.
>=20
> Correct.
>=20
> >                                 Libvirt is paranoid by default and scru=
bs
> > QEMU's env only keeping a specific sanitized whitelist for exactly these
> > reasons.
>=20
> Must have for running programs with different privileges.
>=20
> Corrollary: a program that does not use getenv() at all is slightly
> harder to misuse with different privileges.  Irrelevant in practice,
> because libraries use getenv(), starting with ld.so.

I'll reiterate that I'm happy to merge this but would first like to know
if Philippe is satisfied with adding it just to qtest?

Let's just add it to qtest if that is enough.  Otherwise let's bring it
into QEMU proper.

Stefan

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0kSPQACgkQnKSrs4Gr
c8j9kAf/b6CJZvpsYARf1ei8gRPqu3ZjYCTeL95i1A8sFvUO1zsZzxe49MzUuGDS
OOmhsEAKy5gxL4dFuji39tPF3Qvw0tckxKHJ/dUBrog2JrNxAYkFRBXtalcKckHS
vtdUIz88LovDQKAfnrA01lrFiU8tM/I9yujJe65lrOyT2mEUCXtan4UoGSBTwI/+
eU/XUGtFi4KmqPHOUSfl9JaR6V406QbY+IhHshy2ptxWCXchDpMZkLmVhgBObNcP
tcT33PzWMVN0oCFPG7DGWyc0XftAJ2J86J0cMy6wWvj1Q13bWkOWIExCr1ziH10b
Ywg7GKqOctOYxYshfPC1+BPN6/L2zA==
=qsIz
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

