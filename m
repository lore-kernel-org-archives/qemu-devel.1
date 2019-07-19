Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D9C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEB521849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKJYwYTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEB521849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPY4-0004z1-N8
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoPXt-0004aA-In
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hoPXr-0002fe-S2
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:51:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hoPXr-0002fG-Mh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:51:19 -0400
Received: by mail-ot1-x341.google.com with SMTP id x21so32110824otq.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=uN5hThdb58kw3px4SK/kn5XOhMGpugt1cxH9MOy558k=;
 b=lKJYwYTD4Gt63l5B9JdpvOC7U8oEjkg1eTHTTtJQyVQ+Tg1DVNKpQkPyXtn7s+3FSM
 bvytURBxA/DlgGJI/2uC/nYZ68Nj/Pu4UDWit78jD19K71Dzl6BYRTVAjEfOkM2Z0VGC
 ikuaLLwKCAUorD5+cVuEhYclrCQvBEPnqRVm3B4fd+FOUkX8x3B9Bkm4fsCxQrxIAj1b
 cbqxMyMj1H2dUZTq95BZ4Iu7nvWqIdFawmJ0/ovKTL5mcEgWI20bhkBWAYKSuc8PZbaV
 fKdHphXWUgyNJ8rP0yz2hEn05qA3vCWaZ8XDTuccY7r0xhW9C2rmKtccTMqt+g8fY1eu
 942Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=uN5hThdb58kw3px4SK/kn5XOhMGpugt1cxH9MOy558k=;
 b=lCjKb7mCGzk6OFitzXPwaFnCeRSH5ThNggNJFsRxWAXPFhtTXBgfDih+fHtVjsaOLN
 A7QysCOjiTJN51L8ztKljh04F1d5Cdo+4i1CSHfrhA9gEWobiyZoZhzjEa++w4ztRhnC
 n6tkBx8oUiDEJFNGAOTX4P83J7/4lhxSUtu+lSk/peQ03VHLrbGjrTP5NpJPlkOgSPSf
 o2kFeRJmJ98JjyuRW+NP5lSvZ47pNqmhKLkj5plcq7tuk5OYg9UnNDe1ZHx5lTO4W06x
 bX/EyngsNCudZJnTECkL4bKN9puJNYaIxIh0iAJJkpeHugcNf/iPI/9Tz+oJp5zFFb8M
 thsA==
X-Gm-Message-State: APjAAAXkJE/uQ8hslyHAb5s2eNUINmXTTmHlV1NE481u5nn6RPQbnHXQ
 VasoMHoide+s0wkXd8UdevcYJO39nigziaJo9+4=
X-Google-Smtp-Source: APXvYqxfp2mgdx8kQBTabAmptHCJ99WfeRgFd19tOE28MhvMZIOHaLyRbsvMqbIcj5/NEIZtew7XPJ+HLBfHmFAFVNY=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr14511782otr.295.1563529878774; 
 Fri, 19 Jul 2019 02:51:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 02:51:18
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Fri, 19 Jul 2019 02:51:18
 -0700 (PDT)
In-Reply-To: <20190531104432.29379-1-david@redhat.com>
References: <20190531104432.29379-1-david@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 19 Jul 2019 11:51:18 +0200
Message-ID: <CAL1e-=g=8t+rvVisn2bXxir0ezZRZAybAFiNzV6M89Q9qvyRAw@mail.gmail.com>
To: David Hildenbrand <david@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v1 00/23] s390x/tcg: Vector Instruction
 Support Part 4
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 31, 2019 12:48 PM, "David Hildenbrand" <david@redhat.com> wrote:
>
> This is the final part of vector instruction support for s390x. It is
based
> on part 2, which is will send a pull-request for to Conny soon.
>
> Part 1: Vector Support Instructions
> Part 2: Vector Integer Instructions
> Part 3: Vector String Instructions
> Part 4: Vector Floating-Point Instructions
>

Congratulations on completing this complex task!

I followed your series (even though I did not make any comment), and I
salute this addition to QEMU.

I would just ask you to provide me and others with the link to the detailed
documentation on this matter - I had the hardest time trying to find it
online.

Thanks in advance!

Aleksandar

