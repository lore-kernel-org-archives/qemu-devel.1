Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14668C2D0EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5382070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 12:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7ILRW2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5382070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHRYu-0002q1-29
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 08:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHRYK-0002Pb-Qc
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHRYJ-00073D-3V
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:24:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHRYI-00072v-Q3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 08:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585225441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AIbS+FfQtaAlJ8lTrYIBIaZioyn3BbKa/Tay5867cA0=;
 b=a7ILRW2oxKt38Cjos6Qgood2sRLgIvYukVlwau/MC8WlpwGh95EgY7GUNQTSion7a2+ZFY
 3APo9iXpg9GsdlqhmHq7NHU+eotaZeIwsOb5wVnN5wevC6PR0BpLtRfkyvhcK0It5v187m
 7bc4CPW6Jprca7FqHtLYkbSLUTQhLh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-M9KboicJP7qfabjRfBHWiA-1; Thu, 26 Mar 2020 08:23:54 -0400
X-MC-Unique: M9KboicJP7qfabjRfBHWiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75173DB6B;
 Thu, 26 Mar 2020 12:23:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 693D210002A5;
 Thu, 26 Mar 2020 12:23:33 +0000 (UTC)
Subject: Re: [PATCH 0/2] Fix the generic image creation code
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200326011218.29230-1-mlevitsk@redhat.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <e5855331-05a9-c828-5bdd-e2d06e0352a9@redhat.com>
Date: Thu, 26 Mar 2020 13:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326011218.29230-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yd9NDyZt1iLnrbNRs6K9vq0y30DfUO7VE"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 integration@gluster.org, sheepdog@lists.wpkg.org,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Jason Dillaman <dillaman@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yd9NDyZt1iLnrbNRs6K9vq0y30DfUO7VE
Content-Type: multipart/mixed; boundary="ava5bSWF3WPXbH2YmreYGog6UW2kh33lo"

--ava5bSWF3WPXbH2YmreYGog6UW2kh33lo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.03.20 02:12, Maxim Levitsky wrote:
> The recent patches from Max Reitz allowed some block drivers to not
> provide the .bdrv_co_create_opts and still allow qemu-img to
> create/format images as long as the image is already existing
> (that is the case with various block storage drivers like nbd/iscsi/nvme,=
 etc)
>=20
> However it was found out that some places in the code depend on the
> .bdrv_co_create_opts/.create_opts to be !=3D NULL to decide if to allow
> image creation.
>=20
> To avoid adding failback code to all these places, just make generic fail=
back
> code be used by the drivers that need it, so that for outside user, there
> is no diffirence if failback was used or not.
>=20
> Best regards,
> =09Maxim Levitsky
>=20
> Maxim Levitsky (2):
>   block: pass BlockDriver reference to the .bdrv_co_create
>   block: trickle down the fallback image creation function use to the
>     block drivers

Thanks, fixed the function parameter alignment, moved the declarations
from block.h into block_int.h, and applied the series to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--ava5bSWF3WPXbH2YmreYGog6UW2kh33lo--

--yd9NDyZt1iLnrbNRs6K9vq0y30DfUO7VE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl58nsMACgkQ9AfbAGHV
z0Dqzwf/cTELxi2l1hNi2TgpbYUHYA6SdgEGBlhnL5vRZODw9DtydJMzNds+jv98
kEbVbDt4A4N0Cy5XVTK4eDVp6zWbbmtoVcEKqPN05JfCoudklAu6OG4hC4GAkqxQ
JTMW69+wuIPk1cdB781rbNND+JGcMjvRGAPQXX2XUiT+CIKqG6O/TfjBf9wWN+DT
s6SQLT/cgwloNCnYLIepIAoatX8D3vRV2UNMaBgtUWscgoNj15EK6A+7lUEH4hRX
YSH2Fy4y9oQbdgcDkqD7e58ICEogLsfiEaJ97BONZVUTPXUmU1ZGu9k87cv14uGK
PpNdN35QvGn2bA8rVj5uqg+REO8xww==
=GMS0
-----END PGP SIGNATURE-----

--yd9NDyZt1iLnrbNRs6K9vq0y30DfUO7VE--


