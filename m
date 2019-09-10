Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A902C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39DA2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39DA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7azc-0005Zq-1Q
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7ay2-0004XG-DQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7axz-0008GP-CY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35464)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7axv-0008Ei-0N; Tue, 10 Sep 2019 03:53:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11E893172D8D;
 Tue, 10 Sep 2019 07:53:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD9FE60BE2;
 Tue, 10 Sep 2019 07:53:25 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-5-mreitz@redhat.com>
 <6ecb6085-174f-f3a5-62cd-5a75a319c91f@redhat.com>
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
Message-ID: <a8894b10-113d-bde9-b3b1-35cea2a1ead7@redhat.com>
Date: Tue, 10 Sep 2019 09:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6ecb6085-174f-f3a5-62cd-5a75a319c91f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mQfDZM9Y4ZknhhiWWkGVpfvM8eUvUVhCz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 10 Sep 2019 07:53:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/6] curl: Report only ready
 sockets
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
--mQfDZM9Y4ZknhhiWWkGVpfvM8eUvUVhCz
Content-Type: multipart/mixed; boundary="F9RYgSh8n2H5yHfHGdwPe8ndpR2IFXKaN";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a8894b10-113d-bde9-b3b1-35cea2a1ead7@redhat.com>
Subject: Re: [Qemu-block] [PATCH 4/6] curl: Report only ready sockets
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-5-mreitz@redhat.com>
 <6ecb6085-174f-f3a5-62cd-5a75a319c91f@redhat.com>
In-Reply-To: <6ecb6085-174f-f3a5-62cd-5a75a319c91f@redhat.com>

--F9RYgSh8n2H5yHfHGdwPe8ndpR2IFXKaN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 22:16, John Snow wrote:
>=20
>=20
> On 8/27/19 12:34 PM, Max Reitz wrote:
>> Instead of reporting all sockets to cURL, only report the one that has=

>> caused curl_multi_do_locked() to be called.  This lets us get rid of t=
he
>> QLIST_FOREACH_SAFE() list, which was actually wrong: SAFE foreaches ar=
e
>> only safe when the current element is removed in each iteration.  If i=
t
>> possible for the list to be concurrently modified, we cannot guarantee=

>> that only the current element will be removed.  Therefore, we must not=

>> use QLIST_FOREACH_SAFE() here.
>>
>> Fixes: ff5ca1664af85b24a4180d595ea6873fd3deac57
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/curl.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 05f77a38c2..bc70f39fcb 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -394,24 +394,19 @@ static void curl_multi_check_completion(BDRVCURL=
State *s)
>>  }
>> =20
>>  /* Called with s->mutex held.  */
>> -static void curl_multi_do_locked(CURLSocket *ready_socket)
>> +static void curl_multi_do_locked(CURLSocket *socket)
>=20
> Only a momentary hiccup, then.
>=20
>>  {
>> -    CURLSocket *socket, *next_socket;
>> -    CURLState *s =3D socket->state;
>> +    BDRVCURLState *s =3D socket->state->s;
>>      int running;
>>      int r;
>> =20
>> -    if (!s->s->multi) {
>> +    if (!s->multi) {
>>          return;
>>      }
>> =20
>> -    /* Need to use _SAFE because curl_multi_socket_action() may trigg=
er
>> -     * curl_sock_cb() which might modify this list */
>> -    QLIST_FOREACH_SAFE(socket, &s->sockets, next, next_socket) {
>> -        do {
>> -            r =3D curl_multi_socket_action(s->s->multi, socket->fd, 0=
, &running);
>> -        } while (r =3D=3D CURLM_CALL_MULTI_PERFORM);
>> -    }
>> +    do {
>> +        r =3D curl_multi_socket_action(s->multi, socket->fd, 0, &runn=
ing);
>> +    } while (r =3D=3D CURLM_CALL_MULTI_PERFORM);
>>  }
>> =20
>>  static void curl_multi_do(void *arg)
>>
>=20
> We were just calling this spuriously on whatever sockets before?

Yep.  I was to blame; but to my defense, before then we only called it
for a single socket (which doesn=E2=80=99t work that well for FTP).

Max

> Seems like a clear improvement, then.
>=20



--F9RYgSh8n2H5yHfHGdwPe8ndpR2IFXKaN--

--mQfDZM9Y4ZknhhiWWkGVpfvM8eUvUVhCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13VnMACgkQ9AfbAGHV
z0DyLQf+MWCg+fyro5mWpshWAJ0G72xMI9mbm0khurLF7FsT4MR9AlBdFAYJdIH/
antxtzDN6hU0pL4dsj6gT3qEjyX0UV0i7TGCo1CZex5H0mj/OpE1NwoyPELBLfDY
7AYG0mFh5N87zB02Vx/SVL7w08zhJimiVs6Az4pzI20hRNuCeKBdxSQFuEYk8ngX
WWFQFBIikFpij9yHj8AVscOlEjiiQ9Vu9fCNOEiGliMT6BX2I/uXaDhN8tMVNzzF
MirUuDjAkHR7XmeATqm0iPtpD3XnEbgW+47mTScNT4Vmx2pvQlokcAZKqX+QxnQm
AD2+UprwwztbO9jkH9spIAsAubxL8A==
=AiFz
-----END PGP SIGNATURE-----

--mQfDZM9Y4ZknhhiWWkGVpfvM8eUvUVhCz--

