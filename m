Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4711EC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A85520C01
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A85520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvC3-0005dp-8D
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:11:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNvB1-0004Sv-6I
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hNvB0-0003FP-0C
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:10:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hNvAw-0003Dc-Vz; Tue, 07 May 2019 04:10:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1AB4356CF;
	Tue,  7 May 2019 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-186.ams2.redhat.com
	[10.36.116.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B4A3B1715F;
	Tue,  7 May 2019 08:10:08 +0000 (UTC)
Date: Tue, 7 May 2019 10:10:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190507081004.GA5808@localhost.localdomain>
References: <20190503143904.31211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190503143904.31211-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 07 May 2019 08:10:10 +0000 (UTC)
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.05.2019 um 16:39 hat Alex Benn=E9e geschrieben:
> This attempts to clean-up the output to better match the output of the
> rest of the QEMU check system. This includes:
>=20
>   - formatting as "  TEST    iotest: nnn"
>   - calculating time diff at the end
>   - only dumping config on failure
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Hm... I see that this makes the output more consistent with other tests,
which is nice when it's run in the context of make check. I also think
the more consistent new output is uglier than the old output format.

I wonder whether we should have two modes - one that blends in with make
check, and another one that is provides nice and possibly more complete
output when the script is run manually.

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

At the first sight, I have two things that I like to see improved at
least in the manual mode:

* The output above is now produced for each failing case when multiple
  tests are failing. I don't usually want to have my scroll buffer
  filled with tons of these, but I just want to see as many diffs as
  possible with as little scrolling as possible.

  If we have two modes, we can unconditionally display it at the start
  (like before this patch) in manual mode and completely disable it in
  make check mode. (It's rare that I need this information, and if make
  check fails, I should be trivially able to re-run it manually.)

* I'd like to see the currently running test with its start time and
  expected duration before it has finished. When running tests in the
  background, I often look at this information to check whether what's
  running is just a long-running test case or whether it hangs.

> -
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

I don't see this reason turn up in the output anywhere. It gets printed
only for failures, but "not run" is not a failure. So all I get is
something like this:

$ ./check -T -raw 001-010
006 - unknown test, ignored
  TEST    iotest: 001 [09:48:38] -> [09:48:39] 1s (last 1s)
  TEST    iotest: 002 [09:48:39] -> [09:48:40] 1s (last 1s)
  TEST    iotest: 003 [09:48:40] -> [09:48:40] 0s (last 1s)
  TEST    iotest: 004 [09:48:40] -> [09:48:41] 1s (last 0s)
  TEST    iotest: 005 [09:48:41] -> [09:48:41] 0s (last 0s)
not suitable for this image format: raw
  TEST    iotest: 007 [09:48:41] -> [09:48:41]
  TEST    iotest: 008 [09:48:41] -> [09:48:41] 0s (last 1s)
  TEST    iotest: 009 [09:48:41] -> [09:48:42] 1s (last 0s)
  TEST    iotest: 010 [09:48:42] -> [09:48:42] 0s (last 0s)
Not run: 007
Passed all 8 tests

Note that the "not suitable for this image format: raw" comes _before_
the test that it refers to, without including the test number. If I
didn't know that 007 was the skipped test, I would interpret it as
belonging to test 005.

The indentation for the message that we had previously felt nicer, too,
but maybe only for manual mode because none of make check is nice like
that? Actually, is there any reason for make check to even print that
message for skipped tests? It only tests a subset of tests anyway, and
we'll still get the "Not run" list at the end.

Kevin

