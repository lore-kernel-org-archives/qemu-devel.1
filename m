Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF5C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D7E215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nVVThD8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D7E215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGLLA-0006W5-Bz
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iGKHJ-0004d6-1K
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iGKHG-0002oi-1T
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:53:36 -0400
Received: from ozlabs.org ([203.11.71.1]:58869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iGKHF-0002nl-Lw
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:53:33 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46l4vF4PMlz9sQr; Fri,  4 Oct 2019 19:53:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1570182809;
 bh=FqwY6Q6eoQumKCr5wennTgTta4p7lmhNwQab/YlSmkU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nVVThD8lP13+nBoqUWCc70SzqLuBxoReM58EvjNYT0sviDpqrGsm6INI5yrlqpU/x
 WIumCZwkQEvZj01c04WujpuUBwnJNKTd05MCzoFd2xzgicozUSu9TFkF9ZIp6d5C9M
 LdikoNeOfcIVpNkcXKo85TDx2KGjioGYIWGlLDOo=
Date: Fri, 4 Oct 2019 19:52:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: Skip
 LinuxInitrd.test_with_2gib_file_should_exit_error_msg_with_linux_v3_6 on
 32-bit hosts?
Message-ID: <20191004095232.GA29310@umbus.fritz.box>
References: <20191004052906.GC27597@umbus.fritz.box>
 <20191004083237.GA25716@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20191004083237.GA25716@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2019 at 09:33:38AM +0100, Daniel P. Berrang=E9 wrote:
> Re-adding qemu-devel since it seems to have been Bcc'd.
>=20
> On Fri, Oct 04, 2019 at 03:29:06PM +1000, David Gibson wrote:
> > When I run make check-acceptance in a 32-bit (i686) container, this
> > test fails, because it tries to start a guest with 4G of RAM, which
> > can't fit in the userspace address space on a 32-bit host, obviously.
> >=20
> >  (16/44) /home/dwg/src/qemu/tests/acceptance/linux_initrd.py:LinuxInitr=
d.test_with_2gib_file_should_exit_error_msg_with_linux_v3_6: FAIL: Regex di=
dn't match: '.*initrd is too large.*max: \\d+, need 2147483648.*' not found=
 in 'qemu-system-x86_64: -m 4096: ram size too large\n' (0.12 s)
> >=20
> > Should we simply skip this test on 32-bit hosts?
>=20
> There's a thread right now asking if we should drop support for 32-bit
> hosts entirely
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06168.html

Huh.

> I'm curious why you were testing with 32-bit host ? Do you have some
> use case that needs it, or was this just responding to some user bug
> report

A 32-bit build (actually, a couple) is part of my routine pre-pull
tests, precisely because I've accidentally included some things that
broken them.

> As long as we do support 32-bit hosts though, this test definitely needs
> fixing. It is attempting to boot with a 2 GB initrd, so I guess RAM
> needs to be big enough to fit that & boot the guest OS image. Possibly
> it might still work in 2.5-3.0 GB of RAM in guest if that's sufficiently
> small for 32-bit host testing. If not, then skipping seems reasonable,
> as no one will ever use such huge initrds on 32-bit hosts in real
> world.

Right.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2XFl4ACgkQbDjKyiDZ
s5JyrhAA464va2AQAza7DtQIeFggtld8j65w2IChoPt/jR+ue6VxUGfPWgZ6xo7W
NxlxWnGnfWx6vcH3VEhxSl1Yf0t+iIKp1JnYDPtuTdGZYLVhIi/bWCd/HhGebTI2
r2mTLi6xmxkhl5FMKJBmD+GI1B3AlPU7vkOMkaLNAJNmEXONvk3CFaZ3yMGXgNNb
7FTlReAYs2SpO3mKmLN79mSKrxPmWllH3HviYggAclnjLQziE5o3ui36tu6hzX04
Lt0+QI+O7+VXlimBt58rUUY0XSjePhdeoqj1HuvW6p8JG4eYf2UgUSax6goSVgbZ
lXd5bfz+FSqmD3Lht9nE0OBK4rxh1r5zdnHw3cx4e/HkBc2v3y/ZuovIOXwGdoLB
kWxRz3FR793iXPl7HHzKdVZ92hRE/0P1TM4kF9allsDGXOLrWsmyFMISzLq5xb7B
LMWVjGFALsotTBF/SN3OtWxjMxDcaYEPUNLwvb5j5X0VZDi8NX/XSsjk/HKPd4LS
TbYPtfriQDTLukTvCqjRaKgePno5PxOzjorsiQqzyj22ERZF6MfsS4jj51PQ3Jyj
+iMFX7mFIncSg9dlk+amJjVq+Hu+s7h6xiCd72NmR7NMw/kmGG3lVz6NGmbiM5AV
M7vZ9weqzpLpyumuxNVdTBXaJb2MqIn3FoDHjd5PD6EkkLfkHss=
=7LyY
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

