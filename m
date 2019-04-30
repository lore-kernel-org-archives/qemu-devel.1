Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D7C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F3620645
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVWv9ODU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F3620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50182 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLW42-0005du-Dt
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:57:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW23-000491-0t
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLW21-0001xK-RV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:02 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLW21-0001wj-Kw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:01 -0400
Received: by mail-ot1-x344.google.com with SMTP id g24so7967384otq.2
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9DFTohWXy/wYjNK8LrGwawKL4YX+RTydSr+hZQZ4bJE=;
	b=DVWv9ODUSm6suHGNNUyqtfksz+mXNEMUKHf6Y23oaNIj2M4qA93uNdbNLpcHNRnRUH
	N7Ia1BMi5btsvUXz8r3s/xlI1+/T6TZM8X8okDO4v6SKI4oskinX0xCo/JKy2Y1ZQOcJ
	bNQRLxh8A94YRqf4/Sd5V89Dem0PzCcu1Kgoypr7Kz+ubZRLsbfqWvDm7FGHw91FyCzB
	5zn6Irxh2F3mwZWAtX3HAyxPIw0FjOKT7fNMubG+oODnxRkq+L+yChbrNk4y13G1bRHv
	Xnsi7Lx8GBAADYPDRvtmaK5K1otQI3bDVmyDTCar3zW3QVfKhCOV55bHN+Cin+A2WoKS
	JClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9DFTohWXy/wYjNK8LrGwawKL4YX+RTydSr+hZQZ4bJE=;
	b=C/PCNwdxzImEQ+StV9e00+ckKIohYBz9iEg6G0ScANWsJS8DYgyfmcU0vssVZNEh4z
	d7Bpfzr5HrGWpb+G7tjmYmeD4WieWSQpP5FDSDPJ3YhlLdL91cOv3Wc5g/HDEBzDvZmR
	NqbE6O5yEGcmijmsh2aB7re035/AV0wI7cfRUAmp0YuOxNuDPCi/9TpWKdz1x4/Q081K
	Obn78H7yAw++m7gSyyp7FfyL5ZsXTEaDEdF7nX6LN4642xRuSbEUTQ/JSd6qdg3fbwJh
	3uwTHQg3gmnsTh/o0G4ZkJQvpvXXyGI0lfDfzdK/FVnSs5+nqAsK/E8rsQfO6DmazPjt
	sZOw==
X-Gm-Message-State: APjAAAVkUeXJg3Re15PXqFaWJVUdx/vgOxRE6gh5EK0XsD+jdJTA9QKk
	WGf85yFtIAOZjDsjr93hRdrnM5L0mMvKYzj0JYrz3w==
X-Google-Smtp-Source: APXvYqz5eZ1AgUjPwQO2cX5RNnY/duhNOKz2Sjbo+mfgHDsN45TTke+pBB70dELUJ/qnzpA2bjZ+cGIm6HQttvE/Ka4=
X-Received: by 2002:a9d:404:: with SMTP id 4mr40973086otc.352.1556643300723;
	Tue, 30 Apr 2019 09:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190425132134.2839-1-cohuck@redhat.com>
	<20190425132134.2839-2-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-2-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 17:54:49 +0100
Message-ID:
 <CAFEAcA8TvMqZRCrMF5orgaWy-CxTR8fr6yF2W_-Y6LYfi1pGng@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 01/19] s390 vfio-ccw: Add bootindex property
 and IPLB data
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430165449.E0mmIwQo1bPYNgKhss2-YftTf7P5Pjx57ZOaies9Rfg@z>

On Thu, 25 Apr 2019 at 14:21, Cornelia Huck <cohuck@redhat.com> wrote:
>
> From: "Jason J. Herne" <jjherne@linux.ibm.com>
>
> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
>
> Refactor s390_get_ccw_device() to return device type. This prevents us from
> having to use messy casting logic in several places.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
> [thuth: fixed "typedef struct VFIOCCWDevice" build failure with clang]
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Hi; Coverity has a complaint (CID 1401098) about the use of
object_dynamic_cast() in this function. It looks like it's just
the result of code motion making it forget we'd dismissed the
warning before, but maybe we can avoid it entirely...

> @@ -335,20 +360,22 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>  {
>      DeviceState *dev_st;
>      CcwDevice *ccw_dev = NULL;
> +    SCSIDevice *sd;
> +    int devtype;
>
>      dev_st = get_boot_device(0);
>      if (dev_st) {
> -        ccw_dev = s390_get_ccw_device(dev_st);
> +        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
>      }
>
>      /*
>       * Currently allow IPL only from CCW devices.
>       */
>      if (ccw_dev) {
> -        SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> -                                                            TYPE_SCSI_DEVICE);
> -
> -        if (sd) {
> +        switch (devtype) {
> +        case CCW_DEVTYPE_SCSI:
> +            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> +                                                           TYPE_SCSI_DEVICE);

Coverity doesn't like the use of object_dynamic_cast() without a
check that the return value isn't NULL before we dereference
it a few lines further down.

I think that if we know this cast must always succeed, we
could instead just write
  SCSIDevice *sd = SCSI_DEVICE(dev_st);

On the other hand if the cast might not succeed because dev_st
isn't necessarily of the right type, then we should check it
for NULL and handle that appropriately.

thanks
-- PMM

