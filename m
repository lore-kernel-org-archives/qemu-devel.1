Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A093C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21620206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 04:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwa2NZp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21620206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38961 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJsTb-0003qF-2h
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 00:28:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsSc-0003Hm-Ll
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJsSb-000704-Le
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:27:42 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:35686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJsSb-0006yu-DX
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 00:27:41 -0400
Received: by mail-vs1-xe44.google.com with SMTP id d8so1211825vsp.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 21:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Pfz0qdkaEyI+W1Eu5E+utI4tvcCFHA+IrY72v/Wqoec=;
	b=Nwa2NZp3tS0fV/yH6te1k1C6yDUdOuXDj35jdo0mS2Yqi5AnPUQyw49jY4BVZwzH3x
	reSZ8GM+EiFl3SUl2PJHqi5Yq6yLF98kM/ePv9zEGwwvZI41LacC01QEaGHjAwhMv+CX
	7iCKH0VWkQxjrAnlxZwph3SLVlhHxsIcRsgpgfmExqccNki5I/YMoqCFk95WLC2TCQza
	uDGTgQNYuWLfJvNJhKFdIAVXACS3MhJlXwlnIhth6L5sAOTY6DCw2CoeYyDjeT26yzt8
	MWaR9mT2KBJfw3eLlPQ1H2OYGiXLgm7jeKaa1U2jyP0wImPWAF7Hm7uAVnv4cstrIHzU
	IO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Pfz0qdkaEyI+W1Eu5E+utI4tvcCFHA+IrY72v/Wqoec=;
	b=p9NiYy5v6pj01BQNBFlGmg+4yHEFgPtGcvWD2nzkzaASfYi+stcy5M+/WON503g1uN
	unalv+2vVR84+cBEXBnLjzl5yJQ95nQV///vRUIsVAmX2vc1BdNaV2VFn5kIqO1LURwE
	VO9XIQAqqmmtXFQZ/Y3pIfEtbilDhwwJiEXL37CGmK3FOKth5iCuZkifB2TkodX1puZg
	RBE8ffZKUVInkzIpKXrrL4KolIaSFad3LDce81jt7Upvz5IXWICj6tb+AYNdvQqmwB+b
	0kbsbxiV+f+Uua1mHhGi9Y1b3N1/kWoYOhLKjLmUliRV7KFO9Hu6SEeUHxAg4jnXgrWt
	vtDw==
X-Gm-Message-State: APjAAAVBI7axGh/OECdANpQpDT73TA5kQsRmziau28wSltCWlF9LU6Se
	Y1I09VdZ63xCdQcf/H8373YwfYA9yiQau/yKb8g=
X-Google-Smtp-Source: APXvYqwtHRnOC5Sle9ISz1917C8wpvOtmzVVff9cgyAwMf2bT9TMJg4AgHoqfnH2+92XMOpIsZG7OfW4evcpI3XcVyc=
X-Received: by 2002:a67:da86:: with SMTP id w6mr12057429vsj.189.1556252860556; 
	Thu, 25 Apr 2019 21:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190424142714.28460-1-arilou@gmail.com>
	<87r29quo2x.fsf@zen.linaroharston>
In-Reply-To: <87r29quo2x.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Fri, 26 Apr 2019 07:27:28 +0300
Message-ID:
 <CAP7QCohTShnzDuao6YbtvH+51odyP7059rhBR08sDNDsPoP31Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e44
Subject: Re: [Qemu-devel] [PATCH v3 01/20] gdbstub: Add infrastructure to
 parse cmd packets
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426042728.aEK4EzpbyXJGyQMYiSXS4gTHTrHuvR1QLZSPjDne8w8@z>

Hi Alex,

Thank you for your comments I will add a cover-letter and update it
with the review changes, as for what I'm was hoping to add later on is
mostly
custom query commands for KVM perhaps might apply to other
architectures as well here are things i had mind:
1. Get VM nested state, this way you can get the correct VMCS12 if we
are in nested state
2. Read/Write MSR
3. Read/Write Control Registers
4. Read/Write physical memory
5. Search pattern in Physical memory

I did notice there are few custom things already in gdbstub one in
particular that I would have considered that needs to modified a bit
in order to be easier to parse is the 'F' command which is currently
used only for ARM to syscall cb, but that's a different topic

Thanks,
-- Jon.

On Thu, Apr 25, 2019 at 6:00 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> arilou@gmail.com writes:
>
> > From: Jon Doron <arilou@gmail.com>
> >
> > Signed-off-by: Jon Doron <arilou@gmail.com>
>
> Multi-patch series should have a cover letter:
>
>   https://wiki.qemu.org/index.php/Contribute/SubmitAPatch#Include_a_meani=
ngful_cover_letter
>
> Overall this looks like a nice improvement to the parsing code. Please
> CC me on the next revision.
>
> I'm still curious as to what additional commands you plan to implement
> once this is merged?
>
> --
> Alex Benn=C3=A9e

