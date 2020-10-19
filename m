Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED3CC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:00:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8785E20885
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwwcwMrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785E20885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUVi6-0007IS-B7
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kUVgH-0006LR-Eb; Mon, 19 Oct 2020 09:58:33 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:44056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kUVgD-0000t2-8j; Mon, 19 Oct 2020 09:58:33 -0400
Received: by mail-io1-xd36.google.com with SMTP id b8so12985234ioh.11;
 Mon, 19 Oct 2020 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EG00pFMip1wlIwK0vHBf77BiKrODKzPr2RqoxN1+ScM=;
 b=KwwcwMrdxppgnsOSBSNDy3V1LwtwSXV3lI6jS2sxGdgMNH9ItIuo1M964NKH5OLmkX
 r3s++/q5BSmZsBEyt6UrZKHOrFrTNvL1aHymMVa4bNhUGj8JLmBnli6bLKAkwvZr9xcl
 mxGDeJKZQ6QhhFzE1cVbf2mjdWaL3T0mwUj0b3ktqzaKi/hAgOQHTxz/Us3lAkhwohHu
 kKgzHorYc3fJktIYHN0AREcVPdigXVfIScprzbSZoV3HK78r+eQQH/rhTS7A8gYqZO++
 L70M2v9X0tXGbc1YbUVZB6Qdj+mmp6e6E94OPrflWKq7vciF63KashEIKoY7yUU6BZn1
 cGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EG00pFMip1wlIwK0vHBf77BiKrODKzPr2RqoxN1+ScM=;
 b=omF+Cex0ZGY3izBc+hdbMcbIvxcTJeUS21HqACdfiezJZ0xJ9cjLox7/YTQU41cHRC
 TIFYXwXUVWQ+r+RSESNDJMaCQB666saz/026oKTHa1eDYGbjDUlVNSLwdrUIUkd88Qnq
 jNXQlhqp9GOnR8nSnlHgOwnML9jltr7hCAx9VnbvMzKInWeh7TskBNo86aqr52kiJrff
 g1iyGk9oo37GXcy6Dklrxq3jZkKk50mpng7ggZVaA2xw1Zopwozh9Fs7WuW74i4hV6/E
 95gfx/FcC/U1KtyNwPR5aFVKIdyyIMWFFc65sa1+j01pPyPieiiBHJjACUglG095NIM7
 dNxA==
X-Gm-Message-State: AOAM532ZxFjcxE9Ro8ngAgjLuljZrzbj4lhaaLOKLKtC4UK+YTdpsQQV
 4gD6Xr4NUxaSGwruF7pRg4+Lv0YfVoXBxd9Gs48=
X-Google-Smtp-Source: ABdhPJyxG965hBjmNKlAVl7TQi/i0hJHzCFyAssJ1gFacHb9spRw62CcMXGUTbNz2apaIhmqYA3k2qhoEPli6yE5Guo=
X-Received: by 2002:a6b:f30a:: with SMTP id m10mr10456696ioh.164.1603115907441; 
 Mon, 19 Oct 2020 06:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201016145346.27167-1-chetan4windows@gmail.com>
 <20201019061126.3102-1-chetan4windows@gmail.com>
 <20201019104336.GI236912@redhat.com>
In-Reply-To: <20201019104336.GI236912@redhat.com>
From: Chetan <chetan4windows@gmail.com>
Date: Mon, 19 Oct 2020 19:28:11 +0530
Message-ID: <CAPPKfOF=0REFGD6jOdO9LVeYcqbSWLWet9mTKBrqOjLWPDVjgA@mail.gmail.com>
Subject: Re: [PATCH 8/30] powerpc tcg: Fix Lesser GPL version number
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000326b1905b20682c2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=chetan4windows@gmail.com; helo=mail-io1-xd36.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000326b1905b20682c2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 19, 2020 at 4:13 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

>This subject line says 8/30, but I've never received patches
>9->30, and I don't see them in the mailing list archive
>either...

I'm working on the rest of the patches and will be pushing them before the
end of this week.
Please let me know if it's not the right way and if I should send the
remaining patches in one go.

Regards,
Chetan P.

