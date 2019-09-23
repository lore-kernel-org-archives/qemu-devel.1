Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CECC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680CC2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 19:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680CC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCUOD-00038l-Jr
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 15:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iCUNF-0002c1-Iu
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iCUNE-00006c-8z
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 15:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iCUNB-00005Q-5p; Mon, 23 Sep 2019 15:51:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 66FE8308FBA9;
 Mon, 23 Sep 2019 19:51:48 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A88D19D70;
 Mon, 23 Sep 2019 19:51:44 +0000 (UTC)
Subject: Re: [PATCH v9 3/3] iotests: test nbd reconnect
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <7f0a7890-7b3d-9fd7-954d-389a8e28106f@redhat.com>
Date: Mon, 23 Sep 2019 14:51:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917171322.4127-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ardQwTDiQET4HsppFFtN8Qw00kPZZrhId"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 23 Sep 2019 19:51:48 +0000 (UTC)
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ardQwTDiQET4HsppFFtN8Qw00kPZZrhId
Content-Type: multipart/mixed; boundary="xeqlz3oG02LS99AhuecQlD9tDrfmsZzQd";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <7f0a7890-7b3d-9fd7-954d-389a8e28106f@redhat.com>
Subject: Re: [PATCH v9 3/3] iotests: test nbd reconnect
References: <20190917171322.4127-1-vsementsov@virtuozzo.com>
 <20190917171322.4127-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190917171322.4127-4-vsementsov@virtuozzo.com>

--xeqlz3oG02LS99AhuecQlD9tDrfmsZzQd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/17/19 12:13 PM, Vladimir Sementsov-Ogievskiy wrote:
> Add test, which starts backup to nbd target and restarts nbd server
> during backup.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/264        | 65 +++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/264.out    | 12 +++++++
>  tests/qemu-iotests/group      |  1 +
>  tests/qemu-iotests/iotests.py |  4 +++
>  4 files changed, 82 insertions(+)
>  create mode 100755 tests/qemu-iotests/264
>  create mode 100644 tests/qemu-iotests/264.out
>=20

> +import time
> +
> +import iotests
> +from iotests import qemu_img_create, file_path, qemu_nbd_popen, log
> +
> +disk_a, disk_b, nbd_sock =3D file_path('disk_a', 'disk_b', 'nbd-sock')=

> +
> +qemu_img_create('-f', iotests.imgfmt, disk_a, '5M')
> +qemu_img_create('-f', iotests.imgfmt, disk_b, '5M')
> +srv =3D qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
> +time.sleep(1)
> +

Hard-coded sleep times can be problematic (too long, and the test is no
longer quick; too short, and heavy load can interfere); is there any way
to poll for a completion event rather than just waiting one second?

> +vm =3D iotests.VM().add_drive(disk_a)
> +vm.launch()
> +vm.hmp_qemu_io('drive0', 'write 0 5M')
> +
> +vm.qmp_log('blockdev-add', filters=3D[iotests.filter_qmp_testfiles],
> +           **{'node_name': 'backup0',
> +              'driver': 'raw',
> +              'file': {'driver': 'nbd',
> +                       'server': {'type': 'unix', 'path': nbd_sock},
> +                       'reconnect-delay': 10}})
> +vm.qmp_log('blockdev-backup', device=3D'drive0', sync=3D'full', target=
=3D'backup0',
> +           speed=3D(1 * 1024 * 1024))

Throttling to make sure we are likely to still be going and thus test
the reconnect logic.

> +
> +time.sleep(1)
> +log('Kill NBD server')
> +srv.kill()

Again, that hard-coded sleep looks a bit risky.

> +
> +jobs =3D vm.qmp('query-block-jobs')['return']
> +if jobs and jobs[0]['offset'] < jobs[0]['len']:
> +    log('Backup job is still in progress')
> +
> +time.sleep(1)

Why do we need yet another sleep?

> +
> +log('Start NBD server')
> +srv =3D qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
> +
> +vm.qmp_log('block-job-set-speed', device=3D'drive0', speed=3D0)

So here, you release the throttle to finish the job.

> +e =3D vm.event_wait('BLOCK_JOB_COMPLETED')
> +log('Backup completed: {}'.format(e['data']['offset']))
> +
> +vm.qmp_log('blockdev-del', node_name=3D'backup0')
> +srv.kill()
> +vm.shutdown()
> diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
> new file mode 100644
> index 0000000000..4a2f4aa509
> --- /dev/null
> +++ b/tests/qemu-iotests/264.out
> @@ -0,0 +1,12 @@
> +{"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"d=
river": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nb=
d-sock", "type": "unix"}}, "node-name": "backup0"}}
> +{"return": {}}
> +{"execute": "blockdev-backup", "arguments": {"device": "drive0", "spee=
d": 1048576, "sync": "full", "target": "backup0"}}
> +{"return": {}}
> +Kill NBD server
> +Backup job is still in progress
> +Start NBD server
> +{"execute": "block-job-set-speed", "arguments": {"device": "drive0", "=
speed": 0}}
> +{"return": {}}
> +Backup completed: 5242880
> +{"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
> +{"return": {}}
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> index 5d3da937e4..4f6dd6f153 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -275,5 +275,6 @@
>  258 rw quick
>  262 rw quick migration
>  263 rw quick
> +264 rw quick

With that many hard-coded sleeps, is it still quick?

/me applies the patch and runs it...

264      pass       [14:49:55] [14:50:01]   6s

that's borderline enough that I would not call it quick.

> =20
> +def qemu_nbd_popen(*args):
> +    '''Run qemu-nbd in daemon mode and return the parent's exit code''=
'
> +    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(ar=
gs))
> +

Should you also use a pid file here, and wait for the existence of the
pid file before returning (rather than hard-coding sleep(1))?

>  def compare_images(img1, img2, fmt1=3Dimgfmt, fmt2=3Dimgfmt):
>      '''Return True if two image files are identical'''
>      return qemu_img('compare', '-f', fmt1,
>=20

At any rate,

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--xeqlz3oG02LS99AhuecQlD9tDrfmsZzQd--

--ardQwTDiQET4HsppFFtN8Qw00kPZZrhId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl2JIk8ACgkQp6FrSiUn
Q2q+gwf7B6DwqTuQYwnXIjUIUguj3rmF53hwtgRGHxnviPqrlIcY8zRTV6Us6IW4
EmrKSdkSCQvS/WvJejOrP/LxdbxK6Cs/xZ/otJH83slQbgpNA9ES68Z9lC34MU+1
G1kheFbBbf7VqMgX+7TvbuP1AHphj3HVAz1RX8AhXXuheAMz+3HW/oi5wUvnI9gb
SzYEPtGxF7xdYC+wHZO8ieB4VAXAASDObKNhTnmrklNu1fwQh5jOEZ9wxPXt4R4H
XeEb11lfp60GYhXGmWImZkNGJ6NeAJQRxa8WSalN5pV9DZ8IAixPgEmjlSk4yPI/
zxZRk/JX16+S0EaXkJndiH/qd91sGA==
=6ALO
-----END PGP SIGNATURE-----

--ardQwTDiQET4HsppFFtN8Qw00kPZZrhId--

