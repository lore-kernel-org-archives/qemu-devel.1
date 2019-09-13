Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF4C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63485208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63485208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8je3-00085J-KW
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8jcZ-0006uS-W3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8jcY-0002tc-IY
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:20:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8jcV-0002pd-CH; Fri, 13 Sep 2019 07:20:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 969EC50F64;
 Fri, 13 Sep 2019 11:20:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4DC960606;
 Fri, 13 Sep 2019 11:20:04 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-7-mreitz@redhat.com>
 <b3a81eca84577a0524bd1be8366852e2801a65f1.camel@redhat.com>
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
Message-ID: <cd6879cf-222d-ea48-0bb7-49d0fc455374@redhat.com>
Date: Fri, 13 Sep 2019 13:20:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b3a81eca84577a0524bd1be8366852e2801a65f1.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CAxtYf79QvvZc4cRSg2AyhjZy2tBEjj3O"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 13 Sep 2019 11:20:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 6/7] curl: Handle success
 in multi_check_completion
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
--CAxtYf79QvvZc4cRSg2AyhjZy2tBEjj3O
Content-Type: multipart/mixed; boundary="vzlj94fnGk2NTRutpS1cJ3bMB00ZzZ2Rf";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Message-ID: <cd6879cf-222d-ea48-0bb7-49d0fc455374@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 6/7] curl: Handle success in
 multi_check_completion
References: <20190910124136.10565-1-mreitz@redhat.com>
 <20190910124136.10565-7-mreitz@redhat.com>
 <b3a81eca84577a0524bd1be8366852e2801a65f1.camel@redhat.com>
In-Reply-To: <b3a81eca84577a0524bd1be8366852e2801a65f1.camel@redhat.com>

--vzlj94fnGk2NTRutpS1cJ3bMB00ZzZ2Rf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 18:13, Maxim Levitsky wrote:
> On Tue, 2019-09-10 at 14:41 +0200, Max Reitz wrote:
>> Background: As of cURL 7.59.0, it verifies that several functions are
>> not called from within a callback.  Among these functions is
>> curl_multi_add_handle().
>>
>> curl_read_cb() is a callback from cURL and not a coroutine.  Waking up=

