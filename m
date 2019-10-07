Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1AECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A69206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZ1MJaQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A69206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHXiu-0003EV-8o
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 14:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iHXhY-0002eu-LO
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iHXhX-00072I-EH
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:25:44 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:39173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iHXhX-00071b-9p
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:25:43 -0400
Received: by mail-yb1-xb42.google.com with SMTP id v37so5004816ybi.6
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cs8zxU93aD8ynvB0tt+JhMRUQ4TwR66VJedOixxINHs=;
 b=OZ1MJaQrzXMbX/Fl3hbEeR5p7XUBoFuhIce8qlMx838m2pSQ1o15VL9I2fTi2WZIar
 DnwdU+HRW2S7y8hOzMSlvXeolP/Izz/9zNtFGV6kyCUdhXbkmbEBDJRtfHpms4LnL5oV
 bq3lIU8alKSNj/N2e2PoAgfe226mQoLhHb7D7f7HByQ06/ajKAmNbPgCfG3gv/aw4u6m
 mDQ/aXA2nQXhs+pYS6ffrJrhzhvYJLFWyP82Ms4ryYdpCcdBBI4U7UWeHyjM+iDt4Iqr
 WjwgXM1sFFiteQi4d3ze7zV4Xm2+er7eWaAgrKWefD/0fKZvIZ39dHw1xsVjq5X8d0vT
 l8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cs8zxU93aD8ynvB0tt+JhMRUQ4TwR66VJedOixxINHs=;
 b=uJAJTFscHz257boRnxI4QJJC/2zN3XOSgsJ+Ea0baGSFoHw10CKRn4viVksbupN3/z
 1l3OtM1B0DgkM1oAoa+G2IIcr20LxQjf0sXXRg4N//0Lc0ZVA6kuWS7MCuPSp9DyxscF
 rZw1Ne0N9umSxk5SgzsteYZzjRCROJAPXM5cymvWgpK3p5t/tQvFWBmzoApwTH873M6W
 0eaGgthfx4wgY3PYYosGr4Dd6sERaQy+FEMorFCFCHi1PDuAs9J62LNA7xJu06a5jKm+
 pwdzlF99O1MN310f1O2IkNgqQbbzPh2l36HBgNdTZgcOvhX+PhiIubzsQBXQLEhQfuBy
 sw9g==
X-Gm-Message-State: APjAAAUxsApgqo1U/mjSJaluRstbepEBCyaxZ7eoyfLVWwmxRTJ8Ptcf
 aoOVmkoYO6fXi3QF+DX4X6Ug5g==
X-Google-Smtp-Source: APXvYqw7M4zeGpw+lqQPcGr0FVjgCOq+k7o0m8G4S4ptUI3KHcoq7plIlTTnuob53XnM9x04cO805Q==
X-Received: by 2002:a25:b7c8:: with SMTP id u8mr12240390ybj.212.1570472742310; 
 Mon, 07 Oct 2019 11:25:42 -0700 (PDT)
Received: from [192.168.1.44] (67.216.144.16.pool.hargray.net. [67.216.144.16])
 by smtp.gmail.com with ESMTPSA id a130sm4075650ywc.81.2019.10.07.11.25.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Oct 2019 11:25:41 -0700 (PDT)
Subject: Re: [PATCH] target/riscv: PMP violation due to wrong size parameter
To: Dayeol Lee <dayeol@berkeley.edu>
References: <20191007052813.25814-1-dayeol@berkeley.edu>
 <5583387c-5c5b-8890-999b-2ba4d75cd69d@linaro.org>
 <CACjxMEsw+Deh176JLP2aF4Pdkb_s8MiPApwMON-_K6ed61-Zyw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3747223d-23ee-1f28-e165-b2b0c5746b68@linaro.org>
Date: Mon, 7 Oct 2019 14:25:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACjxMEsw+Deh176JLP2aF4Pdkb_s8MiPApwMON-_K6ed61-Zyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 10:19 AM, Dayeol Lee wrote:
> Thank you very much for the clarification!
> 
> I found tlb_set_page with size != TARGET_PAGE_SIZE makes the translation way
> too slow; the Linux doesn't seem to boot.

To clarify, PMP specifies a range.  That range has only two end points.
Therefore, a maximum of 2 pages may be affected by a mis-aligned PMP boundary.

It sounds like you're getting size != TARGET_PAGE_SIZE for all pages.


r~

