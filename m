Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426E2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165D120B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165D120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrTa-0005gN-4S
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMrSY-0004ex-TC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMrSX-0006kq-Mk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:32:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMrSX-0006kQ-DE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:32:13 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56BB4C057EC6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:32:12 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o128so8323546wmo.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=74soXi8sIcSFDaZXmtEvxPvP85Uf4YBUzbunDHoBzQQ=;
 b=CsjW+Af425iatbBgc0U3ujZHvVzmxEAO/1hlFcqjR6zym7TUYW2uAk7s5dlHg8jcmv
 tY49untB6K0bMFcVub1M9wnDb7powUF85aFS4eq14cw/nTWm1Roq4kacBESrd7vDKufJ
 /GTzmXqVyWeQXTnBXWLiVR/tJUK8ehCR/JyefW4lviNMglyAczBjopeL5kGZzBxsJ0gm
 eVnB9sWJo1zBp+mdXcfMQFZUcSq0ukhWzQhBq76LkbFpmUuExoGimf5KuB/56zduWv6X
 C/YAzBYdEwCEUWRXUPTZgo16brqp5XEsePeH+YnnFKF0Pw2qcrWMOnc3yCAtd888pxvT
 YYRw==
X-Gm-Message-State: APjAAAUE2k9BOCXIZdwzk6snq858aeTWVHaEb6Oo+GANv4ENeOiWpjOa
 lST6bPP3pTPMgdZ+1/QA9xPK35SqifFn9F+QeYKxjvQHVAET5mN9ZnuvMGPx0kLgOD1TskOkA9i
 uiRKMwFD+r01xUWA=
X-Received: by 2002:a05:600c:23cc:: with SMTP id
 p12mr2321275wmb.163.1571740331058; 
 Tue, 22 Oct 2019 03:32:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWIMXxsJJOs3QfvWxmWEPtDNB0SL4790zYGzdk5oENsRcpzqogfI9s4ZigBuaVSR5nyRUWgg==
X-Received: by 2002:a05:600c:23cc:: with SMTP id
 p12mr2321257wmb.163.1571740330851; 
 Tue, 22 Oct 2019 03:32:10 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id p15sm17904502wrs.94.2019.10.22.03.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 03:32:10 -0700 (PDT)
Subject: Re: [PATCH v8 6/8] bootdevice: Refactor get_boot_devices_list
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20191016164145.115898-1-sameid@google.com>
 <20191016164145.115898-8-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e4970108-366b-70a2-20da-f3174a19a182@redhat.com>
Date: Tue, 22 Oct 2019 12:32:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016164145.115898-8-sameid@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 jsnow@redhat.com, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, lersek@redhat.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 6:41 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>=20
> Move device name construction to a separate function.
>=20
> We will reuse this function in the following commit to pass logical CHS
> parameters through fw_cfg much like we currently pass bootindex.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> Signed-off-by: Sam Eiderman <sameid@google.com>
> ---
>   bootdevice.c | 61 +++++++++++++++++++++++++++++----------------------=
-
>   1 file changed, 34 insertions(+), 27 deletions(-)
>=20
> diff --git a/bootdevice.c b/bootdevice.c
> index bc5e1c2de4..2cf6b37c57 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -202,6 +202,39 @@ DeviceState *get_boot_device(uint32_t position)
>       return res;
>   }
>  =20
> +static char *get_boot_device_path(DeviceState *dev, bool ignore_suffix=
es,
> +                                  const char *suffix)
> +{
> +    char *devpath =3D NULL, *s =3D NULL, *d, *bootpath;
> +
> +    if (dev) {
> +        devpath =3D qdev_get_fw_dev_path(dev);
> +        assert(devpath);
> +    }
> +
> +    if (!ignore_suffixes) {
> +        if (dev) {
> +            d =3D qdev_get_own_fw_dev_path_from_handler(dev->parent_bu=
s, dev);
> +            if (d) {
> +                assert(!suffix);
> +                s =3D d;
> +            } else {
> +                s =3D g_strdup(suffix);
> +            }
> +        } else {
> +            s =3D g_strdup(suffix);
> +        }
> +    }
> +
> +    bootpath =3D g_strdup_printf("%s%s",
> +                               devpath ? devpath : "",
> +                               s ? s : "");
> +    g_free(devpath);
> +    g_free(s);
> +
> +    return bootpath;
> +}
> +
>   /*
>    * This function returns null terminated string that consist of new l=
ine
>    * separated device paths.
> @@ -218,36 +251,10 @@ char *get_boot_devices_list(size_t *size)
>       bool ignore_suffixes =3D mc->ignore_boot_device_suffixes;
>  =20
>       QTAILQ_FOREACH(i, &fw_boot_order, link) {
> -        char *devpath =3D NULL,  *suffix =3D NULL;
>           char *bootpath;
> -        char *d;
>           size_t len;
>  =20
> -        if (i->dev) {
> -            devpath =3D qdev_get_fw_dev_path(i->dev);
> -            assert(devpath);
> -        }
> -
> -        if (!ignore_suffixes) {
> -            if (i->dev) {
> -                d =3D qdev_get_own_fw_dev_path_from_handler(i->dev->pa=
rent_bus,
> -                                                          i->dev);
> -                if (d) {
> -                    assert(!i->suffix);
> -                    suffix =3D d;
> -                } else {
> -                    suffix =3D g_strdup(i->suffix);
> -                }
> -            } else {
> -                suffix =3D g_strdup(i->suffix);
> -            }
> -        }
> -
> -        bootpath =3D g_strdup_printf("%s%s",
> -                                   devpath ? devpath : "",
> -                                   suffix ? suffix : "");
> -        g_free(devpath);
> -        g_free(suffix);
> +        bootpath =3D get_boot_device_path(i->dev, ignore_suffixes, i->=
suffix);
>  =20
>           if (total) {
>               list[total-1] =3D '\n';
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

