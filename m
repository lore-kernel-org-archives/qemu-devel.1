Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A194CC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7355C23E29
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 03:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li7e8lnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7355C23E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWBUP-0001K9-ON
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 23:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hWBTY-00010h-SH
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hWBTY-0007sO-1S
	for qemu-devel@nongnu.org; Wed, 29 May 2019 23:11:32 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40701)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hWBTV-0007qQ-V3; Wed, 29 May 2019 23:11:30 -0400
Received: by mail-lj1-x241.google.com with SMTP id q62so4581771ljq.7;
	Wed, 29 May 2019 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4iZNZXWvjTNPW170/Ws2I20i4KzM4jE0u76vbgbGPW8=;
	b=li7e8lnke/ooqQZ13G/WUIUsapXROnvY7XLiNIRO19GdaZ0ai+knVLsEsffTNB5FWF
	bhUjTLPbLr2IV97X0eWlyTO/gPdGsatr9F6FW0ngNACbI539ojFU4smGDIzoOuatXyeU
	ocupKtNUYABroOPddUqlXlZLgmhF2s6lGJcEpdvnhK9UyL1NWfWJWVpnhKOVE3/sRaoB
	1ddGFclOVp6x/MvviPqKigBmChINu8bs4hpJeEIsKL23+UJyCxdJAdhzMyv99y0DOV+l
	7Nl79NNtyMH6p400Bt1m9lHlfw9h1VpLWN+cpfAJVUiZX8RJyiuyOLWLwGJInOL8GwQ7
	IG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4iZNZXWvjTNPW170/Ws2I20i4KzM4jE0u76vbgbGPW8=;
	b=NSDOCYXifh3dnxfNNkO0Ph/OrZFNXXfaL5cI99Ip6U7r3L20OyC79B0PfxANV1rw73
	632ZzL/Lb4k8ZpsEzDfOmAoYPeJ2uO+30gZgIfY8E5/BzVGcdaqEzwZIQyErZKYvzfwW
	24/71QqzyZKLQzjW4uSoB0GG9kVC+9rrd5BBAdd/Yut9Ih9Z0NHStz93yONDD38IALyt
	OI56Ojs1xOIf+ygLXjM1Zo32xQMeEejJRZBR/bRu0CWVfMW7qIzrg1LERmkGBRWGn6o2
	ArfGLOWKg08GOIewhujsvW1JsGJfuD8jtFmI+CJWLP+JaGaxqyZOYtAtyy4F2w8ke6SG
	p23w==
X-Gm-Message-State: APjAAAXGNRqybtA5obiDD0AXKQl/DJt18Hufnojn7831e/dsss1oR+O8
	Wd4Lap33pW0nOLElfV7iLsnL0z/lXZ2U/2mJFE4=
X-Google-Smtp-Source: APXvYqwxzQ2ou01enm7k/7EoW/e3ztjccXFepVHmFQiBgRTMs+hFcU5XNj1HvsBf1E3X4NvC8hlyxYMq3IixeNVufGk=
X-Received: by 2002:a2e:6545:: with SMTP id z66mr698857ljb.146.1559185888254; 
	Wed, 29 May 2019 20:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190522090947.22334-1-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190522090947.22334-1-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 May 2019 20:11:00 -0700
Message-ID: <CAKmqyKP9PbWhXEHrEcYoRrZD-MSMomC1k0DgKK2u19eZXt6uHQ@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCHv3 1/5] RISC-V: Only Check PMP if MMU
 translation succeeds
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 2:13 AM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> The current implementation unnecessarily checks for PMP even if MMU translation
> failed. This may trigger a wrong PMP access exception instead of
> a page exception.
>
> For example, the very first instruction fetched after the first satp write in
> S-Mode will trigger a PMP access fault instead of an instruction fetch page
> fault.
>
> This patch prioritises MMU exceptions over PMP exceptions and only checks for
> PMP if MMU translation succeeds. This patch is required for future commits
> that properly report PMP exception violations if PTW succeeds.
>
> Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 41d6db41c3..40fb47e794 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -401,6 +401,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                    " prot %d\n", __func__, address, ret, pa, prot);
>
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> +        (ret == TRANSLATE_SUCCESS) &&
>          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
>          ret = TRANSLATE_FAIL;
>      }
> --
> 2.17.1
>
>

