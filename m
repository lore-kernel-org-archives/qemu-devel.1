Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E38C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5691920896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 12:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdx1q7CR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5691920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hagLz-0003Iy-IQ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 08:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44358)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hagJ3-0000uV-DB
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hagFQ-0004gO-K7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:51:33 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:34787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hagFQ-0004fC-8Z
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 08:51:32 -0400
Received: by mail-ot1-x32e.google.com with SMTP id z24so11744318oto.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 05:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GCQlJ2M8c6maQ7vm+59ZkK7GHwN+0KycSdz8wN8Te8M=;
 b=tdx1q7CRSbSgGVkIj4B+ELCXZv6aJSKoG+a+eYucRq2E+xjbG337qnnqOnxyp+WzE8
 nW/1GVjgefkd1buAWa0NQ6HdizwI1rnc8GVmugK1A4u048tT1Wq/nOZw5N2nlBc9qWGq
 5tjtZUyA+NEtEOLPBZwC55qUrrUxInaaToLSgdUcAcjL0CFsXiYh+1uavCrGIbOgr5en
 /cn54nfatBwQ3xmytRF9Zw/gsdrgG6wlEFmEr0PGpIeJREi6PbIamDOWqFywfERtrBbQ
 uSqVdW2nFhSsxUUSfuzkyFMsJILUmeH0r7IHuy60Qssjl1oXuZYLju7Kp9WLIeBU7yGe
 xT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GCQlJ2M8c6maQ7vm+59ZkK7GHwN+0KycSdz8wN8Te8M=;
 b=kJw+yyxR2DZ7/2gOVKkpQWeFJpO5gtQtF2amFipDi6VGBy/OX/WxyUyfzmyt8OW9dp
 FcK2lM7/bousHzDhrJo2/LHPkgLbVcNtj6mmnZtfmZB8Bcgug+2MZxZNRM/UouaLSz76
 AQoxMAb2oHqsZevpR/7cf/r4UdT/K/Ud6WGcNFxcfkBJ20E6rCUU7z4brW6k+0wEPLCf
 8c4tlraNRzt/QMiLGPdpB0YJqTa4njI2El5BwpK3cpwsfpM1fRL+vVlf/eYNZJpBpXzL
 WFQ+AyFGqI2X0cMYcpSjtfVXfdUrPRAUXblbEXqJRDmsKkySpC7KfGDDNO1V3kuYFo43
 K4bg==
X-Gm-Message-State: APjAAAVf3mCFs1SyO1DYqazEh6/GRcBkDRIzjYun5Vpyv5ag8Mb8l61Y
 fEhrfakPGM2XXuoBfuwHAsNabCMs53jUeQIDQXIfTw==
X-Google-Smtp-Source: APXvYqyGj9b4F/2QUMRp0wU4AleYkAmx0IQhWwa4GLBpHkQvlTT9GqeU7tUhPjtwqbwX01346KV7ybPW7jr158mQQ/Y=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr33557770oti.221.1560257488959; 
 Tue, 11 Jun 2019 05:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190312170931.25013-1-alex.bennee@linaro.org>
 <20190312170931.25013-15-alex.bennee@linaro.org>
In-Reply-To: <20190312170931.25013-15-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2019 13:51:17 +0100
Message-ID: <CAFEAcA_bSC4xmFPqe9LP1yh_5y3CrK5mq+-+zLzHQwHBWgVgMw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 14/26] tests/tcg/arm: add ARMv6-M UNDEFINED
 32-bit instruction test
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Mar 2019 at 17:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Test that 32-bit instructions declared UNDEFINED in the ARMv6-M
> Reference Manual really do raise an exception.  Also test that the 6
> 32-bit instructions defined in the ARMv6-M Reference Manual do not raise
> an exception.
>
> Based-on: <20181029194519.15628-1-stefanha@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20181129185113.30353-1-stefanha@redhat.com>
> [AJB: integrated into system tests]
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

So I just tried running this test with a QEMU built with
clang's undefined-behaviour sanitizer, and it reveals a bug
in our elf loader code:

e104462:bionic:qemu$ make -C build/arm-clang/ check-tcg
make: Entering directory
'/home/petmay01/linaro/qemu-from-laptop/qemu/build/arm-clang'
make[1]: Entering directory '/home/petmay01/linaro/qemu-from-laptop/qemu/sl=
irp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/petmay01/linaro/qemu-from-laptop/qemu/sli=
rp'
  BUILD   debian9
  BUILD   debian-armhf-cross
  BUILD   TCG tests for arm-softmmu
  BUILD   arm guest-tests with arm-linux-gnueabihf-gcc
  RUN     TCG tests for arm-softmmu
  BUILD   arm guest-tests with arm-linux-gnueabihf-gcc
  RUN     tests for arm
  TEST    test-armv6m-undef on arm
/home/petmay01/linaro/qemu-from-laptop/qemu/include/hw/elf_ops.h:175:11:
runtime error: null pointer passed as argument 1, which is declared to
never be null
/usr/include/stdlib.h:828:30: note: nonnull attribute specified here
[...]

I think what's happening here is that the ELF file being
loaded has no function symbols, so in the load_symbols
function nsyms is 0, and g_realloc(syms, nsyms * sizeof(*syms))
returns NULL. We then pass that to qsort(), which is bad
because qsort() mandates a non-NULL pointer.

thanks
-- PMM

