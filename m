Received: from eggs.gnu.org ([2001:4830:134:3::10]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBiJN-0003Ew-C3
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBiJK-0000Jx-6f
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBiJJ-0000J9-TX
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 10:55:50 -0400
References: <20180417142739.GV29865@localhost.localdomain>
	<20180417174110.1a7f1daf@redhat.com>
	<20180417204135.GB29865@localhost.localdomain>
	<87d0yx2dqp.fsf@dusky.pond.sub.org>
	<20180419100004.0b560c85@redhat.com>
	<20180419194251.GZ29865@localhost.localdomain>
	<87muxy2xu1.fsf@dusky.pond.sub.org>
	<20180423115016.31b4a302@redhat.com>
	<20180423130554.GL29865@localhost.localdomain>
	<20180423185514.1dcaa223@redhat.com>
	<20180423204531.GR29865@localhost.localdomain>
	<20180426163911.270915c9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <318e4cfd-22ec-9cb1-a139-07e83a45ed8c@redhat.com>
Date: Thu, 26 Apr 2018 09:55:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180426163911.270915c9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wCCOfzVVbWKPPxG7SuhsJajoDSlUYhOp1"
Subject: Re: [Qemu-devel] [PATCH v4 0/9] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com, david@gibson.dropbear.id.au

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wCCOfzVVbWKPPxG7SuhsJajoDSlUYhOp1
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Message-ID: <318e4cfd-22ec-9cb1-a139-07e83a45ed8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/9] enable numa configuration before
 machine_init() from QMP
References: <20180417142739.GV29865@localhost.localdomain>
 <20180417174110.1a7f1daf@redhat.com>
 <20180417204135.GB29865@localhost.localdomain>
 <87d0yx2dqp.fsf@dusky.pond.sub.org> <20180419100004.0b560c85@redhat.com>
 <20180419194251.GZ29865@localhost.localdomain>
 <87muxy2xu1.fsf@dusky.pond.sub.org> <20180423115016.31b4a302@redhat.com>
 <20180423130554.GL29865@localhost.localdomain>
 <20180423185514.1dcaa223@redhat.com>
 <20180423204531.GR29865@localhost.localdomain>
 <20180426163911.270915c9@redhat.com>
In-Reply-To: <20180426163911.270915c9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2018 09:39 AM, Igor Mammedov wrote:

>>> I'll try to come up with a text for qemu-doc.texi, not about
>>> deprecating -S but about when --preconfig should be used vs -S
>>> and where to get list of commands that could be used at preconfig sta=
te. =20
>>
>> Sounds good to me.  Thanks!
> how about something like this:
>=20
> diff --git a/qemu-tech.texi b/qemu-tech.texi
> index 52a56ae..6951258 100644
> --- a/qemu-tech.texi
> +++ b/qemu-tech.texi
> @@ -5,6 +5,7 @@
>  * CPU emulation::
>  * Translator Internals::
>  * QEMU compared to other emulators::
> +* Managed start up options::
>  * Bibliography::
>  @end menu
> =20
> @@ -314,6 +315,44 @@ VirtualBox [9], Xen [10] and KVM [11] are based on=
 QEMU. QEMU-SystemC
>  [12] uses QEMU to simulate a system where some hardware devices are
>  developed in SystemC.
> =20
> +@node Managed start up options
> +@section Managed start up options
> +
> +In system mode emulation, it's possible to create VM in paused state u=
sing
> +-S command line option. In this state the machine is completely initia=
lized
> +according to command line options and ready to execute VM code but VCP=
U threads
> +are not executing any code. VM state in this paused state depends on w=
ay QEMU
> +was started. It could be in:
> +@table @asis
> +@item initial state (after reset/power on state)
> +@item with direct kernel loading initial state could be ammended to ex=
ecute

s/ammended/amended/

> +code loaded by QEMU in VM's RAM and with incomming migration

s/incomming/incoming/

> +@item with incomming migrartion, initial state will by ammended by the=
 migrated

