Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E68C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7987721744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WhA1demz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7987721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6X1p-0004Hy-MD
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6X0h-00034u-6j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6X0f-0001mC-W1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:00:14 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6X0f-0001lH-PL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:00:13 -0500
Received: by mail-ot1-x344.google.com with SMTP id i6so11523413otr.7
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 02:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hto01OtFb58DCVDdjVJ+ydnPoPBC4N079sxj9AOpg8E=;
 b=WhA1demzTauOq6f0DnSZfZ5u8+PPUjjl3CbXA2bKhTmE9wndoEPKujSZagWrYb51K/
 r+RZtfBnrmW3S+MCPawC8wJ5gGaj74N0qun3UzTDnmyHypE6CPUOZpWoS6fK3zxJeeEI
 1c/XQVjfKjgptjoWOy+q5K6mM5eMQ4ZtHfUIjgjico/j+hc0pcO/7OUGDc1XQmlhJda6
 G1wePASW5aRFQuHAki8Sz+7LAUtqz7FnVHDGZZ1+ZoSu8kT4cpEBxTzkbl69CYOJSAvx
 WPqxiKaTXEqQiSmMFyXun5NCPcuhwVpRKhwplvUdxScImbAIjsBbH51omQ20Iavhhf3b
 MTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hto01OtFb58DCVDdjVJ+ydnPoPBC4N079sxj9AOpg8E=;
 b=tI2dj8aGj7F3MDjKDKveAfzrnBD/3nEs4xOUN/CShAIn+LbkxBJ5euC8Zimb3KFyQ8
 y3tTIWmbsKMcrcBa4JfoD82iJntwNMASP6WGq9Q8NslLq7WIED5nRoEFd/GWWK0Tx0GE
 GgZ6PLJf7j7zXsWEttt7MLqvRLdsGCf9YFrGwbwr7/E0h5IAD+ku3x+R6uAgvagB0nP4
 2zXLVUL/LpRjDCa+LePGTGJJTR94sIUs9WXxYhFR0Q0cM5JhcLO0Qp5B7QZoxc52u3Zd
 j8hsI4hLDTK4jqP019neHni1BaVKKELHYitAGKUPsjEToJ1qgwmTV9vryx1ALJEhyXDC
 QdTA==
X-Gm-Message-State: APjAAAVD6HZBvbiv8R6TyvJmIaXUfNrTPdHtu+cYaHN2i21x/8hSs/Js
 mKc2J1gj0m61v5b4sqJurs5eL1rwAxwkRG/y5tahSA==
X-Google-Smtp-Source: APXvYqyfPKcGZT2j5eRkllSghmuRHEaR00+X1PqcDQnF0j6WSef9cnwPH1Hq2Tl1U6OaHXq113DYM/FHmB5iHrkpWA0=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr31876025oto.135.1582624812741; 
 Tue, 25 Feb 2020 02:00:12 -0800 (PST)
MIME-Version: 1.0
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
 <20200221033650.444386-8-david@gibson.dropbear.id.au>
In-Reply-To: <20200221033650.444386-8-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 10:00:01 +0000
Message-ID: <CAFEAcA8GZ-YkfQJ9TMAOoLe++WF9+YZT1rw_F8xLPxY+ciBhMg@mail.gmail.com>
Subject: Re: [PULL 07/20] spapr: Add NVDIMM device support
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 03:37, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>
> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
> device interface in QEMU to support virtual NVDIMM devices for Power.
> Create the required DT entries for the device (some entries have
> dummy values right now).

> +void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
> +                                Error **errp)
> +{
> +    char *uuidstr = NULL;
> +    QemuUUID uuid;
> +
> +    if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
> +        error_setg(errp, "NVDIMM memory size excluding the label area"
> +                   " must be a multiple of %" PRIu64 "MB",
> +                   SPAPR_MINIMUM_SCM_BLOCK_SIZE / MiB);
> +        return;
> +    }
> +
> +    uuidstr = object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP, NULL);
> +    qemu_uuid_parse(uuidstr, &uuid);
> +    g_free(uuidstr);
> +
> +    if (qemu_uuid_is_null(&uuid)) {
> +        error_setg(errp, "NVDIMM device requires the uuid to be set");
> +        return;
> +    }
> +}

Hi -- Coverity thinks (CID 1419883) that it's suspicious that
this code doesn't check the return value of qemu_uuid_parse(),
because we check it everywhere else that we call that function
(it can return a failure code if the UUID doesn't validly parse).

thanks
-- PMM

