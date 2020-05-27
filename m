Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288F3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DE3208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSSjfRy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DE3208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdwva-0000au-4r
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdwui-0008FA-NR
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:20:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdwuh-000714-A3
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:20:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id j198so2389738wmj.0
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=A4AReW0H9HvC6ngTxkLLKkfxchUfukerwlsxbZImcKs=;
 b=qSSjfRy9jKdh8jRSi7GwYuA4AOvhwVDXEdgdSRKkxt+EfTEGWWtrJFuvaVzyiKK3os
 BEiZtZgb65kUBO+7wTj9tWoKcDoTi9+Owt231tVeOpV0IL9DQDNOvraSiGRHaRDmsKyZ
 jY2TkjhI3MCAPW0Cs6w2a9Y7ZTlCe+DzwmJQ5lonW97GmlVrKPQKFKByJxSoLznRYd7o
 PG0SsEfDfkWNxJAXALoRIHCzNdTwiCrjUuQcr0NrFY4m+BQ8o+Ps9A8Aa0RYC6qZu0fJ
 8DrNI/r5V8lj6AWnSeH/gdduWewN2nAWXzs31ex33fxkjClLIQWOmm53isZQvgzTpr2S
 TC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=A4AReW0H9HvC6ngTxkLLKkfxchUfukerwlsxbZImcKs=;
 b=hTE6Qm9ZW0pO6E2sCRAbb9egooGrMTeBpZcN8h5nlL9W3ZZy5569ZbcV5CwZnxOmro
 r24RdKSHiTueRFb5IavS3yFtYDaMS//ESxDC17yMxJccZ2WUDQeKJM5Z9Jaa3ApJRBcs
 TTKvKWIsHIV83c1tRCk3lGfhsu5It8QbFqKA0Jf+07RhGfPKwUtd9fm8ai1iAZfgVkbq
 EzU1Ph2sTFOor3RhxwuodDBrZy0TpJsPqJhQZbxZ3gDwJIS1HVumytuCLkblLn0VHbVs
 KBYhjjgNc8XDc2+3sumcjab41oidr5RN6tJqnlsSm/gaSR8dM4sShreXuX9k8cClRyIi
 5/pA==
X-Gm-Message-State: AOAM5321DZmTTasHOXKtw6hYugYgsv7RiYxgWrdN7UOnvUMlYL0sRG7l
 UlA6OUwQF0I/4u5t3WC/nKXlKA==
X-Google-Smtp-Source: ABdhPJyPcsF2N9gKji+BlyodVMebLjk4KMoUB6V6eeSoWkT/Z2oJHijtuWzoxCSHWbvFKi8rFf0Azg==
X-Received: by 2002:a1c:b0c8:: with SMTP id z191mr4665911wme.165.1590589208780; 
 Wed, 27 May 2020 07:20:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u23sm3260968wmu.20.2020.05.27.07.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:20:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5CADE1FF7E;
 Wed, 27 May 2020 15:20:05 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057544414.16818.6329438674514481731.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2 01/11] tests/acceptance: allow console interaction
 with specific VMs
In-reply-to: <159057544414.16818.6329438674514481731.stgit@pasha-ThinkPad-X280>
Date: Wed, 27 May 2020 15:20:05 +0100
Message-ID: <874ks1794a.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:

> Console interaction in avocado scripts was possible only with single
> default VM.
> This patch modifies the function parameters to allow passing a specific
> VM as a parameter to interact with it.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Reviewed-by: Willian Rampazzo <willianr@redhat.com>
> ---
>  0 files changed
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 59e7b4f763..77d1c1d9ff 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -69,13 +69,15 @@ def pick_default_qemu_bin(arch=3DNone):
>=20=20
>=20=20
>  def _console_interaction(test, success_message, failure_message,
> -                         send_string, keep_sending=3DFalse):
> +                         send_string, keep_sending=3DFalse, vm=3DNone):

is it not possible to make vm=3Dtest.vm to avoid having...

>      assert not keep_sending or send_string
> -    console =3D test.vm.console_socket.makefile()
> +    if vm is None:
> +        vm =3D test.vm

to do this here?

> +    console =3D vm.console_socket.makefile()
>      console_logger =3D logging.getLogger('console')
>      while True:
>          if send_string:
> -            test.vm.console_socket.sendall(send_string.encode())
> +            vm.console_socket.sendall(send_string.encode())
>              if not keep_sending:
>                  send_string =3D None # send only once
>          msg =3D console.readline().strip()
> @@ -115,7 +117,8 @@ def interrupt_interactive_console_until_pattern(test,=
 success_message,
>      _console_interaction(test, success_message, failure_message,
>                           interrupt_string, True)
>=20=20
> -def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne):
> +def wait_for_console_pattern(test, success_message, failure_message=3DNo=
ne,
> +                             vm=3DNone):
>      """
>      Waits for messages to appear on the console, while logging the conte=
nt
>=20=20
> @@ -125,7 +128,7 @@ def wait_for_console_pattern(test, success_message, f=
ailure_message=3DNone):
>      :param success_message: if this message appears, test succeeds
>      :param failure_message: if this message appears, test fails
>      """
> -    _console_interaction(test, success_message, failure_message, None)
> +    _console_interaction(test, success_message, failure_message, None, v=
m=3Dvm)
>=20=20
>  def exec_command_and_wait_for_pattern(test, command,
>                                        success_message, failure_message=
=3DNone):

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

