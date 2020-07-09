Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07861C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB20420772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjQAKWYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB20420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUn7-0000XN-TJ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtUmG-0008FM-Cq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:31:44 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:42816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtUmD-0002Kz-RM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:31:43 -0400
Received: by mail-ot1-x330.google.com with SMTP id g37so1436149otb.9
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 04:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WLWZV1rpOnDKtVi670UWK2xy4CeDE+Irw2r/vUCgnms=;
 b=kjQAKWYv9EIXX5RVpfbWF1rm/pFfG6Cts0qGYocQa1lFZ62EhHJ8kDOMFOE0U5dEVZ
 hEJucaWN527OdKdLFBUN71LVp65ji9nNUYLRk+DoutlA8/vCHdOXYBUUOVZTNlHi4gbP
 xpFnK/UMEKXuwFVJUo3wDb5aR1RaGkGY+PSVIzg/7zyheA56J/4G7wNvpADcQMPxqZgr
 svFDMcpsV00DMT7+5Fl+ksklsB1oFdic4FspV/GHkhAPvQrU7OeC/6bqRqg2Xh1lLOlv
 +d/GsgZArFdMtWJNSuekzJ2p7CSfYPEj5sMPO/6IfHJWK/6BEOyVtluAa3Ph6bvk6dFs
 hcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WLWZV1rpOnDKtVi670UWK2xy4CeDE+Irw2r/vUCgnms=;
 b=N0bfyWHVuVm92ChFSOsIRH5NTpEWa71SWjwqKZPonHrngymysInAKRKMzkFUtMQ8Dk
 BYpRKCWAIPDcD8G/ZzyuOzhBoa3J4bCituFajmnxRLKcjhsYNeWFI+mst9py0CCQ2bIJ
 2SxWZipY3unDnH4vO3kpuwSVGf4+c7BjnLJXBKwg9u4ccA1h0kQva9LvviIg9dCZ8g9N
 y5L36tl+CAk5/y1CSqwSZH079+FUheV0UqDYZY4+UrfnHxm87ICITwjU2QNvNvUzpHag
 vfdfF8hXe6YC9Nhikn++ySqmTy7vMgw6ZDbIoHJMncgMBpeldu/d2rETYne577H+mxXY
 9JmA==
X-Gm-Message-State: AOAM530oW/dU7uwNw97/CjsMPBPb10122JkuEbIUs95/equaMGhOrYAQ
 fbHevy1mv3ucVqpuEZCx3uWkSBaJRiHcJ/kynwxkbg==
X-Google-Smtp-Source: ABdhPJxYc/B8nYPfOoATU0pGgMUTKnNFmONQcR31/ESpN/b+kO6A/mIxk+4ESO5k3ur4WZaGl8OISQL1RGrdr0gA8vg=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr46471855oto.135.1594294300289; 
 Thu, 09 Jul 2020 04:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200707070858.6622-1-alex.bennee@linaro.org>
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 12:31:28 +0100
Message-ID: <CAFEAcA80gPAFRsJcFyO8ogNbSa_ex6fSaxnBYU6awU=Ug+Y7wg@mail.gmail.com>
Subject: Re: [PULL 00/41] testing updates (vm, gitlab, misc build fixes)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Tue, 7 Jul 2020 at 08:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> There will be some docker failures until the official repository has
> seeded but local builds should continue to work.
>
> ----
>
> The following changes since commit eb6490f544388dd24c0d054a96dd304bc72844=
50:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00703' into staging (2020-07-04 16:08:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-070720-1
>
> for you to fetch changes up to 6a726e8ca0286e3ed69945abd447099f6f6a903c:
>
>   tests/qht-bench: Adjust threshold computation (2020-07-07 07:57:41 +010=
0)
>
> ----------------------------------------------------------------
> Testing and build updates:
>
>   - tests/vm support for aarch64 VMs
>   - tests/tcg better cross-compiler detection
>   - update docker tooling to support registries
>   - gitlab build docker images and store in registry
>   - gitlab use docker images for builds
>   - a number of skipIf updates to support move
>   - linux-user MAP_FIXED_NOREPLACE fix
>   - qht-bench compiler tweaks
>   - configure fix for secret keyring
>   - tsan fiber annotation clean-up

freebsd failed:

perl: warning: Please check that your locale settings:
perl: warning: Falling back to the standard locale ("C").
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
con recv: Loading /boot/defaults/loader.conf
con recv: Loading /boot/device.hints
con recv: Loading /boot/loader.conf
con recv: Loading /boot/loader.conf.local
con recv: \/  ```                        ` s` `.....---.......--.```
-/ +o   .--`         /y:`      +.  yo`:.            :o      `+-   y/
            -/`   -o/  .-                  ::/sy+:.  /
    `--  / `:                          :` `:
:`  /                          /  .-                        -.   --
                  -.    `:`                  `:`      .--
`--.         .---.....----.  ______               ____   _____ _____
|  ____|             |  _ \ / ____|  __ \  | |___ _ __ ___  ___ | |_)
| (___ | |  | | |  ___| '__/ _ \/ _ \|  _ < \___ \| |  | | | |   | | |
 __/  __/| |_) |____) | |__| | | |   | | |    |    ||     |      |
 | |_|   |_|  \___|\___||____/|_____/|_____/
