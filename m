Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1CBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B1F206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlnBWd6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B1F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jClWh-00061M-6b
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jClTJ-0000CE-4w
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1jClTI-0006B4-3O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:39:32 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1jClTH-00067m-U1; Fri, 13 Mar 2020 10:39:32 -0400
Received: by mail-qk1-x744.google.com with SMTP id m2so12814821qka.7;
 Fri, 13 Mar 2020 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=44w/yXzypDOsT7HO0jyj2OMeDtD4ttnIYtGEriwFSuc=;
 b=TlnBWd6FmTE86knBjLg7vroxAjkmzetACv+SXTozHvzgA2lf92b5HKu/a8/0omz/KC
 c0d/+zXe67Arp13XN/SoM1cnmPHp+5uqciTehNt5HPJGsI0f8vbG9jxeghvvH1c2747l
 5+G4aanf99K/H1RKokzro5FJw95HefjOJTEGgNlcStX1owEns63jTsYxpfRwpoO+1A9U
 FQNIiAoh/19fi3CRrPXAJxKakjtw7WRUFIyz+lCDaXnSLvg/9+XkV+XZr5k/hvtyGb0L
 BdE175lRLkqwUol9xC9iIbI8B/LFVE4se9pf2/FUt3bsmelcELxqLfy/6/wTshW8TJ9d
 0edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=44w/yXzypDOsT7HO0jyj2OMeDtD4ttnIYtGEriwFSuc=;
 b=LseWe5gQTcGjSl88mG85B3SDdce05Ve+KZx7+NZLkqiWBYxOWCERo/hX+KPL1mkEsk
 9UTCQF21RyY10EfaRcPIeRd4MCw0M7p2tilSaziE014nn4hFWPYwAcKJQxtK8/aGaXdx
 ZxlfRmDZD+FGJ/rKT6GpoZJptd4EM7f1zUpFs6gYbgFlZDQMO56sqRkdqIagMcbD4hod
 qeayHadiqW/Wj/XCIPAq+xf23DDqzx7YnWB9JgpIJEsWa44DiDjdI8PXHiMWGwkEgKQL
 bltBAEDMO1v1LG4IhvQ8f8S3Iyr8Bj0duAmmFxCO1VmUaalv8f6kb8KN4QWe1NJDli4n
 65nA==
X-Gm-Message-State: ANhLgQ1KqR6iwWwvepxfQZr80c5vtQ4qc+1JfqsPZnuznSYQJAZt1vmS
 0zSf4isL2IHRfHDayNk/8LosGHb+OGolgz8TTsw=
X-Google-Smtp-Source: ADFU+vtsj11dQDDpuIXzfmmG+DxL1oS6r1O5lhlqPfZUWlf87RTNuXSKLcb4nUhSlvFyemveYds4NOxTdw21QSY5Z/0=
X-Received: by 2002:a25:84c6:: with SMTP id x6mr5471940ybm.56.1584110370891;
 Fri, 13 Mar 2020 07:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200313005508.1906-1-coreyw7@fb.com>
 <20200313005508.1906-2-coreyw7@fb.com>
In-Reply-To: <20200313005508.1906-2-coreyw7@fb.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 13 Mar 2020 22:39:20 +0800
Message-ID: <CAEUhbmVP__C6F8J+c0pcjcqCCp-q1waO=Kgr6k+QAd+3HLnj+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: sifive_e: Support changing CPU type
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 8:57 AM Corey Wharton <coreyw7@fb.com> wrote:
>
> Allows the CPU to be changed from the default via the -cpu command
> line option.
>
> Signed-off-by: Corey Wharton <coreyw7@fb.com>
> ---
>  hw/riscv/sifive_e.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

