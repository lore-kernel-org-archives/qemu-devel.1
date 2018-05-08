Received: from eggs.gnu.org ([2001:4830:134:3::10]:56497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fFz1D-0006Lf-FE
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fFz19-0001xd-GF
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:34:47 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:35959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fFz19-0001tH-A8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:34:43 -0400
Received: from player762.ha.ovh.net (unknown [10.109.120.62])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 60956C07B4
	for <qemu-devel@nongnu.org>; Tue,  8 May 2018 11:34:32 +0200 (CEST)
Date: Tue, 8 May 2018 11:34:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180508113425.003c5031@bahia.lan>
In-Reply-To: <71b68bd5-e50b-3baa-3f72-f6af78db4e2e@redhat.com>
References: <152568372989.443627.900708381919207053.stgit@bahia.lan>
	<71b68bd5-e50b-3baa-3f72-f6af78db4e2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc: e500: use g_strdup_printf() instead
 of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, 7 May 2018 12:53:45 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/07/2018 04:02 AM, Greg Kurz wrote:
> > qemu-system-ppc fails to build with GCC 8.0.1:
> >=20
> > /home/hsp/src/qemu-master/hw/ppc/e500.c: In function =E2=80=98ppce500_l=
oad_device_tree=E2=80=99:
> > /home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic@=
=E2=80=99
> > directive output may be truncated writing 5 bytes into a region of
> > size between 1 and 128 [-Werror=3Dformat-truncation=3D]
> >       snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_REG=
S_OFFSET);
> >                                       ^~~~~ =20
>=20
> >=20
> > Fix this by converting e500 to use g_strdup_printf()+g_free() instead
> > of snprintf(). This is done globally, even for call sites that don't
> > break build, since this is the preferred practice in QEMU.
> >=20
> > Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   hw/ppc/e500.c |   39 +++++++++++++++++++++++----------------
> >   1 file changed, 23 insertions(+), 16 deletions(-)
> >  =20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Hi Peter,

David said the next pull request for ppc would happen in a month. This
patch fixes an annoying build break with recent GCC, and it already
got two positive reviews, is it possible to have it merged upstream ?

Cheers,

--
Greg
