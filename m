Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A492222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A492222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQGR-00025O-Lu
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDQEF-0008Ui-NX
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDQEE-0006PC-Jb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:38:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDQEE-0006Ol-CO
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:38:26 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E20BC0578F4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:38:25 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t11so689284wrq.19
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yuCYxCfYknIiA8OyeyUeUqfES6lavGi7lsFkvi00w30=;
 b=TfOQFTaR+UDiW+gMEgcKubVeopBYASTgkqWA58v2kjx1uWxNfMyvtdf3QWHZRRjtlE
 qGGJo+PcbkxjVgEB18VpMhOLoXdn7rCTwfCWt8ygRCeVtkLas2SlMgmPXbRUzh1lG0M2
 43ybyr3V1qgzvu0yEEqOoNlpDlp74b5RNfWehgQX0brmpnV8Y4b739+IM5hjo1QPUnSd
 ALY11EQX2l7SwnvLohR/45i2BHIsW7EZYSukDnXEppxQLtSR/oFOaDleV4SEpiZz99AP
 TQc+EXmICPPCL7sgdz307XVT537jNLJk5wyBhkcSvjtgU5zc2QjgPjJYydMPE3Xn7YzL
 g8IQ==
X-Gm-Message-State: APjAAAUlIZp0896EV9PqRCP1pgniuFjM621IO+afBT0Uf0d7vPxNIpbc
 c/mrwgc/YFEtgX1Ag8SflTKeIMBhfWikIE28iCppUCjBLlPRK0BEseNHGMWGhi2pjmeH/0KqxHe
 0ILOOBLvZ2Z7J4m8=
X-Received: by 2002:adf:f112:: with SMTP id r18mr2125334wro.88.1569490703691; 
 Thu, 26 Sep 2019 02:38:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPMoNpUko6LNiHpLLcwr7rz1tRBJrF3iIwvlI26f5zycvvmEzqFp5qCh+aSkKJu5g5b8gdwA==
X-Received: by 2002:adf:f112:: with SMTP id r18mr2125319wro.88.1569490703525; 
 Thu, 26 Sep 2019 02:38:23 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id c8sm2155142wrr.49.2019.09.26.02.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:38:22 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 4/8] scsi: Propagate unrealize() callback to
 scsi-hd
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-5-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4c1642a9-04a1-803a-07f4-0bb71e0353e5@redhat.com>
Date: Thu, 26 Sep 2019 11:38:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925110639.100699-5-sameid@google.com>
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
> We will need to add LCHS removal logic to scsi-hd's unrealize() in the
> next commit.
>=20
> Signed-off-by: Sam Eiderman <sameid@google.com>
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  hw/scsi/scsi-bus.c     | 16 ++++++++++++++++
>  include/hw/scsi/scsi.h |  1 +
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index bccb7cc4c6..359d50d6d0 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -59,6 +59,14 @@ static void scsi_device_realize(SCSIDevice *s, Error=
 **errp)
>      }
>  }
> =20
> +static void scsi_device_unrealize(SCSIDevice *s, Error **errp)
> +{
> +    SCSIDeviceClass *sc =3D SCSI_DEVICE_GET_CLASS(s);
> +    if (sc->unrealize) {
> +        sc->unrealize(s, errp);
> +    }
> +}
> +
>  int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf=
,
>                         void *hba_private)
>  {
> @@ -217,12 +225,20 @@ static void scsi_qdev_realize(DeviceState *qdev, =
Error **errp)
>  static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
>  {
>      SCSIDevice *dev =3D SCSI_DEVICE(qdev);
> +    Error *local_err =3D NULL;
> =20
>      if (dev->vmsentry) {
>          qemu_del_vm_change_state_handler(dev->vmsentry);
>      }
> =20
>      scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));
> +
> +    scsi_device_unrealize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      blockdev_mark_auto_del(dev->conf.blk);
>  }
> =20
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index d77a92361b..332ef602f4 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -59,6 +59,7 @@ struct SCSIRequest {
>  typedef struct SCSIDeviceClass {
>      DeviceClass parent_class;
>      void (*realize)(SCSIDevice *dev, Error **errp);
> +    void (*unrealize)(SCSIDevice *dev, Error **errp);
>      int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
>                       void *hba_private);
>      SCSIRequest *(*alloc_req)(SCSIDevice *s, uint32_t tag, uint32_t lu=
n,
>=20

