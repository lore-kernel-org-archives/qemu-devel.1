Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469CFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 04:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A192073E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 04:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVmOaDKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A192073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfcVT-00080w-CP
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 00:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jfcUN-00079A-MA; Mon, 01 Jun 2020 00:55:55 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:39881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jfcUL-00005m-NU; Mon, 01 Jun 2020 00:55:55 -0400
Received: by mail-yb1-xb41.google.com with SMTP id p123so4565554yba.6;
 Sun, 31 May 2020 21:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TL7HDmvtrq4YxgEcyXi3dU6ysRk7QJZZ4X9tIteT15g=;
 b=EVmOaDKXk48eL8r84FMTe8nMa67BYHmC1bQPnnaZHR9ab1hJy3DRx5ws6kCiT5PVhz
 yQ9MCNEiobn8QpzNL1CZ+xSaPlKi9kMz59sjlzvB5rJ7iaFwK809R4XX6B3fgL3h2es+
 x316Z125PAFriZ/JklViN6cuMdmWsWqH+tHZ7Ns3UHclHqzi4EIUX0QteHN9SOCq2qcu
 SY97mw1szwbkHomlKJjyZSTzAQJ32ctJlTNvm1eX0+rzRUMarX5YPqaXgCSbrxNHhE08
 19mr4FInQBPIzOXMgI3DhVf2rBKs3vL4i5ij1nhcmkXK9B5o4JALIZoOStmofVXAXE/w
 6vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TL7HDmvtrq4YxgEcyXi3dU6ysRk7QJZZ4X9tIteT15g=;
 b=ec+vQKJfhwZc5YPRS5ygH0vzbOk9BgzeP9OJAAJ2FtEdUSjs0E3RuYtqIzVNorvheK
 APgeTThg0Q9lEHlK8+mIO+9WI1174xySUykEdrNSZJ2ZtcEoIZ/mkRbbArB8yLoQQ3/1
 FweEFSWpfqbtr+W3ZpzljiimOBs4I+Yoa2o5eqY3EX7gX7sP8zYVudfiK/G4ZJriabY8
 EKTWb2ZDzpHyIUsYQu46m/PxAmQ85xpBU9yU98C00LKj3VX2O50+zx4aTD3oNX8H95Z8
 pIkbqvD4YWv3Cvx5X/f5Nn70/EQ1rqQfSrK/YjxhQNRtvrHvVi6kp2pxQ3cRJTCWLA7Q
 8GVQ==
X-Gm-Message-State: AOAM530aJLdArZvW/dfL56Rfwm9hnPbZ6GeoFG8X5EHnFpeo13SRYgW7
 LBe8MAgjAMEoQnbvsaI1sVyoCXPDSroNU2CWMug=
X-Google-Smtp-Source: ABdhPJxpxZTh3kAzUwDSfRaoa0FmBA/PKx9WDvrRhp+0hM8A0HuZVmBMEuqgUsN7C3CeUKZI6R829nPLx+/wS9PLZz4=
X-Received: by 2002:a25:7404:: with SMTP id p4mr28339107ybc.517.1590987352503; 
 Sun, 31 May 2020 21:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590704110.git.alistair.francis@wdc.com>
 <dec5eeaaaea2f9ea5776a3a31d41fd8ec246a06c.1590704110.git.alistair.francis@wdc.com>
In-Reply-To: <dec5eeaaaea2f9ea5776a3a31d41fd8ec246a06c.1590704110.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 1 Jun 2020 12:55:41 +0800
Message-ID: <CAEUhbmUSA7HXucPpgcqoWdeSy7T3utVzg=1_3tKbU+EdMqh8NA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] docs: deprecated: Update the -bios documentation
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 6:24 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Update the -bios deprecation documentation to describe the new
> behaviour.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  docs/system/deprecated.rst | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@windriver.com>

