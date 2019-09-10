Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0BDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346FD2171F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346FD2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bN2-0001k7-CN
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7bLn-0000yR-Ug
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7bLl-0003dj-Vh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7bLh-0003cL-4o; Tue, 10 Sep 2019 04:18:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3284930224A8;
 Tue, 10 Sep 2019 08:18:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BB6F5D9D6;
 Tue, 10 Sep 2019 08:18:00 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-6-mreitz@redhat.com>
 <691099b9-dd24-447e-8e7a-ea949fc75737@redhat.com>
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
Message-ID: <2098eb35-cd43-6627-68d6-288969a04ce5@redhat.com>
Date: Tue, 10 Sep 2019 10:17:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <691099b9-dd24-447e-8e7a-ea949fc75737@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2ZgCJl98BM7I4BkCeRygebB5qyIkoEYxS"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 10 Sep 2019 08:18:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/6] curl: Handle success in
 multi_check_completion
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
--2ZgCJl98BM7I4BkCeRygebB5qyIkoEYxS
Content-Type: multipart/mixed; boundary="drpm7el4sYV4Dbfsqc1wgqLqHuutQIma0";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2098eb35-cd43-6627-68d6-288969a04ce5@redhat.com>
Subject: Re: [Qemu-block] [PATCH 5/6] curl: Handle success in
 multi_check_completion
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-6-mreitz@redhat.com>
 <691099b9-dd24-447e-8e7a-ea949fc75737@redhat.com>
In-Reply-To: <691099b9-dd24-447e-8e7a-ea949fc75737@redhat.com>

--drpm7el4sYV4Dbfsqc1wgqLqHuutQIma0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 22:30, John Snow wrote:
>=20
>=20
> On 8/27/19 12:34 PM, Max Reitz wrote:
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

>> and our FD read handler, so not from any cURL callbacks).
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
>> index bc70f39fcb..5e0cca601d 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -231,7 +231,6 @@ static size_t curl_read_cb(void *ptr, size_t size,=
 size_t nmemb, void *opaque)
>>  {
>>      CURLState *s =3D ((CURLState*)opaque);
>>      size_t realsize =3D size * nmemb;
>> -    int i;
>> =20
>>      trace_curl_read_cb(realsize);
>> =20
>> @@ -247,32 +246,6 @@ static size_t curl_read_cb(void *ptr, size_t size=
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
>=20
> This changes from a conditional,

It doesn=E2=80=99t really change.  This code here is the read_cb.  We may=
 have
incomplete data still.

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
>> @@ -353,13 +326,14 @@ static void curl_multi_check_completion(BDRVCURL=
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
>> @@ -371,20 +345,35 @@ static void curl_multi_check_completion(BDRVCURL=
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
>=20
> To an assertion. This makes me feel better (What happens if that was
> ever false in the old code, we just drop the callback?) but is it
> definitely always gonna be true?

No, in the old code, the read_cb may have been called multiple times per
request.  Of course, it would only really complete the last time, and
then we=E2=80=99d invoke the callback.

But here we just look at all requests that are done (CURLMSG_DONE from
curl_multi_info_read()).  So we can now assert that we=E2=80=99ve actuall=
y read
all data.

You could argue that it=E2=80=99s up to the library to behave correctly f=
or this
assertion not to blow up, which may not be to everyone=E2=80=99s liking.

> Well, you are asserting it is, so I will believe you.
>=20
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
>>
>=20
> Only other thing that's not obvious to someone who hasn't programmed
> curl before: this action is moving from curl_read_cb to check_completio=
n.

What you should ask here is why we ever did handle it in read_cb rather
than here.  That=E2=80=99s simply because the code in read_cb is older th=
an
curl_multi_check_completion().  (f785a5ae36c added the error handling;
including the =E2=80=9CACBs for successful messages get completed in
curl_read_cb=E2=80=9D comment.)

> check_completion is only called in curl_multi_read and not
> curl_multi_do, but curl_read_cb is arguably called somewhere down the
> stack from curl_multi_do_locked.
>=20
> I assume because this is curl_read_cb that there was no way it was
> getting invoked from curl_multi_do, and therefore we're not missing
> something on the return trip now.

Two things:

First, we do all error handling in check_completion, so we already rely
on it being invoked at some point (or failed requests would stall).

Second, I cannot give you a guarantee.  It isn=E2=80=99t like I have cURL=
 in my
blood.  But from what I gather, it doesn=E2=80=99t do anything in the
background, at least if the user (that is us) handles all the timer and
FD stuff.  So it should indeed only invoke the read_cb from whenever we
tell it that new data is available on some FD (or maybe when some timer
fires).  We do call curl_multi_check_completion() whenever new data is
available for reading (or when a timer fires), so it looks OK to me.
We just don=E2=80=99t call it whenever cURL can write to the socket.  But=
 it
can=E2=80=99t read anything from it then, so it should be OK.


Now that=E2=80=99s an awful lot of =E2=80=9Cshould=E2=80=9D and =E2=80=9C=
looks OK=E2=80=9D.  We can do one of
two things to improve the situation, I think: curl_multi_socket_action()
actually takes an argument that tells it whether the socket is available
for reading or writing (currently we always pass 0 to it, which means
=E2=80=9Cfigure it out yourself=E2=80=9D).  This could ensure that it doe=
sn=E2=80=99t read data
when we think the socket is only available for writing and thus won=E2=80=
=99t
call check_completion.

But there=E2=80=99s a problem: cURL doesn=E2=80=99t only accept IN and OU=
T there, but
also ERR.  When do we pass that?  Both in _read and _do?  But if it gets
ERR, it will probably return an error, so we should then call
check_completion.  So should we pass IN | ERR from _read and just OUT
from _do?

It gets a bit icky and I don=E2=80=99t want to add a bug here.

So there=E2=80=99s of course something else we could do which is to simpl=
y
invoke check_completion in _do for good measure.  (And then _do and
_read would be the same, so we could even save some LoC.)

What do you think?

Max


--drpm7el4sYV4Dbfsqc1wgqLqHuutQIma0--

--2ZgCJl98BM7I4BkCeRygebB5qyIkoEYxS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13XDYACgkQ9AfbAGHV
z0CD7wgAutZrpzYbSK+rA8bCXObVHgStEaKcZv0H0sTJXvrvRnja6zebWHZjNs2b
QZYYecOgT1Yo/Ts/UTH979Hb0p/BX8x/qqAb/UACxRFqfL4v8F7NwmpcpltLNAy9
EZFMgRyE+cusiTUdCcfunx0EONd11uifM8dHS635OmN7+74YbjPSXJ3qwOByhud5
EHIG+PWqPWqrvlB5LCd+TbS+ICfDmTmcEeFMKBL6Y6fhSGjfkRSMzOOdrGk2FkwR
e6iF8MWfzYCYSeFrTyC7LnIyA55SUnxvEkOIdnXZVvHQf03DFC5vdKE6kOwpsGow
W26g2ECeVuKLiw01QyGW4zdlTD1TSg==
=xRn8
-----END PGP SIGNATURE-----

--2ZgCJl98BM7I4BkCeRygebB5qyIkoEYxS--

