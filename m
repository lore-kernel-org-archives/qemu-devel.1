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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D96C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA49205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thb3X030"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA49205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqyi-0005lb-6A
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iHquo-0002Pv-VO
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iHqum-00053H-B3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:56:42 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iHqum-00052f-3M
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:56:40 -0400
Received: by mail-oi1-x242.google.com with SMTP id m16so15039613oic.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XhZOtptjq504aM0J4ShnY1KA+M8Tu6+1wGrb9bDLIs0=;
 b=thb3X030l1yfDjyLnbkmsk4RAMFfPT1DcyegwlLy6u1vRRTjgz4zGucXI4g3Ebd1uL
 kMoueP3Mw6aOC0hv6F/8qnrLMwCBEmOe/983xwOpfz7YlwSJcyGi+9t0VT4oSGcaYtva
 K8dDUJBXMUPb9RBJKraKC8oi2ldb5ERbybxp+BFZDGNH1G0X8pIllc2VVakH8xXamJOa
 4RbyIouH093eFzEgUbioMVeaBYVDiF5obNhfAnn2ddUdH6C5eSFmav49ceBI7poe/2IY
 mQbKEn3elSEh0NcHOYkJdYVBI4FXHYNbhIiakGm6ADOFfdMDxUNPThzOoCAV9pE5CgKz
 XUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XhZOtptjq504aM0J4ShnY1KA+M8Tu6+1wGrb9bDLIs0=;
 b=TXdxNCY6KQdsJmetl15zEayeWgReKMMxlEgHugmWhOGpWm4rxOsGFX2gSmBQ5+a7NQ
 aBvTrkc/0jx8WMBoBu1nSPftgkq7C5tFZcrcg5q6EyQO9yUmfeFzUGkLPUBbayMJ2nNw
 DP/UeIMNb1JzwT9de1NOjRgXp14QU069q7CD1BM+COIslu98UvQnagFtNpCjrzTSiWqo
 ndF/los5YqVdUHTIF+bCDWpy0i5PrYSjEPxhyztj9jptCUr6YCQAqQtNlRdrrhLQTChG
 YqdabA621DFQXfPtPldodRjTUaD7U6wPRaLMmFy01AfRbwSim2i/2ujgRv6sTqWw6UvB
 vFwA==
X-Gm-Message-State: APjAAAUTFI6TbxZqgCf9Z0zG5llFnyJNHOBl/xnRtHy7wyyR/h4/Dr7N
 oAjmOoae5OpJvMxUYqPoDaWcFqwgv8NWkexZyys=
X-Google-Smtp-Source: APXvYqxpoG9UEWiyEJUTjgBBjU+W4gf98NSLd+TQZ8nC593M69u42yVe7FM7qM0/07t8HtrSVPMcsZ67OH5R+dhRsKM=
X-Received: by 2002:a54:4084:: with SMTP id i4mr4286951oii.129.1570546599172; 
 Tue, 08 Oct 2019 07:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191007151905.32766-1-philmd@redhat.com>
 <20191007151905.32766-7-philmd@redhat.com>
In-Reply-To: <20191007151905.32766-7-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 8 Oct 2019 22:56:03 +0800
Message-ID: <CAKXe6SL__XptLzvLGyqa0WbUg96KPDfD41ssU1jKe2E7zZnhvA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] tests/fw_cfg: Declare one QFWCFG for all tests
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000025a04d05946760bb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

--00000000000025a04d05946760bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=99=E9=81=
=93=EF=BC=9A

