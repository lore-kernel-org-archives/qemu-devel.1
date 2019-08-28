Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA0C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:23:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252F72080F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 14:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252F72080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2yr9-0001gv-62
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 10:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i2yqH-0001DR-IA
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i2yqG-0008BB-Ky
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 10:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i2yqD-00088s-6I; Wed, 28 Aug 2019 10:22:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A49785545;
 Wed, 28 Aug 2019 14:22:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34BBC6012D;
 Wed, 28 Aug 2019 14:22:13 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-3-vsementsov@virtuozzo.com>
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
Message-ID: <6c22ee44-4875-92e5-273b-53276cdec860@redhat.com>
Date: Wed, 28 Aug 2019 16:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826161312.489398-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XqnZ7lt1SJ6eHcTehx64GSFMwu3hO4dcu"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 28 Aug 2019 14:22:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9 02/13] block/backup: split shareable
 copying part from backup_do_cow
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
Cc: fam@euphon.net, kwolf@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com,
 jsnow@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XqnZ7lt1SJ6eHcTehx64GSFMwu3hO4dcu
Content-Type: multipart/mixed; boundary="oxd6zX0qINs2ObUFAtXjJQ0Kn424tXHOV";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net,
 stefanha@redhat.com, jsnow@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <6c22ee44-4875-92e5-273b-53276cdec860@redhat.com>
Subject: Re: [PATCH v9 02/13] block/backup: split shareable copying part from
 backup_do_cow
References: <20190826161312.489398-1-vsementsov@virtuozzo.com>
 <20190826161312.489398-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190826161312.489398-3-vsementsov@virtuozzo.com>

--oxd6zX0qINs2ObUFAtXjJQ0Kn424tXHOV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.19 18:13, Vladimir Sementsov-Ogievskiy wrote:
> Split copying logic which will be shared with backup-top filter.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 47 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
>=20
> diff --git a/block/backup.c b/block/backup.c
> index 33b144305f..13a1d80157 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -248,26 +248,18 @@ static int64_t backup_bitmap_reset_unallocated(Ba=
ckupBlockJob *s,
>      return ret;
>  }
> =20
> -static int coroutine_fn backup_do_cow(BackupBlockJob *job,
> -                                      int64_t offset, uint64_t bytes,
> -                                      bool *error_is_read,
> -                                      bool is_write_notifier)
> +static int coroutine_fn backup_do_copy(BackupBlockJob *job,
> +                                       int64_t offset, uint64_t bytes,=

> +                                       bool *error_is_read,
> +                                       bool is_write_notifier)
>  {
> -    CowRequest cow_request;
>      int ret =3D 0;
> -    int64_t start, end; /* bytes */
> +    int64_t start =3D offset, end =3D bytes + offset; /* bytes */

Maybe just rename the =E2=80=9Coffset=E2=80=9D parameter to =E2=80=9Cstar=
t=E2=80=9D, replace the =E2=80=9Cbytes=E2=80=9D
parameter by an =E2=80=9Cend=E2=80=9D parameter, and drop this line?

Max

>      void *bounce_buffer =3D NULL;
>      int64_t status_bytes;
> =20
> -    qemu_co_rwlock_rdlock(&job->flush_rwlock);
> -
> -    start =3D QEMU_ALIGN_DOWN(offset, job->cluster_size);
> -    end =3D QEMU_ALIGN_UP(bytes + offset, job->cluster_size);
> -
> -    trace_backup_do_cow_enter(job, start, offset, bytes);
> -
> -    wait_for_overlapping_requests(job, start, end);
> -    cow_request_begin(&cow_request, job, start, end);
> +    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
> +    assert(QEMU_IS_ALIGNED(end, job->cluster_size));
> =20
>      while (start < end) {
>          int64_t dirty_end;


--oxd6zX0qINs2ObUFAtXjJQ0Kn424tXHOV--

--XqnZ7lt1SJ6eHcTehx64GSFMwu3hO4dcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1mjhMACgkQ9AfbAGHV
z0BSqQf9FyvWpfsTLR8wQvMO1WeUlaQjFk7pEl3ZQ35VGmqMqALkQD+s+2N5psIg
8aE5v6ogguwpinO0Whjx/4WcX/ma36IogodkMB2e7wy7bmoHk7TYclpuJd5wmcem
D4QPHoJg0rv73+z4AYvNHhaWz0cFsag/5cYoeasiKtUfO84V2EkMv46bBHXzRZJf
UcCVwNI7rxCCcyjjOkiPr0DDpdbkFZsTroWxZFdz5yb765FdkstCWJEses+yCV5D
9py0K5FB9tXrKsSSQu++K7dwWQtE0iadmepEew9cxev30rQVKnt350A8/SbTibZ4
vlcA2B+ScDCLtP44zHJRnl4jkCa+Ww==
=Kfb8
-----END PGP SIGNATURE-----

--XqnZ7lt1SJ6eHcTehx64GSFMwu3hO4dcu--

