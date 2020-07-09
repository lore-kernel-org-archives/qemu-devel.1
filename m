Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DD820720
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTlE05ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DD820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYls-00046E-Rc
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtYkr-0003fW-GT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:46:33 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtYkp-0005p1-7H
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:46:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id o8so2370048wmh.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Df8Xk9tKzOjLGI7IkSJIy2lMh0lOQhdJJGiTca8lnws=;
 b=YTlE05tiLsNyxthkooojMAbCj/L/ltaIKEu2iTeKCLEzm17II9MuyBNA6CFnjxMSpO
 62ddOkZmzrZYso3tq9BC29/xOCJ14H2aa1WM2An9E/aenlmuEF5Rl8DLObOSf91+tK/W
 AIntstQyUV7jbeb2KjcFp46ndGp6Uu6HYK7XugIvWNvFBBxxyGQ3XMuThzM2o7pRjGYc
 3EloHPN8JXEkR573e1FOHVbtnHXhDKDKB4XJa28hE9A5be3ph0rf86CHI/AOTf8vxj19
 Fq39+fV2aDALepoY1xGvuO0grHOBYkcyo+kbGbYcix5zfanHt2dyGlYfs4vOJZ1Utx+A
 B8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Df8Xk9tKzOjLGI7IkSJIy2lMh0lOQhdJJGiTca8lnws=;
 b=W8vPELw2hT3r4C/Ql43tbKC0cie+pS4ZTFIljagUCJwqjJnRZvP87pqc8NjEGEdjMN
 lqdcpOEjCvLuiyyJCfleiTwRSftzEAHdTLUHqLpF2umciHKnTAhTjT1YkaBRkLzzc0If
 fZOkEUz4YyUGGp/8K5IlKCuEXXwLfOgd5GRa4nOSaSWB6/Wc7FsL7NXvBS1cDBMiSlQX
 PsJ7IF8GIfJrAgVcT08O4XfZLqPdNkGeO/SF/NP3JNUYpk11zHMkPabKTsNM6bB8nnK/
 1FtcEVZqB7yBrvZvH7Uo89rANSoORLt8I0pycFkFtvcLJZXKCEuyRBeIcu9TmzafNJwZ
 XDjA==
X-Gm-Message-State: AOAM531L+bFLFRFxNecI91PTW7AObyaUs1Bbsjm3wUwXvXbgcfCTA4Ed
 gwpsOhTffRkprUGm+SR9OvZYipDT/iU=
X-Google-Smtp-Source: ABdhPJzF9yoo6eesTjA5fFv/W1md0XghGW+yJI2vFMyrEj2bZ0k3hNGd1eSSrzOYu3zYfcUYX9Lwhw==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr648612wme.177.1594309589454; 
 Thu, 09 Jul 2020 08:46:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f186sm5283809wmf.29.2020.07.09.08.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 08:46:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 522181FF7E;
 Thu,  9 Jul 2020 16:46:27 +0100 (BST)
References: <20200707070858.6622-1-alex.bennee@linaro.org>
 <CAFEAcA80gPAFRsJcFyO8ogNbSa_ex6fSaxnBYU6awU=Ug+Y7wg@mail.gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/41] testing updates (vm, gitlab, misc build fixes)
In-reply-to: <CAFEAcA80gPAFRsJcFyO8ogNbSa_ex6fSaxnBYU6awU=Ug+Y7wg@mail.gmail.com>
Date: Thu, 09 Jul 2020 16:46:27 +0100
Message-ID: <878sfsn12k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 7 Jul 2020 at 08:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> There will be some docker failures until the official repository has
>> seeded but local builds should continue to work.
>>
>> ----
>>
>> The following changes since commit eb6490f544388dd24c0d054a96dd304bc7284=
450:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20=
200703' into staging (2020-07-04 16:08:41 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-070720-1
>>
>> for you to fetch changes up to 6a726e8ca0286e3ed69945abd447099f6f6a903c:
>>
>>   tests/qht-bench: Adjust threshold computation (2020-07-07 07:57:41 +01=
00)
>>
>> ----------------------------------------------------------------
>> Testing and build updates:
>>
>>   - tests/vm support for aarch64 VMs
>>   - tests/tcg better cross-compiler detection
>>   - update docker tooling to support registries
>>   - gitlab build docker images and store in registry
>>   - gitlab use docker images for builds
>>   - a number of skipIf updates to support move
>>   - linux-user MAP_FIXED_NOREPLACE fix
>>   - qht-bench compiler tweaks
>>   - configure fix for secret keyring
>>   - tsan fiber annotation clean-up
>
> freebsd failed:
>
<snip>
>
> con recv:  set console=3Dcomconso
>
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line 628, i=
n main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 163,
> in build_image
>     self.console_boot_serial()
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/freebsd", line 76,
> in console_boot_serial
>     self.console_wait_send("OK", "boot\n")
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
> 400, in console_wait_send
>     self.console_wait(wait)
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/basevm.py", line
> 340, in console_wait
>     chars =3D vm.console_socket.recv(1)
>   File "/home/peter.maydell/qemu-freebsd/tests/vm/../../python/qemu/conso=
le_socket.py",
> line 96, in recv
>     raise socket.timeout
> socket.timeout

