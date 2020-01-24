Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FCC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C02F20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+aSn5tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C02F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3nD-0002U4-KT
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv3m1-0001XG-8Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv3lz-0005KF-Ri
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:33:41 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:39748)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv3lz-0005K7-La
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:33:39 -0500
Received: by mail-ot1-x32f.google.com with SMTP id 77so2548211oty.6
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qUJqCJLznYWcv0xdV/AUVdZO3ixQ+ez9m9P4RuGOSkU=;
 b=v+aSn5ttp/KjGhWe7w3LJOsjsaWd1TZAZ2IiKv0XnzKkQX6pR5Vg/DYOqe4KFJZXyh
 xmrzqidNdyFOMK1MWHnt5Wmx17KTWhXlKB2VzXzrK8yfn0lMOyXpOO40U53iV4oZrD0b
 ta9Tk6CsQ66qhzZ4RGSD5NMsVxB7YXqnZtsdOvZNdeLh9+uBmWohNjmEVQ/z3V+Ia5Og
 JrKqC7Dpg++tWxz6HRKlyA+CvyTS+EAw14mwE0WLuxb8YJEiOtLjnJoxrYO8d5vPNZLe
 G6mfo49RkoqkHxlvNivTuyrZazhx4828Zg+95P0YBUmdq7uAarSFRxWH01uMc6Rwxj0B
 HeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qUJqCJLznYWcv0xdV/AUVdZO3ixQ+ez9m9P4RuGOSkU=;
 b=Pay9BDDBe/EsPcUyyJc1YfytOOPu2QMqGMnlYHkrQt1Dnpi7KRNAUXH2E3xRQV2Yc5
 da57qKs9EMT7O6fe9fGCsA3gLmwq0kwbMdGQ9K3t17XFCXSYwHDU9FRIyEw7m9eXvt9Q
 s9qqK843Lb4VzzBMN9LPxckHMoN7AXOqmtTypODmITgwKBHS82Jk03EBG6AQZey0SYkR
 kUghCYrLzDt4LqAQIlbYz0KyA+bUFL5GBEsl1nywEao4Cwi+pz8npmZNF7eP57vxIaAF
 UIse6I6DrMLoaNvZmiixU42kCjhfbG9yMRyNzqnTw3Mj+EN3c1dYKN6xJMLR2XGPYKyD
 8eBA==
X-Gm-Message-State: APjAAAVe7rRxn4kXPVXOVSIWPY8gOz+NWzLQjQJJaH5LOecHXttPHsXF
 g4UaY4OHzPHr3v1Cj+fMc/nFRc34K8UcEfOpSVmBjA==
X-Google-Smtp-Source: APXvYqzaHGyLJDUOCcmqU/T78NEXIsl8C6tGPbjWDOuo8WPOtYAQFX9fmMuhzgAmrheTu+gvPoMEHGn+PHCCduT3yBk=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr3507552otq.97.1579890818516; 
 Fri, 24 Jan 2020 10:33:38 -0800 (PST)
MIME-Version: 1.0
References: <1579889269-8122-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1579889269-8122-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 18:33:27 +0000
Message-ID: <CAFEAcA96divoYVZcxeWVNPNHh8+0Px69Q+PuTc6j8HJ+6-XhKQ@mail.gmail.com>
Subject: Re: [PULL v2 0/7] MIPS queue for Jan 24th, 2020
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 at 18:07, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit ba2ed84fe6a78f64b2da441750fc6e925d9410=
6a:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-5.0-=
sf1' into staging (2020-01-24 12:34:04 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jan-24-2020
>
> for you to fetch changes up to 6e128a2e792b316281f6f1409fe9ffaf522a5a38:
>
>   mips/mips_r4k: use memdev for RAM (2020-01-24 19:01:19 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for Jan 24th, 2020
>
>   History:
>
>     - v2: Inserted one missing "Signed-off-by:"
>
>   Content:
>
>     - correct a detail on r4k deprecation
>     - style cleanup in helper_do_semihosting()
>     - improving passing data to disassembler
>     - refactoring of memdev usage for RAM for four MIPS machines
>

Hi; this fails to compile for me:

/home/petmay01/linaro/qemu-for-merges/hw/mips/mips_r4k.c: In function
=E2=80=98mips_r4k_init=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/mips/mips_r4k.c:209:62:
error: =E2=80=98MachineState {aka struct MachineState}=E2=80=99 has no memb=
er named
=E2=80=98ram=E2=80=99
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
                                                              ^~
/home/petmay01/linaro/qemu-for-merges/hw/mips/mips_r4k.c: In function
=E2=80=98mips_machine_init=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/hw/mips/mips_r4k.c:315:9: error:
=E2=80=98MachineClass {aka struct MachineClass}=E2=80=99 has no member name=
d
=E2=80=98default_ram_id=E2=80=99; did you mean =E2=80=98default_ram_size=E2=
=80=99?
     mc->default_ram_id =3D "mips_r4k.ram";
         ^~~~~~~~~~~~~~
         default_ram_size
/home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
'hw/mips/mips_r4k.o' failed

(similar sorts of errors for mips_malta and mips_mipssim)

I don't think the patches from Igor are suitable for cherry-picking
into your tree, because they depend on earlier patches from the
start of his series which haven't yet gone into master.

thanks
-- PMM

