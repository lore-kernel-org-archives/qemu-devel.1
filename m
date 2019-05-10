Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F7C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9F420989
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 11:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iLKDVQQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9F420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP3Rx-0004o4-HH
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 07:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP3QS-0003ak-He
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:10:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hP3QR-0004aj-Dw
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:10:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hP3QR-0004ND-5b
	for qemu-devel@nongnu.org; Fri, 10 May 2019 07:10:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id a12so7395416wrn.4
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=0fy1QeZ2w8TmPzjU3QT3KHycC9g8zHV1Lux0sKT0PAg=;
	b=iLKDVQQxj1fZ69YZ3g6NN5+Tnz71f8ukgE8Ht4S2jAhsZBZ4bUryaLysqDsw9d29Ig
	sB3i/PX9lBYFo/tv5uI1VNaIrhp+uJ8BH83nEU2gW7yACyQUUVpphZ2FEFGFnRotV7Ce
	1yJh05DTHZbgvd8yuS33oGIF+lI/K7MN5Lbe/wuL9u5lPMQeWNp4M2xK4RHM0yD/Opf+
	hNVkvDLhUVHCyjmdWm/LV0ZI+qzO4DxPvBLx2uMD3iFRNcIM51627HNO/tYa6i+RmzP+
	1H5hPuPsr2KNDwLEV/TgA5DkWujb0CLQacKomPBR982qX9bXAVfUdBLpW5c5wOSVZQg4
	s3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=0fy1QeZ2w8TmPzjU3QT3KHycC9g8zHV1Lux0sKT0PAg=;
	b=ApQUoA2qoOJtEe9151EzQA9zJl7Vrds8+ejxI77koCit6YDsQG0pXU09u7pDiQjcKR
	a2vRz0fDt3fek2MRIMytFmIGaPtJziJI6Vug065K2CgbuhgcmnJOyc88K+A+8zZg/jGR
	AmAoz0+ECwjNm1k7goMNJk6GPavMF/vI95eonXNGdZm4/qa4od13p+U1qZizHKw3Z+Zi
	jMRVPgVY8wgdHmCnQcR3sdZfz75elMX7SnWNSVggMwAbVuUKF6xeE57vY6RCyfGsgIRW
	Rfa5qr4PsQ/rVo9eGIm4BrIjlKjW2Tm5dbL7tWmEUf6h05utytn7hebaj1dqbsIjFvIb
	rJjA==
X-Gm-Message-State: APjAAAURKqhC+1vUNQ/nY+j17VM6K8S4EW//Fy/TY+YpRbVo1rUkKxXA
	KTqxE0FANRPmTEbz8merqaxRww==
X-Google-Smtp-Source: APXvYqyeZuIUwqvtUbxsSBQap0E21RuxuK/Pq8l/bdOOvZOjwn3+gZ4ByINsvkw2I93GEgCKVKkKTA==
X-Received: by 2002:a5d:6249:: with SMTP id m9mr7034094wrv.255.1557486649131; 
	Fri, 10 May 2019 04:10:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	u125sm7815401wme.15.2019.05.10.04.10.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 04:10:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1E3861FF87;
	Fri, 10 May 2019 12:10:48 +0100 (BST)
References: <20190510102918.2705-1-alex.bennee@linaro.org>
	<55dd9cf4-cb06-48b1-0cec-ff03113c7c17@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <55dd9cf4-cb06-48b1-0cec-ff03113c7c17@redhat.com>
