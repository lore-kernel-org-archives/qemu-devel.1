Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1673AC74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1F920838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1F920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJbr-0007en-Rv
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlJb9-0007Bv-0N
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlJb6-0007rE-Qt
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:53:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlJb4-0007jK-22; Wed, 10 Jul 2019 16:53:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2630E3082B44;
 Wed, 10 Jul 2019 20:53:49 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DEF198BA;
 Wed, 10 Jul 2019 20:53:44 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-7-jsnow@redhat.com>
 <24cb63cb-e19c-c4cb-fb08-c8f1d086cabf@redhat.com>
 <5b3f6dad-c438-861f-b4cf-236b3f058322@redhat.com>
 <4e9b8a92-c98d-0f19-3f8f-636dc64ca0b4@redhat.com>
 <6a3440ed-f9d2-8f84-a5a7-d9db34a79b5b@redhat.com>
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
Message-ID: <03822316-9e9f-b538-85f0-1404852af514@redhat.com>
Date: Wed, 10 Jul 2019 22:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6a3440ed-f9d2-8f84-a5a7-d9db34a79b5b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Lr2Ew4piNay6zYcqIvYuPfhNCz6p56UC4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 10 Jul 2019 20:53:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/8] block/backup: issue progress updates
 for skipped regions
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lr2Ew4piNay6zYcqIvYuPfhNCz6p56UC4
Content-Type: multipart/mixed; boundary="zUupGiqpNhNHo3am9AMycR4qfgKa2KCrf";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <03822316-9e9f-b538-85f0-1404852af514@redhat.com>
Subject: Re: [PATCH 6/8] block/backup: issue progress updates for skipped
 regions
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-7-jsnow@redhat.com>
 <24cb63cb-e19c-c4cb-fb08-c8f1d086cabf@redhat.com>
 <5b3f6dad-c438-861f-b4cf-236b3f058322@redhat.com>
 <4e9b8a92-c98d-0f19-3f8f-636dc64ca0b4@redhat.com>
 <6a3440ed-f9d2-8f84-a5a7-d9db34a79b5b@redhat.com>
In-Reply-To: <6a3440ed-f9d2-8f84-a5a7-d9db34a79b5b@redhat.com>

--zUupGiqpNhNHo3am9AMycR4qfgKa2KCrf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 22:47, John Snow wrote:
>=20
>=20
> On 7/10/19 4:30 PM, Max Reitz wrote:
>> On 10.07.19 20:20, John Snow wrote:
>>>
>>>
>>> On 7/10/19 12:36 PM, Max Reitz wrote:
>>>> On 10.07.19 03:05, John Snow wrote:
>>>>> The way bitmap backups work is by starting at 75% if it needs
>>>>> to copy just 25% of the disk.
>>>>
>>>> Although there is this comment:
>>>>
>>>>> /* TODO job_progress_set_remaining() would make more sense */
>>>>
>>>> So...
>>>>
>>>>> The way sync=3Dtop currently works, however, is to start at 0% and =
then
>>>>> never update the progress if it doesn't copy a region. If it needs =
to
>>>>> copy 25% of the disk, we'll finish at 25%.
>>>>>
>>>>> Update the progress when we skip regions.
>>>>
>>>> Wouldn=E2=80=99t it be more correct to decrease the job length?
>>>>
>>>> Max
>>>>
>>>
>>> Admittedly I have precisely no idea. Maybe? As far as I understand it=
,
>>> we guarantee only:
>>>
>>> (1) Progress monotonically increases
>>> (2) Upon completion, progress will equal the total work estimate.
>>>     [Trying to fix that to be true here.]
>>>
>>> This means we can do stuff like:
>>>
>>> - Total work estimate can increase or decrease arbitrarily
>>> - Neither value has to mean anything in particular
>>>
>>>
>>> Bitmap sync works by artificially increasing progress for NOP regions=
,
>>> seen in init_copy_bitmap.
>>
>> Yes, and it has a TODO comment that says it should be done differently=
=2E
>>
>>> Full sync also tends to increase progress regardless of it actually d=
id
>>> a copy or not; offload support also counts as progress here. So if yo=
u
>>> full sync an empty image, you'll see it increasing the progress as it=

>>> doesn't actually do anything.
>>>
>>> Top sync is the odd one out, which just omits progress for regions it=
 skips.
>>>
>>> My only motivation here was to make them consistent. Can I do it the
>>> other way? Yeah, probably. Is one way better than the other? I
>>> legitimately have no idea. I guess whoever wrote the last comment fel=
t
>>> that it should all be the other way instead. Why'd they not do that?
>>
>> If you look at the commit (05df8a6a2b4), I suppose it was because that=

>> commit simply did not intend to change behavior.  It just touched that=

>> piece of code and noted that maybe there should be a follow-up commit =
to
>> change it.
>>
>> But yeah, whatever.
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>=20
> I mean. I'll make it consistent either way, but I actually don't know
> which way I should make it go. I just think that all the modes should
> work the same if we can help it.
>=20
> Flip a coin?

If you=E2=80=99d flip a coin, I can say that I=E2=80=99d find it a bit mo=
re meaningful
to reduce the length.  Especially if you change sync=3Dtop to calculate
beforehand how much we need to copy, so the length isn=E2=80=99t even red=
uced
while the job is running.

And it=E2=80=99s easier to remove the TODO comment this way.  If we decid=
e
against it, you=E2=80=99d have to remove the TODO comment aso (because we=

decided against it), but you=E2=80=99d need to justify it in the commit m=
essage.
 And we all know that writing explanations and documentation is the
hardest thing of all.

Max


--zUupGiqpNhNHo3am9AMycR4qfgKa2KCrf--

--Lr2Ew4piNay6zYcqIvYuPfhNCz6p56UC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mUFcACgkQ9AfbAGHV
z0BQQgf/fxV4TAzdPxBXFRbE1UE1uYoX5CoJ5fDgTQpCsGG9RiuThFjdnZdKy3No
XwXp/+WCGXyu5/H7ps8B3Hl6rdp3Ew/MVTTjvq0ihjvoahlTWBZrDcbNTKVTwyYM
Ug5sN9thZ99tb/wr0iV4NZGqoFkUMc/MvWKAOBUxtkT7eDmPQoYwSO8zobDUJvb2
TaBt1eW7/9XlNNHrZV93Ed80pT3tj1+BsQ4SoJ63aU7M867OXSy6WuqH+XHV2RUz
s71Q9UlUXa8m6UKoN9RV4d7UWg9buyAShi0AxVk31Ls+TkfDMDcS3+fUUbE7nGH+
uKK/LTECuoorAp9DRsZ8LGiFDilneQ==
=wjEA
-----END PGP SIGNATURE-----

--Lr2Ew4piNay6zYcqIvYuPfhNCz6p56UC4--

