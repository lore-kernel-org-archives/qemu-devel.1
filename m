Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C83C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9793820872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9793820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aT0-0001dy-Ji
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7aRa-0000YP-77
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7aRZ-0002M7-1m
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:20:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7aRV-0002Ko-JQ; Tue, 10 Sep 2019 03:20:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA4D1307D925;
 Tue, 10 Sep 2019 07:20:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B388E19C78;
 Tue, 10 Sep 2019 07:19:59 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190903133553.6500-1-mreitz@redhat.com>
 <20190903133553.6500-2-mreitz@redhat.com>
 <CAFEAcA_Gpw14Hjr7rW0Z-9Ngj5Udbxv0ZEMZAo0W0PT0nCwe2g@mail.gmail.com>
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
Message-ID: <3311e590-d2c1-2388-27cf-981c917881ab@redhat.com>
Date: Tue, 10 Sep 2019 09:19:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Gpw14Hjr7rW0Z-9Ngj5Udbxv0ZEMZAo0W0PT0nCwe2g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tTnX1J5qwIbG6BPojvtiRdHMT5IADGYTG"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 10 Sep 2019 07:20:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 01/16] qemu-io: add pattern file for
 write command
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tTnX1J5qwIbG6BPojvtiRdHMT5IADGYTG
Content-Type: multipart/mixed; boundary="cmVWEzpepzzet2RUJHex68u5Swz3vl5Nd";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <3311e590-d2c1-2388-27cf-981c917881ab@redhat.com>
Subject: Re: [PULL v2 01/16] qemu-io: add pattern file for write command
References: <20190903133553.6500-1-mreitz@redhat.com>
 <20190903133553.6500-2-mreitz@redhat.com>
 <CAFEAcA_Gpw14Hjr7rW0Z-9Ngj5Udbxv0ZEMZAo0W0PT0nCwe2g@mail.gmail.com>
In-Reply-To: <CAFEAcA_Gpw14Hjr7rW0Z-9Ngj5Udbxv0ZEMZAo0W0PT0nCwe2g@mail.gmail.com>

--cmVWEzpepzzet2RUJHex68u5Swz3vl5Nd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 19:26, Peter Maydell wrote:
> On Tue, 3 Sep 2019 at 14:35, Max Reitz <mreitz@redhat.com> wrote:
>>
>> From: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>
>> The patch allows to provide a pattern file for write
>> command. There was no similar ability before.
>>
>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>> Message-id: 20190820164616.4072-1-dplotnikov@virtuozzo.com
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> [mreitz: Keep optstring in alphabetical order]
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Hi; Coverity finds a FILE* leak in this code (CID 1405303):

Thanks for the heads-up.  Denis, do you want to write a patch?

Max

>> +/*
>> + * qemu_io_alloc_from_file()
>> + *
>> + * Allocates the buffer and populates it with the content of the give=
n file
>> + * up to @len bytes. If the file length is less than @len, then the b=
uffer
>> + * is populated with the file content cyclically.
>> + *
>> + * @blk - the block backend where the buffer content is going to be w=
ritten to
>> + * @len - the buffer length
>> + * @file_name - the file to read the content from
>> + *
>> + * Returns: the buffer pointer on success
>> + *          NULL on error
>> + */
>> +static void *qemu_io_alloc_from_file(BlockBackend *blk, size_t len,
>> +                                     const char *file_name)
>> +{
>> +    char *buf, *buf_origin;
>> +    FILE *f =3D fopen(file_name, "r");
>=20
> Here we allocate the FILE*...
>=20
>> +    int pattern_len;
>> +
>> +    if (!f) {
>> +        perror(file_name);
>> +        return NULL;
>> +    }
>> +
>> +    if (qemuio_misalign) {
>> +        len +=3D MISALIGN_OFFSET;
>> +    }
>> +
>> +    buf_origin =3D buf =3D blk_blockalign(blk, len);
>> +
>> +    if (qemuio_misalign) {
>> +        buf_origin +=3D MISALIGN_OFFSET;
>> +        buf +=3D MISALIGN_OFFSET;
>> +        len -=3D MISALIGN_OFFSET;
>> +    }
>> +
>> +    pattern_len =3D fread(buf_origin, 1, len, f);
>> +
>> +    if (ferror(f)) {
>> +        perror(file_name);
>> +        goto error;
>=20
> ...but in this error-exit path...
>=20
>> +    }
>> +
>> +    if (pattern_len =3D=3D 0) {
>> +        fprintf(stderr, "%s: file is empty\n", file_name);
>> +        goto error;
>=20
> ...and this one...
>=20
>> +    }
>> +
>> +    fclose(f);
>> +
>> +    if (len > pattern_len) {
>> +        len -=3D pattern_len;
>> +        buf +=3D pattern_len;
>> +
>> +        while (len > 0) {
>> +            size_t len_to_copy =3D MIN(pattern_len, len);
>> +
>> +            memcpy(buf, buf_origin, len_to_copy);
>> +
>> +            len -=3D len_to_copy;
>> +            buf +=3D len_to_copy;
>> +        }
>> +    }
>> +
>> +    return buf_origin;
>> +
>> +error:
>> +    qemu_io_free(buf_origin);
>> +    return NULL;
>=20
> ...we go to the 'error' label and leave the function without
> ever calling fclose(f).
>=20
>> +}
>=20
> thanks
> -- PMM
>=20



--cmVWEzpepzzet2RUJHex68u5Swz3vl5Nd--

--tTnX1J5qwIbG6BPojvtiRdHMT5IADGYTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13Tp0ACgkQ9AfbAGHV
z0CMMAf+NwYpNzz5Cfb3aCEsDAwQPW3FXra5wJxKUo4VOtLd94NLtwxtSt6uQA5G
zShdIi4Aj/afU4s+KH1QsnTyKIUNe0XWxZ5OStMqTd5ws/i1AYtE9/PXJifzOVBP
YdrN2aM0XrV1AyVvT1kIN9//5SoDMnOaOyZBFhoAOCR0Tr1FRiLb7dteHQa8eiMi
lU1vqOuYNpk7nhAW7Y4sFLnOUBUqBiq1R02vepuZpVWyBeHhAns8BA68b3QxyfHx
Z+ZHOAHzsSnKcj0dRaFiZIVsRjIakkFEjf8WmaUwMq3qQYoIY2JimX0pnQUylcbX
3znMIiO8Z6FDeFv8W7kCvNV6tWvB0Q==
=qwRZ
-----END PGP SIGNATURE-----

--tTnX1J5qwIbG6BPojvtiRdHMT5IADGYTG--

