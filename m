Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C666FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10962214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10962214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5OX-0006fp-58
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iL5Ne-0005nE-1I
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iL5Nc-0006d0-GD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 08:59:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iL5NY-0006b6-5n; Thu, 17 Oct 2019 08:59:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53B53307D96D;
 Thu, 17 Oct 2019 12:59:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-3.ams2.redhat.com
 [10.36.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 886505C1B5;
 Thu, 17 Oct 2019 12:59:39 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] iotests: Include QMP input in .out files
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191015193503.25591-1-eblake@redhat.com>
 <20191015193503.25591-3-eblake@redhat.com>
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
Message-ID: <0962fe1d-df21-0efb-818a-1afabdc4fcfe@redhat.com>
Date: Thu, 17 Oct 2019 14:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015193503.25591-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EQe0izuzArNOji8R3YLbiRUiqCGPwrLgb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 12:59:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EQe0izuzArNOji8R3YLbiRUiqCGPwrLgb
Content-Type: multipart/mixed; boundary="VGxpYuG7MSRwJTGT8c3UoGQIWmlHjRjKx"

--VGxpYuG7MSRwJTGT8c3UoGQIWmlHjRjKx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.19 21:35, Eric Blake wrote:
> We generally include relevant HMP input in .out files, by virtue of
> the fact that HMP echoes its input.  But QMP does not, so we have to
> explicitly inject it in the output stream, in order to make it easier
> to read .out files to see what behavior is being tested (especially
> true where the output file is a sequence of {'return': {}}).
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>

That was actually not my intention. :-)

I was thinking of a new parameter that enables this behavior and is
disabled by default so that existing tests don=E2=80=99t change.

