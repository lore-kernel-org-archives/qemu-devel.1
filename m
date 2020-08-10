Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39526C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7E82078D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T63XNbDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7E82078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59TU-0004zk-6m
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k59SK-0004Rc-Vl
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:11:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59869
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k59SI-00051W-0p
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597072276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ACNWXQZkVsuEuqzOVp4dtkD+dF16gboF+EqWOk1w4LI=;
 b=T63XNbDBsokuXWLkNAwDrr67BbhRrSsvzW2r9b0vNAJsg2UV/e9kwnGfivMsRvHX3uydVb
 CSxG43rbV78qdcbmsVCjy0ntg9qSCnX3nq9TDIRyBe4547x+j38wzpPFHMkKq/ls9/zcix
 Vqww3G8JhJX2n9GZKyJaeEwKPDySO1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-cayUa2pCMGmo79SCwgB5Bg-1; Mon, 10 Aug 2020 11:11:13 -0400
X-MC-Unique: cayUa2pCMGmo79SCwgB5Bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744ED1326E1;
 Mon, 10 Aug 2020 15:11:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-36.ams2.redhat.com
 [10.36.113.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D89056F120;
 Mon, 10 Aug 2020 15:11:09 +0000 (UTC)
Subject: Re: [PATCH for-5.1 v2 2/2] iotests: add test for unaligned
 granularity bitmap backup
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-block@nongnu.org
References: <20200810095523.15071-1-s.reiter@proxmox.com>
 <20200810095523.15071-2-s.reiter@proxmox.com>
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
Message-ID: <941940d2-370d-0452-83c8-969a41f83c72@redhat.com>
Date: Mon, 10 Aug 2020 17:11:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810095523.15071-2-s.reiter@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WwZSkP09Y8LVE4jLrxmHjmMAKqKWsBAqU"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwZSkP09Y8LVE4jLrxmHjmMAKqKWsBAqU
Content-Type: multipart/mixed; boundary="3BuiXYvDqr6xGWQxMDUN2wl5moHXZ8JxA"

--3BuiXYvDqr6xGWQxMDUN2wl5moHXZ8JxA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

(Note: When submitting a patch series with multiple patches, our
guidelines require a cover letter:
https://wiki.qemu.org/Contribute/SubmitAPatch#Include_a_meaningful_cover_le=
tter

But not too important now.)

On 10.08.20 11:55, Stefan Reiter wrote:
> Start a VM with a 4097 byte image attached, add a 4096 byte granularity
> dirty bitmap, mark it dirty, and then do a backup.
>=20
> This used to run into an assert and fail, check that it works as
> expected and also check the created image to ensure that misaligned
> backups in general work correctly.
>=20
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>=20
> I saw Andrey's big series covering iotest 303 so I went for 304.

Works for me.

> Never submitted
> one before so I hope that's okay, if not feel free to renumber it.

Yep, if there=E2=80=99s a clash I tend to just renumber it when applying it=
.

>  tests/qemu-iotests/304     | 68 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/304.out |  2 ++
>  tests/qemu-iotests/group   |  1 +
>  3 files changed, 71 insertions(+)
>  create mode 100755 tests/qemu-iotests/304
>  create mode 100644 tests/qemu-iotests/304.out
>=20
> diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
> new file mode 100755
> index 0000000000..9a3b0224fa
> --- /dev/null
> +++ b/tests/qemu-iotests/304
> @@ -0,0 +1,68 @@
> +#!/usr/bin/env python3
> +#
> +# Tests dirty-bitmap backup with unaligned bitmap granularity
> +#
> +# Copyright (c) 2020 Proxmox Server Solutions
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
> +# owner=3Ds.reiter@proxmox.com
> +
> +import iotests
> +from iotests import qemu_img_create, qemu_img_log, file_path
> +
> +iotests.script_initialize(supported_fmts=3D['qcow2'],
> +                          supported_protocols=3D['file'])
> +
> +test_img =3D file_path('test.qcow2')
> +target_img =3D file_path('target.qcow2')
> +
> +# unaligned by one byte
> +image_len =3D 4097
> +bitmap_granularity =3D 4096
> +
> +qemu_img_create('-f', iotests.imgfmt, test_img, str(image_len))
> +
> +# create VM and add dirty bitmap
> +vm =3D iotests.VM().add_drive(test_img)
> +vm.launch()
> +
> +vm.qmp('block-dirty-bitmap-add', **{
> +    'node': 'drive0',
> +    'name': 'bitmap0',
> +    'granularity': bitmap_granularity
> +})
> +
> +# mark entire bitmap as dirty
> +vm.hmp_qemu_io('drive0', 'write -P0x16 0 4096');
> +vm.hmp_qemu_io('drive0', 'write -P0x17 4097 1');

s/4097/4096/?

(4097 works, too, because of something somewhere aligning up the 4097 to
512 byte sectors, I suppose, but I don=E2=80=99t think it=E2=80=99s the add=
ress you want
here)

> +
> +# do backup and wait for completion
> +vm.qmp('drive-backup', **{
> +    'device': 'drive0',
> +    'sync': 'full',
> +    'target': target_img,
> +    'bitmap': 'bitmap0',
> +    'bitmap-mode': 'on-success'

The bitmap is unnecessary, isn=E2=80=99t it?  I.e., if I drop the
block-dirty-bitmap-add call and the bitmap* parameters here, I still get
an assertion failure without patch 1.

Not that it really matters, it=E2=80=99s just that this makes it look like =
less
of an issue than it actually is.  (Which is why I=E2=80=99d drop the bitmap
stuff in case there=E2=80=99s no actual reason for it.)

> +})
> +
> +event =3D vm.event_wait(name=3D'BLOCK_JOB_COMPLETED',
> +                      match=3D{'data': {'device': 'drive0'}},
> +                      timeout=3D5.0)

(By the way, =E2=80=9Cvm.run_job('drive0', auto_dismiss=3DTrue)=E2=80=9D wo=
uld have worked
as well.  But since the backup job just needs waiting for a single
event, I suppose it doesn=E2=80=99t matter.  Just a hint in case you start
writing more iotests in the future.)

Max


--3BuiXYvDqr6xGWQxMDUN2wl5moHXZ8JxA--

--WwZSkP09Y8LVE4jLrxmHjmMAKqKWsBAqU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8xY4wACgkQ9AfbAGHV
z0Ba9wgAsvl8LBhowKf4fohi3/oUOBpxbqouPFrX8cdfuRpA34wJL5qN16kPXxhg
/4+mTiEBHjSBg+jc3InCXhzMfUGgqnA+hu6ZDoCMwPgTjPfj8zMYQuR20YxJpXDs
YlUSKbagS/E6S93mv765Jif+A19zUBDN6hJ8E/fCu6sA5vxbUO13o+PPcUvEqigQ
p9fHSl/kR3ymz/pemo7spJgUYs/t3/gguxwSeedYEY3LBb4Ibl+4Jw3gW9N0yQp+
30Ab0R7pNuR5Li/a9J5LwgRIzeHa4r4B+kGFHUukTDiLOtazMacxe3z4DIldxQWQ
Hwab2wwcHN39L7UW2vtjv9iPvKN+uA==
=Bo55
-----END PGP SIGNATURE-----

--WwZSkP09Y8LVE4jLrxmHjmMAKqKWsBAqU--


