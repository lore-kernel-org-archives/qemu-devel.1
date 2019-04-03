Received: from eggs.gnu.org ([209.51.188.92]:37488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hBjBe-00072g-7Y
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hBjBc-0006Aj-EJ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 12:56:30 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20190329110454.82409-1-vsementsov@virtuozzo.com>
	<5d4b5522-c31b-f69c-93c2-506fef535745@redhat.com>
	<20190329172411.GM5081@localhost.localdomain>
	<85784659-e4ed-4a21-8606-c12de3db064a@redhat.com>
	<20190329174059.GO5081@localhost.localdomain>
	<2f820393-b9e1-cd23-a220-bae14b98ab4a@redhat.com>
	<993ee436-f998-bba4-cd50-03142174b7cd@virtuozzo.com>
	<4f035f02-ded6-7796-836e-937ce45079f0@virtuozzo.com>
	<20190329193224.GP5081@localhost.localdomain>
	<8e2bf8a6-6755-fb4b-4ad6-90ef037dd589@virtuozzo.com>
	<45b9861a-8ad4-43d6-3b1a-55495adfc866@redhat.com>
Message-ID: <87cf561c-9634-c9ce-a9fe-07e635c3c3ec@redhat.com>
Date: Wed, 3 Apr 2019 18:56:09 +0200
MIME-Version: 1.0
In-Reply-To: <45b9861a-8ad4-43d6-3b1a-55495adfc866@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2yNBUclUuVkyZwWpgBLMxHBEids7hali3"
Subject: Re: [Qemu-devel] [PATCH v3] block/file-posix: do not fail on unlock
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Denis Lunev <den@virtuozzo.com>, "fam@euphon.net" <fam@euphon.net>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2yNBUclUuVkyZwWpgBLMxHBEids7hali3
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>, "fam@euphon.net" <fam@euphon.net>,
 "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <87cf561c-9634-c9ce-a9fe-07e635c3c3ec@redhat.com>
Subject: Re: [PATCH v3] block/file-posix: do not fail on unlock bytes
References: <20190329110454.82409-1-vsementsov@virtuozzo.com>
 <5d4b5522-c31b-f69c-93c2-506fef535745@redhat.com>
 <20190329172411.GM5081@localhost.localdomain>
 <85784659-e4ed-4a21-8606-c12de3db064a@redhat.com>
 <20190329174059.GO5081@localhost.localdomain>
 <2f820393-b9e1-cd23-a220-bae14b98ab4a@redhat.com>
 <993ee436-f998-bba4-cd50-03142174b7cd@virtuozzo.com>
 <4f035f02-ded6-7796-836e-937ce45079f0@virtuozzo.com>
 <20190329193224.GP5081@localhost.localdomain>
 <8e2bf8a6-6755-fb4b-4ad6-90ef037dd589@virtuozzo.com>
 <45b9861a-8ad4-43d6-3b1a-55495adfc866@redhat.com>
In-Reply-To: <45b9861a-8ad4-43d6-3b1a-55495adfc866@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.19 18:41, Max Reitz wrote:
> On 01.04.19 09:21, Vladimir Sementsov-Ogievskiy wrote:
>> 29.03.2019 22:32, Kevin Wolf wrote:
>>> Am 29.03.2019 um 19:00 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 29.03.2019 20:58, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 29.03.2019 20:44, Max Reitz wrote:
>>>>>> On 29.03.19 18:40, Kevin Wolf wrote:
>>>>>>> Am 29.03.2019 um 18:30 hat Max Reitz geschrieben:
>>>>>>>> On 29.03.19 18:24, Kevin Wolf wrote:
>>>>>>>>> Am 29.03.2019 um 18:15 hat Max Reitz geschrieben:
>>>>>>>>>> On 29.03.19 12:04, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>>>>> bdrv_replace_child() calls bdrv_check_perm() with error_abort=
 on
>>>>>>>>>>> loosening permissions. However file-locking operations may fa=
il even
>>>>>>>>>>> in this case, for example on NFS. And this leads to Qemu cras=
h.
>>>>>>>>>>>
>>>>>>>>>>> Let's avoid such errors. Note, that we ignore such things any=
way on
>>>>>>>>>>> permission update commit and abort.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtu=
ozzo.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  =C2=A0 block/file-posix.c | 12 ++++++++++++
>>>>>>>>>>>  =C2=A0 1 file changed, 12 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/block/file-posix.c b/block/file-posix.c
>>>>>>>>>>> index db4cccbe51..1cf4ee49eb 100644
>>>>>>>>>>> --- a/block/file-posix.c
>>>>>>>>>>> +++ b/block/file-posix.c
>>>>>>>>>>> @@ -815,6 +815,18 @@ static int raw_handle_perm_lock(BlockDri=
verState *bs,
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (op) {
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case RAW_PL_PREPARE:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((s->perm | ne=
w_perm) =3D=3D s->perm &&
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (s->shared_perm & new_shared) =3D=3D s->shared_perm)
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /*
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * We are going to unlock bytes, it should not fail. If it fa=
il due
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * to some fs-dependent permission-unrelated reasons (which o=
ccurs
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * sometimes on NFS and leads to abort in bdrv_replace_child)=
 we
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * can't prevent such errors by any check here. And we ignore=
 them
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 * anyway in ABORT and COMMIT.
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 */
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return 0;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D=
 raw_apply_lock_bytes(s, s->fd, s->perm | new_perm,
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ~s->shared_perm | ~new_shared,
>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 false, errp);
>>>>>>>>>>
>>>>>>>>>> Help me understand the exact issue, please.=C2=A0 I understand=
 that there are
>>>>>>>>>> operations like bdrv_replace_child() that pass &error_abort to=

>>>>>>>>>> bdrv_check_perm() because they just loosen the permissions, so=
 it should
>>>>>>>>>> not fail.
>>>>>>>>>>
>>>>>>>>>> However, if the whole effect really would be to loosen permiss=
ions,
>>>>>>>>>> raw_apply_lock_bytes() wouldn't have failed here in PREPARE an=
yway:
>>>>>>>>>> @unlock is passed as false, so no bytes will be unlocked.=C2=A0=
 And if
>>>>>>>>>> permissions are just loosened (as your condition checks), it s=
hould not
>>>>>>>>>> lock any bytes.
>>>>>>>>>>
>>>>>>>>>> So why does it attempt lock any bytes in the first place?=C2=A0=
 There must be
>>>>>>>>>> some discrepancy between s->perm and s->locked_perm, or ~s->sh=
ared_perm
>>>>>>>>>> and s->locked_shared_perm.=C2=A0 How does that occur?
>>>>>>>>>
>>>>>>>>> I suppose raw_check_lock_bytes() is what is failing, not
>>>>>>>>> raw_apply_lock_bytes().
>>>>>>>>
>>>>>>>> Hm, maybe in Vladimir's case, but not in e.g.
>>>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1652572 .
>>>>>>>
>>>>>>> This is reported against 3.0, which didn't avoid re-locking permi=
ssions
>>>>>>> that we already hold, so there raw_apply_lock_bytes() can still f=
ail.
>>>>>>
>>>>>> That makes sense.=C2=A0 Which leaves the question why Vladimir sti=
ll seems to
>>>>>> see the error there...?
>>>>>>
>>>>>
>>>>> I'm sorry :(. I'm trying to fix bug based on 2.10, and now I see th=
at is already fixed
>>>>>   =C2=A0upstream. I don't have a reproducer, only old coredumps.
>>>>>
>>>>> So, now it looks like we don't need this patch, as on permission lo=
osening file-posix
>>>>> don't call any FS apis, yes?
>>>>>
>>>>
>>>>
>>>> Ah, you mentioned, that raw_check_lock_bytes is still buggy.
>>>
>>> I haven't tried it out, but from looking at the code it seems so. May=
be
>>> you can reproduce on master just to be sure?
>>>
>>
>> I don't have a reproducer :(
>=20
> I have one, but it only breaks before
> 2996ffad3acabe890fbb4f84a069cdc325a68108:
>=20
> First, setup on an NFS mount on /mnt/nfs.  Second:
>=20
> $ qemu-img create -f qcow2 /mnt/nfs/foo.qcow2 64M
> Formatting '/mnt/nfs/foo.qcow2', fmt=3Dqcow2 size=3D67108864
> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> $ (sleep 5; echo "{'execute':'qmp_capabilities'}"; \
>    echo "{'execute':'blockdev-del','arguments':{'node-name':'fmt'}}";
>    echo "{'execute':'quit'}") \
>   | x86_64-softmmu/qemu-system-x86_64 -qmp stdio \
>     -blockdev node-name=3Dproto,driver=3Dfile,filename=3D/mnt/nfs/foo.q=
cow2 \
>     -blockdev node-name=3Dfmt,driver=3Dqcow2,file=3Dproto
> {"QMP": {"version": {"qemu": {"micro": 90, "minor": 0, "major": 3},
> "package": "v3.1.0-rc0-71-ga883d6a0bc"}, "capabilities": []}}
>=20
> Before the sleep is done, stop the service on the NFS host:
>=20
> $ systemctl stop nfs-service
>=20
> Once the sleep has run out (you get a {"return": {}} over QMP), start
> the service again:
>=20
> $ systemctl start nfs-service
>=20
> And then this happens:
>=20
> Unexpected error in raw_apply_lock_bytes() at block/file-posix.c:705:
> Failed to lock byte 100
> [1]    30486 done                 ( sleep 5; echo
> "{'execute':'qmp_capabilities'}"; echo ; echo ; ) |
>        30487 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qm=
p
> stdio -blockdev  -blockdev
>=20
> It works fine after 2996ffad3acabe890fbb4f84a069cdc325a68108.

Now I have a reproducer that breaks before this patch here and works
afterwards: You just need two parents and delete one of them, so some
permissions stay taken.

So, we can do this:

$ (echo "{'execute':'qmp_capabilities'}"; \
   echo "{'execute':'nbd-server-start',
          'arguments':{'addr':{'type':'inet',
              'data':{'host':'0.0.0.0','port':'10809'}}}}"; \
   echo "{'execute':'nbd-server-add',
          'arguments':{'device':'proto'}}"; \
   sleep 5; \
   echo "{'execute':'nbd-server-stop'}"; \
   echo "{'execute':'quit'}") \
  | x86_64-softmmu/qemu-system-x86_64 -qmp stdio \
     -blockdev node-name=3Dproto,driver=3Dfile,filename=3D/mnt/nfs/foo.im=
g \
     -device virtio-blk,drive=3Dproto
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 1, "major": 3},
"package": "v4.0.0-rc1-74-g38e694fcc9"}, "capabilities": ["oob"]}}
{"return": {}}
{"return": {}}
{"return": {}}

