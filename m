Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3Ah-0001pA-GI
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr3Ad-0007Dz-Hj
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 09:52:59 -0400
References: <1490175166-19785-1-git-send-email-he.chen@linux.intel.com>
	<20170322103405.rcye74zye6gvrfis@hawk.localdomain>
	<20170323072335.GC10166@he>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4c620bdf-5979-38f5-8dc2-74641c627151@redhat.com>
Date: Thu, 23 Mar 2017 08:52:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170323072335.GC10166@he>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aSlSVi119flFnvmNsdRmavNEsFwfjtXJJ"
Subject: Re: [Qemu-devel] [PATCH v3] Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>, Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aSlSVi119flFnvmNsdRmavNEsFwfjtXJJ
From: Eric Blake <eblake@redhat.com>
To: He Chen <he.chen@linux.intel.com>, Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <4c620bdf-5979-38f5-8dc2-74641c627151@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] Allow setting NUMA distance for different
 NUMA nodes
References: <1490175166-19785-1-git-send-email-he.chen@linux.intel.com>
 <20170322103405.rcye74zye6gvrfis@hawk.localdomain>
 <20170323072335.GC10166@he>
In-Reply-To: <20170323072335.GC10166@he>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 02:23 AM, He Chen wrote:

>>> -numa dist,src=3D1,dst=3D0,val=3D21 \

>>
>> And maybe should also point out how to set an unreachable node with 25=
5.
>>
> Thanks for your careful review. Regarding setting unreachable node,
> which way is good? Set exact 255 as distance or distance that is larger=

> than 255 is regarded as unreachable?

Given that you spec'd val as 'uint8', you can't pass a value for
distance that is larger than 255.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aSlSVi119flFnvmNsdRmavNEsFwfjtXJJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY09MoAAoJEKeha0olJ0NqEDsH/0kauDQHjgH93I+2C7D78tXZ
XuJwTAsx35eolxLFYPasKbwrQ4QRsR/4DQB+enX12LTbaqNCWyw/UQu8ZyI9yDBM
4KuLxXD+LWFOfyKFjf9nAmtRJlaPzgvaXhHuoJRY+jjUxBIRGCf1cYQdacodhASm
1CB9b2FsqjSy7i3Ye03zqs3F6MtqvIL1IxYrRuKxUjhtqnDLQmwS6a3yEMtscikh
zAVXrRz7/ZCdv3jWtoVI832Gj7IZEOc4CyMbbwllshsNLMN1VCuW7mwFvPyGgG5D
FspF+htjYieTUNKRyNzigQ3scHKg/7M6pG/f8oBs3BpiQT+CF7DCLc8Gs/c5WwY=
=VMmG
-----END PGP SIGNATURE-----

--aSlSVi119flFnvmNsdRmavNEsFwfjtXJJ--
