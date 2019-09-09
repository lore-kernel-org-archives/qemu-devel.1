Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F80EC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A9020828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcNtVVX6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A9020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NOq-0004is-3Y
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NO1-0004Ai-RY
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7NO0-0006Ke-Hp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:23:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7NO0-0006K3-4C
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:23:32 -0400
Received: by mail-ot1-x344.google.com with SMTP id n7so13325566otk.6
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1G8l0ZcD8iHD55sL32Lr0PzVcYNs2y/tV3uye5oo/3U=;
 b=OcNtVVX69V9H84o+jYulukeLqQMZf7FwwJfqfhymz+0NNpihbrVDjtTMbQl70BVB+s
 nZtpljBgylKOU4HHuMqy3M04bxQeJ1epBuy6WpjKVroZcj5Gs+WmhEkkLyL96v+kg7IL
 M/yEKfHuzFC3frHApnOwqvGf9uhIhdLDDkD4aZH7WstI1pDjfLyNoY9l8x94WNqc3LMZ
 B6a45UdBjypu7TKLrDLLgUipcVqQvUDglxT36MTfwMCZWBUwSg9izz0mPzEu8vlu/gZu
 xADuVxEcv/69N9eAp5LDBPBXffMw4zxZTarG0vZ3oDdSh5Rzj6KZL295FcPLlWddReJF
 pAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1G8l0ZcD8iHD55sL32Lr0PzVcYNs2y/tV3uye5oo/3U=;
 b=ZSqHUIFq/0iEjvm51uGlkteZMBOpoWIXTp9VLw9sT5NQcvrA+BVOMcXRGJM2fHkHOU
 tdWbYYAtkBfiVgLxtCfVzPXEtiO+li2NoKEEYx4pk5RD/vacO0ReEwvLbxhenIuUgMgE
 Qqsg23i46KxJcETGgTZENZChfT36NtIuKQD62tiAhBmcZGcJ72qMs6DGY9piFZvBF0Tk
 G34IhczCBBVKdoHOTW1N+fnp7Fl7RMU+OazhGZRny2sbXuzaU+uPW+ercxGFnMBRIteg
 xVzcL13FUF3Pkf+SFqqSDQCu8kg8egADlX2thsLGOtAO5hxMNrqVNa1ARUEpUvSKh6Gi
 chkw==
X-Gm-Message-State: APjAAAWy/vR41R0R1HN9JXhvoVgxYDtRbC/CXdcz9EANbNBd2OtW+uG4
 T8mMYgbaD+FgWBbu1zCVU22LOmrWEdHu7kv/c0FbNzd071M=
X-Google-Smtp-Source: APXvYqwzoA5jl7B2bst3tjgbEjtuXku3lnw+mAiN4jYmo2WdLKlYEXBO7ggXrlqiSSYs3FCCVC+kcBYWk2OJIGQ7npc=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr21101070oti.91.1568049811037; 
 Mon, 09 Sep 2019 10:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
 <20190821072542.23090-21-david@gibson.dropbear.id.au>