Then immediately this on the NFS host:

$ sudo systemctl stop nfs-server; sleep 6; \
  sudo systemctl start nfs-server

And this happens on the client:

Unexpected error in raw_check_lock_bytes() at block/file-posix.c:775:
Failed to get "consistent read" lock
[1]    21289 done                 ( echo
"{'execute':'qmp_capabilities'}"; echo ; echo ; sleep 5; echo ; echo ;  |=

       21290 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
stdio -blockdev  -device

No issues after 696aaaed579ac5bf5fa336216909b46d3d8f07a8 (this patch here=
).

Max


--2yNBUclUuVkyZwWpgBLMxHBEids7hali3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyk5akACgkQ9AfbAGHV
z0DAngf/Tarf5Bl8vKs/OdJN5f0kQymZbX0qC2Z8qI2z4A5V5lhrcy3tYhhTIdiR
B/VxLE73u3ihdD8b3Ww5c9ukuPgbcGNmItnazr3M7q6uB+EY2VXAEfpUpLxONpjn
x6i6nA2V5YQxFS0uAVG7ML9Kt92KHmRPmsnLz4yjDoCtbAMyqfPH7dtOjm9GnkYa
MJVyN/bzFPJ1oBQmzCucOLp5nz4MTCH3HI+++M+nmjxbBNGFPsXqkJbIEVQSSX4M
785cdPtGSe6Io1qZkUYL0KeGBLNfSo2gjO0Y7F/Bvtq8Q6LhrvXn8jf3qwWtdIy7
2u1ooc0eIlnAqZ+yrq94uc+IPhaUyA==
=FF7O
-----END PGP SIGNATURE-----

--2yNBUclUuVkyZwWpgBLMxHBEids7hali3--
