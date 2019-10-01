Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0796FC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E972086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E972086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKHd-0002rg-EY
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFK4H-0007lP-Cg
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFK4F-0002Dn-Tc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFK4C-00028I-KV; Tue, 01 Oct 2019 11:27:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D841B20FD;
 Tue,  1 Oct 2019 15:27:55 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EDA610018F8;
 Tue,  1 Oct 2019 15:27:50 +0000 (UTC)
Subject: Re: bitmap migration bug with -drive while block mirror runs
To: Kevin Wolf <kwolf@redhat.com>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <6dd4e735-47e7-45d1-98e9-2131746d470c@redhat.com>
 <dfc26b72-4795-09f8-9c50-07d4eabd971a@virtuozzo.com>
 <ef32215d-35e2-14dd-1b43-26f09a88f2dc@redhat.com>
 <20191001150950.GD4688@linux.fritz.box>
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
Message-ID: <d32d21c0-6f18-39ba-6da3-060c865f701a@redhat.com>
Date: Tue, 1 Oct 2019 17:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191001150950.GD4688@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fygEGrfqhcMSBUgnZ0RqiSPrtwBu8Wapw"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 01 Oct 2019 15:27:55 +0000 (UTC)
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fygEGrfqhcMSBUgnZ0RqiSPrtwBu8Wapw
Content-Type: multipart/mixed; boundary="OTsTJbpeQLL3jlEBjkN8tg1B9GU2QmKpu"

--OTsTJbpeQLL3jlEBjkN8tg1B9GU2QmKpu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.10.19 17:09, Kevin Wolf wrote:
> Am 01.10.2019 um 16:34 hat Max Reitz geschrieben:
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
>>>>>        *child_flags =3D flags;
>>>>>    }
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
> We never made a requirement that the backend must be the same on the
> source and the destination. Basically, migration copies the state of
> frontends and the user is responsible for having these frontends create=
d
> and connected to the right backends on the destination.
>=20
> Using different paths on the destination is a very obvious requirement
> for block devices. It's less obvious for the graph structure, but I
> don't see a reason why it couldn't change on migration. Say we were
> using local storage on the source, but now we did storage migration to
> some network storage, access to which should be throttled.

I don=E2=80=99t quite see why we couldn=E2=80=99t add such filters before=
 or after
migration.  And it was my impression that bitmap migration was a problem
now precisely because it is bound to the graph structure.

But anyway.  I=E2=80=99ll gladly remove myself from this discussion becau=
se I
don=E2=80=99t know much about migration and actually I=E2=80=99d prefer t=
o keep it that
way.  (Sorry.)

Max


--OTsTJbpeQLL3jlEBjkN8tg1B9GU2QmKpu--

--fygEGrfqhcMSBUgnZ0RqiSPrtwBu8Wapw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2TcHQACgkQ9AfbAGHV
z0CfnQf+Oi2wVuORUIWvhjfjtPImuszexblxgLDndhVGXCUIREA5hKbg688s0px4
e52EgDlGtBQN01QRmKuu18azVpQ2DQlNbgXK397iePPRH3YJRwOnyjmaEmIsOy/A
bm8xzXgGMXaSDiuixfEaQyBHiXsBXH+WKo2p9Qi/2gIMeslLOvijLXMTO4n1BRpP
XKJT6oil095tyIXyA5nClfxJrJ6Ztxvn+tswrv2sXQ9T4Kn3jIggOApEFLNyMOVk
bnsftQmpiGU/86B93kqS63j7P28CHFdyXu1PtYeyK9RkzB87zX/sSTtUD34mJQv2
TSlLlMOtDr21IeY1ZXtuySXDQnGnFw==
=YFMi
-----END PGP SIGNATURE-----

--fygEGrfqhcMSBUgnZ0RqiSPrtwBu8Wapw--