...........................................................................=
...........................................................................=
...........................................................................=
...........................................................................=
..............................Welcome
to FreeBSD1. Boot Multi user [Enter]2. Boot Single user3. Escape to
loader prompt4. RebootOptions:/\/\5. Kernel: default/kernel (1 of 1)6.
Boot OptionsAutoboot
con send: 3
con recv:  in 10 seconds, hit [Enter] to boot or any other key to stop
con recv:
con recv: Exiting menu!
con recv: Type '?' for a list of commands, 'help' for more detailed help.
con recv: OK
con send: set console=3Dcomconsole<enter>
console: *** read timeout ***
console: waiting for: 'OK'
console: line buffer:

con recv:  set console=3Dcomconso

Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line 628, in =
main
    return vm.build_image(args.image)
  File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 163,
in build_image
    self.console_boot_serial()
  File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 76,
in console_boot_serial
    self.console_wait_send("OK", "boot\n")
  File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
400, in console_wait_send
    self.console_wait(wait)
  File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
340, in console_wait
    chars =3D vm.console_socket.recv(1)
  File "/home/peter.maydell/qemu-freebsd/tests/vm/../../python/qemu/console=
_socket.py",
line 96, in recv
    raise socket.timeout
socket.timeout


NetBSD failed:
con recv: postfix: rebuilding /etc/mail/aliases (missing /etc/mail/aliases.=
db)
con recv: Starting inetd.
con recv: Starting cron.
con recv: Thu Jul  9 10:40:07 UTC 2020
con recv: NetBSD/amd64 (localhost) (constty)
con recv: login:
con send: qemu<enter>
con recv:  Jul  9 10:40:09 localhost getty[756]: /dev/ttyE2: Device
not configured
con recv: Jul  9 10:40:09 localhost getty[703]: /dev/ttyE3: Device not
configured
con recv: Jul  9 10:40:09 localhost getty[753]: /dev/ttyE1: Device not
configured
con recv: qemu
con recv: Password:
con send: qemupass<enter>
con recv: Login incorrect or refused on this terminal.
console: *** read timeout ***
console: waiting for: 'localhost$'
console: line buffer:

con recv: login:

Failed to prepare guest environment
Traceback (most recent call last):
  File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 628, in m=
ain
    return vm.build_image(args.image)
  File "/home/peter.maydell/qemu-netbsd/tests/vm/netbsd", line 174, in
build_image
    self._config["guest_pass"])
  File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 408,
in console_ssh_init
    self.console_wait_send(prompt,      "mkdir .ssh\n")
  File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 400,
in console_wait_send
    self.console_wait(wait)
  File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 340,
in console_wait
    chars =3D vm.console_socket.recv(1)
  File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/console_=
socket.py",
line 96, in recv
    raise socket.timeout
socket.timeout

arm-linux-static check-tcg failed:
  TEST    pauth-4 on aarch64
  TEST    semihosting on aarch64
  SKIPPED semiconsole on aarch64 because MANUAL ONLY
  TEST    basic gdbstub support
/tmp/tmp6ftb0v61qemu-gdbstub/gdbstub.socket: No such device or address.
SKIPPING (not connected)
  BUILD   TCG tests for aarch64_be-linux-user
  BUILD   aarch64_be-linux-user guest-tests SKIPPED
  RUN     TCG tests for aarch64_be-linux-user
  RUN     tests for aarch64_be-linux-user SKIPPED
make: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
  BUILD   debian10
Error response from daemon: manifest for
registry.gitlab.com/qemu-project/qemu/qemu/debian10:latest not found
make: Leaving directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
make: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
  BUILD   debian-alpha-cross
Error response from daemon: manifest for
registry.gitlab.com/qemu-project/qemu/qemu/debian-alpha-cross:latest
not found
registry.gitlab.com/qemu-project/qemu/qemu/debian10:latest not found
Traceback (most recent call last):
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 701, in <module>
    sys.exit(main())
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 697, in main
    return args.cmdobj.run(args, argv)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 494, in run
    extra_files_cksum=3Dcksum)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 347, in build_image
    quiet=3Dquiet)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 244, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python3.6/subprocess.py", line 311, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t',
'qemu/debian-alpha-cross', '-f',
'/tmp/docker_buildsstz1jcy/tmp_7c70xjh.docker', '--build-arg',
'BUILDKIT_INLINE_CACHE=3D1', '--cache-from',
'registry.gitlab.com/qemu-project/qemu/qemu/debian-alpha-cross',
'/tmp/docker_buildsstz1jcy']' returned non-zero exit status 1.
/home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:58:
recipe for target 'docker-image-debian-alpha-cross' failed
make: *** [docker-image-debian-alpha-cross] Error 1


Also a compile failure on s390x, but since this isn't related
to changes you made afaict I wonder if it's the result of
a change in the build environment:
/home/ubuntu/qemu/block/ssh.c: In function =E2=80=98check_host_key_knownhos=
ts=E2=80=99:
/home/ubuntu/qemu/block/ssh.c:281:28: error: storage size of =E2=80=98state=
=E2=80=99 isn=E2=80=99t known
     enum ssh_known_hosts_e state;
                            ^~~~~
/home/ubuntu/qemu/block/ssh.c:289:13: error: implicit declaration of
function =E2=80=98ssh_session_is_known_server=E2=80=99 [-Werror=3Dimplicit-=
funct
ion-declaration]
     state =3D ssh_session_is_known_server(s->session);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
[and other errors]


thanks
-- PMM

