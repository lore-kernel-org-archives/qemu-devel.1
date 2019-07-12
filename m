Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BD4C742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B809208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B809208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlt5W-0002Xe-Mr
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38511)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlt5K-00027K-0O
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlt5H-0007fH-MN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlt5F-0007dM-CN; Fri, 12 Jul 2019 06:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B1EFF2E97C8;
 Fri, 12 Jul 2019 10:47:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 546761001281;
 Fri, 12 Jul 2019 10:47:16 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-2-mreitz@redhat.com>
 <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
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
Message-ID: <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
Date: Fri, 12 Jul 2019 12:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dvHHPw1sZCzkolOLH3RwqAYDCViQFElGO"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 12 Jul 2019 10:47:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 1/5] block/nbd: Fix hang in .bdrv_close()
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dvHHPw1sZCzkolOLH3RwqAYDCViQFElGO
Content-Type: multipart/mixed; boundary="P34HM1mfAJqE6ezS6fpbQ7Bmb38IFT843";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <8ce2ce78-833e-c98f-ad3a-d44f6432ae4c@redhat.com>
Subject: Re: [RFC 1/5] block/nbd: Fix hang in .bdrv_close()
References: <20190711195804.30703-1-mreitz@redhat.com>
 <20190711195804.30703-2-mreitz@redhat.com>
 <20190712092419.GB4514@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190712092419.GB4514@dhcp-200-226.str.redhat.com>

--P34HM1mfAJqE6ezS6fpbQ7Bmb38IFT843
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.07.19 11:24, Kevin Wolf wrote:
> Am 11.07.2019 um 21:58 hat Max Reitz geschrieben:
>> When nbd_close() is called from a coroutine, the connection_co never
>> gets to run, and thus nbd_teardown_connection() hangs.
>>
>> This is because aio_co_enter() only puts the connection_co into the ma=
in
>> coroutine's wake-up queue, so this main coroutine needs to yield and
>> reschedule itself to let the connection_co run.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/nbd.c | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 81edabbf35..b83b6cd43e 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -135,7 +135,17 @@ static void nbd_teardown_connection(BlockDriverSt=
ate *bs)
>>      qio_channel_shutdown(s->ioc,
>>                           QIO_CHANNEL_SHUTDOWN_BOTH,
>>                           NULL);
>> -    BDRV_POLL_WHILE(bs, s->connection_co);
>> +
>> +    if (qemu_in_coroutine()) {
>> +        /* Let our caller poll and just yield until connection_co is =
done */
>> +        while (s->connection_co) {
>> +            aio_co_schedule(qemu_get_current_aio_context(),
>> +                            qemu_coroutine_self());
>> +            qemu_coroutine_yield();
>> +        }
>=20
> Isn't this busy waiting? Why not let s->connection_co wake us up when
> it's about to terminate instead of immediately rescheduling ourselves?

Yes, it is busy waiting, but I didn=E2=80=99t find that bad.  The connect=
ion_co
will be invoked in basically every iteration, and once there is no
pending data, it will quit.

The answer to =E2=80=9Cwhy not...=E2=80=9D of course is because it=E2=80=99=
d be more complicated.

But anyway.

Adding a new function qemu_coroutine_run_after(target) that adds
qemu_coroutine_self() to the given @target coroutine=E2=80=99s wake-up qu=
eue and
then using that instead of scheduling works, too, yes.

I don=E2=80=99t really like being responsible for coroutine code, though.=
=2E.

(And maybe it=E2=80=99d be better to make it qemu_coroutine_yield_for(tar=
get),
which does the above and then yields?)

Max

>> +    } else {
>> +        BDRV_POLL_WHILE(bs, s->connection_co);
>> +    }
>> =20
>>      nbd_client_detach_aio_context(bs);
>>      object_unref(OBJECT(s->sioc));
>=20
> Kevin
>=20



--P34HM1mfAJqE6ezS6fpbQ7Bmb38IFT843--

--dvHHPw1sZCzkolOLH3RwqAYDCViQFElGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0oZTMACgkQ9AfbAGHV
z0A/zAf+O16WgVaitciUk8+fPU9UwBWJ+rVbTLE/lrIya4TfuAcEpS8C22Mifdcv
TzEnSkuHv2oAgBlYKP5JSv8Ics9b+h8n5guxWMDDOiQr5fN9nElryoZoeaWhE7BA
u41BG/dt68dnFeS2K7WPM9fOkG4PnP5ZIExlnkg8swkTy5ggD+JX1ALiAYZp2Z7b
6yXJtJ64WduHSvhwdw3qT/h/9UkfIs3BRHyYClAVgmA/PEPBgZl0YpBJX4Xor18H
UvqrkkoYfpLL6Dw0/Tkw5ZyAG4NePOKtjviDd/6f+37njuPHbmajmgQfVmPia9Y2
0ueldzSUqLbHn4iBT6h5BakYes9bVg==
=0238
-----END PGP SIGNATURE-----

--dvHHPw1sZCzkolOLH3RwqAYDCViQFElGO--

