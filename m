Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8F9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:15:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFDD22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dah9lzWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFDD22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hnJ-0003KJ-4I
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7hgt-0007bi-VJ; Mon, 17 Aug 2020 12:08:56 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:34151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k7hgr-0003Tn-T7; Mon, 17 Aug 2020 12:08:55 -0400
Received: by mail-io1-xd41.google.com with SMTP id q75so18228692iod.1;
 Mon, 17 Aug 2020 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HZObGnpNDex5DeuNzmBuJ9et0tid5t/uOhy0Hxm5Nsg=;
 b=Dah9lzWFQrIlGz3kCf9EznPyPw/Fee2Mq3B6OlsKHPORMHCwX06q1JP7JC6wDlFaiM
 fVb0/Z6pBueeI7TlcG1Xf3DXIQl9B7tWziXvnbdIMVbv9bt+fhoH0m8x2BKWt9iBdylK
 f5pQEfKKIa5Gw9xZTQ9enXIm612lE1ik0oyCrqARxbpWJPEDGEeVNIh5mZYNYCtmdsKx
 7nCeYedjU4B6RRZvSvQ2hTWaPDPVm3rhg3mwZG/uLOq7QFKyKwoKM+x47N01DHARY9os
 JNivc/AoloAC60m9fzWTIshs4wZ70/KpceAzGZ9aAdO1YMmBtxSBeNKN1rucJKCaKb3c
 A7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HZObGnpNDex5DeuNzmBuJ9et0tid5t/uOhy0Hxm5Nsg=;
 b=Ye7o7eTamSkm0OalNpkKuer69HAmOz0n4lq2JGmcSAI2Kpm6IOVZWCI1/xrlH7JLLX
 1K3kc7pgHmu/qHgCYXOAakeBuU6LJFqxCBHuQZi8lw3VHCRaMyw6j/RHcC+8UpYjzEl+
 SZTK0NcxXUTWxKwdGI1IyqOFZYgzjLMhFon+QDAIuXsbyaUVxWAo4ceT40mB3nc6pzSk
 2PguGFt03rQ2kIeCwOhgO9snGglS5jD2YwWoTY3gFU50zopUGmtBUYJL6oRXnqhZgrJE
 2/noAWs0gCDLvLZGrU808TursGJ9uKsvk6rcm5qMTKUV9LRaRxvOF3HqzwM7nKNOR9rx
 6rpg==
X-Gm-Message-State: AOAM531t1iovDBj6R+40HuPlZYklEiJIK6ic64ccjxoyLMEePqpS2L8d
 cPfBuFuTTY9EY7mOwOxQ6vPvdmls0g+umZA8AIM=
X-Google-Smtp-Source: ABdhPJzTQSTr/sgfcJsDFvxIISlIbKtMEDo+xjckDJRZJQbxEpQDnKCEgMq1pxsWfzjFmwJpJNAg691NVLKTXEffjJc=
X-Received: by 2002:a05:6638:e90:: with SMTP id
 p16mr15489022jas.26.1597680531334; 
 Mon, 17 Aug 2020 09:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
 <20200811225122.17342-3-dmitry.fomichev@wdc.com>
In-Reply-To: <20200811225122.17342-3-dmitry.fomichev@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Aug 2020 08:58:19 -0700
Message-ID: <CAKmqyKNkTSGZtCq8hL-6GT3UP8-yp+ZhSgv=FoX675G+BsQLbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi-generic: Fix HM-zoned device scan
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Damien Le Moal <damien.lemoal@wdc.com>,
 Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 3:52 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
>
> Several important steps during device scan depend on SCSI type of the
> device. For example, max_transfer property is only determined and
> assigned if the device has the type of TYPE_DISK.
>
> Host-managed ZBC disks retain most of the properties of regular SCSI
> drives, but they have their own SCSI device type, 0x14. This prevents
> the proper assignment of max_transfer property for HM-zoned devices in
> scsi-generic driver leading to I/O errors if the maximum i/o size
> calculated at the guest exceeds the host value.
>
> To fix this, define TYPE_ZBC to have the standard value from SCSI ZBC
> standard spec. Several scan steps that were previously done only for
> TYPE_DISK devices, are now performed for the SCSI devices having
> TYPE_ZBC too.
>
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/scsi/scsi-generic.c   | 10 ++++++----
>  include/scsi/constants.h |  1 +
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 86ed0a3822..2cb23ca891 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -162,7 +162,8 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
>          }
>      }
>
> -    if (s->type == TYPE_DISK && (r->req.cmd.buf[1] & 0x01)) {
> +    if ((s->type == TYPE_DISK || s->type == TYPE_ZBC) &&
> +        (r->req.cmd.buf[1] & 0x01)) {
>          page = r->req.cmd.buf[2];
>          if (page == 0xb0) {
>              uint32_t max_transfer =
> @@ -299,10 +300,11 @@ static void scsi_read_complete(void * opaque, int ret)
>      }
>      blk_set_guest_block_size(s->conf.blk, s->blocksize);
>
> -    /* Patch MODE SENSE device specific parameters if the BDS is opened
> +    /*
> +     * Patch MODE SENSE device specific parameters if the BDS is opened
>       * readonly.
>       */
> -    if ((s->type == TYPE_DISK || s->type == TYPE_TAPE) &&
> +    if ((s->type == TYPE_DISK || s->type == TYPE_TAPE || s->type == TYPE_ZBC) &&
>          blk_is_read_only(s->conf.blk) &&
>          (r->req.cmd.buf[0] == MODE_SENSE ||
>           r->req.cmd.buf[0] == MODE_SENSE_10) &&
> @@ -617,7 +619,7 @@ static void scsi_generic_read_device_identification(SCSIDevice *s)
>  void scsi_generic_read_device_inquiry(SCSIDevice *s)
>  {
>      scsi_generic_read_device_identification(s);
> -    if (s->type == TYPE_DISK) {
> +    if (s->type == TYPE_DISK || s->type == TYPE_ZBC) {
>          scsi_generic_set_vpd_bl_emulation(s);
>      } else {
>          s->needs_vpd_bl_emulation = false;
> diff --git a/include/scsi/constants.h b/include/scsi/constants.h
> index 874176019e..2a32c08b5e 100644
> --- a/include/scsi/constants.h
> +++ b/include/scsi/constants.h
> @@ -218,6 +218,7 @@
>  #define TYPE_ENCLOSURE      0x0d    /* Enclosure Services Device */
>  #define TYPE_RBC            0x0e    /* Simplified Direct-Access Device */
>  #define TYPE_OSD            0x11    /* Object-storage Device */
> +#define TYPE_ZBC            0x14    /* Host-managed Zoned SCSI Device */
>  #define TYPE_WLUN           0x1e    /* Well known LUN */
>  #define TYPE_NOT_PRESENT    0x1f
>  #define TYPE_INACTIVE       0x20
> --
> 2.21.0
>
>

