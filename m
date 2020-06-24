Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855B8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413742073E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 07:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INrdAMqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413742073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnzpn-0002ST-GM
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 03:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnzp8-0001yM-Fz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:27:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47133
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnzp5-0004jb-2G
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 03:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592983673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7zGBaYWvD4yYW1cSydLr2Chp9edkphrDYBge1lhXN2g=;
 b=INrdAMqkjtZaA19Hur3fUtL2iicB95vokGm/NjMraiYoZ6iedCzvFX8GKjW386+RuLTgFk
 7B4zDyQER6p0hm9ULsAyCuVPtdVWXLtUpB9uxp+Oog/v70VKKG+HVDs/Gx+wQOPldPICd6
 rkWHs3HIUNxrn03vVrZszfEbtWQiq00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-nwQ80D7wMaqn5knwulQqEw-1; Wed, 24 Jun 2020 03:27:48 -0400
X-MC-Unique: nwQ80D7wMaqn5knwulQqEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9138D1005512;
 Wed, 24 Jun 2020 07:27:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-239.ams2.redhat.com
 [10.36.113.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10CA2610FD;
 Wed, 24 Jun 2020 07:27:45 +0000 (UTC)
Subject: Re: [PULL 00/18] Block patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200622151059.921191-1-mreitz@redhat.com>
 <CAFEAcA-QDYBf4COqrLmeO_v-gt6rq_J3rs6YexHGjCGTokVvDQ@mail.gmail.com>
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
Message-ID: <8bed1833-3a47-ece9-2b5d-23881fa5a238@redhat.com>
Date: Wed, 24 Jun 2020 09:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-QDYBf4COqrLmeO_v-gt6rq_J3rs6YexHGjCGTokVvDQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z9v5aWgLCDcFT0QQawrSWlDc4l7SL9KJA"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z9v5aWgLCDcFT0QQawrSWlDc4l7SL9KJA
Content-Type: multipart/mixed; boundary="mcUzdhz8hl5VbqHIR6D1pBzO4hhF7D8Vi"

--mcUzdhz8hl5VbqHIR6D1pBzO4hhF7D8Vi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.06.20 14:55, Peter Maydell wrote:
> On Mon, 22 Jun 2020 at 16:11, Max Reitz <mreitz@redhat.com> wrote:
>>
>> The following changes since commit bae31bfa48b9caecee25da3d5333901a126a0=
6b4:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200619-pull-=
request' into staging (2020-06-19 22:56:59 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/XanClic/qemu.git tags/pull-block-2020-06-22
>>
>> for you to fetch changes up to 74c55e4142a7bb835c38d3770c74210cbb1e4fab:
>>
>>   iotests: don't test qcow2.py inside 291 (2020-06-22 16:05:23 +0200)
>>
>> ----------------------------------------------------------------
>> Block patches:
>> - Support modifying a LUKS-encrypted image's keyslots
>> - iotest fixes
>>
>> ----------------------------------------------------------------
>=20
> Hi; I see various iotest failures, different things on
> PPC64 Linux, OpenBSD and FreeBSD, and on an AArch32 build
> that happens to not have optional crypto libs installed.

OK.  Sorry.  None of this looks easily fixable, so I suppose I=E2=80=99ll h=
ave
to drop everything but the last two patches for now.

> On PPC64 Linux, lots of iotests fail like this:
>=20
>   TEST    iotest-qcow2: 001 [fail]
> QEMU          --
> "/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-s=
ystem-ppc64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qem=
u-img"
> QEMU_IO       --
> "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
> writeback --aio threads -f qcow2
> QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qem=
u-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
> TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.vvBdnkatyZ
> SOCKET_SCM_HELPER --
> /home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper
>=20
> --- /home/pm215/qemu/tests/qemu-iotests/001.out 2015-04-08
> 18:43:24.908449234 +0000
> +++ /home/pm215/qemu/build/all/tests/qemu-iotests/001.out.bad
> 2020-06-23 10:42:29.262626202 +0000
> @@ -1,5 +1,6 @@
>  QA output created by 001
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
> +./common.filter: line 128: readarray: -d: invalid option
> +readarray: usage: readarray [-n count] [-O origin] [-s count] [-t]
> [-u fd] [-C callback] [-c quantum] [array]
>=20
>  =3D=3D reading whole image =3D=3D
>  read 134217728/134217728 bytes at offset 0
>   TEST    iotest-qcow2: 002 [fail]
> QEMU          --
> "/home/pm215/qemu/build/all/tests/qemu-iotests/../../ppc64-softmmu/qemu-s=
ystem-ppc64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qem=
u-img"
> QEMU_IO       --
> "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qemu-io"  --cache
> writeback --aio threads -f qcow2
> QEMU_NBD      -- "/home/pm215/qemu/build/all/tests/qemu-iotests/../../qem=
u-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/ppc64 gcc1-power7 3.10.0-862.14.4.el7.ppc64
> TEST_DIR      -- /home/pm215/qemu/build/all/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.vvBdnkatyZ
> SOCKET_SCM_HELPER --
> /home/pm215/qemu/build/all/tests/qemu-iotests/socket_scm_helper
>=20
> Looks like you're trying to use a readarray option that doesn't
> exist (maybe only exists in newer shells?)

Yes, I am.  Well, that=E2=80=99s a real shame. :/

I wasn=E2=80=99t aware that readarray=E2=80=99s -d option was only introduc=
ed at some
later point.  Looks like that happened in 4.4, which was only released
2016.  So that=E2=80=99s probably too new indeed.

> iotests failures on aarch32 which happens to not have some
> optional crypto lib dependency installed I guess; these
> iotests ought to be made to skip if the functionality they're
> testing isn't compiled into this QEMU:

Right.  Maxim, can you do that?

>   TEST    iotest-qcow2: 293 [fail]
> QEMU          --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../aarch64-=
softmmu/qemu-system-aarch64"
> -nodefaults -display none -machine virt -accel qtest
> QEMU_IMG      --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-img=
"
> QEMU_IO       --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-io"
>  --cache writeback --aio threads -f qcow2
> QEMU_NBD      --
> "/home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/../../qemu-nbd=
"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/aarch64 mustang-maydell 4.15.0-101-generic
> TEST_DIR      --
> /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.tjBWiNDvED
> SOCKET_SCM_HELPER --
> /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/socket_scm_help=
er
>=20
> --- /home/peter.maydell/qemu/tests/qemu-iotests/293.out 2020-06-23
> 10:38:50.091867725 +0000
> +++ /home/peter.maydell/qemu/build/all-a32/tests/qemu-iotests/293.out.bad
>       2020-06-23 10:59:09.027627162 +0000
> @@ -1,5 +1,6 @@
>  QA output created by 293
>  =3D=3D creating a test image =3D=3D
> +qemu-img: TEST_DIR/t.IMGFMT: No crypto library supporting PBKDF in
> this build: Function not implemented
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
>=20
>  =3D=3D test that key 0 opens the image =3D=3D
> @@ -7,10 +8,15 @@
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>=20
>  =3D=3D adding a password to slot 4 =3D=3D
> +qemu-img: Can't amend encryption options - encryption not present
>  =3D=3D adding a password to slot 1 =3D=3D
> +qemu-img: Can't amend encryption options - encryption not present
>  =3D=3D adding a password to slot 3 =3D=3D
> +qemu-img: Can't amend encryption options - encryption not present
>  =3D=3D adding a password to slot 2 =3D=3D
> +qemu-img: Can't amend encryption options - encryption not present
>  =3D=3D erase slot 4 =3D=3D
> +qemu-img: Can't amend encryption options - encryption not present
>=20
>  =3D=3D all secrets should work =3D=3D
>  read 4096/4096 bytes at offset 0
> @@ -23,19 +29,29 @@
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>=20
>  =3D=3D erase slot 0 and try it =3D=3D
> -qemu-io: can't open: Invalid password, cannot unlock any keyslot
> +qemu-img: Can't amend encryption options - encryption not present
> +read 4096/4096 bytes at offset 0
> +4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> [etc]
>=20
>=20
> On OpenBSD: iotest 293 fails trying to use "seq" when it doesn't exist:

Well that=E2=80=99s nice.  Maxim, I think we=E2=80=99ll need a for (()) loo=
p then (like
e.g. tests/qemu-iotests/common.pattern:25 does it).

>   TEST    iotest-qcow2: 293 [fail]
> QEMU          --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../aarch64-softm=
mu/qemu-system-aarch64"
> -nodef
> aults -display none -machine virt -accel qtest
> QEMU_IMG      --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-io"
> --cache writeback --aio threads -
> f qcow2
> QEMU_NBD      --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- OpenBSD/amd64 openbsd 6.6
> TEST_DIR      -- /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/scr=
atch
> SOCK_DIR      -- /tmp/tmp.o4s3SCLIsx
> SOCKET_SCM_HELPER --
>=20
> --- /home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/293.out  Tue
> Jun 23 10:38:33 2020
> +++ /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/293.out.bad
>  Tue Jun 23 11:06:19 2020
> @@ -1,6 +1,6 @@
>  QA output created by 293
>  =3D=3D creating a test image =3D=3D
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
> +Formatting 'TEST_DIR/t.IMGFMT'x0IMGFMT encrypt.format=3Dluks
> encrypt.key-secret=3Dsec0 encrypt.iter-time=3D10 cluster_size=3D65
> 536 compression_type=3Dzlib size=3D33554432 compat=3D1.1 lazy_refcounts=
=3Doff
> refcount_bits=3D16
>=20
>  =3D=3D test that key 0 opens the image =3D=3D
>  read 4096/4096 bytes at offset 0
> @@ -29,25 +29,26 @@
>  qemu-io: can't open: Invalid password, cannot unlock any keyslot
>=20
>  =3D=3D filling  4 slots with secret 2 =3D=3D
> +./293: line 111: seq: command not found
>=20
>  =3D=3D adding secret 0 =3D=3D
>=20
>  =3D=3D adding secret 3 (last slot) =3D=3D
>=20
>  =3D=3D trying to add another slot (should fail) =3D=3D
> -qemu-img: Can't add a keyslot - all keyslots are in use
> +qemu-img: Could not open
> 'driver=3Dqcow2,file.filename=3D/home/qemu/qemu-test.DyTmtb/build/tests/q=
emu-iotests/scratch/t.qco
> w2,encrypt.key-secret=3Dsec2': Invalid password, cannot unlock any keyslo=
t
>=20
>  =3D=3D all secrets should work again =3D=3D
>  read 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +qemu-io: can't open: Invalid password, cannot unlock any keyslot
>  read 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -read 4096/4096 bytes at offset 0
> -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>=20
>  =3D=3D erase all keys of secret 2=3D=3D
> +qemu-img: No keyslots match given (old) password for erase operation
>  =3D=3D erase all keys of secret 1=3D=3D
>  =3D=3D erase all keys of secret 0=3D=3D
>  =3D=3D erasing secret3 will fail now since it is the only secret (in 3 s=
lots) =3D=3D
>=20
> Also OpenBSD, iotest 295 failed because the QEMU dumped core:

I assume the SIGKILL occurred because 295 somewhere waits on some QMP
event that never happens (probably because the encryption is again not
supported), so the iotest kills it on timeout.

(Maxim, I think that we=E2=80=99ll need something similar to what we need i=
n 293
to skip the test if there=E2=80=99s no crypto library.)

>   TEST    iotest-qcow2: 295 [fail]
> QEMU          --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../aarch64-softm=
mu/qemu-system-aarch64"
> -nodef
> aults -display none -machine virt -accel qtest
> QEMU_IMG      --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-io"
> --cache writeback --aio threads -
> f qcow2
> QEMU_NBD      --
> "/home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- OpenBSD/amd64 openbsd 6.6
> TEST_DIR      -- /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/scr=
atch
> SOCK_DIR      -- /tmp/tmp.o4s3SCLIsx
> SOCKET_SCM_HELPER --
>=20
> --- /home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/295.out  Tue
> Jun 23 10:38:33 2020
> +++ /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/295.out.bad
>  Tue Jun 23 11:09:01 2020
> @@ -4,19 +4,11 @@
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
>  {"return": {}}
> +WARNING:qemu.machine:qemu received signal 9:
> /home/qemu/qemu-test.DyTmtb/build/tests/qemu-iotests/../../aarch64-softmm=
u/qemu-system-aarch64
> -display none -vga none -chardev
> socket,id=3Dmon,path=3D/tmp/tmp.o4s3SCLIsx/qemu-36824-monitor.sock -mon
> chardev=3Dmon,mode=3Dcontrol -qtest
> unix:path=3D/tmp/tmp.o4s3SCLIsx/qemu-36824-qtest.sock -accel qtest
> -nodefaults -display none -machine virt -accel qtest
>  {"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
>  {"return": {}}
> -{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
> -{"return": {}}
> -Job failed: Invalid password, cannot unlock any keyslot
>  {"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
>  {"return": {}}
> -{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
> -{"return": {}}
> -{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
> -{"return": {}}
> -{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
> -{"return": {}}
>  Job failed: Refusing to overwrite active keyslot 2 - please erase it fir=
st
>  {"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
>  {"return": {}}
> @@ -33,8 +25,37 @@
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
>  {"return": {}}
> -...
> +.E.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ERROR: testOldPassword (__main__.EncryptionSetupTestCase)
>  ----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/=
qemu/qmp.py",
> line 139, in __get_events
> +    ret =3D self.__json_read(only_event=3DTrue)
> +  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/=
qemu/qmp.py",
> line 99, in __json_read
> +    data =3D self.__sockfile.readline()
> +  File "/usr/local/lib/python3.7/socket.py", line 589, in readinto
> +    return self._sock.recv_into(b)
> +socket.timeout: timed out
> +
> +During handling of the above exception, another exception occurred:
> +
> +Traceback (most recent call last):
> +  File "295", line 234, in testOldPassword
> +    self.addKeyQmp("testdev", new_secret =3D self.secrets[1])
> +  File "295", line 164, in addKeyQmp
> +    self.vm.run_job('job_add_key')
> +  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/iotests.py",
> line 648, in run_job
> +    ev =3D filter_qmp_event(self.events_wait(events, timeout=3Dwait))
> +  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/=
qemu/machine.py",
> line 518, in events_wait
> +    event =3D self._qmp.pull_event(wait=3Dtimeout)
> +  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/=
qemu/qmp.py",
> line 254, in pull_event
> +    self.__get_events(wait)
> +  File "/home/qemu/qemu-test.DyTmtb/src/tests/qemu-iotests/../../python/=
qemu/qmp.py",
> line 141, in __get_events
> +    raise QMPTimeoutError("Timeout waiting for event")
> +qemu.qmp.QMPTimeoutError: Timeout waiting for event
> +
> +----------------------------------------------------------------------
>  Ran 3 tests
>=20
> -OK
> +FAILED (errors=3D1)
>=20
> FreeBSD: lots of iotest failures, looks like some sed or other
> command trying to sanitize output is broken on this host OS
> (assuming gnu sed or whatever, maybe?)

It=E2=80=99s assuming that \x0 produces a NUL character.  It=E2=80=99s a sh=
ame it
doesn=E2=80=99t, but I suppose it doesn=E2=80=99t even really matter withou=
t readarray
supporting -d.

>   TEST    iotest-qcow2: 001 [fail]
> QEMU          --
> "/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../aarch64-softm=
mu/qemu-system-aarch64"
> -nodefaults -display none -machine virt -accel qtest
> QEMU_IMG      --
> "/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../qemu-io"
> --cache writeback --aio threads -f qcow2
> QEMU_NBD      --
> "/home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- FreeBSD/amd64 freebsd 12.1-RELEASE
> TEST_DIR      -- /home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/scr=
atch
> SOCK_DIR      -- /tmp/tmp.l5ksaQ9N
> SOCKET_SCM_HELPER --
>=20
> --- /home/qemu/qemu-test.RNYtim/src/tests/qemu-iotests/001.out
> 2020-06-23 10:38:33.000000000 +0000
> +++ /home/qemu/qemu-test.RNYtim/build/tests/qemu-iotests/001.out.bad
>  2020-06-23 10:56:47.833020000 +0000
> @@ -1,5 +1,5 @@
>  QA output created by 001
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
> +Formatting 'TEST_DIR/t.IMGFMT'x0IMGFMT cluster_size=3D65536
> compression_type=3Dzlib size=3D134217728 compat=3D1.1 lazy_refcounts=3Dof=
f
> refcount_bits=3D16
>=20
>  =3D=3D reading whole image =3D=3D
>  read 134217728/134217728 bytes at offset 0
>=20
>=20
> thanks

Thank you!

Max


--mcUzdhz8hl5VbqHIR6D1pBzO4hhF7D8Vi--

--Z9v5aWgLCDcFT0QQawrSWlDc4l7SL9KJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7zAG8ACgkQ9AfbAGHV
z0Bz8QgAwg6/NX4BVNODWm5cEFICGqDvVZy+WCKwvCq+5COzLKvSN09uLNXtSoCV
Sw2cGdO+r4aDPNMFD8akyP/XutBz7LITd/9dSvUfoh+3rHQ80NFZTJgdgV3g7mVQ
XpsEj70j95/iaK6ve8UnD4chSl062v7Ea1zJEK4qpL33dg1rjar8QnzYZyQF9NKS
daWo0u8W7WPcpYD5HwlXFPJeDSnwPhRJLPtLvlVzisBMCIHWSO1Ys/LnYvNCh1cK
Yk2M8do1VlxLQ2qitYqghgQ8NkVaGqc/2JyvvAtybSVhxCeAIr7JSjZCc6Mfbx0w
oTVcTuVtjXPn4bcUlzUD6Ggb33o6fA==
=bEI/
-----END PGP SIGNATURE-----

--Z9v5aWgLCDcFT0QQawrSWlDc4l7SL9KJA--