>> acb->co will lead to entering it then and there, which means the curre=
nt
>> request will settle and the caller (if it runs in the same coroutine)
>> may then issue the next request.  In such a case, we will enter
>> curl_setup_preadv() effectively from within curl_read_cb().
>>
>> Calling curl_multi_add_handle() will then fail and the new request wil=
l
>> not be processed.
>>
>> Fix this by not letting curl_read_cb() wake up acb->co.  Instead, leav=
e
>> the whole business of settling the AIOCB objects to
>> curl_multi_check_completion() (which is called from our timer callback=

>> and our FD handler, so not from any cURL callbacks).
>>
>> Reported-by: Natalie Gavrielov <ngavrilo@redhat.com>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1740193
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/curl.c | 69 ++++++++++++++++++++++-----------------------------=
-
>>  1 file changed, 29 insertions(+), 40 deletions(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index fd70f1ebc4..c343c7ed3d 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -229,7 +229,6 @@ static size_t curl_read_cb(void *ptr, size_t size,=
 size_t nmemb, void *opaque)
>>  {
>>      CURLState *s =3D ((CURLState*)opaque);
>>      size_t realsize =3D size * nmemb;
>> -    int i;
>> =20
>>      trace_curl_read_cb(realsize);
>> =20
>> @@ -245,32 +244,6 @@ static size_t curl_read_cb(void *ptr, size_t size=
, size_t nmemb, void *opaque)
>>      memcpy(s->orig_buf + s->buf_off, ptr, realsize);
>>      s->buf_off +=3D realsize;
>> =20
>> -    for(i=3D0; i<CURL_NUM_ACB; i++) {
>> -        CURLAIOCB *acb =3D s->acb[i];
>> -
>> -        if (!acb)
>> -            continue;
>> -
>> -        if ((s->buf_off >=3D acb->end)) {
>> -            size_t request_length =3D acb->bytes;
>> -
>> -            qemu_iovec_from_buf(acb->qiov, 0, s->orig_buf + acb->star=
t,
>> -                                acb->end - acb->start);
>> -
>> -            if (acb->end - acb->start < request_length) {
>> -                size_t offset =3D acb->end - acb->start;
>> -                qemu_iovec_memset(acb->qiov, offset, 0,
>> -                                  request_length - offset);
>> -            }
>> -
>> -            acb->ret =3D 0;
>> -            s->acb[i] =3D NULL;
>> -            qemu_mutex_unlock(&s->s->mutex);
>> -            aio_co_wake(acb->co);
>> -            qemu_mutex_lock(&s->s->mutex);
>> -        }
>> -    }
>> -
>>  read_end:
>>      /* curl will error out if we do not return this value */
>>      return size * nmemb;
>> @@ -351,13 +324,14 @@ static void curl_multi_check_completion(BDRVCURL=
State *s)
>>              break;
>> =20
>>          if (msg->msg =3D=3D CURLMSG_DONE) {
>> +            int i;
>>              CURLState *state =3D NULL;
>> +            bool error =3D msg->data.result !=3D CURLE_OK;
>> +
>>              curl_easy_getinfo(msg->easy_handle, CURLINFO_PRIVATE,
>>                                (char **)&state);
>> =20
>> -            /* ACBs for successful messages get completed in curl_rea=
d_cb */
>> -            if (msg->data.result !=3D CURLE_OK) {
>> -                int i;
>> +            if (error) {
>>                  static int errcount =3D 100;
>> =20
>>                  /* Don't lose the original error message from curl, s=
ince
>> @@ -369,20 +343,35 @@ static void curl_multi_check_completion(BDRVCURL=
State *s)
>>                          error_report("curl: further errors suppressed=
");
>>                      }
>>                  }
>> +            }
>> =20
>> -                for (i =3D 0; i < CURL_NUM_ACB; i++) {
>> -                    CURLAIOCB *acb =3D state->acb[i];
>> +            for (i =3D 0; i < CURL_NUM_ACB; i++) {
>> +                CURLAIOCB *acb =3D state->acb[i];
>> =20
>> -                    if (acb =3D=3D NULL) {
>> -                        continue;
>> -                    }
>> +                if (acb =3D=3D NULL) {
>> +                    continue;
>> +                }
>> +
>> +                if (!error) {
>> +                    /* Assert that we have read all data */
>> +                    assert(state->buf_off >=3D acb->end);
>> +
>> +                    qemu_iovec_from_buf(acb->qiov, 0,
>> +                                        state->orig_buf + acb->start,=

>> +                                        acb->end - acb->start);
>> =20
>> -                    acb->ret =3D -EIO;
>> -                    state->acb[i] =3D NULL;
>> -                    qemu_mutex_unlock(&s->mutex);
>> -                    aio_co_wake(acb->co);
>> -                    qemu_mutex_lock(&s->mutex);
>> +                    if (acb->end - acb->start < acb->bytes) {
>> +                        size_t offset =3D acb->end - acb->start;
>> +                        qemu_iovec_memset(acb->qiov, offset, 0,
>> +                                          acb->bytes - offset);
>> +                    }
> Original code was memsetting the tail of the buffer before waking up th=
e coroutine.
> Is this change intended?
>=20
> aio_co_wake doesn't enter the co-routine if already in coroutine, but
> I think that this is an aio fd handler with isn't run in co-routine its=
elf,
> so the callback could run with not yet ready data.

(Sorry, I don=E2=80=99t know why I forgot to reply.)

I don=E2=80=99t see how anything changes.  aio_co_wake() is still called =
after
the qemu_iovec_memset().

Max

>>                  }
>> +
>> +                acb->ret =3D error ? -EIO : 0;
>> +                state->acb[i] =3D NULL;
>> +                qemu_mutex_unlock(&s->mutex);
>> +                aio_co_wake(acb->co);
>> +                qemu_mutex_lock(&s->mutex);
>>              }
>> =20
>>              curl_clean_state(state);
>=20
>=20
> Best regards,
> 	Maxim Levitsky
>=20



--vzlj94fnGk2NTRutpS1cJ3bMB00ZzZ2Rf--

--CAxtYf79QvvZc4cRSg2AyhjZy2tBEjj3O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17e2IACgkQ9AfbAGHV
z0Cv3gf7BCpgBnZEKDROHi+Ss1wmZCctRC46sTsrEr5H7wKJ+Yom0mDcmd6073/t
U2oBHs9JvWYDdH6b2/90B00GGdaMajrKJLzoBmlXE+WiYeTpzTFKBjBNfxePhOqi
LSUnbY5Gm0vkAXOpSerz0jv9XR9mKlgYAH3sLZMxevoj8xZbjo5B3sZbgya4JCMu
0j473ghZQIyjeGQGvqw57ERLVOlPpiySRmvhKpemazr9bRaSBeLs0C16pPNtd/4X
1xdF4PDqqvTZLpWwqc6+yX3c8kK9B3h1Ib/BKZylmxV5u9Q/LG5syRTY1ybGKdoT
Mv0xRObJBKmpIxCZcLN6psfSgO97Tw==
=tokd
-----END PGP SIGNATURE-----

--CAxtYf79QvvZc4cRSg2AyhjZy2tBEjj3O--

