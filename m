Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59715C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E79892184C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79892184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOpj-00041T-F6
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hiOkl-0001Nn-3K
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hiOki-0000GY-5U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 15:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hiOkT-0007jA-NG; Tue, 02 Jul 2019 15:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6E57B7FDEE;
 Tue,  2 Jul 2019 19:46:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-120.brq.redhat.com
 [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A3DA1001B20;
 Tue,  2 Jul 2019 19:46:16 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190624144740.5338-1-mreitz@redhat.com>
 <20190624144740.5338-7-mreitz@redhat.com>
 <CAFEAcA_jnQj5sUjOiPY5_jaLaWEYVTqKre1TiTVJVBXTaC1vaA@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <4b210893-e3ac-aa4f-2103-8a183658f483@redhat.com>
Date: Tue, 2 Jul 2019 21:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jnQj5sUjOiPY5_jaLaWEYVTqKre1TiTVJVBXTaC1vaA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JdFUtDHFpGkVBtpU4OSafXQ3PgfUpLHQF"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 02 Jul 2019 19:46:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 6/8] vmdk: Add read-only support for
 seSparse snapshots
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JdFUtDHFpGkVBtpU4OSafXQ3PgfUpLHQF
Content-Type: multipart/mixed; boundary="XulWpV6mUM7yYiukxojPQ5ZVVMKc8zwAi";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Sam Eiderman <shmuel.eiderman@oracle.com>
Message-ID: <4b210893-e3ac-aa4f-2103-8a183658f483@redhat.com>
Subject: Re: [PULL v2 6/8] vmdk: Add read-only support for seSparse snapshots
References: <20190624144740.5338-1-mreitz@redhat.com>
 <20190624144740.5338-7-mreitz@redhat.com>
 <CAFEAcA_jnQj5sUjOiPY5_jaLaWEYVTqKre1TiTVJVBXTaC1vaA@mail.gmail.com>
In-Reply-To: <CAFEAcA_jnQj5sUjOiPY5_jaLaWEYVTqKre1TiTVJVBXTaC1vaA@mail.gmail.com>

--XulWpV6mUM7yYiukxojPQ5ZVVMKc8zwAi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.07.19 21:13, Peter Maydell wrote:
> On Mon, 24 Jun 2019 at 15:48, Max Reitz <mreitz@redhat.com> wrote:
>>
>> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>>
>> Until ESXi 6.5 VMware used the vmfsSparse format for snapshots (VMDK3 =
in
>> QEMU).
>>
>> This format was lacking in the following:
>>
>>     * Grain directory (L1) and grain table (L2) entries were 32-bit,
>>       allowing access to only 2TB (slightly less) of data.
>>     * The grain size (default) was 512 bytes - leading to data
>>       fragmentation and many grain tables.
>>     * For space reclamation purposes, it was necessary to find all the=

>>       grains which are not pointed to by any grain table - so a revers=
e
>>       mapping of "offset of grain in vmdk" to "grain table" must be
>>       constructed - which takes large amounts of CPU/RAM.
>>
>=20
> Hi; this change has confused Coverity a bit (CID 1402786):
>=20
>> @@ -481,7 +529,7 @@ static int vmdk_init_tables(BlockDriverState *bs, =
VmdkExtent *extent,
>>      int i;
>>
>>      /* read the L1 table */
>> -    l1_size =3D extent->l1_size * sizeof(uint32_t);
>> +    l1_size =3D extent->l1_size * extent->entry_size;
>>      extent->l1_table =3D g_try_malloc(l1_size);
>>      if (l1_size && extent->l1_table =3D=3D NULL) {
>>          return -ENOMEM;
>=20
>>      }
>>
>>      if (extent->l1_backup_table_offset) {
>> +        assert(!extent->sesparse);
>>          extent->l1_backup_table =3D g_try_malloc(l1_size);
>>          if (l1_size && extent->l1_backup_table =3D=3D NULL) {
>>              ret =3D -ENOMEM;
>=20
> Here we allocate extent->l1_backup_table via g_try_malloc(),
> and our "ENOMEM" guard checks l1_size. However later on we do:
>=20
>         for (i =3D 0; i < extent->l1_size; i++) {
>             le32_to_cpus(&extent->l1_backup_table[i]);
>         }
>=20
> which is a dereference of l1_backup_table whose guard
> is looking at extent->l1_size. Previously Coverity could
> (probably) see this was OK because we were setting
>    l1_size =3D extent->l1_size * sizeof(uint32_t)
> so l1_size is 0 if and only if extent->l1_size is zero.
> But now there's another possibility because we have changed
> the initialization to
>    l1_size =3D extent->l1_size * extent->entry_size;
> so if extent->entry_size is zero then l1_size could be 0
> (getting us past the ENOMEM check) but extent->l1_size
> non-zero (causing us to try to dereference a NULL l1_backup_table
> pointer).
>=20
> This can't in fact happen because if extent->l1_size is
> non-zero we'll assert that extent->entry_size is
> either 8 or 4, but the logic has become sufficiently
> convoluted that it's no longer clear to Coverity that this
> is an impossible case. I could mark this as a false positive,
> but maybe there's a way of rephrasing this code that makes
> the logic a little clearer to both humans and robots?

There is also the fact that entry_size is initialized to 4
(sizeof(uint32_t)) and updated to 8 (sizeof(uint64_t)) when the image is
in the seSparse subformat.  So entry_size can only ever be 4 or 8.

The only substantial thing I could imagine that might in some way make
it clearer would be to drop entry_size and always decide based on
extent->sesparse (because extent->entry_size =3D=3D (extent->sesparse ? 8=
 : 4)).

But to me personally, that would not really be clearer.  I think it=E2=80=
=99s
reasonable to store the size of L1 entries in an extent attribute, and
remember that it=E2=80=99s always 4 or 8.

Of course, there is also the less substantial thing, which is adding a
comment =E2=80=9CSize of L1 entries, can only be sizeof(uint32_t) or
sizeof(uint64_t)=E2=80=9D above the entry_size definition.


I think Coverity is actually confused by aliasing.  The report says this:=


> 1. Condition l1_size, taking false branch.

So l1_size must be 0, which means either extent->l1_size or
extent->entry_size must be 0.

It then says:

> 3. Condition i < extent->l1_size, taking true branch.

So extent->l1_size must be greater than 0.  (To be exact, it prints this
two times, so extent->l1_size must be 2.)

This is followed by:

> 4. Condition extent->entry_size =3D=3D 8UL /* sizeof (uint64_t) */, tak=
ing true branch.

Er, so, extent->entry_size is 8?

That actually makes l1_size 16.  So somewhere between conditions 1 and
3/4, *extent must have changed its contents.

So it looks to me like Coverity just thinks that *extent may be used
concurrently.  Short of adding a =E2=80=9Crestrict=E2=80=9D, I don=E2=80=99=
t know what to do
this but to close the report as a false positive.

> Supplementary:
>=20
> (1) this code:
>     for (i =3D 0; i < extent->l1_size; i++) {
>         if (extent->entry_size =3D=3D sizeof(uint64_t)) {
>             le64_to_cpus((uint64_t *)extent->l1_table + i);
>         } else {
>             assert(extent->entry_size =3D=3D sizeof(uint32_t));
>             le32_to_cpus((uint32_t *)extent->l1_table + i);
>         }
>     }
> only asserts that extent->entry_size is sane if the l1_size
> is non-zero, and it does it inside the loop so we assert
> once for each entry. Hiding the assert like this might be
> part of what's confusing Coverity.
>=20
> (2) we allocate the l1_backup_table() with a size of l1_size,
> which will differ depending on extent->entry_size; but then
> we do the endianness conversion on it using
>         for (i =3D 0; i < extent->l1_size; i++) {
>             le32_to_cpus(&extent->l1_backup_table[i]);
>         }
> which assumes always 32-bit entries. Is that correct?

Yes, because 64 bit entries only occur for the seSparse format.  At
least our current (RO) implementation does not use a backup table when
accessing seSparse images.  (Hence the assertion against that at the
beginning of the enclosing if block.)

Max


--XulWpV6mUM7yYiukxojPQ5ZVVMKc8zwAi--

--JdFUtDHFpGkVBtpU4OSafXQ3PgfUpLHQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0btIcACgkQ9AfbAGHV
z0CT+wf7BaFZOpsAJmfJiH/YzLxmY53cSurzAvjBWf7MjAw/erQtjLe3kIx3U7ma
BJIUMaRw7LbQqiywsTn10tY3PK48MyZUjjF/bAPvqBmjNrjoyzIFw/mSl2UsVjSm
B/D9qKwGShJIjhB7IYGqbp/p93h9H3uY6ZEppOLiNQv39vvIQA4OzXnaZgwssijh
2DiauhPg6BuqU3Y9PUUgmQ7ogEXWbAjhhHXDnEhyh5Xz/4iZRuXFRqsWbXAcmPG7
5AidFxQ/bhfxmtu2LUoqixVJfLbcC3vietWWRmv2qgUX/6zfTS62cJRpjtc5XOJK
FRhWuJ+5nqYbozHj1ajZ7PyMSYqo+A==
=5J8S
-----END PGP SIGNATURE-----

--JdFUtDHFpGkVBtpU4OSafXQ3PgfUpLHQF--

