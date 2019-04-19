Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2479DC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 02:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA99521736
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 02:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boiRaHkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA99521736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHJDI-0000HO-69
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 22:25:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hHJCU-0008RV-D0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:24:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hHJCT-0007oN-6V
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:24:26 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hHJCS-0007o4-UE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 22:24:25 -0400
Received: by mail-ot1-x343.google.com with SMTP id u15so3321186otq.10
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 19:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JrLNGAPmFtMkdlNSCqDrWRRgLBwxv6Bct7XEmGHLYYM=;
	b=boiRaHkHnd1qk9bFx+ngViGk4FML5qZrJicrcmPBKdHdos+bTL1iwwX3HbaCMYtEjX
	c8c1aF9dw6HoFCYuyguWqTobKVn/PIRf6RcCSID/dCBZRUixIGX8CML/Rx1XqEhYq1FF
	rHZtuhPHj3t9HvsDDRIbiG1baqhS9+GHC9Uizs1fkMmwzqPtVjeUPSlgjYc91W9xrwbb
	cFArN6wyCpU61yzcLlQK/D5PKEiFFRROi9FqJoOn/zVKjmEnzp3x5PZG7+bCI5yigcrF
	qzywOzubo7qfVU8nLs8FG1qSJpaOviHmQ3rOUus6KzEEmYyipVUIEnhgqV6oIb8Fh4MQ
	Ro4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JrLNGAPmFtMkdlNSCqDrWRRgLBwxv6Bct7XEmGHLYYM=;
	b=lMOvZ/ZGl6+S7FSs+GHJvQ9QfMvSeicvqC/WqT+oMQ1ZEaMKJ2JQ/E18hWkitiNnj5
	EZm3JtRI76HJDQ5SAFbdkJiDP6kpZUbBBpeuQ1okIfJAe8DidcJhakIU2tlWRjRhTNAy
	yQyoR4R9bSibTvPvQJcz3s17kFIvVk0tugWjnlSpumk1tQ0oAx5jY3nU+LB47mReMc5c
	KftRaOMCvkBcfWnIle19OkKazeudfe+TKkoXs5CtE8vISQ07pLykGuZ6G3tcACC2n8Gj
	FGyt/7WrBFvXQZLs9e7y0DOhfBT1M+4wlQ9240z7XNJHXu9qU77FAhMqNcatWt15uL+9
	RUpw==
X-Gm-Message-State: APjAAAXE1FPKW1DkcfE0rlu3vHLo2DZ5xjGdr1boEk80a3OYmyoaHmNt
	qRISrGC6MkFohXdyn8TNEBvOnXR8cr8tUyPcZ/4=
X-Google-Smtp-Source: APXvYqykDcB5ILjrBs+yo/+LAlpEyUliVdbmk8McVC1XuEM4pd7Sgmsw7YuNn8QwEMf/YcHb3ThzTN5BuVAvPEY8Xbc=
X-Received: by 2002:a9d:d66:: with SMTP id 93mr669462oti.25.1555640663371;
	Thu, 18 Apr 2019 19:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190319023030.947-1-liq3ea@163.com>
	<20190319023030.947-3-liq3ea@163.com>
	<979370c0-99ec-aff1-7cf5-350caa6ac773@redhat.com>
In-Reply-To: <979370c0-99ec-aff1-7cf5-350caa6ac773@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 19 Apr 2019 10:23:47 +0800
Message-ID:
 <CAKXe6SJyd=4PoJyZ=k5g52TV67wxQDjQamOOsodR7RYvKH9izQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: fw_cfg: add reboot_timeout test
 case
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419022347.13Y_PNLe1W1uG2ICJgazLYmKrPm258Oqjyiqk02yNMU@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=
=9C=8819=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=885:01=E5=86=99=E9=81=
=93=EF=BC=9A

> Hi Li,
>
> On 3/19/19 3:30 AM, Li Qiang wrote:
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/fw_cfg-test.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> > index 1c5103fe1c..551b51e38f 100644
> > --- a/tests/fw_cfg-test.c
> > +++ b/tests/fw_cfg-test.c
> > @@ -99,6 +99,17 @@ static void test_fw_cfg_boot_menu(void)
> >      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D,
> boot_menu);
> >  }
> >
> > +static void test_fw_cfg_reboot_timeout(void)
> > +{
> > +    uint32_t reboot_timeout =3D 0;
> > +    size_t filesize;
> > +
> > +    filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> > +                     &reboot_timeout, sizeof(reboot_timeout));
> > +    g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
> > +    g_assert_cmpint(reboot_timeout, =3D=3D, 15);
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >      QTestState *s;
> > @@ -106,7 +117,8 @@ int main(int argc, char **argv)
> >
> >      g_test_init(&argc, &argv, NULL);
> >
> > -    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> > +    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 "
> > +                   "-boot reboot-timeout=3D15");
>
> This modify all tests. I'd rather add a specific test with this option.
> Doing so, we can easily modify the timeout and add the <0 and >0xffff
> cases.
>
>
Ok, will do in the next revision.


> Can you think of a 'splash-time' test (for commit 6912bb0b3d3b1)?


Ok.

PS: any comments in the first patch.

Thanks,
Li Qiang


>
> Regards,
>
> Phil.
>
> >
> >      fw_cfg =3D pc_fw_cfg_init(s);
> >
> > @@ -125,6 +137,7 @@ int main(int argc, char **argv)
> >      qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
> >      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
> >      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> > +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout=
);
> >
> >      ret =3D g_test_run();
> >
> >
>
