Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE233C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 01:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789B9207E8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 01:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sku+qTaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789B9207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqngw-0001RW-Nl
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 21:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqngB-0000zH-H5
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 21:06:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqng9-0004hp-QO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 21:06:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id b6so26009555wrs.11
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 18:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WDDcxQBvRYkOYt8YLQElBhLJz9s2tOqARauhyEUsW80=;
 b=Sku+qTazIx9tUZzA9yS/ATPDZYuvI5dX5GJuFfYg5QRma7R0HQ3BwPJcd16q123DRK
 Nd+JSu/fss6mwhoyq8Ciy0O+NLGeS4tn2w1vxPMbJGOWGiKEGUY86CD2TGP+ebEvkbxV
 QyBEIFqZsCdSyiCb869e72cmYu9hO4AD/MqTpe0AQpQ4RPuyHlMaaNEmRc+3fo5fGVx5
 Trp++FqbNknB4MgEfZBXkyO6SLkf0nWXHbBz0iiPXI6VdRZvldARtWV8OoUkAENNCOVc
 FrlLwYZsgAdV2yp+DVTf425MhL02z4c9VWO04Li1juK6/Sno8+MQXtDAu2/vj2zGo1Za
 GsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WDDcxQBvRYkOYt8YLQElBhLJz9s2tOqARauhyEUsW80=;
 b=twC1p+0je3BOJIHuYNBTxYyOL/dUUP1qaY5PxVMu3gimkpJv1Veph7mBQKD9oXjVRX
 KK6zlmOvtIgNoDILRXcx9jGwpbToQrk1CBYdd28iOwvOcgE8soUE01aW0+V7ysHlKIFQ
 aH/WmSkUtwYBAotQOPrc+EwIvFKDbe2S2r9Vp45Xx93bdaQjcwkzUyb5Sv1UFZKydcX9
 RvA3iLCWgTr7i+9RKZ1bdT6fGGUmzJr4qIJRxERrtZPKLqjOC7ovfZljoUxv0CJ0xKzr
 BC4FPIV8VJvFwgP3vK6T5e7tljUnLtbp66CoXB4ByT4LI/6RAhIhpHYMGepQJS65kstu
 zMFg==
X-Gm-Message-State: AOAM531SnqYOudjcobsyTyfFVBhklH0wXVu4QGJP8bxgjpIMmfFgw2QC
 rBAkQwGhN9YBJhuEpRkC6EtvoowbzAChZdcTVfs=
X-Google-Smtp-Source: ABdhPJwGO8lpmc42bubYndNniq4LfqiN7dLuNQquAYyhjNbRRwdgnIWolYS4HUzvQNRFye4Uu5OZx3RzdYt4fZYPAYs=
X-Received: by 2002:a5d:6907:: with SMTP id t7mr28982001wru.329.1593651967300; 
 Wed, 01 Jul 2020 18:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-29-alex.bennee@linaro.org>
In-Reply-To: <20200701135652.1366-29-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 2 Jul 2020 03:05:55 +0200
Message-ID: <CAHiYmc7tXuRiS51-pyoj6NoJppbkcObzcEggvAav2GWqwMoYgQ@mail.gmail.com>
Subject: Re: [PATCH v4 28/40] tests/acceptance: skip multicore mips_malta
 tests on GitLab
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G . Cota" <cota@braap.org>, Cleber Rosa <crosa@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 4:03 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> For some reason these tests fail all the time on GitLab. I can
> re-create the hang around 3% of the time locally but it doesn't seem
> to be MTTCG related. For now skipIf on GITLAB_CI.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---

Alex,

Thanks for having this test at all. I will review its content, but
here is my stupid question:

How can I, as a regular developer, repro the test in question? I am
not familiar with GitLab at all.

Thanks,
Aleksandar

>  tests/acceptance/machine_mips_malta.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/ma=
chine_mips_malta.py
> index 92b4f28a112..7c9a4ee4d2d 100644
> --- a/tests/acceptance/machine_mips_malta.py
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -15,6 +15,7 @@ from avocado import skipUnless
>  from avocado_qemu import Test
>  from avocado_qemu import wait_for_console_pattern
>  from avocado.utils import archive
> +from avocado import skipIf
>
>
>  NUMPY_AVAILABLE =3D True
> @@ -99,6 +100,7 @@ class MaltaMachineFramebuffer(Test):
>          """
>          self.do_test_i6400_framebuffer_logo(1)
>
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>          """
>          :avocado: tags=3Darch:mips64el
> @@ -108,6 +110,7 @@ class MaltaMachineFramebuffer(Test):
>          """
>          self.do_test_i6400_framebuffer_logo(7)
>
> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
>      def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>          """
>          :avocado: tags=3Darch:mips64el
> --
> 2.20.1
>

