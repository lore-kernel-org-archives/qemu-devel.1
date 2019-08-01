Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A23DC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:46:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1122084C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 19:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1122084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htH1m-0001tq-6j
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 15:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1htH0b-00017b-64
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1htH0a-00008E-2l
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 15:45:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1htH0X-000061-HL; Thu, 01 Aug 2019 15:45:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1F08315D007;
 Thu,  1 Aug 2019 19:44:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-187.brq.redhat.com
 [10.40.204.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F4BB600C4;
 Thu,  1 Aug 2019 19:44:55 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190724094025.12442-1-vsementsov@virtuozzo.com>
 <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
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
Message-ID: <7a7c668b-eac0-eadd-7065-689c5eae6ce0@redhat.com>
Date: Thu, 1 Aug 2019 21:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hZqRZCTPpQIsvvYXGkfHUQ3edEDynLLC1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 01 Aug 2019 19:45:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
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
Cc: kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hZqRZCTPpQIsvvYXGkfHUQ3edEDynLLC1
Content-Type: multipart/mixed; boundary="OS2VrX8LUwHQxDn2Se0jNF6OS5GqlXSdf";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <7a7c668b-eac0-eadd-7065-689c5eae6ce0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] blockjob: drain all job nodes in
 block_job_drain
References: <20190724094025.12442-1-vsementsov@virtuozzo.com>
 <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>
In-Reply-To: <1977e825-0a1f-e575-2ffa-0ea8c65531bb@redhat.com>

--OS2VrX8LUwHQxDn2Se0jNF6OS5GqlXSdf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 21:11, John Snow wrote:
>=20
>=20
> On 7/24/19 5:40 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Instead of draining additional nodes in each job code, let's do it in
>> common block_job_drain, draining just all job's children.
>> BlockJobDriver.drain becomes unused, so, drop it at all.
>>
>> It's also a first step to finally get rid of blockjob->blk.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>
>> v3: just resend, as I've some auto returned mails and not sure that
>>     v2 reached recipients.
>>
>> v2: apply Max's suggestions:
>>  - drop BlockJobDriver.drain
>>  - do firtly loop of bdrv_drained_begin and then separate loop
>>    of bdrv_drained_end.
>>
>>    Hmm, a question here: should I call bdrv_drained_end in reverse
>>    order? Or it's OK as is?
>>
>=20
> I think it should be OK. These nodes don't necessarily have a well
> defined relationship between each other, do they?

It=E2=80=99s OK.  If they do have a relationship, the drain code sorts it=
 out by
itself anyway.

[...]

> Seems much nicer to me. What becomes of the ref/unref pairs?
>=20
> I guess not needed anymore?, since job cleanup necessarily happens in
> the main loop context now and we don't have a backup_complete function
> anymore ...?
>=20
> In the cases where auto_finalize=3Dtrue, do we have any guarantee that =
the
> completion callbacks cannot be scheduled while we are here?

Let me try to figure this out...

The only caller of block_job_drain() is job_drain(), whose only caller
is job_finish_sync() in an AIO_WAIT_WHILE() loop.  That loop can only
work in the main loop, so I suppose it does run in the main loop (and
consequentially, block_job_drain() runs in the main loop, too).

That AIO_WAIT_WHILE() loop drains the job (so all nodes) and waits until
the job has completed.  To me that looks like it is designed to have the
completion callback run at some point...?

I suppose anything like that is scheduled by job_enter() in job_drain(),
namely the aio_co_enter() in there.

(A) If the job runs in the main AioContext, aio_co_enter() will enter
the coroutine if we do not run in a coroutine right now (safe), or it
will schedule it for a later point if we do run in a coroutine.  That
latter part may be unsafe, because I guess some coroutine work in
bdrv_drained_begin() or bdrv_drained_end() may wake it up, which can
then mess everything up.

(B) If the job runs in another context, aio_co_enter() will schedule the
job immediately, which I guess means that it can run at any point?  So
it could complete at any point, including block_job_drain().  Ah, no,
actually.  AIO_WAIT_WHILE() will have the job=E2=80=99s context acquired =
while
evaluating the condition (that is, when calling block_job_drain()).  So
this is safe.


So, well.  Unless Vladimir can give you a guarantee why e.g.
block_job_remove_all_bdrv() won=E2=80=99t run during e.g. bdrv_drained_be=
gin(),
I suppose you=E2=80=99re right and the node list needs to be copied at th=
e
beginning of this function and all nodes should be ref=E2=80=99d.

Max


--OS2VrX8LUwHQxDn2Se0jNF6OS5GqlXSdf--

--hZqRZCTPpQIsvvYXGkfHUQ3edEDynLLC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1DQTYACgkQ9AfbAGHV
z0Bk2AgAlsYDYrQv0tnBkCNHy/3uW/H9WZIBKNDGrylbDg99Da6eZ8JcM4bnBSGN
fgMZUiWRMdIhHWPKtd9ROdxYq8va2nho1W67i76e+Vnzzg6X5w9QhMfwa8OQByJ5
AUr6NL8j8e4PcuJgQ0GCoXv1YWAIE3+qoJ+WQZ56QpViGR1xU7JQdJuEbPQgnHF6
gztSdlw9QETY/+tagcKpQnbts1+JYQCXb++Toc4NXyav8aLtPVHnAiQ8EVfRakzA
jTtnfY8CytoYIowWhThSiK1OuvwWAcipS5ro7XWUbyb76MNiTBw1/QIsdgNPPanF
4AnEzxmneeX6LPrA32siKhWu9WKnew==
=S3qG
-----END PGP SIGNATURE-----

--hZqRZCTPpQIsvvYXGkfHUQ3edEDynLLC1--

