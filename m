Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F92C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9932086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 17:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tq2L41f0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9932086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyg7C-0003bz-9a
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 13:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hyg6K-0003Ap-JB
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hyg6J-0008Ri-0F
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 13:33:20 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:37608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hyg6I-0008RC-Nh; Fri, 16 Aug 2019 13:33:18 -0400
Received: by mail-lf1-x143.google.com with SMTP id c9so4589640lfh.4;
 Fri, 16 Aug 2019 10:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sg4DchbEuir7TA0M1GFZRMxqEoBHsIS0Huq+Eu6XP0k=;
 b=tq2L41f0IXTzezULoWr4I2QKNjUexaVTTQg4co5CBG2JxMdyIf2laO9gqvrufs5moQ
 PjU+gA/jUC3iTLwWxjz4hAb0kmd4eMJqHyUktCt2RuVgFMRxSkkxDy6m5v4kNSmaIFdX
 tPTNh9YzyFq4Y+CnyofyEDxabRQ6Agv8oUa56mfDI4UodYe/qUPw/aIv/BdKGaLOt+3t
 zq4hmXnfXDqMUpZxJ99liHNlRfdXaC+v2AB3xVd6ePVcKssQxra0UJdQe4QWxr/V6ngk
 v8xgvKuiZSCHUoP9/7A7hgkfdhLn1Z+hP91QXRPjFL9CzASrN3hXk1TgMQAgN9A9PYX3
 Sp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sg4DchbEuir7TA0M1GFZRMxqEoBHsIS0Huq+Eu6XP0k=;
 b=kcSZ4dLW1po37NxGDVZOBuW8CJ1cYwZXEBLi49ra1JsWNrZmaS8b+6d1/cuDvuvGog
 nkWQYcqKHHysh85Id71XSE3JMVoQLk+IyXqdDD8fnkGy1MOwa6cfnNxUscDRXoYcMZF0
 8jEbq8fa156Il58D8xioSKkCFCL22Hy8GLToJqJ3DSSF4O5QBO3ppnDlTQE/bwgevVzP
 ZSS+1n5PyWZ/g7QxcGiHugBUgt/csuaMFcc/z3vVm0uo98feWlgo++JsBAm1Re5B/7Bn
 jBn/d1B4vUzd8j3Bv5hktXhyN2mnOmEeVFWZPYbkaDnzmA/0JPE1D745t7vj+bpwiqxG
 hdkQ==
X-Gm-Message-State: APjAAAXHYnZkePTZoak7Z7gB5XP1qKp23NOdBqkzRXmWDVAkiUwRTXjA
 QvzCuZ/IdtTnDzTSCE0+SXSKiOIqtcoEJL2Ms7c=
X-Google-Smtp-Source: APXvYqxSO9/6CRejVavGlJcQRfBJgqfkdm4/NF7DbI9ZQxD3Ma/RlKEvHre92ZB0++pU76jshZJdvMxmYkuJOzrLPMQ=
X-Received: by 2002:a19:7006:: with SMTP id h6mr5784362lfc.5.1565976797286;
 Fri, 16 Aug 2019 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <0141541d-43ff-98d8-e9d4-4a2fdcfdcf36@c-sky.com>
In-Reply-To: <0141541d-43ff-98d8-e9d4-4a2fdcfdcf36@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Aug 2019 10:29:21 -0700
Message-ID: <CAKmqyKPr0V6acB2-Y+N1-aoj-5LSofwi=Jz=u6KFJN1fPUWjzA@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] RISCV: when will the CLIC be ready?
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 8:39 PM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Hi, Palmer
>
> When Michael Clark still was the maintainer of RISCV QEMU, he wrote in the mail list, "the CLIC interrupt controller is under testing,
> and will be included in QEMU 3.1 or 3.2". It is pity that the CLIC is not in
> included even in QEMU 4.1.0.

I see that there is a CLIC branch available here:
https://github.com/riscv/riscv-qemu/pull/157

It looks like all of the work is in a single commit
(https://github.com/riscv/riscv-qemu/pull/157/commits/206d9ac339feb9ef2c325402a00f0f45f453d019)
and that most of the other commits in the PR have already made it into
master.

Although the CLIC commit is very large it doesn't seem impossible to
manually pull out the CLIC bits and apply it onto master.

Do you know the state of the CLIC model? If it's working it shouldn't
be too hard to rebase the work and get the code into mainline.

Alistair

>
> As we have cpus using CLIC, I have to use the out of tree qemu code in SIFIVE
> a long time. Could you tell me when it will be upstreamed?
>
> Best Regards
> Zhiwei
>

