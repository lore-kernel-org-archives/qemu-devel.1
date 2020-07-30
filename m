Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1262C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DC12082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 17:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lduqauny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DC12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BzZ-0006MI-WB
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 13:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k1ByN-0005T8-DS
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:04:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k1ByL-0008Rg-Jx
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 13:04:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id p14so6356052wmg.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pchR31nrcO5b0nyQf52oinSOdgGHqZ6o3u5HgtyNLsk=;
 b=lduqaunyqZlfHe+m1f5mqwheeq4SgMH9gVZP+bXkOSIpYddNRSGeYeOhGQ3ezFJUwA
 nAwHpO4B5KNuEl85hqIpx6NzUdLgTAOqJaNY55U43ahJotZ2R1j0saP10CPlyqq0glKN
 L+jOXaXGcpak67hnbDN1wlDdwuuI8WVX8fV881XY0N5XmpzpvdWSva5/4sLXSAptfzCL
 AQFG9m7GO8Wc+EUKt9cUa3iONREhmFhEHBKIbc8MxoL3zFvVotV3u7n1pykDA+4dRm6G
 hM+RBMpPlY3RzwbEEHIuJHVSmwbd0+70H2F/r6Sr4PfEye48QiYhkW9Jej9twAoOoT/j
 pA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pchR31nrcO5b0nyQf52oinSOdgGHqZ6o3u5HgtyNLsk=;
 b=ABQ9wyeNge+uJ+CKq2Hk2SvIydzN4bJvxWAFiqVrKo526/r5/6r9COLDBX1f2TZp2Q
 KlZU/M6OT0C0OHr9Xl6IVAR0sDjbHAiSWwOhsnaHvgLARx0i56iL6cRUjPBJIhTelMYH
 gnj4D1AQ89xM4ULjwPfZ6Dcyt2pcrT/7tjsl7eLbmGZhvHJaCTScFEUkxqNmey0u6/3w
 AG4aTFnzlYI+uXw0G4yz78bkLADXrdwzVQoghg2GOCk97kwUulGdjF//9EcuvGjYMimD
 Z3GWig9KjWpcVihMoxgHcGO2vRwKUuzrIsJE11oqOCg9fgkGXzfkvlz2UK/2b1EmtSO/
 jckQ==
X-Gm-Message-State: AOAM533vE142E1nhQzdunAj0r7hU1ppg2XMo5WPXVw/6Ucx/vDrvjSQB
 n5A4frNsycMo5UeszkItNw/w5w==
X-Google-Smtp-Source: ABdhPJweSrbZ1gHDZRMQF0hXqVFdOY4If/Sjwnx4sei2hbKvQkd2aY+tz4FgtD5w6PEjXr8BP/g5EQ==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr258522wme.16.1596128639053;
 Thu, 30 Jul 2020 10:03:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i14sm13610773wrc.19.2020.07.30.10.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 10:03:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 40BC01FF7E;
 Thu, 30 Jul 2020 18:03:56 +0100 (BST)
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
 <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 12/32] vl: pause option
In-reply-to: <1596122076-341293-13-git-send-email-steven.sistare@oracle.com>
Date: Thu, 30 Jul 2020 18:03:55 +0100
Message-ID: <87r1stdjes.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Steve Sistare <steven.sistare@oracle.com> writes:

> Provide the -pause command-line parameter and the QEMU_PAUSE environment
> variable to briefly pause QEMU in main and allow a developer to attach gd=
b.
> Useful when the developer does not invoke QEMU directly, such as when usi=
ng
> libvirt.

How does this differ from -S?

>
> Usage:
>   qemu -pause <seconds>
>   or
>   export QEMU_PAUSE=3D<seconds>
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qemu-options.hx |  9 +++++++++
>  softmmu/vl.c    | 15 ++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 708583b..8505cf2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3668,6 +3668,15 @@ SRST
>      option is experimental.
>  ERST
>=20=20
> +DEF("pause", HAS_ARG, QEMU_OPTION_pause, \
> +    "-pause secs    Pause for secs seconds on entry to main.\n", QEMU_AR=
CH_ALL)
> +
> +SRST
> +``--pause secs``
> +    Pause for a number of seconds on entry to main.  Useful for attaching
> +    a debugger after QEMU has been launched by some other entity.
> +ERST
> +

It seems like having an option to race with the debugger is just asking
for trouble.

>  DEF("S", 0, QEMU_OPTION_S, \
>      "-S              freeze CPU at startup (use 'c' to start execution)\=
n",
>      QEMU_ARCH_ALL)
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 8478778..951994f 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2844,7 +2844,7 @@ static void create_default_memdev(MachineState *ms,=
 const char *path)
>=20=20
>  void qemu_init(int argc, char **argv, char **envp)
>  {
> -    int i;
> +    int i, seconds;
>      int snapshot, linux_boot;
>      const char *initrd_filename;
>      const char *kernel_filename, *kernel_cmdline;
> @@ -2882,6 +2882,13 @@ void qemu_init(int argc, char **argv, char **envp)
>      QemuPluginList plugin_list =3D QTAILQ_HEAD_INITIALIZER(plugin_list);
>      int mem_prealloc =3D 0; /* force preallocation of physical target me=
mory */
>=20=20
> +    if (getenv("QEMU_PAUSE")) {
> +        seconds =3D atoi(getenv("QEMU_PAUSE"));
> +        printf("Pausing %d seconds for debugger. QEMU PID is %d\n",
> +               seconds, getpid());
> +        sleep(seconds);
> +    }
> +
>      os_set_line_buffering();
>=20=20
>      error_init(argv[0]);
> @@ -3204,6 +3211,12 @@ void qemu_init(int argc, char **argv, char **envp)
>              case QEMU_OPTION_gdb:
>                  add_device_config(DEV_GDB, optarg);
>                  break;
> +            case QEMU_OPTION_pause:
> +                seconds =3D atoi(optarg);
> +                printf("Pausing %d seconds for debugger. QEMU PID is %d\=
n",
> +                            seconds, getpid());
> +                sleep(seconds);
> +                break;
>              case QEMU_OPTION_L:
>                  if (is_help_option(optarg)) {
>                      list_data_dirs =3D true;


--=20
Alex Benn=C3=A9e

