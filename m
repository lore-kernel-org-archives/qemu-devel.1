Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76593C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58104221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqRHqMnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58104221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3msQ-0002E5-Do
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3mrV-0001LJ-R9
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 16:51:41 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:38477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3mrT-0000Oi-Vh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 16:51:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id u63so32386779oie.5
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VFfLcUywvhMOwjxJCzG7WLa88JSSWiz11z5XZUxs0Hw=;
 b=XqRHqMnwFrSp/M4AElmtM5sppnLgi3jKVXQTqqkIa2vzVznzN1XA5jZE1ONVfmocMi
 zXDfcg69Znk8gyLKOJtguBEEOy8lj5vhNHxFFWkT7CBBl33kCalSZkWpJrOlOAVM1Yt7
 2EwKVCkvWNaZZTcdYiMtHyMojZ+QgolBPxM517RNEhSgTK+F7vLrZi2AErSiIMePrttd
 atQch/Kd2uDfwQbNI9lkTdBqmZcVCQa1taM+ei71Lmc03JdcWu7LMtZpDSHQT/O7N/si
 9MnzWsFnGRkIgM0hTAfaMwBXuCv9NW3fqfh+17QwWbPNNxIZlqMi170Mfnxc0zVslKZt
 S14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VFfLcUywvhMOwjxJCzG7WLa88JSSWiz11z5XZUxs0Hw=;
 b=XKVgY861EiKY7oPgOsJWMd+Ri8hpB6YVrZrr9Ph/Tf0bfN4aJ9uRRMiGqy8fGz2pcO
 TYlbd2XqRYksphfxYzx+1c0Ab3WCMZt82XOXcE0K4KUe3cIdgl2sUy8oYAxAt73K3sQl
 8AImMUAkP+MzBzoabKwClQqDZeknti6XPLrTch5ZoFynX0rfDA/SsdGUPGw/r76yV5ws
 jGRk80FaQKd7aptYj6nBpqZYxmm+cBbkxVuTZKrwWnz1UGwMN59DWTxV3WT6IS8I5t9X
 dq3v71fsk2kf0+sx6gpLjiB2FO6L7OPmui0UCAAAGwSp+JoAcIiXbuBHwLrTUYzCAImc
 8qgQ==
X-Gm-Message-State: AOAM532j89w6YiGeeLASMBhrRqXvSrcuocuPf+jSmZGNHP6XUmM94/7S
 9cASZfguq2d0EJxbL44t5hOKBva4UjZFh/MlMzamBw==
X-Google-Smtp-Source: ABdhPJzgRChyya9RbKUPto/4+cQzBoEmSiSl4SQ1mid7IGP1oES5mXD2KWFby3JO2R7omJEwGei8LLZQvOe1FLW0Xgg=
X-Received: by 2002:aca:5703:: with SMTP id l3mr8144088oib.48.1596747098254;
 Thu, 06 Aug 2020 13:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200806122612.17167-1-f4bug@amsat.org>
 <e55da0ff-e88c-f2f4-0430-32255f7e58fe@flygoat.com>
 <ec0ff553-a5e7-6c93-5ab3-093721b044a6@amsat.org>
In-Reply-To: <ec0ff553-a5e7-6c93-5ab3-093721b044a6@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 21:51:27 +0100
Message-ID: <CAFEAcA8iXXW=eD+w-UdPqdjtbfc45Qu+DyfZBmaVe0TgMt_jmg@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] target/mips: Report unimplemented cache()
 operations
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 21:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 8/6/20 8:01 PM, Jiaxun Yang wrote:
> > =E5=9C=A8 2020/8/6 =E4=B8=8B=E5=8D=888:26, Philippe Mathieu-Daud=C3=A9 =
=E5=86=99=E9=81=93:
> >> We only implement the Index[Store/Load]Tag from the 'cache' opcode.
> >> Instead of ignoring the other cache operations, report them as
> >> unimplemented.
> >
> > Hmm, I don't think we have anything to do with Invalidate/Writeback etc=
.
> > opcodes
> > in QEMU. Why do we log this?
>
> I'm noticed this code is run on Linux 3.3.8 (4KEc):
>
>     8880:       3082000f        andi    v0,a0,0xf
>     8884:       10800008        beqz    a0,88a8
>     8888:       00a21021        addu    v0,a1,v0
>     888c:       08002227        j       889c
>     8890:       00001821        move    v1,zero
>     8894:       bcf90000        cache   0x19,0(a3)
>     8898:       24630010        addiu   v1,v1,16
>     889c:       0062302b        sltu    a2,v1,v0
>     88a0:       14c0fffc        bnez    a2,8894
>     88a4:       00833821        addu    a3,a0,v1
>     88a8:       03e00008        jr      ra
>     88ac:       00000000        nop
>
> Why silently ignore the opcode is not implemented instead of logging it?

I think the question is whether the opcode is supposed to have
some behaviour which we're not implementing, or whether "no-op"
is the correct behaviour for it (which it usually is for
cache invalidate type operations; compare the way the Arm
cache ops like IC_IALLU are just ARM_CP_NOP ops).

thanks
-- PMM

