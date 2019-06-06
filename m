Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4292DC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C685E20872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 19:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3tJOmjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C685E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYxuA-0001E2-Cj
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 15:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53567)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hYxlE-0004dY-LN
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 15:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hYxMn-0003nG-Jc
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:44:02 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:43708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hYxMn-0003ee-CP; Thu, 06 Jun 2019 14:44:01 -0400
Received: by mail-lf1-x143.google.com with SMTP id j29so895703lfk.10;
 Thu, 06 Jun 2019 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l2Dns/96orDoa6iQDHWoGDluZMJkCvzTInd0FDZD4v4=;
 b=N3tJOmjdmujTIgv1BX17b/yUdg335lChq4QaRWlBf3BTvjZqcSqWJnCq/91gpdcoam
 AYA8le4T1azz9rXFWSn8wT2G6J/umT0hpc3Os0deilU+4E9PVXTrm+ROLPUWw74F6A1R
 VFZ0Raeq2Fbaq2oJRicqjWu+ZU8ffkX2Dar06lLDaAdNrnAW6jaSqrGKIBkvNNjyDUal
 4EWMCXBpQslzpLCfs1H0YgsyMfwdsn3jhJMzXbiy5wY02olKDDqssjlsXbJaZ1sFcr1w
 VraN0LDTWQZm+5JzpyXDfMoOCXrj8OtjMHPvyE97cgFI+WbT/12lIYSXFWRNlP0acxn7
 Rgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l2Dns/96orDoa6iQDHWoGDluZMJkCvzTInd0FDZD4v4=;
 b=LkQ5DnYzJ/6tYng/FS6iYDWP4uSoXn7i4I6K3MJo2kQfdItc++WDVwZyUbUmaj3WDX
 ZlNcyERh1Oxu0nKIcMbIMXVBzfnzskfge9Rs1aMDYHxvq2DiBB5sDsk3wIjzFFT8X/Mj
 WZveZwZmzbgvdMyup0C+j1pn/GUuYHlOJJJuUHjXs6GUfb431toNUeeIQTfiU9DmlYsu
 UjqDzdyIytmLaw2IUsGnBE0IGO6ut4N9RcdgveakNCmMAY6UogUJk0wItPO+wbFq+uMK
 lemITtnYJ/C7BTVFY9JeDQjyqO5JoT24bIpJSwG6w/gWCyDzChK/UgLIyKckGHA7C0b2
 6lLg==
X-Gm-Message-State: APjAAAXyDQu26caIGQEzgrDE4/7TWNlsF2SlzsHltffO3PNqSTJv2GFQ
 CFeZ5aWOBvbFSshYTth0Ljci+/3XCmCpVbNeChA=
X-Google-Smtp-Source: APXvYqw9rdCLBYfvGa6++WVI/RsPQt3AzeSylSzfdPz+jgzZ7KK53inWtOq25PY9ido/7de64EPKfGREHfXodHRc+Ow=
X-Received: by 2002:a19:2b14:: with SMTP id r20mr13706519lfr.86.1559846637767; 
 Thu, 06 Jun 2019 11:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558131003.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1558131003.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Jun 2019 11:41:23 -0700
Message-ID: <CAKmqyKOZgiVXn2j6P7RJW3KKuQHLFHzrH7xkvOa8Mv340GUiUA@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v1 0/4] Miscellaneous patches from the
 RISC-V fork
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 3:12 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> This should be the last series bringing the patches from the RISC-V fork
> into mainline QEMU.
>
> Dayeol Lee (1):
>   target/riscv: Fix PMP range boundary address bug
>
> Michael Clark (3):
>   disas/riscv: Disassemble reserved compressed encodings as illegal
>   disas/riscv: Fix `rdinstreth` constraint
>   target/riscv: Implement riscv_cpu_unassigned_access

Ping!

Alistair

>
>  disas/riscv.c             | 53 ++++++++++++++++++++++++++-------------
>  target/riscv/cpu.c        |  1 +
>  target/riscv/cpu.h        |  2 ++
>  target/riscv/cpu_helper.c | 16 ++++++++++++
>  target/riscv/pmp.c        |  2 +-
>  5 files changed, 55 insertions(+), 19 deletions(-)
>
> --
> 2.21.0
>