> It is pointless to create/remove a QFWCFG object for each test.
> Move it to the test context and create/remove it only once.
>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  tests/fw_cfg-test.c | 80 ++++++++++++++++++---------------------------
>  1 file changed, 32 insertions(+), 48 deletions(-)
>
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index dda9a9fb07..35af0de7e6 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -25,47 +25,42 @@ static uint16_t boot_menu =3D 0;
>
>  typedef struct {
>      const char *machine_name;
> +    QFWCFG *fw_cfg;
>  } QTestCtx;
>
>  static void test_fw_cfg_signature(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>      char buf[5];
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    qfw_cfg_get(s, fw_cfg, FW_CFG_SIGNATURE, buf, 4);
> +    qfw_cfg_get(s, ctx->fw_cfg, FW_CFG_SIGNATURE, buf, 4);
>      buf[4] =3D 0;
> -
>      g_assert_cmpstr(buf, =3D=3D, "QEMU");
> -    g_free(fw_cfg);
> +
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_id(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>      uint32_t id;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    id =3D qfw_cfg_get_u32(s, fw_cfg, FW_CFG_ID);
> +    id =3D qfw_cfg_get_u32(s, ctx->fw_cfg, FW_CFG_ID);
>      g_assert((id =3D=3D 1) ||
>               (id =3D=3D 3));
> -    g_free(fw_cfg);
> +
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_uuid(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>
>      uint8_t buf[16];
> @@ -76,12 +71,10 @@ static void test_fw_cfg_uuid(const void *opaque)
>
>      s =3D qtest_initf("-M %s -uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8"=
,
>                      ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    qfw_cfg_get(s, fw_cfg, FW_CFG_UUID, buf, 16);
> +    qfw_cfg_get(s, ctx->fw_cfg, FW_CFG_UUID, buf, 16);
>      g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);
>
> -    g_free(fw_cfg);
>      qtest_quit(s);
>
>  }
> @@ -89,80 +82,71 @@ static void test_fw_cfg_uuid(const void *opaque)
>  static void test_fw_cfg_ram_size(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_RAM_SIZE), =3D=3D,
> ram_size);
> +    g_assert_cmpint(qfw_cfg_get_u64(s, ctx->fw_cfg, FW_CFG_RAM_SIZE),
> +                    =3D=3D, ram_size);
>
> -    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_nographic(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NOGRAPHIC), =3D=3D=
, 0);
> +    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_NOGRAPHIC),
> =3D=3D, 0);
>
> -    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_nb_cpus(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NB_CPUS), =3D=3D,
> nb_cpus);
> +    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_NB_CPUS),
> +                    =3D=3D, nb_cpus);
>
> -    g_free(fw_cfg);
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_max_cpus(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_MAX_CPUS), =3D=3D,
> max_cpus);
> -    g_free(fw_cfg);
> +    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_MAX_CPUS),
> +                    =3D=3D, max_cpus);
> +
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_numa(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>      uint64_t *cpu_mask;
>      uint64_t *node_mask;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_NUMA), =3D=3D,
> nb_nodes);
> +    g_assert_cmpint(qfw_cfg_get_u64(s, ctx->fw_cfg, FW_CFG_NUMA),
> +                    =3D=3D, nb_nodes);
>
>      cpu_mask =3D g_new0(uint64_t, max_cpus);
>      node_mask =3D g_new0(uint64_t, nb_nodes);
>
> -    qfw_cfg_read_data(s, fw_cfg, cpu_mask, sizeof(uint64_t) * max_cpus);
> -    qfw_cfg_read_data(s, fw_cfg, node_mask, sizeof(uint64_t) * nb_nodes)=
;
> +    qfw_cfg_read_data(s, ctx->fw_cfg, cpu_mask, sizeof(uint64_t) *
> max_cpus);
> +    qfw_cfg_read_data(s, ctx->fw_cfg, node_mask, sizeof(uint64_t) *
> nb_nodes);
>
>      if (nb_nodes) {
>          g_assert(cpu_mask[0] & 0x01);
> @@ -171,72 +155,68 @@ static void test_fw_cfg_numa(const void *opaque)
>
>      g_free(node_mask);
>      g_free(cpu_mask);
> -    g_free(fw_cfg);
> +
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_boot_menu(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>
>      s =3D qtest_initf("-M %s", ctx->machine_name);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_BOOT_MENU),
> +    g_assert_cmpint(qfw_cfg_get_u16(s, ctx->fw_cfg, FW_CFG_BOOT_MENU),
>                      =3D=3D, boot_menu);
> -    g_free(fw_cfg);
> +
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_reboot_timeout(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>      uint32_t reboot_timeout =3D 0;
>      size_t filesize;
>
>      s =3D qtest_initf("-M %s -boot reboot-timeout=3D15", ctx->machine_na=
me);
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-fail-wait",
> +    filesize =3D qfw_cfg_get_file(s, ctx->fw_cfg, "etc/boot-fail-wait",
>                                  &reboot_timeout, sizeof(reboot_timeout))=
;
>      g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout));
>      reboot_timeout =3D le32_to_cpu(reboot_timeout);
>      g_assert_cmpint(reboot_timeout, =3D=3D, 15);
> -    g_free(fw_cfg);
> +
>      qtest_quit(s);
>  }
>
>  static void test_fw_cfg_splash_time(const void *opaque)
>  {
>      const QTestCtx *ctx =3D opaque;
> -    QFWCFG *fw_cfg;
>      QTestState *s;
>      uint16_t splash_time =3D 0;
>      size_t filesize;
>
>      s =3D qtest_initf("-M %s -boot splash-time=3D12", ctx->machine_name)=
;
> -    fw_cfg =3D pc_fw_cfg_init();
>
> -    filesize =3D qfw_cfg_get_file(s, fw_cfg, "etc/boot-menu-wait",
> +    filesize =3D qfw_cfg_get_file(s, ctx->fw_cfg, "etc/boot-menu-wait",
>                                  &splash_time, sizeof(splash_time));
>      g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));
>      splash_time =3D le16_to_cpu(splash_time);
>      g_assert_cmpint(splash_time, =3D=3D, 12);
> -    g_free(fw_cfg);
> +
>      qtest_quit(s);
>  }
>
>  int main(int argc, char **argv)
>  {
>      QTestCtx ctx;
> +    int ret;
>
>      g_test_init(&argc, &argv, NULL);
>
>      ctx.machine_name =3D "pc";
> +    ctx.fw_cfg =3D pc_fw_cfg_init();
>
>      qtest_add_data_func("fw_cfg/signature", &ctx, test_fw_cfg_signature)=
;
>      qtest_add_data_func("fw_cfg/id", &ctx, test_fw_cfg_id);
> @@ -257,5 +237,9 @@ int main(int argc, char **argv)
>                          test_fw_cfg_reboot_timeout);
>      qtest_add_data_func("fw_cfg/splash_time", &ctx,
> test_fw_cfg_splash_time);
>
> -    return g_test_run();
> +    ret =3D g_test_run();
> +
> +    g_free(ctx.fw_cfg);
> +
> +    return ret;
>  }
> --
> 2.21.0
>
>

