Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E5ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07DC920842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DC920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKEi-0007Nw-NB
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFK2q-0005yQ-AY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFK2o-00012A-RL
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFK2i-0000vY-ER; Tue, 01 Oct 2019 11:26:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50A384FCCE;
 Tue,  1 Oct 2019 15:26:21 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A81B5D9CC;
 Tue,  1 Oct 2019 15:26:15 +0000 (UTC)
Subject: Re: bitmap migration bug with -drive while block mirror runs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
 <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
 <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
 <e809204f-48f3-b4c0-0b6f-1e3d59c34640@virtuozzo.com>
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
Message-ID: <00f03849-18a0-bf34-b83a-98580c58826f@redhat.com>
Date: Tue, 1 Oct 2019 17:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e809204f-48f3-b4c0-0b6f-1e3d59c34640@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="er6Vo0qIYkhAn1gsBfwU6b3hGNULdJu1Y"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 01 Oct 2019 15:26:21 +0000 (UTC)
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
--er6Vo0qIYkhAn1gsBfwU6b3hGNULdJu1Y
Content-Type: multipart/mixed; boundary="rjunoLVqPB4tsYiUOxwupV8RkxTUHUjtx"

--rjunoLVqPB4tsYiUOxwupV8RkxTUHUjtx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.10.19 16:53, Vladimir Sementsov-Ogievskiy wrote:
> 01.10.2019 17:34, Max Reitz wrote:
>> On 01.10.19 16:27, Vladimir Sementsov-Ogievskiy wrote:
>>> 01.10.2019 17:13, Max Reitz wrote:
>>>> On 01.10.19 16:00, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 01.10.2019 3:09, John Snow wrote:
>>>>>> Hi folks, I identified a problem with the migration code that Red =
Hat QE
>>>>>> found and thought you'd like to see it:
>>>>>>
>>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1652424#c20
>>>>>>
>>>>>> Very, very briefly: drive-mirror inserts a filter node that change=
s what
>>>>>> bdrv_get_device_or_node_name() returns, which causes a migration p=
roblem.
>>>>>>
>>>>>>
>>>>>> Ignorant question #1: Can we multi-parent the filter node and
>>>>>> source-node? It looks like at the moment both consider their only =
parent
>>>>>> to be the block-job and don't have a link back to their parents ot=
herwise.
>>>>>>
>>>>>>
>>>>>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
>>>>>> ultimately what we want is to be able to find the "addressable" na=
me for
>>>>>> the node the bitmap is attached to, which would be the name of the=
 first
>>>>>> ancestor node that isn't a filter. (OR, the name of the block-back=
end
>>>>>> above that node.)
>>>>>
>>>>> Not the name of ancestor node, it will break mapping: it must be na=
me of the
>>>>> node itself or name of parent (may be through several filters) bloc=
k-backend
>>>>>
>>>>>>
>>>>>> A simple way to do this might be a "child_unfiltered" BdrvChild ro=
le
>>>>>> that simply bypasses the filter that was inserted and serves no re=
al
>>>>>> purpose other than to allow the child to have a parent link and fi=
nd who
>>>>>> it's """real""" parent is.
>>>>>>
>>>>>> Because of flushing, reopen, sync, drain &c &c &c I'm not sure how=

>>>>>> feasible this quick idea might be, though.
>>>>>>
>>>>>>
>>>>>> - Corollary fix #1: call error_setg if the bitmap node name that's=
 about
>>>>>> to go over the wire is an autogenerated node: this is never correc=
t!
>>>>>>
>>>>>> (Why not? because the target is incapable of matching the node-nam=
e
>>>>>> because they are randomly generated AND you cannot specify node-na=
mes
>>>>>> with # prefixes as they are especially reserved!
>>>>>>
>>>>>> (This raises a related problem: if you explicitly add bitmaps to n=
odes
>>>>>> with autogenerated names, you will be unable to migrate them.))
>>>>>>
>>>>>> --js
>>>>>>
>>>>>
>>>>> What about the following:
>>>>>
>>>>> diff --git a/block.c b/block.c
>>>>> index 5944124845..6739c19be9 100644
>>>>> --- a/block.c
>>>>> +++ b/block.c
>>>>> @@ -1009,8 +1009,20 @@ static void bdrv_inherited_options(int *chil=
d_flags, QDict *child_options,
>>>>>         *child_flags =3D flags;
>>>>>     }
>>>>>
>>>>> +static const char *bdrv_child_get_name(BdrvChild *child)
>>>>> +{
>>>>> +    BlockDriverState *parent =3D child->opaque;
>>>>> +
>>>>> +    if (parent->drv && parent->drv->is_filter) {
>>>>> +        return bdrv_get_parent_name(parent);
>>>>> +    }
>>>>> +
>>>>> +    return NULL;
>>>>> +}
>>>>> +
>>>>
>>>> Why would we skip filters explicitly added by the user?
>>>>
>>>
>>> Why not? Otherwise migration of bitmaps will not work: we may have di=
fferent set
>>> of filters on source and destination, and we still should map nodes w=
ith bitmaps
>>> automatically.
>>
>> Why would we have a different set of explicitly added filters on sourc=
e
>> and destination and allow them to be automatically changed during
>> migration?  Shouldn=E2=80=99t users only change them pre or post migra=
tion?
>=20
> Hm I didn't say to automatically change filters.
>=20
> I meant, that we must understand the mapping of nodes with bitmaps: if =
we have source
> node N with bitmaps, in which target node these bitmaps should be after=
 migration?
> And we have to understand it without user interaction.

Well, I=E2=80=99d think it should be on the one with the same node name, =
but it
appears others don=E2=80=99t want a node-name-based mapping, so maybe I s=
hould
just stop trying to be part of the discussion. :-)

> Still, if you don't like skipping explicit filters, I'm OK with implici=
t only, it will
> fix the bug we are saying about.
>=20
> But why you don't like creating some additional explicit filters on tar=
get (prior to
> migration process) which we didn't have on source?

Because I feel like (without having too much insight into migration, I
admit) that migration is generally a process where you move from one VM
to another, but both should have the same configuration.  If you want to
change the configuration, you do that before or after the migration.
(I=E2=80=99d think.)

Max


--rjunoLVqPB4tsYiUOxwupV8RkxTUHUjtx--

--er6Vo0qIYkhAn1gsBfwU6b3hGNULdJu1Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2TcBUACgkQ9AfbAGHV
z0AZeggAqDy8EtywIphlCBu8PipgJVtUrYrjvzGj6z1FyrGmP6xbq6z6wEqmCjw1
ZDsrfe7rAxV+B8BPlSMbT+75JPncPDv65JGHyeIFK6A0ohWh2hfL6jlkPdIJfl2w
CZ3nYUM/4y6LpY5JpkdW+MQCP2huscC8rA9uJ0lSgO43mfjAtVsztO+dUUpmhAbp
syNYV/JWTsxGt9IqWHhMyFJv2Gbm6710ZU/u4qv+CMJpUj6iGw1LJ9vJQf8cnXXC
WgNFxTIklaBCtrq2lzXla/vTK8hweaa6kd+ryaphO+zRLoAoZuQtuOf1VQK2ehqS
6p5jdormiE3JNKZokIGFtmdvJt39MA==
=9j6l
-----END PGP SIGNATURE-----

--er6Vo0qIYkhAn1gsBfwU6b3hGNULdJu1Y--

