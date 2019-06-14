Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CA0C31E4E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5882084D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 20:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5882084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbt0j-0002EL-0p
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 16:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60486)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbszK-00013J-5i
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbszJ-0004mw-68
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 16:39:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39272)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbszG-0004jS-R8; Fri, 14 Jun 2019 16:39:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC40E30832DE;
 Fri, 14 Jun 2019 20:39:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17A8F648CF;
 Fri, 14 Jun 2019 20:39:28 +0000 (UTC)
To: Klaus Birkelund Jensen <klaus@birkelund.eu>, qemu-block@nongnu.org
References: <20190606092530.14206-1-klaus@birkelund.eu>
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
Message-ID: <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
Date: Fri, 14 Jun 2019 22:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606092530.14206-1-klaus@birkelund.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="i4iVxd5uN757broCtWnCWxQCnx2JU2g8u"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 14 Jun 2019 20:39:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nvme: do not advertise support for
 unsupported arbitration mechanism
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
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i4iVxd5uN757broCtWnCWxQCnx2JU2g8u
Content-Type: multipart/mixed; boundary="VW5zcBraDItk2HdiPqI73EmO5emWgKOez";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Klaus Birkelund Jensen <klaus@birkelund.eu>, qemu-block@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
Subject: Re: [PATCH] nvme: do not advertise support for unsupported
 arbitration mechanism
References: <20190606092530.14206-1-klaus@birkelund.eu>
In-Reply-To: <20190606092530.14206-1-klaus@birkelund.eu>

--VW5zcBraDItk2HdiPqI73EmO5emWgKOez
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.06.19 11:25, Klaus Birkelund Jensen wrote:
> The device mistakenly reports that the Weighted Round Robin with Urgent=

> Priority Class arbitration mechanism is supported.
>=20
> It is not.

I believe you based on the fact that there is no =E2=80=9Cweight=E2=80=9D=
 or =E2=80=9Cpriority=E2=80=9D
anywhere in nvme.c, and that it does not evaluate the Arbitration
Mechanism Selected field.

> Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 30e50f7a3853..415b4641d6b4 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1383,7 +1383,6 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>      n->bar.cap =3D 0;
>      NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
>      NVME_CAP_SET_CQR(n->bar.cap, 1);
> -    NVME_CAP_SET_AMS(n->bar.cap, 1);

I suppose the better way would be to pass 0, so it is more explicit, I
think.

(Just removing it looks like it may have just been forgotten.)

Max

>      NVME_CAP_SET_TO(n->bar.cap, 0xf);
>      NVME_CAP_SET_CSS(n->bar.cap, 1);
>      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
>=20



--VW5zcBraDItk2HdiPqI73EmO5emWgKOez--

--i4iVxd5uN757broCtWnCWxQCnx2JU2g8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0EBf8ACgkQ9AfbAGHV
z0C/Nwf+NmTZXyjCZcvI0Zdyvb4sHdCrvVs6WgzSPTNA1efJ0BhnNpRHNSGO+UOd
YwsXp05vL3QbIDJsRMX6DK7sP22RhsNfeLPVwdgMHvh9zH2K8AvWbJfhPm8b9bPm
JB+gSNFo6pVnsbwiP0c6WtkWZCtR83Epak7AytjOmi1pde3xGWOs3isiEE/cQUVy
Je6ui6nobkR5HK2Mniox/aneVpsUyIK9zuD9U8unD7GwL0h43wHjylgvG3cs5MaC
o1uBBtqGv4niboY38rFQHhwdZUY8B+DiB7wEa9h2v+zEnq5tVDG3SUWqcN0DdW6E
C84u/TATU8x6GamZS/rNXYQ3iT+wSA==
=Q/95
-----END PGP SIGNATURE-----

--i4iVxd5uN757broCtWnCWxQCnx2JU2g8u--

