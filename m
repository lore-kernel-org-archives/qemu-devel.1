Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95504C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526CB20645
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqil+TFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526CB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35313 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVcTo-0001KI-FT
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 09:49:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVcSF-0000S1-Bv
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVcSD-0005o2-TF
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:47:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVcSD-0005mI-Bk
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:47:49 -0400
Received: by mail-wr1-x436.google.com with SMTP id c2so5118558wrm.8
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=VLCldtEGKqTS4y5qeXekmu9jpR1ycQVuh7obOtg44nM=;
	b=yqil+TFkXAea8o6dDNeeFh1PB48FXWVx2G6wucm2gQdpWCIKRc6QT6U3BOh8bjnEMW
	bFrWlf72fAQDQ9kC2yHoYfs9fEwBT22JPYxwVXbImPZy+y5PVolx70SQn1LwcYMxJXvm
	/DiZbXR90feMyX9Zcglpo1/CrvfkUFnu1V1Upp8eCmwYPFaDTfV99A2xSoyj4DXJtqRj
	Z8BGVTesnseumJYgheiQLjvMJ6D9DP8cCwF2xxob5+LTYJz4nOsJvKlMDz/DfdsW7dUw
	sMndG2cY2M48y2eKa3w6xQf3PL7+WsK4BfBTvcaUzbbAFeAk5d/SmxF16pN7oD46hwIT
	NSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=VLCldtEGKqTS4y5qeXekmu9jpR1ycQVuh7obOtg44nM=;
	b=Fz3UoCdVChgajha3K0EfeZS3srVRvBBW0BHFlDKJpiA2ikLCfQX6shWwJfTG6dYLsX
	w4rGGxynJwosEaJi+UMRUSn9ld+C9Z3Itni9fNfe3vxD/7YuczDVU+yLdYjN6+Ne+M0w
	igTEwczzdRSma7sm7ylxduaWFAOSF2kD7o5ZAwiQDA9yVjkaMizQHo4QNnXP3oUKCtj2
	kG/h/YjAPj+mF7aYi1VfHLtlDtTjVTEyN2LtKeSXgt8mxnyrsIngm40KoHgQeVWSMsxm
	zmxJsdN5DTllfvu8V72RTfdA9YQpG+mYopGGyA7Xdtfs45VOoi9+1lhK5SrVlBLc/+JH
	TeiQ==
X-Gm-Message-State: APjAAAV3tcONTVhO6j+2o5p38POqLUfCdyVbR7ClmJIQBtfM5goTsx/u
	bb8/4InaGa7KQEJgLdBdqEN9WQ==
X-Google-Smtp-Source: APXvYqzNPbbHhcsjHNQK7uH/nC88smcZNMHHlggQzPDsE8lkO01vcJ5sO/tIsq9MTmJ18LqfwQXCXQ==
X-Received: by 2002:a5d:6849:: with SMTP id o9mr25618714wrw.196.1559051267678; 
	Tue, 28 May 2019 06:47:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h14sm11805170wro.3.2019.05.28.06.47.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 06:47:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A101D1FF87;
	Tue, 28 May 2019 14:47:46 +0100 (BST)
References: <20190528094953.14898-1-alex.bennee@linaro.org>
	<CAFEAcA-Cbot1POVcbAzXhaLqNJpi6M_0z18=YoB7vyqY3PekUg@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA-Cbot1POVcbAzXhaLqNJpi6M_0z18=YoB7vyqY3PekUg@mail.gmail.com>
Date: Tue, 28 May 2019 14:47:46 +0100
Message-ID: <878suqsnb1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: Re: [Qemu-devel] [PULL 00/28] testing/next (system tests, docker,
 iotests)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 28 May 2019 at 10:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit a7b21f6762a2d6ec08106d8a7ccb118299145=
23f:
>>
>>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-=
pull-request' into staging (2019-05-24 12:47:49 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-next-280519-1
>>
>> for you to fetch changes up to 4a344d91083e351c1c5ac877c0ab215335a1e23d:
>>
>>   tests: Run the iotests during "make check" again (2019-05-28 10:28:51 =
+0100)
>>
>> ----------------------------------------------------------------
>> Various testing updates
>>
>>   - semihosting re-factor (used in system tests)
>>   - aarch64 and alpha system tests
>>   - editorconfig tweak for .S
>>   - some docker image updates
>>   - iotests clean-up and make check inclusion
>>
>
> Hi; this fails 'make check' on the clang sanitiser build for Linux x86-64.
> It looks like the code in qemu-imo-cmds.c is incorrectly doing
> a division-by-zero if the operation it is reporting on took
> less than a second...

Sounds like we should include the sanitizer build in our normal setup.
We currently only do:

  ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3Dthread
  -fuse-ld=3Dgold"

with gcc-7. What are the clang configure runes you are using?

>
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/cla=
ng'
> /home/petmay01/linaro/qemu-for-merges/tests/check-block.sh
>   TEST    iotest-qcow2: 001
>   TEST    iotest-qcow2: 002
>   TEST    iotest-qcow2: 003
>   TEST    iotest-qcow2: 004
>   TEST    iotest-qcow2: 005
>   TEST    iotest-qcow2: 007
>   TEST    iotest-qcow2: 008
>   TEST    iotest-qcow2: 009
>   TEST    iotest-qcow2: 010
>   TEST    iotest-qcow2: 011
>   TEST    iotest-qcow2: 012
> --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/013.out
>  2014-12-15 11:11:04.234972929 +0000
> +++ /home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/=
013.out.bad
>    2019-05-28 14:06:57.827692927 +010
> 0
> @@ -17596,6 +17596,7 @@
>
>  With offset 0:
>  =3D=3D=3D IO: pattern 0
> +/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
> error: division by zero
>  read 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 4096/4096 bytes at offset 4096
> @@ -21994,6 +21995,7 @@
>  No errors were found on the image.
>  With offset 4294967296:
>  =3D=3D=3D IO: pattern 0
> +/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
> error: division by zero
>  read 4096/4096 bytes at offset 4294967296
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 4096/4096 bytes at offset 4294971392
>   TEST    iotest-qcow2: 013 [fail]
> QEMU          --
> "/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../=
../x86_64-softmmu/qemu-system-x8
> 6_64" -nodefaults -machine accel=3Dqtest
> QEMU_IMG      --
> "/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../=
../qemu-img"
> QEMU_IO       --
> "/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../=
../qemu-io"
>  --cache writeback -
> f qcow2
> QEMU_NBD      --
> "/home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/../=
../qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 e104462 4.15.0-48-generic
> TEST_DIR      --
> /home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/scra=
tch
> SOCKET_SCM_HELPER --
> /home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/sock=
et_scm_helper
>
> --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/013.out
>  2014-12-15 11:11:04.234972929 +0000
> +++ /home/petmay01/linaro/qemu-for-merges/build/clang/tests/qemu-iotests/=
013.out.bad
>    2019-05-28 14:06:57.827692927 +0100
> @@ -17596,6 +17596,7 @@
>
>  With offset 0:
>  =3D=3D=3D IO: pattern 0
> +/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
> error: division by zero
>  read 4096/4096 bytes at offset 0
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 4096/4096 bytes at offset 4096
> @@ -21994,6 +21995,7 @@
>  No errors were found on the image.
>  With offset 4294967296:
>  =3D=3D=3D IO: pattern 0
> +/home/petmay01/linaro/qemu-for-merges/qemu-io-cmds.c:264:18: runtime
> error: division by zero
>  read 4096/4096 bytes at offset 4294967296
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read 4096/4096 bytes at offset 4294971392
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

