Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5372084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5372084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7axX-00043b-LK
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7awq-0003M0-5X
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7awp-0007oa-06
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:52:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7awm-0007nT-JL; Tue, 10 Sep 2019 03:52:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5723C08EC1B;
 Tue, 10 Sep 2019 07:52:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC8775C21E;
 Tue, 10 Sep 2019 07:52:12 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-4-mreitz@redhat.com>
 <8fea3235-3f4c-86b1-f88e-b469081f0a6a@redhat.com>
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
Message-ID: <feec597d-c559-a2ca-c30a-b751c334ee57@redhat.com>
Date: Tue, 10 Sep 2019 09:52:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8fea3235-3f4c-86b1-f88e-b469081f0a6a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="65dDfm5xkxj7VVXSu2F2QBLaRUM0CKvAO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 10 Sep 2019 07:52:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/6] curl: Pass CURLSocket to
 curl_multi_{do, read}()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--65dDfm5xkxj7VVXSu2F2QBLaRUM0CKvAO
Content-Type: multipart/mixed; boundary="MGdyMJqs86WO0Pd4JF72o3BktTo9bfSvN";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <feec597d-c559-a2ca-c30a-b751c334ee57@redhat.com>
Subject: Re: [Qemu-block] [PATCH 3/6] curl: Pass CURLSocket to curl_multi_{do,
 read}()
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-4-mreitz@redhat.com>
 <8fea3235-3f4c-86b1-f88e-b469081f0a6a@redhat.com>
In-Reply-To: <8fea3235-3f4c-86b1-f88e-b469081f0a6a@redhat.com>

--MGdyMJqs86WO0Pd4JF72o3BktTo9bfSvN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 22:10, John Snow wrote:
>=20
>=20
> On 8/27/19 12:34 PM, Max Reitz wrote:
>> curl_multi_do_locked() currently marks all sockets as ready.  That is
>> not only inefficient, but in fact unsafe (the loop is).  A follow-up
>> patch will change that, but to do so, curl_multi_do_locked() needs to
>> know exactly which socket is ready; and that is accomplished by this
>> patch here.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/curl.c | 29 ++++++++++++++++-------------
>>  1 file changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 8a45b371cc..05f77a38c2 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -189,15 +189,15 @@ static int curl_sock_cb(CURL *curl, curl_socket_=
t fd, int action,
>>      switch (action) {
>>          case CURL_POLL_IN:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> -                               curl_multi_read, NULL, NULL, state);
>> +                               curl_multi_read, NULL, NULL, socket);
>>              break;
>>          case CURL_POLL_OUT:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> -                               NULL, curl_multi_do, NULL, state);
>> +                               NULL, curl_multi_do, NULL, socket);
>>              break;
>>          case CURL_POLL_INOUT:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> -                               curl_multi_read, curl_multi_do, NULL, =
state);
>> +                               curl_multi_read, curl_multi_do, NULL, =
socket);
>>              break;
>>          case CURL_POLL_REMOVE:
>>              aio_set_fd_handler(s->aio_context, fd, false,
>> @@ -394,9 +394,10 @@ static void curl_multi_check_completion(BDRVCURLS=
tate *s)
>>  }
>> =20
>>  /* Called with s->mutex held.  */
>> -static void curl_multi_do_locked(CURLState *s)
>> +static void curl_multi_do_locked(CURLSocket *ready_socket)
>>  {
>>      CURLSocket *socket, *next_socket;
>> +    CURLState *s =3D socket->state;
>=20
> Did you mean to use ready_socket here instead?

Oops...  Yes, I suppose so.

(An artifact from pulling apart one large patch, sorry.)

Max

>>      int running;
>>      int r;
>> =20
>> @@ -415,21 +416,23 @@ static void curl_multi_do_locked(CURLState *s)
>> =20
>>  static void curl_multi_do(void *arg)
>>  {
>> -    CURLState *s =3D (CURLState *)arg;
>> +    CURLSocket *socket =3D arg;
>> +    BDRVCURLState *s =3D socket->state->s;
>> =20
>> -    qemu_mutex_lock(&s->s->mutex);
>> -    curl_multi_do_locked(s);
>> -    qemu_mutex_unlock(&s->s->mutex);
>> +    qemu_mutex_lock(&s->mutex);
>> +    curl_multi_do_locked(socket);
>> +    qemu_mutex_unlock(&s->mutex);
>>  }
>> =20
>>  static void curl_multi_read(void *arg)
>>  {
>> -    CURLState *s =3D (CURLState *)arg;
>> +    CURLSocket *socket =3D arg;
>> +    BDRVCURLState *s =3D socket->state->s;
>> =20
>> -    qemu_mutex_lock(&s->s->mutex);
>> -    curl_multi_do_locked(s);
>> -    curl_multi_check_completion(s->s);
>> -    qemu_mutex_unlock(&s->s->mutex);
>=20
> bye bye &s->s->mutex ! you're very nasty !!
>=20
>> +    qemu_mutex_lock(&s->mutex);
>> +    curl_multi_do_locked(socket);
>> +    curl_multi_check_completion(s);
>> +    qemu_mutex_unlock(&s->mutex);
>>  }
>> =20
>>  static void curl_multi_timeout_do(void *arg)
>>



--MGdyMJqs86WO0Pd4JF72o3BktTo9bfSvN--

--65dDfm5xkxj7VVXSu2F2QBLaRUM0CKvAO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13VioACgkQ9AfbAGHV
z0Br/wgAoSu7ucKa4prS8BH0YJBdljChIlcBXKG6FxoSoHfpzmqysWBQRKKZo66/
/P5M85ZoydA2pP/jIQPcaof+pthE0Wn4iNXaJf3hhIhZ/Pj6AfKncb5NLpuurDSZ
mmgLToYaredVymJ6nLSDACUF/z58fVYjNRouzQhh8nCQhHpP5pu/pTtT4RxaoREN
f5s/xmuzr8iCrSSwAzCvJE/pr9+8NXm3SkQV7Blunv0Yy2G/sfAb1kSf+CUtOzM6
xzCR700B0+9UVZj+KmPBxPTDSo5pbiAMp2LS7cz15q6MsQOOKAh1snAAUll1r/RN
hl9bSDGwfUxl2pT27GbWDokLsR432Q==
=fdL+
-----END PGP SIGNATURE-----

--65dDfm5xkxj7VVXSu2F2QBLaRUM0CKvAO--

