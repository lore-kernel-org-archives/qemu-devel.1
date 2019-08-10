Return-Path: <SRS0=VlUQ=WG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A8BC433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E622166E
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Aug 2019 01:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9nLPCTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E622166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwGbG-0000PM-Vs
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 21:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwGam-000824-Va
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 21:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwGal-0002Ab-VX
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 21:54:48 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:47001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwGal-0002A2-Ng; Fri, 09 Aug 2019 21:54:47 -0400
Received: by mail-lf1-x141.google.com with SMTP id n19so2392007lfe.13;
 Fri, 09 Aug 2019 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=z5JlJp08JJ7LrohdylFk3y5UvwZrFn53Qep5+jX4PD0=;
 b=M9nLPCTnWfBrKuNhfzfh8r7ldAYTgTAkvnV/seY8dXBRxZFcU1CDxnO/ALQCUQgkUZ
 7L+GVgyPn5uJuGoNe6kqQpcM3+XHmnK7BM5LuaawYPqfFLfDL02hYi+DcOOBKvO5HrG5
 8RYyROCyzo3CG6P7YSheIGypHNaaKdxF8iCJuDPTFvjIqEP2ineZiLcltuR7l3QuphZA
 0E5ELmZDvPXKEl5bEAoXuvXKj84XQK3C3rhARL0Qemc4dV2gVopXBDloe+z9WZbMoJ7o
 K8p4c44gDtgMdN+Awcfe6r3BzvRSvlsqv5TCqcTSmdW5FRKAzHaCfF6jLX0C9TnEoX7Q
 Twlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z5JlJp08JJ7LrohdylFk3y5UvwZrFn53Qep5+jX4PD0=;
 b=eP4LeoM+y9CtA/xul99edRt9XbXCu2vucjLRAG6VhPCNcKF9IS1+wfVarQviiRmdSV
 rcVjkvqaPzU42XMYB1GGv4aOCwse21vqKI41wsG7vhlA07hmwLj2kAdmXaS86+UM8jt+
 69QU9jap981G8cFdVTtGNis5krrqsRYvBVIknaXmpcWmO0QjE2GuPhDcoGv1sJANSOpQ
 sJwe8xQf3W9xW1OmoniaAId1D7YHTNxl8hERjpC28daCVY203q3jc8fHy98bdQtl+ZXm
 7fUehYMa2DWnb5SLOVNbvs3fdrF80gGelEJMZ+y+tMYnQGFNJYwGqEwdHfL3YxBDCIMN
 FVlw==
X-Gm-Message-State: APjAAAX4HkRjwXl2Usr5LHn+nczfbFrqXiQnuFa0+EDfBTJnJAPqabgK
 QCUvmvgQ3jBYsLEZYCKhitr0zgHPx1ixl+WsqII=
X-Google-Smtp-Source: APXvYqyplpwGqIY67O4PANq1AxXUSvBXgS1jcx1iGeJodhN5E7+cGccqv1VUaQc3IMiwvh0oZ/lhKdf2iXw1rFi3ONk=
X-Received: by 2002:ac2:5ec3:: with SMTP id d3mr14089550lfq.44.1565402086408; 
 Fri, 09 Aug 2019 18:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
In-Reply-To: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Aug 2019 18:54:20 -0700
Message-ID: <CAKmqyKMqCKS_-rxZ2WYEn+m2gDom27rd2f2FCe0LmVs9brPcAQ@mail.gmail.com>
To: liuzhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 8, 2019 at 2:52 AM liuzhiwei <zhiwei_liu@c-sky.com> wrote:
>
> Hi all,
>
>     My workmate  and I have been working on Vector & Dsp extension, and
> I'd like to share develop status  with folks.

Cool!

>
>     The spec references for  Vector extension is riscv-v-spec-0.7.1, and
> riscv-p-spec-0.5 for DSP extension. The code of vector extension is
> ready and under testing,  the first patch will be sent about two weeks
> later. After that we will forward working on DSP extension, and send the
> first patch in middle  October.

What code are you talking about? Is this QEMU code?

>
>      Could the maintainers  tell me whether the specs referenced are
> appropriate? Is anyone working on these extensions?  I'd like to get
> your status, and maybe discuss questions and work togather.

Just use the latest (master) from the ISA spec git repo.

I don't know anyone doing vector work for QEMU. It would be very
useful, but everyone is busy with something at the moment
unfortunately.

Alistair

>
> Best Regards
>
> LIU Zhiwei
>
>
>

