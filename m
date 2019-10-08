Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D51C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:20:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7726620673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GENjxDcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7726620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqM2-0002Y6-Jb
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHqEo-0004K5-8n
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHqEk-0006tb-Bz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:13:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHqEi-0006rd-Br
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:13:14 -0400
Received: by mail-oi1-x244.google.com with SMTP id t84so14855698oih.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s1+bSOSQkvvhpwTchVQ6zTncT3e/uEcAR3yVK5HkL84=;
 b=GENjxDcZmhPjon7EMWKhchneQY3FFGrRbDSvOWlqeSBKHisLqvOyLiTmwxISuWK9Go
 DGKM41TE2YrkbhUuoLDjsohHs2MXGbh8MqwBQstJnkgxdcd5DR6/vd4uZmKhzTJ5Iptr
 53JeQPolVNB6tL8WyZAfukyKTbRlZpSYbSQ2FI3EHhwUOCRLBc+nrc4X8vdQRLeZtLaV
 f7u2ZS3vB/VoTRdrxgxAM28JQVfWba82DyFbp7RAUZvcPD8E4XTAp/7KjStPh0dMDxPt
 GUS+tst3XALJ9BpJkWHHB0ndRQsqRzO7RYGYoKPdlBHzALTupgLGKQxj9dL+ur5eDd94
 7+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s1+bSOSQkvvhpwTchVQ6zTncT3e/uEcAR3yVK5HkL84=;
 b=V7N9qdqgimUWhqEzLT1MYE94mlXVn/WYBjP00DJmmOIs9BM2O0FL+eTyOWJ3YfhPsq
 wgVPlO8UJwq/lpzCql3UvsyHVAhdH5V0R2XztLFjSR6DUpG8VskmcBNwSkzoPgNOk0Kj
 AUvGoBc0At+UmEZNthfo0iq/+xyM/euWjyp3zb7o5Z8/n50Skq47Zn9/4bh0E8YzaY0j
 VijtZw3DGTT/OCAUdCQTKbhYNKSh42jeRWAb71lZxKvALb70ifXcygM/nSgl3cO17rbt
 FpAvolpov31QYw5lgOVhFLmtOYjMbyMkk68sSfwyX43Fv0ArEOPEJz+ZqiZVoTdYUhD9
 153A==
X-Gm-Message-State: APjAAAWfO+OYnWAAPTBnRHPbh8ntRZCI6ZTbQ2gA7UclhqIqYntyQ4He
 H0WqNnivVeWOOu4IETcXPqWptgiJDXjk81rNZqE=
X-Google-Smtp-Source: APXvYqx6S3p1gIh+3v11aZD1qPBddT7cze4O9JIadut67UApQAtkqaiaX80/ALskm2RjTF7PT6F3eQMmWIR343HP0zM=
X-Received: by 2002:aca:f1d7:: with SMTP id p206mr4143617oih.97.1570543990175; 
 Tue, 08 Oct 2019 07:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-5-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-5-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 22:12:33 +0800
Message-ID: <CAKXe6S+2yqN4LBOapHbb+DnwJfjPb+QDrHnP0WWdbLQT2qPc2A@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] tests/fw_cfg: Let the tests use a context
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a37ec4059466c41a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a37ec4059466c41a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=99=E9=81=
=93=EF=BC=9A

