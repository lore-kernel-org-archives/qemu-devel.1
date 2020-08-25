Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92717C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54646206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcbOGWz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54646206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgke-00076m-KL
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAgjC-0004nJ-5j
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:43:38 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAgjA-00071X-E8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:43:37 -0400
Received: by mail-ej1-x642.google.com with SMTP id md23so73235ejb.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h1FVVkrFbpNV/8y6G4wjzVwaJ8iV8BwBwU+88+xv9yE=;
 b=AcbOGWz51d4ijeP11gt5V3TIoDJn6xn2rnQjG1UyzIJ3EjQrWsbXKDluQiKZZJi59d
 WTl4X6YLuuh6kxMhdMFvfUxrJ8A4MxnxfoxjGfAOPhDSFeYRUXERrW0SRl+DN0RIVQlO
 Bf7lkVbFHIX7/7Iy8JKlFR9APNtv0gUGZJnVwW7KD4dc2uPAyAkio9nMX3wrPseRpcAb
 36Awy3YhBDR4/kaOoCJWvUlA/S6X7GOrWzFPbfELT0CBHG6OYA2FSffARrSoZH2uk/+X
 je+U++93lnHOMzZnCSu5+bSbfrXie3Y7d1LAnYV/oLrkYefZYb8zXhOpD0E+MFr9Wrzr
 hiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h1FVVkrFbpNV/8y6G4wjzVwaJ8iV8BwBwU+88+xv9yE=;
 b=P67+cDn9Tnk7nWAGImxS8UXEjyaP0Smp4+N8OZdBS8LYi1BRy6ogGsnXiiaekonFDq
 GjGzD1mnCGRgYfFKxIhrPU0M8BID0vv9IZn5kGBNdWVHej573JvWPO9hW1PQgQ03+YYE
 SzewNIxPX9DGWjm+jB7gVPcoNclYsCG0nEDtdP5PyDatANkkH7qN/PD1zPaqBx3CVnj0
 gq8IDjm6zIFhQu8rNXKN7EFzQzMhZY7S+hWHKDnLiVM2schEmHaX827YRTcFLjewINWG
 HSthNlUtgBhVmXm/fF50AT1uMgLT/Ko0Rqy8jsnV6hR+oxr6DoaCdPZ/I5PBthQ/rKcf
 Fbpw==
X-Gm-Message-State: AOAM533f3zkWtkjQXPmNBYfPmECfbGBozG2uy3DE7hoAPrbtzOnFwSjJ
 dgCfCLcu2/e9QNaBWbZfrdsZgjQv7RxdWEMFAC/3FA==
X-Google-Smtp-Source: ABdhPJxwva7WeoJy1zF4O/HqBOQrxTPplqX71I4gIRaw9l5GLUTWWAHJI8rP5MBt+1vPRJns5z17s9Zoy4tb6xhTOLI=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr2967219ejg.250.1598391814620; 
 Tue, 25 Aug 2020 14:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200819192240.GA25305@dhcp-10-100-145-180.wdl.wdc.com>
 <CAFEAcA8-VgEDTZ7+T9ZgB2LR9KWRrejBtZN=iwy2GGPcuFuz2Q@mail.gmail.com>
 <20200825201242.GA20971@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200825201242.GA20971@redsun51.ssa.fujisawa.hgst.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 22:43:23 +0100
Message-ID: <CAFEAcA-SD1WMODNzZpJkq_39bk72Gf+XFhCKWEDjTb0Lvdfe9g@mail.gmail.com>
Subject: Re: [PULL] nvme updates
To: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 21:12, Keith Busch <kbusch@kernel.org> wrote:
>
> On Sun, Aug 23, 2020 at 02:56:12PM +0100, Peter Maydell wrote:
> > Hi; it looks like this isn't a gpg-signed tag?
> >
> > error: remotes/nvme/nvme-next: cannot verify a non-tag object of type commit.
>
> Oops, sorry I forgot about that part of the procedure here. The repo should
> have a signed tag now:

Thanks; the gpg key setup looks ok.

I notice that all the commits in the repo have Klaus's signed-off-by.
Usually the expectation is that the person who sends the pull req
is the one who's curated the tree and added their signed-off-by,
but are you doing a jointly-administered tree here ?

The build has a format string issue that shows up on OSX, Windows,
and 32-bit builds:

In file included from ../../hw/block/trace.h:1:0,
                 from ../../hw/block/fdc.c:48:
./trace/trace-hw_block.h: In function '_nocheck__trace_pci_nvme_err_mdts':
./trace/trace-hw_block.h:2162:18: error: format '%llu' expects
argument of type 'long long unsigned int', but argument 6 has type
'size_t {aka unsigned int}' [-Werror=format=]
         qemu_log("%d@%zu.%06zu:pci_nvme_err_mdts " "cid %"PRIu16" len
%"PRIu64"" "\n",
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

thanks
-- PMM

