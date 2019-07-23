Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ADEC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DCB320644
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0CYKoSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DCB320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpt4y-0006x8-N4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 07:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpt4o-0006YD-IR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpt4m-0002VR-V3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:35:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46389)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpt4m-0002V0-Oo
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:35:24 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so15327921ote.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RbaisKpSnQMRWbHqoxMI3oe0fWck9QxOl4GVM1YNjS0=;
 b=l0CYKoSyerG0z/rvAlIGPzcbDD908HiFqkfdYxyTSSyiKFuLU2ngkHx/vmC9n5GDHN
 ja3qDpSe7ScmxM5cGaoO3KdUACvCtjepsN+3EmDn+9rSJEWWITy8wLz/Xa96cCVV8XZZ
 Peh0mwOz08Jwq0a/2dTiuH1jwcbZThr4V27RRNS/Gqw+rhMqEp83j8kXm2GHhps+HtAz
 +XKt+yb6fWYO308Lot0lrDx/hysPS6GBAh8sjejJv4JB14S6/EXDbeJT+8hTGDOmgG9M
 60LADMxxmlEizKk2ANondurpdFd0nj9fAZKTMEH/r1yISPIm/yHbx6aItkkayA3+4roh
 u9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RbaisKpSnQMRWbHqoxMI3oe0fWck9QxOl4GVM1YNjS0=;
 b=rx6LLt0iXoNq3AuxIDq61ixk8PcFizGrKcAA07qH4FMBrqf4Gt07Jp/MHAMXVHyoCE
 TbRJE96ey3uaER7wCIoUEBLBwFiPEMQZ8gSZuWj2sxZR8rgnl5M9icwAHswmUfEHcTqJ
 OiNaR+pUR2CTAXik9GQl5U54r09oK0zNAOgKEE/9k3gV83CqKFr8+0R2O4gnQFEbIh3G
 Oua2AdOTyJlfIPwZjinHT4nEX5BA+rLK0lonC7cpR0kLVBXcews94xv0NR24PFDBox59
 KCNDeP8DJID4/Bwf7WSPDSM6gp/JgIn4nYJ/I6p3IkhLcpamtKN/08zDkOWekV5fqjdZ
 0Qbw==
X-Gm-Message-State: APjAAAXAFi+kt0ZVJ5sfyYaP7J75DoQHAzVjtIq3OzJQrJDds1HCKf2d
 h5EBoDb7gEltSr0mlO3OGmCuFq1mxpNbBjzKecLzpA==
X-Google-Smtp-Source: APXvYqxnAK6/ttM2F3mnV2mN5gckE5pnQcT03K3SOKImxsVP+0p93qZg4O8u43+mo1H5uZlrwSY1awSHTEszw6Owac8=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr52622808otj.97.1563881723896; 
 Tue, 23 Jul 2019 04:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190723103612.5600-1-alex.bennee@linaro.org>
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 12:35:13 +0100
Message-ID: <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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

On Tue, 23 Jul 2019 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe=
96:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90722' into staging (2019-07-22 15:16:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-230719-1
>
> for you to fetch changes up to 2e3b8743cd66f1d0fbc83051b0b6b072a97460cc:
>
>   gitlab-ci: Remove qcow2 tests that are handled by "make check" already =
(2019-07-23 11:33:15 +0100)
>
> ----------------------------------------------------------------
> Final testing updates:
>
>   - docker sphinx updates
>   - windows build re-enabled in CI
>   - travis_retry for make check
>   - quick iotests enabled for make check
>   - build fixes
>
> ----------------------------------------------------------------

'make check-tcg' fails (x86-64 host):

make: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
  BUILD   debian10
The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata
apt install -y --no-install-recommends         bison
build-essential         ca-certificates         clang         flex
    gettext         git         pkg-config         psmisc
python         python3-sphinx         texinfo         $(apt-get -s
build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\  -f2)' returned
a non-zero code: 100
Traceback (most recent call last):
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 615, in <module>
    sys.exit(main())
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 611, in main
    return args.cmdobj.run(args, argv)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 413, in run
    extra_files_cksum=3Dcksum)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 280, in build_image
    quiet=3Dquiet)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 207, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 190, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t',
'qemu:debian10', '-f', '/tmp/docker_buildBgZdCD/tmp6MJLiZ.docker',
'/tmp/docker_buildBgZdCD']' returned non-zero exit status 100
/home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
recipe for target 'docker-image-debian10' failed
make: *** [docker-image-debian10] Error 1
make: Leaving directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'

I also got a failure with openbsd which seems to be when
the tests run check-block.sh:

/home/qemu/qemu-test.Dy1Aj3/src/tests/check-block.sh
  TEST    iotest-qcow2: 001
  TEST    iotest-qcow2: 002
  TEST    iotest-qcow2: 003
  TEST    iotest-qcow2: 004
  TEST    iotest-qcow2: 005 [not run]
  TEST    iotest-qcow2: 007 [fail]
QEMU          --
"/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../aarch64-softmmu=
/qemu-system-aarch64"
-nodefaults -machine virt,accel=3Dqtest
QEMU_IMG      --
"/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-io"
--cache writeback -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- OpenBSD/amd64 openbsd 6.5
TEST_DIR      -- /home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/scrat=
ch
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.Dy1Aj3/src/tests/qemu-iotests/007.out  Tue
Jul 23 10:49:15 2019
+++ /home/qemu/qemu-test.Dy1Aj3/build/tests/qemu-iotests/007.out.bad
 Tue Jul 23 11:10:21 2019
@@ -2,16 +2,7 @@

 creating image
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
-savevm 1
-savevm 2
-savevm 3
-savevm 4
-savevm 5
-savevm 6
-savevm 7
-savevm 8
-savevm 9
-savevm 10
+./007: line 51: seq: command not found

[and some other failures]

I see Thomas Huth has a patch on-list for that, but this
didn't manifest as a problem before this pullreq.

thanks
-- PMM

