Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B154CCA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 22:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8297320862
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 22:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8297320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQIXb-00029W-Ja
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 18:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iQIWo-0001Zc-4D
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 18:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iQIWl-0001dE-71
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 18:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iQIWk-0001Yx-U5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 18:02:47 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEC6C86662
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 22:02:44 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g13so3385394wme.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 15:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G96KzkBpz20D8yIQuubdOk1zfA8zE1BeMfmMPleZ6r8=;
 b=n7Sx6Rs2aUlct4WPw+epFr0qPpuscnUvgQI8auu8HzGYGNTPOXtWHQlU8VNHkFi9i0
 qmDQ7R0oqOGvVNfnEgckWpIIHglezBCJaQJy1522fKeeKMftmUXFadflMgVjUaysrKyc
 gkRZVf8LXWVMzAkSQ5EjWS7hS4HZyI4wFuwIdFONXDWA9Ejlmi41dcWXX3PbQlz2uKql
 qpYPyfRmVvicHbmOoqHrnEMqJUeblQqDwmmMfmAZlERS+PlUzzguIEm2zcWAkk7QTwCC
 fk2ijyww92KVuQExSv+LhP4hGjzaW68+n/HApMiEyC/Kqi2CsbHtFMvJXB13EvkXXATQ
 f3+w==
X-Gm-Message-State: APjAAAVJFIQMBikoW3s6z8BF/7NFEFxuk6WJF396ICkShWcefayOqdEj
 D7p5xwnikHiHmj0wiPuw6a3+0f2D6ws4kTT/BZ5U5ztD6bRZ2CxY1dPKbg6Huk3NZBGxSncQnib
 9SZGAls7AcjsEyXs=
X-Received: by 2002:a5d:448f:: with SMTP id j15mr7441119wrq.70.1572559363405; 
 Thu, 31 Oct 2019 15:02:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqws+A4KJb1Pm2fMt9+tBSZh4O0wmtpSfUmaACc8sZ+xS1hVZawWR36d264AviYJ7sPNZBgbJQ==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr7441080wrq.70.1572559363028; 
 Thu, 31 Oct 2019 15:02:43 -0700 (PDT)
Received: from [192.168.20.72] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id w17sm5695064wra.34.2019.10.31.15.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 15:02:42 -0700 (PDT)
Subject: Re: [PULL 1/9] IDE: deprecate ide-drive
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20191031105904.12194-1-jsnow@redhat.com>
 <20191031105904.12194-2-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c688f160-e10e-52d1-5a54-881dd86987d4@redhat.com>
Date: Thu, 31 Oct 2019 23:02:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191031105904.12194-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/10/19 11:58, John Snow wrote:
> It's an old compatibility shim that just delegates to ide-cd or ide-hd.
> I'd like to refactor these some day, and getting rid of the super-object
> will make that easier.
> 
> Either way, we don't need this.

Good idea.  I will prepare a similar patch for scsi-disk, even though
technically we're already in soft freeze; it makes no sense to deprecate
only one of the two.

Paolo

> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ACKed-by: Peter Krempa <pkrempa@redhat.com>
> Message-id: 20191009224303.10232-2-jsnow@redhat.com
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qemu-deprecated.texi          | 5 +++++
>  hw/ide/qdev.c                 | 3 +++
>  tests/qemu-iotests/051.pc.out | 6 ++++--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index f727bd3932..296bfc93a3 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -254,6 +254,11 @@ quite a bit. It will be removed without replacement unless some users speaks
>  up at the @email{qemu-devel@@nongnu.org} mailing list with information about
>  their usecases.
>  
> +@subsection ide-drive (since 4.2)
> +
> +The 'ide-drive' device is deprecated. Users should use 'ide-hd' or
> +'ide-cd' as appropriate to get an IDE hard disk or CD-ROM as needed.
> +
>  @section System emulator machines
>  
>  @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 6fba6b62b8..3666e59721 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -279,6 +279,9 @@ static void ide_drive_realize(IDEDevice *dev, Error **errp)
>  {
>      DriveInfo *dinfo = NULL;
>  
> +    warn_report("'ide-drive' is deprecated, "
> +                "please use 'ide-hd' or 'ide-cd' instead");
> +
>      if (dev->conf.blk) {
>          dinfo = blk_legacy_dinfo(dev->conf.blk);
>      }
> diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
> index 000557c7c8..34849dd172 100644
> --- a/tests/qemu-iotests/051.pc.out
> +++ b/tests/qemu-iotests/051.pc.out
> @@ -158,7 +158,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  
>  Testing: -drive if=none,id=disk -device ide-drive,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) QEMU_PROG: -device ide-drive,drive=disk: Device needs media, but drive is empty
> +(qemu) QEMU_PROG: -device ide-drive,drive=disk: warning: 'ide-drive' is deprecated, please use 'ide-hd' or 'ide-cd' instead
> +QEMU_PROG: -device ide-drive,drive=disk: Device needs media, but drive is empty
>  
>  Testing: -drive if=none,id=disk -device ide-hd,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information
> @@ -228,7 +229,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
>  
>  Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-drive,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) QEMU_PROG: -device ide-drive,drive=disk: Block node is read-only
> +(qemu) QEMU_PROG: -device ide-drive,drive=disk: warning: 'ide-drive' is deprecated, please use 'ide-hd' or 'ide-cd' instead
> +QEMU_PROG: -device ide-drive,drive=disk: Block node is read-only
>  
>  Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-hd,drive=disk
>  QEMU X.Y.Z monitor - type 'help' for more information
> 


