Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A444C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 411E82084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411E82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7awX-0002wf-DR
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7avc-0002Qo-3c
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7avb-00073q-1u
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:51:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7avY-00071R-R2; Tue, 10 Sep 2019 03:51:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1FB838980E1;
 Tue, 10 Sep 2019 07:51:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 378EE60BE2;
 Tue, 10 Sep 2019 07:50:59 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-3-mreitz@redhat.com>
 <4197624e-c06e-b7d9-4cf4-90af4ccc53cf@redhat.com>
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
Message-ID: <dd4490ab-c395-b6e0-6606-03216b8fdd12@redhat.com>
Date: Tue, 10 Sep 2019 09:50:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4197624e-c06e-b7d9-4cf4-90af4ccc53cf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WUgL2AHeReeqIx1rc1eNVmpr7FBpyorF5"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 10 Sep 2019 07:51:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/6] curl: Keep *socket until
 the end of curl_sock_cb()
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
--WUgL2AHeReeqIx1rc1eNVmpr7FBpyorF5
Content-Type: multipart/mixed; boundary="AeQ1WNAssBTZf8qwxVqRCIAHo2RQK7fTJ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <dd4490ab-c395-b6e0-6606-03216b8fdd12@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/6] curl: Keep *socket until the end of
 curl_sock_cb()
References: <20190827163439.16686-1-mreitz@redhat.com>
 <20190827163439.16686-3-mreitz@redhat.com>
 <4197624e-c06e-b7d9-4cf4-90af4ccc53cf@redhat.com>
In-Reply-To: <4197624e-c06e-b7d9-4cf4-90af4ccc53cf@redhat.com>

--AeQ1WNAssBTZf8qwxVqRCIAHo2RQK7fTJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 22:09, John Snow wrote:
>=20
>=20
> On 8/27/19 12:34 PM, Max Reitz wrote:
>> This does not really change anything, but it makes the code a bit easi=
er
>> to follow once we use @socket as the opaque pointer for
>> aio_set_fd_handler().
>>
>> (Also, this change stops us from creating new CURLSocket objects when
>> the cURL library just wants to stop listening on an existing socket th=
at
>> we do not recognize.  With a well-behaving cURL, that should never
>> happen anyway.)
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/curl.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 92dc2f630e..8a45b371cc 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -174,18 +174,16 @@ static int curl_sock_cb(CURL *curl, curl_socket_=
t fd, int action,
>>          if (socket->fd =3D=3D fd) {
>>              if (action =3D=3D CURL_POLL_REMOVE) {
>>                  QLIST_REMOVE(socket, next);
>> -                g_free(socket);
>>              }
>>              break;
>>          }
>>      }
>=20
>> -    if (!socket) {
>> +    if (action !=3D CURL_POLL_REMOVE && !socket) {
>>          socket =3D g_new0(CURLSocket, 1);
>>          socket->fd =3D fd;
>>          socket->state =3D state;
>>          QLIST_INSERT_HEAD(&state->sockets, socket, next);
>>      }
>> -    socket =3D NULL;
>> =20
>>      trace_curl_sock_cb(action, (int)fd);
>>      switch (action) {
>> @@ -207,6 +205,9 @@ static int curl_sock_cb(CURL *curl, curl_socket_t =
fd, int action,
>>              break;
>>      }
>> =20
>> +    if (action =3D=3D CURL_POLL_REMOVE) {
>> +        g_free(socket);
>> +    }
>>      return 0;
>>  }
>> =20
>>
>=20
> Very naive question: why is CURL_POLL_REMOVE handled so early in the
> function? Why not handle both QLIST_REMOVE and g_free under the
> switch(action) construct entirely?

I don=E2=80=99t know how that=E2=80=99s a naive question, it=E2=80=99s ju=
st a different way to
approach this problem.  Sure, we can do that.  It is probably more
intuitive to everyone who hasn=E2=80=99t seen the state before this serie=
s.

Max


--AeQ1WNAssBTZf8qwxVqRCIAHo2RQK7fTJ--

--WUgL2AHeReeqIx1rc1eNVmpr7FBpyorF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13VeIACgkQ9AfbAGHV
z0Bcdwf/VAblvCDvwDnQsdQn7VtTu54MAEg0Ikbfw80Qo0GE1qT8hw0vV8yRRZOk
/x3aJpG93y4IC7opMZZu/wPIfDDaNJTlTDaA8iCtnBj51CITQj+XUq4pVHtETULk
kwdkgBC5hOKlsuhgjObBzqlUSYHPQt9LizcQRHuMmqmjSWN3wc4PyC+3AFiWGY7c
ikR9nQ1PS7XSNvPe4pYeZGE0yvztWnrBUbVX2c8RiKQQT0cKyMRnxN1SKwa58bzJ
8c89Ml2NDQRvmjUI5r+CGR7fqT58VB78fjysFx5DWKt6cGozeO6ZufJHXyW38mcJ
TFjU4xDu3ccia0QhrP1OVP70YF/uCw==
=AnaN
-----END PGP SIGNATURE-----

--WUgL2AHeReeqIx1rc1eNVmpr7FBpyorF5--

