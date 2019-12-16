Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568D8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A26206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NPeDDWY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A26206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsWr-0007rh-C0
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igsU1-0004Lx-TA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igsU0-0002UH-Mo
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:40:29 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42284)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igsU0-0002TH-EM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:40:28 -0500
Received: by mail-ot1-x342.google.com with SMTP id 66so9670391otd.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=57XV+rnHN3MQjm/YspqhKVtAQ2f35QZqw0JR2xiVzc8=;
 b=NPeDDWY8ko/vEj1cI6b65AeL6fJIrTh+dpSfrqqgmJJkUWQL+1nKgFjI/jQT3Ecz1c
 2mPBUUmMfANPMWKx3eifhA88NOBCSuJtvgR67NYP5m36O1oVUU9fHOPinnJvSa540aJK
 CPrprBWuJTqR8yp4W8A61dyMcC9Pz7DbTYQnl9X620DzAdqQ24woflvxohgzUi7ze+Qk
 5eTncjZV1ldp6swPiqTcSFdYcydeVXu1JnM3PzkA6CCvnyddUKftWTQbB3XH4yvLaFnd
 ZjTZ29i7HgqGpzTxQ+4PUY2GdT5hoYpipHBOzhg4dSiQaEKwqOCqeMs1y7cPswFSuT8r
 ys1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=57XV+rnHN3MQjm/YspqhKVtAQ2f35QZqw0JR2xiVzc8=;
 b=EhtvjzIhPUfu0fZbv//uIdfSP2Edoyi0Ye/KKMo+BT3WLcrRpwlRLWDBCs1G+xV2be
 y1unMkX6gLmQ6OxHd3e+5dFIQGCXQwwbJHLneFvnokFCt0J3HlL0997h7/4SXDeCfJb6
 ICt5eLLKp+w6sTdUPPRh+Iopvnxj+X3CGJIwv7ERT/LwkjilFGCgHUqJrNIENbH3ui/S
 9lDAdplpzMBFRGDbVfqERfMabsgxxkWyLuYwDZ3Xir9EgWkpM773qXLgsXseNS8rjZsO
 FaR0yoJ00U97viZt1UbmEauRqB5c0ACYU65cLgUemebOaUENd0fdTqo68qa5VaZiPojb
 hvZg==
X-Gm-Message-State: APjAAAXAk+djBRd8+RBblfwwk2f7dqqt1rfoWofgDDvUWdbNDexg7UIn
 0cSIlQLBbHI+QLJeBl0ECZCZJ4B9noND2wGcJ/Supg==
X-Google-Smtp-Source: APXvYqxJ7jbu4CQNJtVa9Nx5P2BoDNizYRUY3fx4wg463tL4ttO8B8wQqHRqyT/hjSWtPGPYy+eAkweAlrNFs+isyGU=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr30804462otm.221.1576510827498; 
 Mon, 16 Dec 2019 07:40:27 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
 <20191212173320.11610-4-drjones@redhat.com>
 <CAFEAcA_u94O8WYLgB8DF=pu-3V7LrNWpiQFV5mDYeeqLj1Ee2Q@mail.gmail.com>
In-Reply-To: <CAFEAcA_u94O8WYLgB8DF=pu-3V7LrNWpiQFV5mDYeeqLj1Ee2Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 15:40:16 +0000
Message-ID: <CAFEAcA9ZoOZt6Jh42hi6q91=kRM9T9z436J99NF+Ns5KVKUYow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] target/arm/kvm: Implement virtual time
 adjustment
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 at 15:14, Peter Maydell <peter.maydell@linaro.org> wrote:
> How does this interact with the usual register sync to/from
> KVM (ie kvm_arch_get_registers(), which I think will do a
> GET_ONE_REG read of the TIMER_CNT register the way it does
> any other sysreg, inside write_kvmstate_to_list(), plus
> kvm_arch_set_registers() which does the write back to the
> kernel in write_list_to_kvmstate()) ? Presumably we want this
> version to take precedence by the set_virtual_time call
> happening after the kvm_arch_set_registers, but is this
> guaranteed ?

...you might also want to look at the effects of simply
removing the KVM_REG_ARM_TIMER_CNT entry from the
'non_runtime_cpregs[]' array -- in commit 4b7a6bf402bd064
we explicitly stopped reading/writing this register's value
to/from the kernel except for inbound migration, and it
feels like this patchset is now rolling back that approach,
so maybe we should also be (configurably) rolling back some
of its implementation rather than just leaving it in place.

I note also that the commit message there had a remark
about inconsistencies between VCPUs -- is the right thing
to handle this per-VM rather than per-VCPU somehow?

thanks
-- PMM

