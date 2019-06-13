Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D11DC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFECF207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFECF207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTWQ-0005e3-MB
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbSCe-0008JS-52
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbSCX-0004Fr-9j
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18893)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbSC9-0002n0-LW; Thu, 13 Jun 2019 12:03:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FFD13079B87;
 Thu, 13 Jun 2019 16:03:07 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A6C360A9A;
 Thu, 13 Jun 2019 16:03:05 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190612220839.1374-1-mreitz@redhat.com>
 <20190612220839.1374-2-mreitz@redhat.com>
 <b110b753-8546-0d34-f6ef-06c5726766ce@virtuozzo.com>
 <c1fbf12a-77af-d939-4266-67b822e5a923@redhat.com>
 <57ae7f82-ae02-a382-74f6-cb96672b2058@virtuozzo.com>
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
Message-ID: <00cce102-a1f1-9205-6eb7-1e48d8991b00@redhat.com>
Date: Thu, 13 Jun 2019 18:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <57ae7f82-ae02-a382-74f6-cb96672b2058@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M3wl1NTteJ8gK53oiyYBvZsIyRQjRRD9b"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 13 Jun 2019 16:03:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Drain before (block) job cancel
 when quitting
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M3wl1NTteJ8gK53oiyYBvZsIyRQjRRD9b
Content-Type: multipart/mixed; boundary="017Fbqrn0PEJzCqCYB50BGb6u5dJ1R9nv";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00cce102-a1f1-9205-6eb7-1e48d8991b00@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Drain before (block) job cancel when
 quitting
References: <20190612220839.1374-1-mreitz@redhat.com>
 <20190612220839.1374-2-mreitz@redhat.com>
 <b110b753-8546-0d34-f6ef-06c5726766ce@virtuozzo.com>
 <c1fbf12a-77af-d939-4266-67b822e5a923@redhat.com>
 <57ae7f82-ae02-a382-74f6-cb96672b2058@virtuozzo.com>
In-Reply-To: <57ae7f82-ae02-a382-74f6-cb96672b2058@virtuozzo.com>

--017Fbqrn0PEJzCqCYB50BGb6u5dJ1R9nv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[re-adding the original CCs, why not]

On 13.06.19 16:30, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 17:21, Max Reitz wrote:
>> On 13.06.19 16:19, Vladimir Sementsov-Ogievskiy wrote:
>>> 13.06.2019 1:08, Max Reitz wrote:
>>>> If the main loop cancels all block jobs while the block layer is not=

>>>> drained, this cancelling may not happen instantaneously.  We can sta=
rt a
>>>> drained section before vm_shutdown(), which entails another
>>>> bdrv_drain_all(); this nested bdrv_drain_all() will thus be a no-op,=

>>>> basically.
>>>>
>>>> We do not have to end the drained section, because we actually do no=
t
>>>> want any requests to happen from this point on.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>> I don't know whether it actually makes sense to never end this drain=
ed
>>>> section.  It makes sense to me.  Please correct me if I'm wrong.
>>>> ---
>>>>    vl.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/vl.c b/vl.c
>>>> index cd1fbc4cdc..3f8b3f74f5 100644
>>>> --- a/vl.c
>>>> +++ b/vl.c
>>>> @@ -4538,6 +4538,17 @@ int main(int argc, char **argv, char **envp)
>>>>         */
>>>>        migration_shutdown();
>>>>   =20
>>>> +    /*
>>>> +     * We must cancel all block jobs while the block layer is drain=
ed,
>>>> +     * or cancelling will be affected by throttling and thus may bl=
ock
>>>> +     * for an extended period of time.
>>>> +     * vm_shutdown() will bdrv_drain_all(), so we may as well inclu=
de
>>>> +     * it in the drained section.
>>>> +     * We do not need to end this section, because we do not want a=
ny
>>>> +     * requests happening from here on anyway.
>>>> +     */
>>>> +    bdrv_drain_all_begin();
>>>> +
>>>>        /* No more vcpu or device emulation activity beyond this poin=
t */
>>>>        vm_shutdown();
>>>>   =20
>>>>
>>>
>>> So, actually, the problem is that we may wait for job requests twice:=

>>> on drain and then on cancel.
>>
>> We don=E2=80=99t wait on drain.  When the throttle node is drained, it=
 will
>> ignore throttling (as noted in the cover letter).
>>
>> We do wait when cancelling a job while the throttle node isn=E2=80=99t=
 drained,
>> though.  That=E2=80=99s the problem.
>=20
> Ah, understand now.
>=20
> Is it safe to drain_begin before stopping cpus? We may finish up then w=
ith some queued
> somewhere IO requests..

Hm...  Aren=E2=80=99t guest devices prohibited from issuing requests to t=
he
block layer while their respective block device is drained?

Otherwise, I suppose I=E2=80=99ll have to move the bdrv_drain_all_begin()=
 below
the vm_shutdown().  That wouldn=E2=80=99t be too big of a problem.

Max


--017Fbqrn0PEJzCqCYB50BGb6u5dJ1R9nv--

--M3wl1NTteJ8gK53oiyYBvZsIyRQjRRD9b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Cc7gACgkQ9AfbAGHV
z0A5uQf8DX6F12p8sJQ7GftT8/WVVqz0u8csoUw+O7Ralgetd7rFAMMscHGSvWLC
VHV6jxXAApnOpKsNMY2IVdwQjrXuVe5k/873Dm/a4aW8wxft29AjgKshdc0ro5dT
QfMyLTd8dGTj9+lWuu4GjfctsEZudpl+rxyhl7ig/5IPq3KbEOtFSWdnoEFr+XCX
y6RzarcIFckZNjypY6/6S9aUDwKMRQxqI8yyG9V34P4B/BU8z/RCviAgn2FybcHt
PeFuu2GUOJd0X8l+5VAlLSd913CYaIjPRcJR7bD04Gj6D2P2E49uEqf/YnhIGrxR
280B6JX9OcOBZF+DQJN2bCBqnIuRlA==
=0IQZ
-----END PGP SIGNATURE-----

--M3wl1NTteJ8gK53oiyYBvZsIyRQjRRD9b--

