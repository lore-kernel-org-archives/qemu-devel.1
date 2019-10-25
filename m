Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E37FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB2B21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jezXd4Mv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB2B21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxGU-0001im-TT
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNx6q-0006Te-LX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNx6p-0004t2-5z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:46:20 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:39192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNx6n-0004sB-9x
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:46:19 -0400
Received: by mail-ot1-x334.google.com with SMTP id s22so1743018otr.6
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WGppmCpKS3dwHZsjVwAOeneLFq0wEm5HeaXQ9RYdWww=;
 b=jezXd4MveKc7sm/La/hW7yPTXUPvy+EYlEWcm/GzYF4eEM75vI9uwMaA4zd+nLSRoe
 c35FN2QVWxMA6cKOG6x4EooFWVlrviM2SAooasvVU8uOTwp24v5/5XEfE17u60/5wc0C
 MLTkmFoDqCYZQn7QiaGx+zB9UG/zWUGedaJfmvclhgTk+YuSnyBRFIykbpOZATAwFdi+
 AUYLDKIR8g800J+fM5eUZyFdH9ZMlxYpwbBhle535CHLb/ib1DVwfJ77kw23UltUB7AG
 khZOhT205ggUBQAbAazzGXt2Aqt57RYPREbNvTqV6YAjDFRono0lAGr6dp7dje9h+bBj
 MMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WGppmCpKS3dwHZsjVwAOeneLFq0wEm5HeaXQ9RYdWww=;
 b=G4QwdIvwbg0BAnNXgHkwSH62AIFiZ+nHOch8i6zs2/NoZqX5Qj61iK4CMKTWVvmmIO
 2VrIgO0x02HBgPy9Uu+QOdkmqJ7AUlk98VMJw4CKKPTaZ1Q/MhKkKmCmuwIVpp1asTMM
 CdtJqjP0oBniaA6mHiWmxjvjRx0wC9LwfTpohvK5hfsdqxHygb3p7GoIoZnD90yV4yLw
 OVrIAaOjmFtSBnLRCr3hWP7O8gVj22bw64x8dZ24yvWXtNHNGOhlZJ+DFV1KBWz8jEwG
 XHoROCF5mgJO1nahxN82t45ob4Pl/Vy2al1a1nKWb0K/0IHaOM80ja8rw1R8zXQHg8J3
 HxMQ==
X-Gm-Message-State: APjAAAUfIgWKLMWO2GpBOLEvSWdJyA/UpPU1Iv4lLS03+whi1/McvyxK
 AQ8prZJ3wu8WvWOJIc3oCbVTy2CvOehWcqlXfgpJ6w==
X-Google-Smtp-Source: APXvYqwRpYBGt8rBDr3xKsmcVJJN6sOWgsA+JEuiMZlVs6unNW3BYDJ3Lsr20URM4T+qV8gS1ulPzJpMoqfo7aLN/gg=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr704068otj.135.1572000376362; 
 Fri, 25 Oct 2019 03:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 11:46:05 +0100
Message-ID: <CAFEAcA-1gWa8qRK85i+MP-UixiPq7NPHw+8kn6KPq6VQMtRt4g@mail.gmail.com>
Subject: Re: [PULL 00/39] Misc (mostly x86) patches for 2019-10-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 15:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0=
b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-r=
equest' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a263f81cb4b302eb392898bdc4ad4381e1961629:
>
>   i386: implement IGNNE (2019-10-24 16:02:04 +0200)
>
> ----------------------------------------------------------------
> * Bulgarian translation update (Alexander)
> * RTC and PC refactorings (Herv=C3=A9, Philippe, Sergio)
> * RTC fix (Marcelo)
> * More comprehensive MCE logging (Mario)
> * x86 IGNNE implementation (Paolo)
> * Microvm machine type (Sergio)
> * Support for UMONITOR/UMWAIT/TPAUSE (Tao)
> * Do not use %m in common code (Thomas)
> * NoNonArchitecturalCoreSharing Hyper-V enlightenment (Vitaly)
> * getpagesize cleanups (Wei)
>

I got a link failure building the --disable-tcg config on x86-64:


  LINK    x86_64-softmmu/qemu-system-x86_64
hw/i386/pc_piix.o: In function `pc_init1':
/home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:216: undefined
reference to `x86_register_ferr_irq'
hw/i386/pc_q35.o: In function `pc_q35_init':
/home/petmay01/linaro/qemu-for-merges/hw/i386/pc_q35.c:264: undefined
reference to `x86_register_ferr_irq'
collect2: error: ld returned 1 exit status
Makefile:206: recipe for target 'qemu-system-x86_64' failed
make[1]: *** [qemu-system-x86_64] Error 1
Makefile:482: recipe for target 'x86_64-softmmu/all' failed
make: *** [x86_64-softmmu/all] Error 2
make: *** Waiting for unfinished jobs....
  LINK    i386-softmmu/qemu-system-i386
hw/i386/pc_piix.o: In function `pc_init1':
/home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:216: undefined
reference to `x86_register_ferr_irq'
hw/i386/pc_q35.o: In function `pc_q35_init':
/home/petmay01/linaro/qemu-for-merges/hw/i386/pc_q35.c:264: undefined
reference to `x86_register_ferr_irq'
collect2: error: ld returned 1 exit status


x86_register_ferr_irq() is defined in target/i386/fpu_helper.c,
which is only built if CONFIG_TCG, but the callers don't
seem to be similarly guarded and there's no stub fallback.

thanks
-- PMM

