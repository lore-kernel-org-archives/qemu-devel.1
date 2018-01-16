Received: from eggs.gnu.org ([2001:4830:134:3::10]:60664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ebacp-0003yS-Qb
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ebacm-0001ja-Jy
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:26:39 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:45723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ebacm-0001ie-9t
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:26:36 -0500
Received: by mail-pg0-x22d.google.com with SMTP id c194so10269339pga.12
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 15:26:35 -0800 (PST)
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
Date: Wed, 17 Jan 2018 10:26:28 +1100
MIME-Version: 1.0
In-Reply-To: <20180116223413.GQ30352@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TozKKq1CDhUtQz9WxsW93tnGem060oicv"
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc:
 Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Andrea Bolognani <abologna@redhat.com>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TozKKq1CDhUtQz9WxsW93tnGem060oicv
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Andrea Bolognani <abologna@redhat.com>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
Subject: Re: [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc: Rework
 spapr_caps
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
 <1516110433.10494.5.camel@redhat.com>
 <20180116135459.GN30352@umbus.fritz.box> <1516113980.3278.1.camel@redhat.com>
 <20180116223413.GQ30352@umbus.fritz.box>
In-Reply-To: <20180116223413.GQ30352@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/01/18 09:34, David Gibson wrote:
> On Tue, Jan 16, 2018 at 03:46:20PM +0100, Andrea Bolognani wrote:
>> On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
>>>> Correct me if I'm wrong, but it seems to me like there's no way
>>>> to figure out through QMP whether these new machine options can be
>>>> used for a given QEMU binary.
>>>
>>> Uh, I don't think so.  These are machine options like any other (just=

>>> constructed a bit differently).  So they'll appear in qemu -machine
>>> pseries,? and I believe that info can also be retrieved with QMP.
>>
>> Yes, they will indeed show up in the output of -machine pseries,?
>> but there's AFAICT no way to retrieve them via QMP.
>=20
> Really!?  I thought introspecting object properties was QMP's bread
> and butter.


On a guest started with '-S':
{"execute": "qom-list", "arguments": {"path": "/machine"}}

returns:
{   'return': [   {'name': 'graphics', 'type': 'bool'},
                  {'name': 'phandle-start', 'type': 'int'},
                  {'name': 'dump-guest-core', 'type': 'bool'},
                  {'name': 'kernel-irqchip', 'type': 'OnOffSplit'},
                  {'name': 'accel', 'type': 'string'},
                  {'name': 'append', 'type': 'string'},
                  {'name': 'dumpdtb', 'type': 'string'},
                  {'name': 'igd-passthru', 'type': 'bool'},
                  {'name': 'dt-compatible', 'type': 'string'},
                  {'name': 'kernel', 'type': 'string'},
                  {'name': 'usb', 'type': 'bool'},
                  {'name': 'suppress-vmdesc', 'type': 'bool'},
                  {'name': 'dtb', 'type': 'string'},
                  {'name': 'firmware', 'type': 'string'},
                  {'name': 'mem-merge', 'type': 'bool'},
                  {'name': 'initrd', 'type': 'string'},
                  {'name': 'enforce-config-section', 'type': 'bool'},
                  {'name': 'kvm-shadow-mem', 'type': 'int'},
                  {'name': 'cap-dfp', 'type': 'bool'},
                  {'name': 'cap-htm', 'type': 'bool'},
                  {'name': 'cap-vsx', 'type': 'bool'},
                  {'name': 'vfio-no-msix-emulation', 'type': 'bool'},
                  {'name': 'kvm-type', 'type': 'string'},
                  {'name': 'max-cpu-compat', 'type': 'string'},
                  {   'name': 'dr-connector[268435480]',
                      'type': 'child<spapr-drc-cpu>'},
                  {'name': 'peripheral', 'type': 'child<container>'},
                  {   'name': 'dr-connector[268435472]',
                      'type': 'child<spapr-drc-cpu>'},
                  {'name': 'modern-hotplug-events', 'type': 'bool'},
                  {   'name': 'dr-connector[268435464]',
                      'type': 'child<spapr-drc-cpu>'},
                  {   'name': 'dr-connector[268435456]',
                      'type': 'child<spapr-drc-cpu>'},
                  {'name': 'peripheral-anon', 'type': 'child<container>'}=
,
                  {'name': 'ics', 'type': 'child<icskvm>'},
                  {'name': 'vsmt', 'type': 'uint32'},
                  {'name': 'type', 'type': 'string'},
                  {'name': 'rtc-time', 'type': 'struct tm'},
                  {'name': 'unattached', 'type': 'child<container>'},
                  {'name': 'rtc', 'type': 'child<spapr-rtc>'},
                  {'name': 'resize-hpt', 'type': 'string'}]}


but still requires a running qemu, yes.

>=20
>> And libvirt
>> can't afford to spawn a QEMU process for each machine type
>> implemented by each QEMU binary installed on the system just to
>> figure out what properties they support; in fact, we've been
>> pushing away from that approach - which was used initially - for
>> years and we're now at the point where we only fall back to it
>> for positively ancient QEMU versions. So the information needs
>> to be available through QMP for libvirt to consume it.
>=20
> Right, I'm not arguing with that.  It's just that I thought that
> standard QOM properties on QOM objects (the machine in this case) met
> the criteria.
>=20


--=20
Alexey


--TozKKq1CDhUtQz9WxsW93tnGem060oicv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlpeiiQOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILk4pQ//fXke3P9pJ7+h3K4UlZapywE+xAGJ5m4fE8UY
MR9iRs822Hr2Y/lpFiYLAk/FxsdjAdQR1PoPHDr7fgzslRkCbAhW25LgJNJU8B9s
cfD5TksXNKocLvpmqtRIPc3+9OoBlgGQj0eWDnKhbnSjUaOtDKeKmn4LeqzzCfyx
CgfYdS3XaySIdmTAPh2RaL4adZtdlBFJ9/MI1QE5+Ktjo2jCPP3SiH38+2dANfAZ
qT027T9s1Ee0gxMYohUn8Dc+NQhu9WjX+mOb5YuQhgJICaWcGu/owvr+DDsyQTns
gsa+HqFDF21kn4E1iLn9LN4Ioe2yI2B5qyCuYyM+KQRXTgPePoUcGEzzHtz3Kttk
i2QNGS1aMoEU20ziHrKXe8K1CGOV1n6CPUO7Gd3iaF6fwRKuv5JcLx6q6OMGCaa+
TOnpsZ5oJqlwMY8zP0UxPaDMiOQ44p9Ui/Fk5s4V512CAEZb3KlAr96Nxb+Jyf+D
yLw+vUrALwuwA93NUZU7QjbNxLYSBq9FpOTF8HlkcJ4pldw2sx8to4d2rVSJ0CSt
gQ56h/es9ZM9DzNj2sklHVU6zu5D9YF1ef1p0TnG8rj0xf7JzlQ17Y3m66YpntK5
DRk7XgQqK1M/S/TgwQurbl8HarHiw4du+tfRHNUP6l+5idd/SruxdIXW1jelOJAb
i4jgkgQ=
=8Aj1
-----END PGP SIGNATURE-----

--TozKKq1CDhUtQz9WxsW93tnGem060oicv--
