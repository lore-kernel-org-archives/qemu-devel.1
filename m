Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B74C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D436206A1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f15L8bkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D436206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfTr0-0000ic-BI
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTqF-00008y-0V
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:41:55 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTqA-0004uq-Gk
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:41:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id i22so7237759oik.10
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 12:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zZkAfHXymnO3BXYgTxxC7cdbgIt0XWHaxePpN/N3NYw=;
 b=f15L8bkQjtQ3FzGw6fFCB3pGeOsMFHUJ5xQU5NoYAFBXlqemt98hl8YY672OTPUH5u
 xgLTRA4lydyKBEZol1G/E4B5lr/Zt0vFFPCJpZWfqLqpv+h0oSb/SHBW3cCC7pwvFW0C
 bRFOr5/kwmPdGH81r/iCz5Yb/foX+Zd6iqpZHvHe5+2gqQAj4A8wWqamEaiRoP/JvTLO
 6vUOTN1ISfxXYblYCD4sK91y4jzzeIKXKl+9uNN1reA6V8MvdcsHFtizaybmnqtFWqU5
 I7EkC42p5hyVnsfkTMxDi/f44GP+Fyos2RM6kqfURndJRlQdJ1pW0KuTsvsLH+0vlMlo
 FY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zZkAfHXymnO3BXYgTxxC7cdbgIt0XWHaxePpN/N3NYw=;
 b=GofMFVgwxljNadBKfokwe1kvHRdoDKOIeznCphZTDTMDwEBjkeuySFiPjUluxNQduU
 g+mgHu6azSRJD8X/O0RLuUSdPyeOK8sGd1aSmnIOVWZrF9EraHoACPVu/yMo4JQQryju
 6oiPIaqdr1+p226P8x1aQriwyFFPjxUOA3VUIGXb2M7OO2GdpARSPTo8bQ5vQ/IWwpN1
 V61CO+y62d9fHehFk+STwv6EpL6uMh/UgqLqGAaF1V1MLzx/eeF04N4YinIXkVdKphY0
 jEk75nFC8g8mwvhzc5sZMCEVG3Q+nv8ZxGUxh5rPt4LLR4gxaJZ+C2JFyZS/AV5U8U6T
 gFsw==
X-Gm-Message-State: AOAM533uPWVEbxMMlRVQY7DjK7QQ5u/aVdmSZuTAU9TDkLKFRX30lmWO
 at76c/5wuZAYg/zpaBMrKFIW1PH47zhRGxNXbEuxYQ==
X-Google-Smtp-Source: ABdhPJwx/Fp22ckvm8yonutVfHujugI28A8908acZg8+fqReC23eXHSgFnsiuuoQdRFG5xBHa+Lbx5PC2hNUSqGTiIg=
X-Received: by 2002:aca:5451:: with SMTP id i78mr7126844oib.48.1590954109071; 
 Sun, 31 May 2020 12:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-5-f4bug@amsat.org>
In-Reply-To: <20200531175425.10329-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 May 2020 20:41:38 +0100
Message-ID: <CAFEAcA9bDjiQnr7bw8QiixGtFmFszN6RuN3D-jNEL8mNmk987Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] exec/cpu-common: Do not restrict CPU to 32-bit memory
 access maximum
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 18:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Most CPUs can do 64-bit operations. Update the CPUReadMemoryFunc
> and CPUWriteMemoryFunc prototypes.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/exec/cpu-common.h |  4 ++--
>  hw/usb/hcd-musb.c         | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index b47e5630e7..5ac766e3b6 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -43,8 +43,8 @@ extern ram_addr_t ram_size;
>
>  /* memory API */
>
> -typedef void CPUWriteMemoryFunc(void *opaque, hwaddr addr, uint32_t valu=
e);
> -typedef uint32_t CPUReadMemoryFunc(void *opaque, hwaddr addr);
> +typedef void CPUWriteMemoryFunc(void *opaque, hwaddr addr, uint64_t valu=
e);
> +typedef uint64_t CPUReadMemoryFunc(void *opaque, hwaddr addr);

I don't think the type of these functions has anything to do with the
CPU's capabilities, does it? The typedefs are a legacy remnant from before
the conversion to MemoryRegions:
 * before MemoryRegions, devices provided separate functions for
   byte/word/long reads and writes (64-bit writes were simply
   impossible with the ancient APIs, which required a 3-element
   function pointer array for read and the same for write)
 * the initial MemoryRegion conversion introduced the new-style
   "one read/write fn for all widths" APIs, but also supported
   old-style six-function devices, for ease of conversion, using
   MemoryRegionOps::old_mmio.
 * in commit 62a0db942dec6ebfe we were finally able to drop the
   old_mmio (having changed over the last devices using old-style).
   (I see I forgot to delete the now-unused MemoryRegionMmio typedef.)

The only remaining user of these typedefs is hw/usb/hcd-musb.c,
which is still not converted to QOM/qdev. It uses them to allow
its one user (hw/usb/tusb6010.c) to perform reads/writes on the
underlying musb registers.

There's no point in changing these typedefs to pass or return
a 64-bit data type, because their sole use is in the musb_read[]
and musb_write[] arrays, which only allow for 1, 2 or 4 byte
accesses, depending on which array element you use.

Possible cleanups here:
Easy:
 * delete the unused MmeoryRegionMmio
 * move these typedefs into include/hw/usb.h and rename them
   to MUSBReadFunc and MUSBWriteFunc, since that's all they're
   used for now
Tricky:
 * convert the hw/usb/hcd-musb.c code to QOM/qdev, which would
   include refactoring the current musb_read/musb_write so that
   instead of the tusb6010.c code calling function entries in these
   arrays the hcd-musb.c code exposed a MemoryRegion; the tusb6010
   code would access it via memory_region_dispatch_read/write

thanks
-- PMM

