Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B4C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C9E20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3erSF5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C9E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgR2-0000Ak-PY
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgQE-000859-9O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgQB-000805-Sz
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:38:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35123
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgQB-0007v6-NO
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580992694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pDG1ah0M9UbHGNkIJv7bMLuAazd7pqdVuDa12aLNtyo=;
 b=B3erSF5pJfD3DoJfj0VGWDBFuzhPuoftQgUotn5Qf+l4LVRVZdeCFh2YG0qQRqiRkGIDCZ
 Pb+FupXZNhkwe8HdqcWqzNf+hja96HYq4zghWWPVzTWonncQv6q1NZreCCLtctjmuRinfP
 uNUNVE1EvaXQO1ecqCMnEBk5yVPpbT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-d29FFLc4NkST1JGHwE7nkg-1; Thu, 06 Feb 2020 07:38:10 -0500
X-MC-Unique: d29FFLc4NkST1JGHwE7nkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62C3E800D54;
 Thu,  6 Feb 2020 12:38:09 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DABA87B1C;
 Thu,  6 Feb 2020 12:38:06 +0000 (UTC)
Subject: Re: [PATCH v11 2/2] docs: qcow2: introduce compression type feature
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org
References: <20200131142219.3264-1-vsementsov@virtuozzo.com>
 <20200131142219.3264-3-vsementsov@virtuozzo.com>
 <ee6b018a-be33-ed77-c4b9-4894c685d30a@redhat.com>
 <w51mua3zg16.fsf@maestria.local.igalia.com>
 <18578060-2c1f-6c63-31e1-dee51387210a@redhat.com>
 <aa9050a1-b071-6e08-bb91-8b513de09180@virtuozzo.com>
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
Message-ID: <aa11a480-bd79-837b-c79b-722bdb6dc31f@redhat.com>
Date: Thu, 6 Feb 2020 13:38:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aa9050a1-b071-6e08-bb91-8b513de09180@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vN4e0KznxX72d8vxk54VyiBeaY2RkQWVC"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, den@openvz.org, dplotnikov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vN4e0KznxX72d8vxk54VyiBeaY2RkQWVC
Content-Type: multipart/mixed; boundary="1o0cWSd2UPATMBOanHn5ciAojKqssDn6j"

--1o0cWSd2UPATMBOanHn5ciAojKqssDn6j
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.01.20 19:15, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2020 20:49, Eric Blake wrote:
>> On 1/31/20 11:34 AM, Alberto Garcia wrote:
>>> On Fri 31 Jan 2020 03:46:12 PM CET, Eric Blake wrote:
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 If the inc=
ompatible bit "Compression type" is
>>>>> set: the field
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 must be pr=
esent and non-zero (which means
>>>>> non-zlib
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 compressio=
n type). Otherwise, this field must
>>>>> not be present
>>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 or must be=
 zero (which means zlib).
>>>>
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 If the incompatible bit "Compress=
ion type" is set: the
>>>> field
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 must be present. Otherwise, this =
field must not be present
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 or must be zero (which means zlib=
).
>>>
>>> But "not being present" and "being zero" is equivalent (as described in
>>> the previous commit).
>>>
>>> And if the incompatible bit is not present then the field can be safely
>>> ignored (i.e. whether it is zero or not is irrelevant).
>>>
>>> Let's try again:
>>>
>>> =A0=A0=A0 Defines the compression method used for compressed clusters. =
All
>>> =A0=A0=A0 compressed clusters in an image use the same type.
>>>
>>> =A0=A0=A0 The value of this field should only be used when the incompat=
ible
>>> bit
>>> =A0=A0=A0 "Compression type" is set. If that bit is unset then this fie=
ld is
>>> =A0=A0=A0 not used and the compression method is zlib.

This doesn=92t fully make sense to me.  Maybe with s/should/must/, because
as it is it means that for non-zlib compression methods, you *should*
set the compression type bit and add this header extension; but you may
also just add the extension and not set the compression bit.

All in all, I didn=92t see anyone disagreeing on the fact that there are
only two cases that make any sense:
(1) Have the bit unset and the extension not present or zero: zlib.
(2) Have the bit set and an extension present and non-zero: not zlib.

If those are the only sensible choices, I don=92t see any practical
argument for allowing anything else[1].  (However, I do see an argument
for forbidding anything else, namely to ensure that everyone follows
these sensible guidelines.)

>> I like that wording.
>>
>=20
> I'm OK with it too, as well as I'm OK with the stricter variant, when we
> don't allow incompatible images with zlib set. I don't see any serious
> difference.
>=20
> But I need this to land somehow. Max likes stricter variant and he is
> maintainer of qcow2..
>=20
> Max, will you merge it as is, or did you change your mind, or should we
> ask Kevin for his opinion?

I=92m currently preparing a pull request (without this series), but after
that I=92m planning to merge the stricter variant.

As far as I=92ve seen, the argument for making it less strict was still
accompanied by =93Sure, nobody would set this flag for zlib-compressed
images because that doesn=92t make sense=94.  So if nobody would do that, w=
e
might as well just forbid it and thus ensure that everyone indeed does
the sensible thing.

Max


[1] Besides =93The specification would be one restriction shorter=94, which
I don=92t think is a very good argument.  Because without that sentence,
anyone who implements qcow2 has to think about the problem anyway and
figure out that quasi-restriction by themselves.  If they don=92t, it=92d b=
e
a bit bad because they=92d produce incompatible zlib-compressed images for
no reason.  Hence why I don=92t see the restriction as a burden to the
reader but as a helpful guideline (that must be followed).


--1o0cWSd2UPATMBOanHn5ciAojKqssDn6j--

--vN4e0KznxX72d8vxk54VyiBeaY2RkQWVC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl48CK0ACgkQ9AfbAGHV
z0BydQf/YUdOdsgRi3LuTF8tSMOP4j0nCYqBsjv1N2yn3jSoJ/o9nBfNYK5dc/JY
4PRvMuzAyd+HmeGNr0cjp/nGH42B55DkFbTCbn0ty+HAa25/KWx4DvE/VTttRZMV
VYZYwYgLZc+/bvlvd4/2OcwvycTVR3kFOZ+Uj6GLE0bdFGZqRTxeK7pzgmFoLYUy
7PI7a3eJIKK4ipXHrnmRuCDxFwOx3j0Nfn7QxMoVYjKFkSD8CbhhtTSleBoRSZwM
0tz5tn+LT9uK9xxr+1W/NhJ2PthOU+VofQqMjEk+1w6YcTPrh36iHDBnUu+YCk9/
uAxx2gdHHLoRccKMLhTmOEeJExVk9Q==
=ui5t
-----END PGP SIGNATURE-----

--vN4e0KznxX72d8vxk54VyiBeaY2RkQWVC--


