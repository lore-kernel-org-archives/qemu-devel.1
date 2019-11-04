Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7145CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 16:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D49020848
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 16:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2sck0Rl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D49020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRfA4-0001Bm-K3
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 11:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRf8r-0000Kz-Bf
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRf8o-0006bF-Px
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:23:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40811
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRf8o-0006b0-D8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 11:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572884621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHGq6HO7beybjRg5GMGyV8Twdmz4Kmli8kxN95dtWao=;
 b=f2sck0RlIESimbx7rAArXseA46PbZH34X+Fk/pexvQd5kH/Bit84nMz+vdFXLmwnoEBUhO
 8a7AwAN75xnkPQDBz674GARxW7Iajluawxki9NsmhwFj9YNSiSZHRcuDgsYLlGL2VlcdQw
 Whhw/+KNcCvBLkFe7JJ3QefmDnDa5oU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-yCdIMHImPcCWbbQIwkhtiQ-1; Mon, 04 Nov 2019 11:23:40 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so10666513wrp.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 08:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pNMy+IZVqrbstgOvR+DfLKsxfy1JjwRjzypxgp2ol2o=;
 b=VbugUMfqHT2SIWZpY4ZdDRgSFxS1DpOefiLQyjYUs0dB2EguoC7+U/1o+iygMKWOo9
 JBwSrxWaSW/r+Z0EsB6Iq/RhPd7M5YXr2lwKIFJyMCalGA1zo4BozBMilhPXVBfStsyO
 J6MU/CmJJfwKYQhxKTiuUdFaMVO/LrvD+Nap+w2mLPlg1RZFUkjCeEsPKteOgyzcLsuC
 wWGxri1Q0ZFbQErezSOTfTU6tMjyrLBy/HMHwJ9n88f4u/PNAmSO/9hDm9SxkHaYnuXX
 pnZCZg5Zpdw/kqUug1UOR4M0D+RD0/8zK7JhD6PFU+Ljmz7MU+k7QgH1Zt1NQIvHe/Ni
 LIjg==
X-Gm-Message-State: APjAAAUj4cSmbLQEVBWKFKsvxnVbSqfAuYioaNli8dhea4sqs2bYHTmn
 VmSM3XmhX2GTVSXq+4XAz2Z9dQ1JJuw4vzAU3dWBtUdEQw0OJEyX47dX7MRsvcbYoUGc5MW4Ra/
 ZuTWvXji1itOeGO0=
X-Received: by 2002:a1c:f210:: with SMTP id s16mr21258932wmc.24.1572884618178; 
 Mon, 04 Nov 2019 08:23:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3o4dIMDIvVsBRVOc6/5xVcx9Xcb3fgO9QkvZyw8t8EqRhz1nuGGNeHfuywq2G9x70/o4+tA==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr21258913wmc.24.1572884617926; 
 Mon, 04 Nov 2019 08:23:37 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id t1sm21412017wrn.81.2019.11.04.08.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 08:23:37 -0800 (PST)
