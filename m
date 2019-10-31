Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F2BCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C998120862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 23:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C998120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQK34-00061j-UN
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 19:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQK1a-00051c-HW
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQK1Y-00008J-0B
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:38:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQK1V-0008VU-GF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 19:38:39 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A63134E83E
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 23:38:35 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id r16so1536328wrj.4
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 16:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J8bgphd3ygQ74msF+m1sFmeYg6lP0SClY9MLtdmfy28=;
 b=UClNf3gjfIftxdd/etFencEilQW3g/+klDmDy1zpLdluoJx5ibrzh9JEZvK3cxL6Ih
 qoVbl1WmkQNnTY8GJUFP2wDyjxkRdfc1iBafiArlRNJ2Gg900OMD+5sMSi2MDOAJwYdm
 2Df/ekH1urvB9ZWbS1Qm3JZNrFT3ExWKGYtsM5dtWse/8NbWkFiFcPkBXGSK4AznMmHQ
 vs3y3UJfg10vr17Lt3HFF0Tio5KUDiWrQHl49C7tKk4uQjnBfrxYMbqpotFNftlGdZj9
 HxN3Ju2Nf5DWDO1j2k49ohpuFf3hrC3lCNVusYlqoc5Ur6srCa6tIMR6ugeyAyfqyK46
 a6YA==
X-Gm-Message-State: APjAAAWIrQisW7Br4F1FYZVOBlq+VXXCJGNLIskB9CQQMxA3ckhnVo5A
 q25O8/FQic0x+P9FFRgiNKNihnJctB7dd5YMMLv5OjQtA6zuMLEgh8UngzSg1f+E3ZTex3aHtHb
 oYBdD+o2c5vmtG3k=
X-Received: by 2002:a1c:a791:: with SMTP id q139mr7380867wme.155.1572565114396; 
 Thu, 31 Oct 2019 16:38:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMNHQaHsk5dFWxnHcCH0/dvFgB2lbFzbUanOAA/QcOtLRHyZ/ZU2fLnLrtrN6B+JbW5XNoxQ==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr7380849wme.155.1572565114221; 
 Thu, 31 Oct 2019 16:38:34 -0700 (PDT)
Received: from [192.168.20.58] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id b3sm874766wmh.17.2019.10.31.16.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 16:38:33 -0700 (PDT)
Subject: Re: [PATCH v5 11/13] hw/s390x/ipl: replace deprecated qdev_reset_all
 registration
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-12-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29cfdbcc-3e83-a980-f753-dae8549e5853@redhat.com>
Date: Fri, 1 Nov 2019 00:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018150630.31099-12-damien.hedde@greensocs.com>
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, edgari@xilinx.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 5:06 PM, Damien Hedde wrote:
> Replace deprecated qdev_reset_all by resettable_cold_reset_fn for
> the ipl registration in the main reset handlers.
>=20
> This does not impact the behavior for the following reasons:
> + at this point resettable just call the old reset methods of devices
>    and buses in the same order than qdev/qbus.
> + resettable handlers registered with qemu_register_reset are
>    serialized; there is no interleaving.
> + eventual explicit calls to legacy reset API (device_reset or
>    qdev/qbus_reset) inside this reset handler will not be masked out
>    by resettable mechanism; they do not go through resettable api.
>=20
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/ipl.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ca544d64c5..2689f7a017 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -237,7 +237,15 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or **errp)
>        */
>       ipl->compat_start_addr =3D ipl->start_addr;
>       ipl->compat_bios_start_addr =3D ipl->bios_start_addr;
> -    qemu_register_reset(qdev_reset_all_fn, dev);
> +    /*
> +     * Because this Device is not on any bus in the qbus tree (it is
> +     * not a sysbus device and it's not on some other bus like a PCI
> +     * bus) it will not be automatically reset by the 'reset the
> +     * sysbus' hook registered by vl.c like most devices. So we must
> +     * manually register a reset hook for it.

:)

> +     * TODO: there should be a better way to do this.

:(

> +     */
> +    qemu_register_reset(resettable_cold_reset_fn, dev);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   error:
>       error_propagate(errp, err);
>   }
>=20

