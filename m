Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1E9C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E98D2339E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 23:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E98D2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i36v3-0007QB-LY
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 19:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i36uA-0006mx-PT
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 18:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i36u8-0000Ba-Hg
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 18:59:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i36u2-00005m-8A; Wed, 28 Aug 2019 18:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C67BA18B3D85;
 Wed, 28 Aug 2019 22:58:56 +0000 (UTC)
Received: from [10.18.17.85] (dhcp-17-85.bos.redhat.com [10.18.17.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A08B5D9E2;
 Wed, 28 Aug 2019 22:58:55 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1566834628-485525-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1566834628-485525-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d04202ac-87ab-f226-0fc9-490d20f571fd@redhat.com>
Date: Wed, 28 Aug 2019 18:58:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566834628-485525-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Wed, 28 Aug 2019 22:58:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 1/6] iotests: allow Valgrind checking
 all QEMU processes
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/26/19 11:50 AM, Andrey Shinkevich wrote:
> With the '-valgrind' option, let all the QEMU processes be run under
> the Valgrind tool. The Valgrind own parameters may be set with its
> environment variable VALGRIND_OPTS, e.g.
> $ VALGRIND_OPTS=3D"--leak-check=3Dyes" ./check -valgrind <test#>
> or they may be listed in the Valgrind checked file ./.valgrindrc or
> ~/.valgrindrc like
> --memcheck:leak-check=3Dno
> --memcheck:track-origins=3Dyes
> To exclude a specific process from running under the Valgrind, the
> corresponding environment variable VALGRIND_QEMU_<name> is to be unset:
> $ VALGRIND_QEMU_IO=3D ./check -valgrind <test#>
> When QEMU-IO process is being killed, the shell report refers to the
> text of the command in _qemu_io_wrapper(), which was modified with this
> patch. So, the benchmark output for the tests 039, 061 and 137 is to be
> changed also.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/039.out   |  30 ++----------
>  tests/qemu-iotests/061.out   |  12 +----
>  tests/qemu-iotests/137.out   |   6 +--
>  tests/qemu-iotests/common.rc | 107 +++++++++++++++++++++++++++++++++++=
--------
>  4 files changed, 97 insertions(+), 58 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index 724d7b2..66d2159 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -11,11 +11,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  incompatible_features     0x1
>  ERROR cluster 5 refcount=3D0 reference=3D1
>  ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D=
0
> @@ -50,11 +46,7 @@ read 512/512 bytes at offset 0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  incompatible_features     0x1
>  ERROR cluster 5 refcount=3D0 reference=3D1
>  Rebuilding refcount structure
> @@ -68,11 +60,7 @@ incompatible_features     0x0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  incompatible_features     0x0
>  No errors were found on the image.
> =20
> @@ -91,11 +79,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  incompatible_features     0x1
>  ERROR cluster 5 refcount=3D0 reference=3D1
>  ERROR OFLAG_COPIED data cluster: l2_entry=3D8000000000050000 refcount=3D=
0
> @@ -105,11 +89,7 @@ Data may be corrupted, or further writes to the ima=
ge may corrupt it.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  incompatible_features     0x0
>  No errors were found on the image.
>  *** done
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 1aa7d37..346e654 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -118,11 +118,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>  wrote 131072/131072 bytes at offset 0
>  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  magic                     0x514649fb
>  version                   3
>  backing_file_offset       0x0
> @@ -280,11 +276,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>  wrote 131072/131072 bytes at offset 0
>  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  magic                     0x514649fb
>  version                   3
>  backing_file_offset       0x0
> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index 22d59df..225e6f6 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -35,11 +35,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D=
67108864
>  qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. A=
llowed are any of the following: none, constant, cached, all
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" =3D=3D =
"y" ]; then
> -    exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitcode=3D=
99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( VALGRIND_QEMU=3D"${VALGRIND_ON}=
" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@=
" )
>  incompatible_features     0x0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>  wrote 65536/65536 bytes at offset 0
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.r=
c
> index 5502c3d..289686b 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -60,61 +60,132 @@ if ! . ./common.config
>      exit 1
>  fi
> =20
> +# Unset the variables to turn Valgrind off for specific processes, e.g=
.
> +# $ VALGRIND_QEMU_IO=3D ./check -qcow2 -valgrind 015
> +
> +: ${VALGRIND_QEMU_VM=3D'y'}
> +: ${VALGRIND_QEMU_IMG=3D'y'}
> +: ${VALGRIND_QEMU_IO=3D'y'}
> +: ${VALGRIND_QEMU_NBD=3D'y'}
> +: ${VALGRIND_QEMU_VXHS=3D'y'}
> +

I have to admit to you that I'm not familiar with this trick. I'm
looking it up and I see :=3D documented, but not =3D alone.

It doesn't seem documented here at all:
https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expans=
ion.html

I see it here, though:
https://www.tldp.org/LDP/abs/html/parameter-substitution.html

And it seems to work, but I'm not sure if this works with BSD or OSX's
sh. I see Eric comment on that compatibility a lot, so maybe I'll let
him chime in.

The other option, if this is not portable, is to have a NO_VALGRIND_XYZ
variable that can be set by the user and checked instead without needing
to set a default.


> +# The Valgrind own parameters may be set with
> +# its environment variable VALGRIND_OPTS, e.g.
> +# $ VALGRIND_OPTS=3D"--leak-check=3Dyes" ./check -qcow2 -valgrind 015
> +
> +_qemu_proc_exec()
> +{
> +    local VALGRIND_LOGFILE=3D"$1"
> +    shift
> +    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
> +        exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-exitc=
ode=3D99 "$@"
> +    else
> +        exec "$@"
> +    fi
> +}
> +
> +_qemu_proc_valgrind_log()
> +{
> +    local VALGRIND_LOGFILE=3D"$1"
> +    local RETVAL=3D"$2"
> +    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
> +        if [ $RETVAL =3D=3D 99 ]; then
> +            cat "${VALGRIND_LOGFILE}"
> +        fi
> +        rm -f "${VALGRIND_LOGFILE}"
> +    fi
> +}
> +
>  _qemu_wrapper()
>  {
> +    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
> +    local VALGRIND_ON=3D"${VALGRIND_QEMU}"
> +    if [ "${VALGRIND_QEMU_VM}" !=3D "y" ]; then
> +        VALGRIND_ON=3D''
> +    fi
>      (
>          if [ -n "${QEMU_NEED_PID}" ]; then
>              echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid=
"
>          fi
> -        exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
> +        VALGRIND_QEMU=3D"${VALGRIND_ON}" _qemu_proc_exec "${VALGRIND_L=
OGFILE}" \
> +            "$QEMU_PROG" $QEMU_OPTIONS "$@"
>      )
> +    RETVAL=3D$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
> =20
>  _qemu_img_wrapper()
>  {
> -    (exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@")
> +    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
> +    local VALGRIND_ON=3D"${VALGRIND_QEMU}"
> +    if [ "${VALGRIND_QEMU_IMG}" !=3D "y" ]; then
> +        VALGRIND_ON=3D''
> +    fi
> +    (
> +        VALGRIND_QEMU=3D"${VALGRIND_ON}" _qemu_proc_exec "${VALGRIND_L=
OGFILE}" \
> +            "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@"
> +    )
> +    RETVAL=3D$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
> =20
>  _qemu_io_wrapper()
>  {
>      local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
>      local QEMU_IO_ARGS=3D"$QEMU_IO_OPTIONS"
> +    local VALGRIND_ON=3D"${VALGRIND_QEMU}"
> +    if [ "${VALGRIND_QEMU_IO}" !=3D "y" ]; then
> +        VALGRIND_ON=3D''
> +    fi
>      if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>          QEMU_IO_ARGS=3D"--image-opts $QEMU_IO_ARGS"
>          if [ -n "$IMGKEYSECRET" ]; then
>              QEMU_IO_ARGS=3D"--object secret,id=3Dkeysec0,data=3D$IMGKE=
YSECRET $QEMU_IO_ARGS"
>          fi
>      fi
> -    local RETVAL
>      (
> -        if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
> -            exec valgrind --log-file=3D"${VALGRIND_LOGFILE}" --error-e=
xitcode=3D99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
> -        else
> -            exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
> -        fi
> +        VALGRIND_QEMU=3D"${VALGRIND_ON}" _qemu_proc_exec "${VALGRIND_L=
OGFILE}" \
> +            "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
>      )
>      RETVAL=3D$?
> -    if [ "${VALGRIND_QEMU}" =3D=3D "y" ]; then
> -        if [ $RETVAL =3D=3D 99 ]; then
> -            cat "${VALGRIND_LOGFILE}"
> -        fi
> -        rm -f "${VALGRIND_LOGFILE}"
> -    fi
> -    (exit $RETVAL)
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
> =20
>  _qemu_nbd_wrapper()
>  {
> -    "$QEMU_NBD_PROG" --pid-file=3D"${QEMU_TEST_DIR}/qemu-nbd.pid" \
> -                     $QEMU_NBD_OPTIONS "$@"
> +    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
> +    local VALGRIND_ON=3D"${VALGRIND_QEMU}"
> +    if [ "${VALGRIND_QEMU_NBD}" !=3D "y" ]; then
> +        VALGRIND_ON=3D''
> +    fi
> +    (
> +        VALGRIND_QEMU=3D"${VALGRIND_ON}" _qemu_proc_exec "${VALGRIND_L=
OGFILE}" \
> +            "$QEMU_NBD_PROG" --pid-file=3D"${QEMU_TEST_DIR}/qemu-nbd.p=
id" \
> +             $QEMU_NBD_OPTIONS "$@"
> +    )
> +    RETVAL=3D$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
> =20
>  _qemu_vxhs_wrapper()
>  {
> +    local VALGRIND_LOGFILE=3D"${TEST_DIR}"/$$.valgrind
> +    local VALGRIND_ON=3D"${VALGRIND_QEMU}"
> +    if [ "${VALGRIND_QEMU_VXHS}" !=3D "y" ]; then
> +        VALGRIND_ON=3D''
> +    fi
>      (
>          echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
> -        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
> +        VALGRIND_QEMU=3D"${VALGRIND_ON}" _qemu_proc_exec "${VALGRIND_L=
OGFILE}" \
> +            "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
>      )
> +    RETVAL=3D$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
> =20
>  export QEMU=3D_qemu_wrapper
>=20

--=20
=E2=80=94js

