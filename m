Received: from eggs.gnu.org ([2001:4830:134:3::10]:49436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1emGXI-0000mF-RT
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1emGXD-0005ND-Se
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:13:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1emGXD-0005N2-NB
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:12:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 633469BB57
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 10:12:59 +0000 (UTC)
Date: Thu, 15 Feb 2018 11:12:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180215101257.GC4575@localhost.localdomain>
References: <20180213142102.14450-1-stefanha@redhat.com>
	<20180213142102.14450-2-stefanha@redhat.com>
	<73eb771d-ddcd-42e6-5895-23e6024ccc80@redhat.com>
	<20180214140647.GC7545@stefanha-x1.localdomain>
	<8894e9fa-8e3d-ecfe-07f4-61a465f4bf57@redhat.com>
	<20180215092730.GA23321@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20180215092730.GA23321@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: extract AIO_WAIT_WHILE()
 from BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 15.02.2018 um 10:27 hat Stefan Hajnoczi geschrieben:
> On Wed, Feb 14, 2018 at 04:31:45PM -0600, Eric Blake wrote:
> > On 02/14/2018 08:06 AM, Stefan Hajnoczi wrote:
> > > On Tue, Feb 13, 2018 at 10:01:06AM -0600, Eric Blake wrote:
> > > I hope this explains things!  The main issue that raised these questi=
ons
> > > was that aio_context_in_iothread() has a misleading name.  Shall we
> > > rename it?
> >=20
> > Maybe, but that's a separate patch.  What name would we bikeshed, maybe
> > aio_context_correct_thread() (we are the correct thread if we are the
> > iothread that owns ctx, or if we are the main thread and have properly
> > acquired ctx)=20
>=20
> Having acquired the AioContext does not make this function return true.
> The semantics are:
> 1. Current thread is the IOThread that runs the AioContext
> 2. Current thread is the main loop and the AioContext is the global
>    AioContext.
>=20
> The function tests whether the current thread is the "native" or "home"
> thread for this AioContext.  Perhaps we could also call it the "poller"
> thread because only that thread is allowed to call aio_poll(ctx, true).
>=20
>   if (aio_context_in_native_thread(ctx)) {
>       ...
>   } else {
>       ...
>   }
>=20
> What do you think?

"home" or "native" both work for me. Or if we want to keep the name
short, maybe just changing the order and s/iothread/thread/ would be
enough: bool in_aio_context_thread(AioContext *ctx) - do you think that
would still be prone to misunderstandings?

Kevin

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJahV0pAAoJEH8JsnLIjy/WNIUP/3WzlLB7G1aPy1JYl8TEONzH
tnfVh2/6ZfavwgCzUSClR5M+ichMG5yjHrEnLLLoFPkWgb8c6Z56wxIHVwb/ZLhW
HO4UzTsxycWTPG4ZHouDhjE/dOpvb4SfCum0zWM3aNpju8MMKo3M0idr+jgUcD2e
/Kn9Y2XnnViLgoc4+9piM2kV8biH9YR8Z8ocroYzisepmasQ96KrNK1/XlIoTagI
c9UPWO15Nuhryjz0VgcsI3FrGfbaRAN54tKIS/dCpRAd81GwfmAugyAk06suKINd
c+/ds3ypH2sR35Xx8E0kAFnWmVpnJrchkhygwvg7pmRfnlTiSjitoZyVtSDjwMNg
PezBuYtSbpCazGers+rF/GMLtH397Z6MlY6S72a+4g6YiVOHBHv3ZWHUM711Pi/x
6TyMINJvePuOzIzBEMBUDh5C7j/njEpLRuLGb/ofbowY45Jq4TM5aNuHmHr820uu
LzQufdSmJ93tQbKhAP0vrW9QBzCgGgLrVxRUjuTQ0h5wdW8nCPOAAzZKWuSFiTSQ
uFKBt8rxuh1462gdThGWpIYv2fJuQMwsW4JSj9lrwP/rTblhmxWyRAFaj8iF/OVj
/e+KCElOTtMKt1nEXJYUBdmcFvoiLZmWFmCGejWG1HAcJ5SXMirSCB2//Cvbi3/V
YkY892QNUA/+1t7YeLBq
=FgH4
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
