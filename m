Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324FEC41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 047232074D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdbiridK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047232074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnWV-00012M-6K
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGnVJ-0000cj-Kb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGnVI-0006C5-5K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:38:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGnVI-0006Be-0D
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 13:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585071495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n7tKcnv4fKZoKFhDMH/KJF6TFMT4Z01j7GRjDMNytcA=;
 b=QdbiridK4ntLkN/jdhI90ogZ7figmEMP+Zue+RbPrKIPNngTOrRW1CcYEM4jbKcyr5jyf4
 DWtr7FSLfvvc9KAALgPzByLOBYex9Kgm50RxGhQ0trzs8JxaCCqmd61pC1wuPvFG0zbc1n
 YBrrIOIyA92MCl/AXW8INe7aLWgn1Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-0CGkCv3zMrSb_JNFO-o3tg-1; Tue, 24 Mar 2020 13:38:12 -0400
X-MC-Unique: 0CGkCv3zMrSb_JNFO-o3tg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74841005509;
 Tue, 24 Mar 2020 17:38:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4BE35DA7B;
 Tue, 24 Mar 2020 17:38:06 +0000 (UTC)
Subject: Re: [PATCH v8 07/11] iotests: limit line length to 79 chars
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200317004105.27059-1-jsnow@redhat.com>
 <20200317004105.27059-8-jsnow@redhat.com>
 <dcc1f8fa-2916-4241-b213-5ddf0ed62c34@redhat.com>
 <2f230c22-bd4b-ded5-27a9-1971efea0ec3@redhat.com>
 <bdff3fe8-fb51-51b1-f9b1-a111c2fcd04b@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <eea5b8db-8e49-e5ec-bf84-b6e9533b36a8@redhat.com>
Date: Tue, 24 Mar 2020 18:38:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bdff3fe8-fb51-51b1-f9b1-a111c2fcd04b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="B44RYBAo3ACkHSn3zd5JaMniBFx5Sjhiu"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B44RYBAo3ACkHSn3zd5JaMniBFx5Sjhiu
Content-Type: multipart/mixed; boundary="E7fgtz85K1N0wZ6hePmVeVLefup7lIKhN"

--E7fgtz85K1N0wZ6hePmVeVLefup7lIKhN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.03.20 18:09, John Snow wrote:
>=20
>=20
> On 3/24/20 11:12 AM, Max Reitz wrote:
>> On 24.03.20 16:02, Max Reitz wrote:
>>> On 17.03.20 01:41, John Snow wrote:
>>>> 79 is the PEP8 recommendation. This recommendation works well for
>>>> reading patch diffs in TUI email clients.
>>>
>>> Also for my very GUI-y diff program (kompare).
>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/iotests.py | 64 +++++++++++++++++++++++-----------=
-
>>>>  tests/qemu-iotests/pylintrc   |  6 +++-
>>>>  2 files changed, 47 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>>>> index 3d90fb157d..75fd697d77 100644
>>>> --- a/tests/qemu-iotests/iotests.py
>>>> +++ b/tests/qemu-iotests/iotests.py
>>>
>>> [...]
>>>
>>>> @@ -529,11 +539,13 @@ def pause_drive(self, drive, event=3DNone):
>>>>              self.pause_drive(drive, "write_aio")
>>>>              return
>>>>          self.qmp('human-monitor-command',
>>>> -                 command_line=3D'qemu-io %s "break %s bp_%s"' % (driv=
e, event, drive))
>>>> +                 command_line=3D'qemu-io %s "break %s bp_%s"'
>>>> +                 % (drive, event, drive))
>>>
>>> Can we put this value in a variable instead?  I don=E2=80=99t like the =
%
>>> aligning with the parameter name instead of the string value.  (I also
>>> don=E2=80=99t like how there are no spaces around the assignment =3D, b=
ut around
>>> the %, even though the % binds more strongly.)
>>>
>>>> =20
>=20
> I think I had another patch somewhere that added an HMP helper that
> fixes this issue for this particular instance.
>=20
> I can send that separately as a follow-up. I think otherwise,
> unfortunately, "we" "decided" that this indent style is "best".
>=20
> So I think that this patch is "correct".

Perhaps it=E2=80=99s the best if we assume that we had to do it this way, b=
ut
can=E2=80=99t we just do a

qemu_io_cmd =3D f'qemu-io {drive} "break {event} bp_{drive}"'
self.qmp('human-monitor-command', command_line=3Dqemu_io_cmd)

?

(Or maybe an f-string inline.  I was thinking of a separate variable
because I wasn=E2=80=99t aware that f-strings would be an option until I go=
t to
later hunks of this patch...)

> (All of the other options for indent styles seemed to be worse visually,
> or actively go against PEP8. While PEP8 is not a bible, every conscious
> choice to disregard it generally means you will be fighting a CQA tool
> at some other point in time. I have therefore adopted a "When in Rome"
> policy to reduce friction wherever possible with pylint, flake8, mypy,
> pycharm, and so on.)
>=20
>=20
> ((I would prefer we begin to deprecate uses of % and begin using
> .format() and f-strings wherever possible to help alleviate this kind of
> syntax, too -- but I must insist that's for another series.))

Hm.  But you do change something to f-strings below, why not here?

Max


--E7fgtz85K1N0wZ6hePmVeVLefup7lIKhN--

--B44RYBAo3ACkHSn3zd5JaMniBFx5Sjhiu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl56RXwACgkQ9AfbAGHV
z0DicggAnqPxCS3aec5wtGCwgzvq9YgQBUvIK+eBGc0kUduOYfzMj4NlCrf5U3pt
3s79e4827ctSN+Lf/R0GjvH+JN/UHetOu3Ow/MBm54rkrf+yyqFc+obp5iM2qBmK
h5DFvkie66lZHlnKqoO/GfMfhYqoTusU+nSW+ILTccAfwevB0U9XPT8GLxArHnuA
ey8Ojn5dYPQsGWMfbQmfQ0rOet9OQZiBH0Rct32Ja+rBb+BuBPiQNQgsKWfvXNQ4
MXFdSZVFUDE3RFsXY3+OVKGg8wUA5wOhdl3UONKOxZZ8+F31UlU7yZLuPJVS1v9W
UVnTl4GMb73P5BzHcacxkxvem2NeYg==
=Kgex
-----END PGP SIGNATURE-----

--B44RYBAo3ACkHSn3zd5JaMniBFx5Sjhiu--


