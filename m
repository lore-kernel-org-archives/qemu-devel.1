Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3ECC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:32:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6952468E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wK2LdRAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6952468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ILU-0000le-K9
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j7IKZ-0000Eu-O1
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j7IKY-0002oz-HR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:31:55 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j7IKY-0002nC-Aq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:31:54 -0500
Received: by mail-wr1-x443.google.com with SMTP id v4so3104048wrs.8
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 04:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=n+gavB/1ppLhpwbeRMMOgLAlN7jxWtDpIKjymr++j1U=;
 b=wK2LdRAOMFqPgBzmCsnANlyItBemwOewv88g8weqWMSnlY6lfqA4joZYwvYlBn6gzX
 H/UzEP3R2tlkntpOuLnrLvOzzVLMjHLOKzW7s+msjiVrYZc5y7sTe/dVS3iDbaPoqLJH
 XZtPs4Q9Ao8caBdfbstjlMeMYMtJBo2QRu8Kco+tJU6F/I6clzSaptU0ka0McZmqHkb5
 qkmVE4WyjTEmkdtCI5+XVh+2lV2ZEzQV1uWzEkX9DbQSuOTJvokgqIPtkcVd0i224I8+
 nRpQ7WH2LlWOkNOs9umvaIY8kzxeeqNvgwsA0FfGEpp/D76sTs5OL1Sc5f5oNenpEcJz
 uCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=n+gavB/1ppLhpwbeRMMOgLAlN7jxWtDpIKjymr++j1U=;
 b=NoF9bR70xuejQ2lXXIB5LJP7nwEeH0SnYNyfaPU7nx86DkLCuUbd2KZ5fc3w2/WMSH
 trGImUFhOV67dsBEC8A12zBd7IOGwpQ1hCB9XSYVMA3WxmlAAj9hxMoC0c86KqtMZL/X
 Yu1uW6zEhQCnn0HgvsQ8jB5eP05RvULAZ4CZzrWL/4galaxpeh5/02Se3v9sOeHvzQuQ
 tn3frtiLZ/BTFWeCLlVUbfN6eHGHdwmT6t5ZF+edTstbtQqI+dgEzBqFXb31i8hjn8Cy
 Szi8Y1/8+XkQL9L6xxxiPol8uoOgKoZGWZMOjPRR7sgvuAombjT6W+X0g0grYYs5M+T7
 R3CQ==
X-Gm-Message-State: APjAAAWEDnNjTPhqYyLK5ccibw8OCo+smSFn//h2jTaM/e0un5XFpABV
 9NyMyAQCwmUhkUfeZ7RrF9fFkw==
X-Google-Smtp-Source: APXvYqziXynnSgx9P6Yt2SrF1Ongyzd6LQLmzUHg0jyWHtG2B0arkfmNQ0V2/bA4A1XfiS+G/Ohc/w==
X-Received: by 2002:a5d:498f:: with SMTP id r15mr4625159wrq.284.1582806712386; 
 Thu, 27 Feb 2020 04:31:52 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l3sm6110602wrq.62.2020.02.27.04.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 04:31:51 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B03171FF87;
 Thu, 27 Feb 2020 12:31:50 +0000 (GMT)
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
 <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org>
User-agent: mu4e 1.3.8; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
In-reply-to: <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org>
Date: Thu, 27 Feb 2020 12:31:50 +0000
Message-ID: <87pne0w6rt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/26/20 10:10 AM, Alex Benn=C3=A9e wrote:
>> While 32mb is certainly usable a full system boot ends up flushing the
>> codegen buffer nearly 100 times. Increase the default on 64 bit hosts
>> to take advantage of all that spare memory. After this change I can
>> boot my tests system without any TB flushes.
>
>> +#if TCG_TARGET_REG_BITS =3D=3D 32
>>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
>> +#else
>> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2 * GiB)
>> +#endif
>
> This particular number, I'm not so sure about.
>
> It makes sense for a lone vm, running in system mode, on a large-ish host.
> It's more questionable for a large-ish host running many system mode vm's,
> although one can tune that from the command-line, so perhaps it's
> still ok.

Yeah it would be nice to get some feedback from users. I suspect system
emulation means the mmap is less efficient due to the sharding of the
translation buffer.

> It does not make sense for a linux-user chroot, running make -jN, on just=
 about
> any host.  For linux-user, I could be happy with a modest increase, but n=
ot all
> the way out to 2GiB.
>
> Discuss.

Does it matter that much? Surely for small programs the kernel just
never pages in the used portions of the mmap?

That said does linux-user have a better idea of the size of the problem
set before we start running? Could we defer calling tcg_exec_init until
we have mapped in the main executable and then size based on that?

>
>
> r~


--=20
Alex Benn=C3=A9e

