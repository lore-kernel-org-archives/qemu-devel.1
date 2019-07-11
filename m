Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05A8C74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8D621019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIoa70tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8D621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYaS-0004eq-ND
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59674)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYZs-0003dM-PG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlYZr-0007gj-IG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:53:36 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:45625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlYZr-0007fo-An
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:53:35 -0400
Received: by mail-ot1-x335.google.com with SMTP id x21so5680657otq.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=gku9+4zdZ3AWSOPxK9qUjprQ1vjIqBJC3RxrQc8aLFM=;
 b=KIoa70tjPeJ3mhRZCKyMwI+eQ36HVNsB2v83Lb80RYSVAej+QWp5YmdGK93LfzgPOD
 dshambYwpewU2tlvlUVmnCESAhMIuNQIreDD5YoOsGIQwI8I7aUWsHDjPrPhh0Hhrlo5
 ab1uUApQzrKY8+Hji52ukeQDo2D5kzC2cG+f2vjRzTI3s3iGg3ZELxXHWCze+BOS+Lxo
 CfPNSmaLBVvQEwSgwKYPoVzAN9hSOhtuFIux3IvdXWOOBiBCQWIdilDhwAq9K+wpQnLf
 yPu6puGvAV21NCL+DKYGDtuLiFifhQko9QK+vgM5NM6jwsfr7DaEVYpFFzlQdQzCezJI
 iB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=gku9+4zdZ3AWSOPxK9qUjprQ1vjIqBJC3RxrQc8aLFM=;
 b=hrn+6hnm4o2ej5jWoQsE2K8p647wnmHkdK7hBjgih2ouXqJ2BfvHjasuaj/eir2Rrr
 F8K2wT3sZ3R8KsGsH5HTRE1o04/tfAZnr59HgksRn0HBeXgouWwQbCM4FR2s7cB3oC1V
 noZeMQEwW0idiZVdMydo5aCayzemxnkZbKubiBNZSxLkZAeRnx6hbMWVBG6QJxkyi6np
 nQaIPqNy3Sfi5pBv9Riz9L/2MQi2P4hhLNkFrqN2MxoUxTfwqCXLBIt5r+TfgBkok/B8
 Xa7ekMqgJwC1Et3GpJsy1HuT0X1vzK4BXMw/OgU7b/dehLnNz2peric5xTFuBkZDx0AS
 FcqA==
X-Gm-Message-State: APjAAAXRaPC6UYGyeuGJ/7Mm+d9rcrFwE3PLyd6Qs5opsyI16JvYe3KJ
 N7Jj79bwEq3j4rFzuPPGZ12Ul5P8QLJsZ69DiuNGlUEeDs0=
X-Google-Smtp-Source: APXvYqy71JJD0N6oFi3509fIw85AO7GctFLS+kOlp5Bp3SpGZROlDJ6GtEtBrcPfzPjECrPs9wHBgiXWpXR++Z+YMYU=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr3351874otn.135.1562849613872; 
 Thu, 11 Jul 2019 05:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180816133438.17061-1-peter.maydell@linaro.org>
 <20180816133438.17061-10-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-10-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 13:53:23 +0100
Message-ID: <CAFEAcA87W=nY-isQNqDOjnG9nWaV4DsCnYDvFckraEqwsMy9GQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe DUBOIS <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 09/30] i.MX6UL: Add i.MX6UL SOC
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Aug 2018 at 14:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Jean-Christophe Dubois <jcd@tribudubois.net>

> +enum FslIMX6ULConfiguration {
> +    FSL_IMX6UL_NUM_CPUS         = 1,

Hi; Coverity has just noticed some "unreachable code"
in places like the imx6ul realize function:

> +static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
> +{
> +    FslIMX6ULState *s = FSL_IMX6UL(dev);
> +    int i;
> +    qemu_irq irq;
> +    char name[NAME_SIZE];
> +
> +    if (smp_cpus > FSL_IMX6UL_NUM_CPUS) {
> +        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
> +                   TYPE_FSL_IMX6UL, FSL_IMX6UL_NUM_CPUS, smp_cpus);
> +        return;
> +    }
> +
> +    for (i = 0; i < smp_cpus; i++) {
> +        Object *o = OBJECT(&s->cpu[i]);
> +
> +        object_property_set_int(o, QEMU_PSCI_CONDUIT_SMC,
> +                                "psci-conduit", &error_abort);
> +
> +        /* On uniprocessor, the CBAR is set to 0 */
> +        if (smp_cpus > 1) {
> +            object_property_set_int(o, FSL_IMX6UL_A7MPCORE_ADDR,
> +                                    "reset-cbar", &error_abort);
> +        }

where here for instance, smp_cpus can never be > 1 because
there is only ever 1 CPU in an iMX6UL and we enforce that with
the smp_cpus > FSL_IMX6UL_NUM_CPUS check; so the call to
object_property_set_int() is dead unreachable code.

Is it the case that there really can only ever be 1 CPU
in these SoCs (in which case we might as well delete the
dead code), or are there future variants which have two
CPUs that we might want to model in future (in which case
the dead code has some purpose and we can just tell
Coverity to be quiet) ?

thanks
-- PMM

