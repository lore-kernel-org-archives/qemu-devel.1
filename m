Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D7FC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF62D20862
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 22:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnctERtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF62D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43041 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSr1B-0006Ga-3L
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 18:44:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSr0L-0005u3-Kq
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSr0K-0007JB-OI
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:43:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSr0K-0007Hq-8y
	for qemu-devel@nongnu.org; Mon, 20 May 2019 18:43:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id n25so867789wmk.4
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=K5vi96rIwghDWs+xFNa5L6xqqsOYsjx8O+SgwXL5qkM=;
	b=CnctERtM/N8cf3aVdRniSqliMNryeHcT/3eEWCN2rS2MlLxMlpu+TAiyRu2GBD/IMN
	3BE8s9QbJ36paWnn8+Ad6tjB2GuofaxCeJuaSKbZpoqY39S0QxKnMs+xbCtrGQdyRMxY
	Of50HZheRs8rHjr81vLUUqiWhuLxcEoBhcz38flOqYCkAbcBUVOqMSH89DQmdeYZ/uBo
	ojEoKdaobv+Koy/YPUepS+vegPB3HXcr/Nl2b+Z4frM3CdvKB5vH1uLx9WM6y/qyT2ol
	xx2ovHbkmo0hJrvJMawueO3xbfZALfvuxCibIYxGFiDlOu0y2Yr6XJAfx8ORlgOetHU6
	Q52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=K5vi96rIwghDWs+xFNa5L6xqqsOYsjx8O+SgwXL5qkM=;
	b=b7bd9OusUojI6xScNc2snX4sPzIXDr/shYIqLoE07A8o1S3eiXgjDZAgmlF6rZi1OS
	EGa8ooymVR4RQ++AzKo694SmORpYOg9qGUvX6/9nqQqvXP9f0wkpvz6yYvmyT5hS21yy
	A5tEbkfwAGAGXEzodgWvWXNWm36W+T3JJZVdwnuY7rNkYEKTqSgY5PqJ4/7Gegpg0CxD
	tmXshEmwHnvaFzZneEi3aKeRa6O+xQmI2LdqequhLzQi9q0LE/MguKb5kQ1AOVIzFs+5
	tG47ZwwJdw4mH7QRIa9jozjoFb3rSGO3n0CbGnhC+34GhuV9sZ0TaGe53NRMBHWzqnou
	HV+g==
X-Gm-Message-State: APjAAAUpvMCZFbluUwOgRtVopIg/cokidV+j1DUBRtNodzjYAmce/exO
	4Y2yshHl9CCXh06CrMAVgQ+S0/c3xC63NgmGcxwIzg==
X-Google-Smtp-Source: APXvYqyHiYdvVqFrIn2Vkm0cEYxgN3wfWyM70zyKZtR6Hl9ySnLdVLusAnUdjJNZKZvo6gO/3z6m+dQcCW9XvDzwZzc=
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr927700wmi.114.1558392214370; 
	Mon, 20 May 2019 15:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-8-jan.bobek@gmail.com>
	<87zhnhgw1c.fsf@zen.linaroharston>
In-Reply-To: <87zhnhgw1c.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 20 May 2019 18:43:23 -0400
Message-ID: <CAFXwXrkiShudOkAKks7VwB5-tUskeY1pfSeftvS8n=ez8Zgeog@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm
 to gas
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Bobek <jan.bobek@gmail.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019, 08:17 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

>
> Jan Bobek <jan.bobek@gmail.com> writes:
>
> > This allows us to drop dependency on NASM and build the test image
> > with GCC only. Adds support for x86_64, too.
>
>   ./risu --master -t run.out test_i386.bin
>
> and then:
>
>   ./risu -t run.out test_i386.bin
>
> Gives:
>
>   loading test image test_i386.bin...
>   starting apprentice image at 0xf7f07000
>   starting image
>   finished early after 1 checkpoints
>   match status...
>   mismatch on regs!
>   this reginfo:
>     faulting insn fc0b90f
>
> Because:
>
>   Mismatch (master v apprentice):
>   xmm4  : fe76ea16f7d9c58c 000006fc00000000
>        v: fe76ea16f7d1a58c 000006fc00000000
>
> We probably need to zero or reset the xmm regs both in the test and when
> risugen dumps it's preamble.
>

That gets fixed later in the series.

r~

>
