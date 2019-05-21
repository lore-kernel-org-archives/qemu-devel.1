Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645FC072B5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 22:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5227A21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 22:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuiCX8cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5227A21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60433 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTDSf-0001Jq-Ob
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 18:42:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hTDRe-0000cn-SD
	for qemu-devel@nongnu.org; Tue, 21 May 2019 18:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hTDRd-0004js-Vq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 18:41:18 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hTDRb-0004gX-QP; Tue, 21 May 2019 18:41:15 -0400
Received: by mail-lf1-x141.google.com with SMTP id y10so167647lfl.3;
	Tue, 21 May 2019 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=qeS5ImG80zGyzgMtHMJ+UYhSUAWijmMWfvIC+znD4XQ=;
	b=QuiCX8cqYzEQNvyf7QUjtfTXV+fOD4HrcwYR8oZo00iGUaezbzsa9W2q9NA6si2RgN
	kBUo6BhS5q112CzBFLtxdxeJkq8ixVkYrvB2ioF9k9S8+680eG5IxgHL1cjkL35QDKUe
	vg+pHw2IrM77g0iqY5pWOsWzfVNqq+7SFnQK1iSIDV/YsyGMHJnewkVVyFMucoYSbFaQ
	aLzV16gUp+4bD73+y6eaxAFh3cboI64x5mHF54SIEFxFw+CEwpRCw4drr42h3zwdOg1C
	BiNYf6G8/Fbk49dWovIziH0BuHI9jTnJPjPpv6YcIAoUc3X57cCMRITv3PHfm7N6u0AR
	Zlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qeS5ImG80zGyzgMtHMJ+UYhSUAWijmMWfvIC+znD4XQ=;
	b=nlcdhcNdORD5X6BYKRpq0DUcs+oxT98hY6MsGz2gydHSe7gs9TNvnBQ4naBLqxu/Mw
	2cd8iPHM0m5U6HB9c2K035yDpi91nU1vKfe+vzk0q9iaCPAV+h/TXfEzecybfkeaO+BR
	KNkFBpU5ik/KH969aoQdV+qYUz6jO4FNB9S9PwKfJ7DMA/gFQYkdteYGrWJAX4CyAbNK
	CcUOeD3gdLJ3rPkjEzUhCAoyg4IsBivsUvOOHQVDDqNH5Oxixjppd3H/sSISDie8uZpy
	OY4eRBRdEQK3W20l3I3aiXXEGaZpz8yigQEEUGD4t4KXcKRy+XRCB31vGYU2OlqSevoO
	XiXw==
X-Gm-Message-State: APjAAAUWPXLMptilg9QFYSSd7cOI2KlW5j89f50wzcfCKj/aQW8naXP/
	aoIlVJnZiIDvj9JK4qFfbtHgU+MYAoPj4xnJ+Zk=
X-Google-Smtp-Source: APXvYqwH+cxoIWuT6gMBcjKX5Wn2t1Xt97rvteNSfH7ri6Z7Oj6xY5atYNCRd2E7EQ7L+7lIlVjtfG/7WK4sdiOwghk=
X-Received: by 2002:a19:4cd5:: with SMTP id
	z204mr27126773lfa.113.1558478474426; 
	Tue, 21 May 2019 15:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190521104324.12835-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190521104324.12835-4-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190521104324.12835-4-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 May 2019 15:38:58 -0700
Message-ID: <CAKmqyKOZzfZBU-nkRzsP9G0J07S8PchMt4W8m+OrMdZKms907Q@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCHv3 4/5] RISC-V: Fix a PMP bug where it
 succeeds even if PMP entry is off
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

On Tue, May 21, 2019 at 3:47 AM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> The current implementation returns 1 (PMP check success) if the address is in
> range even if the PMP entry is off. This is a bug.
>
> For example, if there is a PMP check in S-Mode which is in range, but its PMP
> entry is off, this will succeed, which it should not.
>
> The patch fixes this bug by only checking the PMP permissions if the address is
> in range and its corresponding PMP entry it not off. Otherwise, it will keep
> the ret = -1 which will be checked and handled correctly at the end of the
> function.
>
> Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index b11c4ae22f..8668f0dd7c 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -259,11 +259,12 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
>          /* fully inside */
>          const uint8_t a_field =
>              pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
> -        if ((s + e) == 2) {
> -            if (PMP_AMATCH_OFF == a_field) {
> -                return 1;
> -            }
>
> +        /*
> +         * If the PMP entry is not off and the address is in range, do the priv
> +         * check
> +         */
> +        if (((s + e) == 2) && (PMP_AMATCH_OFF != a_field)) {
>              allowed_privs = PMP_READ | PMP_WRITE | PMP_EXEC;
>              if ((env->priv != PRV_M) || pmp_is_locked(env, i)) {
>                  allowed_privs &= env->pmp_state.pmp[i].cfg_reg;
> --
> 2.17.1
>
>

