Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5DFC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E580820880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E580820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLsV-0005LE-D4
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnLsK-0004sG-2W
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnLsJ-0004fx-2f
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33334)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnLsG-0004cS-Hi; Tue, 16 Jul 2019 07:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9810413A82;
 Tue, 16 Jul 2019 11:43:59 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F362E5C21A;
 Tue, 16 Jul 2019 11:43:54 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-10-jsnow@redhat.com>
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
Message-ID: <1e0e9638-6d60-7343-e6db-a1e77b5da932@redhat.com>
Date: Tue, 16 Jul 2019 13:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716000117.25219-10-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tbUfFe1WUWW0L1T9PXLy1k7bC1GL3bCpO"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 16 Jul 2019 11:43:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/11] block/backup: teach TOP to never
 copy unallocated regions
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tbUfFe1WUWW0L1T9PXLy1k7bC1GL3bCpO
Content-Type: multipart/mixed; boundary="OFpcQQYDF51gEqIM8Mz5vftDtNHixCXAO";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <1e0e9638-6d60-7343-e6db-a1e77b5da932@redhat.com>
Subject: Re: [PATCH v2 09/11] block/backup: teach TOP to never copy
 unallocated regions
References: <20190716000117.25219-1-jsnow@redhat.com>
 <20190716000117.25219-10-jsnow@redhat.com>
In-Reply-To: <20190716000117.25219-10-jsnow@redhat.com>

--OFpcQQYDF51gEqIM8Mz5vftDtNHixCXAO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 02:01, John Snow wrote:
> Presently, If sync=3DTOP is selected, we mark the entire bitmap as dirt=
y.
> In the write notifier handler, we dutifully copy out such regions.
>=20
> Fix this in three parts:
>=20
> 1. Mark the bitmap as being initialized before the first yield.
> 2. After the first yield but before the backup loop, interrogate the
> allocation status asynchronously and initialize the bitmap.
> 3. Teach the write notifier to interrogate allocation status if it is
> invoked during bitmap initialization.
>=20
> As an effect of this patch, the job progress for TOP backups
> now behaves like this:
>=20
> - total progress starts at bdrv_length.
> - As allocation status is interrogated, total progress decreases.
> - As blocks are copied, current progress increases.
>=20
> Taken together, the floor and ceiling move to meet each other.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c     | 78 ++++++++++++++++++++++++++++++++++++++++------=

>  block/trace-events |  1 +
>  2 files changed, 70 insertions(+), 9 deletions(-)

Looks good to me but for a seemingly unrelated change:

> diff --git a/block/backup.c b/block/backup.c
> index b407d57954..e28fd23f6a 100644
> --- a/block/backup.c
> +++ b/block/backup.c

[...]

> @@ -507,10 +565,12 @@ static int coroutine_fn backup_run(Job *job, Erro=
r **errp)
>               * notify callback service CoW requests. */
>              job_yield(job);
>          }
> +        ret =3D -ECANCELED;

This one.  This doesn=E2=80=99t look like it belongs in this patch, and I=
=E2=80=99m not
even sure it=E2=80=99s correct.  Being cancelled is the normal state for
sync=3Dnone, so I suppose it is correct to just return 0 then.

Max

>      } else {
>          ret =3D backup_loop(s);
>      }
> =20
> + out:
>      notifier_with_return_remove(&s->before_write);
> =20
>      /* wait until pending backup_do_cow() calls have completed */


--OFpcQQYDF51gEqIM8Mz5vftDtNHixCXAO--

--tbUfFe1WUWW0L1T9PXLy1k7bC1GL3bCpO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0tuHgACgkQ9AfbAGHV
z0D7swgAsBDLEVu/YXRXien2O87pn9QMfg2MqbzyDI3wvDge8gdYTh8lvxJivE+9
lgokZ6W/7OKj36N7/dMKWKLvMfqAOvFwM064gRYm0L8sGas7bwk4XrLnbmL28Omd
AUZKnsZhcEgZc+D+eIcfSh1jmTI44Hd0JyKI5MxPjs6SdZepJFnRBhGdyf02L6M8
/eULSxJD0xC034FUD59XauThkOvW6UG5LYqwG6c+XMtWigmecO402Z/qt+4a+QJp
VkXjoBS8KMkb8NAAwfP0CJr/OzomRi6Lt1OAnWQTszG7eVDlFOfFvvRtdEolsvbg
9m5Cb+/bJfoBekAKpi7yBpH8VeVbPA==
=OA/g
-----END PGP SIGNATURE-----

--tbUfFe1WUWW0L1T9PXLy1k7bC1GL3bCpO--