Subject: Re: [PATCH] tcg plugins: expose an API version concept
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104131836.12566-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3d966b24-ea00-63de-c5a3-b679664590a4@redhat.com>
Date: Mon, 4 Nov 2019 17:23:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104131836.12566-1-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: yCdIMHImPcCWbbQIwkhtiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 2:18 PM, Alex Benn=C3=A9e wrote:
> This is a very simple versioning API which allows the plugin
> infrastructure to check the API a plugin was built against. We also
> expose a min/cur API version to the plugin via the info block in case
> it wants to avoid using old deprecated APIs in the future.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   include/qemu/qemu-plugin.h | 19 +++++++++++++++++++
>   plugins/loader.c           | 15 +++++++++++++++
>   plugins/plugin.h           |  2 ++
>   tests/plugin/bb.c          |  2 ++
>   tests/plugin/empty.c       |  2 ++
>   tests/plugin/hotpages.c    |  2 ++
>   tests/plugin/howvec.c      |  2 ++
>   tests/plugin/insn.c        |  2 ++
>   tests/plugin/mem.c         |  2 ++
>   9 files changed, 48 insertions(+)
>=20
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index a00a7deb461..5502e112c81 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -38,9 +38,28 @@
>  =20
>   typedef uint64_t qemu_plugin_id_t;
>  =20
> +/*
> + * Versioning plugins:
> + *
> + * The plugin API will pass a minimum and current API version that
> + * QEMU currently supports. The minimum API will be incremented if an
> + * API needs to be deprecated.
> + *
> + * The plugins export the API they were built against by exposing the
> + * symbol qemu_plugin_version which can be checked.
> + */
> +
> +extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
> +
> +#define QEMU_PLUGIN_VERSION 0
> +
>   typedef struct {
>       /* string describing architecture */
>       const char *target_name;
> +    struct {
> +        int min;
> +        int cur;
> +    } version;
>       /* is this a full system emulation? */
>       bool system_emulation;
>       union {
> diff --git a/plugins/loader.c b/plugins/loader.c
> index ce724ed5839..1bcca909691 100644
> --- a/plugins/loader.c
> +++ b/plugins/loader.c
> @@ -178,6 +178,19 @@ static int plugin_load(struct qemu_plugin_desc *desc=
, const qemu_info_t *info)
>           goto err_symbol;
>       }
>  =20
> +    if (!g_module_symbol(ctx->handle, "qemu_plugin_version", &sym)) {
> +        warn_report("%s: missing version %s", __func__, g_module_error()=
);
> +    } else {
> +        int version =3D *(int *)sym;
> +        if (version < QEMU_PLUGIN_MIN_VERSION ||
> +            version > QEMU_PLUGIN_VERSION) {
> +            error_report("%s: bad plugin version %d vs %d/%d",
> +                         __func__, version, QEMU_PLUGIN_MIN_VERSION,
> +                         QEMU_PLUGIN_VERSION);
> +            goto err_symbol;
> +        }
> +    }
> +
>       qemu_rec_mutex_lock(&plugin.lock);
>  =20
>       /* find an unused random id with &ctx as the seed */
> @@ -248,6 +261,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
>       g_autofree qemu_info_t *info =3D g_new0(qemu_info_t, 1);
>  =20
>       info->target_name =3D TARGET_NAME;
> +    info->version.min =3D QEMU_PLUGIN_MIN_VERSION;
> +    info->version.cur =3D QEMU_PLUGIN_VERSION;
>   #ifndef CONFIG_USER_ONLY
>       MachineState *ms =3D MACHINE(qdev_get_machine());
>       info->system_emulation =3D true;
> diff --git a/plugins/plugin.h b/plugins/plugin.h
> index 5482168d797..1aa29dcaddf 100644
> --- a/plugins/plugin.h
> +++ b/plugins/plugin.h
> @@ -14,6 +14,8 @@
>  =20
>   #include <gmodule.h>
>  =20
> +#define QEMU_PLUGIN_MIN_VERSION 0
> +
>   /* global state */
>   struct qemu_plugin_state {
>       QTAILQ_HEAD(, qemu_plugin_ctx) ctxs;
> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
> index 45e1de5bd68..f30bea08dcc 100644
> --- a/tests/plugin/bb.c
> +++ b/tests/plugin/bb.c
> @@ -14,6 +14,8 @@
>  =20
>   #include <qemu-plugin.h>
>  =20
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
>   static uint64_t bb_count;
>   static uint64_t insn_count;
>   static bool do_inline;
> diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
> index 3f60f690278..8fa6bacd93d 100644
> --- a/tests/plugin/empty.c
> +++ b/tests/plugin/empty.c
> @@ -13,6 +13,8 @@
>  =20
>   #include <qemu-plugin.h>
>  =20
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
>   /*
>    * Empty TB translation callback.
>    * This allows us to measure the overhead of injecting and then
> diff --git a/tests/plugin/hotpages.c b/tests/plugin/hotpages.c
> index 77df07a3ccf..ecd6c187327 100644
> --- a/tests/plugin/hotpages.c
> +++ b/tests/plugin/hotpages.c
> @@ -18,6 +18,8 @@
>  =20
>   #include <qemu-plugin.h>
>  =20
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  =20
>   static uint64_t page_size =3D 4096;
> diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
> index 58fa675e348..4ca555e1239 100644
> --- a/tests/plugin/howvec.c
> +++ b/tests/plugin/howvec.c
> @@ -20,6 +20,8 @@
>  =20
>   #include <qemu-plugin.h>
>  =20
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  =20
>   typedef enum {
> diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
> index e5fd07fb64b..0a8f5a0000e 100644
> --- a/tests/plugin/insn.c
> +++ b/tests/plugin/insn.c
> @@ -14,6 +14,8 @@
>  =20
>   #include <qemu-plugin.h>
>  =20
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
>   static uint64_t insn_count;
>   static bool do_inline;
>  =20
> diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
> index d9673889896..878abf09d19 100644
> --- a/tests/plugin/mem.c
> +++ b/tests/plugin/mem.c
> @@ -14,6 +14,8 @@
>  =20
>   #include <qemu-plugin.h>
>  =20
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
>   static uint64_t mem_count;
>   static uint64_t io_count;
>   static bool do_inline;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


