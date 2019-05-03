Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC70C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF64206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAi1Mg13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF64206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38279 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWCp-0007fq-Vq
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:18:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMWBs-0007K2-8X
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMWBr-0007Jg-85
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:17:20 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMWBr-0007IW-0e
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:17:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id f2so1355746wmj.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=LDnTsG5ltzP6WaSpBgYWCuVdvbx94yyTbk2ZcTENVLU=;
	b=QAi1Mg13bfBeCPnwf222gzrVn0Um/yXCRqZivLNrA4b9VNRSYHV5oKtlGBQZO8h7du
	3DT5d+eUBDibigQqbnZ7UuSwfLIlPIh9DayFzTcdce2Bcnlsb2dz0bL71ag3euNARNch
	lGEijUPM5FgYGuBxmCUeHc9IUYaEEhNLUWXB/pUqlJfvcG8L8Rda99wAKhkHq3qBD+A7
	Ln/rf96kYlKeWSv16c42ZyNLjUJ77qNkLJyoT2PU6r/BNDa2XLZ2/fSapNtpY5n2nus3
	GNsAambdmqQtW1SWWhu6I7OPs8jJ166tBlHJmROCViL+ig07l6gsM3XDWV3XD73PeR+u
	b6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=LDnTsG5ltzP6WaSpBgYWCuVdvbx94yyTbk2ZcTENVLU=;
	b=CleL5+Bd2qadjwbd+XviEZ9X8+2FIar+g5W8tMOp7MIDkvwVm6YzJDxcAIWUavG493
	qIW+ROAJjmA028vn+GvH/OkC1We22+Qo1JKHxodXOYl1S0RKPG0Dt8eCY9EbKd+1BM4Y
	v13EMfbU5hQfycwb4OMzjhd36QiOjMARZ7EhKGSHJTzVZfH3qYAuznl8yX0Cid2aiVto
	aVcpC/HYMmLSIYNV1GZ7TTFCKLYnUG+jnu+f65RUivvYpai6++EDPpTSpw/GLu2Ayqxb
	+2bvxD/aLKLnjBLM7q+N+0VWLq+qqxPxrDZPSC2LCUICa+JIOkt912Qc8RWXV58cLRJh
	fP3Q==
X-Gm-Message-State: APjAAAXh3EWz3cTEm0dy0pnSaPiRuU8CDRAzkc7+JNSGDXZV0dGuo0sa
	TMsZxoGnL9x5Adawrmlmkbsayw==
X-Google-Smtp-Source: APXvYqxYD8TDL0xiELYOnxfokP4V7ComCvUrFEXxy8zVExnIyLyDcP6BbYTCwgeBoMoZkO4tH7Hmew==
X-Received: by 2002:a1c:a103:: with SMTP id k3mr6022549wme.8.1556882237038;
	Fri, 03 May 2019 04:17:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	p67sm2000681wmp.22.2019.05.03.04.17.16
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 03 May 2019 04:17:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A97B81FF87;
	Fri,  3 May 2019 12:17:15 +0100 (BST)
References: <20190502185835.15185-1-laurent@vivier.eu>
	<CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA9-hAU5dxUmSWtbvrPEXE-nCP1uLvLbOby-_EXZ27o+8g@mail.gmail.com>
Date: Fri, 03 May 2019 12:17:15 +0100
Message-ID: <87sgtv4wjo.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PULL 00/13] Trivial branch patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
	Jason Wang <jasowang@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503111715.AaFDF8Katge6NiYV2sdM2IExozrUlgcrcmALm02VeaU@z>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 2 May 2019 at 19:58, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e4=
1df:
>>
>>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request=
' into staging (2019-05-02 12:04:51 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
>>
>> for you to fetch changes up to f7c03a68b814254df414977ff299468fbf0fa1c0:
>>
>>   sockets: avoid string truncation warnings when copying UNIX path (2019=
-05-02 20:50:47 +0200)
>>
>> ----------------------------------------------------------------
>> Pull request trivial branch 2019-05-02
>>
>> ----------------------------------------------------------------
>
> Markus's "Clean up includes" patch breaks 'make check' on
> big-endian hosts:
> cd /home/pm215/qemu/build/all/tests/fp && ./fp-test -s -l 1 -r all  i32_t=
o_f16 i
> 64_to_f16 i32_to_f32 i64_to_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_to_=
f128 >
>  int-to-float.out 2>&1 || (cat  int-to-float.out && exit 1;)
>>> Testing i32_to_f16, rounding near_even
> ^M372 tests total.
> ^M372 tests performed.
> In 372 tests, no errors found in i32_to_f16, rounding near_even.
>>> Testing i32_to_f16, rounding minMag
> [...]
> ^MErrors found in i32_to_f128:
> 1006FFFF  =3D> +0000.000000000000401B006FFFF00000 .....
>         expected +401B.006FFFF000000000000000000000 .....
> ^M0001DDEB  =3D> +0000.000000000000400FDDEB00000000 .....
>         expected +400F.DDEB000000000000000000000000 .....
> ^MFFF6FFFC  =3D> +0000.000000000000C012200080000000 .....
>         expected -4012.2000800000000000000000000000 .....
> ^MFFFFFFF8  =3D> +0000.000000000000C002000000000000 .....
>         expected -4002.0000000000000000000000000000 .....
> [etc]

Considering the header clean-ups moved bswap related stuff and the
patterns look incorrectly swapped something has gone fishy.

If it's just stuff touching f128 then we have some magic in
softfloat-types:

 typedef struct {
 #ifdef HOST_WORDS_BIGENDIAN
     uint64_t high, low;
 #else
     uint64_t low, high;
 #endif
 } float128;

but I would have though HOST_WORDS_BIGENDIAN is in the config. I shall
have a poke once I get onto the s390 machine.

>
> (I had to bounce Markus' own pullreq from a week or
> so back because it had this patch in too and also failed
> for this reason.)
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

