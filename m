Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343D6C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:16:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069B720818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069B720818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYyN-000352-8h
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:16:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hRYxQ-0002lr-LU
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hRYxP-0008QP-Nz
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hRYxP-0008Nw-Fv
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A75EF37EE0;
	Fri, 17 May 2019 09:15:12 +0000 (UTC)
Received: from localhost (ovpn-117-183.ams2.redhat.com [10.36.117.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 255DE4A8;
	Fri, 17 May 2019 09:15:08 +0000 (UTC)
Date: Fri, 17 May 2019 10:15:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190517091507.GF3679@stefanha-x1.localdomain>
References: <20190510180410.GA10349@erokenlabserver>
	<20190515141712.GG29507@stefanha-x1.localdomain>
	<20190516134945.GA2293@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <20190516134945.GA2293@erokenlabserver>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 17 May 2019 09:15:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] chardev/char-i2c: Implement Linux I2C
 character device
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 02:49:45PM +0100, Ernest Esene wrote:
> On Wed, May 15, 2019 at 03:17:12PM +0100, Stefan Hajnoczi wrote:
> > On Fri, May 10, 2019 at 07:04:10PM +0100, Ernest Esene wrote:
> > > Add support for Linux I2C character device for I2C device passthrough
> > > For example:
> > > -chardev i2c,address=3D0x46,path=3D/dev/i2c-N,id=3Di2c-chardev
> > >=20
> > > QEMU supports emulation of I2C devices in software but currently can't
> > > passthrough to real I2C devices. This feature is needed by developers
> > > using QEMU for writing and testing software for I2C devices.
> > >=20
> > > Signed-off-by: Ernest Esene <eroken1@gmail.com>
> >=20
> > How is -chardev i2c meant to be used?  Do you have code to connect this
> > new chardev type to an emulated I2C bus?
> It is meant to be connected to emulated I2C bus as you've stated, but I
> don't have the code yet.

I'd like to see that code first, especially if it uses the chardev ioctl
to perform operations other than just read/write.  That could influence
the design of chardev-i2c.

Please keep this patch out-of-tree unless someone has an immediate use
for it.  If it gets merged too early (especially if a QEMU release is
made), then it's difficult to change the command-line interface if
changes are required to make it work with the I2C emulation.

Stefan

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzee5sACgkQnKSrs4Gr
c8g4xwgAqb2whebBbPu8nnU8cqyx2IYvNidb5U5dP/iXI5ZPFKYApIvmmaQNAXOL
EtxckM8Wn0cMLucJDDOaICrBD9mJbPWjtJn8bW8uzrbPxIJfbRAqIm2ujfk1cxLy
zhhQ7KwVhF66AkkoCMl72zSVmafM49liCSwDF75h5wOOsYIFm8Y1X8yoyLRSFAyu
3YTPMo4Es3j1/34VExaS8iNZEP7K5PWTVcwPJiyfPeUbJISOVpLRydNOniOphyZ4
fCEMyDSJTSTWR4IwfpPvZDjpW16ppidt680pXFzRG49d8EGXUwlM5LFbqFKtwX4J
7oD3kvSICDz15bl7m5WD0Bph5NZvqQ==
=QHQX
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--

