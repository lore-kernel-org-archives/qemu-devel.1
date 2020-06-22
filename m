Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217E8206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIJ5yoZv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217E8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPzj-0002gL-Dx
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jnPz8-0002Gc-J4
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:11:54 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jnPz6-000421-Bk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:11:54 -0400
Received: by mail-lj1-x243.google.com with SMTP id z9so20181740ljh.13
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iKbhw950iOt04Y7PDRnoZ0DFUWF5Q+3JFIL+cO6bd4M=;
 b=oIJ5yoZvCsLMLXt4DTOnGNRVckHuq+PzjdXJWaZp3AZhQWCVFc2JWskqGExqa6RKM+
 dWqbI0I+ddynweviwcuu9Sa+U1WDoPTqHqgI/fUK+rckUVA030D23/2Vf0ULEg4doUhq
 scC+0x93srX6Gq5lxPjXklx1VbeFw2+qwxlxrcww8J/Uhbel699NzHCFvF5koT7hrmjm
 Dyn6w9RMrUpq6qLZesDC9NGLg9qoIeGqwk4g9KjioHVPqME3PSoypQH1CTuIRf+UnFp6
 84SlXI+s1FCH/dSaLu5OBtcb9MpwusHCaDuhx/3q8UUZc5umgn84S5Yrlw2TZ0EN9e66
 yR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iKbhw950iOt04Y7PDRnoZ0DFUWF5Q+3JFIL+cO6bd4M=;
 b=Oa0EDiRQkt/hQ7YRG4iszGMWQdKdOlE14qdgcNiSPm8V1CSdrP0T0jhcatW1VkEfp8
 NlznxGAYSmW0YoD2qACGfXrcadhalYB73hMc+tVBmIK4NlRRQa4s1C6/2KdR07lzcjyX
 +/PvTD65F1kKGZxaB4hUbb7djfw9QdDM2dUqu68ZhcLF7F/Cuq8IMzi/Gncb+70NGncX
 aidVllxlTRfDIwIsdULx1DMinH11hLlQNCBRiju1h+gdtZGRcQS2pC6vMvw8F6uKsqBa
 NesYHpNgzPl4xrci0aevHQ/eVkrZHsViGjowS/cqSBj0GHr84KCGc5W0KhXNC/wDPlkW
 U79w==
X-Gm-Message-State: AOAM533ptaaITc5pYxF8qVMALIC+EGqJ4LDOxge62eTJDIxO2LM8mItG
 53dUJzACVoDnY+dL0iwKQIAOkFVFBmspJOat21A4tw==
X-Google-Smtp-Source: ABdhPJy9pq4z1UXzVG3xLY9Oc/sY2/pRE2MgItht6guFREhB7suen28qXIKM7o1yBnQVWIxxIS0z7aF+DE1oRMgNNRw=
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr9794190ljj.9.1592845910281;
 Mon, 22 Jun 2020 10:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200622143204.12921-1-alex.bennee@linaro.org>
 <20200622143204.12921-12-alex.bennee@linaro.org>
In-Reply-To: <20200622143204.12921-12-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 22 Jun 2020 13:11:55 -0400
Message-ID: <CAEyhzFu3mY2rksON5wiJPY0x5aFGP3x0W+zhudC-ZmbKN427RA@mail.gmail.com>
Subject: Re: [PATCH v1 11/18] tests/vm: switch from optsparse to argparse
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, f4bug@amsat.org,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

