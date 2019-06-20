Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35866C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 042182080C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 12:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvMCRiLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042182080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdvr5-0006n4-9w
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 08:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hsp.cat7@gmail.com>) id 1hdvbl-0002Vp-S6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1hdvbd-0000om-OD
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:51:59 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45777)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1hdvbd-0000m5-Da
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 07:51:53 -0400
Received: by mail-ot1-x343.google.com with SMTP id x21so2387226otq.12
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2019 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ksHVkaNUQ7RvR0uQvMVK7teyV1dMzqs0PiiBRxP5ovk=;
 b=JvMCRiLLmve9rqOnlNNI/Il0NXgx/ye3KR32UeVEUOEnSpszzaLbJ2miABIq6XVOun
 r+Q2y9SaSNlDwnDd5Fq0Qgnqv3pDZAgk2mZcJmUBEREG2Koe05tsiaWwi/OZBrB4//f2
 NIlmcaZxYX0Xlbx0SHfp04InrRJYv4rhRVvvK80BX0tuDMjej2uOKupp8GImNn8WQ3Y1
 wDkwsHXKR8+JtyiXndXGhC5PeR89a1estG+T5PMVUmiehWlGInEwMf5BN0P9TkEjSmqD
 OEzJ4OJXGwdJ8I9dxCj+ldlwgZoOWmOJuRAJ20O7vC/Dh7AT3oI0WNeCqhUhcZ9AEUdR
 OdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ksHVkaNUQ7RvR0uQvMVK7teyV1dMzqs0PiiBRxP5ovk=;
 b=WtLhJ/Rv2WpAzg81tsKF0ZqVv24z+5gU/m46+Ml9sTdH2y49I4/FYtXMU/VqBDOkFP
 bH247EnXO92yPhkDC933jA5HF4+e/6k+00p6Seckhy1admbPFqxxdYtl/EcbWvZ4GI9C
 6Pfwr2gyGk4rgPYdd8jjp7Cgsp0TQV2olbLsJ2qths5/2zF4xCxs+RzwLqiMcR8h7vGT
 UQptQw/xJX7itKzTxcO/NL38mlhKrK0wnuuYb+jmjjdnSt/ZQG9azLysvIJ6HMiKFW24
 xFKLrzSlq/Ud22bQM+/pzExmo2hZhAIVhKkXHe45m6H+dWJs2RUmG7NB0/sZ3sZfz8qP
 fKfQ==
X-Gm-Message-State: APjAAAV2kxm67re5d0w4cedoZhO02gvZZ0OQwLp5EidscWcFMq/vUBon
 R9oo8AG91ahReezxMxR+wnGhwuBmevxAxzf/Dl0=
X-Google-Smtp-Source: APXvYqx63/Au0VWu5QA4d5fEbgKiU0ZA8rb74bkPEyg057O3wf2rsJzANgZyytjGkvHst/vdkpGuACJepdemyhn1Aug=
X-Received: by 2002:a9d:5787:: with SMTP id q7mr39544299oth.75.1561031511112; 
 Thu, 20 Jun 2019 04:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
In-Reply-To: <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 20 Jun 2019 13:51:35 +0200
Message-ID: <CABLmASEKLJfNURTwYTkC+ZenN03Mv1Ao3jMkeKAfChRWe-CWGg@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As reported before, qemu-system-ppc still crashes with a segmentation fault
on Lubuntu 16 on a G5. Built from current tcg-ppc-vsx branch.

Linux hsp-G5-Lubuntu 4.4.0-143-powerpc64-smp #169-Ubuntu SMP Thu Feb 7
08:25:49 UTC 2019 ppc64 ppc64 ppc64 GNU/Linux

hsp@hsp-G5-Lubuntu:~$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc/powerpc-linux-gnu/5/lto-wrapper
Target: powerpc-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Ubuntu
5.4.0-6ubuntu1~16.04.11'
--with-bugurl=file:///usr/share/doc/gcc-5/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++ --prefix=/usr
--program-suffix=-5 --enable-shared --enable-linker-build-id
--libexecdir=/usr/lib --without-included-gettext --enable-threads=posix
--libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-libitm --disable-libquadmath --enable-plugin --with-system-zlib
--disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.5.0-gcj-5-powerpc/jre
--enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-5-powerpc
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-5-powerpc
--with-arch-directory=ppc --with-ecj-jar=/usr/share/java/eclipse-ecj.jar
--enable-objc-gc --enable-secureplt --disable-softfloat
--with-cpu=default32 --disable-softfloat
--enable-targets=powerpc-linux,powerpc64-linux --enable-multiarch
--disable-werror --with-long-double-128 --enable-multilib
--enable-checking=release --build=powerpc-linux-gnu
--host=powerpc-linux-gnu --target=powerpc-linux-gnu
Thread model: posix
gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.11)
<https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06561.html>

Best,
Howard.
