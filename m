Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597B0C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 17:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B272070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 17:18:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B272070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs9I9-0004Os-A8
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 13:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hs9Hf-0003pi-JH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hs9He-0004mr-7f
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:18:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38361)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hs9He-0004mV-20
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 13:18:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so62709457wrr.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 10:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UcsNsSJDDwl7yjQ6N+DrqE0hqb6n2RsdQKDnQsVTWY8=;
 b=JvmFErOplGICdzWA+rCFClyXq8RihRDGhs3wun4T/9kUo81ZFjaejR/D0dkT8CMfFx
 R9+tEBwbUkOR29fijrR96AtC32KSc58aBNrtemT1Nos8w6KvnbtLmiFsda3Vt6igPEiT
 XOH4GlFyRDOXHp8pticEr8dodaCnaZUsEXtll/u0DWXh4KL5uBwtVxUhOTGpe/4Qe5EJ
 CL9/4vXyVwt/JxTGa/8D1hsaJXt9nT8UWv7r9wZAKTzArXcuVcRblz4fPbSD2WhZG+4X
 79mLgqJUV+pbE4AcqpR4s4n58gTJGlOgQCzhcaRVJKnZGVXWb8EDiHKxo/sToQR7eJGg
 kvFA==
X-Gm-Message-State: APjAAAVIl/9HCgQic3urqR817/XEaWZZ1Fay6msZxMZzuEwe2jK/axXz
 1FwZHSXyA9vbF15803eIjEfC8Q==
X-Google-Smtp-Source: APXvYqxe8LJHBvegGMrzuqVx4RWXWrvjJJHjkBsqzoBN6n4IprapVsZSl+/2mrOqHK0C27l97ti5zw==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr46420318wrv.164.1564420680979; 
 Mon, 29 Jul 2019 10:18:00 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id x8sm51991696wmc.5.2019.07.29.10.18.00
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 10:18:00 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20190729164234.11573-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <83185706-7584-e583-e917-5e05d1d27e25@redhat.com>
Date: Mon, 29 Jul 2019 19:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190729164234.11573-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.1] scsi-cd: Fix inserting read-only
 media in empty drive
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 6:42 PM, Kevin Wolf wrote:
> scsi-disks decides whether it has a read-only device by looking at
> whether the BlockBackend specified as drive=... is read-only. In the
> case of an anonymous BlockBackend (with a node name specified in
> drive=...), this is the read-only flag of the attached node. In the case
> of an empty anonymous BlockBackend, it's always read-write because
> nothing prevented it from being read-write.
> 
> This is a problem because scsi-cd would take write permissions on the
> anonymous BlockBackend of an empty drive created without a drive=...
> option. Using blockdev-insert-medium with a read-only node fails then
> with the error message "Block node is read-only".
> 
> Fix scsi_realize() so that scsi-cd devices always take read-only
> permissions on their BlockBackend instead.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1733920
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/scsi/scsi-disk.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 8e95e3e38d..af3e622dc5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -2318,6 +2318,7 @@ static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
>  static void scsi_realize(SCSIDevice *dev, Error **errp)
>  {
>      SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
> +    bool read_only;
>  
>      if (!s->qdev.conf.blk) {
>          error_setg(errp, "drive property not set");
> @@ -2351,8 +2352,13 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
>              return;
>          }
>      }
> -    if (!blkconf_apply_backend_options(&dev->conf,
> -                                       blk_is_read_only(s->qdev.conf.blk),
> +
> +    read_only = blk_is_read_only(s->qdev.conf.blk);
> +    if (dev->type == TYPE_ROM) {
> +        read_only = true;
> +    }
> +
> +    if (!blkconf_apply_backend_options(&dev->conf, read_only,
>                                         dev->type == TYPE_DISK, errp)) {
>          return;
>      }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

