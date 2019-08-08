Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E317FC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6672171F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 13:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JQ1PaCaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6672171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvipW-0002Gt-VD
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 09:51:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54988)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvioW-0001JP-3q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hvioS-0003aE-De
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:50:44 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hvims-0002Ig-1Z
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 09:50:38 -0400
Received: by mail-ot1-x341.google.com with SMTP id o101so118784996ota.8
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 06:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NpsU4i3hOdSlC+nlL/yF35AxiEWrigBgskh4dJmO30E=;
 b=JQ1PaCaVsK5V34dSg/pn9mHcUGOrxkwsbTnRp9YOyUMo/PwmtgiEWNw+GjcC6BHrSU
 vA/EeSdBb2NVGdP8GzbZkiGlvkfZYMQ+J6tpqfFEuj9y5vIOxxa1QccmXNuASILMyIWK
 6IjsR307N5dfsQcLJGiNK1UYG6owUyX1I0gBjLrytnGuSbvZN3NoFZNSF3MvKUhJATNE
 Mom1O+d73fPwHmd48b1dEVODFAYRsoMUSSQClRziyQEOQgkGvA81LbBS5cmE9up8pg/N
 nYVq2/Hd0Q/ymZ4dilZvsDMAd0cOXlobZlxSu19Q4otUU+Mp9Wnuh/hpbxusHxCa31Ij
 uUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NpsU4i3hOdSlC+nlL/yF35AxiEWrigBgskh4dJmO30E=;
 b=UApqbExNdKWdjyQFQEPqAQ2zsbY/ivpD8wooWic/NZV7c+W8GAPTCWAk9vvyE5bP8Q
 9f68AefhvHPw5XnEANhqSv5azFkLKSZlMIezvamKc/hbc5aN9RRsLiomjcDE5vvw+o99
 pIwJMIWTsGBWXmLohf7bF0NZHuqkxIG2urHK12ntJUjBzhuhjfUn8zZyi2hCmpaa9Jw6
 6t0O/FKWTeUY1CoFBYJkXQ8LhyNClO3uk7DUR+lzsUCB9ory1B74irh7qMGO0t+WM6Ae
 KMwp+Cqhs70Wu7n+L/ZeiuMtE1guB9oi6clbU9w+j6PfKvw5lh3isSlr+uHdY5fJgrCt
 aWDQ==
X-Gm-Message-State: APjAAAUxIPCIBB9KCWpsyNwNFHF5XrFm55SlbXjYECIIXHA4seEizG6G
 6cDNnoOCQUFjR/yqYv3TVy8V4mqYuluaAKnCv8SZUg==
X-Google-Smtp-Source: APXvYqzWbXYpyJ0pxCr0jiUX0R4QxbwMx7nuUklHoTtDJ14IxxRArzmBHsIxZmY2HmzjKoLV6j+sOd+HA/yo9Z40+JE=
X-Received: by 2002:a5d:91d7:: with SMTP id k23mr4409741ior.163.1565272138853; 
 Thu, 08 Aug 2019 06:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAL1e-=jceerbvam57mmXoKWHzepB-qUFL08gBEnSws_ohewLzw@mail.gmail.com>
In-Reply-To: <CAL1e-=jceerbvam57mmXoKWHzepB-qUFL08gBEnSws_ohewLzw@mail.gmail.com>
From: Chih-Min Chao <chihmin.chao@sifive.com>
Date: Thu, 8 Aug 2019 21:48:47 +0800
Message-ID: <CAEiOBXVDg-oaqWDpzFrsPjzt8jdmLt7DskG4=zXwYVUb+5=tfg@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, liuzhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 8, 2019 at 7:29 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

> On Thu, Aug 8, 2019 at 11:52 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
> > Hi all,
> >
> >     My workmate  and I have been working on Vector & Dsp extension, and
> > I'd like to share develop status  with folks.
> >
> >     The spec references for  Vector extension is riscv-v-spec-0.7.1, and
> > riscv-p-spec-0.5 for DSP extension.
>
>
> Hello, Liu.
>
> I will not answer your questions directly, however I want to bring to you
> and others another perspective on this situation.
>
> First, please provide the link to the specifications. Via Google, I found
> that "riscv-v-spec-0.7.1" is titled "Working draft of the proposed RISC-V V
> vector extension". I could not find "riscv-p-spec-0.5".
>
> I am not sure what the QEMU policy towards "working draft proposal" type of
> specification is. Peter, can you perhaps clarify that or any other related
> issue?
>

Hi Aleksandar,

As for riscv-v-spec 0.7.1, it is first stable spec for target software
development
though the name is working draft.  The architecture skeleton is fix and
most of
work are focusing the issues related to micro-architecture implementation
complexity.
Sifive has released an open source implementation on spike simulation and
Imperas also
provides another implementation with its binary simulator.  I think it is
worth to include the extension
in Qemu at this moment.

As for riscv-p-spec-0.5, I think Andes has fully supported this extension
and should release more
detailed spec in the near future (described Riscv Technical Update
2019/06).
They have implement lots of DSP kernel based on this extension and also
provided impressed
performance result.  It is also worth to be reviewed (at least [RFC]) if
the detailed  spec is public.


ref:
     1.
https://content.riscv.org/wp-content/uploads/2019/06/17.40-Vector_RISCV-20190611-Vectors.pdf
     2.
https://content.riscv.org/wp-content/uploads/2019/06/17.20-P-ext-RVW-Zurich-20190611.pdf
     3.
https://content.riscv.org/wp-content/uploads/2019/06/10.05-TechCommitteeUpdate-June-2019-Copy.pdf


chihmin


I would advice some caution in these cases. The major issue is backward
> compatibility, but there are other issues too. Let's say, fairness. If we
> let emulation of a component based on a "working draft proposal" be
> integrated into QEMU, this will set a precedent, and many other developer
> would rightfully ask for their contributions based on drafts to be
> integrated into QEMU. Our policy should be as equal as possible to all
> contribution, large or small, riscv or alpha, cpu or device, tcg or kvm -
> in my honest opinion. QEMU upstream should not be a collecting place for
> all imaginable experimentations, certain criteria on what is appropriate
> for upstreaming exist and must continue to exist.
>
> Yours,
> Aleksandar
>
>
>
>
> > The code of vector extension is
> > ready and under testing,  the first patch will be sent about two weeks
> > later. After that we will forward working on DSP extension, and send the
> > first patch in middle  October.
> >
> >      Could the maintainers  tell me whether the specs referenced are
> > appropriate? Is anyone working on these extensions?  I'd like to get
> > your status, and maybe discuss questions and work togather.
> >
> > Best Regards
> >
> > LIU Zhiwei
> >
> >
> >
> >
>
