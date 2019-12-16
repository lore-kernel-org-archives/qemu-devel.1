Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F15020663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ac/8lu9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F15020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsOm-0000Hf-P6
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igsNx-00084L-8d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:34:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igsNu-0007bX-ST
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:34:12 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igsNu-0007b1-Ia
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:34:10 -0500
Received: by mail-oi1-x242.google.com with SMTP id k196so3623992oib.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XlFImKkLeBBCYbNKNKMVNzlOgmpDx8oY5F19MpVJ9X0=;
 b=ac/8lu9Qp8RqTMui7fWYkg3YW0UzDilHTCt07oFtlDFztpucpEj1EuQyWpkzPlI7xK
 niV9XXnmznXkYllPsnWsQgLejsr2wfbSNyARJFW0aGJSp6L3OeHK3HW4oVZr43p2oohy
 qybzctq6hNnsIo4THy/YB0ezl9kDLuGikOkmj+wJ2sf1COWNadr70A/5DhzJpZ1QtOVP
 Noe36WVdcTh31UmRsyLaO63hupD7Xc7abZcZzn1jmzbDFqDtkSBpbjhcYgT+LnHuYBVv
 GEo6xSfj6Tmiq7++BPfFtymsONqYTynfgarHzh+KPpdTAypq/FIj5M5NS7h45LFT7ZJC
 kLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XlFImKkLeBBCYbNKNKMVNzlOgmpDx8oY5F19MpVJ9X0=;
 b=ACgrzqa5ljheeFxUTfWGAsQZpClYe1WUUYhjAPiHJydN4a/OsHlw3JCkL5z6Q2GEId
 33KWyHTkJD4leSPu51yM5EyhupuxQgnKUC9HywHu5vwRxHhjUPHqsouEZta4yr6f7nAv
 aGVKol0gtKpKaEZj+u7JvYohp6wJAATOAPCL0lysg/iVfqTBLTnrMfXPe90C3aHTG5NH
 BiYp637DZ7CghVge3YBxpmkccjC13DPfCh9fgB5ad9SHZgz91GBz3vdRlLMGANYJr265
 5loZUIRa4eIKZIWCi8WNHRdYrekzmxPUXaQC0wAQRYLZkuGDHSehXHcUTWa8y6ySjZT8
 E+kw==
X-Gm-Message-State: APjAAAVFMShes+5Ig9xlo9KnmADW0cBm1eYNhfBULjnkkLzPWWzfyG0Z
 zplcRfNgYcIU8CPM2IqtMWRNgI1NkJmYY8H490Cy8Q==
X-Google-Smtp-Source: APXvYqx6JSojAgU7E1NxJd/LWb+yfZXK/wnaMHAhqtzpEt1CmfEXgx8tHt8lCEUrWdpnkqz4xQ5qQXDhPeYDWJ60Mmo=
X-Received: by 2002:aca:f484:: with SMTP id s126mr9237783oih.48.1576510448904; 
 Mon, 16 Dec 2019 07:34:08 -0800 (PST)
MIME-Version: 1.0
References: <20191212173320.11610-1-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 15:33:57 +0000
Message-ID: <CAFEAcA9FprSotg11rS0fM94QiciysZ6kgKhyU4eQfZg7YYaL5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] target/arm/kvm: Adjust virtual time
To: Andrew Jones <drjones@redhat.com>
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 at 17:33, Andrew Jones <drjones@redhat.com> wrote:

> Userspace that wants to set KVM_REG_ARM_TIMER_CNT should beware that
> the KVM register ID is not correct.  This cannot be fixed because it's
> UAPI and if the UAPI headers are used then it can't be a problem.
> However, if a userspace attempts to create the ID themselves from the
> register's specification, then they will get KVM_REG_ARM_TIMER_CVAL
> instead, as the _CNT and _CVAL definitions have their register
> parameters swapped.

So, to be clear, you mean that:

(1) the kernel headers say:

/* EL0 Virtual Timer Registers */
#define KVM_REG_ARM_TIMER_CTL           ARM64_SYS_REG(3, 3, 14, 3, 1)
#define KVM_REG_ARM_TIMER_CNT           ARM64_SYS_REG(3, 3, 14, 3, 2)
#define KVM_REG_ARM_TIMER_CVAL          ARM64_SYS_REG(3, 3, 14, 0, 2)

(2) some of the RHSes of these are wrong

(3) but the kernel internally is using the same 'wrong' value, so
userspace also needs to use that value, ie trust the #defined name
rather than manufacturing one ?

That's awkward. I think it would be worth at least having a kernel
patch to add a comment clearly documenting this bug.

(This error seems to only be in the 64-bit ABI, not 32-bit.)

QEMU does assume that the kernel's ID register values match
the hardware for sysregs in some ways -- we use this when we
construct our mapping from KVM register IDs as returned by
KVM_GET_REG_LIST to QEMU cpreg definitions and thus CPUState
struct fields. I *think* that in this case the only visible
effect will be that gdbstub will show you the CNT value
if you ask it to print the value of the CVAL sysreg.

thanks
-- PMM

