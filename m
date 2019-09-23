Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7084C4740C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1DC20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1DC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCL1g-0004wO-3z
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCKzw-0003Tr-GL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCKzv-0003Go-4s
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:51:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCKzs-0003F3-GN; Mon, 23 Sep 2019 05:51:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECC61C053B34;
 Mon, 23 Sep 2019 09:51:06 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5BF510016EB;
 Mon, 23 Sep 2019 09:51:01 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v6 0/8] Add Qemu to SeaBIOS LCHS interface
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190827082427.64280-1-sameid@google.com>
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
Message-ID: <de51ae88-5bb3-07dc-18d8-ab96d14eb3bc@redhat.com>
Date: Mon, 23 Sep 2019 11:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827082427.64280-1-sameid@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7lGRogEDizVVYQO5WFLpmLbsMcAiwnoJL"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 23 Sep 2019 09:51:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, seabios@seabios.org,
 kevin@koconnor.net, liran.alon@oracle.com, kraxel@redhat.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7lGRogEDizVVYQO5WFLpmLbsMcAiwnoJL
Content-Type: multipart/mixed; boundary="c0oa1hrI8me5WDgvYk4Rxw9oq1OeEccmZ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, seabios@seabios.org,
 kevin@koconnor.net, liran.alon@oracle.com, kraxel@redhat.com,
 karl.heubaum@oracle.com
Message-ID: <de51ae88-5bb3-07dc-18d8-ab96d14eb3bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/8] Add Qemu to SeaBIOS LCHS interface
References: <20190827082427.64280-1-sameid@google.com>
In-Reply-To: <20190827082427.64280-1-sameid@google.com>

--c0oa1hrI8me5WDgvYk4Rxw9oq1OeEccmZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.08.19 10:24, Sam Eiderman via Qemu-devel wrote:
> v1:
>=20
> Non-standard logical geometries break under QEMU.
>=20
> A virtual disk which contains an operating system which depends on
> logical geometries (consistent values being reported from BIOS INT13
> AH=3D08) will most likely break under QEMU/SeaBIOS if it has non-standa=
rd
> logical geometries - for example 56 SPT (sectors per track).
> No matter what QEMU will guess - SeaBIOS, for large enough disks - will=

> use LBA translation, which will report 63 SPT instead.
>=20
> In addition we can not enforce SeaBIOS to rely on phyiscal geometries a=
t
> all. A virtio-blk-pci virtual disk with 255 phyiscal heads can not
> report more than 16 physical heads when moved to an IDE controller, the=

> ATA spec allows a maximum of 16 heads - this is an artifact of
> virtualization.
>=20
> By supplying the logical geometies directly we are able to support such=

> "exotic" disks.
>=20
> We will use fw_cfg to do just that.
>=20
> v2:
>=20
> Fix missing parenthesis check in
>     "hd-geo-test: Add tests for lchs override"
>=20
> v3:
>=20
> * Rename fw_cfg key to "bios-geometry".
> * Remove "extendible" interface.
> * Add cpu_to_le32 fix as Laszlo suggested or big endian hosts
> * Fix last qtest commit - automatic docker tester for some reason does =
not have qemu-img set
>=20
> v4:
>=20
> * Change fw_cfg interface from mixed textual/binary to textual only
>=20
> v5:
>=20
> * Fix line > 80 chars in tests/hd-geo-test.c
>=20
> v6:
>=20
> * Small fixes for issues pointed by Max
> * (&conf->conf)->lcyls to conf->conf.lcyls and so on
> * Remove scsi_unrealize from everything other than scsi-hd
> * Add proper include to sysemu.h
> * scsi_device_unrealize() after scsi_device_purge_requests()
>=20
> Sam Eiderman (8):
>   block: Refactor macros - fix tabbing
>   block: Support providing LCHS from user
>   bootdevice: Add interface to gather LCHS
>   scsi: Propagate unrealize() callback to scsi-hd
>   bootdevice: Gather LCHS from all relevant devices
>   bootdevice: Refactor get_boot_devices_list
>   bootdevice: FW_CFG interface for LCHS values
>   hd-geo-test: Add tests for lchs override
>=20
>  bootdevice.c             | 148 ++++++++--
>  hw/block/virtio-blk.c    |   6 +
>  hw/ide/qdev.c            |   7 +-
>  hw/nvram/fw_cfg.c        |  14 +-
>  hw/scsi/scsi-bus.c       |  16 ++
>  hw/scsi/scsi-disk.c      |  12 +
>  include/hw/block/block.h |  22 +-
>  include/hw/scsi/scsi.h   |   1 +
>  include/sysemu/sysemu.h  |   4 +
>  tests/Makefile.include   |   2 +-
>  tests/hd-geo-test.c      | 582 +++++++++++++++++++++++++++++++++++++++=

>  11 files changed, 773 insertions(+), 41 deletions(-)

Acked-by: Max Reitz <mreitz@redhat.com>


--c0oa1hrI8me5WDgvYk4Rxw9oq1OeEccmZ--

--7lGRogEDizVVYQO5WFLpmLbsMcAiwnoJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2IlYMACgkQ9AfbAGHV
z0CDIAgAo1/Vrid3HmVOaCi7FqMrBso2HwWp3W0IH44ZQqFmMXSXBon3x298TJ0X
e8BTB8VFw7TRsSGkYnE3pmK3qx8+8oMJgr2B2KiTSjIVxTa8p/5Ce4FqCYyBPS3H
QVkfbYRejIol08QQEgKZqnL0L23MV60AO1vSKdbRaNbz3jHsxf1digFMdtt1me78
9kZbpieFK+P6JpPc3iymb/OCDCw5hMB6ULOpY15e9MGGDIYk2vnBwJMhg3wkdM/P
HrQp8SrJhh7lbDtLjan0gbXmu5dkRtHG8hhX/FVn3dxR+mcMxXdSI6b8LBo78UrY
5q45UHNNDpkvCywyARFBHyhNIjmxMg==
=S/Fq
-----END PGP SIGNATURE-----

--7lGRogEDizVVYQO5WFLpmLbsMcAiwnoJL--

