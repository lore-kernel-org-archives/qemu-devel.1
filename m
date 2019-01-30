Received: from eggs.gnu.org ([209.51.188.92]:56418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1goquB-0002wU-Ks
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1goquA-0006iu-LA
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:31:55 -0500
Received: from greensocs.com ([193.104.36.180]:36853)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1goqu9-0006hG-Uc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:31:54 -0500
References: <20190129203219.6473-1-jcmvbkbc@gmail.com>
	<cfc9fee5-9f8b-2fb2-d58e-f8e08f5a0a52@adacore.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <d7469a28-716d-5054-cba6-fc3a3001ea6c@greensocs.com>
Date: Wed, 30 Jan 2019 15:31:37 +0100
MIME-Version: 1.0
In-Reply-To: <cfc9fee5-9f8b-2fb2-d58e-f8e08f5a0a52@adacore.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zIcOtmNN33RtHcQOcXhxHp2feQqtwucZA"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: allow killing QEMU via vKill
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zIcOtmNN33RtHcQOcXhxHp2feQqtwucZA
From: Luc Michel <luc.michel@greensocs.com>
To: KONRAD Frederic <frederic.konrad@adacore.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <d7469a28-716d-5054-cba6-fc3a3001ea6c@greensocs.com>
Subject: Re: [Qemu-devel] [PATCH] gdbstub: allow killing QEMU via vKill
 command
References: <20190129203219.6473-1-jcmvbkbc@gmail.com>
 <cfc9fee5-9f8b-2fb2-d58e-f8e08f5a0a52@adacore.com>
In-Reply-To: <cfc9fee5-9f8b-2fb2-d58e-f8e08f5a0a52@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 1/30/19 2:37 PM, KONRAD Frederic wrote:
> Hi,
>=20
> Le 1/29/19 =C3=A0 9:32 PM, Max Filippov a =C3=A9crit=C2=A0:
>> With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to=

>> kill the inferior. Handle 'vKill' the same way 'k' was handled in the
>> presence of single process.
>>
>> Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
>> (f|s)ThreadInfo and ThreadExtraInfo")
Thanks for the patch.

>>
>> Cc: Luc Michel <luc.michel@greensocs.com>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>> ---
>> =C2=A0 gdbstub.c | 22 ++++++++++++++++++++++
>> =C2=A0 1 file changed, 22 insertions(+)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index bfc7afb50968..1ef31240c055 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1383,6 +1383,28 @@ static int gdb_handle_packet(GDBState *s, const=

>> char *line_buf)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 put_packet(s, buf);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (strncmp(p, "Kil=
l;", 5) =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 un=
signed long pid;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =
+=3D 5;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (qemu_strtoul(p, &p, 16, &pid)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 put_packet(s, "E22");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
ocess =3D gdb_get_process(s, pid);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (process =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 put_packet(s, "E22");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (s->process_num <=3D 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Kill the target */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("QEMU: Terminated via GDBstub");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 exit(0);
>=20
> I suggest:
>=20
> #ifdef CONFIG_USER_ONLY
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(0);
> #else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_system_shutdown_request=
(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
You are missing a `break;' here.

Regarding the cause, I think it's more an 'host' cause than a 'guest' one=
=2E
> #endif
>=20
> instead of exit(0);
I just tested, this is not ideal in the current shape. Not quitting
immediately makes the stub sends a "W00" packet. It's better if we send
nothing because GDB interprets that as the connection was closed (which
is effectively the case). Otherwise in multiprocess mode, GDB thinks the
other processes are still alive (see below).

with exit(0):
(gdb) k
Kill the program being debugged? (y or n) y
Sending packet: $vKill;1#6e...Ack
Remote connection closed

with qemu_system_shutdown_request:
(gdb) k
Kill the program being debugged? (y or n) y
Sending packet: $vKill;1#6e...Ack
Packet received: W00
Packet vKill (kill) is supported
[Inferior 1 (process 1) killed]

So maybe a solution (for another patch) would be to send a 'W' packet
for each attached process (using the multiprocess format). Another is to
prevent 'W' packets to be sent at all... they are not required in this ca=
se.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 TODO: handle multiprocess case */
About the multiprocess case, I would vote to adopt the same behaviour
(i.e. terminate QEMU), whatever the PID is or how many processes are
attached. Otherwise we would have different behaviour for the GDB `kill`
command, whether the simulated board exposes multiple processes or not.
Moreover, I think considering just one PID for a kill command does not
make much sense in our case.

I just tested, GDB is fine with QEMU closing the connection when having
multiple processes attached if we do exit(0) directly (i.e. do not send
a 'W00' packet).

Thanks.

Luc
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to unknown_command;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto unknown_command;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>


--zIcOtmNN33RtHcQOcXhxHp2feQqtwucZA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlxRtUkACgkQd8knW3Qn
Tr717Q/9HAgB5x6IbRN40e0dSzbNPxOtL41S9V7aGy7MEv+xYl2R2iD2xV+AtGLA
zDUg9V1C7LK//ruA7Rw94Wkj0jbXMah4cWsEfMIzzF64UXxNJV7BJ3UPype+1kkK
tUscb9KWljoQbt7QglMwlbRnP4ErIKnLkSHRugL4DhrcuzVxGwo1waRrkX9rnbhL
Pt7RQlPMyCPaicP3xaSydouYhofjpWstCbDHIABqpcdH3h1lWTBrjnBQod2O8jA3
UzFdFh3AGvWwBP/YrxYHllIyp+lt91EbCX333zGs6HN0uiceK+Kj3R9ITsH6nhAK
HEgRKvpgV7Cvv1EyK11qDFjhfcXr8KZKf4Yn4+OPIuqsUb/l+mtLGt+E2ElurG+W
hK0O/g3HYnTDREILLykAZerGjTk6hmWrjW1pyi7S869oUlhamlVwvLJfErw35iE5
ghFLdDdfXY3Eo20kf/q5yWkLmmi7X3R5HHkSoCmDe2VVZOtOsDlJhhxj6o2QtZno
J4/SqyTUJRdbO1KbczClZgzmVMN7iCwOl8XnWthUgbEwUWgAaFJJeOrQ6DO8Hw7L
qq3iADDf53tzhk2zNWg0NlvFo63wvdCDrSNFHBBbpILqOsMfnEneLoMykk+rjlDb
paxLitpe5dO6vf6qMkA8NWiAALLKwmggv+LyQWyIXOuYxqwNhW0=
=lIxO
-----END PGP SIGNATURE-----

--zIcOtmNN33RtHcQOcXhxHp2feQqtwucZA--
