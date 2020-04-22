Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AE9C55189
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9943D20781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRr3CxuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9943D20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRDXg-00024w-Nj
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 07:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRDWb-0000V3-Oy
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRDWa-00044a-JW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:26:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38444
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRDWa-0003w5-4k
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 07:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587554798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cawM04ElyiHP1EMJi7Z+U+tTQby5nuVH6HHuFpZge0U=;
 b=hRr3CxuGg1vSxxaRNlM9svbQM9lrYlQQv0zh8c5rn9FIHEFI3LaZp5lpM70wpkD9Trre/n
 e0MCMGyZzINTBEmZ6vuWzPskSuTY/CT/9FdxyHPWaCfzWv9q80zI31HVFgJKsPQndp6wAc
 b+jtN74xV7YeNLb8ibfzixB89t+lbkg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-oF7qzS-2NA2NVRhlE8TMAQ-1; Wed, 22 Apr 2020 07:26:37 -0400
X-MC-Unique: oF7qzS-2NA2NVRhlE8TMAQ-1
Received: by mail-wr1-f72.google.com with SMTP id p16so880612wro.16
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 04:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B7RZLlPW3eIPV3kxfLKDG3xa/XEQ1D7wJaes+8h+iOQ=;
 b=PpEpzZw1J4N1cRz6ABjiQ/Hg/+KHErJocHNqx847+B1mtkvfFXz0WaHkITnw6ekgDd
 N+/o0c8JBihWi36UjbRpk5Wh1vHVq8thSJerdKLLf8b46eq+UTM+1lI+FzzxExHJwC/A
 g8WME/Zh7KGDUlW/5jWyF+U0MUpFZdg+UQlho5RlrIV2dHOuDgwRotm/JRCRJZfTdrLa
 CCjtJyRP0LJgv23f0LGgRZKcp58WAr5RIcohn9LMiNAsgnCAWivZBusVS4Qv3SIIFRbM
 2gPD94rIoDvti5N/NBb+uKAtmLIxkUS0SYkdX+Qkmv9pn40fLKorYosr1jWkXb5eyXuW
 Ghig==
X-Gm-Message-State: AGi0PuY/fwBbKpn4ZcFUNvLQmGK+v2EE19tH+uOrVGErf6RYr7fKlluS
 oG3neqRqYAbQp8yiFnqD0RlNB3fmkrgmHRtuwTKTd++RTfSRLv3zVExeiTcwpE/EgfuovHLMMRw
 5AHxSNQzikIU0d/A=
X-Received: by 2002:a1c:48c:: with SMTP id 134mr9480291wme.47.1587554795606;
 Wed, 22 Apr 2020 04:26:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzLoV3PbjzQLdCMdRQsew/vG83PBU8RnztFrCUvK+4YkttEEBa7FigJOB9pgIgqUXC6mtuSg==
X-Received: by 2002:a1c:48c:: with SMTP id 134mr9480268wme.47.1587554795340;
 Wed, 22 Apr 2020 04:26:35 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d133sm8341214wmc.27.2020.04.22.04.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 04:26:34 -0700 (PDT)
Subject: Re: [PATCH] vfio-helpers: Free QEMUVFIOState in qemu_vfio_close()
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <04cb6cb30a49cabd5ff8e6c094c0d13572de9fb1.1587551421.git.mprivozn@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9b4d9cd7-1222-cee3-a1a9-4435a2efa4e2@redhat.com>
Date: Wed, 22 Apr 2020 13:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <04cb6cb30a49cabd5ff8e6c094c0d13572de9fb1.1587551421.git.mprivozn@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michal,

On 4/22/20 12:30 PM, Michal Privoznik wrote:
> The qemu_vfio_open_pci() allocates this QEMUVFIOState structure
> but free counterpart is missing. Since we already have
> qemu_vfio_close() which does cleanup of the state, it looks like
> a perfect place to free the structure too. However, to avoid
> confusing rename the function to make it explicit that the passed
> structure is also freed.
>=20
> =3D=3D167296=3D=3D 528 (360 direct, 168 indirect) bytes in 1 blocks are d=
efinitely lost in loss record 8,504 of 8,908
> =3D=3D167296=3D=3D    at 0x4837B86: calloc (vg_replace_malloc.c:762)
> =3D=3D167296=3D=3D    by 0x4B8F6A0: g_malloc0 (in /usr/lib64/libglib-2.0.=
so.0.6000.7)
> =3D=3D167296=3D=3D    by 0xA7F532: qemu_vfio_open_pci (vfio-helpers.c:428=
)
> =3D=3D167296=3D=3D    by 0x989595: nvme_init (nvme.c:606)
> =3D=3D167296=3D=3D    by 0x989EB0: nvme_file_open (nvme.c:795)
> =3D=3D167296=3D=3D    by 0x8F9D04: bdrv_open_driver (block.c:1466)
> =3D=3D167296=3D=3D    by 0x8FA6E1: bdrv_open_common (block.c:1744)
> =3D=3D167296=3D=3D    by 0x8FDC73: bdrv_open_inherit (block.c:3291)
> =3D=3D167296=3D=3D    by 0x8FE1B5: bdrv_open (block.c:3384)
> =3D=3D167296=3D=3D    by 0x5EE828: bds_tree_init (blockdev.c:663)
> =3D=3D167296=3D=3D    by 0x5F57F8: qmp_blockdev_add (blockdev.c:3746)
> =3D=3D167296=3D=3D    by 0x5666DC: configure_blockdev (vl.c:1047)
>=20
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>   block/nvme.c                | 2 +-
>   include/qemu/vfio-helpers.h | 2 +-
>   util/vfio-helpers.c         | 3 ++-
>   3 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 7b7c0cc5d6..7e00c4f1a7 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -766,7 +766,7 @@ static void nvme_close(BlockDriverState *bs)
>                              false, NULL, NULL);
>       event_notifier_cleanup(&s->irq_notifier);
>       qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SI=
ZE);
> -    qemu_vfio_close(s->vfio);
> +    qemu_vfio_close_and_free(s->vfio);
>  =20
>       g_free(s->device);
>   }
> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
> index 1f057c2b9e..c96a0b1963 100644
> --- a/include/qemu/vfio-helpers.h
> +++ b/include/qemu/vfio-helpers.h
> @@ -16,7 +16,7 @@
>   typedef struct QEMUVFIOState QEMUVFIOState;
>  =20
>   QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
> -void qemu_vfio_close(QEMUVFIOState *s);
> +void qemu_vfio_close_and_free(QEMUVFIOState *s);
>   int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
>                         bool temporary, uint64_t *iova_list);
>   int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s);
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index ddd9a96e76..4c525d245b 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -706,7 +706,7 @@ static void qemu_vfio_reset(QEMUVFIOState *s)
>   }
>  =20
>   /* Close and free the VFIO resources. */

The comment already says 'close and free', I don't think it is worth=20
renaming the function.

> -void qemu_vfio_close(QEMUVFIOState *s)
> +void qemu_vfio_close_and_free(QEMUVFIOState *s)
>   {
>       int i;
>  =20
> @@ -721,4 +721,5 @@ void qemu_vfio_close(QEMUVFIOState *s)
>       close(s->device);
>       close(s->group);
>       close(s->container);
> +    g_free(s);

Good catch.

Preferably not renaming:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   }
>=20


