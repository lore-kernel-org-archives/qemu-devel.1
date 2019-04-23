Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50133C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18ADD206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 07:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pPwGTb1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ADD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49223 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIpYu-00024F-8F
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 03:09:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIpXe-0001LY-Vp
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIpJr-0001vj-AB
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 02:54:20 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:59363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hIpJq-0001nY-HD; Tue, 23 Apr 2019 02:54:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44pDh568Hxz9s9T; Tue, 23 Apr 2019 16:54:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556002453;
	bh=Du+TryElnCCVQnf/wHS8R5EJhNvd5Bp81Ivn2K+DdUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPwGTb1BZSmFUhMXys+b3MXxgqLpaGmYL6mZRAJVYh4HCVKshm8MsNrlmcvUkCFJg
	8o3k9TcV9kqKqdbou/EU19IYG6nLTpUD4pqL9FjB3iz7jZXJ0YQ3e6sqUO03Y7UbOv
	ahKc3LDdnFDRAtB6ZBS/cdfKpcn8ebH8+ANkwpOc=
Date: Tue, 23 Apr 2019 16:47:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190423064737.GE31496@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591658718.20338.10108476276907741991.stgit@aravinda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline
In-Reply-To: <155591658718.20338.10108476276907741991.stgit@aravinda>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v8 2/6] Wrapper function to wait on
 condition for the main loop mutex
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, aik@au1.ibm.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423064737.eJqxHxdKFQ7v5j2wWFceN8J4dS_RQwujlODhk5omwJM@z>


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 12:33:07PM +0530, Aravinda Prasad wrote:
> Introduce a wrapper function to wait on condition for
> the main loop mutex. This function atomically releases
> the main loop mutex and causes the calling thread to
> block on the condition. This wrapper is required because
> qemu_global_mutex is a static variable.
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  cpus.c                   |    5 +++++
>  include/qemu/main-loop.h |    8 ++++++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/cpus.c b/cpus.c
> index e83f72b..d9379e7 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -1858,6 +1858,11 @@ void qemu_mutex_unlock_iothread(void)
>      qemu_mutex_unlock(&qemu_global_mutex);
>  }
> =20
> +void qemu_cond_wait_iothread(QemuCond *cond)
> +{
> +    qemu_cond_wait(cond, &qemu_global_mutex);
> +}
> +
>  static bool all_vcpus_paused(void)
>  {
>      CPUState *cpu;
> diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
> index f6ba78e..a6d20b0 100644
> --- a/include/qemu/main-loop.h
> +++ b/include/qemu/main-loop.h
> @@ -295,6 +295,14 @@ void qemu_mutex_lock_iothread_impl(const char *file,=
 int line);
>   */
>  void qemu_mutex_unlock_iothread(void);
> =20
> +/*
> + * qemu_cond_wait_iothread: Wait on condition for the main loop mutex
> + *
> + * This function atomically releases the main loop mutex and causes
> + * the calling thread to block on the condition.
> + */
> +void qemu_cond_wait_iothread(QemuCond *cond);
> +
>  /* internal interfaces */
> =20
>  void qemu_fd_register(int fd);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly+tQkACgkQbDjKyiDZ
s5LJ1BAAgKQ9jKuGBWJ7td4pp/tblbdTB51ZqSgVTO9Eu6owlj3y2ukc64VNf2Bi
/wqbPYN9LhztW4wTXVn4rJp1N1NBBH9KSCdLNYJZkY0Jb47EabToVkm3KiHr4GM7
qGozdqqj9NDTqGbzaF0rQmAPpl+fcif3qfULpoevTOLtW93rsvNmrIjzeQXi7hTm
IvcLbtbkVIqfYMkTecpa0E9unqabGHclw/lmlJuosQ2E2bnu/1gq217wO2Itt3T/
yD6uf6DagQaN9KMaBfnFyMfR8juRjywIftucg3PieD3FOpndewEBuPLvrCSVQf4Q
dQksvGj7VamHXfUKikoUAB/npBxWSgnw+1ER2eScfgTkKpfhkxRNA/9HPLQ/sE5s
XZaUumtWMsA+NyvXhi+UOz9RM2VR+iCZ10hw+PAde7SkymOVybYETzbZ0Ax8ZB3N
EnIe7SY7ZYOWPDGw/mc8cSlginGuWyCLV3ofbQNHSvGropniMWee9OVf73z61FEt
EU6X8Ry62DAvOKgLn7GhC5CKHQ3MjppTWSkhjV94eQj6HenfVci8vSq5N/lhFjPd
hGXHoceF/73Gf7vyW1V7eH+895NFtY01R8ekhn3DRYbArIHgYWobYcg11WepKA9c
pSfxdwY6bB0C4IdIeKCKXzVTYv+70DE+FOzIOl2QA3HnPmrR2UU=
=Zn4U
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--

