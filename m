Received: from eggs.gnu.org ([2001:4830:134:3::10]:54033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXUWF-00011x-JT
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXUWC-00005q-4i
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:06:55 -0500
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:32970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXUWB-0008Vl-EX
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:06:51 -0500
Received: by mail-qk0-x235.google.com with SMTP id i17so2087290qke.0
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 08:06:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
	<58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d393de05-84a7-4053-65be-dfdbdbdb4e43@amsat.org>
Date: Fri, 5 Jan 2018 13:06:40 -0300
MIME-Version: 1.0
In-Reply-To: <58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="3lRhvYOOU6J9Ia6ipZRd4QZaINhZQ3gtP"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3lRhvYOOU6J9Ia6ipZRd4QZaINhZQ3gtP
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Eric Blake <eblake@redhat.com>,
 Alistair Francis <alistair.francis@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <d393de05-84a7-4053-65be-dfdbdbdb4e43@amsat.org>
Subject: Re: [PATCH v2 1/4] sdbus: add a QMP command to access a SDBus
References: <20180103214925.16677-1-f4bug@amsat.org>
 <20180103214925.16677-2-f4bug@amsat.org>
 <58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
In-Reply-To: <58860a06-3d3f-ab2a-90ea-dd56dfbe9d79@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 01/05/2018 12:29 PM, Eric Blake wrote:
> On 01/03/2018 03:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Use Base64 to serialize the binary blobs in JSON.
>> So far at most 512 bytes will be transfered, which result
>=20
> s/transfered/transferred/
>=20
>> in a 684 bytes payload.
>> Since this command is intented for qtesting, it is acceptable.
>=20
> s/intented/intended/
>=20
> Might be worth mentioning the actual command name,
> x-debug-sdbus-command, in the commit message to make future git log
> trawling easier.

Ok.

What about using 'x-qtest-sdbus-command'?

>=20
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>=20
>> +##
>> +# @SDBusCommandResponse:
>> +#
>> +# SD Bus command response.
>> +#
>> +# @base64: the command response encoded as a Base64 string, if any (o=
ptional)
>=20
> s/ (optional)//, now that the documentation engine automatically takes
> care of that.
>=20
> Even if there is no response, isn't the empty string "" more accurate
> than omitting the string altogether?  In other words, I'm not sure why
> you made the 'base64' member optional.

Indeed you right.

>=20
>> +#
>> +# Since: 2.11
>=20
> 2.12

Oops :)

