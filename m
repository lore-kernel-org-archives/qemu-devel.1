Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B58C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 23:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4659921871
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 23:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzV8ZknJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4659921871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr9ho-0004CH-DN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 19:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46839)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <saiallforums@gmail.com>) id 1hr9hY-0003nr-OR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saiallforums@gmail.com>) id 1hr9hX-0000Hy-3a
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:32:40 -0400
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35]:36378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <saiallforums@gmail.com>)
 id 1hr9hW-0000Cs-QF
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 19:32:38 -0400
Received: by mail-vs1-xe35.google.com with SMTP id y16so37154944vsc.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 16:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=X6IUj6H9WR/N7Yp9+W5q+xyknIyUCBHGRYsnQoaMku0=;
 b=AzV8ZknJNT51YFGqC5IQpZ23daCKCiUjE0S19V0aWIMojfFIMC0Gz+FI/7uWCRbslE
 ZVhBZS/Y49KppTpxxarpldWpNCymY1XW+SRDrHkSj0rJZodcFDiKF9bb1p2Dij1UfiGe
 gK0DTUxUKcypZd6aL+AlBRoUJY04Z/lZ0fvVvqWPaiqBalU6Icfi7BMPPY58TufemvUy
 pHY1PBu2kn0+nVcErBMp+N3u3DOzsGAVsFJld0MdiFKziEJiXyUq7TIk27Y8VCUTRltg
 Fjlz4aNnBI101LsKSlL4RRKcNpf4TX6TEk+pgE0kjuoaMk+0Ffr5BhzMEu/cQhFPPBW9
 VqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=X6IUj6H9WR/N7Yp9+W5q+xyknIyUCBHGRYsnQoaMku0=;
 b=fNRFMBJpFCH4Sk0JTm3Wnhbpu9xRvMM1G+HV9kzI5i7qI4I93hEZSJUDe6Fqq9/cRj
 saJnWwxtL1ge7dkTLglnaNWxQSEqrce+X/xANyi6vVBH7YaSNLJK2tHWMtrKYScoly7O
 PpY2KXjBqVKJKu3cLQ8XYYm1TPUdnaGE0y0/Fm34P65pRgjLsR2KnBxVZiqDopvIN9KI
 oL0nyNkdA0y7JLYh+VcQbLUcAkBbGUayTAL3FGxUGNRTeHNMJYwNka+3CBkJq1KbruEN
 Ob5HxRNJZI29lWVbXL1fVKLMEzL8GbjAXcEq3Zhn5Lqh944jo9wYpOG+Yb0qCWEHc59i
 wLaA==
X-Gm-Message-State: APjAAAUxCsmeSQ/ZqSluIXcw5tO+5CpVBfO2XHN4FioH3eE9NkA7mvbw
 Dt21fCWF92lTl5rKVI1ZaBDEo1GV1FwvLEywdhiyEDZt
X-Google-Smtp-Source: APXvYqxsBtKTyRW9mNfo7Dca5AWWsb8DtuDIttm7XBLs1Ap8Mq58eKkfonbQGdXpQayni/+gF5kGM41E71V4THlqg5g=
X-Received: by 2002:a67:dd0a:: with SMTP id y10mr31707111vsj.93.1564183956981; 
 Fri, 26 Jul 2019 16:32:36 -0700 (PDT)
MIME-Version: 1.0
From: sainath grandhi <saiallforums@gmail.com>
Date: Fri, 26 Jul 2019 16:32:26 -0700
Message-ID: <CABqzqi5n9Sz4H+wc7yJSQz+tzOf8zr8=9H+KkgSoNv8wf=04WA@mail.gmail.com>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e35
Subject: [Qemu-devel] Question regarding tcg trace-events
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello
I am working with qemu tracing support and combined with tcg.
I read that if tcg property is used for trace-event, it generates a
trace-event once during translation and another trace-event after the
execution.

I made the following change in target/i386/translate.c

-static inline void gen_op_movl_seg_T0_vm(DisasContext *s, int seg_reg)
+static inline void gen_op_movl_seg_T0_vm(DisasContext *s, int
seg_reg, CPUX86State *env)
 {
     tcg_gen_ext16u_tl(s->T0, s->T0);
     tcg_gen_st32_tl(s->T0, cpu_env,
                     offsetof(CPUX86State,segs[seg_reg].selector));
+    trace_seg_write_tcg(tcg_ctx->cpu, cpu_env, env->eip, seg_reg,
env->segs[seg_reg].selector, s->T0);
     tcg_gen_shli_tl(cpu_seg_base[seg_reg], s->T0, 4);

I see seg_write_trans and seg_write_exec trace-events.
Question I have is the following:
I expect one seg_write_trans trace-event per seg_write_exec
trace-event. However I notice more than one seg_write_exec
trace-events after a seg_write_trans and in some cases seg_write_exec
trace-events occur without a seg_write_trans.
Why do this happen? Does this have something to do with TCG and TBs?

