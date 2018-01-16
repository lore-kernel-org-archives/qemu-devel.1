Received: from eggs.gnu.org ([2001:4830:134:3::10]:40493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ebawT-0000LG-Lz
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ebawO-0006I9-MW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:46:57 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:40979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ebawO-0006Gt-B0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 18:46:52 -0500
Received: by mail-pf0-x241.google.com with SMTP id j3so10534982pfh.8
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 15:46:51 -0800 (PST)
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
	<20180116233043.GR30352@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <82382b6b-7105-550e-f19e-8013e6c8a466@ozlabs.ru>
Date: Wed, 17 Jan 2018 10:46:45 +1100
MIME-Version: 1.0
In-Reply-To: <20180116233043.GR30352@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Lrb0mlm98J3wXIgb5J0VgtpFvyqPoAFH"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrea Bolognani <abologna@redhat.com>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Lrb0mlm98J3wXIgb5J0VgtpFvyqPoAFH
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrea Bolognani <abologna@redhat.com>, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-ID: <82382b6b-7105-550e-f19e-8013e6c8a466@ozlabs.ru>
Subject: Re: [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc: Rework
 spapr_caps
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
 <1516110433.10494.5.camel@redhat.com>
 <20180116135459.GN30352@umbus.fritz.box> <1516113980.3278.1.camel@redhat.com>
 <20180116223413.GQ30352@umbus.fritz.box>
 <62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
 <20180116233043.GR30352@umbus.fritz.box>
In-Reply-To: <20180116233043.GR30352@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/01/18 10:30, David Gibson wrote:
> On Wed, Jan 17, 2018 at 10:26:28AM +1100, Alexey Kardashevskiy wrote:
>> On 17/01/18 09:34, David Gibson wrote:
>>> On Tue, Jan 16, 2018 at 03:46:20PM +0100, Andrea Bolognani wrote:
>>>> On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
>>>>>> Correct me if I'm wrong, but it seems to me like there's no way
>>>>>> to figure out through QMP whether these new machine options can be=

>>>>>> used for a given QEMU binary.
>>>>>
>>>>> Uh, I don't think so.  These are machine options like any other (ju=
st
>>>>> constructed a bit differently).  So they'll appear in qemu -machine=

>>>>> pseries,? and I believe that info can also be retrieved with QMP.
>>>>
>>>> Yes, they will indeed show up in the output of -machine pseries,?
>>>> but there's AFAICT no way to retrieve them via QMP.
>>>
>>> Really!?  I thought introspecting object properties was QMP's bread
>>> and butter.
>>
>>
>> On a guest started with '-S':
>> {"execute": "qom-list", "arguments": {"path": "/machine"}}
>>
>> returns:
>> {   'return': [   {'name': 'graphics', 'type': 'bool'},
>>                   {'name': 'phandle-start', 'type': 'int'},
>>                   {'name': 'dump-guest-core', 'type': 'bool'},
>>                   {'name': 'kernel-irqchip', 'type': 'OnOffSplit'},
>>                   {'name': 'accel', 'type': 'string'},
>>                   {'name': 'append', 'type': 'string'},
>>                   {'name': 'dumpdtb', 'type': 'string'},
>>                   {'name': 'igd-passthru', 'type': 'bool'},
>>                   {'name': 'dt-compatible', 'type': 'string'},
>>                   {'name': 'kernel', 'type': 'string'},
>>                   {'name': 'usb', 'type': 'bool'},
>>                   {'name': 'suppress-vmdesc', 'type': 'bool'},
>>                   {'name': 'dtb', 'type': 'string'},
>>                   {'name': 'firmware', 'type': 'string'},
>>                   {'name': 'mem-merge', 'type': 'bool'},
>>                   {'name': 'initrd', 'type': 'string'},
>>                   {'name': 'enforce-config-section', 'type': 'bool'},
>>                   {'name': 'kvm-shadow-mem', 'type': 'int'},
>>                   {'name': 'cap-dfp', 'type': 'bool'},
>>                   {'name': 'cap-htm', 'type': 'bool'},
>>                   {'name': 'cap-vsx', 'type': 'bool'},
>                               ^^^^^^^
> Here are the cap properties.  Is it just Suraj's new tristate ones
> that aren't showing up?  If so that's weird...  are you sure you built
> with those patches included?

I am sure I do not have them, my point was that QMP has it all if they ar=
e
present in qemu :)


Here is rerun:


 {"execute": "qom-list", "arguments": {"path": "/machine"}}

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
                  {'name': 'cap-ibs', 'type': 'string'},
                  {'name': 'cap-cfpc', 'type': 'string'},
                  {'name': 'cap-sbbc', 'type': 'string'},
                  {'name': 'cap-dfp', 'type': 'bool'},
                  {'name': 'cap-htm', 'type': 'bool'},
                  {'name': 'cap-vsx', 'type': 'bool'},
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


and (on unmodified host kernel):

 {"execute": "qom-get", "arguments": {"path": "/machine", "property":
"cap-ibs"}}
{'return': 'broken'}

etc.


--=20
Alexey


--3Lrb0mlm98J3wXIgb5J0VgtpFvyqPoAFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlpejuUOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILmEGg//SDC+y4EU8RAEKQPhQuKLLTzaFuC4bSgaHYEe
IjBQXUQqFrK9jAQenkF/0WAg3ekyw7nFzNUuU7QjPQcRqKPmE9lraq6Dp5em9V/G
yPy1oM9BNaEvEeHWcz6ArJvyPWqwNREXzPuRb3ISOWcOeD/rASxt3vC0gVekaEdM
E6gHuMEIpAFXAo6kXrf6aJDRWV/4NRhDVI0iGLfUqYOXoAmF7P8qqb+OyEDnBpj0
tmiA5A1j91p4UgyOz/33JnkTXsJId6wXZABrFvdb2T2zxpC+yo3PtYcDmPGmxrqn
Sqh/X8n5RA3g/LHhDo0Unt8F73NXCAz3rfg27Jpc0lKrvxQ4sxsBDHpu5JmnBfdB
dhL1/ooZixxBDE4tdht4yW8YoupPdLU2GjDeqvk3KpRigpOwUc+otcxagjSZG02j
GwBDS9VGGa/NDPzMeAH8YULPnDC0QNdh5jqObFxalQecy8/seAPgXPTngJOUVjl6
8waxpohhn/4MPbH0yIOeviEWdoOMqkW0enKakqvmVH35g+Dh6pdBmSFytl/5yBjv
V/D12OSR+Ik1NkQCTvhivsJMO40xLI/KXjOMWKT1dSCzUA1K2UQDXyLAyIXmsOSJ
zC99BoUeMJ0ahM8KuHJmAjuGTdpBQlCNPY0XUO9t1XSCqYXuMM/VMyZj/sWEZ9ld
DWDP0Xs=
=zFcb
-----END PGP SIGNATURE-----

--3Lrb0mlm98J3wXIgb5J0VgtpFvyqPoAFH--
