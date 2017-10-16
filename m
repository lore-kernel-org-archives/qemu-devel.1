Received: from eggs.gnu.org ([2001:4830:134:3::10]:43212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44TK-0007mN-N0
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e44TJ-0008Ps-9A
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:26:18 -0400
References: <20171015010131.12172-1-eblake@redhat.com>
	<20171015010131.12172-6-eblake@redhat.com>
	<b40d728c-3abc-7061-65b1-93033d6d6960@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef71c7e7-c45d-946d-e47e-3605d50558c7@redhat.com>
Date: Mon, 16 Oct 2017 07:26:08 -0500
MIME-Version: 1.0
In-Reply-To: <b40d728c-3abc-7061-65b1-93033d6d6960@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xbn5hE8PjHEbA7re0wFXOeG7l5epHAgF1"
Subject: Re: [Qemu-devel] [PATCH v4 5/8] nbd/server: Include human-readable
 message in structured errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xbn5hE8PjHEbA7re0wFXOeG7l5epHAgF1
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef71c7e7-c45d-946d-e47e-3605d50558c7@redhat.com>
Subject: Re: [PATCH v4 5/8] nbd/server: Include human-readable message in
 structured errors
References: <20171015010131.12172-1-eblake@redhat.com>
 <20171015010131.12172-6-eblake@redhat.com>
 <b40d728c-3abc-7061-65b1-93033d6d6960@virtuozzo.com>
In-Reply-To: <b40d728c-3abc-7061-65b1-93033d6d6960@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/16/2017 05:59 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.10.2017 04:01, Eric Blake wrote:
>> The NBD spec permits including a human-readable error string if
>> structured replies are in force, so we might as well send the
>> client the message that we logged on any error.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++++-----=
-
>> =C2=A0 nbd/trace-events |=C2=A0 2 +-
>> =C2=A0 2 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 23dc6be708..8085d79076 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -1289,23 +1289,25 @@ static int coroutine_fn
>> nbd_co_send_structured_read(NBDClient *client,
>> =C2=A0 static int coroutine_fn nbd_co_send_structured_error(NBDClient =
*client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t error,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 char *msg,
>=20
> it's not const because we want to put it into iov..
> may be it is better to make it const and convert to (char *) like in
> qio_channel_write_all, to
> 1: more native message parameter type
> 2: allow constat strings like nbd_co_send_structured_error(..., "some
> error")

Yes, casting away const would be a more convenient interface (it's a
bummer that iov can't be const-correct for write, because it is also
used by read which cannot be const).

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDStructuredError chunk;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nbd_err =3D system_errno_to_nbd_err=
no(error);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iovec iov[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D =
&chunk, .iov_len =3D sizeof(chunk)},
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* FIXME: Support human-re=
adable error message */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D msg, .iov_l=
en =3D strlen(msg)},
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
> msg is always non-zero? so we don't want to send errors without
> message.. (1)

I played with the idea of allowing NULL, and don't know whether it was
easier to require non-NULL message (which may require NULL check at all
callers) or to allow NULL (requiring more code here).

>=20
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(nbd_err);
>> -=C2=A0=C2=A0=C2=A0 trace_nbd_co_send_structured_error(handle, nbd_err=
);
>> +=C2=A0=C2=A0=C2=A0 trace_nbd_co_send_structured_error(handle, nbd_err=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 nbd_err_lookup(nbd_err), msg);
>=20
> it doesn't really matter, but "nbd_err_lookup(nbd_err)" is a bit
> unrelated and looks like part of previous patch

The previous patch was yours; I tried to minimize the changes I made to
your patches, so I stuck this one in mine instead. But if you think we
should trace accurately from the get-go, I'm just fine rebasing the
series to make your patch trace the error name at its introduction,
rather than in my followup that supports error messages.

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_be_chunk(&chunk.h, NBD_REPLY_FLAG_D=
ONE,
>> NBD_REPLY_TYPE_ERROR, handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(chunk) - sizeof(chunk.h));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(&chunk.error, nbd_err);
>> -=C2=A0=C2=A0=C2=A0 stw_be_p(&chunk.message_length, 0);
>> +=C2=A0=C2=A0=C2=A0 stw_be_p(&chunk.message_length, iov[1].iov_len);
>>
>> -=C2=A0=C2=A0=C2=A0 return nbd_co_send_iov(client, iov, 1, errp);
>> +=C2=A0=C2=A0=C2=A0 return nbd_co_send_iov(client, iov, 1 + !!iov[1].i=
ov_len, errp);
>=20
> but you allow messages of zero length..
> it's ok, but looks a bit strange in connection with (1)

Passing "" is the easiest thing to do for callers that can't pass NULL.
My first attempt had:

=2Eiov_len =3D msg ? strlen(msg) : 0

and

trace_...(msg ? msg : "")

For this patch, there is only a single caller, so it's really hard to
judge which style (required non-NULL parameter, vs. doing more work in
the common function) will be more useful until we add further callers.


>> -=C2=A0=C2=A0=C2=A0 if (client->structured_reply && request.type =3D=3D=
 NBD_CMD_READ) {
>> +=C2=A0=C2=A0=C2=A0 if (client->structured_reply &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ret < 0 || request.type =3D=
=3D NBD_CMD_READ)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!msg) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 msg =3D g_strdup("");
>=20
> I'd prefer to handle msg=3DNULL in nbd_co_send_structured_error instead=
 of
> this.

Okay, then it sounds like accepting a NULL parameter is the way to go!

It's also worth considering that casting away const would mean I don't
have to g_strdup("").


> anyway it should work, so, with or without my suggestions:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks for your reviews!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Xbn5hE8PjHEbA7re0wFXOeG7l5epHAgF1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnkpWAACgkQp6FrSiUn
Q2qjIAf+JxI7VETleP/5tVe8Q92WWPeUAXUXTjISYgFVRGyUikc+X/jekfqr6sr6
0MV+nYhMX1YZiZ5N4GrtmQRx3XbuEu3DJuVIWWdcXUihnMxKuGqOgSiPuJYJkVHx
Jcw+0cFuPHeMe5N+VCCU5gt3ZHYGRM5ZKfjjAAPFOHV4gU5A3x0cRWt+n9AqgUAw
5dKuadutt9owXhWrHvqRv79fd5D6CBojG1Vj9sNGJrnB1ppzOTZ44XD9zfcZXIKs
g3kuFlBGh7G99frSjFamt0Y+Jjy/tHhM1xAlyqAbdTadFSiL9gH2VYfSdngrIe+x
j6Mok0pBVNMeZOxSmL8bFWFPb8+DUw==
=uA+L
-----END PGP SIGNATURE-----

--Xbn5hE8PjHEbA7re0wFXOeG7l5epHAgF1--
