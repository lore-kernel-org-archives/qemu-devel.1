Received: from eggs.gnu.org ([2001:4830:134:3::10]:50018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePWum-0004yp-Lr
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePWui-0000HW-KJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:03:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePWui-0000H0-CC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:03:16 -0500
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d174413b-b6bf-2730-fdd5-3669751c588d@redhat.com>
Date: Thu, 14 Dec 2017 11:03:12 -0600
MIME-Version: 1.0
In-Reply-To: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p39bTnfK34bpD0m7MI1MkWshAd09jfR3h"
Subject: Re: [Qemu-devel] QMP, HMP: introduce 'writeconfig' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p39bTnfK34bpD0m7MI1MkWshAd09jfR3h
From: Eric Blake <eblake@redhat.com>
To: Vadim Galitsyn <vadim.galitsyn@profitbricks.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Message-ID: <d174413b-b6bf-2730-fdd5-3669751c588d@redhat.com>
Subject: Re: QMP, HMP: introduce 'writeconfig' command
References: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
In-Reply-To: <20171023151310.6462-1-vadim.galitsyn@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/23/2017 10:13 AM, Vadim Galitsyn wrote:
> Hi Guys,
>=20
> This thread is a continuation of discussion started in
> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03182.html.
>=20
> This series introduces =E2=80=98writeconfig=E2=80=99 command support fo=
r QMP and HMP monitors. This functionality might be useful for live migra=
tion for cases when guest configuration was modified in runtime (for exam=
ple as a result of hot- plug/unplug operations) and actual Qemu command l=
ine no longer reflects setup exposed to guest.
>=20
> Original series has =E2=80=98qemu_opts=E2=80=99 patch as well (http://l=
ists.nongnu.org/archive/html/qemu-devel/2017-02/msg03183.html) because HM=
P=E2=80=99s =E2=80=98object_add=E2=80=99 result was not reflected in =E2=80=
=98writeconfig=E2=80=99 output. Later I found that QMP=E2=80=99s =E2=80=98=
object-add=E2=80=99 has the same issue. Anyway, I don=E2=80=99t include =E2=
=80=98qemu_opts=E2=80=99 patches here because Markus mentioned (here http=
://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg03476.html) that t=
his functionality is going to be reworked in some future and such patches=
 might collide with the rework process.
>=20
> Markus, could you please post if you have an update on this topic? Curr=
ent =E2=80=98master=E2=80=99 branch (9993c82dc2f5ce58b41d708b765e1a717ad4=
281d) still has the issue.
>=20
> Also, Markus mentioned that once configuration was changed during live =
migration -- it might be an issue because =E2=80=98writeconfig=E2=80=99 d=
ata became outdated (and might be make sense to think about to embed this=
 data into migration stream itself). In the same time David said that thi=
s is another problem which is unrelated to this patch series. What is you=
r current opinion on this topic? Can we consider these patches to be incl=
uded into =E2=80=98master=E2=80=99 taking into account that not all confi=
guration is dumped by =E2=80=98writeconfig=E2=80=99 (=E2=80=98object_add=E2=
=80=99 problem), but this can be fixed later?

I don't think we should expose 'writeconfig' via QMP as long as there is
still the chance of inconsistent data being written.  And I think we
have a lot more issues where existing code abuses QemuOpts in ways that
current configuration does not match the original command line, but
where you cannot easily expose the current configuration in a way that
would be reparsed by the command line into the current state.
Therefore, I'm not sure this series is worthwhile.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--p39bTnfK34bpD0m7MI1MkWshAd09jfR3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloyrtEACgkQp6FrSiUn
Q2oHNgf/Txofw1kLP5Okt9O6j3YiV3g1fzRXskAa8ig1lw7OvnKtqL6C420MhsN8
wcVH0cnAjs8qtaiu/O6vi6dN2pZUazS8jcmFYAhkk8qH1sxAfHYoNfA6THQ9pC0P
t0CVN48uXaZBVrqKrcbgxhrRowx2SMDsjc3vlZytSBnqUoakdxZ0S27lYGLBrAPS
4m492UWEbz02cRAY3WeqcGrFasnzWggn3/unvuM4B5Vd0CyE2KjoevJNee9xDDLL
lt+dVLlRFvVMHaQ8EZJ5WI+J3oJQywKuyXraQ6hnCUgiW5q74iWfMp/UFAT5GPd5
TMXiz8NzAlRTOXj7xb3xuBqNx9lP7A==
=m7NC
-----END PGP SIGNATURE-----

--p39bTnfK34bpD0m7MI1MkWshAd09jfR3h--
