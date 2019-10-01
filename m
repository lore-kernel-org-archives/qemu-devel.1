Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81320C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5693820842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5693820842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJGQ-0002iD-GE
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFJEm-0001RX-5m
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFJEk-0001a8-9a
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:34:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFJEh-0001XG-1S; Tue, 01 Oct 2019 10:34:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A304307D983;
 Tue,  1 Oct 2019 14:34:42 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72F4A6012D;
 Tue,  1 Oct 2019 14:34:40 +0000 (UTC)
Subject: Re: bitmap migration bug with -drive while block mirror runs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
 <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
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
Message-ID: <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
Date: Tue, 1 Oct 2019 16:34:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aD101pyIdd4oFQYgHrlCnZ0WlIVPclHUs"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 01 Oct 2019 14:34:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aD101pyIdd4oFQYgHrlCnZ0WlIVPclHUs
Content-Type: multipart/mixed; boundary="H07WYdZk4RYDC42jxTxhpPqIEInv06aiH"

--H07WYdZk4RYDC42jxTxhpPqIEInv06aiH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.10.19 16:27, Vladimir Sementsov-Ogievskiy wrote:
> 01.10.2019 17:13, Max Reitz wrote:
>> On 01.10.19 16:00, Vladimir Sementsov-Ogievskiy wrote:
>>> 01.10.2019 3:09, John Snow wrote:
>>>> Hi folks, I identified a problem with the migration code that Red Ha=
t QE
>>>> found and thought you'd like to see it:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1652424#c20
>>>>
>>>> Very, very briefly: drive-mirror inserts a filter node that changes =
what
>>>> bdrv_get_device_or_node_name() returns, which causes a migration pro=
blem.
>>>>
>>>>
>>>> Ignorant question #1: Can we multi-parent the filter node and
>>>> source-node? It looks like at the moment both consider their only pa=
rent
>>>> to be the block-job and don't have a link back to their parents othe=
rwise.
>>>>
>>>>
>>>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
>>>> ultimately what we want is to be able to find the "addressable" name=
 for
>>>> the node the bitmap is attached to, which would be the name of the f=
irst
>>>> ancestor node that isn't a filter. (OR, the name of the block-backen=
d
>>>> above that node.)
>>>
>>> Not the name of ancestor node, it will break mapping: it must be name=
 of the
>>> node itself or name of parent (may be through several filters) block-=
backend
>>>
>>>>
>>>> A simple way to do this might be a "child_unfiltered" BdrvChild role=

>>>> that simply bypasses the filter that was inserted and serves no real=

>>>> purpose other than to allow the child to have a parent link and find=
 who
>>>> it's """real""" parent is.
>>>>
>>>> Because of flushing, reopen, sync, drain &c &c &c I'm not sure how
>>>> feasible this quick idea might be, though.
>>>>
>>>>
>>>> - Corollary fix #1: call error_setg if the bitmap node name that's a=
bout
>>>> to go over the wire is an autogenerated node: this is never correct!=

>>>>
>>>> (Why not? because the target is incapable of matching the node-name
>>>> because they are randomly generated AND you cannot specify node-name=
s
>>>> with # prefixes as they are especially reserved!
>>>>
>>>> (This raises a related problem: if you explicitly add bitmaps to nod=
es
>>>> with autogenerated names, you will be unable to migrate them.))
>>>>
>>>> --js
>>>>
>>>
>>> What about the following:
>>>
>>> diff --git a/block.c b/block.c
>>> index 5944124845..6739c19be9 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -1009,8 +1009,20 @@ static void bdrv_inherited_options(int *child_=
flags, QDict *child_options,
>>>        *child_flags =3D flags;
>>>    }
>>>
>>> +static const char *bdrv_child_get_name(BdrvChild *child)
>>> +{
>>> +    BlockDriverState *parent =3D child->opaque;
>>> +
>>> +    if (parent->drv && parent->drv->is_filter) {
>>> +        return bdrv_get_parent_name(parent);
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>
>> Why would we skip filters explicitly added by the user?
>>
>=20
> Why not? Otherwise migration of bitmaps will not work: we may have diff=
erent set
> of filters on source and destination, and we still should map nodes wit=
h bitmaps
> automatically.

Why would we have a different set of explicitly added filters on source
and destination and allow them to be automatically changed during
migration?  Shouldn=E2=80=99t users only change them pre or post migratio=
n?

And you can also add bitmaps on filters, of course.

> I like John's idea of explicitly defined node mapping, but now we need =
simpler fix,
> not involving libvirt changes if possible.
>=20
> Hmm, or you mean that by this patch I touch not only migration but all =
users of
> bdrv_get_device_or_node_name? Than I can't predict all the consequences=
=2E..

I=E2=80=99m hinting at the fact that maybe we cannot drop the concept of
implicit filters quite as fast as we wanted.

Max


--H07WYdZk4RYDC42jxTxhpPqIEInv06aiH--

--aD101pyIdd4oFQYgHrlCnZ0WlIVPclHUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2TY/4ACgkQ9AfbAGHV
z0BzoAf9G55ysqsZppwsyyM00UB0qvRHA2Z2QOE4hraBkQx6oa6T+mWjysU91B5N
HosLBwBSDPr53B/vsFD8VJIFCZHF8yTl8IkoR569x0QDwowFO4S5fsjy8M53vuk+
0UN2AbfWvJNE7IQGthgPw+c131pJZWcfW7tPCVVKOKEPf0QQwm3v2tiNgOQqVd6k
/m3mQ5S1FTabYr2aaGsYZnGQBmfqxJh/jOs+v5NjMD5Z1vGfP8NA9IBwlu2Hhfm1
QJcxvCUG5yMPDthlYYcYbQ+DPee8vxI7huO1RWTZxNXz0FTIJ66QNQjvwo2g2LYz
R61sehDj9pw7Gc5CjZUhgcZr2cnXqA==
=JK0d
-----END PGP SIGNATURE-----

--aD101pyIdd4oFQYgHrlCnZ0WlIVPclHUs--

