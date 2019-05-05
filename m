Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00108C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 16:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B836920578
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 16:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836920578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43145 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJe6-0002Lp-MN
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 12:05:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNJZn-0007pz-5T
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNJZl-0002BM-7W
	for qemu-devel@nongnu.org; Sun, 05 May 2019 12:01:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hNJZf-000287-IO; Sun, 05 May 2019 12:01:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CBCB3087928;
	Sun,  5 May 2019 16:01:10 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-27.ams2.redhat.com [10.36.116.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 282E7100194A;
	Sun,  5 May 2019 16:01:08 +0000 (UTC)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190503143904.31211-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <408aeb3a-efd9-68a7-c5f0-08993084ec09@redhat.com>
Date: Sun, 5 May 2019 18:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503143904.31211-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Sun, 05 May 2019 16:01:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] tests/qemu-iotests: re-format output
 to for make check-block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505160108.YcGQyCcIjIXaDyRDnSzEdVakOvpe4bhhBt0v34NFqh4@z>

On 03/05/2019 16.39, Alex Benn=C3=A9e wrote:
> This attempts to clean-up the output to better match the output of the
> rest of the QEMU check system. This includes:
>=20
>   - formatting as "  TEST    iotest: nnn"
>   - calculating time diff at the end
>   - only dumping config on failure
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/qemu-iotests/check | 71 +++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 37 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 922c5d1d3d..2ffc14113e 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -633,12 +633,6 @@ _wallclock()
>      date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
>  }
> =20
> -_timestamp()
> -{
> -    now=3D$(date "+%T")
> -    printf %s " [$now]"
> -}
> -
>  _wrapup()
>  {
>      if $showme
> @@ -709,19 +703,6 @@ trap "_wrapup; exit \$status" 0 1 2 3 15
>  FULL_IMGFMT_DETAILS=3D$(_full_imgfmt_details)
>  FULL_HOST_DETAILS=3D$(_full_platform_details)
> =20
> -cat <<EOF
> -QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
> -QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
> -QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
> -QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
> -IMGFMT        -- $FULL_IMGFMT_DETAILS
> -IMGPROTO      -- $IMGPROTO
> -PLATFORM      -- $FULL_HOST_DETAILS
> -TEST_DIR      -- $TEST_DIR
> -SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
> -
> -EOF

Maybe turn it into a function instead, so that it could also always be
printed when the script is run with the "-v" parameter?

>  seq=3D"check"
> =20
>  [ -n "$TESTS_REMAINING_LOG" ] && echo $list > $TESTS_REMAINING_LOG
> @@ -729,7 +710,9 @@ seq=3D"check"
>  for seq in $list
>  do
>      err=3Dfalse
> -    printf %s "$seq"
> +    reason=3D""
> +    times=3D""
> +
>      if [ -n "$TESTS_REMAINING_LOG" ] ; then
>          sed -e "s/$seq//" -e 's/  / /' -e 's/^ *//' $TESTS_REMAINING_L=
OG > $TESTS_REMAINING_LOG.tmp
>          mv $TESTS_REMAINING_LOG.tmp $TESTS_REMAINING_LOG
> @@ -738,7 +721,7 @@ do
> =20
>      if $showme
>      then
> -        echo
> +        echo "  TEST    iotest: $seq (not actually run)"

I wonder whether some other scripts depend on the output of "check -n"
... in that case, it make sense to only print the numbers, without the
additional strings here.

>          continue
>      elif [ -f expunged ] && $expunge && egrep "^$seq([         ]|\$)" =
expunged >/dev/null
>      then
> @@ -753,17 +736,11 @@ do
>          # really going to try and run this one
>          #
>          rm -f $seq.out.bad
> -        lasttime=3D$(sed -n -e "/^$seq /s/.* //p" <$TIMESTAMP_FILE)
> -        if [ "X$lasttime" !=3D X ]; then
> -                printf %s " ${lasttime}s ..."
> -        else
> -                printf "        "        # prettier output with timest=
amps.
> -        fi
>          rm -f core $seq.notrun
>          rm -f $seq.casenotrun
> =20
>          start=3D$(_wallclock)
> -        $timestamp && printf %s "        [$(date "+%T")]"
> +        $timestamp && times=3D"[$(date "+%T")]"
> =20
>          if [ "$(head -n 1 "$source_iotests/$seq")" =3D=3D "#!/usr/bin/=
env python" ]; then
>              run_command=3D"$PYTHON $seq"
> @@ -781,26 +758,26 @@ do
>                      $run_command >$tmp.out 2>&1)
>          fi
>          sts=3D$?
> -        $timestamp && _timestamp
> +        $timestamp && times=3D"$times -> [$(date "+%T")]"
>          stop=3D$(_wallclock)
> =20
>          if [ -f core ]
>          then
> -            printf " [dumped core]"
>              mv core $seq.core
> +            reason=3D"dumped core $seq.core"
>              err=3Dtrue
>          fi
> =20
>          if [ -f $seq.notrun ]
>          then
> -            $timestamp || printf " [not run] "
> -            $timestamp && echo " [not run]" && printf %s "        $seq=
 -- "
> +            $timestamp || reason=3D"[not run]"
> +            $timestamp && reason=3D"[not run] $seq -- "
>              cat $seq.notrun
>              notrun=3D"$notrun $seq"
>          else
>              if [ $sts -ne 0 ]
>              then
> -                printf %s " [failed, exit status $sts]"
> +                reason=3D$(printf %s "[failed, exit status $sts]")
>                  err=3Dtrue
>              fi
> =20
> @@ -821,22 +798,27 @@ do
> =20
>              if [ ! -f "$reference" ]
>              then
> -                echo " - no qualified output"
> +                reason=3D" - no qualified output"
>                  err=3Dtrue
>              else
>                  if diff -w "$reference" $tmp.out >/dev/null 2>&1
>                  then
> -                    echo ""
>                      if $err
>                      then
>                          :
>                      else
> -                        echo "$seq $(expr $stop - $start)" >>$tmp.time
> +                        lasttime=3D$(sed -n -e "/^$seq /s/.* //p" <$TI=
MESTAMP_FILE)
> +                        thistime=3D$(expr $stop - $start)
> +                        echo "$seq $thistime" >>$tmp.time
> +
> +                        if [ "X$lasttime" !=3D X ]; then
> +                            times=3D"$times ${thistime}s (last ${lastt=
ime}s)"
> +                        fi
>                      fi
>                  else
> -                    echo " - output mismatch (see $seq.out.bad)"
>                      mv $tmp.out $seq.out.bad
>                      $diff -w "$reference" "$PWD"/$seq.out.bad
> +                    reason=3D" - output mismatch (see $seq.out.bad)"
>                      err=3Dtrue
>                  fi
>              fi
> @@ -852,9 +834,24 @@ do
>      #
>      if $err
>      then
> +        echo "  TEST    iotest: $seq FAILED $reason"
> +        cat <<EOF
> +QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
> +QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
> +QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
> +QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
> +IMGFMT        -- $FULL_IMGFMT_DETAILS
> +IMGPROTO      -- $IMGPROTO
> +PLATFORM      -- $FULL_HOST_DETAILS
> +TEST_DIR      -- $TEST_DIR
> +SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
> +
> +EOF
>          bad=3D"$bad $seq"
>          n_bad=3D$(expr $n_bad + 1)
>          quick=3Dfalse
> +    else
> +        echo "  TEST    iotest: $seq $times"
>      fi
>      [ -f $seq.notrun ] || try=3D$(expr $try + 1)

Output is much nicer indeed (especially when this is running in parallel
with the other tests), thus:

Tested-by: Thomas Huth <thuth@redhat.com>