Date: Fri, 10 May 2019 12:10:48 +0100
Message-ID: <87lfze4laf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3] tests/qemu-iotests: re-format output to
 for make check-block
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 10/05/2019 12.29, Alex Benn=C3=A9e wrote:
>> This attempts to clean-up the output to better match the output of the
>> rest of the QEMU check system when called with -pretty. This includes:
>>
>>   - formatting as "  TEST    iotest: nnn"
>>   - calculating time diff at the end
>>   - only dumping config on failure (when -pretty enabled)
>>
>> The existing output is mostly preserved although the dumping of the
>> old time at the start "Ns ..." was removed to keep the logic simple.
>> The timestamp mode can still be used to see which tests are "hanging".
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
>>
>> ---
>> v3
>>   - revert echo to printf
>>   - add _report_test_start
>> ---
>>  tests/qemu-iotests/check | 101 ++++++++++++++++++++++++++-------------
>>  1 file changed, 68 insertions(+), 33 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 922c5d1d3d3..ac481f905bf 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -27,6 +27,7 @@ bad=3D""
>>  notrun=3D""
>>  casenotrun=3D""
>>  interrupt=3Dtrue
>> +pretty=3Dfalse
>>
>>  # by default don't output timestamps
>>  timestamp=3D${TIMESTAMP:=3Dfalse}
>> @@ -88,6 +89,22 @@ _full_platform_details()
>>      echo "$os/$platform $host $kernel"
>>  }
>>
>> +_full_env_details()
>> +{
>> +    cat <<EOF
>> +QEMU          -- "$QEMU_PROG" $QEMU_OPTIONS
>> +QEMU_IMG      -- "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS
>> +QEMU_IO       -- "$QEMU_IO_PROG" $QEMU_IO_OPTIONS
>> +QEMU_NBD      -- "$QEMU_NBD_PROG" $QEMU_NBD_OPTIONS
>> +IMGFMT        -- $FULL_IMGFMT_DETAILS
>> +IMGPROTO      -- $IMGPROTO
>> +PLATFORM      -- $FULL_HOST_DETAILS
>> +TEST_DIR      -- $TEST_DIR
>> +SOCKET_SCM_HELPER -- $SOCKET_SCM_HELPER
>> +
>> +EOF
>> +}
>> +
>>  # $1 =3D prog to look for
>>  set_prog_path()
>>  {
>> @@ -256,6 +273,7 @@ other options
>>      -o options          -o options to pass to qemu-img create/convert
>>      -T                  output timestamps
>>      -c mode             cache mode
>> +    -pretty             pretty print output for make check
>
> "pretty" is likely just a matter of taste ... so maybe this should be
> named differently instead? "--makecheck" ? Or "--one-shot" ?
>
>>  testlist options
>>      -g group[,group...]        include tests from these groups
>> @@ -403,7 +421,10 @@ testlist options
>>                  command -v xxdiff >/dev/null 2>&1 && diff=3Dxxdiff
>>              fi
>>              ;;
>> -
>> +        -pretty)   # pretty print output
>> +            pretty=3Dtrue
>> +            xpand=3Dfalse
>> +            ;;
>>          -n)        # show me, don't do it
>>              showme=3Dtrue
>>              xpand=3Dfalse
>> @@ -704,23 +725,30 @@ END        { if (NR > 0) {
>>
>>  trap "_wrapup; exit \$status" 0 1 2 3 15
>>
>> +# Report the test start and results, optionally pretty printing for make
>> +# args: $seq
>> +_report_test_start()
>> +{
>> +    if $pretty; then
>> +        printf "  TEST    iotest: %s" "$1"
>
> Could you maybe change the "iotest:" into "iotest-$IMGFMT:" ? ... so
> that when you run "make check SPEED=3Dslow" you also see which kind of
> format is currently under test?

Sure I can do that.

>
> And this currently also does not play very nicely when running "make -j8
> check" in parallel:
>
>   [...]
>   TEST    iotest: 001  TEST    check-qtest-alpha: tests/qmp-test
>   TEST    check-qtest-alpha: tests/qmp-cmd-test
>   TEST    check-qtest-aarch64: tests/boot-serial-test
>   TEST    check-qtest-aarch64: tests/migration-test
>   TEST    check-qtest-arm: tests/tmp105-test
>   TEST    check-unit: tests/check-qnum
>   TEST    check-unit: tests/check-qstring
>   TEST    check-unit: tests/check-qlist
>   TEST    check-unit: tests/check-qnull
>  2s (last 2s)
>   TEST    iotest: 002  TEST    check-qtest-arm: tests/pca9552-test
>   TEST    check-unit: tests/check-qobject
>   TEST    check-qtest-cris: tests/qmp-test
>   [...]
>
> I think the "make check" mode should only print out one time for each
> test, preferable at the end, like the other tests (like qtests) are
> doing it...?

*sigh* and this is of course why deferred everything to the end in the
last revision. Should we just assume the -pretty/-make whatever is
incompatible with -T for the timestamp mode?

>
>  Thomas


--
Alex Benn=C3=A9e

