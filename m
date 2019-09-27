Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E18EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2657921841
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGJJ6ov7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2657921841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqxc-0008UZ-8I
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqA1-0001uF-K6
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDq9x-0008MO-HQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:19:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDq9x-0008M6-35
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:19:45 -0400
Received: by mail-ot1-x341.google.com with SMTP id s22so2189375otr.6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=lhhVvlH+/VJBwGrSQq1aOjhSEBry1BKWGVPTjkraBTk=;
 b=aGJJ6ov7MPh3STpS/AnZ6RjW7ulyZzZsOOyGHrXFPTCl8cqh275GKzTdmKrohOUtzJ
 oJhwtEmfiSByGr8NY0wSxeUuqrk3TiA6PFmzMsiK6ixcDgAjK4ArXlBud+eyJkrhcWZ2
 OIS3vRIq/G9p5BUFV/lNGtUOuQB1Txl/FlH9xBP7MnzO485ce82M2QoQmW3obgCuxZNj
 PSOIRSGT6kNATR2pAI/ZGZ61tYF/BNSPy964jIPsANycDiEoS953dMas8BOjUath+XAQ
 TVrhmIca91wA2o6kzd/M19hsLBC2XjCW/3nWF6bHvWb5xVkGCzCH/EX5QktGhm7+OfJs
 x/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=lhhVvlH+/VJBwGrSQq1aOjhSEBry1BKWGVPTjkraBTk=;
 b=Z1Zd2qWOPeG1/BnwwkNUgfH9Z07GFhSal9OlUqdrskNsPLd2YikqkthwVikRMJ96bh
 8b4jgM83SJ/S5YtKOhXUZWl4rOvQhBpRof8Nkm0wjeSy/1vYeOYAlviA1n11LNBJba0e
 ++ROU3cdTx3WrICkoy13TnYh2KFE40haCPF9lmavbLRffjORsw9E4arXTLr+beCNtLhS
 SUVsYoKSy/xoDlXK/tMI090KCjL0d5WZHFctgVMG4rkJAgsGLawo8MtCnrjVsU66hSzy
 xcx055aMuLo+90XJJshDhLIT9BqwxaVBEnGpZuoNGLis7sjv7tJkxx0Bw8KgRybrire0
 rgkg==
X-Gm-Message-State: APjAAAXFkdEevs2P/m3pNf59eFtOBwARC0Xrv4ZvPuEwnzraYs6zUEpr
 Pj1WpJtdC8/xHa1FJeLn82COgKIGKW0PM7DNFxzEiaADxHE=
X-Google-Smtp-Source: APXvYqxQpF+81bM32LME7i6Qi3EiRem8Qlk83aNMumGVMmywl0eXTX9jUCem3F2YyhrHoMsNBgUOdcn1YwT8jtxtdSA=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr2539183oti.135.1569578494862; 
 Fri, 27 Sep 2019 03:01:34 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 11:01:23 +0100
Message-ID: <CAFEAcA8HGEdHs74-m3Wa7RHU_ZE5g9kEidP-9Z69zhsMkCPRZQ@mail.gmail.com>
Subject: ptimer use of bottom-half handlers
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Investigating https://bugs.launchpad.net/qemu/+bug/1777777 I
found what seems to be a design flaw in the ptimer code.

The ptimer API is basically a down-counter (with a lot of bells
and whistles), with functions to do things like "read current count"
and "write current count". When the counter hits zero it typically
reloads, and the ptimer code notifies a callback function in the
device that's using ptimer. In the current implementation this
is done using a QEMU bottom-half handler, so ptimer_trigger()
calls replay_bh_schedule_event() on a QEMUBH that it was passed
by the device when it was initialized. The comment says this is
"to avoid reentrancy issues". That's a bit vague, but I assume the
idea is to avoid the code of the device's 'triggered' callback
being called from within eg ptimer_set_count(), because the
device might be in the middle of changing multiple parts of the
ptimer's state, its own state might not be consistent, etc.

Unfortunately, use of the bottom-half mechanism might have worked
back when the ptimer was first written, but these days we don't
run the iothread in lockstep with a single vcpu thread, so you
can get races, like:

 * the QEMU timer ptimer uses calls the ptimer_tick() function
 * ptimer code updates its own state for the counter rollover,
   and schedules the bottom-half handler to run
 * the vcpu thread executes guest code that does "read the counter
   value", which calls ptimer_get_count() and gets the new
   rolled-over value
 * the vcpu thread executes guest code that does "read an
   interrupt-pending register", which looks at a bit of state
   that's updated by the device's bottom-half handler, and
   incorrectly gets a value indicating "no rollover happened"
 * ...then the bottom-half handler runs and the device code
   updates its interrupt state, but too late.

I'm not sure what the best fix here is, but it's hard to see
how we can really continue to use bottom-half handlers here.

Possibilities I thought of:
 (1) make ptimer_trigger() just directly call the device's
     callback function. We'd need to audit all the devices
     to fix them up to handle the cases where the callback
     gets called while the device is in the middle of
     reconfiguring the timer.
 (2) call the device's callback function directly when the
     ptimer triggers from the QEMU timer expiry. But for
     the case of "a call to ptimer_set_count() etc caused
     the timer to trigger", don't call the callback, instead
     return a boolean from those functions which tells the
     caller that the timer triggered, and they need to deal
     with it (by calling their callback function when they've
     finished messing with the timer).

In either case we would need to gradually convert all (~30)
of the devices currently using ptimer over to use the new
mechanism, which in all cases would require some examination
and modification of the timer code to deal with the new
semantics. (I'm thinking of a patch series structure along
the lines of "patch 1 renames ptimer_init to ptimer_init_bh,
patch 2 introduces new ptimer_init function with new
semantics, patches 3..n change one device at a time,
patch n+1 deletes the now-unused ptimer_init_bh".)

I think overall I favour option 2, which is a bit more
syntactically invasive in terms of changing API signatures etc,
but semantically easier to reason about (because the
callback-function in the device is still not called when
the device might be partway through doing an update to
the ptimer state that changes multiple parameters of the
ptimer).

Is there another cleverer fix that I haven't thought of?

thanks
-- PMM