--00000000000025a04d05946760bb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:20=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">It is pointless to create/remove a QFWCFG object for each test.<br>
Move it to the test context and create/remove it only once.<br>
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
=C2=A0tests/fw_cfg-test.c | 80 ++++++++++++++++++--------------------------=
-<br>
=C2=A01 file changed, 32 insertions(+), 48 deletions(-)<br>
<br>
diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c<br>
index dda9a9fb07..35af0de7e6 100644<br>
--- a/tests/fw_cfg-test.c<br>
+++ b/tests/fw_cfg-test.c<br>
@@ -25,47 +25,42 @@ static uint16_t boot_menu =3D 0;<br>
<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0const char *machine_name;<br>
+=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0} QTestCtx;<br>
<br>
=C2=A0static void test_fw_cfg_signature(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0char buf[5];<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 qfw_cfg_get(s, fw_cfg, FW_CFG_SIGNATURE, buf, 4);<br>
+=C2=A0 =C2=A0 qfw_cfg_get(s, ctx-&gt;fw_cfg, FW_CFG_SIGNATURE, buf, 4);<br=
>
=C2=A0 =C2=A0 =C2=A0buf[4] =3D 0;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpstr(buf, =3D=3D, &quot;QEMU&quot;);<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_id(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t id;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 id =3D qfw_cfg_get_u32(s, fw_cfg, FW_CFG_ID);<br>
+=C2=A0 =C2=A0 id =3D qfw_cfg_get_u32(s, ctx-&gt;fw_cfg, FW_CFG_ID);<br>
=C2=A0 =C2=A0 =C2=A0g_assert((id =3D=3D 1) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (id =3D=3D 3));<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_uuid(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint8_t buf[16];<br>
@@ -76,12 +71,10 @@ static void test_fw_cfg_uuid(const void *opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s -uuid 4600cb32-38ec-4b2f-=
8acb-81c6ea54f2d8&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ctx-&gt;machine_name);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 qfw_cfg_get(s, fw_cfg, FW_CFG_UUID, buf, 16);<br>
+=C2=A0 =C2=A0 qfw_cfg_get(s, ctx-&gt;fw_cfg, FW_CFG_UUID, buf, 16);<br>
=C2=A0 =C2=A0 =C2=A0g_assert(memcmp(buf, uuid, sizeof(buf)) =3D=3D 0);<br>
<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
<br>
=C2=A0}<br>
@@ -89,80 +82,71 @@ static void test_fw_cfg_uuid(const void *opaque)<br>
=C2=A0static void test_fw_cfg_ram_size(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_RAM_SIZE),=
 =3D=3D, ram_size);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(s, ctx-&gt;fw_cfg, FW_CFG_RA=
M_SIZE),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=3D, ram_size);<br>
<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_nographic(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NOGRAPHIC)=
, =3D=3D, 0);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, ctx-&gt;fw_cfg, FW_CFG_NO=
GRAPHIC), =3D=3D, 0);<br>
<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_nb_cpus(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_NB_CPUS), =
=3D=3D, nb_cpus);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, ctx-&gt;fw_cfg, FW_CFG_NB=
_CPUS),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=3D, nb_cpus);<br>
<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_max_cpus(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_MAX_CPUS),=
 =3D=3D, max_cpus);<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, ctx-&gt;fw_cfg, FW_CFG_MA=
