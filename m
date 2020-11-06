Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE0C388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD7B20782
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBWfcflW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD7B20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasEQ-00023o-40
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kasDr-0001a6-SR; Thu, 05 Nov 2020 22:15:31 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:43964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kasDq-0005Cx-CZ; Thu, 05 Nov 2020 22:15:31 -0500
Received: by mail-yb1-xb43.google.com with SMTP id c18so3235460ybj.10;
 Thu, 05 Nov 2020 19:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qlljcZKY+KxkaVt1CJZ06F8wd4HPhUA50rW0KtwfmE4=;
 b=ZBWfcflW4wx4Gz1xj0xz+O9Kq+tFinGtsEL/6ckRiBRdMFUFGAYcC5HzwQqS8uVwCr
 3djgriaWJH6ISKiE0Fm8EJUSUqpN2Y9awLCV8M3QE78YnmBaDXQbZ/KVhEFcvMc3dWwu
 Yu/aI7wlT8QZVPTxObz+CufLl/G42SwG1JkJXuGtZsneTWY5dHmpCB/GOAVuYxopihkJ
 2z79IxqPgs85zweK7KUusRbQ7dN/zRbtMcn3F6BPryWZKnoP2fODO1aNrl4n4QnhyZyd
 Xz8NRUppiepzqxKydx+NrsVJ+bBpk8vEucOGNxDBKwAn098iptxcWIBNlNNlg5saAm6Y
 Vrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qlljcZKY+KxkaVt1CJZ06F8wd4HPhUA50rW0KtwfmE4=;
 b=gNhw3XIYBo/daBwl0XTrKiabr7GxMwx6Y6Z24Fi7qQxzU/3eg22eGVcrfsrbe5g6oS
 Zu7HKD7QQbZA5Iv7xPkWJcJpeh/rWz0T6DBvIxp8wUorN/f/IiQUVdGd44DVTNQDAfmy
 C9fD5vGvfLyyOHvztPRhgVOHkWfGYL4zDbc+VAc7lVxqYwXt801jbCQrciFcLotZ7pJu
 zwnOF1fpN6EzE/5PTK993+S2ewSl0084l/E3AThx6Nzhf/o+zKaQiVRDjugJZguBnKbq
 oqcsWwJVZtYwoerDDUKPPBmWYuYxRiFN7+sd8yQWri6+p8Sk63Zm1FNH3gxhFKVlRqt8
 4tzQ==
X-Gm-Message-State: AOAM533HskldqfGpJTutt5vwnOCx3dr/ryCe5XTL3Bk1Un1Dj6crmWz9
 pFAKl4y8t2kqkesolx31pJhMZ6iUJtDfoZz6cFM=
X-Google-Smtp-Source: ABdhPJxuLmc01jtF1fNoFKobPIOqQlyrjuHbbH2VyMHGKWOMaCNyw7FDkqeZYjnEQ8mR95viDdmX3Lsri6fumn9s8c0=
X-Received: by 2002:a05:6902:513:: with SMTP id
 x19mr142432ybs.239.1604632528798; 
 Thu, 05 Nov 2020 19:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20201105175153.30489-1-alex.bennee@linaro.org>
 <20201105175153.30489-3-alex.bennee@linaro.org>
In-Reply-To: <20201105175153.30489-3-alex.bennee@linaro.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 6 Nov 2020 11:15:17 +0800
Message-ID: <CAEUhbmUkwq318FW=8cTuU1fcPk8U46EEUr5f6P9QJTdonNZHJA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/15] hw/riscv: migrate fdt field to generic
 MachineState
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: julien@xen.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 masami.hiramatsu@linaro.org, Andre Przywara <andre.przywara@arm.com>,
 stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, stefano.stabellini@xilinx.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 6, 2020 at 1:57 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> This is a mechanical change to make the fdt available through
> MachineState.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20201021170842.25762-3-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  include/hw/riscv/virt.h |  1 -
>  hw/riscv/virt.c         | 20 ++++++++++----------
>  2 files changed, 10 insertions(+), 11 deletions(-)

What about the 'sifive_u' and 'spike' machines?

Regards,
Bin

