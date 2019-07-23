Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3088DC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8AC721842
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJyooZh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AC721842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptFl-0001Ww-4g
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 07:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hptFZ-00018S-9L
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hptFX-00026V-FG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:46:33 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40218)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hptFT-00024e-Rk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:46:29 -0400
Received: by mail-wr1-x443.google.com with SMTP id r1so42825906wrl.7
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rovnfAxNV8PWwia368imxazla7nTuGksM0xB+nyWTR0=;
 b=IJyooZh1i+qNHMm2o8RAKk1a8XwXfBaV6ZR7EdUNejExsJc3htAEgwNdVZSyoRoV9M
 YzzdiYBcuJ2ox6hC1OF6j43ab7yLOnZ2rG4qfvAk+yB6R8G+soRy/eDq+Ye5oW9U0Xi5
 eo1hqrvvJJtQrpwP1pavq77vJldTA2uIRVQx7JJr8YV0hhtO0bHdZU7HEim9KeSeO4bX
 vympQjgdFL+h5e2pOEbat/xFf+6XgxZX8LRvVgH3Jw0n/dBTTfMsbh+mTVsMH/knnB93
 /mK5Je4DPijmJ1ksthz0NjUQbjpF3UoC4MSu+MVUnyYBeMoDhm6UPRfk51uZpZJGYjFs
 qHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rovnfAxNV8PWwia368imxazla7nTuGksM0xB+nyWTR0=;
 b=GErasqTIjkiuVDPJKHBUlbgcwMuAkwW+zjSQ1fGLCbJlOe9Yn74Had/Gor0M98c2JH
 Yir6z4/Ml7rbiRUUx8yA5lqY8Oz9X2IdF0UIJISoE/A/VoqJXFvTrC+KTw1dkOj5LlG5
 Tn68Lr0HxhHSziFscjwbdrJKmiBWKG4S+xTh0+bztAE5XYnyGIAm8FK5EI6On5oE79IN
 MMpu5W1LVbvarEHqq5eP16+X5RnecK1E+xQJuZCFnA98uuiRLo7yoefuJFG0UtqUmN+U
 dY9Ps4Be7ZWqhxbtXORkOAcWtZdvGdxBzasGSqdHueaciZvtzqf1ckHdKBGX+hM/2fbF
 +7xg==
X-Gm-Message-State: APjAAAXDboMYWPKcS8Y3iLSJebbxIoBJxZ2frtm5GojTSpBYtiv8DR+U
 7jFVoG+ifHzwAYFFdrStXAll/g==
X-Google-Smtp-Source: APXvYqyVRjIoJqawT0zYN8S36IgGLIup5R6EXL632nNkz6aPffhL6VxDX3uvgea6hUpcMzVUBIYrUA==
X-Received: by 2002:adf:dfc4:: with SMTP id q4mr79437441wrn.54.1563882386235; 
 Tue, 23 Jul 2019 04:46:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j189sm47994691wmb.48.2019.07.23.04.46.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 04:46:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 46D6E1FF87;
 Tue, 23 Jul 2019 12:46:25 +0100 (BST)
References: <20190723103612.5600-1-alex.bennee@linaro.org>
 <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
Date: Tue, 23 Jul 2019 12:46:25 +0100
Message-ID: <87imrt0y9a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PULL for 4.1-rc2 00/23] testing updates (green
 CI!)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 23 Jul 2019 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The following changes since commit 23da9e297b4120ca9702cabec91599a44255f=
e96:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20=
190722' into staging (2019-07-22 15:16:48 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-230719-1
>>
>> for you to fetch changes up to 2e3b8743cd66f1d0fbc83051b0b6b072a97460cc:
>>
>>   gitlab-ci: Remove qcow2 tests that are handled by "make check" already=
 (2019-07-23 11:33:15 +0100)
>>
>> ----------------------------------------------------------------
>> Final testing updates:
>>
>>   - docker sphinx updates
>>   - windows build re-enabled in CI
>>   - travis_retry for make check
>>   - quick iotests enabled for make check
>>   - build fixes
>>
>> ----------------------------------------------------------------
>
> 'make check-tcg' fails (x86-64 host):
>
> make: Entering directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>   BUILD   debian10
> The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata
> apt install -y --no-install-recommends         bison
> build-essential         ca-certificates         clang         flex
>     gettext         git         pkg-config         psmisc
> python         python3-sphinx         texinfo         $(apt-get -s
> build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)' returned
> a non-zero code: 100
> Traceback (most recent call last):
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 615, in <module>
>     sys.exit(main())
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 611, in main
>     return args.cmdobj.run(args, argv)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 413, in run
>     extra_files_cksum=3Dcksum)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 280, in build_image
>     quiet=3Dquiet)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 207, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
> 'qemu:debian10', '-f', '/tmp/docker_buildBgZdCD/tmp6MJLiZ.docker',
> '/tmp/docker_buildBgZdCD']' returned non-zero exit status 100
> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
> recipe for target 'docker-image-debian10' failed
> make: *** [docker-image-debian10] Error 1
> make: Leaving directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'

Odd. Does:

  make docker-image-debian10 V=3D1

fail for you? Can you retry with:

  make docker-image-debian10 V=3D1 NOCACHE=3D1

>
> I also got a failure with openbsd which seems to be when
> the tests run check-block.sh:
>
> /home/qemu/qemu-test.Dy1Aj3/src/tests/check-block.sh
>   TEST    iotest-qcow2: 001
>   TEST    iotest-qcow2: 002
>   TEST    iotest-qcow2: 003
>   TEST    iotest-qcow2: 004
>   TEST    iotest-qcow2: 005 [not run]
>   TEST    iotest-qcow2: 007 [fail]
> QEMU          --
> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../aarch64-softm=
mu/qemu-system-aarch64"
> -nodefaults -machine virt,accel=3Dqtest
> QEMU_IMG      --
> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-img"
> QEMU_IO       --
> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-io"
> --cache writeback -f qcow2
> QEMU_NBD      --
> "/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- OpenBSD/amd64 openbsd 6.5
> TEST_DIR      -- /home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/scr=
atch
> SOCKET_SCM_HELPER --
>
> --- /home/qemu/qemu-test.Dy1Aj3/src/tests/qemu-iotests/007.out  Tue
> Jul 23 10:49:15 2019
> +++ /home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/007.out.bad
>  Tue Jul 23 11:10:21 2019
> @@ -2,16 +2,7 @@
>
>  creating image
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
> -savevm 1
> -savevm 2
> -savevm 3
> -savevm 4
> -savevm 5
> -savevm 6
> -savevm 7
> -savevm 8
> -savevm 9
> -savevm 10
> +./007: line 51: seq: command not found
>
> [and some other failures]
>
> I see Thomas Huth has a patch on-list for that, but this
> didn't manifest as a problem before this pullreq.

OK, I'll add it and rebuild the PR.

Have you noticed any issues with check-acceptance?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

