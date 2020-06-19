Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6688EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3606B20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCQU2nmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3606B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJMS-0008E0-Df
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmJLn-0007mu-8k
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:54:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmJLl-0007pA-H7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:54:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so8877467wmh.4
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=P9dylHCe/x2tIYoGliS2ZBGteoBfHO1SHY6/KrFan38=;
 b=NCQU2nmH5JyZzkFb5axJrkl/cPKK1KBcWPWmaueoLQghdi7t2BGSWpKFpoXi+MmS7g
 28xhgWwolINKHVOCcs8RwPNj2IFiwT+KsPIUoftRli/lWqrZ74WgQlBXXm28dLM2Ekx6
 FQlBIUZXpqQ8EwXoxx7jB7Kgv/uLh4pF4Y1bTlJ3aaWNScADnSOShBkf7iD1ZvG/XJrU
 uNY/exiQx4/ur4aMJ2x6GS6S+BcSrDWOshHjht1onGhkZHyEe5iPFEymhwrKBVoRUMDS
 AKoSUDyaUjEJEuMiFgcQcfR02x9bjZm5G09TgHeYot9hyllhhF76iKbur2WJCVGV0iW1
 9YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=P9dylHCe/x2tIYoGliS2ZBGteoBfHO1SHY6/KrFan38=;
 b=S3iUm73DJ1+NhUQnXQIJgMBzDDd++feKs2cSfmGAld9b7hOHpg34hiXQ8BLP+4nKGR
 tmhhZxqqOEUzlHh8/qWrV8JvyY/zTzlzLzTjMepAUBuu71fNkWPw5NQX1uJi2DFfV2qD
 XF/7knxt9Ti+h9B10k99rZP/eE8dgRaMv/DKdYW/ux+yTBO8c58Vuhn41Kg6VUBj62FX
 lulryY9tROp9haKeWAMzi/57jHIpS1dr215SWZRNzMa+ie4v2+xNK6OkN8RNLFAylmPQ
 l9zspbtyXuwFuhLu3AEFm9t3eYP1qrfBQWhK0VCSBIcmUSR9U2t5wO3MW6awXS6Y+RCE
 6SVg==
X-Gm-Message-State: AOAM532HoZcH9qsDXnXzK9ywYxJS+J5tBYxXJzUHNsGIXzxSe3iHzRDJ
 xVylInliz0giKd2XPNZDrAs7rA==
X-Google-Smtp-Source: ABdhPJyKhHAq1QtLmsx98ZDpYHlAYzkFVq5mZm/dzO928Jj/a4G02zstOEhHxj/0OrDfhQ+y6S1SZA==
X-Received: by 2002:a1c:2901:: with SMTP id p1mr4568535wmp.144.1592582079746; 
 Fri, 19 Jun 2020 08:54:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c5sm7096296wmb.24.2020.06.19.08.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 08:54:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C451D1FF7E;
 Fri, 19 Jun 2020 16:54:37 +0100 (BST)
References: <20200619135844.23307-1-alex.bennee@linaro.org>
 <CAFEAcA-KX-2zjktg9A8dPdo6RkxtafM7YnahKaP=uftCO-7=GQ@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH] docs/devel: add some notes on tcg-icount for
 developers
In-reply-to: <CAFEAcA-KX-2zjktg9A8dPdo6RkxtafM7YnahKaP=uftCO-7=GQ@mail.gmail.com>
Date: Fri, 19 Jun 2020 16:54:37 +0100
Message-ID: <878sgjuk3m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 19 Jun 2020 at 14:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This attempts to bring together my understanding of the requirements
>> for icount behaviour into one reference document for our developer
>> notes. It currently make one piece of conjecture which I think is true
>> that we don't need gen_io_start/end statements for non-MMIO related
>> I/O operations.
>
>> +Other I/O operations
>> +--------------------
>> +
>> +MMIO isn't the only type of operation for which we might need a
>> +correct and accurate clock. IO port instructions and accesses to
>> +system registers are the common examples here. For the clock to be
>> +accurate you end a translation block on these instructions.
>> +
>> +.. warning:: (CONJECTURE) instructions that won't get trapped in the
>> +             io_read/writex shouldn't need gen_io_start/end blocks
>> +             around them.
>
> I think this is backwards -- instructions where icount is handled
> by io_readx/io_writex are the ones that don't need to be marked
> with gen_io_start. It's the i/o instructions that don't go through
> io_readx/io_writex that need gen_io_start.

There are two types of MMIO accesses we generate:

 - normal loads/stores which if they end up accessing I/O ports
   eventually trap in io_read/writex where as they haven't been marked
   with can_do_io (via gen_io_start()) will trigger a recompile and
   exit.

 - loads and stores emitted while CF_LAST_IO && icount is in effect
   (from the above recompile) where they should be the last instruction
   in the block so the icount is correct when the do whatever they do.

What I've missed is the one other place where cpu->can_do_io is checked
which is when we read cpu_get_icount_raw_locked. In this case it is
effectively an assert that we have marked the instruction as potentially
accessing icount - although not that the gen_io_start/end was actually on
the last instruction of the block.

--=20
Alex Benn=C3=A9e