On Mon, Oct 19, 2020 at 4:13 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> This subject line says 8/30, but I've never received patches
> 9->30, and I don't see them in the mailing list archive
> either...
>
> On Mon, Oct 19, 2020 at 06:11:26AM +0000, Chetan Pant wrote:
> > There is no "version 2" of the "Lesser" General Public License.
> > It is either "GPL version 2.0" or "Lesser GPL version 2.1".
> > This patch replaces all occurrences of "Lesser GPL version 2" with
> > "Lesser GPL version 2.1" in comment section.
> >
> > Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> > ---
> >  hw/ppc/ppce500_spin.c           | 2 +-
> >  target/ppc/compat.c             | 2 +-
> >  target/ppc/cpu-models.c         | 2 +-
> >  target/ppc/cpu-models.h         | 2 +-
> >  target/ppc/cpu.c                | 2 +-
> >  target/ppc/cpu.h                | 2 +-
> >  target/ppc/dfp_helper.c         | 2 +-
> >  target/ppc/excp_helper.c        | 2 +-
> >  target/ppc/fpu_helper.c         | 2 +-
> >  target/ppc/gdbstub.c            | 2 +-
> >  target/ppc/helper_regs.h        | 2 +-
> >  target/ppc/int_helper.c         | 2 +-
> >  target/ppc/internal.h           | 2 +-
> >  target/ppc/mem_helper.c         | 2 +-
> >  target/ppc/misc_helper.c        | 2 +-
> >  target/ppc/mmu-book3s-v3.c      | 2 +-
> >  target/ppc/mmu-book3s-v3.h      | 2 +-
> >  target/ppc/mmu-hash32.c         | 2 +-
> >  target/ppc/mmu-hash64.c         | 2 +-
> >  target/ppc/mmu-radix64.c        | 2 +-
> >  target/ppc/mmu_helper.c         | 2 +-
> >  target/ppc/timebase_helper.c    | 2 +-
> >  target/ppc/translate.c          | 2 +-
> >  target/ppc/translate_init.c.inc | 2 +-
> >  target/ppc/user_only_helper.c   | 2 +-
> >  25 files changed, 25 insertions(+), 25 deletions(-)
> >
> > diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
> > index 25c9ce7..d57b199 100644
> > --- a/hw/ppc/ppce500_spin.c
> > +++ b/hw/ppc/ppce500_spin.c
> > @@ -8,7 +8,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > index 08aede8..dd56025 100644
> > --- a/target/ppc/compat.c
> > +++ b/target/ppc/compat.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > index 4ad1686..87e4228 100644
> > --- a/target/ppc/cpu-models.c
> > +++ b/target/ppc/cpu-models.c
> > @@ -8,7 +8,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index ce750b2..fc5e217 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> > @@ -8,7 +8,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> > index 2801166..e501a7f 100644
> > --- a/target/ppc/cpu.c
> > +++ b/target/ppc/cpu.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 766e9c5..9e108ed 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
> > index 2c65bad..07341a6 100644
> > --- a/target/ppc/dfp_helper.c
> > +++ b/target/ppc/dfp_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > index a988ba1..8429bf6 100644
> > --- a/target/ppc/excp_helper.c
> > +++ b/target/ppc/excp_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> > index ae43b08..ccc155a 100644
> > --- a/target/ppc/fpu_helper.c
> > +++ b/target/ppc/fpu_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> > index 5c11c88..01459dd 100644
> > --- a/target/ppc/gdbstub.c
> > +++ b/target/ppc/gdbstub.c
> > @@ -7,7 +7,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
> > index d78c2af..efcc903 100644
> > --- a/target/ppc/helper_regs.h
> > +++ b/target/ppc/helper_regs.h
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> > index b45626f..0b682a1 100644
> > --- a/target/ppc/int_helper.c
> > +++ b/target/ppc/int_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> > index 15d655b..6104940 100644
> > --- a/target/ppc/internal.h
> > +++ b/target/ppc/internal.h
> > @@ -4,7 +4,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> > index 98f5895..f4f7e73 100644
> > --- a/target/ppc/mem_helper.c
> > +++ b/target/ppc/mem_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > index e43a3b4..5d6e0de 100644
> > --- a/target/ppc/misc_helper.c
> > +++ b/target/ppc/misc_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c
> > index 32b8c16..c78fd8d 100644
> > --- a/target/ppc/mmu-book3s-v3.c
> > +++ b/target/ppc/mmu-book3s-v3.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> > index 0f3c9d0..7b89be5 100644
> > --- a/target/ppc/mmu-book3s-v3.h
> > +++ b/target/ppc/mmu-book3s-v3.h
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> > index 55cf156..178cf09 100644
> > --- a/target/ppc/mmu-hash32.c
> > +++ b/target/ppc/mmu-hash32.c
> > @@ -7,7 +7,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > index c31d21e..46061e9 100644
> > --- a/target/ppc/mmu-hash64.c
> > +++ b/target/ppc/mmu-hash64.c
> > @@ -7,7 +7,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> > index c60bf31..30fcfcf 100644
> > --- a/target/ppc/mmu-radix64.c
> > +++ b/target/ppc/mmu-radix64.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> > index 8972714..ed74144 100644
> > --- a/target/ppc/mmu_helper.c
> > +++ b/target/ppc/mmu_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.=
c
> > index d16360a..8ff4080 100644
> > --- a/target/ppc/timebase_helper.c
> > +++ b/target/ppc/timebase_helper.c
> > @@ -6,7 +6,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index fedb9b2..54cac0e 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -7,7 +7,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/translate_init.c.inc
> b/target/ppc/translate_init.c.inc
> > index bb66526..c765803 100644
> > --- a/target/ppc/translate_init.c.inc
> > +++ b/target/ppc/translate_init.c.inc
> > @@ -7,7 +7,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > diff --git a/target/ppc/user_only_helper.c
> b/target/ppc/user_only_helper.c
> > index 683c033..aa3f867 100644
> > --- a/target/ppc/user_only_helper.c
> > +++ b/target/ppc/user_only_helper.c
> > @@ -7,7 +7,7 @@
> >   * This library is free software; you can redistribute it and/or
> >   * modify it under the terms of the GNU Lesser General Public
> >   * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > + * version 2.1 of the License, or (at your option) any later version.
> >   *
> >   * This library is distributed in the hope that it will be useful,
> >   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > --
> > 2.17.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000326b1905b20682c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br>
</div><div dir=3D"ltr">On Mon, Oct 19, 2020 at 4:13 PM Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; =
wrote: <br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">
&gt;This subject line says 8/30, but I&#39;ve never received patches<br>
&gt;9-&gt;30, and I don&#39;t see them in the mailing list archive<br>
&gt;either...