>=20
>> +##
>> +{ 'struct': 'SDBusCommandResponse', 'data': {'*base64': 'str'} }
>> +
>> +##
>> +# @x-debug-sdbus-command:
>> +#
>> +# Execute a command on a SD Bus return the response (if any).
>> +#
>=20
> Maybe mention that this command is only intended for use during unit
> testing (that information is already implicit from the x-debug prefix,
> but stating it explicitly doesn't hurt).
>=20
>> +# @qom-path: the SD Bus path
>> +# @command: the SD protocol command to execute in the bus
>> +# @arg: a 64-bit command argument (optional)
>> +# @crc: the command/argument CRC (optional)
>> +#
>> +# Returns: the response of the command encoded as a Base64 string
>> +#
>> +# Since: 2.11
>=20
> 2.12
>=20
>> +#
>> +# -> { "execute": "x-debug-sdbus-command",
>> +#      "arguments": { "qom-path": "/machine/unattached/device[32]/sd.=
0",
>> +#                     "command": 0x01
>=20
> That's invalid JSON (which does not understand hex numbers).  You need
> "command": 1

Yes, you right, I wonder how I ended using hex here (I don't have any in
my .qmp_history ...)

>=20
>> +#      }
>> +#    }
>> +# <- { "return": {'base64': 'A=3D'} }
>> +#
>> +##
>> +{ 'command': 'x-debug-sdbus-command',
>> +  'data': { 'qom-path': 'str',
>> +            'command': 'uint8',
>> +            '*arg': 'uint64',
>> +            '*crc': 'uint16' },
>> +  'returns': 'SDBusCommandResponse'
>> +}
>> diff --git a/hw/sd/sdbus-qmp.c b/hw/sd/sdbus-qmp.c
>> new file mode 100644
>> index 0000000000..8c4b6f2aee
>> --- /dev/null
>> +++ b/hw/sd/sdbus-qmp.c
>> @@ -0,0 +1,65 @@
>> +/*
>> + * SD card bus QMP debugging interface (for QTesting).
>> + *
>> + * Copyright (c) 2017 ?
>=20
> The question mark in a copyright line is not right.  I don't know what
> you meant to use, but unless you were doing the work on behalf of an
> employer, your own name is probably correct.  You could include 2018 no=
w
> if you wanted.

:)

>=20
>=20
>> +SDBusCommandResponse *qmp_x_debug_sdbus_command(const char *qom_path,=

>> +                                                uint8_t command,
>> +                                                bool has_arg, uint64_=
t arg,
>> +                                                bool has_crc, uint16_=
t crc,
>> +                                                Error **errp)
>> +{
>> +    uint8_t response[16 + 1];
>> +    SDBusCommandResponse *res;
>> +    bool ambiguous =3D false;
>> +    Object *obj;
>> +    SDBus *sdbus;
>> +    int sz;
>> +
>> +    obj =3D object_resolve_path(qom_path, &ambiguous);
>> +    if (obj =3D=3D NULL) {
>=20
> I don't know if the style 'if (!obj) {' is any more prevalent; but it
> doesn't really matter.

old habits are hard to change :)

>=20
>> +        if (ambiguous) {
>> +            error_setg(errp, "Path '%s' is ambiguous", qom_path);
>> +        } else {
>> +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
>> +                      "Device '%s' not found", qom_path);
>> +        }
>> +        return NULL;
>> +    }
>> +    sdbus =3D (SDBus *)object_dynamic_cast(obj, TYPE_SD_BUS);
>=20
> Is the cast still necessary, or does object_dynamic_cast() return void*=

> so that you can omit the cast?

Good to know!

>=20
>> +    if (sdbus =3D=3D NULL) {
>> +        error_set(errp, ERROR_CLASS_GENERIC_ERROR,
>> +                  "Device '%s' not a sd-bus", qom_path);
>> +        return NULL;
>> +    }
>> +
>> +    res =3D g_new0(SDBusCommandResponse, 1);
>> +    sz =3D sdbus_do_command(sdbus,
>> +                          &(SDRequest){ command, arg, has_crc ? crc :=
 -1 },
>=20
> It's probably safer to use specific initializer assignments, as in:
>=20
> &(SDRequest){ .cmd =3D command, .arg =3D arg, ...

Ok.

>=20
>=20
>> +++ b/stubs/qmp_sdbus.c
>> @@ -0,0 +1,12 @@
>> +#include "qemu/osdep.h"
>> +#include "qmp-commands.h"
>> +#include "hw/sd/sd.h"
>> +
>> +SDBusCommandResponse *qmp_x_debug_sdbus_command(const char *qom_path,=

>> +                                                uint8_t command,
>> +                                                bool has_arg, uint64_=
t arg,
>> +                                                bool has_crc, uint16_=
t crc,
>> +                                                Error **errp)
>> +{
>> +    return NULL;
>=20
> In addition to returning NULL, the stub should set errp.

Oh, I didn't know.

Thanks for your detailed review!

Phil.


--3lRhvYOOU6J9Ia6ipZRd4QZaINhZQ3gtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpPopAACgkQ4+MsLN6t
wN5QhBAA0rE3KdPBxnypMB10sTPB+y4wdRGPcGAm+peTMddaCTbGh2b4NalY0pgl
qGaqqGLuqJn/NO5v6DfKVQYbBIQ5v6gpNUWIEmFEVGnTFKpiRjijP2OA3BGCChbR
Q+olCbfMBS1ErwWm+ovnTa21XKb7ngSftXI47S2Pq/ND+A2sEkp6ULELzLFi9bkM
hzLtJyZUslRA9KIzxl98lXaLA9cXG896qHW08Io4B9+0wy/7J7H0UTmzd/d/4YxX
ex9WnK3+U61Z2oyIOsk6pa4hcA8/RjI7z2HePk/EOUWNzM8nXcGYob4Wlnz3Bryc
HUinR5Xnc9RVPNQgtC9GtJqWp4u7gcbD/+hcQQqbWuI0GPB9OAIb98ZZ/ln0CGyh
SBly9QFW4CjaPK+cZziS+ke8eAfwYRJoPSf0G+Hw4vCgleiGDX5+hHv8Ho5+TDNn
FzDP2/4wPxocwx3RV5zq3OEQA4+r/GuMYHEF42HEK8GCg8Z2AeV0L0ayyVG6d3Uk
MuK3av+aH92twLBu9Ri9y7+2gSE6M76DdZepPv5t5JzX5CrgWaax/vU4xK3VdGNO
HJZnVJvbjS7ctOg/G2is7eY0LhI4V5LUEQ3Wn9WKrspPxYYs1KbNjRVXdmgV7xL3
uxFvaUiWc3gXsRjCZvuxhB8ZTtXIoW207d5E77FjnilIVty2oOE=
=qdcY
-----END PGP SIGNATURE-----

--3lRhvYOOU6J9Ia6ipZRd4QZaINhZQ3gtP--