> The current state can be found at (kept updated):
>     https://github.com/davidhildenbrand/qemu/tree/vx
>
> It is based on:
> - [PATCH v2 0/5] s390x/tcg: Vector Instruction Support Part 3
> - [PATCH v1 0/2] s390x: Fix vector register alignment
>
> With the current state I can boot Linux kernel + user space compiled with
> SIMD support. This allows to boot distributions compiled exclusively for
> z13, requiring SIMD support. Also, it is now possible to build a complete
> kernel using rpmbuild as quite some issues have been sorted out.
>
> While the current state works fine for me with RHEL 8, I am experiencing
> some issues with newer userspace versions (I suspect glibc). I'll have
> to look into the details first - could be a BUG in !vector
> instruction or a BUG in a vector instruction that was until now unused.
>
> In this part, all Vector Floating-Point Instructions introduced with the
> "Vector Facility" are added. Also, the "qemu" model is changed to a
> z13 machine.
>
> David Hildenbrand (23):
>   s390x: Use uint64_t for vector registers
>   s390x/tcg: Introduce tcg_s390_vector_exception()
>   s390x/tcg: Export float_comp_to_cc() and float(32|64|128)_dcmask()
>   s390x/tcg: Implement VECTOR FP ADD
>   s390x/tcg: Implement VECTOR FP COMPARE (AND SIGNAL) SCALAR
>   s390x/tcg: Implement VECTOR FP COMPARE (EQUAL|HIGH|HIGH OR EQUAL)
>   s390x/tcg: Implement VECTOR FP CONVERT FROM FIXED 64-BIT
>   s390x/tcg: Implement VECTOR FP CONVERT FROM LOGICAL 64-BIT
>   s390x/tcg: Implement VECTOR FP CONVERT TO FIXED 64-BIT
>   s390x/tcg: Implement VECTOR FP CONVERT TO LOGICAL 64-BIT
>   s390x/tcg: Implement VECTOR FP DIVIDE
>   s390x/tcg: Implement VECTOR LOAD FP INTEGER
>   s390x/tcg: Implement VECTOR LOAD LENGTHENED
>   s390x/tcg: Implement VECTOR LOAD ROUNDED
>   s390x/tcg: Implement VECTOR FP MULTIPLY
>   s390x/tcg: Implement VECTOR FP MULTIPLY AND (ADD|SUBTRACT)
>   s390x/tcg: Implement VECTOR FP PERFORM SIGN OPERATION
>   s390x/tcg: Implement VECTOR FP SQUARE ROOT
>   s390x/tcg: Implement VECTOR FP SUBTRACT
>   s390x/tcg: Implement VECTOR FP TEST DATA CLASS IMMEDIATE
>   s390x/tcg: Allow linux-user to use vector instructions
>   s390x/tcg: We support the Vector Facility
>   s390x: Bump the "qemu" CPU model up to a stripped-down z13
>
>  hw/s390x/s390-virtio-ccw.c      |   2 +
>  linux-user/s390x/signal.c       |   4 +-
>  target/s390x/Makefile.objs      |   1 +
>  target/s390x/arch_dump.c        |   8 +-
>  target/s390x/cpu.c              |   3 +
>  target/s390x/cpu.h              |   5 +-
>  target/s390x/cpu_models.c       |   4 +-
>  target/s390x/excp_helper.c      |  21 +-
>  target/s390x/fpu_helper.c       |   4 +-
>  target/s390x/gdbstub.c          |  16 +-
>  target/s390x/gen-features.c     |  10 +-
>  target/s390x/helper.c           |  10 +-
>  target/s390x/helper.h           |  46 +++
>  target/s390x/insn-data.def      |  45 +++
>  target/s390x/internal.h         |   4 +
>  target/s390x/kvm.c              |  16 +-
>  target/s390x/machine.c          | 128 +++----
>  target/s390x/tcg_s390x.h        |   2 +
>  target/s390x/translate.c        |   2 +-
>  target/s390x/translate_vx.inc.c | 274 ++++++++++++++
>  target/s390x/vec_fpu_helper.c   | 644 ++++++++++++++++++++++++++++++++
>  21 files changed, 1145 insertions(+), 104 deletions(-)
>  create mode 100644 target/s390x/vec_fpu_helper.c
>
> --
> 2.20.1
>
>
