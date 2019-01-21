Received: from eggs.gnu.org ([209.51.188.92]:40489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gldB7-0005d1-GM
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gldB6-00038C-K8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:16:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gldB6-000365-Aa
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:16:04 -0500
References: <20190111153451.14304-1-tao3.xu@intel.com>
	<20190111153451.14304-5-tao3.xu@intel.com>
	<859ba7db-4129-1f8b-f4e4-8609f2d3755d@redhat.com>
	<1c57aaaf-4c12-fb6e-7d59-c113004dc3a8@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e781ace4-b415-2325-d74f-88f586de6dda@redhat.com>
Date: Mon, 21 Jan 2019 11:09:04 -0600
MIME-Version: 1.0
In-Reply-To: <1c57aaaf-4c12-fb6e-7d59-c113004dc3a8@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="J4gBZjxvv12wflNWNKMRiUcByGcpDSTLF"
Subject: Re: [Qemu-devel] [PATCH v2 4/9] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J4gBZjxvv12wflNWNKMRiUcByGcpDSTLF
From: Eric Blake <eblake@redhat.com>
To: Tao Xu <tao3.xu@intel.com>, mst@redhat.com, imammedo@redhat.com
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net
Message-ID: <e781ace4-b415-2325-d74f-88f586de6dda@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/9] Extend the command-line to provide
 memory latency and bandwidth information
References: <20190111153451.14304-1-tao3.xu@intel.com>
 <20190111153451.14304-5-tao3.xu@intel.com>
 <859ba7db-4129-1f8b-f4e4-8609f2d3755d@redhat.com>
 <1c57aaaf-4c12-fb6e-7d59-c113004dc3a8@intel.com>
In-Reply-To: <1c57aaaf-4c12-fb6e-7d59-c113004dc3a8@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/21/19 12:03 AM, Tao Xu wrote:

>>> =C2=A0 #
>>> +# @hmat-lb: memory latency and bandwidth information (Since: 2.13)
>> s/2.13/4.0/ (probably in multiple spots in your series)=20
> Hi Eric,
>=20
> Thank you for your comments. The spell mistakes in patches 1/9 to 6/9
> have been corrected in patch 7/9. Because patches 1/9 to 6/9 are jingqi=
's
> initial V1 patchesand7/9 to 9/9 are the changes compared withV1.

Still, it's better to rebase the series to avoid the mistakes in the
first place, instead of having churn with a mistake early in the series
corrected only later in the series.  Even if the mistake is corrected by
a different author than the bulk of the patch, as long as there are
Signed-off-by lines for both the original author and the person making
the spelling correction, then proper attribution has been made.

>=20
> About s/2.13/4.0/,do you mean ACPI HMAT will not be merged before QEMU
> 4.0?

Correct - 4.0 is the next release planned.  There was no 2.13 release;
after 2.12 was the 3.0 release; the current release is 3.1, and the next
release is 4.0; for more details, see
https://www.qemu.org/2018/08/15/qemu-3-0-0/ for a description of the
current version numbering scheme.  And even making it in time for 4.0
means polishing this by mid-March: https://wiki.qemu.org/Planning/4.0

>=20
> In addition, do you have any other comments about these patches?

I was commenting on the high-level user interface issues, but will leave
the bulk of the technical review to those more familiar with the code
being added.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--J4gBZjxvv12wflNWNKMRiUcByGcpDSTLF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxF/LAACgkQp6FrSiUn
Q2pmzAf/Y5X9/d0m/SO1IG5TD2QVkebq39S2AHvHc39Rx3M63IKjOopcCtZAMhdN
cXjcukZGwxbcT5dqi5GQygifEV1BZoxoHCPXI9mw0gypvy8cZW93PimvFxo/MeWC
mmt6pt35yqIN7R5NJCpWIn9fsO3q7DBMAsfob/U7V6jDBx1IKbGPp3zRBqIG6L0G
InGP7ySXxhVCSJrjdA9m4isPyXliKDbWiDsZ2bmIxjkavyeu7CLhDc17pztSScGF
YYPZL+nTpPTjiFGH657iXRkWxqZnWPNsJllN+4wsR0oLreL03gkwsA1z91SXG7Wk
ALL+Ip+BZu6NvEeFJDxE6AuqGAVIkQ==
=T8p1
-----END PGP SIGNATURE-----

--J4gBZjxvv12wflNWNKMRiUcByGcpDSTLF--
