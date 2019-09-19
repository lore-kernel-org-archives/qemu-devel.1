Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E27CC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3202621924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3202621924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtKW-0003Mz-68
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAtGr-0008Tp-KH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAtGp-0005yC-P5
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:02:41 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAtGg-0005sX-LF; Thu, 19 Sep 2019 06:02:30 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2OAi-1iDeQR3IBq-003xDq; Thu, 19 Sep 2019 12:02:25 +0200
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190904052739.22123-1-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <525096b9-3be8-b768-bf3f-98b6ae707c2b@vivier.eu>
Date: Thu, 19 Sep 2019 12:02:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904052739.22123-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:owyqM2wD0aZIeujj7H5TrjFg69SEI5w4V2cHWCninWYB5PhqqLC
 WUfz+201V2ndGL+FmUgtZ/pYxfxHuqnWfOt5+w2iALZpI+Fa4g66xqOOCglCNc2Bn1/XbOS
 SoIANdEj0HZi+mYHSz33NHgwuKArNCUVI+Im+zHxgU2LzQVSZ/9L0tJ7OEN1/7v9sXOAZl4
 R9a0CLKqyWrMriv/Y1b2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4a4ezcfjz88=:ui5MyhLeFu42NDrN9GjFcC
 FjhH2MfR00/2bELGKhsRP9DFA8+ceI1+O5ciQEeevAe1zz2jr38DmG9KlwLYURUzMirGKL1nm
 gWPQW/Wf2QyYEJ+06EBOJniPpLelzYW9sqfcxSoDD4KxaB4/9Fv5zKjvMQe6uMxv0MHXeA0i1
 0SR5L1ZGeMrI4nPmnO7TDzwT6F92GGN9KZ86ebVPmCy/ti0gnU0cLw8KWf4Kw5xGzTICutFbz
 KlpC0iDJ6Hdr8hlDDHRIypaDVat1dM1CFXzim/HfcFrAbHzLDpJag5nZcrCwPWrb08GN+Nudn
 c/8dpavPc1TBJ0bKY5qYJZdROFKKuUQN35d9dPJz4niHdnsfR8Utf5remKGzumlk0dITVxetx
 UTtoCJNLi2vd0LnKimuU/LZf+jDRf34palACSLIccGuEXaZXwYfnc37fmeJvyHeYkUbo1CaJy
 wXpovLja84emO5bkr9sROYxw41/CEbSTd199YVnnXmuKt98uf76zF7qxHPBZfS66jpYtkAE7y
 fwgdL5EjSd1YNpLe/XjZO3Qyi6SCG+XhHXGzroC/isNtdvTOARebI7Iw4L6a5pkIirei25SKb
 wAg2wrTxpY1jK1o4CU5MgqOs2dRBnr9rFieNgqkM1FaSWAUlN/vhulFqPI60bLqUGq+r5H/Zo
 ep3tDbhVvdkMB+pZka267aWOGTJqU64VBj1CzfJdo3WwigehZNjLie2A/TqMvyNVRhaBD/5GY
 1LltRgbU1kKEKXl7oFl2rw8zY/xBk98krmRYrE+7ql9b02Hgz9amL1JjRu/TZjrBOIxLRwThn
 x7w22xCJnKdJaq2P0YyAxwcxH1KIC1/Jm8ruzcNDvD2/MNMOpt6JBrbBB18gw5b8wo4Yx7djb
 jzXodOk5PQh8ue8Dg9P8JMUDkdCVdnlX3VFkGQPi8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Replace '-machine
 accel=xyz' with '-accel xyz'
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/09/2019 à 07:27, Thomas Huth a écrit :
> We've got a separate option to configure the accelerator nowadays, which
> is shorter to type and the preferred way of specifying an accelerator.
> Use it in the source and examples to show that it is the favored option.
> (However, do not touch the places yet which also specify other machine
> options or multiple accelerators - these are currently still better
> handled with one single "-machine" statement instead)
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  python/qemu/qtest.py                | 2 +-
>  qemu-deprecated.texi                | 3 +--
>  qemu-options.hx                     | 2 +-
>  tests/libqtest.c                    | 2 +-
>  tests/migration/guestperf/engine.py | 2 +-
>  tests/qemu-iotests/172              | 2 +-
>  6 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
> index eebcc233ed..3f1d2cb325 100644
> --- a/python/qemu/qtest.py
> +++ b/python/qemu/qtest.py
> @@ -96,7 +96,7 @@ class QEMUQtestMachine(QEMUMachine):
>      def _base_args(self):
>          args = super(QEMUQtestMachine, self)._base_args()
>          args.extend(['-qtest', 'unix:path=' + self._qtest_path,
> -                     '-machine', 'accel=qtest'])
> +                     '-accel', 'qtest'])
>          return args
>  
>      def _pre_launch(self):
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 00a4b6f350..0982e41698 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -26,8 +26,7 @@ The @option{enforce-config-section} parameter is replaced by the
>  
>  @subsection -no-kvm (since 1.3.0)
>  
> -The ``-no-kvm'' argument is now a synonym for setting
> -``-machine accel=tcg''.
> +The ``-no-kvm'' argument is now a synonym for setting ``-accel tcg''.
>  
>  @subsection -usbdevice (since 2.10.0)
>  
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 09e6439646..e0bba2abd1 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4156,7 +4156,7 @@ STEXI
>  Enable FIPS 140-2 compliance mode.
>  ETEXI
>  
> -HXCOMM Deprecated by -machine accel=tcg property
> +HXCOMM Deprecated by -accel tcg
>  DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
>  
>  DEF("msg", HAS_ARG, QEMU_OPTION_msg,
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 2713b86cf7..67e39c59e7 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -238,7 +238,7 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>                                "-qtest-log %s "
>                                "-chardev socket,path=%s,id=char0 "
>                                "-mon chardev=char0,mode=control "
> -                              "-machine accel=qtest "
> +                              "-accel qtest "
>                                "-display none "
>                                "%s", qemu_binary, socket_path,
>                                getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
> diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
> index f13dbea800..1dd04ce33b 100644
> --- a/tests/migration/guestperf/engine.py
> +++ b/tests/migration/guestperf/engine.py
> @@ -287,7 +287,7 @@ class Engine(object):
>              cmdline = "'" + cmdline + "'"
>  
>          argv = [
> -            "-machine", "accel=kvm",
> +            "-accel", "kvm",
>              "-cpu", "host",
>              "-kernel", self._kernel,
>              "-initrd", self._initrd,
> diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
> index ba7dad9057..d67997e5f6 100755
> --- a/tests/qemu-iotests/172
> +++ b/tests/qemu-iotests/172
> @@ -55,7 +55,7 @@ do_run_qemu()
>              done
>          fi
>          echo quit
> -    ) | $QEMU -machine accel=qtest -nographic -monitor stdio -serial none "$@"
> +    ) | $QEMU -accel qtest -nographic -monitor stdio -serial none "$@"
>      echo
>  }
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

