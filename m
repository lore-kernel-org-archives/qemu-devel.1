Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12646ECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E5E20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E5E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL990-0002A6-GK
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iL8NZ-000089-30
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iL8NY-0000sp-1Y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:11:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43170)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iL8NX-0000sP-SF
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9EDA30089BA
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 16:11:54 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99CF919D70;
 Thu, 17 Oct 2019 16:11:51 +0000 (UTC)
Date: Thu, 17 Oct 2019 17:11:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 2/2] virtiofsd: move to a new pid namespace
Message-ID: <20191017161150.GD1266@stefanha-x1.localdomain>
References: <20191016160157.12414-1-stefanha@redhat.com>
 <20191016160157.12414-3-stefanha@redhat.com>
 <20191017144553.GA12588@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <20191017144553.GA12588@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 17 Oct 2019 16:11:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2019 at 10:45:53AM -0400, Vivek Goyal wrote:
> On Wed, Oct 16, 2019 at 05:01:57PM +0100, Stefan Hajnoczi wrote:
>=20
> [..]
> > +	/*
> > +	 * If the mounts have shared propagation then we want to opt out so o=
ur
> > +	 * mount changes don't affect the parent mount namespace.
> > +	 */
> > +	if (mount(NULL, "/", NULL, MS_REC|MS_SLAVE, NULL) < 0) {
> > +		fuse_log(FUSE_LOG_ERR, "mount(/, MS_REC|MS_SLAVE): %m\n");
> > +		exit(1);
> > +	}
>=20
> So we will get mount propogation form parent but our mounts will not
> propagate back. Sounds reasonable.
>=20
> Can we take away CAP_SYS_ADMIN from virtiofsd? That way it will not be=20
> able to do mount at all.=20
>=20
> I am wondering are we dependent on daemon having CAP_SYS_ADMIN.=20

I don't know the answer.  Additional patches to reduce the capability
set as much as possible would be great, but are a separate task.

Stefan

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2oksYACgkQnKSrs4Gr
c8gRPAf/WjlSHNmLI310xJzO+cYRNz6NrPw79qoYflQ98baGOpkUsQ2rKn7pT76M
g/aPiAYEWwydbnlQvcOoPuVjWVVn7eDuhyUza5ezu6iT5DEqmCVIk284sClJdWXv
CRpPxOeRc1wkJwkIE2qyAKCfjt/gKy5cXfQ56vudM64YKOxoyN31xNUlvk9i+R5i
M90QW4jpqb0rTlV7S4C/I6JVI2NGYy/uqm7qWIJ7umst+/G9Mi91JjQ+3zOK9yd6
TI2Wj+Eguv672sIGHLgmzdLgo0NI1fEL2jOmu4crijOfYEwJ2MpwZtZYeP6UN6zR
h93HcxFa7H2DRSU/CqRicj1rIQrhIg==
=pNX6
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--

