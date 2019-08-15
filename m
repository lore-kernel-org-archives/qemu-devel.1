Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA4AC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CBB8206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 22:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CBB8206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyOZL-0002e0-C4
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 18:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hyOYh-00029Y-BN
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hyOYf-0001gQ-Gy
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 18:49:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53684)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hyOYa-0001ey-UM; Thu, 15 Aug 2019 18:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E92E681F31;
 Thu, 15 Aug 2019 22:49:19 +0000 (UTC)
Received: from [10.18.17.169] (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98B825C219;
 Thu, 15 Aug 2019 22:49:18 +0000 (UTC)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1563553816-148827-2-git-send-email-andrey.shinkevich@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e1448863-8133-dec0-bce3-7b13664deb6b@redhat.com>
Date: Thu, 15 Aug 2019 18:49:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563553816-148827-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 22:49:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 1/6] iotests: allow
 Valgrind checking all QEMU processes
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



On 7/19/19 12:30 PM, Andrey Shinkevich wrote:
> With the '-valgrind' option, let all the QEMU processes be run under
> the Valgrind tool. The Valgrind own parameters may be set with its
> environment variable VALGRIND_OPTS, e.g.
> VALGRIND_OPTS="--leak-check=yes" ./check -qcow2 -valgrind <test#>
> or they may be listed in the Valgrind checked file ./.valgrindrc or
> ~/.valgrindrc like
> --memcheck:leak-check=no
> --memcheck:track-origins=yes
> When QEMU-IO process is being killed, the shell report refers to the
> text of the command in _qemu_io_wrapper(), which was modified with this
> patch. So, the benchmark output for the tests 039, 061 and 137 is to be
> changed also.
> 

Oh, weird. "VALGRIND_QEMU=y" actually has just meant ... valgrind
qemu-io. OK.

> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  tests/qemu-iotests/039.out   | 30 ++++---------------
>  tests/qemu-iotests/061.out   | 12 ++------
>  tests/qemu-iotests/137.out   |  6 +---
>  tests/qemu-iotests/common.rc | 69 ++++++++++++++++++++++++++++++++------------
>  4 files changed, 59 insertions(+), 58 deletions(-)
> 
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index 724d7b2..972c6c0 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -11,11 +11,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     0x1
>  ERROR cluster 5 refcount=0 reference=1
>  ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
> @@ -50,11 +46,7 @@ read 512/512 bytes at offset 0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     0x1
>  ERROR cluster 5 refcount=0 reference=1
>  Rebuilding refcount structure
> @@ -68,11 +60,7 @@ incompatible_features     0x0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     0x0
>  No errors were found on the image.
>  
> @@ -91,11 +79,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     0x1
>  ERROR cluster 5 refcount=0 reference=1
>  ERROR OFLAG_COPIED data cluster: l2_entry=8000000000050000 refcount=0
> @@ -105,11 +89,7 @@ Data may be corrupted, or further writes to the image may corrupt it.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     0x0
>  No errors were found on the image.
>  *** done
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 1aa7d37..8cb57eb 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -118,11 +118,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  wrote 131072/131072 bytes at offset 0
>  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  magic                     0x514649fb
>  version                   3
>  backing_file_offset       0x0
> @@ -280,11 +276,7 @@ No errors were found on the image.
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  wrote 131072/131072 bytes at offset 0
>  128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  magic                     0x514649fb
>  version                   3
>  backing_file_offset       0x0
> diff --git a/tests/qemu-iotests/137.out b/tests/qemu-iotests/137.out
> index 22d59df..7fed5e6 100644
> --- a/tests/qemu-iotests/137.out
> +++ b/tests/qemu-iotests/137.out
> @@ -35,11 +35,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-io: Unsupported value 'blubb' for qcow2 option 'overlap-check'. Allowed are any of the following: none, constant, cached, all
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -./common.rc: Killed                  ( if [ "${VALGRIND_QEMU}" == "y" ]; then
> -    exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -else
> -    exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@";
> -fi )
> +./common.rc: Killed                  ( _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
>  incompatible_features     0x0
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  wrote 65536/65536 bytes at offset 0
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 5502c3d..6e461a1 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -60,19 +60,52 @@ if ! . ./common.config
>      exit 1
>  fi
>  
> +_qemu_proc_wrapper()
> +{
> +    local VALGRIND_LOGFILE="$1"
> +    shift
> +    if [ "${VALGRIND_QEMU}" == "y" ]; then
> +        exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$@"
> +    else
> +        exec "$@"
> +    fi
> +}
> +

Why do we need a second wrapper? I get nervous with each new wrapper we
make, because I feel like it has unintended consequences with pipe
handling and so on in the test dispatcher scripts.

> +_qemu_proc_valgrind_log()
> +{
> +    local VALGRIND_LOGFILE="$1"
> +    local RETVAL="$2"
> +    if [ "${VALGRIND_QEMU}" == "y" ]; then
> +        if [ $RETVAL == 99 ]; then
> +            cat "${VALGRIND_LOGFILE}"
> +        fi
> +        rm -f "${VALGRIND_LOGFILE}"
> +    fi
> +}
> +
>  _qemu_wrapper()
>  {
> +    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
>      (
>          if [ -n "${QEMU_NEED_PID}" ]; then
>              echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid"
>          fi
> -        exec "$QEMU_PROG" $QEMU_OPTIONS "$@"
> +        _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_PROG" $QEMU_OPTIONS "$@"

Can we not inline that logic here? especially because:

>      )
> +    RETVAL=$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL

We're already making valgrind calls here anyway.

> +    return $RETVAL
>  }
>  
>  _qemu_img_wrapper()
>  {
> -    (exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@")
> +    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
> +    (
> +        _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@"
> +    )
> +    RETVAL=$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
>  
>  _qemu_io_wrapper()
> @@ -85,36 +118,36 @@ _qemu_io_wrapper()
>              QEMU_IO_ARGS="--object secret,id=keysec0,data=$IMGKEYSECRET $QEMU_IO_ARGS"
>          fi
>      fi
> -    local RETVAL
>      (
> -        if [ "${VALGRIND_QEMU}" == "y" ]; then
> -            exec valgrind --log-file="${VALGRIND_LOGFILE}" --error-exitcode=99 "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
> -        else
> -            exec "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
> -        fi
> +        _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@"
>      )
>      RETVAL=$?
> -    if [ "${VALGRIND_QEMU}" == "y" ]; then
> -        if [ $RETVAL == 99 ]; then
> -            cat "${VALGRIND_LOGFILE}"
> -        fi
> -        rm -f "${VALGRIND_LOGFILE}"
> -    fi
> -    (exit $RETVAL)
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
>  
>  _qemu_nbd_wrapper()
>  {
> -    "$QEMU_NBD_PROG" --pid-file="${QEMU_TEST_DIR}/qemu-nbd.pid" \
> -                     $QEMU_NBD_OPTIONS "$@"
> +    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
> +    (
> +        _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_NBD_PROG" \
> +            --pid-file="${QEMU_TEST_DIR}/qemu-nbd.pid" $QEMU_NBD_OPTIONS "$@"
> +    )
> +    RETVAL=$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
>  
>  _qemu_vxhs_wrapper()
>  {
> +    local VALGRIND_LOGFILE="${TEST_DIR}"/$$.valgrind
>      (
>          echo $BASHPID > "${TEST_DIR}/qemu-vxhs.pid"
> -        exec "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
> +        _qemu_proc_wrapper "${VALGRIND_LOGFILE}" "$QEMU_VXHS_PROG" $QEMU_VXHS_OPTIONS "$@"
>      )
> +    RETVAL=$?
> +    _qemu_proc_valgrind_log "${VALGRIND_LOGFILE}" $RETVAL
> +    return $RETVAL
>  }
>  
>  export QEMU=_qemu_wrapper
> 

Only other thought: at the moment, valgrind turns on valgrind for
qemu-io; this wraps many more tools and potentially slows down iotests a
lot. If there are problems, we might want easy access to turn /some/ but
not all of these options off again.


do we want to be able to specify which subprocesses we use valgrind on,
Perhaps with environment variables for fine-tuning?

QEMU_VALGRIND_QEMU_IO = "off"
QEMU_VALGRIND_QEMU = "off"
QEMU_VALGRIND_NBD = "off"

(Only an idle question, not necessary for this series IMO.)