In-Reply-To: <20190821072542.23090-21-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 18:23:20 +0100
Message-ID: <CAFEAcA_zvtxxsr1ZJEqA9R9GMZvo7D229FP85mUaRhbWei-Acw@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 20/42] spapr: initial implementation for
 H_TPM_COMM/spapr-tpm-proxy
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 08:26, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>
> This implements the H_TPM_COMM hypercall, which is used by an
> Ultravisor to pass TPM commands directly to the host's TPM device, or
> a TPM Resource Manager associated with the device.
>
> This also introduces a new virtual device, spapr-tpm-proxy, which
> is used to configure the host TPM path to be used to service
> requests sent by H_TPM_COMM hcalls, for example:
>
>   -device spapr-tpm-proxy,id=tpmp0,host-path=/dev/tpmrm0
>
> By default, no spapr-tpm-proxy will be created, and hcalls will return
> H_FUNCTION.
>
> The full specification for this hypercall can be found in
> docs/specs/ppc-spapr-uv-hcalls.txt
>
> Since SVM-related hcalls like H_TPM_COMM use a reserved range of
> 0xEF00-0xEF80, we introduce a separate hcall table here to handle
> them.
>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com
> Message-Id: <20190717205842.17827-3-mdroth@linux.vnet.ibm.com>
> [dwg: Corrected #include for upstream change]
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Hi; Coverity reports an issue in this change (CID 1405304):

> +static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
> +{
> +    uint64_t data_in = ppc64_phys_to_real(args[1]);
> +    target_ulong data_in_size = args[2];
> +    uint64_t data_out = ppc64_phys_to_real(args[3]);
> +    target_ulong data_out_size = args[4];
> +    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
> +    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
> +    ssize_t ret;
> +
> +    trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_out_size);
> +
> +    if (data_in_size > TPM_SPAPR_BUFSIZE) {
> +        error_report("invalid TPM input buffer size: " TARGET_FMT_lu,
> +                     data_in_size);
> +        return H_P3;
> +    }
> +
> +    if (data_out_size < TPM_SPAPR_BUFSIZE) {
> +        error_report("invalid TPM output buffer size: " TARGET_FMT_lu,
> +                     data_out_size);
> +        return H_P5;
> +    }
> +
> +    if (tpm_proxy->host_fd == -1) {
> +        tpm_proxy->host_fd = open(tpm_proxy->host_path, O_RDWR);
> +        if (tpm_proxy->host_fd == -1) {
> +            error_report("failed to open TPM device %s: %d",
> +                         tpm_proxy->host_path, errno);
> +            return H_RESOURCE;
> +        }
> +    }
> +
> +    cpu_physical_memory_read(data_in, buf_in, data_in_size);
> +
> +    do {
> +        ret = write(tpm_proxy->host_fd, buf_in, data_in_size);
> +        if (ret > 0) {
> +            data_in_size -= ret;
> +        }
> +    } while ((ret >= 0 && data_in_size > 0) || (ret == -1 && errno == EINTR));
> +
> +    if (ret == -1) {
> +        error_report("failed to write to TPM device %s: %d",
> +                     tpm_proxy->host_path, errno);
> +        return H_RESOURCE;
> +    }
> +
> +    do {
> +        ret = read(tpm_proxy->host_fd, buf_out, data_out_size);
> +    } while (ret == 0 || (ret == -1 && errno == EINTR));
> +
> +    if (ret == -1) {
> +        error_report("failed to read from TPM device %s: %d",
> +                     tpm_proxy->host_path, errno);

The tpm_execute() function can unconditionally dereference
tpm_proxy->host_path, implying it can never be NULL...

> +        return H_RESOURCE;
> +    }
> +
> +    cpu_physical_memory_write(data_out, buf_out, ret);
> +    args[0] = ret;
> +
> +    return H_SUCCESS;
> +}
> +
> +static target_ulong h_tpm_comm(PowerPCCPU *cpu,
> +                               SpaprMachineState *spapr,
> +                               target_ulong opcode,
> +                               target_ulong *args)
> +{
> +    target_ulong op = args[0];
> +    SpaprTpmProxy *tpm_proxy = spapr->tpm_proxy;
> +
> +    if (!tpm_proxy) {
> +        error_report("TPM proxy not available");
> +        return H_FUNCTION;
> +    }
> +
> +    trace_spapr_h_tpm_comm(tpm_proxy->host_path ?: "null", op);

...but in this tracing at the callsite we check for whether
it is NULL or not, implying that it can be NULL.

> +
> +    switch (op) {
> +    case TPM_COMM_OP_EXECUTE:
> +        return tpm_execute(tpm_proxy, args);
> +    case TPM_COMM_OP_CLOSE_SESSION:
> +        spapr_tpm_proxy_reset(tpm_proxy);
> +        return H_SUCCESS;
> +    default:
> +        return H_PARAMETER;
> +    }
> +}

Coverity isn't happy about the possible use-after-NULL-check.

thanks
-- PMM

