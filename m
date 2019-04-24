Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C3DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE582175B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 11:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWISbKg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE582175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFmV-0003Uu-RS
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 07:09:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJFic-0008E7-Fp
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJFZ0-0000Kn-3e
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:55:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJFYz-0000GR-U1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:55:42 -0400
Received: by mail-ot1-x341.google.com with SMTP id j10so15735933otq.0
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oB1mNpodHSI8ODyaBBkcsIYkolpsfAZ2feP4QiXkh8E=;
	b=gWISbKg/+A/KRqETyiD/oDDco5Gco5yDLa4H33smp3NNm0QhvAd3Tb7rM1/l3wC6hI
	TTc9Cv04seae+OBsVexelSyXGPWmpzGnwTCqZrby/BEqaR7IjUKl6Os8Rw5jzG8sl+sU
	0ITgrtBRM9SGLPcFPIsBxgDFps3MOAeiDRP8xWNT+ZQ2Mgd8RMNiMhhoxkw5V32xewbY
	oblmAxqPAay6xJlAU5yQp2MrFOGYZM2r6IDv9DJqD4UD3kfciQOv9cbdfm5MtGImBv/e
	ZWRgDydW2ivK2QIe00IeTEHLUutsgiC+hpgTPtN/yJdQ/i4n8MSmK836u7pbePJYnKnY
	qSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oB1mNpodHSI8ODyaBBkcsIYkolpsfAZ2feP4QiXkh8E=;
	b=epZMXc70uBetU2rh2C4/HoBUg4VeHzb9d0UadCCZsnmqLpEX3/qCmXO34BtnPcGwZ9
	2numQYIQVAgtrR5yJ7Ak0/dTgdv2u+ldUru49VP45KpVvmkFWrU6+ywETmu+FL8LL42V
	p0n/5mYOFcaFmZ97eGKgDN1VFQ8FmA9gHgeWWYJkMq2n/VND+PC+I+1JCKNUnuaAOlzz
	Q88ZJ2tXwGoP58VlUmHKX61xXiGDCROtYN0R1PBJ40xS/lPzvFlZxr9B/tiRKtlougIv
	2uRDVx4xbOQFKGsomG8g0GzHpqD1vNZg9XXFzlTgtvV4zIix9CuC6YWB5oiniMYahvnN
	mMWQ==
X-Gm-Message-State: APjAAAUu3bTnIcpjrgHhbxvXkO5P2fAx0bM/idPB9RZHckffnM1c/kkI
	L135/g//6xbALs1nULv7wlsJOBBuAUWkf0prWh2ACg==
X-Google-Smtp-Source: APXvYqxX//jKqy4O+Sn58q6Oun7Btus/wqnRAluK/0iLEtNkKpi0WqbGDdaA8f23IyeDy+XEOD8smQIx0S5OC5stATI=
X-Received: by 2002:a9d:67:: with SMTP id 94mr19238714ota.238.1556103337736;
	Wed, 24 Apr 2019 03:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190418203840.10528-1-armbru@redhat.com>
In-Reply-To: <20190418203840.10528-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 11:55:25 +0100
Message-ID:
 <CAFEAcA9d5uMBiWx+OiLGuSs6qA5CRzG2dqhzsF8Q7tnOf_84Gg@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL for-4.1 0/9] Miscellaneous patches for
 2019-04-18
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424105525.Gm1j6Y_xqtQF8XhIZrb4-buM4SjO7-zfXhLrcYzW4Zg@z>

On Thu, 18 Apr 2019 at 21:40, Markus Armbruster <armbru@redhat.com> wrote:
>
> Early pull request because I'll be on vacation when 4.1 opens.  Hope
> that's okay.
>
> The following changes since commit eeba63fc7fface36f438bcbc0d3b02e7dcb59983:
>
>   Update version for v4.0.0-rc4 release (2019-04-16 21:53:00 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2019-04-18
>
> for you to fetch changes up to 15136db27efaf0bdcf1131d41ad57832a2acadcc:
>
>   Clean up decorations and whitespace around header guards (2019-04-17 19:20:46 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2019-04-18
>
> ----------------------------------------------------------------
> Markus Armbruster (9):
>       Clean up includes
>       Use #include "..." for our own headers, <...> for others
>       authz: Normalize #include "authz/trace.h" to "trace.h"
>       linux-user/nios2 linux-user/riscv: Clean up header guards
>       target/xtensa: Clean up core-isa.h header guards
>       Clean up header guards that don't match their file name
>       Clean up ill-advised or unusual header guards
>       Normalize header guard symbol definition.
>       Clean up decorations and whitespace around header guards

Hi -- this fails 'make check' on ppc64 and s390, so likely
a big-endian hosts issue:

make[1]: Leaving directory `/home/pm215/qemu/build/all/tests/fp'
cd /home/pm215/qemu/build/all/tests/fp && ./fp-test -s -l 1 -r all
i32_to_f16 i64_to_f16 i32_to_f32 i64_to_f32 i32_to_f64 i64_to_f64
i32_to_f128 i64_to_f128 >  int-to-float.out 2>&1 || (cat
int-to-float.out && exit 1;)
>> Testing i32_to_f16, rounding near_even
^M372 tests total.
^M372 tests performed.
In 372 tests, no errors found in i32_to_f16, rounding near_even.
[...]
>> Testing i32_to_f128
^M372 tests total.
^MErrors found in i32_to_f128:
1006FFFF  => +0000.000000000000401B006FFFF00000 .....
        expected +401B.006FFFF000000000000000000000 .....
^M0001DDEB  => +0000.000000000000400FDDEB00000000 .....
        expected +400F.DDEB000000000000000000000000 .....
^MFFF6FFFC  => +0000.000000000000C012200080000000 .....
        expected -4012.2000800000000000000000000000 .....
[...]
^M00000020  => +0000.0000000000004004000000000000 .....
        expected +4004.0000000000000000000000000000 .....
^M21 tests performed; 20 errors found.
make: *** [check-softfloat-conv] Error 1

thanks
-- PMM