But then again I did see that you interpreted my suggestion in a
slightly different way, and thought this is probably better, actually.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/common.qemu |  9 ++++
>  tests/qemu-iotests/085.out     | 26 ++++++++++
>  tests/qemu-iotests/094.out     |  4 ++
>  tests/qemu-iotests/095.out     |  2 +
>  tests/qemu-iotests/109.out     | 88 ++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/117.out     |  5 ++
>  tests/qemu-iotests/127.out     |  4 ++
>  tests/qemu-iotests/140.out     |  5 ++
>  tests/qemu-iotests/141.out     | 26 ++++++++++
>  tests/qemu-iotests/143.out     |  3 ++
>  tests/qemu-iotests/144.out     |  5 ++
>  tests/qemu-iotests/153.out     | 11 +++++
>  tests/qemu-iotests/156.out     | 11 +++++
>  tests/qemu-iotests/161.out     |  8 ++++
>  tests/qemu-iotests/173.out     |  4 ++
>  tests/qemu-iotests/182.out     |  8 ++++
>  tests/qemu-iotests/183.out     | 11 +++++
>  tests/qemu-iotests/185.out     | 18 +++++++
>  tests/qemu-iotests/191.out     |  8 ++++
>  tests/qemu-iotests/200.out     |  1 +
>  tests/qemu-iotests/223.out     | 19 ++++++++
>  tests/qemu-iotests/229.out     |  3 ++
>  tests/qemu-iotests/249.out     |  6 +++
>  23 files changed, 285 insertions(+)
> diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common=
=2Eqemu
> index 8d2021a7eb0c..abc231743e82 100644
> --- a/tests/qemu-iotests/common.qemu
> +++ b/tests/qemu-iotests/common.qemu
> @@ -123,6 +123,9 @@ _timed_wait_for()
>  # until either timeout, or a response.  If it is not set, or <=3D0,
>  # then the command is only sent once.
>  #
> +# If neither $silent nor $mismatch_only is set, and $cmd begins with '=
{',
> +# echo the command before sending it the first time.
> +#
>  # If $qemu_error_no_exit is set, then even if the expected response
>  # is not seen, we will not exit.  $QEMU_STATUS[$1] will be set it -1 i=
n
>  # that case.
> @@ -152,6 +155,12 @@ _send_qemu_cmd()
>          shift $(($# - 2))
>      fi
>=20
> +    # Display QMP being sent, but not HMP (since HMP already echoes it=
s
> +    # input back to output); decide based on leading '{'
> +    if [ -z "$silent" ] && [ -z "$mismatch_only" ] &&
> +            [ "$cmd" !=3D "${cmd#{}" ]; then

It=E2=80=99s a shame that this breaks syntax highlighting in (my) vim.  (=
Also I
have to admit googling to understand ${cmd#{} wasn=E2=80=99t trivial.)

Can I persuade you to use "${cmd#\{}" instead?  That seems to work for me=
=2E

> diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
> index f3b9ecf22b73..f3e1a9ecf736 100644
> --- a/tests/qemu-iotests/094.out
> +++ b/tests/qemu-iotests/094.out
> @@ -1,16 +1,20 @@
>  QA output created by 094
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>  Formatting 'TEST_DIR/source.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +{'execute': 'qmp_capabilities'}
>  {"return": {}}
> +{'execute': 'drive-mirror', 'arguments': {'device': 'src', 'target': '=
nbd:127.0.0.1:10810', 'format': 'nbd', 'sync':'full', 'mode':'existing'}}=


This reminds me that we need to fix nbd=E2=80=99s $TEST_IMG to not be fix=
ed to
port 10810.  I get intermittent failures because of that.

[...]

> diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
> index 67fe44a3e390..3857675f7ebd 100644
> --- a/tests/qemu-iotests/140.out
> +++ b/tests/qemu-iotests/140.out
> @@ -2,14 +2,19 @@ QA output created by 140
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{ 'execute': 'qmp_capabilities' }
>  {"return": {}}
> +{ 'execute': 'nbd-server-start', 'arguments': { 'addr': { 'type': 'uni=
x', 'data': { 'path': 'TEST_DIR/nbd' }}}}

Hmmmmm, this conflicts with my SOCK_DIR series.  common.qemu would then
also need a SOCK_DIR filter.  Well, or 140 should filter it (and the
other tests that are concerned).  I=E2=80=99m not 100 % sure, but a SOCK_=
DIR
filter in common.qemu probably can=E2=80=99t hurt.

>  {"return": {}}
> +{ 'execute': 'nbd-server-add', 'arguments': { 'device': 'drv' }}
>  {"return": {}}
>  read 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{ 'execute': 'eject', 'arguments': { 'device': 'drv' }}
>  {"return": {}}
>  qemu-io: can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: Requ=
ested export not available
>  server reported: export 'drv' not present
> +{ 'execute': 'quit' }
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
>  *** done
> diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
> index e3b578282da4..cb37ccd8ea42 100644
> --- a/tests/qemu-iotests/141.out
> +++ b/tests/qemu-iotests/141.out
> @@ -2,82 +2,108 @@ QA output created by 141
>  Formatting 'TEST_DIR/b.IMGFMT', fmt=3DIMGFMT size=3D1048576
>  Formatting 'TEST_DIR/m.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/b.IMGFMT
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/m.IMGFMT
> +{'execute': 'qmp_capabilities'}
>  {"return": {}}
>=20
>  =3D=3D=3D Testing drive-backup =3D=3D=3D
>=20
> +{'execute': 'blockdev-add', 'arguments': { 'node-name': 'drv0', 'drive=
r': 'qcow2', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.qcow2' }=
}}

141 also supports qed, so this then results in a mismatch.  I suppose
common.qemu should filter the image format.

(Same for 156, 161, and 229.)

[...]

> diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
> index 4c391a760371..d1865044f81a 100644
> --- a/tests/qemu-iotests/156.out
> +++ b/tests/qemu-iotests/156.out
> @@ -5,21 +5,27 @@ wrote 262144/262144 bytes at offset 0
>  256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote 196608/196608 bytes at offset 65536
>  192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +{ 'execute': 'qmp_capabilities' }
>  {"return": {}}
>  Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=3DIMGFMT size=3D1048576 ba=
cking_file=3DTEST_DIR/t.IMGFMT
> +{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'sourc=
e', 'snapshot-file': 'TEST_DIR/t.qcow2.overlay', 'format': 'qcow2', 'mode=
': 'existing' } }

Same here (as said above), although there=E2=80=99s also the fact to cons=
ider
that 156 supports generic protocols.  I hope _filter_testdir handles
that, though.

Max


--VGxpYuG7MSRwJTGT8c3UoGQIWmlHjRjKx--

--EQe0izuzArNOji8R3YLbiRUiqCGPwrLgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2oZboACgkQ9AfbAGHV
z0AG5Qf+PUPeOwwSAJpbVXZvTG69NnkEatio3C14uhgsVPsIzvxWzLSlfoW3fwpD
lfpSQwsTO+GUspoKtvnoz0BOc/yQWOIQ5UUPtZcItx+JrZk2tqOiHzcdGjTOzjDB
Y1ggQl4a1rO3kxvmgU2qmuO4DCAcXz2VilKa4XkOBZqggFjl+c6tQ6MWNDU8nPua
nUjCxHEmSGJk9cO1ywErkce/TCTGolsVXMLUbU32E1vfj6lOqQjTM6Q5mVI2McCH
dbbauHbNLjy2RVU7l69Wz/O2JUvgV0jKrkV/ZqHjF2f0yt3l3KjhssLgDvqarSMx
A4fzTh4vDI3uQ5MWURSEo5pz5uE6Ew==
=MHJO
-----END PGP SIGNATURE-----

--EQe0izuzArNOji8R3YLbiRUiqCGPwrLgb--

