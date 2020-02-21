Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC0C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91D120679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksSrv+JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91D120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58th-0003th-6Z
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j58t5-0003LR-20
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j58t3-00069z-SU
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:02:38 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37161)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j58t3-00069H-Mk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:02:37 -0500
Received: by mail-oi1-x242.google.com with SMTP id q84so1653996oic.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ustmWK5mEvdAZcOBmaOSg4VtBioTYnOuWkx56ShVqRc=;
 b=ksSrv+JQp6iia60+jXznBn1bDqYQPbMAYUjTQvr4KXPkqeSD2mwVnvhvOCiEd0nYMO
 +fX3gUUCsG9jjZzmzjrXMHiRcjpNmmuHttONuw+J+gqM1rbz70fXx123EtxWjaiyUmoZ
 QdwQXxqrzk+7yloQ46ZuZ2no4EmQOrZiRX9c3/FS4Uq6QmCtL0plHzM83fzklhUBE/kf
 r91ZvTUhs0Oo4BE8652GkH8ZZXdXIwahEzUHL5SfSWE9AytFKP9tlQ8unhXEMNj1IH3m
 wAlHaVkOqR53LXl85gOguvTn7u31lxWsKdGQbG9uoioc+M98IBpDaQeYFFm6EOlg8UDB
 kNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ustmWK5mEvdAZcOBmaOSg4VtBioTYnOuWkx56ShVqRc=;
 b=saDLLFUpPVt+Joa48uAUC/03Speu+3S329ry2RRbj37K1d64N+ht5Ttp4iqOcvhggd
 Ylxe+s8W8QHmAGbSWFLCTxjDNgAELM3XfKQhS10dA7xVzfvhABiN1WchL58RdeHTMpOK
 rvEaeErj9wcyvffD39nn+ttP+gURxWCpW6hXawqUijAXjbzAn+svzJ6b/vkfv/qfNlZD
 7D+dkk8+4jktGuuIwH/END6rO3OeNEtxNX7zy6d/zEsHvw/i1kNojuzmTDwl/J4d56w9
 ipwoug5VtRvT9ynbV1Z6/Rh8R3jqUSTdELv9PJh4DlCmKJigsOD1SgemQRGRWUpQVB/3
 jdng==
X-Gm-Message-State: APjAAAVOO3zzQLZ1meJF9tLEENRZQaOfl4fUyij4Q4AUyrkeuAjAwJnR
 f6dUGHRoBMlrra9FaOWsX4xBIXWGeHX0FVlVZBrWGg==
X-Google-Smtp-Source: APXvYqxvQrgBavFAgPw3aYQcPGAqf36Tburz54dTfddYLHWZdLHBm1Io041OmFxhvi9reM6KXIqY2QZldRyCnxIkqSg=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2070195oic.48.1582293756639; 
 Fri, 21 Feb 2020 06:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20200217131248.28273-1-gengdongjiu@huawei.com>
 <20200217131248.28273-10-gengdongjiu@huawei.com>
In-Reply-To: <20200217131248.28273-10-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 14:02:25 +0000
Message-ID: <CAFEAcA9MaRDKNovYjH1FJXTbAVOL3JaA20Sc_Haa3XjnRNkGvg@mail.gmail.com>
Subject: Re: [PATCH v24 09/10] target-arm: kvm64: handle SIGBUS signal from
 kernel or KVM
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Fam Zheng <fam@euphon.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 13:10, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
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
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Xiang Zheng <zhengxiang9@huawei.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

