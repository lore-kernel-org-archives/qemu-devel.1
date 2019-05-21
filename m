Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F91BC072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 22:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7D721773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 22:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzHGpn2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7D721773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTDLD-0007mT-D4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 18:34:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hTDJx-0007BN-00
	for qemu-devel@nongnu.org; Tue, 21 May 2019 18:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hTDJw-0005On-1m
	for qemu-devel@nongnu.org; Tue, 21 May 2019 18:33:20 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hTDJt-0005N0-U9; Tue, 21 May 2019 18:33:18 -0400
Received: by mail-lj1-x243.google.com with SMTP id 14so256848ljj.5;
	Tue, 21 May 2019 15:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Qq8K7ub1MMu58My8La/+Jk01WXoSbdco5XkB1CZ5Nog=;
	b=TzHGpn2LVD+QzGFnyCpaZcAdLLI2gYORYNiQSqTWQq/ncV2+9Xt2dq41nrTcB5nIBt
	8sI3/rfexqe1r2jTrk7HwZtL2KGWeiMDCbKi7ddwJf/u6tp49gZ0BjQrGqGlHDoPm7cP
	HVdgkySauOYsDpL4E48N2Cs6aIAhFkdnviIcEb3Kc+3VF/8iPoz7ZLPw1cL5oFiiMnbt
	2Yp58j01um73YqYHzTwMvwbmA0k/WV/UMwOuY+SJCSJJUYugsFuw9xcdGYX1CIebS81l
	z4yyFmW7nWdXTixuuqBJePOJx9tz1vz8bEFw+3ukdpkWVPGvY9xQLMHS3WmSoI1XPWos
	awXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Qq8K7ub1MMu58My8La/+Jk01WXoSbdco5XkB1CZ5Nog=;
	b=Kzb9cF7Ia4/8Vm3ml5TTPdehzPrAnTtGA7eCbT3Tx0fPuVEXKg6/pL4lkGsBsno3Pr
	oagtq7+YLx48T+iZ0lUjG95U04reQIc23RvigLm5QlxdMD+Q+nR5KRpZ+72QENn5VM0w
	5Yxf05Mxh8OATR+TsKLux94XWMlxSiUaA0P6nXQ8tEikgsfukjBXEfPel/NgXf9UR9OF
	BFtrVLFFrqYuBpdilCseiAZ3M+2YgIpasIpeby1V68LvkZOK2oxqg6vczI2eupOskD/w
	+TayXxQeSD4qNUv8grERLLVODkYO/QV4gGNZxyiwNQRlRIG7ES18Oj6V6ue9YGnZ4I1S
	xfKQ==
X-Gm-Message-State: APjAAAUgRTd3QW8KEejDbM2kB86RuHpqlAZXSUuRIPVEltzacx6g7imO
	j4Y4pVVVpAFv3mCg6AxSjNe02/smUmcsJj2jKZ0=
X-Google-Smtp-Source: APXvYqxAXz2dw5W6Pmzsp7bnMT8CZ+Pg7nD2PahVQZcbqlspIXEptLRzgxsDe7+mN0lUfPb7S84i1XgNg6KSVSmLmtA=
X-Received: by 2002:a2e:8583:: with SMTP id b3mr17083058lji.136.1558477996615; 
	Tue, 21 May 2019 15:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190521104324.12835-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190521104324.12835-5-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190521104324.12835-5-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 May 2019 15:31:00 -0700
Message-ID: <CAKmqyKOaPEC=YdbwJkqZJBwTw++_9Cum5HSChtfnx7_uOmZ_HQ@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCHv3 5/5] RISC-V: Fix a PMP check with the
 correct access size
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

On Tue, May 21, 2019 at 3:45 AM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> The PMP check should be of the memory access size rather
> than TARGET_PAGE_SIZE.
>
> Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d0b0f9cf88..ce1f47e4e3 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -410,7 +410,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          (ret == TRANSLATE_SUCCESS) &&
> -        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
> +        !pmp_hart_has_privs(env, pa, size, 1 << access_type)) {
>          ret = TRANSLATE_PMP_FAIL;
>      }
>      if (ret == TRANSLATE_PMP_FAIL) {
> --
> 2.17.1
>
>

