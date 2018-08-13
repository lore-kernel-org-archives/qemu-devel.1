Received: from eggs.gnu.org ([2001:4830:134:3::10]:57115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEtA-0002RJ-1X
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fpEt9-0000AD-4T
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:36:12 -0400
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
	<20180809114417.28718-3-marcandre.lureau@redhat.com>
	<87r2j6u44f.fsf@dusky.pond.sub.org>
	<165ace92-3b41-3d56-19f4-d2aa6edf8d8e@redhat.com>
	<877ekudc72.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <61a476a1-f4ab-bf87-9d71-5783dd109afe@redhat.com>
Date: Mon, 13 Aug 2018 17:35:58 +0200
MIME-Version: 1.0
In-Reply-To: <877ekudc72.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AbNvcKOQEVQzc1r8QbaxUEpIA3GvHXU2g"
Subject: Re: [Qemu-devel] [PATCH 2/4] tests: fix bdrv-drain leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AbNvcKOQEVQzc1r8QbaxUEpIA3GvHXU2g
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61a476a1-f4ab-bf87-9d71-5783dd109afe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] tests: fix bdrv-drain leak
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
 <20180809114417.28718-3-marcandre.lureau@redhat.com>
 <87r2j6u44f.fsf@dusky.pond.sub.org>
 <165ace92-3b41-3d56-19f4-d2aa6edf8d8e@redhat.com>
 <877ekudc72.fsf@dusky.pond.sub.org>
In-Reply-To: <877ekudc72.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-13 08:15, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 2018-08-10 08:28, Markus Armbruster wrote:
>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>>
>>>> Spotted by ASAN:
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> =3D=3D5378=3D=3DERROR: LeakSanitizer: detected memory leaks
>>>>
>>>> Direct leak of 65536 byte(s) in 1 object(s) allocated from:
>>>>     #0 0x7f788f83bc48 in malloc (/lib64/libasan.so.5+0xeec48)
>>>>     #1 0x7f788c9923c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
>>>>     #2 0x5622a1fe37bc in coroutine_trampoline /home/elmarco/src/qq/u=
til/coroutine-ucontext.c:116
>>>>     #3 0x7f788a15d75f in __correctly_grouped_prefixwc (/lib64/libc.s=
o.6+0x4c75f)
>>>>
>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>>> ---
>>>>  tests/test-bdrv-drain.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
>>>> index 17bb8508ae..abc8bbe6f0 100644
>>>> --- a/tests/test-bdrv-drain.c
>>>> +++ b/tests/test-bdrv-drain.c
>>>> @@ -948,6 +948,7 @@ static void coroutine_fn test_co_delete_by_drain=
(void *opaque)
>>>>      }
>>>> =20
>>>>      dbdd->done =3D true;
>>>> +    g_free(buffer);
>>>>  }
>>>> =20
>>>>  /**
>>>
>>> Screwed up in commit 4c8158e359d.
>>>
>>> Max, could the coroutine's stack accomodate the buffer?
>>
>> I don't know.  How big is a coroutine's stack?  The buffer size
>> apparently is 64k.  (Which is my opinion is generally too much to put =
on
>> any stack.)
>=20
> Even in tests?

You have a point, but why do things differently in tests for no reason?

(So I don't leak memory, yeah, sure, but why not write the test in Rust
then from the start? O:-P)

>> But why would you want to put it on the stack anyway?  It's not like i=
t
>> would make the patch any simpler.
>=20
> If you like the patch as is, go merge it as is :)

W-well, I wasn't CC-d!

I take this as a request to take this one patch from the series and
merge it into my tree, so I will do that. O:-)

Max


--AbNvcKOQEVQzc1r8QbaxUEpIA3GvHXU2g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltxpV4ACgkQ9AfbAGHV
z0DEVAf+PqSxLYRGXquefSr0F42H2j2Ci1kopiWV2wrrQIa7w05ZQIHVaFgrIuw5
dGp8yzcLwHIWJguEERyqGLgfh9Vg87Q1cTxwZ9gxwbiaQnXu3pjJj88l1bcZjYKh
D9yIr0JcoCp6EK0z+axcic0rZTYfvTRvbqcJD5uAGId2m6HpARR+2aYcRtLrAyRO
WaCbE5G8Wlgcahagb4f95yakyJbgkGeJlC2Wy3nZZxszzlRdI1b78PSLsDXP+Bmf
ugAHkwQiXGCS7bieJNkvm7TfJObC6XXok7lEn9S+tc4PNBAfH24klZfz1YegJt1w
S9R7fg0/+UrEUV/KcPyGP1nwShwvOQ==
=UE3s
-----END PGP SIGNATURE-----

--AbNvcKOQEVQzc1r8QbaxUEpIA3GvHXU2g--
