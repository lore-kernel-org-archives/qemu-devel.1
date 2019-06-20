Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9298C48BE2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A9CD2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWF+mdey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9CD2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdtkw-0006CF-QL
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 05:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53764)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdtiI-0004XO-T7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdtiG-0001PS-LM
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:50:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdtiA-0001EG-Lb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 05:50:32 -0400
Received: by mail-wr1-x441.google.com with SMTP id r16so2302964wrl.11
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Fsngp1dcjnX8H+KgdX9/eAa074Xx3jfBqN6wgtwwqm0=;
 b=AWF+mdeyY5YLX+ZrPIQcKhV9qYxM6eCZcyClh3MtJdkMQejSrLme3gzURyO7jeaqTp
 Y363BwQ8E4jRsXb783/70Bi71GwztzwRSOc0LNvUQsQim8V+bq7AQK0SoJQnQpie0yb1
 IS42piKyDV2zXg/5NjGXZWLBx9ZtLRxwno8IlolIS8HINHfd1YX7WBVJPpB6+HLBXczN
 pjm+Jj6DRCzVNQpkeJLafz4+It/tlrnAALvzFQaqHEYUQRHn7K8/l/xLNqATjUAujtdP
 FD2etUWuFt5T2ESxbhnIWT9zXc4lBrtQSUEq1RAJeerqq/iL/eq2j5yjJKlWnUvQk33N
 pBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Fsngp1dcjnX8H+KgdX9/eAa074Xx3jfBqN6wgtwwqm0=;
 b=NROd3Y97LR5wbIicgavE6dZlzYVVf2T8IlqVL3Hf0aHZLQbmq2eAVubfouy/Rjeia3
 50gjzP3CmQqkpjZrXepHxMZZvLT5H8WTeE6rcspoewSDAktis6ff7g6vs3ABCKvAulvC
 QCe0Hs3hcEASAM6k0Ubl4AraGrBh5rkkOBMgOGHB78kWzUi2ZJEINHUIOIYQY61c9fFd
 t0BTshOYVEoZG09zn0rUzLcHzsdif6ce8pViHzIPkGkmsxwLyXefETPrZCIUHfIV6VYo
 qWTfdziR/WE66q/+6WnpC81KULThM+p0t4BzZxfI739sYPgaIzUhNNqMFlT4Z74LzJ0n
 s5yQ==
X-Gm-Message-State: APjAAAXNSor05SW7CF5A1AZMHP1dtnAcHB27f/au3UySg2iB4fgle6Oh
 TNvuk3AquqNKc8S/R9CgWsiTlw==
X-Google-Smtp-Source: APXvYqz6N00z4b6ZL3Nf9CKCh+6Yq1SVj5eTEJVixecsDGJ+s0E35ro2O1guBYj6jYyh475trg1qVQ==
X-Received: by 2002:adf:b78c:: with SMTP id s12mr27518879wre.264.1561024227428; 
 Thu, 20 Jun 2019 02:50:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q20sm41385147wra.36.2019.06.20.02.50.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 20 Jun 2019 02:50:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 752B01FF87;
 Thu, 20 Jun 2019 10:50:26 +0100 (BST)
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-4-alex.bennee@linaro.org>
 <3a5f9077-930e-cfd0-ab04-fbcd2c0061e4@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <3a5f9077-930e-cfd0-ab04-fbcd2c0061e4@linaro.org>
Date: Thu, 20 Jun 2019 10:50:26 +0100
Message-ID: <87wohg8u1p.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v3 03/50] cpu: introduce
 cpu_in_exclusive_work_context()
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
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/14/19 10:11 AM, Alex Benn=C3=A9e wrote:
>>              start_exclusive();
>> +            cpu->in_exclusive_work_context =3D true;
>>              wi->func(cpu, wi->data);
>> +            cpu->in_exclusive_work_context =3D false;
>>              end_exclusive();
>
> Is there a reason not to put those into start/end_exclusive?

Not particularly... it can use current_cpu to find the cpu and set the
flag.

> And if not, what does in_exclusive_work_context mean?

Currently the check implies it's only for:

 exclusive work context, which has previously been queued via async_safe_ru=
n_on_cpu()

which avoids jumping through hoops if another async_safe tasks still
wants to flush the TB. However keeping it with start/end exclusive means
we could also clean up the code in:

  void cpu_exec_step_atomic(CPUState *cpu)
  {
    ..
    /* volatile because we modify it between setjmp and longjmp */
    volatile bool in_exclusive_region =3D false;
    ..
    if (sigsetjmp(cpu->jmp_env, 0) =3D=3D 0) {
        start_exclusive();
        ..
    } else {
        ..
    }

    if (in_exclusive_region) {
        ..
        end_exclusive();

but the volatile makes me nervous. Is it only a risk that local
variable accesses might get optimised away?

>
>
> r~


--
Alex Benn=C3=A9e