> Introduce the local QTestCtx structure, and register the tests
> with qtest_add_data_func(ctx).
> For now the context only contains the machine name (which is
> fixed to the 'pc' machine, since this test only runs on the
> x86 architecture).
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
> v2: Use const QTestCtx *ctx, do not g_new(QTestCtx) (Laszlo)
> ---
>  tests/fw_cfg-test.c | 87 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 54 insertions(+), 33 deletions(-)
>
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 53ae82f7c8..65785bca73 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -23,13 +23,18 @@ static uint16_t max_cpus =3D 1;
>  static uint64_t nb_nodes =3D 0;
>  static uint16_t boot_menu =3D 0;
>
> -static void test_fw_cfg_signature(void)
> +typedef struct {
> +    const char *machine_name;
> +} QTestCtx;
> +
> +static void test_fw_cfg_signature(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>      char buf[5];
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);
> @@ -40,13 +45,14 @@ static void test_fw_cfg_signature(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_id(void)
> +static void test_fw_cfg_id(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>      uint32_t id;
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
> @@ -56,8 +62,9 @@ static void test_fw_cfg_id(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_uuid(void)
> +static void test_fw_cfg_uuid(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>
> @@ -67,7 +74,8 @@ static void test_fw_cfg_uuid(void)
>          0x8a, 0xcb, 0x81, 0xc6, 0xea, 0x54, 0xf2, 0xd8,
>      };
>
> -    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> +    s =3D qtest_initf("-M %s -uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"=
,
> +                    ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);
> @@ -78,12 +86,13 @@ static void test_fw_cfg_uuid(void)
>
>  }
>
> -static void test_fw_cfg_ram_size(void)
> +static void test_fw_cfg_ram_size(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE), =3D=3D,
> ram_size);
> @@ -92,12 +101,13 @@ static void test_fw_cfg_ram_size(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_nographic(void)
> +static void test_fw_cfg_nographic(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D, 0=
);
> @@ -106,12 +116,13 @@ static void test_fw_cfg_nographic(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_nb_cpus(void)
> +static void test_fw_cfg_nb_cpus(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS), =3D=3D, nb_=
cpus);
> @@ -120,12 +131,13 @@ static void test_fw_cfg_nb_cpus(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_max_cpus(void)
> +static void test_fw_cfg_max_cpus(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS), =3D=3D,
> max_cpus);
> @@ -133,14 +145,15 @@ static void test_fw_cfg_max_cpus(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_numa(void)
> +static void test_fw_cfg_numa(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>      uint64_t *cpu_mask;
>      uint64_t *node_mask;
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =3D=3D, nb_nod=
es);
> @@ -162,12 +175,13 @@ static void test_fw_cfg_numa(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_boot_menu(void)
> +static void test_fw_cfg_boot_menu(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>
> -    s =3D qtest_init("");
> +    s =3D qtest_initf("-M %s", ctx->machine_name);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D,
> boot_menu);
> @@ -175,14 +189,15 @@ static void test_fw_cfg_boot_menu(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_reboot_timeout(void)
> +static void test_fw_cfg_reboot_timeout(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>      uint32_t reboot_timeout =3D 0;
>      size_t filesize;
>
> -    s =3D qtest_init("-boot reboot-timeout=3D15");
> +    s =3D qtest_initf("-M %s -boot reboot-timeout=3D15", ctx->machine_na=
me);
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> @@ -194,14 +209,15 @@ static void test_fw_cfg_reboot_timeout(void)
>      qtest_quit(s);
>  }
>
> -static void test_fw_cfg_splash_time(void)
> +static void test_fw_cfg_splash_time(const void *opaque)
>  {
> +    const QTestCtx *ctx =3D opaque;
>      QFWCFG *fw_cfg;
>      QTestState *s;
>      uint16_t splash_time =3D 0;
>      size_t filesize;
>
> -    s =3D qtest_init("-boot splash-time=3D12");
> +    s =3D qtest_initf("-M %s -boot splash-time=3D12", ctx->machine_name)=
;
>      fw_cfg =3D pc_fw_cfg_init(s);
>
>      filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-menu-wait",
> @@ -215,25 +231,30 @@ static void test_fw_cfg_splash_time(void)
>
>  int main(int argc, char **argv)
>  {
> +    QTestCtx ctx;
> +
>      g_test_init(&argc, &argv, NULL);
>
> -    qtest_add_func("fw_cfg/signature", test_fw_cfg_signature);
> -    qtest_add_func("fw_cfg/id", test_fw_cfg_id);
> -    qtest_add_func("fw_cfg/uuid", test_fw_cfg_uuid);
> -    qtest_add_func("fw_cfg/ram_size", test_fw_cfg_ram_size);
> -    qtest_add_func("fw_cfg/nographic", test_fw_cfg_nographic);
> -    qtest_add_func("fw_cfg/nb_cpus", test_fw_cfg_nb_cpus);
> +    ctx.machine_name =3D "pc";
> +
> +    qtest_add_data_func("fw_cfg/signature", &ctx, test_fw_cfg_signature)=
;
> +    qtest_add_data_func("fw_cfg/id", &ctx, test_fw_cfg_id);
> +    qtest_add_data_func("fw_cfg/uuid", &ctx, test_fw_cfg_uuid);
> +    qtest_add_data_func("fw_cfg/ram_size", &ctx, test_fw_cfg_ram_size);
> +    qtest_add_data_func("fw_cfg/nographic", &ctx, test_fw_cfg_nographic)=
;
> +    qtest_add_data_func("fw_cfg/nb_cpus", &ctx, test_fw_cfg_nb_cpus);
>  #if 0
>      qtest_add_func("fw_cfg/machine_id", test_fw_cfg_machine_id);
>      qtest_add_func("fw_cfg/kernel", test_fw_cfg_kernel);
>      qtest_add_func("fw_cfg/initrd", test_fw_cfg_initrd);
>      qtest_add_func("fw_cfg/boot_device", test_fw_cfg_boot_device);
>  #endif
> -    qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
> -    qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
> -    qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> -    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
> -    qtest_add_func("fw_cfg/splash_time", test_fw_cfg_splash_time);
> +    qtest_add_data_func("fw_cfg/max_cpus", &ctx, test_fw_cfg_max_cpus);
> +    qtest_add_data_func("fw_cfg/numa", &ctx, test_fw_cfg_numa);
> +    qtest_add_data_func("fw_cfg/boot_menu", &ctx, test_fw_cfg_boot_menu)=
;
> +    qtest_add_data_func("fw_cfg/reboot_timeout", &ctx,
> +                        test_fw_cfg_reboot_timeout);
> +    qtest_add_data_func("fw_cfg/splash_time", &ctx,
> test_fw_cfg_splash_time);
>
>      return g_test_run();
>  }
> --
> 2.21.0
>
>

--000000000000a37ec4059466c41a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Introduce the local QTestCtx structure, and register the tests<br>
with qtest_add_data_func(ctx).<br>
For now the context only contains the machine name (which is<br>
fixed to the &#39;pc&#39; machine, since this test only runs on the<br>
x86 architecture).<br>
<br>
Reviewed-by: Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com" target=
=3D"_blank">lersek@redhat.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail=
.com">liq3ea@gmail.com</a>&gt;<br></div><div></div></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
v2: Use const QTestCtx *ctx, do not g_new(QTestCtx) (Laszlo)<br>
---<br>
=C2=A0tests/fw_cfg-test.c | 87 ++++++++++++++++++++++++++++----------------=
-<br>
=C2=A01 file changed, 54 insertions(+), 33 deletions(-)<br>
<br>
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c<br>
index 53ae82f7c8..65785bca73 100644<br>
--- a/tests/fw_cfg-test.c<br>
+++ b/tests/fw_cfg-test.c<br>
@@ -23,13 +23,18 @@ static uint16_t max_cpus =3D 1;<br>
=C2=A0static uint64_t nb_nodes =3D 0;<br>
=C2=A0static uint16_t boot_menu =3D 0;<br>
<br>
-static void test_fw_cfg_signature(void)<br>
+typedef struct {<br>
+=C2=A0 =C2=A0 const char *machine_name;<br>
+} QTestCtx;<br>
+<br>
+static void test_fw_cfg_signature(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0char buf[5];<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qfw_cfg_get(fw_cfg, FW_CFG_SIGNATURE, buf, 4);<br>
@@ -40,13 +45,14 @@ static void test_fw_cfg_signature(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_id(void)<br>
+static void test_fw_cfg_id(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t id;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0id =3D qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);<br>
@@ -56,8 +62,9 @@ static void test_fw_cfg_id(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_uuid(void)<br>
+static void test_fw_cfg_uuid(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
@@ -67,7 +74,8 @@ static void test_fw_cfg_uuid(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x8a, 0xcb, 0x81, 0xc6, 0xea, 0x54, 0xf2,=
 0xd8,<br>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;-uuid 4600cb32-38ec-4b2f-8acb-81c6ea5=
4f2d8&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s -uuid 4600cb32-38ec-4b2f-8acb-=
81c6ea54f2d8&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctx-=
&gt;machine_name);<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qfw_cfg_get(fw_cfg, FW_CFG_UUID, buf, 16);<br>
@@ -78,12 +86,13 @@ static void test_fw_cfg_uuid(void)<br>
<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_ram_size(void)<br>
+static void test_fw_cfg_ram_size(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE=
), =3D=3D, ram_size);<br>
@@ -92,12 +101,13 @@ static void test_fw_cfg_ram_size(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_nographic(void)<br>
+static void test_fw_cfg_nographic(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NOGRAPHI=
C), =3D=3D, 0);<br>
@@ -106,12 +116,13 @@ static void test_fw_cfg_nographic(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_nb_cpus(void)<br>
+static void test_fw_cfg_nb_cpus(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_NB_CPUS)=
, =3D=3D, nb_cpus);<br>
@@ -120,12 +131,13 @@ static void test_fw_cfg_nb_cpus(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_max_cpus(void)<br>
+static void test_fw_cfg_max_cpus(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_MAX_CPUS=
), =3D=3D, max_cpus);<br>
@@ -133,14 +145,15 @@ static void test_fw_cfg_max_cpus(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_numa(void)<br>
+static void test_fw_cfg_numa(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t *cpu_mask;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t *node_mask;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u64(fw_cfg, FW_CFG_NUMA), =
=3D=3D, nb_nodes);<br>
@@ -162,12 +175,13 @@ static void test_fw_cfg_numa(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_boot_menu(void)<br>
+static void test_fw_cfg_boot_menu(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_name);<=
br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MEN=
U), =3D=3D, boot_menu);<br>
@@ -175,14 +189,15 @@ static void test_fw_cfg_boot_menu(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_reboot_timeout(void)<br>
+static void test_fw_cfg_reboot_timeout(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t reboot_timeout =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0size_t filesize;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;-boot reboot-timeout=3D15&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s -boot reboot-timeout=3D15&quot=
;, ctx-&gt;machine_name);<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0filesize =3D qfw_cfg_get_file(fw_cfg, &quot;etc/boot-fa=
il-wait&quot;,<br>
@@ -194,14 +209,15 @@ static void test_fw_cfg_reboot_timeout(void)<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
-static void test_fw_cfg_splash_time(void)<br>
+static void test_fw_cfg_splash_time(const void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const QTestCtx *ctx =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t splash_time =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0size_t filesize;<br>
<br>
-=C2=A0 =C2=A0 s =3D qtest_init(&quot;-boot splash-time=3D12&quot;);<br>
+=C2=A0 =C2=A0 s =3D qtest_initf(&quot;-M %s -boot splash-time=3D12&quot;, =
ctx-&gt;machine_name);<br>
=C2=A0 =C2=A0 =C2=A0fw_cfg =3D pc_fw_cfg_init(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0filesize =3D qfw_cfg_get_file(fw_cfg, &quot;etc/boot-me=
nu-wait&quot;,<br>
@@ -215,25 +231,30 @@ static void test_fw_cfg_splash_time(void)<br>
<br>
=C2=A0int main(int argc, char **argv)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 QTestCtx ctx;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/signature&quot;, test_fw_cfg_sig=
nature);<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/id&quot;, test_fw_cfg_id);<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/uuid&quot;, test_fw_cfg_uuid);<b=
r>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/ram_size&quot;, test_fw_cfg_ram_=
size);<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/nographic&quot;, test_fw_cfg_nog=
raphic);<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/nb_cpus&quot;, test_fw_cfg_nb_cp=
us);<br>
+=C2=A0 =C2=A0 ctx.machine_name =3D &quot;pc&quot;;<br>
+<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/signature&quot;, &amp;ctx, =
test_fw_cfg_signature);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/id&quot;, &amp;ctx, test_fw=
_cfg_id);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/uuid&quot;, &amp;ctx, test_=
fw_cfg_uuid);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/ram_size&quot;, &amp;ctx, t=
est_fw_cfg_ram_size);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/nographic&quot;, &amp;ctx, =
test_fw_cfg_nographic);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/nb_cpus&quot;, &amp;ctx, te=
st_fw_cfg_nb_cpus);<br>
=C2=A0#if 0<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;fw_cfg/machine_id&quot;, test_fw_c=
fg_machine_id);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;fw_cfg/kernel&quot;, test_fw_cfg_k=
ernel);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;fw_cfg/initrd&quot;, test_fw_cfg_i=
nitrd);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;fw_cfg/boot_device&quot;, test_fw_=
cfg_boot_device);<br>
=C2=A0#endif<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/max_cpus&quot;, test_fw_cfg_max_=
cpus);<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/numa&quot;, test_fw_cfg_numa);<b=
r>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/boot_menu&quot;, test_fw_cfg_boo=
t_menu);<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/reboot_timeout&quot;, test_fw_cf=
g_reboot_timeout);<br>
-=C2=A0 =C2=A0 qtest_add_func(&quot;fw_cfg/splash_time&quot;, test_fw_cfg_s=
plash_time);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/max_cpus&quot;, &amp;ctx, t=
est_fw_cfg_max_cpus);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/numa&quot;, &amp;ctx, test_=
fw_cfg_numa);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/boot_menu&quot;, &amp;ctx, =
test_fw_cfg_boot_menu);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/reboot_timeout&quot;, &amp;=
ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 test_fw_cfg_reboot_timeout);<br>
+=C2=A0 =C2=A0 qtest_add_data_func(&quot;fw_cfg/splash_time&quot;, &amp;ctx=
, test_fw_cfg_splash_time);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return g_test_run();<br>
=C2=A0}<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>

--000000000000a37ec4059466c41a--

