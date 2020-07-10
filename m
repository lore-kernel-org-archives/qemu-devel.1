Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C35BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503B32076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDD7NEeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503B32076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtxsQ-0006Qk-Kw
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtxrJ-0005fb-1a; Fri, 10 Jul 2020 14:34:53 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtxrD-0006bp-LS; Fri, 10 Jul 2020 14:34:52 -0400
Received: by mail-io1-xd42.google.com with SMTP id y2so7057236ioy.3;
 Fri, 10 Jul 2020 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/z6DLBz413FMPmE+w+/tds6gqklZ6f/Dtvv31G6dQWI=;
 b=MDD7NEeCfQnmuIBEXifC7sXvZWmiyVDesXdmG7sdyweiTS43+8hP95TTPv5/UgTiYA
 ApJaEjzW6liCe2ej7hOODlEhyMdRU0Aqb7KA97tWCAaCambqdgByD/an2Zv0NWLTiHSS
 Dw1n23ozz9Siq9Gyizidspq6plJB9ctN+1gZ/gD9N0TnP/kVce8E/jrpqiaCpSuJBJVk
 umUNDztJPxe1eQgg+JqT88WA/1GHeBEov2S/eY+m0sWrz+ozqEy5WM/H8//7zSI7w+9/
 +rlmmMsdHezUq/Ahmhq2bpIyE+v/eDFmMBn0itmrvsNkYy05mzB3VoGFgc3EYyK49wCc
 KsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/z6DLBz413FMPmE+w+/tds6gqklZ6f/Dtvv31G6dQWI=;
 b=W1hKZd5JsrorgvG5YVV8s2JqtbjBn20HqX8VfsYNJtVW0MKxoeULvxK0t8LJunfqtC
 C3hDX6V4q1T/Q4VhZ+6ld/mqW1yRsGG6aB0/hfWzXJQgysz2qPl7HdBweGLuYw1w0euG
 ooGQaAd/pWdMZALtzoH0UTSYTKqaK9rbhCkH1eyMSzixAOKRQZf9JyHNy1neWzWcnh1J
 UoQ0/K9AuKnKUMbSiBBS+qGzLoQ37pyNGUCR7JWXLYFfCz5vTzrl3fHaxSJcBzButvfj
 cv56cvbwjXwFdQOl26XPWSNkMpZyyF+2xDmbdQNZBQUmU6JxNYvMNM84yuHALMLdpQWB
 bcjA==
X-Gm-Message-State: AOAM533Is+ockl/jdPYgZkdAhb9n6rp674iFlor1isZbLJFyZyAegwRr
 PYPf5GyTOZDDjnOCORDOxctlQ03Ywk7O/feUAEU=
X-Google-Smtp-Source: ABdhPJz0E+0EOvWGMBaOEpDgZ5FA1EemwtBL5bZUMsyoVrCtsLIogjX50N27/j/y+ARZkxNP5gxBMs6QMLXeL5L18yE=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr48422328ioe.176.1594406085913; 
 Fri, 10 Jul 2020 11:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-2-frank.chang@sifive.com>
 <9be2326f-96d8-7680-d068-6fac66ba0be8@linaro.org>
In-Reply-To: <9be2326f-96d8-7680-d068-6fac66ba0be8@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jul 2020 11:24:50 -0700
Message-ID: <CAKmqyKMMsEW_NmnjmOV-4PTfvdEGP_jK8T51Z=8tArZ3rcEXUA@mail.gmail.com>
Subject: Re: [RFC 01/65] target/riscv: fix rsub gvec tcg_assert_listed_vecop
 assertion
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, frank.chang@sifive.com,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 9:13 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> > From: Frank Chang <frank.chang@sifive.com>
> >
> > gvec should provide vecop_list to avoid:
> > "tcg_tcg_assert_listed_vecop: code should not be reached bug" assertion.
> >
> > Signed-off-by: Frank Chang <frank.chang@sifive.com>
> > ---
> >  target/riscv/insn_trans/trans_rvv.inc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Alistair, this one should be queued for 5.1 as a bug fix.

Thanks for reviewing these. I have applied the first 4 to my PR for 5.1.

Alistair

>
>
> r~
>