X_CPUS),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=3D, max_cpus);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_numa(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t *cpu_mask;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t *node_mask;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(s, fw_cfg, FW_CFG_NUMA), =3D=
=3D, nb_nodes);<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u64(s, ctx-&gt;fw_cfg, FW_CFG_NU=
MA),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=3D, nb_nodes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0cpu_mask =3D g_new0(uint64_t, max_cpus);<br>
=C2=A0 =C2=A0 =C2=A0node_mask =3D g_new0(uint64_t, nb_nodes);<br>
<br>
-=C2=A0 =C2=A0 qfw_cfg_read_data(s, fw_cfg, cpu_mask, sizeof(uint64_t) * ma=
x_cpus);<br>
-=C2=A0 =C2=A0 qfw_cfg_read_data(s, fw_cfg, node_mask, sizeof(uint64_t) * n=
b_nodes);<br>
+=C2=A0 =C2=A0 qfw_cfg_read_data(s, ctx-&gt;fw_cfg, cpu_mask, sizeof(uint64=
_t) * max_cpus);<br>
+=C2=A0 =C2=A0 qfw_cfg_read_data(s, ctx-&gt;fw_cfg, node_mask, sizeof(uint6=
4_t) * nb_nodes);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (nb_nodes) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert(cpu_mask[0] &amp; 0x01);<br>
@@ -171,72 +155,68 @@ static void test_fw_cfg_numa(const void *opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_free(node_mask);<br>
=C2=A0 =C2=A0 =C2=A0g_free(cpu_mask);<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_boot_menu(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s&quot;, ctx-&gt;machine_na=
me);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, fw_cfg, FW_CFG_BOOT_MENU)=
,<br>
+=C2=A0 =C2=A0 g_assert_cmpint(qfw_cfg_get_u16(s, ctx-&gt;fw_cfg, FW_CFG_BO=
OT_MENU),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D=3D, boot_menu);<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_reboot_timeout(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t reboot_timeout =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0size_t filesize;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s -boot reboot-timeout=3D15=
&quot;, ctx-&gt;machine_name);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(s, fw_cfg, &quot;etc/boot-fail=
-wait&quot;,<br>
+=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(s, ctx-&gt;fw_cfg, &quot;etc/b=
oot-fail-wait&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;reboot_timeout, sizeof(re=
boot_timeout));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_timeout=
));<br>
=C2=A0 =C2=A0 =C2=A0reboot_timeout =3D le32_to_cpu(reboot_timeout);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(reboot_timeout, =3D=3D, 15);<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0static void test_fw_cfg_splash_time(const void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const QTestCtx *ctx =3D opaque;<br>
-=C2=A0 =C2=A0 QFWCFG *fw_cfg;<br>
=C2=A0 =C2=A0 =C2=A0QTestState *s;<br>
=C2=A0 =C2=A0 =C2=A0uint16_t splash_time =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0size_t filesize;<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D qtest_initf(&quot;-M %s -boot splash-time=3D12&qu=
ot;, ctx-&gt;machine_name);<br>
-=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init();<br>
<br>
-=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(s, fw_cfg, &quot;etc/boot-menu=
-wait&quot;,<br>
+=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(s, ctx-&gt;fw_cfg, &quot;etc/b=
oot-menu-wait&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;splash_time, sizeof(splas=
h_time));<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(filesize, =3D=3D, sizeof(splash_time));=
<br>
=C2=A0 =C2=A0 =C2=A0splash_time =3D le16_to_cpu(splash_time);<br>
=C2=A0 =C2=A0 =C2=A0g_assert_cmpint(splash_time, =3D=3D, 12);<br>
-=C2=A0 =C2=A0 g_free(fw_cfg);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qtest_quit(s);<br>
=C2=A0}<br>
<br>
=C2=A0int main(int argc, char **argv)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0QTestCtx ctx;<br>
+=C2=A0 =C2=A0 int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ctx.machine_name =3D &quot;pc&quot;;<br>
+=C2=A0 =C2=A0 ctx.fw_cfg =3D pc_fw_cfg_init();<br>
<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/signature&quot;, &amp;=
ctx, test_fw_cfg_signature);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/id&quot;, &amp;ctx, te=
st_fw_cfg_id);<br>
@@ -257,5 +237,9 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0test_fw_cfg_reboot_timeout);<br>
=C2=A0 =C2=A0 =C2=A0qtest_add_data_func(&quot;fw_cfg/splash_time&quot;, &am=
p;ctx, test_fw_cfg_splash_time);<br>
<br>
-=C2=A0 =C2=A0 return g_test_run();<br>
+=C2=A0 =C2=A0 ret =3D g_test_run();<br>
+<br>
+=C2=A0 =C2=A0 g_free(ctx.fw_cfg);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div></div>

--00000000000025a04d05946760bb--

