Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F2CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C42A222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C42A222C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTAt-0001nN-HY
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLTA4-0000r4-L3
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLTA3-0006eH-Fg
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:23:24 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38833)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLTA3-0006e7-C2
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:23:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id s6so2222081ywe.5
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JLJpBZYQXf79n1dFdpTnJRceITRbJYuhUTVPY++W0EM=;
 b=Kw8uqrgiEoUjabAohdkUJEnISaFFMD7CYTe2jLouezNzd5ga5G/NAI9/VSFRuhqdQR
 doH04HQELJ4lO6Oo6OmyaZZDILq0c/5HKgDK5nr8wKLG3MbBraWtuLygRTOPTqrFZEGN
 5ndn74Tz6oKajN4us/t8UeYXY/jg+/miMN3Fu3REvhZ8hyU/d71dsB2RIiset0RfLWo8
 /cgM/Nn0Oc0sPBt55cYOBbTDFvvmqUri6vmfC2RLbKVoIPw6AB+bnpTux8xVbrAKogm9
 7voYvG/KmK0kPnN1EeqNvVLh6jIHfgJ6cXUwO4+lIAVbiPvs0UmbNrkRINx/KJhyuUtT
 JiJA==
X-Gm-Message-State: APjAAAVTHzMefwOjo6uPeMHIhkMPegokPbvEDnRJ7ulfZ5QmHBeqyJNp
 xkRaw8o4YQoe83V5wIJRFD53DMEU0Z16d7QfPtW8QXG+
X-Google-Smtp-Source: APXvYqxzmZyAQcDJsVvQuFwP2voMvykkb8ur5AaeypBOLwvfjJDB3YcApN4C6T7/ECkp5MA3oMoMQGXkeVoPN07Yr7E=
X-Received: by 2002:a81:700a:: with SMTP id l10mr7282468ywc.201.1571408601629; 
 Fri, 18 Oct 2019 07:23:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191010122128.29000-1-f4bug@amsat.org>
In-Reply-To: <20191010122128.29000-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 18 Oct 2019 16:23:10 +0200
Message-ID: <CAAdtpL4Y24_12FBDP_Ohh-hpOS3vG+XS7K-LCFCWkPwkWGQ5wg@mail.gmail.com>
Subject: Re: [PATCH 0/2] tests/acceptance: Add tests for the PA-RISC machine
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Sven Schnelle <svens@stackframe.org>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
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
Cc: Helge Deller <deller@gmx.de>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

Sven since you tested this series, can I add your Tested-by tag?

On Thu, Oct 10, 2019 at 2:21 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> This tests boot a HP-UX firmware CD-ROM which allow serial
> console interaction. This exercise the PCI LSI53C895A SCSI
> controller.
>
> I'm not adding it to the Travis-CI list because I'm not sure
> how to split/rename the current job, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg644753.html
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   tests/boot_console: Send <carriage return> on serial lines
>   tests/boot_console: Test booting HP-UX firmware upgrade
>
>  tests/acceptance/boot_linux_console.py | 27 +++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)

