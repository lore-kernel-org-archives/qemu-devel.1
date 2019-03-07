Received: from eggs.gnu.org ([209.51.188.92]:53589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1w4f-0008Vw-9f
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1w4e-0006Bh-Fa
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:40:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1w4e-0006B5-5b
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:40:48 -0500
References: <20190307072218.9153-1-elena.ufimtseva@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8fd5b9f2-50cc-3a5c-1b5c-92fa2331064d@redhat.com>
Date: Thu, 7 Mar 2019 10:40:40 -0600
MIME-Version: 1.0
In-Reply-To: <20190307072218.9153-1-elena.ufimtseva@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ue61jTQOLzBVl401pRyCJ75EQlBlU54GZ"
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 22/37] multi-process:
 QMP/HMP commands to remove device from the remote process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Cc: ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com, kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com, berrange@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ue61jTQOLzBVl401pRyCJ75EQlBlU54GZ
From: Eric Blake <eblake@redhat.com>
To: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Cc: ross.lagerwall@citrix.com, stefanha@redhat.com, liran.alon@oracle.com,
 kanth.ghatraju@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, sstabellini@kernel.org, dgilbert@redhat.com,
 berrange@redhat.com, armbru@redhat.com
Message-ID: <8fd5b9f2-50cc-3a5c-1b5c-92fa2331064d@redhat.com>
Subject: Re: [multiprocess RFC PATCH 22/37] multi-process: QMP/HMP commands to
 remove device from the remote process
References: <20190307072218.9153-1-elena.ufimtseva@oracle.com>
In-Reply-To: <20190307072218.9153-1-elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 1:22 AM, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Add rdevice_del QMP & HMP commands to hot-unplug device from remote
> device.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---

Similar to my other mail (it will probably get hard to track whether
I've replied everywhere or in order, thanks to the threading, but I see
that's already been mentioned):


> +++ b/qapi/misc.json
> @@ -1717,6 +1717,33 @@
>  { 'command': 'device_del', 'data': {'id': 'str'} }
> =20
>  ##
> +# @rdevice_del:
> +#

New QMP commands should favor '-' over '_'; if we add it at all, it
should be 'rdevice-del'.

> +# Remove a device from a guest
> +#
> +# @rdev_id: ID of the remote device root
> +#
> +# @id: the device's ID
> +#
> +# Returns: Nothing on success
> +#          If @id is not a valid device, DeviceNotFound
> +#
> +# Notes: When this command completes, the device may not be removed fr=
om the
> +#        guest.  Hot removal is an operation that requires guest coope=
ration.
> +#        This command merely requests that the guest begin the hot rem=
oval
> +#        process.  Completion of the device removal process is signale=
d with a
> +#        DEVICE_DELETED event. Guest reset will automatically complete=
 removal
> +#        for all devices.
> +#
> +# Since: 3.0

and the soonest you're likely to get this in is 4.1.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Ue61jTQOLzBVl401pRyCJ75EQlBlU54GZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBSYgACgkQp6FrSiUn
Q2poPQgAqDw42IuabXhcVkjnyWN4gAiH00rNQXD1KwMOwoMugE0ZQq56odhtz0nR
LJH8VZNPlkoOe95q9nCroznoujeResrIFf6gJFReQC79Y5DF15OIAERr+GLa77Ex
QXqLFjv08O9ElWND34iOn+uPJW6OuesuE9NGqMAi9sbKdcwtBZ+3S/l5a5LF2NSC
m56jbJ5RjH+VIgeZ36qrgAk5EfsbYdIUYx/VOjgCY2v/24v3M5eHEcXwZ9LLHLgl
TKzjDOde0DXcsnr35cglgQyevhamJHZLKy+7cQKcmOtnYcpAhN+kAx+2QpEIReX1
mhsc+9EkPmQzGAIXIL9NWev6WV6knQ==
=2zzm
-----END PGP SIGNATURE-----

--Ue61jTQOLzBVl401pRyCJ75EQlBlU54GZ--
