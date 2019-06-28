Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C760C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B152086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZsTKloB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B152086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgudN-0001ZC-8x
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hguP5-00088G-16
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hguP2-0000cV-LD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:11:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hguP2-0000ai-DG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:11:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so9790320wme.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OGUqFw7PFkoyHnlsj+M+Gh+SpPTfF+kl62qiyTwBoXQ=;
 b=RZsTKloBHY56DXa3vzAAu9XquCyOhjcPcmCKCj/Fx1PbGu0HxlPgtmyHbe+wYVBwOE
 EuxH5OD0g8JR000a1glJ+Jefs8q5Z1WFxxNkzlX71PPfoYVuyeT3oUSDhNc+wlML9oh5
 swg0o/I3KLqE5bdLED4EcK9WB6JAtvbK68wRhQcggYUtzCXQNeqNfR6+tOh/jvNPDVLM
 CPmeuxwhT1W6cf/hoqC9gdZY4aev2glrHr5ZuplqPkyAd9TP42bxBx+d4PiB6RfgpEYC
 6r2I5jryhUgWeby4hOxdED0HGDY4YiexTP5Gz5WDyS2D3PVu4am5qK3TPwxesfgMxPMC
 mw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OGUqFw7PFkoyHnlsj+M+Gh+SpPTfF+kl62qiyTwBoXQ=;
 b=aU16CVPGvdQCecGbwSIOGwaZ+jrmBSiHqhoVxdMjM0OCbNlFhthOzQLOwYKDkJzPT+
 5boqikbChqTv2X3qdAs/W8tVm2ahGVhXUH2T+4hmE/Km41M7xQBoRd/BUnK9lqqm/yMM
 TDJ/REk8KS7qkdwqyDYBrWhgaj/+7W0jB0MQeHaJIyGEPDQB4pXdIJkY2uhnMq8FJrQG
 lrH0SMN6ZSYgfIEGGvcMJASEEasEYRoCQWnee6JIi3Su0zB3oPppybfZmXV6SYSh7BbE
 bR+23aOFVA1WdpxP1wY8+iJadK/H7CZW7jQziRkK991lHjsVW7QD6tjPmzxdIqwQLtdt
 dN6g==
X-Gm-Message-State: APjAAAXIaKvWihtgASYaMscmX3W0ylQ0kcRTesxAE/NCsEkaiTMYcDkZ
 95wnACyDOGO8/tcVcHQy2lUp4w==
X-Google-Smtp-Source: APXvYqyaPu4BgL10pwQyZMZ0bMiVS8zon5HSZMUOskmMducSzd6MQKCxo5mMiSTR3jw/dfQmUSMFVA==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr8067027wmg.7.1561741869286;
 Fri, 28 Jun 2019 10:11:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n125sm3311786wmf.6.2019.06.28.10.11.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:11:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0E1141FF87;
 Fri, 28 Jun 2019 18:11:08 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-20-alex.bennee@linaro.org>
 <20190628153044.GB26345@quinoa.localdomain>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
In-reply-to: <20190628153044.GB26345@quinoa.localdomain>
Date: Fri, 28 Jun 2019 18:11:08 +0100
Message-ID: <87mui1ab4j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 19/50] tcg: let plugins instrument
 memory accesses
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aaron Lindsay OS <aaron@os.amperecomputing.com> writes:

> On Jun 14 18:11, Alex Benn=C3=A9e wrote:
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> Here the trickiest feature is passing the host address to
>> memory callbacks that request it. Perhaps it would be more
>> appropriate to pass a "physical" address to plugins, but since
>> in QEMU host addr ~=3D guest physical, I'm going with that for
>> simplicity.
>
> How much more difficult would it be to get the true physical address (on
> the guest)?

Previously there was a helper that converted host address (i.e. where
QEMU actually stores that value) back to the physical address (ram
offset + ram base). However the code for calculating all of this is
pretty invasive and requires tweaks to all the softmmu TCG backends as
well as hooks into a slew of memory functions.

I'm re-working this now so we just have the one memory callback and we
provide a helper function that can provide an opaque hwaddr struct which
can then be queried. The catch is you can only call this helper during a
memory callback. I'm not sure if having this restriction violates our
aim of not leaking implementation details to the plugin but it makes the
code simpler.

Internally what the helper does is simply re-query the SoftMMU TLB. As
the TLBs are per-CPU nothing else can have touched the TLB and the cache
should be hot so the cost of lookup should be minor. We could also
potentially expand the helpers so if you are interested in only IO
accesses we can do the full resolution and figure out what device we
just accessed.

> This is important enough to me that I would be willing to help if
> pointed in the right direction.

Well I'll certainly CC on the next series (hopefully posted Monday,
softfreeze starts Tuesday). I'll welcome any testing and review. Also if
you can tell us more about your use case that will help.

>
> -Aaron


--
Alex Benn=C3=A9e

