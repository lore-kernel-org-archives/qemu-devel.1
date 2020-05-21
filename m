Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C97C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFDF2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpMJZPem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFDF2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbksH-0000oU-VD
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbkrW-0008UW-6X
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:03:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbkrU-0007xs-VL
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:03:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id z3so5408856otp.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rN1A86gX8Zaqy8L+ej3ws6/vAjx88+tA7UfKo62wTHI=;
 b=BpMJZPemrMvFgooBYmCmDWknkWT7gLHdpRE59t8WHdZOp1J89tvNJeH4zZ5YMRkYQA
 PRZHgW9NABopgEKNDoWMCgchlr+Xc6zriY065WsoMbXkXP3AmQfqmOv02DOOTLm1kVqh
 1ZW+IjATa/Qt06FwgkUpDtENsJBHbZKfjeZmzpCOG8Ky+eNK8K9dqWow9uS+M5POMXa6
 L66KYDX2fxXNCNM1/TCGo53mDhsaf4+Obglcuqm9nW9zPlFyGV4NIQDxKGie0vAuKc7Q
 Ov8kP1PMXxi+jBRKeW4KhHOEKbk5mV3lNZFsTpTpfYyaOE+PKtv30ejJrfx+g2trIMyk
 a24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rN1A86gX8Zaqy8L+ej3ws6/vAjx88+tA7UfKo62wTHI=;
 b=jfRl9cB87XTgfOzL1wh7PYnGZ4Z7Uo/SmmiFZOdPQ6bfroMxp6u+gfm1y5O1OliQVz
 eyxQZfrjcNaAM4KT9HaGb9Xxw3T13kWzxU7NQRyLD8w2j7dLLCk7EBfzEhiRkSXi7FcR
 0pKKaV9XSJEHVNgl8ImzCpMBZhkrUW0/TaJ8jsvIiZi7wx/3kLAXJjhls/ObO50O4acw
 AgJzLvWKzkXI4x48+lgYEH1cQi0Pax1A2az3iH18iJnP+7DAFKazwTRl3XwXMcA+JHL4
 Qfji/XWhydaoDTN1pgfnAjQNQIeOcxX4e8qpGsx7Minjc418Vux6sp7w8rZX6+2vNBIl
 ZKYA==
X-Gm-Message-State: AOAM531ge/DNVXw5jBLTYwAJV3DtKkLtcymbd3T1wR+JmUsBBOLVdHCz
 cu9pyOceuBv5UxIfMXb0K/4dnAfPEM2+34wt28U76uSW
X-Google-Smtp-Source: ABdhPJyk4eNMiFLAVGvCztYPJN3nExJCVrNexKXVKCmCRjX5E0NhQgxkLMUCHJrxPFcePGOAhsarh5DVAA/XwVZMOpw=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr7142844otr.135.1590066227329; 
 Thu, 21 May 2020 06:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200514142138.20875-1-peter.maydell@linaro.org>
 <20200514142138.20875-27-peter.maydell@linaro.org>
In-Reply-To: <20200514142138.20875-27-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 14:03:36 +0100
Message-ID: <CAFEAcA_a4yiE9UZx=MAFUM+f0LSiNvjQ=X1+dObELRzfnTyUHQ@mail.gmail.com>
Subject: Re: [PULL 26/45] ACPI: Record Generic Error Status Block(GESB) table
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>, Dongjiu Geng <gengdongjiu@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020 at 15:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> kvm_arch_on_sigbus_vcpu() error injection uses source_id as
> index in etc/hardware_errors to find out Error Status Data
> Block entry corresponding to error source. So supported source_id
> values should be assigned here and not be changed afterwards to
> make sure that guest will write error into expected Error Status
> Data Block.
>
> Before QEMU writes a new error to ACPI table, it will check whether
> previous error has been acknowledged. If not acknowledged, the new
> errors will be ignored and not be recorded. For the errors section
> type, QEMU simulate it to memory section error.

Hi; Coverity points out (CID 1428962) that there is
unreachable code in this function:

> +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> +                                      uint64_t error_physical_addr)
> +{
> +    GArray *block;
> +
> +    /* Memory Error Section Type */
> +    const uint8_t uefi_cper_mem_sec[] =
> +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> +                  0xED, 0x7C, 0x83, 0xB1);
> +
> +    /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> +     * Table 17-13 Generic Error Data Entry
> +     */
> +    QemuUUID fru_id = {};
> +    uint32_t data_length;
> +
> +    block = g_array_new(false, true /* clear */, 1);
> +
> +    /* This is the length if adding a new generic error data entry*/
> +    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;

Here data_length has a constant value...

> +
> +    /*
> +     * Check whether it will run out of the preallocated memory if adding a new
> +     * generic error data entry
> +     */
> +    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {

...but here we immediately have a runtime check which can't possibly
fail because of the values of the constants involved, so this
if() block is dead code.

> +        error_report("Not enough memory to record new CPER!!!");
> +        g_array_free(block, true);
> +        return -1;
> +    }

What was this code trying to do? Is the initial value of
data_length incorrect, or is the if() condition wrong, or
should this simply have been an assert() ?

thanks
-- PMM

