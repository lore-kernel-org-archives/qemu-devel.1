Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED06ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD5C920872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkjWXU/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5C920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOVk-0002z4-3h
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKO8L-0004jt-Nw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKO8K-0006ZK-A3
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:49:09 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKO8J-0006YZ-Rm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:49:08 -0400
Received: by mail-oi1-x243.google.com with SMTP id 83so17052270oii.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/kwSlXh6iJx2O0gCfEtXXAa4F2WK8uIGGEOp4n92JOM=;
 b=LkjWXU/fZpk5VVnZObAdiPhF8A1Ozh6Fl7p+l0J7kmC3t20Uh+d+oCGGy3oF3r6NLe
 hEMsy2Wbsoy88zOrL45mi3wV5z9sQOIlnfWr49WcGTrBZZFV2BGwb3FveDziPpo2JDHn
 kpfwm1CHlRPfu67CpYnsHA+1wpF0ME1e5MUbXx5mtN+kOdrNVrNnJDBrZ1EIU+mV5Pdc
 tzOgjKPkaHhXJTvyHhOC488MgyE1HprVgxyht758wl7rSo7bBSglCnMNh6dlHJRqWz03
 BJmurMMAc0G60/VAehe5JtgYrsbOa1fAHAfsIw8/AbrFpjs06sppNhC+IkGXs5ZWKzIv
 V3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/kwSlXh6iJx2O0gCfEtXXAa4F2WK8uIGGEOp4n92JOM=;
 b=qeJhustbcWD3EXqqlFttPhSAATN0ROF1jpkCErkH/xtJTIu3NU8utWayCmCV4TXqqF
 maFRbUQb7cLAnweRdy2bJE/jCNLIP9tgTx1BaySePDE3HPDP7gLFzH9LwgHg/Mwj4q1r
 JUPbzlPWSteb4V7fHbsnAeosKteEHRMnYt+XvaZqECEi7iA7qZjDUmDFUrR/9E7KMxCb
 ylCp/ywW5DbsM5nGLlu4Ceku5gDkniokvPPt1pMTWAWd33EYSGgDoxbhmaEG+QHVlSmK
 RadWg5dg9bHsZjSSnn1pN/LiJSv0cyDkINK3kTm5H8f2Xx6acyywSGARiaRgwljDzE/3
 CKNQ==
X-Gm-Message-State: APjAAAUAQWcewcCc9rroLR1AkmhdsMsSlTaEbEB05da5eWbGXrQ2Gdp9
 pgHs4Oau2EZ1RTYNAqSTPyIkPNxtLYdwfo5C5/9s0g==
X-Google-Smtp-Source: APXvYqxulgZJq7+EMr7REicShnKhm+CUfM2qlJR9cQM8gDJsBL49U+8xBNQAEvwouzHYF6STEw9GWU7u1fqNxMz29Vg=
X-Received: by 2002:aca:49c2:: with SMTP id
 w185mr29667804oia.163.1571150945480; 
 Tue, 15 Oct 2019 07:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191015140140.34748-1-zhengxiang9@huawei.com>
 <20191015140140.34748-6-zhengxiang9@huawei.com>
In-Reply-To: <20191015140140.34748-6-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 15:48:53 +0100
Message-ID: <CAFEAcA-92YEgrBPDVVFEmjBYnw=keJWKUDnqNRakw-jKYaxK5Q@mail.gmail.com>
Subject: Re: [PATCH v19 5/5] target-arm: kvm64: handle SIGBUS signal from
 kernel or KVM
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 15:02, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Add a SIGBUS signal handler. In this handler, it checks the SIGBUS type,
> translates the host VA delivered by host to guest PA, then fills this PA
> to guest APEI GHES memory, then notifies guest according to the SIGBUS
> type.
>
> When guest accesses the poisoned memory, it will generate a Synchronous
> External Abort(SEA). Then host kernel gets an APEI notification and calls
> memory_failure() to unmapped the affected page in stage 2, finally
> returns to guest.
>
> Guest continues to access the PG_hwpoison page, it will trap to KVM as
> stage2 fault, then a SIGBUS_MCEERR_AR synchronous signal is delivered to
> Qemu, Qemu records this error address into guest APEI GHES memory and
> notifes guest using Synchronous-External-Abort(SEA).
>
> In order to inject a vSEA, we introduce the kvm_inject_arm_sea() function
> in which we can setup the type of exception and the syndrome information.
> When switching to guest, the target vcpu will jump to the synchronous
> external abort vector table entry.
>
> The ESR_ELx.DFSC is set to synchronous external abort(0x10), and the
> ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
> not valid and hold an UNKNOWN value. These values will be set to KVM
> register structures through KVM_SET_ONE_REG IOCTL.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

> +static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> +                                      uint64_t error_physical_addr,
> +                                      uint32_t data_length)
> +{
> +    GArray *block;
> +    uint64_t current_block_length;
> +    /* Memory Error Section Type */
> +    QemuUUID mem_section_id_le = UEFI_CPER_SEC_PLATFORM_MEM;
> +    QemuUUID fru_id = {0};

Hi; this makes at least some versions of clang complain
(this is a clang bug, but it's present in shipped versions):

/home/petmay01/linaro/qemu-from-laptop/qemu/hw/acpi/acpi_ghes.c:135:24:
error: suggest braces around
      initialization of subobject [-Werror,-Wmissing-braces]
    QemuUUID fru_id = {0};
                       ^
                       {}

We generally use "{}" as the generic zero-initializer for
this reason (it's gcc/clang specific whereas "{0}" is
in the standard, but all of the compilers we care about
support it and don't warn about its use).

> +    uint8_t fru_text[20] = {0};

Clang doesn't mind this one because it's not initializing
a struct type, but you could use "{}" here too for consistency.

thanks
-- PMM

