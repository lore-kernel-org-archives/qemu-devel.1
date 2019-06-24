Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF7CC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA37C205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA37C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51968 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQKn-000770-Sv
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60723)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfQHs-0004DF-QZ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfQHn-0000dH-Up
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfQHX-0000G5-L5; Mon, 24 Jun 2019 10:49:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2FB2031628FA;
 Mon, 24 Jun 2019 14:49:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-152.brq.redhat.com
 [10.40.204.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDADE1974A;
 Mon, 24 Jun 2019 14:49:08 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>
References: <20190621132324.2165-1-mreitz@redhat.com>
 <CAFEAcA9tPUcZ5BZmasT=GpccGw1EAqMTHRJhsq9cGZjJUhGs=Q@mail.gmail.com>
 <4f34c316-2d5a-4d0c-ab3b-2c85b1a9e22f@redhat.com>
 <5873173.t2JhDm7DL7@lindworm.usersys.redhat.com>
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
Message-ID: <b9afaae4-78d2-8ce6-c8b7-3b687ee94e1f@redhat.com>
Date: Mon, 24 Jun 2019 16:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5873173.t2JhDm7DL7@lindworm.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ERTPn0iR7ysmlj9IzgBEhDJXvGGWjo4Vy"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 24 Jun 2019 14:49:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/8] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ERTPn0iR7ysmlj9IzgBEhDJXvGGWjo4Vy
Content-Type: multipart/mixed; boundary="g1pO0uhyBPXQHWjIYZ1saADA99NLSzJYQ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <b9afaae4-78d2-8ce6-c8b7-3b687ee94e1f@redhat.com>
Subject: Re: [PULL 0/8] Block patches
References: <20190621132324.2165-1-mreitz@redhat.com>
 <CAFEAcA9tPUcZ5BZmasT=GpccGw1EAqMTHRJhsq9cGZjJUhGs=Q@mail.gmail.com>
 <4f34c316-2d5a-4d0c-ab3b-2c85b1a9e22f@redhat.com>
 <5873173.t2JhDm7DL7@lindworm.usersys.redhat.com>
In-Reply-To: <5873173.t2JhDm7DL7@lindworm.usersys.redhat.com>

--g1pO0uhyBPXQHWjIYZ1saADA99NLSzJYQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.06.19 15:15, Pino Toscano wrote:
> On Monday, 24 June 2019 14:20:11 CEST Max Reitz wrote:
>> On 23.06.19 19:18, Peter Maydell wrote:
>>> On Fri, 21 Jun 2019 at 14:23, Max Reitz <mreitz@redhat.com> wrote:
>>>>
>>>> The following changes since commit 33d609990621dea6c7d056c86f707b881=
1320ac1:
>>>>
>>>>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' int=
o staging (2019-06-18 17:00:52 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   https://github.com/XanClic/qemu.git tags/pull-block-2019-06-21
>>>>
>>>> for you to fetch changes up to e2a76186f7948b8b75d1b2b52638de7c2f7f7=
472:
>>>>
>>>>   iotests: Fix 205 for concurrent runs (2019-06-21 14:40:28 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> Block patches:
>>>> - The SSH block driver now uses libssh instead of libssh2
>>>> - The VMDK block driver gets read-only support for the seSparse
>>>>   subformat
>>>> - Various fixes
>>>>
>>>
>>> Hi; this failed to build on my s390 box:
>>>
>>> /home/linux1/qemu/block/ssh.c: In function =E2=80=98check_host_key_kn=
ownhosts=E2=80=99:
>>> /home/linux1/qemu/block/ssh.c:367:27: error: implicit declaration of
>>> function =E2=80=98ssh_get_fingerprint_hash=E2=80=99
>>> [-Werror=3Dimplicit-function-declaration]
>>>              fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_H=
ASH_SHA1,
>>>                            ^
>>> /home/linux1/qemu/block/ssh.c:367:13: error: nested extern declaratio=
n
>>> of =E2=80=98ssh_get_fingerprint_hash=E2=80=99 [-Werror=3Dnested-exter=
ns]
>>>              fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_H=
ASH_SHA1,
>>>              ^
>>> /home/linux1/qemu/block/ssh.c:367:25: error: assignment makes pointer=

>>> from integer without a cast [-Werror=3Dint-conversion]
>>>              fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_H=
ASH_SHA1,
>>>                          ^
>>>
>>> It looks like that function was introduced in libssh 0.8.3, and this =
box
>>> has 0.6.3. (configure has correctly not defined HAVE_LIBSSH_0_8
>>> but this usage is inside a bit of code that's compiled even when
>>> that is not defined.)
>=20
> Oops, sorry, I did not test the latest versions with that old libssh.
>=20
>> Pino, would you be OK with dropping that piece of code for pre-0.8 and=

>> just replacing it with the else-error_setg()?
>=20
> Some the variables in check_host_key_knownhosts must be moved within
> the HAVE_LIBSSH_0_8 block now; attached fixup patch, please squash with=

> my patch (I can submit a v12, if needed/wanted).

Thanks, I=E2=80=99ve squashed it in and sent a v2 for this pull request.

Max


--g1pO0uhyBPXQHWjIYZ1saADA99NLSzJYQ--

--ERTPn0iR7ysmlj9IzgBEhDJXvGGWjo4Vy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Q4uIACgkQ9AfbAGHV
z0AFagf/RutGOQ1Ha7CdqcUE434dnkgqWJfVIDsiYI4T9FADxtUpy84TFDbNV306
fDlXAyuhldg1wkAH+xFRu3sQIDbugyhdz0AFnH9s86pGAQFeMQS+XRI2pnvpGT82
Ea4qF3BdISM8sobOU6VS9M+6HlPjDMAZQN7mgr5WA0RfpsgOlHKr/NFxRiGnl+wW
9n1gZhHku/qFp1uZTz9xRUy3FeihATPzlNdqiKnr2+rZUEbdPCUyjTasY9wdIDBr
hFIHnF71tSO79EmFcM+rXQlXSI8PmMB+AFHwgkpar4ziEIIYpS0kWjFBJBOkuPvN
/v3PAsau56P52gO+bZrov0uEHeiouQ==
=4fSr
-----END PGP SIGNATURE-----

--ERTPn0iR7ysmlj9IzgBEhDJXvGGWjo4Vy--

