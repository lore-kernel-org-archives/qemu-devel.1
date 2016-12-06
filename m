Received: from eggs.gnu.org ([2001:4830:134:3::10]:49305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEOM8-0000If-5w
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEOM7-0001BU-5C
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:37:00 -0500
References: <20161202192223.15153-1-eblake@redhat.com>
	<20161202192223.15153-3-eblake@redhat.com>
	<42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
	<50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
	<110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
	<227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
	<1d974cec-fefe-e4c9-f2b0-1d8231b229cd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e0db4e1-92b9-d14d-9785-f98379cf36f9@redhat.com>
Date: Tue, 6 Dec 2016 16:36:48 -0600
MIME-Version: 1.0
In-Reply-To: <1d974cec-fefe-e4c9-f2b0-1d8231b229cd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wwAS008smMo2XeOSVpbxMLmRimTMafhX2"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] blkdebug: Add pass-through
 write_zero and discard support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wwAS008smMo2XeOSVpbxMLmRimTMafhX2
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <7e0db4e1-92b9-d14d-9785-f98379cf36f9@redhat.com>
Subject: Re: [PATCH v3 2/5] blkdebug: Add pass-through write_zero and discard
 support
References: <20161202192223.15153-1-eblake@redhat.com>
 <20161202192223.15153-3-eblake@redhat.com>
 <42b3c9e3-7c0d-4ec2-4257-1331f16d2c04@redhat.com>
 <50585dad-8418-f52c-8e19-418d8a064131@redhat.com>
 <110c4d8c-c87c-a8b5-04e0-985672e24337@redhat.com>
 <227dbbb5-0486-281b-6668-1dc88cfb6d91@redhat.com>
 <1d974cec-fefe-e4c9-f2b0-1d8231b229cd@redhat.com>
In-Reply-To: <1d974cec-fefe-e4c9-f2b0-1d8231b229cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 04:23 PM, Max Reitz wrote:
> On 06.12.2016 23:18, Eric Blake wrote:
>> On 12/06/2016 04:14 PM, Max Reitz wrote:
>>> On 06.12.2016 23:12, Eric Blake wrote:
>>>> On 12/06/2016 04:00 PM, Max Reitz wrote:
>>>>
>>>>>> Tested by setting up an NBD server with export 'foo', then invokin=
g:
>>>>>> $ ./qemu-io
>>>>>> qemu-io> open -o driver=3Dblkdebug blkdebug::nbd://localhost:10809=
/foo
>>>>
>>>> By the way, I'd LOVE to know if there is a way to write a qemu-io
>>>> command line that would do this connection automatically (so that I =
can
>>>> batch commands up front and benefit from the shell's history) rather=

>>>> than having to issue an 'open' after the fact.  I tried various
>>>> incantations with --object and --image-opts, but got stumped.
>>>
>>> Can't you just do qemu-io -c 'open'?
>>
>> I suppose that would get command-line history.  But I still want
>> interactive mode.  The moment you use -c, ALL commands get run
>> back-to-back without stopping, so I'd have to add additional -c
>> 'read'/'write' commands up front. I like interactive mode (open
>> pre-connected, now let me explore the image at will).
>=20
> Well, the usual --image-opts version would be:
>=20
> ./qemu-io --image-opts driver=3Dblkdebug,image.driver=3Dnbd,\
> image.host=3Dlocalhost,image.export=3Dfoo

Thanks, that appears to do the trick! I think I was getting confused by
trying 'file.driver' instead of 'image.driver', or maybe it was because
I was trying 'image.align' to set the blkdebug alignment where just
plain 'align' works once you are in --image-opts mode, or some such
problem on my end.  [Maybe I shouldn't be testing patches late at night,
either...]

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--wwAS008smMo2XeOSVpbxMLmRimTMafhX2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRz2AAAoJEKeha0olJ0NqLssH/Aju/FGm3FR4kSshxket+faj
xdJ/z6UeVHtta1U6SWIVunMLv/36eVDRe74zK5xhgClIYv4tYHO4ZHr8KgGtSz+A
zLLBIt4cegik/J+YN9GdwY6LWyO3MlNXwPMIYgd2Dza51dgCDkaOxR35Fck0bvHa
pNHJMxr1ezbUHhjdKtCevdohjq+XDZCEJK/oFZkf4KbffaRp/3by0VshdoFkU+Jf
WQg2U7ODL3xdeT+dANJAqB1dKKr7RIyRGWA50fJGOMkULpnTjXqX6RsbHDP5gxKa
LTYENxbtcwSHqrouctR2kmhjSPXrcXC0xQel5MFEK0SDKJBfoJf9YLfcQ0p2iJU=
=45qW
-----END PGP SIGNATURE-----

--wwAS008smMo2XeOSVpbxMLmRimTMafhX2--
