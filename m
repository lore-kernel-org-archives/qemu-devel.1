Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7DAC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415982085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 01:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Znd3haHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415982085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfx5j-0007wY-4X
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 21:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfx24-0005v8-71
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hfx22-00031y-NA
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 21:47:31 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hfx1z-0002so-Rh; Tue, 25 Jun 2019 21:47:28 -0400
Received: by mail-ed1-x543.google.com with SMTP id p15so757317eds.8;
 Tue, 25 Jun 2019 18:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZpsEJNg6yZHKk6edmvTSPFaui+jfap7veYLi+NiMOus=;
 b=Znd3haHXla2PR/Ffl+g6X61ZnGemIdXhNwAgpmEw5refu2AAski97xz+IHmfbYfLqQ
 dlvrQllKcTRtGaniPEdael7JBxStXswOVyR5Eyu4QC/B3VyLrQ3eyVN8Was6xu6fnMge
 9e5vH5txOWNA9+YeJrojEk+Dm5yYCRAWgZcfS+k2y3ATc1QG4T7/Vkj2uqqHDhrhjy47
 yyxh1fZXYQfOwMMv2WY8s0MS8OhhzQ6DccoQIyB34Gmku3J628MWqyHJIx9tCvtVrBuM
 NlgDimz1uIj2U2/swRJUKFThAjyK3Dh3EdEphVF4rLl41YSeR7LRh5o24dESbqCLwv3Q
 k9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZpsEJNg6yZHKk6edmvTSPFaui+jfap7veYLi+NiMOus=;
 b=dHMam5ygdnxu04zixDOmGTPVVXzAX9EuGdyP2N9NA38D8Mm+KvCxjk2MiUGtbBV1Fg
 PVn50cGRV2nZ8CtU02qR/VgKnBJUm3KIGHAfgfEQqTofAE+/jiNmB3wbS4VnpgXBlM29
 R49MG8nH8pPvLaqFdvhPD2vhKYuI8DTKCe1Ob3syehrOZT+804x7mYN/fpp4HE7+5KUg
 2gP+UwjaRXdSxaR/rQZdXkxyMXIFyXE+JBOT6AsNCldQPp9qrxhEjLDt/cjRjCo0zaT5
 V/LykCmZGPmJksv4SXi7LcrEyITOrUpZaCDvLwopkDUIJbYenKIy8fRyUHtd1rR0bqFc
 ek9A==
X-Gm-Message-State: APjAAAU4mWOLiPxQNQjlNeoTFZwCKaNEIQjEtgjr5SQYqrqwJMLxalZ4
 F2HVRC1qnPKsLHYuabPOloLj1eSjSQnF8aQjvmgg3s7/
X-Google-Smtp-Source: APXvYqxzM7uErjl7y5wNZhPDI4gZ0yvCLudnrRIgg3l72q96Kr1JwvtErJSH5y+B5CeOPjO8+0+R6X/MLp5sXBZ0vmk=
X-Received: by 2002:a50:ad0c:: with SMTP id y12mr1788105edc.25.1561513646064; 
 Tue, 25 Jun 2019 18:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558108285-19571-1-git-send-email-bmeng.cn@gmail.com>
 <d5299afa569640c91c4206e38e7098320a4d00b2.camel@wdc.com>
In-Reply-To: <d5299afa569640c91c4206e38e7098320a4d00b2.camel@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 26 Jun 2019 09:47:15 +0800
Message-ID: <CAEUhbmVjExqi9dbq2yuKC7mw1GczxY36AeUAwkQz2+Cc5KWnKA@mail.gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH 1/2] riscv: sifive_u: Do not create
 hard-coded phandles in DT
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
Cc: "palmer@sifive.com" <palmer@sifive.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Sat, May 18, 2019 at 5:34 AM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Fri, 2019-05-17 at 08:51 -0700, Bin Meng wrote:
> > At present the cpu, plic and ethclk nodes' phandles are hard-coded
> > to 1/2/3 in DT. If we configure more than 1 cpu for the machine,
> > all cpu nodes' phandles conflict with each other as they are all 1.
> > Fix it by removing the hardcode.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>

Can this go in the 4.1 PR?

Regards,
Bin

