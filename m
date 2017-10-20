Received: from eggs.gnu.org ([2001:4830:134:3::10]:51540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5eBy-0003Ep-J5
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5eBu-0001Jm-LW
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 16:46:52 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-12-eblake@redhat.com>
	<799e98b5-4013-0118-1cd1-3fba39fe6bdc@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4509afab-6d76-405a-d025-7c634491f54d@redhat.com>
Date: Fri, 20 Oct 2017 15:46:30 -0500
MIME-Version: 1.0
In-Reply-To: <799e98b5-4013-0118-1cd1-3fba39fe6bdc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cTaMFnpR3sAqBJSVgxFFMJeH02dtfQJi1"
Subject: Re: [Qemu-devel] [PATCH v5 11/11] nbd: Minimal structured read for
 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cTaMFnpR3sAqBJSVgxFFMJeH02dtfQJi1
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <4509afab-6d76-405a-d025-7c634491f54d@redhat.com>
Subject: Re: [PATCH v5 11/11] nbd: Minimal structured read for client
References: <20171019222637.17890-1-eblake@redhat.com>
 <20171019222637.17890-12-eblake@redhat.com>
 <799e98b5-4013-0118-1cd1-3fba39fe6bdc@virtuozzo.com>
In-Reply-To: <799e98b5-4013-0118-1cd1-3fba39fe6bdc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 02:58 PM, Vladimir Sementsov-Ogievskiy wrote:
> 20.10.2017 01:26, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Minimal implementation: for structured error only error_report error
>> message.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> +static int nbd_parse_offset_hole_payload(NBDStructuredReplyChunk *chu=
nk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 uint8_t *payload,
>> QEMUIOVector *qiov,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 uint64_t offset;
>> +=C2=A0=C2=A0=C2=A0 uint32_t hole_size;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (chunk->length !=3D sizeof(offset) + sizeof(hol=
e_size)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Protocol=
 error: invalid payload for "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "NBD_REPLY_TYPE_OFFSET_HOLE");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 offset =3D payload_advance64(&payload);
>> +=C2=A0=C2=A0=C2=A0 hole_size =3D payload_advance32(&payload);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (offset > qiov->size - hole_size) {
>=20
> hmm, you've changed order to prevent overflow.. can it overflow anyway
> through negative minimum on 32-bit system with some unhappy size and
> hole_size?

Good catch; qiov->size is size_t, hole_size is uint32_t.  qiov->size
happens to be bounded by NBD_MAX_BUFFER_SIZE (we wouldn't have sent the
request otherwise, to be getting the reply now), but hole_size came over
the wire and must be considered untrusted.  So you are correct that we
don't know that we avoided overflow unless we also compare the two
values, as in:

if (hole_size > qiov->size || offset > qiov->size - hole_size)

in both affected functions.


>> +=C2=A0=C2=A0=C2=A0 *request_ret =3D -error;
>> +=C2=A0=C2=A0=C2=A0 message_size =3D payload_advance16(&payload);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (message_size > chunk->length - sizeof(error) -=

>> sizeof(message_size)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Protocol=
 error: server sent structured
>> error chunk"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "with incorrect message size");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>=20
> you removed my error message from errp, but didn't change comment..
>=20
> And you lose the message.. At least add a "TODO" for it...
>=20
>> +=C2=A0=C2=A0=C2=A0 /* TODO: Add a trace point to mention the server c=
omplaint */

=2E..

>> +
>> +#define NBD_MAX_MALLOC_PAYLOAD 1000
>> +/* nbd_co_receive_structured_payload
>> + * The resulting pointer stored in @payload requires g_free() to free=

>> it.
>=20
> I think now it is an extra comment..
> (and all it's duplication)

True. g_new() is normal enough that the comment doesn't add as much (the
comment was important when we were using the unusual qemu_memalign(),
but we don't need that).


>> +
>> +=C2=A0=C2=A0=C2=A0 if (nbd_reply_type_is_error(chunk->type)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_parse_error_pa=
yload(chunk, local_payload,
>> request_ret, errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(local_payload);
>=20
> and error message is lost.. So you don't like an idea of saving it in e=
rrp?

=2E..because storing in errp, but returning 0, is wrong.  We do NOT need
to be spamming stderr with every time the server replied with an error,
because that is NORMAL behavior that can (sometimes) be gracefully
recovered from - the most obvious situation is ENOSPC errors resulting
from write(), where we add the proposed NBD resize extension to allow
the client to resize the server and then try again.  Tracing server
messages might be useful, but reporting them indiscriminately is not.  I
dropped the setting of errp in these two places because of the
regression I mentioned in this mail:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg04796.html

where setting errp but returning 0 led to duplicate or
poorly-constructed messages.

In my testing, it worked best to set errp ONLY in the situations where
we are giving up all future communication with the server, and not
merely because the server reported an error but we are still fine to
keep talking to the server.


>> -=C2=A0=C2=A0=C2=A0 return nbd_co_receive_reply(client, request->handl=
e,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->type =3D=3D NBD_CMD_R=
EAD ? qiov
>> : NULL);
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_receive_return_code(client, request=
->handle,
>> &local_err);
>> +=C2=A0=C2=A0=C2=A0 if (local_err) {
>=20
> hmm, you changed it from "if (ret < 0)"... It doesn't matter, just note=

> that here (local_err !=3D NULL) <=3D> (ret < 0).

This was the trick to the errp stuff above: we HAVE to return a negative
errno code to the caller whether the connection was fatally wounded or
whether it is just reporting a server error code; so at this point, ret
< 0 is NOT equivalent to local_err !=3D NULL.  I got a coredump if I used=

'if (ret < 0)' on situations where the server replied with an error, but
where it was not fatal so we did not set local_err, because you can't
error_report_err(NULL).

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err=
);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>=20
> [...]
>=20
>=20
> I'm ok with this, we can improve error handling later.

Indeed - I'd like to get as much in as possible for soft freeze, then
focus on polishing things before hard freeze.  I don't know if we'll get
block status in, or just structured read; and I'd really like to be able
to read holes, but one thing at a time...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cTaMFnpR3sAqBJSVgxFFMJeH02dtfQJi1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqYKcACgkQp6FrSiUn
Q2rXOQgAlquFtzeh7r8waXbDgfVn/grTcgCLsrPcwnEDy5tna4yPH2osvNoo0iLX
QXxcbsVV1rqjp6yLoMrQVOX1OBjt0k3gPd3hFMeQz7vEIICVx5V3YGef97coslwI
AxQ9uX4q7W61JebiX6UG244xM1HIcM6zlNeYW/D1aer8OihZfpEkBSoF3PIeEBhc
KJOGnKYlUa0d/elEEm4dMfIWGfEI7GTxGeUVlhg0faabxwml5KIWibdanVtdmQMt
3kEtdpseChXXk5M1HRG6sd3rqDBZxXgFfTA3cE5qvZwFLVGp2xVe6FetUf+iRlXo
L+DSJKXT/3GT2StRe5x5afepZoXMdQ==
=3WN8
-----END PGP SIGNATURE-----

--cTaMFnpR3sAqBJSVgxFFMJeH02dtfQJi1--
