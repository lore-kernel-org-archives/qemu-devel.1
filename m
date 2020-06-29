Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65087C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2038C23770
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcb+Jh05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2038C23770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprGq-0007pn-Dv
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jprFq-0006aa-Lx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:43:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:51174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jprFo-0002sz-F5
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:43:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id l17so14918662wmj.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LSNYXKw9o/KWenb+ZfV9MIxYCmx6yqj86l7ltCzXKP4=;
 b=Kcb+Jh05QKcOkkpJK95N3U2zwimgLl4va+Z++3JXOtaWyauaCRP4pXAVVGSSrk8hxc
 1aFdt+gKVyVQl5atYpTcWtsVJUVjoZiRqgaJAlkdVk62SL9NJGVN4JBB1j4EWAUiqPkJ
 4V5np9fyD+8VslhojBKoLZS8Ds9EnnTRo8bBBkMdIGiRMCRJhMcH6PQ+rJhzq++tadxB
 /KVFOi9FjaFXzXTYjWZAEmfXNCcZxZZzExqf/dqK9M54KiAi+mqWGoUXGJGWeYbN3fdc
 oDavNbIWNmfuHuWVOIlRB3uAifBg054kdUu28x95ffdVTCzWedJUh36cB3dlgiCDLrry
 UmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LSNYXKw9o/KWenb+ZfV9MIxYCmx6yqj86l7ltCzXKP4=;
 b=IEG5O80loRCLaUps+IDndrmeXydgjogkfWFkgJlOC2Sn/kfcnc0rSLlWc17kLecKWX
 dmGOV2g0aEdd0wA5hvuLjYft4blXws/nxV3w4aVEJSD71CcUEqT9mrnNZ8timdJmCohr
 X5BkfQaLQyCO03fJPc0flQ22pewZHWnZt4BnlXDzl2xZ8149xf4kbY+0zKIR2BYkNUy6
 nC/kOzwmeReFfPWX7jCt8FXfhaP7yki5u6d0NSHlFpgHWF1VxPpJdLf2dU4NBbj3p3I2
 kERNE8RNXwr/bKp3r0z+4BiMAAKVO+zi/ssSC6O8+Vra+fhgRohpSpjt/mtgnuo8aArA
 8HxQ==
X-Gm-Message-State: AOAM533EbdHDzmTQl5SYftM3YMAwjzZTcPhC0E7SbjTfIhW5uvtRECsS
 EG2QsnuVE247f5wvMM45KrKiPzpGZS0=
X-Google-Smtp-Source: ABdhPJxeOUy01rIFzhfgu3e7FHI5fwEik5Lq1Mmx1AadwFt/JY7CzLwRJtNQqlmttA2d730QdMNMpg==
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr15618525wmh.41.1593427390684; 
 Mon, 29 Jun 2020 03:43:10 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g195sm28657043wme.38.2020.06.29.03.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 03:43:09 -0700 (PDT)
Date: Mon, 29 Jun 2020 11:43:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1884719 <1884719@bugs.launchpad.net>
Subject: Re: [Bug 1884719] [NEW] Function not implemented when using libaio
Message-ID: <20200629104308.GG31392@stefanha-x1.localdomain>
References: <159289799812.6175.17000319886186623286.malonedeb@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <159289799812.6175.17000319886186623286.malonedeb@soybean.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent@vivier.eu, qemu-devel@nongnu.org, fbozuta1@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 07:39:58AM -0000, Martin Grigorov wrote:
> Public bug reported:

CCing Filip and Laurent, who may be interested in adding Linux AIO
syscalls to qemu-user.

