Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABE2CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:24:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C3D21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C3D21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrL5-0005ld-01
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMrJm-0004W3-D7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMrJl-0002a9-8H
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMrJl-0002Zt-0M
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:23:09 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A0235945E
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:23:08 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id v26so3952541wmh.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=atEVO1rz6oTHYkIsgb0T9wdGJuAd3VgkGaQV1agFVz4=;
 b=l/P8JAlWhEuLh7mPHcGGSQRAjegwUSLRnet65sO5OcSFxBWZvVI7w67puyOBtDZBG0
 O0gm+/Re2nii1PQKFS2lGwwNSmf1s9iUISZUo6QyEwIOQLYxz7HqRADedunuiOCMUJVR
 pIDUfIT/f7Xr1Ak5z4W2JJ+RG8/1PMEfY3JBzQZVLFEjm4sl2q5m4G2/22V/n+ZtDgbh
 iuvBezLdN0QehoFRvweShRajqyTw7kxAuuelIzsJ2CThH9JBPc6l0yPlkXe4Xj050gBa
 7eYpiS6vifllZI1+toZjR8gTn2O4RUOLF7Lyzkvn33RT9p5+aTPLRtqLq+MKxz9KpvQM
 MG+Q==
X-Gm-Message-State: APjAAAWJR5Ya26mBc2JsWbJa2+PLXLSQTNMu33X4P8Rm0zRN/cjswxUr
 LWWz/r+VjTOv0p6lPHP6GyTwWgaTniZRPmJteKX/vZUZTeefWti7bg5xgapYlVkcWSZpBYU6kOS
 7NUsZmLXd0wsjf4Y=
X-Received: by 2002:a05:6000:114e:: with SMTP id
 d14mr2654180wrx.47.1571739786600; 
 Tue, 22 Oct 2019 03:23:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzbJ2eJBcLZEJaIzH84lRDdmCCzIz2cFim7EkY2jCkRJgyKHliyoRBh/ZbD8EHIu6Ic1QJFOw==
X-Received: by 2002:a05:6000:114e:: with SMTP id
 d14mr2654167wrx.47.1571739786413; 
 Tue, 22 Oct 2019 03:23:06 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id 143sm29947232wmb.33.2019.10.22.03.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 03:23:05 -0700 (PDT)
Subject: Re: [PATCH v8 4/8] scsi: Propagate unrealize() callback to scsi-hd
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20191016164145.115898-1-sameid@google.com>
 <20191016164145.115898-6-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <451cf2d3-44a9-9278-1ead-dce9e6fc60d8@redhat.com>
Date: Tue, 22 Oct 2019 12:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016164145.115898-6-sameid@google.com>
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
> We will need to add LCHS removal logic to scsi-hd's unrealize() in the
> next commit.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> Signed-off-by: Sam Eiderman <sameid@google.com>
> ---
>   hw/scsi/scsi-bus.c     | 16 ++++++++++++++++
>   include/hw/scsi/scsi.h |  1 +
>   2 files changed, 17 insertions(+)
>=20
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index bccb7cc4c6..359d50d6d0 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -59,6 +59,14 @@ static void scsi_device_realize(SCSIDevice *s, Error=
 **errp)
>       }
>   }
>  =20
> +static void scsi_device_unrealize(SCSIDevice *s, Error **errp)
> +{
> +    SCSIDeviceClass *sc =3D SCSI_DEVICE_GET_CLASS(s);
> +    if (sc->unrealize) {
> +        sc->unrealize(s, errp);
> +    }
> +}
> +
>   int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *bu=
f,
>                          void *hba_private)
>   {
> @@ -217,12 +225,20 @@ static void scsi_qdev_realize(DeviceState *qdev, =
Error **errp)
>   static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
>   {
>       SCSIDevice *dev =3D SCSI_DEVICE(qdev);
> +    Error *local_err =3D NULL;
>  =20
>       if (dev->vmsentry) {
>           qemu_del_vm_change_state_handler(dev->vmsentry);
>       }
>  =20
>       scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
> +
> +    scsi_device_unrealize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>       blockdev_mark_auto_del(dev->conf.blk);
>   }
>  =20
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index d77a92361b..332ef602f4 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -59,6 +59,7 @@ struct SCSIRequest {
>   typedef struct SCSIDeviceClass {
>       DeviceClass parent_class;
>       void (*realize)(SCSIDevice *dev, Error **errp);
> +    void (*unrealize)(SCSIDevice *dev, Error **errp);
>       int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
>                        void *hba_private);
>       SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t l=
un,
>=20

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