and again, for both words
s/migrartion/migration/

> +machine state after migration completes.
> +@end table
> +
> +This paused state is typically used by users to query machine state an=
d/or
> +additionally configure machine (hotplug devices) in runtime before all=
owing
> +VM code to run.
> +
> +However at -S pause point it's impossible to configure options that af=
fect
> +initial VM creation (like: -smp/-m/-numa ...) or cold plug devices. Th=
at's
> +when -preconfig command line option should be used. It allows to pause=


s/to pause/pausing/

> +QEMU before initial VM creation in preconfig state, query being create=
d
> +VM at runtime and configure start up options depending on previous que=
ry

Reads awkwardly.  Maybe:

It allows pausing QEMU before the initial VM creation, in a new
preconfig state, where additional queries and configuration can be
performed via QMP before moving on to the resulting configuration startup=
=2E

> +results. In preconfig state QEMU allows to configure VM only via QMP m=
onitor
> +with a limited command set which doesn't depend on completely initiali=
zed
> +machine, which includes but not limited to:

In the preconfig state, QEMU only allows a limited set of commands over
the QMP monitor, where the commands do not depend on an initialized
machine, including but not limited to:

> +@table @asis
> +@item qmp_capabilities
> +@item query-qmp-schema
> +@item query-commands
> +@item query-status
> +@end table
> +The full list of commands is in QMP schema which could be queried with=

> +query-qmp-schema, where commands supported at preconfig state have opt=
ion
> +'allowed-in-preconfig' set to true.
> +
>  @node Bibliography
>  @section Bibliography
>=20

>> A separate command would have less room for ambiguity.
> I've added following instead of reusing 'cont':
>=20
> ##                                                                     =
         =20
> # @exit-preconfig:                                                     =
         =20

This should definitely be mentioned in the docs section of commands
permitted during preconfig.

> #                                                                      =
         =20
> # Exit from "preconfig" state                                          =
         =20
> #                                                                      =
         =20
> # Since 2.13                                                           =
         =20
> #                                                                      =
         =20
> # Returns: nothing                                                     =
         =20
> #                                                                      =
         =20
> # Notes: Command makes QEMU exit from preconfig state and proceeds with=
         =20
> # VM initialization using configuration data provided on command line  =
         =20
> # and via QMP monitor at preconfig state. Command is available only at =
         =20
> # preconfig state (i.e. if --preconfig command line option).           =
         =20
> #                                                                      =
         =20
> # Example:                                                             =
         =20
> #                                                                      =
         =20
> # -> { "execute": "exit-preconfig" }                                   =
         =20
> # <- { "return": {} }                                                  =
         =20
> #                                                                      =
         =20
> ##                                                                     =
         =20
> { 'command': 'exit-preconfig', 'allowed-in-preconfig': true }=20
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wCCOfzVVbWKPPxG7SuhsJajoDSlUYhOp1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrh6GwACgkQp6FrSiUn
Q2q7fggAqCrpWnbATurIjn3QzXDcj9GAiIYrGr7umLGL5b61tcvbBNeL2cfuRk8V
gOtuv/aHmyIpsd+HQYyoCuBcs8R5Kkn0q7p4qZJOXgkQKF1sM3A5Ul8j3dQn7giV
0wIKTIoDT3HJI0/qhfiO8u3Zoyg4wqJ1lYxlPgXyydEInwW/htiGP15QKApfqHcE
uSnHKTaNnkA7N7QD/fdq1jC4RRoIdXLULYrng2JcbC02wPBHQ1PKywtfMpnMpcYJ
qHKPtTKwK5NL7zVwFCNJUZGUp4U3mSNA2x+MIREcLVth0uSqtj+93yvR2FHKziPF
yyVBz5rFTDSvyf3roFG19lpbco4h3A==
=3/LF
-----END PGP SIGNATURE-----

--wCCOfzVVbWKPPxG7SuhsJajoDSlUYhOp1--