Hmm works for me, but I'm guessing you have V=3D1?

> NetBSD failed:
> con recv: postfix: rebuilding /etc/mail/aliases (missing /etc/mail/aliase=
s.db)
> con recv: Starting inetd.
> con recv: Starting cron.
> con recv: Thu Jul  9 10:40:07 UTC 2020
> con recv: NetBSD/amd64 (localhost) (constty)
> con recv: login:
> con send: qemu<enter>
> con recv:  Jul  9 10:40:09 localhost getty[756]: /dev/ttyE2: Device
> not configured
> con recv: Jul  9 10:40:09 localhost getty[703]: /dev/ttyE3: Device not
> configured
> con recv: Jul  9 10:40:09 localhost getty[753]: /dev/ttyE1: Device not
> configured
> con recv: qemu
> con recv: Password:
> con send: qemupass<enter>
> con recv: Login incorrect or refused on this terminal.
> console: *** read timeout ***
> console: waiting for: 'localhost$'
> console: line buffer:
>
> con recv: login:
>
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 628, in=
 main
>     return vm.build_image(args.image)
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/netbsd", line 174, in
> build_image
>     self._config["guest_pass"])
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 408,
> in console_ssh_init
>     self.console_wait_send(prompt,      "mkdir .ssh\n")
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 400,
> in console_wait_send
>     self.console_wait(wait)
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/basevm.py", line 340,
> in console_wait
>     chars =3D vm.console_socket.recv(1)
>   File "/home/peter.maydell/qemu-netbsd/tests/vm/../../python/qemu/consol=
e_socket.py",
> line 96, in recv
>     raise socket.timeout
> socket.timeout

OK that I can replicate. So it looks like our console bypass has an
issue. I'll dig into it.

> arm-linux-static check-tcg failed:
>   TEST    pauth-4 on aarch64
>   TEST    semihosting on aarch64
>   SKIPPED semiconsole on aarch64 because MANUAL ONLY
>   TEST    basic gdbstub support
> /tmp/tmp6ftb0v61qemu-gdbstub/gdbstub.socket: No such device or address.
> SKIPPING (not connected)
>   BUILD   TCG tests for aarch64_be-linux-user
>   BUILD   aarch64_be-linux-user guest-tests SKIPPED
>   RUN     TCG tests for aarch64_be-linux-user
>   RUN     tests for aarch64_be-linux-user SKIPPED
> make: Entering directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>   BUILD   debian10
> Error response from daemon: manifest for
> registry.gitlab.com/qemu-project/qemu/qemu/debian10:latest not found
> make: Leaving directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
> make: Entering directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>   BUILD   debian-alpha-cross
> Error response from daemon: manifest for
> registry.gitlab.com/qemu-project/qemu/qemu/debian-alpha-cross:latest
> not found
> registry.gitlab.com/qemu-project/qemu/qemu/debian10:latest not found
> Traceback (most recent call last):
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 701, in <module>
>     sys.exit(main())
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 697, in main
>     return args.cmdobj.run(args, argv)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 494, in run
>     extra_files_cksum=3Dcksum)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 347, in build_image
>     quiet=3Dquiet)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 244, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib/python3.6/subprocess.py", line 311, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
> 'qemu/debian-alpha-cross', '-f',
> '/tmp/docker_buildsstz1jcy/tmp_7c70xjh.docker', '--build-arg',
> 'BUILDKIT_INLINE_CACHE=3D1', '--cache-from',
> 'registry.gitlab.com/qemu-project/qemu/qemu/debian-alpha-cross',
> '/tmp/docker_buildsstz1jcy']' returned non-zero exit status 1.
> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:58:
> recipe for target 'docker-image-debian-alpha-cross' failed
> make: *** [docker-image-debian-alpha-cross] Error 1

This is it tripping up on missing registry (as I switched the registry
from my previous patch posts to point to the "official" gitlab). You can
work around this for now by passing:

  make check-tcg REGISTRY=3Dregistry.gitlab.com/stsquad/qemu

I also just posted:

  Subject: [PATCH  v1 11/13] tests/docker: fall back more gracefully when p=
ull fails
  Date: Thu,  9 Jul 2020 15:13:25 +0100
  Message-Id: <20200709141327.14631-12-alex.bennee@linaro.org>

Maybe I should just squash it into:

  tests/docker: add --registry support to tooling

?

> Also a compile failure on s390x, but since this isn't related
> to changes you made afaict I wonder if it's the result of
> a change in the build environment:
> /home/ubuntu/qemu/block/ssh.c: In function =E2=80=98check_host_key_knownh=
osts=E2=80=99:
> /home/ubuntu/qemu/block/ssh.c:281:28: error: storage size of =E2=80=98sta=
te=E2=80=99 isn=E2=80=99t known
>      enum ssh_known_hosts_e state;
>                             ^~~~~
> /home/ubuntu/qemu/block/ssh.c:289:13: error: implicit declaration of
> function =E2=80=98ssh_session_is_known_server=E2=80=99 [-Werror=3Dimplici=
t-funct
> ion-declaration]
>      state =3D ssh_session_is_known_server(s->session);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> [and other errors]

As Philippe said I don't think this was me.

--=20
Alex Benn=C3=A9e

