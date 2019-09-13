Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84DC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21452084F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 10:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21452084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8iQu-0005KQ-RM
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 06:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8iL1-0000qD-PI
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8iL0-0007lB-MW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:57:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8iKy-0007hm-9I; Fri, 13 Sep 2019 05:57:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AD82796FF;
 Fri, 13 Sep 2019 09:57:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75E5560E3E;
 Fri, 13 Sep 2019 09:57:51 +0000 (UTC)
To: Sergio Lopez <slp@redhat.com>
References: <20190912161624.40886-1-slp@redhat.com>
 <3ceab9a7-e002-a33e-d996-8c4fba374ece@redhat.com> <87v9twwn8r.fsf@redhat.com>
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
Message-ID: <26ff362d-10a8-bcca-0b05-a4d51e88ad37@redhat.com>
Date: Fri, 13 Sep 2019 11:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87v9twwn8r.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zUz8MhhyCjLiGbAPpO3mZeLPQTkoT7Bxv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 13 Sep 2019 09:57:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockdev: avoid acquiring AioContext lock
 twice at do_drive_backup()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zUz8MhhyCjLiGbAPpO3mZeLPQTkoT7Bxv
Content-Type: multipart/mixed; boundary="nlpSmVkiKTrANtLYCA453MvtJRO3xzynb";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 armbru@redhat.com
Message-ID: <26ff362d-10a8-bcca-0b05-a4d51e88ad37@redhat.com>
Subject: Re: [PATCH] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup()
References: <20190912161624.40886-1-slp@redhat.com>
 <3ceab9a7-e002-a33e-d996-8c4fba374ece@redhat.com> <87v9twwn8r.fsf@redhat.com>
In-Reply-To: <87v9twwn8r.fsf@redhat.com>

--nlpSmVkiKTrANtLYCA453MvtJRO3xzynb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 11:37, Sergio Lopez wrote:
>=20
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 12.09.19 18:16, Sergio Lopez wrote:
>>> do_drive_backup() acquires the AioContext lock of the corresponding
>>> BlockDriverState. This is not a problem when it's called from
>>> qmp_drive_backup(), but drive_backup_prepare() also acquires the lock=

>>> before calling it.
>>>
>>> This change adds a BlockDriverState argument to do_drive_backup(),
>>> which is used to signal that the context lock is already acquired and=

>>> to save a couple of redundant calls.
>>
>> But those redundant calls don=E2=80=99t really hurt (it=E2=80=99s just=
 bdrv_lookup_bs(),
>> as far as I can tell).  Wouldn=E2=80=99t it be simpler to just release=
 the
>> context lock in drive_backup_prepare() before calling do_drive_backup(=
)?
>>  The BDS is drained anyway.
>=20
> Redundant calls rarely hurt, they're just redundant ;-)

If they=E2=80=99re expensive and in a hot path, they hurt.

>> On top of that, do_backup_common() calls bdrv_try_set_aio_context() to=

>> bring the target into the source=E2=80=99s AioContext.  However, this =
function
>> must be called with the old AioContext held, and the new context not h=
eld.
>=20
> Is this documented somewhere? I see nothing in the function declaration=

> nor definition.
>=20
> I'm starting to get the feeling that the block layer is riddled with
> unwritten rules and assumptions that makes every change a lot harder
> than it should be.

It is written, it=E2=80=99s just that it=E2=80=99s written in
bdrv_set_aio_context_ignore()=E2=80=99s definition.

Yes, we should document it directly for bdrv_try_set_aio_context(), too,
because that=E2=80=99s what external callers are much more likely to use.=


>> Currently, it=E2=80=99s called exactly the other way around: With the =
new
>> context held, but the old one not held.
>>
>> So I think it indeed actually makes more sense to release the AioConte=
xt
>> before calling do_drive_backup(), and to move the
>> bdrv_try_set_aio_context() call for target_bs to the callers of
>> do_backup_common() (where they have not yet taken the AioContext lock)=
=2E
>=20
> OK. I see this also happens in external_snapshot_prepare() and
> qmp_drive_mirror() too. I guess we should fix these too.
>=20
> In qmp_drive_mirror(), would it be safe to delay the acquisition of any=

> context until just before the blockdev_mirror_common()?

=46rom mirror=E2=80=99s perspective I think so, but I don=E2=80=99t think=
 it=E2=80=99s safe to
access any of a BDS=E2=80=99s fields without having acquired its AioConte=
xt.
(In fact, I wonder whether we should acquire the context even before
bdrv_op_is_blocked()...)

Max


--nlpSmVkiKTrANtLYCA453MvtJRO3xzynb--

--zUz8MhhyCjLiGbAPpO3mZeLPQTkoT7Bxv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17aB0ACgkQ9AfbAGHV
z0DDmQf/cwFJY9H9/ghtq0Wlls+SX9PhgV7kosz8cvF5jlrvx7We8CGKX+KCR1bQ
w7zLzJvSuspB6UNjG1fpS8DH2WrHIlO5jGsLR/+zEIMjurnD8xi1iQzHrTzRx75k
NdWihcdacerrVXE6eTD6ly7Dlk66VukrtU+29oxTd8jx+amTcOs7huDEpXIcJG6H
BdbrBXMV0IDyXhSokc+sdET+4l2di8hIi+94qV2K/4k/nlo3ZKJHGoOK54zvJimN
0twOrT81I9NK7u/jEQ5opk11m9pJOFcnUq/1LY/4VGjrWXI9CvjJ1bXP8JqPfie0
i9OPFkXO83k/LmTPm2Qpu1rmvuEeGA==
=uHPY
-----END PGP SIGNATURE-----

--zUz8MhhyCjLiGbAPpO3mZeLPQTkoT7Bxv--