On Mon, 22 Jun 2020 at 10:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> optparse has been deprecated since version 3.2 and argparse is the
> blessed replacement. Take the opportunity to enhance our help output
> showing defaults when called.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/vm/basevm.py | 84 +++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 04d083409a5..93859362606 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -23,7 +23,7 @@ from qemu.accel import kvm_available
>  from qemu.machine import QEMUMachine
>  import subprocess
>  import hashlib
> -import optparse
> +import argparse
>  import atexit
>  import tempfile
>  import shutil
> @@ -556,47 +556,47 @@ def parse_args(vmcls):
>          else:
>              return 1
>
> -    parser =3D optparse.OptionParser(
> -        description=3D"VM test utility.  Exit codes: "
> -                    "0 =3D success, "
> -                    "1 =3D command line error, "
> -                    "2 =3D environment initialization failed, "
> -                    "3 =3D test command failed")
> -    parser.add_option("--debug", "-D", action=3D"store_true",
> -                      help=3D"enable debug output")
> -    parser.add_option("--image", "-i", default=3D"%s.img" % vmcls.name,
> -                      help=3D"image file name")
> -    parser.add_option("--force", "-f", action=3D"store_true",
> -                      help=3D"force build image even if image exists")
> -    parser.add_option("--jobs", type=3Dint, default=3Dget_default_jobs()=
,
> -                      help=3D"number of virtual CPUs")
> -    parser.add_option("--verbose", "-V", action=3D"store_true",
> -                      help=3D"Pass V=3D1 to builds within the guest")
> -    parser.add_option("--build-image", "-b", action=3D"store_true",
> -                      help=3D"build image")
> -    parser.add_option("--build-qemu",
> -                      help=3D"build QEMU from source in guest")
> -    parser.add_option("--build-target",
> -                      help=3D"QEMU build target", default=3D"check")
> -    parser.add_option("--build-path", default=3DNone,
> -                      help=3D"Path of build directory, "\
> -                           "for using build tree QEMU binary. ")
> -    parser.add_option("--interactive", "-I", action=3D"store_true",
> -                      help=3D"Interactively run command")
> -    parser.add_option("--snapshot", "-s", action=3D"store_true",
> -                      help=3D"run tests with a snapshot")
> -    parser.add_option("--genisoimage", default=3D"genisoimage",
> -                      help=3D"iso imaging tool")
> -    parser.add_option("--config", "-c", default=3DNone,
> -                      help=3D"Provide config yaml for configuration. "\
> -                           "See config_example.yaml for example.")
> -    parser.add_option("--efi-aarch64",
> -                      default=3D"/usr/share/qemu-efi-aarch64/QEMU_EFI.fd=
",
> -                      help=3D"Path to efi image for aarch64 VMs.")
> -    parser.add_option("--log-console", action=3D"store_true",
> -                      help=3D"Log console to file.")
> -    parser.disable_interspersed_args()
> -    return parser.parse_args()
> +    parser =3D argparse.ArgumentParser(
> +        formatter_class=3Dargparse.ArgumentDefaultsHelpFormatter,
> +        description=3D"Utility for provisioning VMs and running builds",
> +        epilog=3D"""Remaining arguments are passed to the command.
> +        Exit codes: 0 =3D success, 1 =3D command line error,
> +        2 =3D environment initialization failed,
> +        3 =3D test command failed""")
> +    parser.add_argument("--debug", "-D", action=3D"store_true",
> +                        help=3D"enable debug output")
> +    parser.add_argument("--image", "-i", default=3D"%s.img" % vmcls.name=
,
> +                        help=3D"image file name")
> +    parser.add_argument("--force", "-f", action=3D"store_true",
> +                        help=3D"force build image even if image exists")
> +    parser.add_argument("--jobs", type=3Dint, default=3Dget_default_jobs=
(),
> +                        help=3D"number of virtual CPUs")
> +    parser.add_argument("--verbose", "-V", action=3D"store_true",
> +                        help=3D"Pass V=3D1 to builds within the guest")
> +    parser.add_argument("--build-image", "-b", action=3D"store_true",
> +                        help=3D"build image")
> +    parser.add_argument("--build-qemu",
> +                        help=3D"build QEMU from source in guest")
> +    parser.add_argument("--build-target",
> +                        help=3D"QEMU build target", default=3D"check")
> +    parser.add_argument("--build-path", default=3DNone,
> +                        help=3D"Path of build directory, "\
> +                        "for using build tree QEMU binary. ")
> +    parser.add_argument("--interactive", "-I", action=3D"store_true",
> +                        help=3D"Interactively run command")
> +    parser.add_argument("--snapshot", "-s", action=3D"store_true",
> +                        help=3D"run tests with a snapshot")
> +    parser.add_argument("--genisoimage", default=3D"genisoimage",
> +                        help=3D"iso imaging tool")
> +    parser.add_argument("--config", "-c", default=3DNone,
> +                        help=3D"Provide config yaml for configuration. "=
\
> +                        "See config_example.yaml for example.")
> +    parser.add_argument("--efi-aarch64",
> +                        default=3D"/usr/share/qemu-efi-aarch64/QEMU_EFI.=
fd",
> +                        help=3D"Path to efi image for aarch64 VMs.")
> +    parser.add_argument("--log-console", action=3D"store_true",
> +                        help=3D"Log console to file.")
> +    return parser.parse_known_args()
>
>  def main(vmcls, config=3DNone):
>      try:
> --
> 2.20.1
>
>

