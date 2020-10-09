Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9B72227E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tb7T1xFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9B72227E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0fD-0006jW-5u
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR0eS-0005p7-4j; Fri, 09 Oct 2020 18:14:12 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR0eQ-0005KK-GP; Fri, 09 Oct 2020 18:14:11 -0400
Received: by mail-io1-xd42.google.com with SMTP id m17so11871945ioo.1;
 Fri, 09 Oct 2020 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eRgcP74qvwlQr+b82xawd6W0J/RP4NL/CRm4biQAMFE=;
 b=Tb7T1xFwIJGC01240ZoQA8HLUSD4njBKRHOmpRNiHeBlSB6zrUROS0n/Haw3zPmro2
 Udh8nsxB7DX+6SVknhYvOk4/SAmU//Evs51yX6x7CW1+MnxgF2MyOIdZ+YP8up8yRX1R
 eFUtrHJLohrCK56kjMr2yjyUo4IyW3n9U6C3OasE4ind1P+S+N6c2/Ofm28sm/1aOe0f
 6zPB5kWZeu3SOhd4b1uJF3Zh6Up2LsUWKLEqQ5J8woGoXmBzO3QhvmM8MUsTlAhskcpB
 t9ci3Jg2BRBFkBwmZRHNPT4QHlaSNIxXScKxo6YvDYv8cDbXwIHX7nXQY5o0o5q9nkEm
 WMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eRgcP74qvwlQr+b82xawd6W0J/RP4NL/CRm4biQAMFE=;
 b=Zf+2FZtpz7bCF/b+q6H2PmfiH76O/YT2YVpr1rKOEY0H7PmAdL7hg4YYdyp87TwaUW
 0zpR7zH5RZVBk03QpuAm4WWXMjg55Zs9n3rSKa0ub2XIx2xmp+G143MMcA/ZL3asEHcd
 dXk3f/DHIdwnGOsHH/xd3flSvOXGOugahAebqxa36FYTHQVeVuzIRh9bK4eZMKNdRYew
 ykNkN+RckgJqVHm1zhhOzrhWxYpM8Y3tTGVTmsuTv0fFluNxHt86+OzGxVDJM4/pvMwu
 kSH+qEghjQevzML4906vanj9hGf1sE1u/0DSY+dsPz2Z/E7M/VUCfP5Gyq26tnXeQNwH
 PUUw==
X-Gm-Message-State: AOAM532T3e34RMd4heuvrVLdpGAprluKyWP0IRbyQsWKUe4UlT5UjDhs
 IkzRXwKg9SiQ4l8z7SQO7Zq8HeeXFDTRCwrSIFk=
X-Google-Smtp-Source: ABdhPJzvwzjM4iT75C/2BJZoaTyx1FU9QcsfOL4WfDkOWoIycX4ool3IliXk+m7O5XrToMs0jwo+aUaC+IH1mM4z3Jg=
X-Received: by 2002:a05:6638:a90:: with SMTP id
 16mr2269625jas.91.1602281648895; 
 Fri, 09 Oct 2020 15:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201009113843.60995-1-lvivier@redhat.com>
 <20201009113843.60995-2-lvivier@redhat.com>
In-Reply-To: <20201009113843.60995-2-lvivier@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Oct 2020 15:02:35 -0700
Message-ID: <CAKmqyKN_tguOw=Jvpb+=88r2+fn2DyU1kHgASy5WxnZcZu9BmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] goldfish_rtc: change MemoryRegionOps endianness to
 DEVICE_NATIVE_ENDIAN
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 9, 2020 at 4:40 AM Laurent Vivier <lvivier@redhat.com> wrote:
>
> The doc [1] doesn't define the endianness, but the kernel driver
> uses readl() to access the registers, so we can guess it depends
> on the architecture endianness.
>
> As riscv architecture endianness is little it might not change anything
> for it.
>
> Moreover, android implementation uses DEVICE_NATIVE_ENDIAN [2]
>
> [1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> [2] https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/timer/goldfish_timer.c#177
>
> Fixes: 9a5b40b84279 ("hw: rtc: Add Goldfish RTC device")
> Cc: Anup.Patel@wdc.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/rtc/goldfish_rtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index 6ddd45cce039..0f4e8185a796 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -217,7 +217,7 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
>  static const MemoryRegionOps goldfish_rtc_ops = {
>      .read = goldfish_rtc_read,
>      .write = goldfish_rtc_write,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
>          .max_access_size = 4
> --
> 2.26.2
>
>

