Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9169ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9372084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9372084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wmF-00048F-IJ
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7wTu-0000dW-Bx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7wTs-0005RG-QX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7wTo-0005PS-JH; Wed, 11 Sep 2019 02:51:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5AE4121D;
 Wed, 11 Sep 2019 06:51:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-94.ams2.redhat.com
 [10.36.116.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA405DA5B;
 Wed, 11 Sep 2019 06:51:49 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-4-mreitz@redhat.com>
 <781db018f83aa375b9a7476028c7ef8c4c24d848.camel@redhat.com>
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
Message-ID: <3630ff2c-513f-9dae-98c7-358775329cbc@redhat.com>
Date: Wed, 11 Sep 2019 08:51:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <781db018f83aa375b9a7476028c7ef8c4c24d848.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lYySP4OSBVZgivDaNTNkfgf7TIGwgkNSL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 11 Sep 2019 06:51:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 3/7] curl: Check completion
 in curl_multi_do()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lYySP4OSBVZgivDaNTNkfgf7TIGwgkNSL
Content-Type: multipart/mixed; boundary="mXPFo9ToDKMvra9XvWOxEPlICL2q92zaG";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <3630ff2c-513f-9dae-98c7-358775329cbc@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 3/7] curl: Check completion in
 curl_multi_do()
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-4-mreitz@redhat.com>
 <781db018f83aa375b9a7476028c7ef8c4c24d848.camel@redhat.com>
In-Reply-To: <781db018f83aa375b9a7476028c7ef8c4c24d848.camel@redhat.com>

--mXPFo9ToDKMvra9XvWOxEPlICL2q92zaG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 18:11, Maxim Levitsky wrote:
> On Tue, 2019-09-10 at 14:41 +0200, Max Reitz wrote:
>> While it is more likely that transfers complete after some file
>> descriptor has data ready to read, we probably should not rely on it.
>> Better be safe than sorry and call curl_multi_check_completion() in
>> curl_multi_do(), too, just like it is done in curl_multi_read().
>>
>> With this change, curl_multi_do() and curl_multi_read() are actually t=
he
>> same, so drop curl_multi_read() and use curl_multi_do() as the sole FD=

>> handler.
>=20
> I understand the reasoning, but I still a bit worry that this
> could paper over some bug/race in the future.
> If curl asks us only to deal with write, that would mean
> that it doesn't expect any data to be received.

I can imagine that maybe it wants to send some data first (to close the
connection) before it really marks the request as done.

> Do you by a chance have an example, of this patch
> affecting the code? Maybe when a unexpected error reply
> is received from the server?

No, I don=E2=80=99t.  As John said, this is just to ensure that we always=
 call
curl_multi_check_completion() after the read_cb might have been invoked
(and once the request is marked as =E2=80=9Cdone=E2=80=9D).

> I don't really know the CURL library, so I probably missed
> something important.

I=E2=80=99d wager a guess that nobody really does because otherwise block=
/curl.c
wouldn=E2=80=99t be in the =E2=80=9COdd Fixes=E2=80=9D category (with no =
dedicated maintainer).

Max

> Other than that,
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20
>=20
> Best regards,
> 	Maxim Levitsky
>=20
>=20
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/curl.c | 14 ++------------
>>  1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 95d7b77dc0..5838afef99 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -139,7 +139,6 @@ typedef struct BDRVCURLState {
>> =20
>>  static void curl_clean_state(CURLState *s);
>>  static void curl_multi_do(void *arg);
>> -static void curl_multi_read(void *arg);
>> =20
>>  #ifdef NEED_CURL_TIMER_CALLBACK
>>  /* Called from curl_multi_do_locked, with s->mutex held.  */
>> @@ -186,7 +185,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t =
fd, int action,
>>      switch (action) {
>>          case CURL_POLL_IN:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> -                               curl_multi_read, NULL, NULL, state);
>> +                               curl_multi_do, NULL, NULL, state);
>>              break;
>>          case CURL_POLL_OUT:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> @@ -194,7 +193,7 @@ static int curl_sock_cb(CURL *curl, curl_socket_t =
fd, int action,
>>              break;
>>          case CURL_POLL_INOUT:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> -                               curl_multi_read, curl_multi_do, NULL, =
state);
>> +                               curl_multi_do, curl_multi_do, NULL, st=
ate);
>>              break;
>>          case CURL_POLL_REMOVE:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> @@ -416,15 +415,6 @@ static void curl_multi_do(void *arg)
>>  {
>>      CURLState *s =3D (CURLState *)arg;
>> =20
>> -    qemu_mutex_lock(&s->s->mutex);
>> -    curl_multi_do_locked(s);
>> -    qemu_mutex_unlock(&s->s->mutex);
>> -}
>> -
>> -static void curl_multi_read(void *arg)
>> -{
>> -    CURLState *s =3D (CURLState *)arg;
>> -
>>      qemu_mutex_lock(&s->s->mutex);
>>      curl_multi_do_locked(s);
>>      curl_multi_check_completion(s->s);
>=20
>=20



--mXPFo9ToDKMvra9XvWOxEPlICL2q92zaG--

--lYySP4OSBVZgivDaNTNkfgf7TIGwgkNSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl14mYQACgkQ9AfbAGHV
z0Buogf9HEFs9wtLEisvl/XSooDR1L+twIQaKv5NIhgFXko3Bj9Z05gPRDLmFYYd
DpzCg8PI9vbrVquJwYnXnhjNXg/QPbiUZWYDMFdqwaJEby+VQhoVixvs+gTTRRnB
2f7xYogMV2RGkzpCMadbQLe+ra3pX/QcROLzkgkUIXkbdg+aBxgHp08vd202RXBA
InI4Hpv0/C3vXnFsNd6ZH+JXtd6Vccvj4gwv0ispUAB/oD4HiM81DLOEDGIZDstP
t8Hl1Z+D7M8EMG/eJVhS8hPNpHLGj7iSdeyWnFi3Yesy/7qhI1s95wzWo4mF1Ke0
KUhZv81w0clkTgBHgbezfv0013Scyw==
=42eO
-----END PGP SIGNATURE-----

--lYySP4OSBVZgivDaNTNkfgf7TIGwgkNSL--

