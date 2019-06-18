Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAEFC31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD0420665
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhlQYGWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD0420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdDhA-0003Df-5E
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 08:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40970)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdDge-0002jN-C5
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdDgd-00058O-Iz
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:58:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdDgd-00056g-AQ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 08:58:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so14348580ote.13
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2AVbzcOczRMrVgHkbxqpowgYHCdbPmqOBLqODOt+rms=;
 b=FhlQYGWFqVigp63ePytQf7yuIVA7fqvVLy6WQrohPVzSqXUbb7+V4/82/CTb7MxDIv
 j351FtyVbWooZGAw2w6wV0VTQAX+TyYJegJDKAcu6q7A6ZB0I6S/GRpY3if7xMSu14zi
 LYGlod2senzJU4JDEIufovjy2SePOBsNAJyP44es6C33grppTyEB1xpdQBpIuC31wmUm
 ADlZ73zdAkLM4j8Qk2jA8nHIwEsKBwHnR1gmY8vrsiE6Vq3UH9r4NfXyvBfMH94rwU0a
 FvPmeJykUwFC1sdaO16Hldr2EpaSwLq5M5Kk5hMMKPXxd9rwWYOz9R4On4Cjm0qEyKIa
 1wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2AVbzcOczRMrVgHkbxqpowgYHCdbPmqOBLqODOt+rms=;
 b=p1J3RK36TIR8lsTDGHw6iqW7KK4YYS195S07d1hFZYOECWb4PoUAGWIhGVx9IiTRvf
 h4IC40mAksuMvglOGTaEwLeGMyxYkBjPkuvM5bk+3TfdC7yQa6q3OjMvI2inRPP8g18S
 N5TFTLV67d1U5KuqxBurWJNC1XVOxG/XklOD5qH+fnif/YwcLMIVG/zMrPy74UF1zHhI
 QzURfJBOVXdIDjzv1SIsnlUim1t4vuaxw981MDqbIi307e3dyFpv+9RXmcx6nCWXbh8G
 RR2rHljF+IRmMgoFQvNFnLkY5gCnReqxfbL2owyda3PLsqpjxtUuAga0ztGTLooemqIP
 Ds7g==
X-Gm-Message-State: APjAAAWOEHmCRSdhrLvib2q8VQyBgXoZksw6w5qFIxILkSWxt3Mg4zdE
 Ufs+oXkgVjdqmf2NsgOM5jSaRNVcqOEVmW+gsFk/Jg==
X-Google-Smtp-Source: APXvYqz1vsd9NPHHL7gLNMfKVVAIx2unrW+wkJ2HAQLutsFfE9NzYbO8BE1J+kP8BNXAAoEGsybDTBLprsZcXWG9AtM=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr4554988otj.97.1560862686500; 
 Tue, 18 Jun 2019 05:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190522162252.28568-1-shameerali.kolothum.thodi@huawei.com>
 <653a6b3c-ac1a-f197-1240-a28f59890fa8@redhat.com>
In-Reply-To: <653a6b3c-ac1a-f197-1240-a28f59890fa8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 13:57:55 +0100
Message-ID: <CAFEAcA9g=9u1Cj+1gqWqXWfg1phmZPw4=y7Ks_EzbYOEBW-WOA@mail.gmail.com>
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v5 0/8] ARM virt: ACPI memory hotplug
 support
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Igor Mammedov <imammedo@redhat.com>, sebastien.boeuf@intel.com,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 13:52, Auger Eric <eric.auger@redhat.com> wrote:
> Feel free to add my T-b on next version:
> Tested-by: Eric Auger <eric.auger@redhat.com>

I'm not sure we should carry across Tested-by tags like that: any
respin might accidentally introduce bugs that make it stop working...

thanks
-- PMM

