Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A8C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E592222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E592222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQJQ-0004dz-FE
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDQIP-0003Zp-V6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDQIO-0007zf-T7
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDQIO-0007z6-Jj
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:42:44 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 993B71108
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:42:43 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id n3so900786wmf.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fF9WstA1jzY7IOVsdCnlx5srPyFDY8mRUz1FOORQrbQ=;
 b=kvJrcYaG/4L3tgbB/nVy6J7VPnVFEJn8uJzmi611EzAsIw3X8/xOFjMXz5nv+Yo8KN
 UrrI9/0AAzRZE/PbcGewDDVHZ8PLJJWGeQ/KJ63Mk51eIcDOBLR0MDplMM5CaAZaKBIr
 IwcU79actK1NJr9iPrCozs2u0ToLstg+GEFP+x6OLISGMdRXRvz70zuIsO5BZ7aTGW8o
 lSsH15sFPGpsPh7ga2ZAmES7HFSxWK14MDboLFUrCXQkpvxYNS1fi1Tm3s9W5bCCANIZ
 hYds+StLmxwy0fjHlYVSD9Zi4unnRocl9OrW6aChBBQvMAUeX/pTmL0eyX8+RTh6HRhR
 mfnw==
X-Gm-Message-State: APjAAAXJnLQmD/RfeBZlhG+Rja4B/L1fKQiqBLgqjyHRZCA+BJ434Zrc
 73scOmH3XyOQwslWkKGRMA3+S1DcY8kX90SmViElu20t3UxA0p7RCmvUiUAKqBWMgA/FjHQVJGS
 G0WtkGav6Gs6ZxDg=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr44182wru.205.1569490962326;
 Thu, 26 Sep 2019 02:42:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxAWN8vYDRietjbnGI8bsPY+tbBcFTa+EtOp2fHd1GiO5At5xiuVXcpgGJRjvaLW9oO4Ut3pw==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr44160wru.205.1569490962107;
 Thu, 26 Sep 2019 02:42:42 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id w22sm1585661wmc.16.2019.09.26.02.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:42:41 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 6/8] bootdevice: Refactor
 get_boot_devices_list
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-7-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5b8e3d3f-b9a0-f846-5f20-3a8e3bfb37ed@redhat.com>
Date: Thu, 26 Sep 2019 11:42:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925110639.100699-7-sameid@google.com>
Content-Type: text/plain; charset=utf-8
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
 seabios@seabios.org, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 1:06 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>=20
> Move device name construction to a separate function.
>=20
> We will reuse this function in the following commit to pass logical CHS
> parameters through fw_cfg much like we currently pass bootindex.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  bootdevice.c | 61 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 34 insertions(+), 27 deletions(-)
>=20
> diff --git a/bootdevice.c b/bootdevice.c
> index bc5e1c2de4..2b12fb85a4 100644
> --- a/bootdevice.c
> +++ b/bootdevice.c
> @@ -202,6 +202,39 @@ DeviceState *get_boot_device(uint32_t position)
>      return res;
>  }
> =20
> +static char *get_boot_device_path(DeviceState *dev, bool ignore_suffix=
es,
> +                                  char *suffix)

Please update to 'const char *suffix'.
John, can you do it directly in your tree before sending the pull request=
?
With it:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


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
>  /*
>   * This function returns null terminated string that consist of new li=
ne
>   * separated device paths.
> @@ -218,36 +251,10 @@ char *get_boot_devices_list(size_t *size)
>      bool ignore_suffixes =3D mc->ignore_boot_device_suffixes;
> =20
>      QTAILQ_FOREACH(i, &fw_boot_order, link) {
> -        char *devpath =3D NULL,  *suffix =3D NULL;
>          char *bootpath;
> -        char *d;
>          size_t len;
> =20
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
> =20
>          if (total) {
>              list[total-1] =3D '\n';
>=20