</div><div dir=3D"ltr"><br></div><div>I&#39;m working on the rest of the pa=
tches and will be pushing them before the end of this week.</div><div>Pleas=
e let me know if it&#39;s not the right way and if I should send the remain=
ing patches in one go.<br></div><div dir=3D"ltr"><br></div><div>Regards,</d=
iv><div>Chetan P.<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Oct 19, 2020 at 4:13 PM Daniel P. Berrang=C3=
=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This subj=
ect line says 8/30, but I&#39;ve never received patches<br>
9-&gt;30, and I don&#39;t see them in the mailing list archive<br>
either...<br>
<br>
On Mon, Oct 19, 2020 at 06:11:26AM +0000, Chetan Pant wrote:<br>
&gt; There is no &quot;version 2&quot; of the &quot;Lesser&quot; General Pu=
blic License.<br>
&gt; It is either &quot;GPL version 2.0&quot; or &quot;Lesser GPL version 2=
.1&quot;.<br>
&gt; This patch replaces all occurrences of &quot;Lesser GPL version 2&quot=
; with<br>
&gt; &quot;Lesser GPL version 2.1&quot; in comment section.<br>
&gt; <br>
&gt; Signed-off-by: Chetan Pant &lt;<a href=3D"mailto:chetan4windows@gmail.=
com" target=3D"_blank">chetan4windows@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/ppc/ppce500_spin.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
2 +-<br>
&gt;=C2=A0 target/ppc/compat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 2 +-<br>
&gt;=C2=A0 target/ppc/cpu-models.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/cpu-models.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/dfp_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/excp_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/fpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
2 +-<br>
&gt;=C2=A0 target/ppc/helper_regs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/int_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
2 +-<br>
&gt;=C2=A0 target/ppc/mem_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/misc_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/mmu-book3s-v3.c=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/mmu-book3s-v3.h=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/mmu-hash32.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/mmu-hash64.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/mmu-radix64.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/mmu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<=
br>
&gt;=C2=A0 target/ppc/timebase_helper.c=C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 target/ppc/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<=
br>
&gt;=C2=A0 target/ppc/translate_init.c.inc | 2 +-<br>
&gt;=C2=A0 target/ppc/user_only_helper.c=C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 25 files changed, 25 insertions(+), 25 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c<br>
&gt; index 25c9ce7..d57b199 100644<br>
&gt; --- a/hw/ppc/ppce500_spin.c<br>
&gt; +++ b/hw/ppc/ppce500_spin.c<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/compat.c b/target/ppc/compat.c<br>
&gt; index 08aede8..dd56025 100644<br>
&gt; --- a/target/ppc/compat.c<br>
&gt; +++ b/target/ppc/compat.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c<br>
&gt; index 4ad1686..87e4228 100644<br>
&gt; --- a/target/ppc/cpu-models.c<br>
&gt; +++ b/target/ppc/cpu-models.c<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h<br>
&gt; index ce750b2..fc5e217 100644<br>
&gt; --- a/target/ppc/cpu-models.h<br>
&gt; +++ b/target/ppc/cpu-models.h<br>
&gt; @@ -8,7 +8,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c<br>
&gt; index 2801166..e501a7f 100644<br>
&gt; --- a/target/ppc/cpu.c<br>
&gt; +++ b/target/ppc/cpu.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h<br>
&gt; index 766e9c5..9e108ed 100644<br>
&gt; --- a/target/ppc/cpu.h<br>
&gt; +++ b/target/ppc/cpu.h<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c<br>
&gt; index 2c65bad..07341a6 100644<br>
&gt; --- a/target/ppc/dfp_helper.c<br>
&gt; +++ b/target/ppc/dfp_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c<br>
&gt; index a988ba1..8429bf6 100644<br>
&gt; --- a/target/ppc/excp_helper.c<br>
&gt; +++ b/target/ppc/excp_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c<br>
&gt; index ae43b08..ccc155a 100644<br>
&gt; --- a/target/ppc/fpu_helper.c<br>
&gt; +++ b/target/ppc/fpu_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c<br>
&gt; index 5c11c88..01459dd 100644<br>
&gt; --- a/target/ppc/gdbstub.c<br>
&gt; +++ b/target/ppc/gdbstub.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h<br>
&gt; index d78c2af..efcc903 100644<br>
&gt; --- a/target/ppc/helper_regs.h<br>
&gt; +++ b/target/ppc/helper_regs.h<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c<br>
&gt; index b45626f..0b682a1 100644<br>
&gt; --- a/target/ppc/int_helper.c<br>
&gt; +++ b/target/ppc/int_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/internal.h b/target/ppc/internal.h<br>
&gt; index 15d655b..6104940 100644<br>
&gt; --- a/target/ppc/internal.h<br>
&gt; +++ b/target/ppc/internal.h<br>
&gt; @@ -4,7 +4,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c<br>
&gt; index 98f5895..f4f7e73 100644<br>
&gt; --- a/target/ppc/mem_helper.c<br>
&gt; +++ b/target/ppc/mem_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c<br>
&gt; index e43a3b4..5d6e0de 100644<br>
&gt; --- a/target/ppc/misc_helper.c<br>
&gt; +++ b/target/ppc/misc_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/mmu-book3s-v3.c b/target/ppc/mmu-book3s-v3.c<b=
r>
&gt; index 32b8c16..c78fd8d 100644<br>
&gt; --- a/target/ppc/mmu-book3s-v3.c<br>
&gt; +++ b/target/ppc/mmu-book3s-v3.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h<b=
r>
&gt; index 0f3c9d0..7b89be5 100644<br>
&gt; --- a/target/ppc/mmu-book3s-v3.h<br>
&gt; +++ b/target/ppc/mmu-book3s-v3.h<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c<br>
&gt; index 55cf156..178cf09 100644<br>
&gt; --- a/target/ppc/mmu-hash32.c<br>
&gt; +++ b/target/ppc/mmu-hash32.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c<br>
&gt; index c31d21e..46061e9 100644<br>
&gt; --- a/target/ppc/mmu-hash64.c<br>
&gt; +++ b/target/ppc/mmu-hash64.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c<br>
&gt; index c60bf31..30fcfcf 100644<br>
&gt; --- a/target/ppc/mmu-radix64.c<br>
&gt; +++ b/target/ppc/mmu-radix64.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c<br>
&gt; index 8972714..ed74144 100644<br>
&gt; --- a/target/ppc/mmu_helper.c<br>
&gt; +++ b/target/ppc/mmu_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper=
.c<br>
&gt; index d16360a..8ff4080 100644<br>
&gt; --- a/target/ppc/timebase_helper.c<br>
&gt; +++ b/target/ppc/timebase_helper.c<br>
&gt; @@ -6,7 +6,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/translate.c b/target/ppc/translate.c<br>
&gt; index fedb9b2..54cac0e 100644<br>
&gt; --- a/target/ppc/translate.c<br>
&gt; +++ b/target/ppc/translate.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/translate_init.c.inc b/target/ppc/translate_in=
it.c.inc<br>
&gt; index bb66526..c765803 100644<br>
&gt; --- a/target/ppc/translate_init.c.inc<br>
&gt; +++ b/target/ppc/translate_init.c.inc<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_help=
er.c<br>
&gt; index 683c033..aa3f867 100644<br>
&gt; --- a/target/ppc/user_only_helper.c<br>
&gt; +++ b/target/ppc/user_only_helper.c<br>
&gt; @@ -7,7 +7,7 @@<br>
&gt;=C2=A0 =C2=A0* This library is free software; you can redistribute it a=
nd/or<br>
&gt;=C2=A0 =C2=A0* modify it under the terms of the GNU Lesser General Publ=
ic<br>
&gt;=C2=A0 =C2=A0* License as published by the Free Software Foundation; ei=
ther<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; + * version 2.1 of the License, or (at your option) any later version.=
<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* This library is distributed in the hope that it will be =
useful,<br>
&gt;=C2=A0 =C2=A0* but WITHOUT ANY WARRANTY; without even the implied warra=
nty of<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
&gt; <br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div>

--000000000000326b1905b20682c2--

