Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30163C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6252073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 10:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4OiSsqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6252073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjx4-0003ZO-AJ
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 06:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTjwD-00035q-K5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTjvr-0004To-En
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:27:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43848
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTjvq-0004NL-V5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 06:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588156029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i4KAGs+JyG23MW5XZwAlyq4LTC4Ik9fjnJKGQ7J0hZY=;
 b=b4OiSsqjoXs/gP6cBaS89lm78t5tFIOOA7mkX669YGSk6v/ReWt+1fLugEWkjMIyLPhXX9
 1GGO/KlZzlxdJxCy+Xfpl3mkB6lL8fNV9wF+d9FztY+Y1jAjB07fxmgzHT/TTltSsOskza
 9irmUJ3pZmEAbJC1tXUUbHCDszzZPs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-iVhC5tevMbWhOKzKyw_7qQ-1; Wed, 29 Apr 2020 06:27:03 -0400
X-MC-Unique: iVhC5tevMbWhOKzKyw_7qQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC5E145F;
 Wed, 29 Apr 2020 10:27:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8CBE5C1C8;
 Wed, 29 Apr 2020 10:26:59 +0000 (UTC)
Subject: Re: [PATCH v22 4/4] iotests: 287: add qcow2 compression type test
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200428200013.24474-1-dplotnikov@virtuozzo.com>
 <20200428200013.24474-5-dplotnikov@virtuozzo.com>
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
Message-ID: <9920c9a7-7442-d6de-a976-55be9f3896f9@redhat.com>
Date: Wed, 29 Apr 2020 12:26:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428200013.24474-5-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AKMilsPHF4b7qyF2twp2Va858PJ923pul"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AKMilsPHF4b7qyF2twp2Va858PJ923pul
Content-Type: multipart/mixed; boundary="7v7bhBj0sUod4qu91strk60zVXmM3B5st"

--7v7bhBj0sUod4qu91strk60zVXmM3B5st
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 22:00, Denis Plotnikov wrote:
> The test checks fulfilling qcow2 requirements for the compression
> type feature and zstd compression type operability.
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/287     | 152 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/287.out |  67 ++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 220 insertions(+)
>  create mode 100755 tests/qemu-iotests/287
>  create mode 100644 tests/qemu-iotests/287.out
>=20
> diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
> new file mode 100755
> index 0000000000..21fe1f19f5
> --- /dev/null
> +++ b/tests/qemu-iotests/287
> @@ -0,0 +1,152 @@
> +#!/usr/bin/env bash
> +#
> +# Test case for an image using zstd compression
> +#
> +# Copyright (c) 2020 Virtuozzo International GmbH
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +# creator
> +owner=3Ddplotnikov@virtuozzo.com
> +
> +seq=3D"$(basename $0)"
> +echo "QA output created by $seq"
> +
> +status=3D1=09# failure is the default!
> +
> +# standard environment
> +. ./common.rc
> +. ./common.filter
> +
> +# This tests qocw2-specific low-level functionality
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +_unsupported_imgopts 'compat=3D0.10' data_file
> +
> +COMPR_IMG=3D"$TEST_IMG.compressed"
> +RAND_FILE=3D"$TEST_DIR/rand_data"
> +
> +_cleanup()
> +{
> +=09_rm_test_img

_rm_test_img needs an argument (it basically replaces =93rm=94).  What I
thus meant was to keep the _cleanup_test_img here (that was completely
correct), but...

> +=09rm -f "$COMPR_IMG"

...to use =93_rm_test_img "$COMPR_IMG"=94 here instead of rm.

Max


--7v7bhBj0sUod4qu91strk60zVXmM3B5st--

--AKMilsPHF4b7qyF2twp2Va858PJ923pul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pVnIACgkQ9AfbAGHV
z0Dhnwf+KZYK1tN1teZG6mZcUPMMLzAbdRKQmqwMv1IAPcuVL6UBsUiIZ5Jp0FZ7
dQdiy1udIgA/Dj2j99D8Vimwwqi/Pl0DtcGypHwCrnMaWTCJxSEIMpAEjVQXOK3O
cjQL3OXQlXTQknFTJA1olH+9n7Lu+nwKxeiHscqER3YnUh97xGrRlSQcUY2lxQqm
r0AjDpxD8PApLUa8URu1eg6laORLOoQAwjfPodEo/GKUpyTa+RuBFteDcK9hhGxF
ezP01ZuAtRiNxppzhpsOQJ9fw/sT0QAVV10uijRdJUT5OWJK16ftaG4nTYdsQNd2
QDlB4EZhlylYPtNNsTMunbxLiHhFkA==
=q2bp
-----END PGP SIGNATURE-----

--AKMilsPHF4b7qyF2twp2Va858PJ923pul--


