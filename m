Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C02CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211A22086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3LiAsQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211A22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMens-0005o4-Ak
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 17:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMemP-0004q9-F9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMemO-0006jg-83
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:59:53 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:36542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMemN-0006iv-Us; Mon, 21 Oct 2019 16:59:52 -0400
Received: by mail-lj1-x244.google.com with SMTP id v24so14851374ljj.3;
 Mon, 21 Oct 2019 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IRfRBhOJ4tK/eyaHwLIDarS0P0zdVadV9K948uMtz8s=;
 b=Z3LiAsQs+IjfGkUKDDbF1Eh8jAjin6+rbCAjr13gMH1+O4756chEphzWBHW9KhkTtg
 Vfy4zZyDaC9qftuuzmvNtKt2WE8Em1b8pbfBpqfrLM7dth2Aoe90Q3RRB7zMUP1Ut/Od
 1WH7lO5CsnMBEaA6wN6y4VsmP6vpShbUVWx0zPP55QBigdf6Xsgo+wCNSNUfjGxpbaXi
 TQLnni6KVPzDgcRQQj23rZbgPKUsI7OFOrlngOmPjBYdwoK5jV+/GSAkQIMjuM89n/w4
 Ei0OlHSptGIj8vdcHSujJryJ8JjnsHUcGw6gQBlSS5Up6POKEeWfAkwemZgCkhFBhSvx
 +4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IRfRBhOJ4tK/eyaHwLIDarS0P0zdVadV9K948uMtz8s=;
 b=MB9m3aaTlgcaWuOeGxrdfnC5xMZHa3JykpRrBXe+TJRtNAHTlGuAGngSp99jicTZQo
 WqQxvPBcMstDJQKNkOCIDY91XYCTtDRg3fTPHMVsPJ11dRSBlZy2hQwy7Km09+TD114C
 4xdsN5343LyxmuO4hdm7jk4B4E5k1r2Iq5d0LUpfm4OepEfOkrlQy8CXd9giA/R1bof4
 OmhYZNrbtokPLfVvuPSIE/ZAq51kAq93zYFIVgahzPFt2OmBpvK/vzB8yPC+T2w9T1sq
 tl1qq7f2wWWnFHufNOOzhp6SDWCcnzGuqcu55W/p4zbgqBw7/D3KXN7iWNTtdJDrqzGI
 oYsQ==
X-Gm-Message-State: APjAAAVnGdLZNOoqsC5RU9xCZf3gtOesCF9hdHGRLYiUh+GGQlheTRbW
 Z9USg7NOEIEJkzypLgQKz6fAxPlLtgzHSxhfiB0=
X-Google-Smtp-Source: APXvYqzCsBN2hgXsSagcEg7xuOuPSWgFcZItyVs84/ugaZX9X+dVHN4bfw1ifOXY6SWgD1xysyceg6Ckd6dmomQzKYI=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr16221475ljk.152.1571691590645; 
 Mon, 21 Oct 2019 13:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191021190653.9511-1-philmd@redhat.com>
In-Reply-To: <20191021190653.9511-1-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:54:35 -0700
Message-ID: <CAKmqyKO7HrqwTkXVadKikT_+2e2BfW2uevQV0UFm0_ZYnZfCLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/arm: Create the RAM in the board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 12:07 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Peter,
>
> This series contains the ARM patches extracted from the
> "Let the machine be the owner of the system memory" series [1]
> reviewed by Richard.
>
> These are cleanups moving the creation of the system ram at
> the board level. The other series will enforce
> memory_region_allocate_system_memory() get called with a
> MachineState argument, this preliminary cleanup is required.

For the whole series:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> Regard,
>
> Phil.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg05085.html
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
>   hw/arm/mps2: Use the IEC binary prefix definitions
>   hw/arm/collie: Create the RAM in the board
>   hw/arm/omap2: Create the RAM in the board
>   hw/arm/omap1: Create the RAM in the board
>   hw/arm/digic4: Inline digic4_board_setup_ram() function
>
>  hw/arm/collie.c       |  8 ++++++--
>  hw/arm/digic_boards.c |  9 ++-------
>  hw/arm/mps2-tz.c      |  3 ++-
>  hw/arm/mps2.c         |  3 ++-
>  hw/arm/nseries.c      | 10 +++++++---
>  hw/arm/omap1.c        | 12 +++++-------
>  hw/arm/omap2.c        | 13 +++++--------
>  hw/arm/omap_sx1.c     |  8 ++++++--
>  hw/arm/palm.c         |  8 ++++++--
>  hw/arm/strongarm.c    |  7 +------
>  hw/arm/strongarm.h    |  4 +---
>  hw/arm/xilinx_zynq.c  |  3 ++-
>  include/hw/arm/omap.h | 10 +++-------
>  13 files changed, 48 insertions(+), 50 deletions(-)
>
> --
> 2.21.0
>
>

