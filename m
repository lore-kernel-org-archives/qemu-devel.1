Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773CC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DA2216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbgxvN+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DA2216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42607 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqKQ-0000YJ-HD
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:00:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqIx-0008Kl-UA
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqIw-0003CE-U3
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:58:47 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hSqIt-00039z-Ai; Mon, 20 May 2019 17:58:43 -0400
Received: by mail-lf1-x142.google.com with SMTP id y19so11465315lfy.5;
	Mon, 20 May 2019 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=xQ8wxtVVJrqxmhNhATxeh1iXb26yhkLabtGZ1tf0t8A=;
	b=NbgxvN+1+eKqibj8uQ88rZyvfTh4r2IbScwWDA8iNLomYAVFMSjvlnvLOvQeTk9me4
	Xph3BMmAECd61PdTLUmTr/jurZh5DIJ75kjYmnKfV+hTo2wC7nBi+cn1L5y4e3yYmz/l
	FYSLm/XugM4xGHVeidoYC6c1Jwt/3IBlRlz1B+zO4OLckSmnmyK2ShDKwoBQ+tqMaJ7L
	gJiUzpYfJqMW3fFbbPEASMTeeAyWbVi/2xSdWGFzzyPuzUSKZF0TGG2I4VpIzTo+TkVZ
	ZGYdwb47tYFzO9lrF+FVr2zu3dwnt1zpX1Mvi0L6X1rIsuPYa1GosPMR81zf8B64N91U
	nUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xQ8wxtVVJrqxmhNhATxeh1iXb26yhkLabtGZ1tf0t8A=;
	b=JPHcLgRyqc+bZVd6NNUifuUIerD+1Ovv/fYFDWWlMag8zfWdYHUNmnJzKJabgdVe0p
	lh5/Gu2KrLq156SwyM6XMrrlLC/u5YlI8yh/iXIXIG6cITZ9/bF9vBRksdnnRwtF3lJp
	vOJyvPLSzhWaB43+As0hDVd7Hra3GXcqhSzNHgF40DCKOV77R13N4+39aV7i6udBoM6Z
	6LTPSZ5gN5pp+R4mB4arIwNPCkJlMgSR+SDWNStTwROH7ymX0sB5A/3YgxCt8fXZ2Rs/
	1CzQmELzVnHA5tbwSy5vGWucY1vFQjKgP/Alfm8vy2sHn1LcawiKPMJUXNEtWZrUQD5/
	2bJQ==
X-Gm-Message-State: APjAAAWK3TZ9sVzWze27NOTj+Ywu+BUxWpCiuvmSzWiEHOZnXti3d4yj
	w2M3tvLxFt0LO7CnExSOSFNWN+G1F2BOSHwcTRs=
X-Google-Smtp-Source: APXvYqyt6qWLhfRpN3+5Bab1f6Cn4XExEZKxlKxKlgYW0Y0bxNQ5N7ET/uyfu6p2kKqodQam+SOu5pnFAsZMNPnT83w=
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr38971010lfa.25.1558389521513;
	Mon, 20 May 2019 14:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190518232502.5201-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190518232502.5201-2-Hesham.Almatary@cl.cam.ac.uk>
In-Reply-To: <20190518232502.5201-2-Hesham.Almatary@cl.cam.ac.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 May 2019 14:56:25 -0700
Message-ID: <CAKmqyKNa0QSudOZUmo+=0=7sz9PZ+kd_uF3noFZn6owQYvtgwg@mail.gmail.com>
To: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCHv2 2/3] RISC-V: Only Check PMP if MMU
 translation succeeds
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

On Sat, May 18, 2019 at 6:36 PM Hesham Almatary
<Hesham.Almatary@cl.cam.ac.uk> wrote:
>
> The current implementation unnecessarily checks for PMP even if MMU translation
> failed. This may trigger a wrong PMP access exception instead of
> a page exception.
>
> For example, the very first instruction fetched after the first satp write in
> S-Mode will trigger a PMP access fault instead of an instruction fetch page
> fault.
>
> This patch prioritises MMU exceptions over PMP exceptions and only checks for
> PMP if MMU translation succeeds.
>
> Signed-off-by: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>

This should come before patch 1 otherwise we will introduce a regression.

Alistair

> ---
>  target/riscv/cpu_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index b48de36114..7c7282c680 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -403,6 +403,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                    " prot %d\n", __func__, address, ret, pa, prot);
>
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> +        (ret == TRANSLATE_SUCCESS) &&
>          !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_type)) {
>          pmp_violation = true;
>          ret = TRANSLATE_FAIL;
> --
> 2.17.1
>
>

