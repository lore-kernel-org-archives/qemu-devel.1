Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5567DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A2E2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwBpcEQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A2E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdx7R-0002rV-BJ
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdx5m-0000Iy-2I
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:31:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdx5h-0000Ni-1E
 for qemu-devel@nongnu.org; Wed, 27 May 2020 10:31:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id c3so19947948wru.12
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=v266NxcvI+SW7fzOZTtcWX/Z2u/rmLcE+xxVTX4ncm8=;
 b=vwBpcEQQuyUvXRmItBEsrw1NhvHVtHABLYYxut1BJ4MdJzNeMdo6jCb8tpu17TsWmn
 IKpljxiEnqK2PQ32cdpjghTTUTe0X2tj7KgrZI0MFaEhvZ/Ipntd2Evf58kHcCMq7q+k
 5WnhOppsJ89gptwNJbVf0t6wpdOasNciiEGnd9jY5S2ztgertS1BV+Q9LZr4owlehnhu
 hkSgRi6P5Ex3p80hZbOKJOnuorG6SNVtPHAaFqeGvUs0AlPaGZYheNdimgeTN4krDuM9
 OMyiinnarG7IwZSUOv2xljvcFw5/ZcvzP1jYWbvHE96YnqaZAEYp9/ozD8QWzLn83EX5
 ohVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=v266NxcvI+SW7fzOZTtcWX/Z2u/rmLcE+xxVTX4ncm8=;
 b=jZTbiU9AZZT/V1l4RqMZOe+SwqAZHbkENJI+ZA16ovryE2J0fcBN1QoGqqOQ+Fueqh
 PDbL/jhW0BvJnjAXb6CVA0P36VUTqs4kL6bGqBeD632vMXJMqL4mWcZrR4eJiMVDOZrB
 zgRTCffhE9CvYHBXGSfoIapyQNlOmuEuAXtQP0T+WJD14zuq40/bF36icS/pcmPzbMeg
 4PdkDLeXSxpoe8tNw0teChoR9caFT6p59DhYa6T4kwQMsTx2lTk2N/WBzf2QsyLoTGxp
 o+tUPRbGL2Qq6RU4R+Vr7Yg2OdFp/6CFDg1NIz78rJ1EKz/LQJV0FxiFIBFQD47hrfOq
 yjEw==
X-Gm-Message-State: AOAM532HbtSVQTgov8sSLZ1RlrobzEk/Jzi07vZRpRPA2LFnxjPRkTMF
 t2H6MCAgP3ZzytnoZw2OJO6YHg==
X-Google-Smtp-Source: ABdhPJysf213b5CimM5zg24JCk4TUVTHMx76Q1knTEpeUYmxlPJT9/7SJ1VXVZPYWleKzjsU+ObF9g==
X-Received: by 2002:a5d:630f:: with SMTP id i15mr15676005wru.309.1590589890578; 
 Wed, 27 May 2020 07:31:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y66sm2852099wmy.24.2020.05.27.07.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 07:31:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C70081FF7E;
 Wed, 27 May 2020 15:31:27 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057544969.16818.6615283542905717210.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2 02/11] tests/acceptance: refactor boot_linux_console
 test to allow code reuse
In-reply-to: <159057544969.16818.6615283542905717210.stgit@pasha-ThinkPad-X280>
Date: Wed, 27 May 2020 15:31:27 +0100
Message-ID: <871rn578lc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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

> This patch splits code in BootLinuxConsole class into two different
> classes to allow reusing it by record/replay tests.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index c6b06a1a13..f23c5833b7 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -28,19 +28,13 @@ try:
>  except CmdNotFoundError:
>      P7ZIP_AVAILABLE =3D False
>=20=20
> -class BootLinuxConsole(Test):
> -    """
> -    Boots a Linux kernel and checks that the console is operational and =
the
> -    kernel command line is properly passed from QEMU to the kernel
> -    """
> -
> -    timeout =3D 90
> -
> +class LinuxKernelUtils(Test):

I'm not super keen on the name given it is being sub-classed. Maybe:

  class LinuxKernelTest(Test):

and then:

  class BootLinuxConsole(LinuxKernelTest)

?


Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

