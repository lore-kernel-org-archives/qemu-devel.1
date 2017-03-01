Received: from eggs.gnu.org ([2001:4830:134:3::10]:51352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjBo7-00037T-Gu
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cjBo4-000583-Bg
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:29:11 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:60239)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cjBo4-00056n-5W
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:29:08 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9B48CB43C9
	for <qemu-devel@nongnu.org>; Wed,  1 Mar 2017 22:29:06 +0100 (CET)
Date: Wed, 1 Mar 2017 22:29:01 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170301222901.6b8154ed@bahia.lan>
In-Reply-To: <20170301115026.22621-2-stefanha@redhat.com>
References: <20170301115026.22621-1-stefanha@redhat.com>
	<20170301115026.22621-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/G7oOvpA2bE1kf/1J.luz=Kc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu-options: explain disk I/O
 throttling options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Nini Gu <ngu@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org

--Sig_/G7oOvpA2bE1kf/1J.luz=Kc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  1 Mar 2017 11:50:24 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> The disk I/O throttling options have been listed for a long time but
> never explained on the QEMU man page.
>=20
> Suggested-by: Nini Gu <ngu@redhat.com>
> Cc: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  qemu-options.hx | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c85f77d..bbd1bd9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -607,6 +607,30 @@ file sectors into the image file.
>  conversion of plain zero writes by the OS to driver specific optimized
>  zero write commands. You may even choose "unmap" if @var{discard} is set
>  to "unmap" to allow a zero write to be converted to an UNMAP operation.
> +@item bps=3D@var{b},bps_rd=3D@var{r},bps_wr=3D@var{w}
> +Specify bandwidth throttling limits in bytes per second, either for all =
request
> +types or for reads or writes only.  Small values can lead to timeouts or=
 hangs
> +inside the guest.  A safe minimum for disks is 2 MB/s.
> +@item bps_max=3D@var{bm},bps_rd_max=3D@var{rm},bps_wr_max=3D@var{wm}
> +Specify bursts in bytes per second, either for all request types or for =
reads
> +or writes only.  Bursts allow the guest I/O to spike above the limit
> +temporarily.
> +@item iops=3D@var{i},iops_rd=3D@var{r},iops_wr=3D@var{w}
> +Specify request rate limits in requests per second, either for all reque=
st
> +types or for reads or writes only.
> +@item iops_max=3D@var{bm},iops_rd_max=3D@var{rm},iops_wr_max=3D@var{wm}
> +Specify bursts in requests per second, either for all request types or f=
or reads
> +or writes only.  Bursts allow the guest I/O to spike above the limit
> +temporarily.
> +@item iops_size=3D@var{is}
> +Let every @var{is} bytes of a request count as a new request for iops
> +throttling purposes.  Use this option to prevent guests from circumventi=
ng iops
> +limits by sending fewer but larger requests.
> +@item group=3D@var{g}
> +Join a throttling quota group with given name @var{g}.  All drives that =
are
> +members of the same group are accounted for together.  Use this option to
> +prevent guests from circumventing throttling limits by using many small =
disks
> +instead of a single larger disk.
>  @end table
> =20
>  By default, the @option{cache=3Dwriteback} mode is used. It will report =
data


--Sig_/G7oOvpA2bE1kf/1J.luz=Kc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAli3PR0ACgkQAvw66wEB28KOGgCfephQ4Duzmd3GC6Q1YISOGvDs
uX4AnRYTeSrnK0uJBbkuiXH7p2YbmvU7
=nfzE
-----END PGP SIGNATURE-----

--Sig_/G7oOvpA2bE1kf/1J.luz=Kc--