>=20
> Hello
>=20
> I experience "Function not implemented" errors when trying to use Linux
> libaio library in foreign architecture, e.g. aarch64.
>=20
> I've faced this problem while using https://github.com/multiarch/qemu-use=
r-static, i.e. Docker+QEMU.=20
> I understand that I do not use plain QEMU and you may count this report a=
s a "distribution of QEMU"! Just let me know what are the steps to test it =
with plain QEMU and I will test and update this ticket!
>=20
>=20
> Here are the steps to reproduce the issue:
>=20
> 1) On x86_64 machine register QEMU:
>=20
>     `docker run -it --rm --privileged multiarch/qemu-user-static --reset
> --credential yes --persistent yes`
>=20
> 2) Start a Docker image with foreign CPU architecture, e.g. aarch64
>=20
>     `docker run -it arm64v8/centos:8 bash`
>=20
> 3) Inside the Docker container install GCC and libaio
>=20
>     `yum install gcc libaio libaio-devel`
>=20
> 4) Compile the following C program
>=20
> ```
> #include <stdio.h>
> #include <errno.h>
> #include <libaio.h>
> #include <stdlib.h>
>=20
> struct io_control {
>     io_context_t ioContext;
> };
>=20
> int main() {
>     int queueSize =3D 10;
>=20
>     struct io_control * theControl =3D (struct io_control *) malloc(sizeo=
f(struct io_control));
>     if (theControl =3D=3D NULL) {
>         printf("theControl is NULL");
>         return 123;
>     }
>=20
>     int res =3D io_queue_init(queueSize, &theControl->ioContext);
>     io_queue_release(theControl->ioContext);
>     free(theControl);
>     printf("res is: %d", res);
> }
> ```
>=20
>     ```
>     cat > test.c
>         [PASTE THE CODE ABOVE HERE]
>     ^D
>     ```
>=20
>     `gcc test.c -o out -laio && ./out`
>=20
>=20
> When executed directly on aarch64 machine (i.e. without emulation) or on =
x86_64 Docker image (e.g. centos:8) it prints `res is: 0`, i.e. it successf=
ully initialized a LibAIO queue.
>=20
> But when executed on Docker image with foreign/emulated CPU architecture
> it prints `res is: -38` (ENOSYS). `man io_queue_init` says that error
> ENOSYS is returned when "Not implemented."
>=20
> Environment:
>=20
> QEMU version: 5.0.0.2  (https://github.com/multiarch/qemu-user-static/blo=
b/master/.travis.yml#L24-L28)
> Container application: Docker
> Output of `docker --version`:
>=20
> ```
> Client:
>  Version:           19.03.8
>  API version:       1.40
>  Go version:        go1.13.8
>  Git commit:        afacb8b7f0
>  Built:             Wed Mar 11 23:42:35 2020
>  OS/Arch:           linux/amd64
>  Experimental:      false
>=20
> Server:
>  Engine:
>   Version:          19.03.8
>   API version:      1.40 (minimum version 1.12)
>   Go version:       go1.13.8
>   Git commit:       afacb8b7f0
>   Built:            Wed Mar 11 22:48:33 2020
>   OS/Arch:          linux/amd64
>   Experimental:     false
>  containerd:
>   Version:          1.3.3-0ubuntu2
>   GitCommit:       =20
>  runc:
>   Version:          spec: 1.0.1-dev
>   GitCommit:       =20
>  docker-init:
>   Version:          0.18.0
>   GitCommit:       =20
> ```
>=20
> Same happens with Ubuntu (arm64v8/ubuntu:focal).
>=20
> I've tried to `strace` it but :
>=20
> ```
> /usr/bin/strace: ptrace(PTRACE_TRACEME, ...): Function not implemented
> /usr/bin/strace: PTRACE_SETOPTIONS: Function not implemented
> /usr/bin/strace: detach: waitpid(112): No child processes
> /usr/bin/strace: Process 112 detached
> ```
>=20
> Here are the steps to reproduce the problem with strace:
>=20
>      ```
>      docker run --rm -it --security-opt seccomp:unconfined --security-opt=
 apparmor:unconfined --privileged --cap-add ALL arm64v8/centos:8 bash
>=20
>      yum install -y strace`
>=20
>      strace echo Test
>      ```
>=20
> Note: I used --privileged, disabled seccomp and apparmor, and added all
> capabilities
>=20
> Disabling security solves the "Permission denied" problem but then comes
> the "Not implemented" one.
>=20
>=20
> Any idea what could be the problem and how to work it around ?
> I've googled a lot but I wasn't able to find any problems related to liba=
io on QEMU.
>=20
> Thank you!
> Martin
>=20
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>=20
> --=20
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1884719
>=20
> Title:
>   Function not implemented when using libaio
>=20
> Status in QEMU:
>   New
>=20
> Bug description:
>   Hello
>=20
>   I experience "Function not implemented" errors when trying to use
>   Linux libaio library in foreign architecture, e.g. aarch64.
>=20
>   I've faced this problem while using https://github.com/multiarch/qemu-u=
ser-static, i.e. Docker+QEMU.=20
>   I understand that I do not use plain QEMU and you may count this report=
 as a "distribution of QEMU"! Just let me know what are the steps to test i=
t with plain QEMU and I will test and update this ticket!
>=20
>  =20
>   Here are the steps to reproduce the issue:
>=20
>   1) On x86_64 machine register QEMU:
>=20
>       `docker run -it --rm --privileged multiarch/qemu-user-static
>   --reset --credential yes --persistent yes`
>=20
>   2) Start a Docker image with foreign CPU architecture, e.g. aarch64
>=20
>       `docker run -it arm64v8/centos:8 bash`
>=20
>   3) Inside the Docker container install GCC and libaio
>=20
>       `yum install gcc libaio libaio-devel`
>=20
>   4) Compile the following C program
>=20
>   ```
>   #include <stdio.h>
>   #include <errno.h>
>   #include <libaio.h>
>   #include <stdlib.h>
>=20
>   struct io_control {
>       io_context_t ioContext;
>   };
>=20
>   int main() {
>       int queueSize =3D 10;
>=20
>       struct io_control * theControl =3D (struct io_control *) malloc(siz=
eof(struct io_control));
>       if (theControl =3D=3D NULL) {
>           printf("theControl is NULL");
>           return 123;
>       }
>=20
>       int res =3D io_queue_init(queueSize, &theControl->ioContext);
>       io_queue_release(theControl->ioContext);
>       free(theControl);
>       printf("res is: %d", res);
>   }
>   ```
>=20
>       ```
>       cat > test.c
>           [PASTE THE CODE ABOVE HERE]
>       ^D
>       ```
>=20
>       `gcc test.c -o out -laio && ./out`
>=20
>  =20
>   When executed directly on aarch64 machine (i.e. without emulation) or o=
n x86_64 Docker image (e.g. centos:8) it prints `res is: 0`, i.e. it succes=
sfully initialized a LibAIO queue.
>=20
>   But when executed on Docker image with foreign/emulated CPU
>   architecture it prints `res is: -38` (ENOSYS). `man io_queue_init`
>   says that error ENOSYS is returned when "Not implemented."
>=20
>   Environment:
>=20
>   QEMU version: 5.0.0.2  (https://github.com/multiarch/qemu-user-static/b=
lob/master/.travis.yml#L24-L28)
>   Container application: Docker
>   Output of `docker --version`:
>=20
>   ```
>   Client:
>    Version:           19.03.8
>    API version:       1.40
>    Go version:        go1.13.8
>    Git commit:        afacb8b7f0
>    Built:             Wed Mar 11 23:42:35 2020
>    OS/Arch:           linux/amd64
>    Experimental:      false
>=20
>   Server:
>    Engine:
>     Version:          19.03.8
>     API version:      1.40 (minimum version 1.12)
>     Go version:       go1.13.8
>     Git commit:       afacb8b7f0
>     Built:            Wed Mar 11 22:48:33 2020
>     OS/Arch:          linux/amd64
>     Experimental:     false
>    containerd:
>     Version:          1.3.3-0ubuntu2
>     GitCommit:       =20
>    runc:
>     Version:          spec: 1.0.1-dev
>     GitCommit:       =20
>    docker-init:
>     Version:          0.18.0
>     GitCommit:       =20
>   ```
>=20
>   Same happens with Ubuntu (arm64v8/ubuntu:focal).
>=20
>   I've tried to `strace` it but :
>=20
>   ```
>   /usr/bin/strace: ptrace(PTRACE_TRACEME, ...): Function not implemented
>   /usr/bin/strace: PTRACE_SETOPTIONS: Function not implemented
>   /usr/bin/strace: detach: waitpid(112): No child processes
>   /usr/bin/strace: Process 112 detached
>   ```
>=20
>   Here are the steps to reproduce the problem with strace:
>=20
>        ```
>        docker run --rm -it --security-opt seccomp:unconfined --security-o=
pt apparmor:unconfined --privileged --cap-add ALL arm64v8/centos:8 bash
>=20
>        yum install -y strace`
>=20
>        strace echo Test
>        ```
>=20
>   Note: I used --privileged, disabled seccomp and apparmor, and added
>   all capabilities
>=20
>   Disabling security solves the "Permission denied" problem but then
>   comes the "Not implemented" one.
>=20
>  =20
>   Any idea what could be the problem and how to work it around ?
>   I've googled a lot but I wasn't able to find any problems related to li=
baio on QEMU.
>=20
>   Thank you!
>   Martin
>=20
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1884719/+subscriptions
>=20

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl75xbwACgkQnKSrs4Gr
c8htWgf/UIS3rZHF4ejgyuhC0mSLd61uXU+9ShigPT2nIYwAHcoHEtUylC6QpRpw
UfJnDJsvJ22EOAmVzfoab74Z+ezE0O+Oog0MlQ7dU/YiF8BJC4bxE/X0TxWaOJ6Y
VIZPi6uvpuQRY3ISff1I5408XmhWWlxbn2k+sE49lF+JmrULtrZuoSU8cHjRoTvO
xzhMYAuMacSG5fUG5eKXfPtss7HmMncvaKGqWphP9E3SqzSqjmZPoMX5h0NFsI+0
QK8n9RROq6MovhgWnnM4EhpzEWVGqLLLm8MR4dfd8BYQEKxBDDXW4DJGUe1ydntq
zr14Pti2v/nm+B/mGdjA0EZ0slHXBA==
=rhlJ
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--

