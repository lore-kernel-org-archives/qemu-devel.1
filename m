Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A387EC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D89A208C2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HIV6Xgt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D89A208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAdS-0004v8-JS
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:04:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQAbT-0003DN-RB
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQARI-0002hd-CY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:52:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQARI-0002gw-2h
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:52:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id l17so11619532otq.1
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/h7YDU+P6MUHl6sVj0WLp+MoxyBRTBEzmvX8oGYQxPw=;
	b=HIV6Xgt0hlwXHD88KEhJy0PqeRJraTxBfxR2EpWUqn7bD/MeMl+qPLfovJYIfQlXUH
	BKJMP7+97uiq3Sr1Jp5kVTSvFBqmtBv8vKN9ijEX0gtHlHTaOPcxijD/NevmbmDRkp54
	hsj5T93JiqUv5kV0a2dNDqrk7iUOHjoOYjT36htvtDJUwnyrqR2ew0OiHD7YtdZSQ0o/
	NVC+WITkg5D1YjYGKsfgnWdj9YvqukCY4z4QKhdpKiaLiekXV1oc07yjdUahfPkf2N08
	Y9ojpNQiS5gvxBxhv+ysFu3dXqPbJddhbNScx/bcQ70HfiU0IfoCQcBhQSb24S4Pg0BH
	BGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/h7YDU+P6MUHl6sVj0WLp+MoxyBRTBEzmvX8oGYQxPw=;
	b=pQaVWokwwB3cqOnNCWkZZkCRwRdh1FDI7EqUBuuD5lCFiSVquoxMmE+TAF7DG0Futm
	jr6tyg/hbVT2lvPEnm6afPtqO62jzJj3IPOT7DE++NNEGlVuOwHiFW+3cNhd6uRfdYRI
	8lhYxiGD5mNmX2qBgvLDD24NBOf9zMgZZ6vkYmeSIU3VJlKIz0Wrkt2mG5J+7qJ2vt4v
	Eh0dod3Vyc3qS/5jmgQFQjxeuy9FcGg32UeWSptdjaXhSsgKxWdquVMw7hLI3T+DegeK
	LpGYh2Rb7QH44HRqvKTucD2cWFgI1LEqHUncHSzgbpEm3dgpQNuzcjXlzKCy6IjioO5S
	qTXg==
X-Gm-Message-State: APjAAAUn6dJEg2NwyR0K/bN/LjigOBPSEit0rzcsEawjn0wjvqOLpefO
	VJVg4gYwzMd7ezD8gEH4732wOio5xhzT7vsqmteUBQ==
X-Google-Smtp-Source: APXvYqzU1KagDuT8cYSQvW6nJUrBFKBgehNsCEbpnaW4NclGbCz1NWGRZC8o9SUsmJnUBwuuLvv5/OMp+Rgu8aGJhEM=
X-Received: by 2002:a9d:4793:: with SMTP id b19mr12407690otf.238.1557751938700;
	Mon, 13 May 2019 05:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <1557751388-27063-1-git-send-email-gengdongjiu@huawei.com>
	<1557751388-27063-11-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1557751388-27063-11-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 13:52:07 +0100
Message-ID: <CAFEAcA81nMkHdCvQTcv2ixNB7sg+3Qx+9mpNgF0XLaBPY7-PNQ@mail.gmail.com>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v16 10/10] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 13:46, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> translates the host VA delivered by host to guest PA, then fill this PA
> to guest APEI GHES memory, then notify guest according to the SIGBUS type.
>
> If guest accesses the poisoned memory, it generates Synchronous External
> Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
> to unmapped the affected page for the guest's stage 2, finally return
> to guest.
>
> Guest continues to access PG_hwpoison page, it will trap to KVM as stage2 fault,
> then a SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this
> error address into guest APEI GHES memory and notify guest using
> Synchronous-External-Abort(SEA).
>
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>


> +void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
> +{
> +    ARMCPU *cpu = ARM_CPU(c);
> +    CPUARMState *env = &cpu->env;
> +    ram_addr_t ram_addr;
> +    hwaddr paddr;
> +
> +    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
> +
> +    if (addr) {
> +        ram_addr = qemu_ram_addr_from_host(addr);
> +        if (ram_addr != RAM_ADDR_INVALID &&
> +            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> +            kvm_hwpoison_page_add(ram_addr);
> +            /* Asynchronous signal will be masked by main thread, so
> +             * only handle synchronous signal.
> +             */
> +            if (code == BUS_MCEERR_AR) {
> +                kvm_cpu_synchronize_state(c);
> +                if (GHES_CPER_FAIL != ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr)) {
> +                    kvm_inject_arm_sea(c);
> +                } else {
> +                    fprintf(stderr, "failed to record the error\n");
> +                }
> +            }
> +            return;
> +        }
> +        fprintf(stderr, "Hardware memory error for memory used by "
> +                "QEMU itself instead of guest system!\n");
> +    }
> +
> +    if (code == BUS_MCEERR_AR) {
> +        fprintf(stderr, "Hardware memory error!\n");
> +        exit(1);
> +    }
> +}

This code appears to still be unconditionally trying to
notify the guest of the error via the ACPI tables without
checking whether those ACPI tables even exist. I told you
about this in a previous round of review :-(

thanks
-- PMM

