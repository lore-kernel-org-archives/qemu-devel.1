Received: from eggs.gnu.org ([2001:4830:134:3::10]:50149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecNqN-0003N2-Pa
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ecNqK-0005Go-Nj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:59:55 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ecNqK-0005GB-EJ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 22:59:52 -0500
Received: by mail-pg0-x243.google.com with SMTP id 136so437866pgd.8
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 19:59:52 -0800 (PST)
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
	<1516179297.3278.6.camel@redhat.com>
	<20180118042713.GJ30352@umbus.fritz.box>
	<1516290939.3278.22.camel@redhat.com>
	<20180119022210.GC30352@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7f785be9-5035-b04c-0569-56a1c5bb3618@ozlabs.ru>
Date: Fri, 19 Jan 2018 14:59:45 +1100
MIME-Version: 1.0
In-Reply-To: <20180119022210.GC30352@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CjHMAaaaCG3cHRebGeju4uOP9aBwDkYOg"
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
--CjHMAaaaCG3cHRebGeju4uOP9aBwDkYOg
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Andrea Bolognani <abologna@redhat.com>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <7f785be9-5035-b04c-0569-56a1c5bb3618@ozlabs.ru>
Subject: Re: [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc: Rework
 spapr_caps
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
 <1516110433.10494.5.camel@redhat.com>
 <20180116135459.GN30352@umbus.fritz.box> <1516113980.3278.1.camel@redhat.com>
 <20180116223413.GQ30352@umbus.fritz.box>
 <62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
 <1516179297.3278.6.camel@redhat.com> <20180118042713.GJ30352@umbus.fritz.box>
 <1516290939.3278.22.camel@redhat.com>
 <20180119022210.GC30352@umbus.fritz.box>
In-Reply-To: <20180119022210.GC30352@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/01/18 13:22, David Gibson wrote:
> On Thu, Jan 18, 2018 at 04:55:39PM +0100, Andrea Bolognani wrote:
>> On Thu, 2018-01-18 at 15:27 +1100, David Gibson wrote:
>>>> I looked further and device-list-properties looks like it would
>>>> do the trick; however it doesn't seem to work for machines:
>>>>
>>>>   {"execute": "device-list-properties",
>>>>    "arguments": {"typename": "spapr-2.11-machine"}}
>>>>   {"error": {"class": "GenericError",
>>>>              "desc": "Parameter 'typename' expects device"}}
>>>>
>>>> It works fine for the likes of virtio-scsi-pci and even
>>>> power9_v2.0-powerpc64-cpu, though. Any ideas? :)
>>>
>>> I'm guessing it's because machines aren't descended from TYPE_DEVICE.=

>>>
>>> Dammit.  I really can't see a reasonable way of addressing this other=

>>> than improving qapi in general to have a way of reporting machine
>>> class properties.  Adding something ad-hoc for just these properties
>>> of this machine seems like madness.
>>>
>>> Nor can I think of a place to put these that would be both sensible
>>> and more discoverable with existing mechanisms.
>>
>> The relationship between QOM/QAPI/QMP is not very clear in my mind,
>=20
> You and me both :/
>=20
>> as you might have guessed from my messages, so I don't think I can
>> offer much useful input. But if the properties are registered using
>> the same mechanism both for devices and machines, then maybe there
>> should be a QMP command that can list them regardless of the parent
>> type? object-list-properties or something like that.
>=20
> So, it's a bit complicated.  The underlying mechanism is QOM
> properties in all cases.

There are 2 types of properties really.

typedef struct DeviceClass {
[...]
    Property *props;

These are printed by QMP's device-list-properties. Machine is not a devic=
e
so we do not see them.


struct ObjectClass
{
[...]
    GHashTable *properties;

These are printed by qom-list/get but these QMP commands take path as an
argument and therefore require instances, not classes.


DeviceClass::props migrate to ObjectClass::properties in device_initfn.


So I guess we will either need to:
- merge all the properties to Object/ObjectClass or
- rename&teach device-list-properties to work with objects rather than
devices or
- add qom-list-properties which will only print QOM properties.


The latter is fairly simple, I'll post an rfc patch in few minutes, it wi=
ll
do like this:


{"execute": "qom-list-properties", "arguments": {"typename":
"pseries-2.11-machine"}}


{   'return': [   {   'description': 'Set on/off to enable/disable graphi=
cs '
                                     'emulation',
                      'name': 'graphics',
                      'type': 'bool'},
                  {   'description': 'The first phandle ID we may generat=
e '
                                     'dynamically',
                      'name': 'phandle-start',
                      'type': 'int'},
                  {   'description': 'Include guest memory in  a core dum=
p',
                      'name': 'dump-guest-core',
                      'type': 'bool'},
                  {   'description': 'Configure KVM in-kernel irqchip',
                      'name': 'kernel-irqchip',
                      'type': 'OnOffSplit'},
                  {   'description': 'Accelerator list',
                      'name': 'accel',
                      'type': 'string'},
                  {   'description': 'Linux kernel command line',
                      'name': 'append',
                      'type': 'string'},
                  {   'description': 'Dump current dtb to a file and quit=
',
                      'name': 'dumpdtb',
                      'type': 'string'},
                  {   'description': 'Set on/off to enable/disable igd '
                                     'passthrou',
                      'name': 'igd-passthru',
                      'type': 'bool'},
                  {   'description': 'Overrides the "compatible" property=
 of '
                                     'the dt root node',
                      'name': 'dt-compatible',
                      'type': 'string'},
                  {   'description': 'Linux kernel image file',
                      'name': 'kernel',
                      'type': 'string'},
                  {   'description': 'Set on/off to enable/disable usb',
                      'name': 'usb',
                      'type': 'bool'},
                  {   'description': 'Set on to disable self-describing '=

                                     'migration',
                      'name': 'suppress-vmdesc',
                      'type': 'bool'},
                  {   'description': 'Linux kernel device tree file',
                      'name': 'dtb',
                      'type': 'string'},
                  {   'description': 'Firmware image',
                      'name': 'firmware',
                      'type': 'string'},
                  {   'description': 'Enable/disable memory merge support=
',
                      'name': 'mem-merge',
                      'type': 'bool'},
                  {   'description': 'Linux initial ramdisk file',
                      'name': 'initrd',
                      'type': 'string'},
                  {   'description': 'Set on to enforce configuration sec=
tion '
                                     'migration',
                      'name': 'enforce-config-section',
                      'type': 'bool'},
                  {   'description': 'KVM shadow MMU size',
                      'name': 'kvm-shadow-mem',
                      'type': 'int'},
                  {   'description': 'Allow Decimal Floating Point (DFP)'=
,
                      'name': 'cap-dfp',
                      'type': 'bool'},
                  {   'description': 'Allow Hardware Transactional Memory=
 '
                                     '(HTM)',
                      'name': 'cap-htm',
                      'type': 'bool'},
                  {   'description': 'Allow Vector Scalar Extensions (VSX=
)',
                      'name': 'cap-vsx',
                      'type': 'bool'},
                  {'name': 'type', 'type': 'string'},
                  {   'description': 'Resizing of the Hash Page Table '
                                     '(enabled, disabled, required)',
                      'name': 'resize-hpt',
                      'type': 'string'},
                  {   'description': 'Maximum permitted CPU compatibility=
 '
                                     'mode. Valid values are power6, powe=
r7, '
                                     'power7+, power8, power9.',
                      'name': 'max-cpu-compat',
                      'type': 'string'},
                  {   'description': 'Use dedicated hotplug event mechani=
sm
in '
                                     'place of standard EPOW events when =
'
                                     'possible (required for memory
hot-unplug '
                                     'support)',
                      'name': 'modern-hotplug-events',
                      'type': 'bool'},
                  {   'description': 'Virtual SMT: KVM behaves as if this=

were '
                                     "the host's SMT mode",
                      'name': 'vsmt',
                      'type': 'uint32'},
                  {   'description': 'Specifies the KVM virtualization mo=
de '
                                     '(HV, PR)',
                      'name': 'kvm-type',
                      'type': 'string'},
                  {'name': 'vfio-no-msix-emulation', 'type': 'bool'}]}


--=20
Alexey


--CjHMAaaaCG3cHRebGeju4uOP9aBwDkYOg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlphbTEOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILkq0xAApoWzILr3WemxZ8wcmhmFar0PQCcqAPHMI0Jo
mEa01GvL+EfaF3//GEfJgYFO3ZOT+E18JOa7BQExE2Wa304rjUOhyvX0Rh02gUvK
l1QxwHUzLXwkBODt2vRQcor7ySBV5Cy9ci0+/oxYDBEXSMY/fE+f/GOSGdmMNiTY
IZzi/ChLRdePuFmjDNWe0iX+YZSH/awKlqZdgdfmdKlz8aypGfxLYeNoDuMuFQZu
Sh9iltCo0OQ7fegoytnN/HZKoa+YMGTy97frNuqdI60frP1EteQsOOShlwxShruR
Tefz19jk8zQ95NrMzmAUJ6lEHlGyX/EYKKWq24ueYkuuxxtjGrVTiICnyMscms0L
74PvS8ycOXXnAd60nmNZh/b2wXUi8lmN3KsEpsE4PcZUhVCBiB8lwAhYgZD1lNTu
Tjg+b6P5PCQpI3A2hil71JuPtgQU9qOIww7P4/ulyL8xG8j1o7qjLpyHXpBRxSTK
VILC0SzGznqc1/47TZiEgSkjdSb/L/foxDESkCctHK9/W0y6Q8NnB1JVzWzCzTqO
9jQ0qZtkggb2Tf2GZzt7/PD5ye2F9Nr2JsXt/LcuE4hcogbA/7dRwKA0K2eA9/E/
s0jAHLbUCVDTaXUB82U6JiLeTFrP+XooZpiZavr/JpPdK6RQrQdh3IBieS9Oe6kB
0YwlWuA=
=YgCI
-----END PGP SIGNATURE-----

--CjHMAaaaCG3cHRebGeju4uOP9aBwDkYOg--
