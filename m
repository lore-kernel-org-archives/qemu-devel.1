Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CBC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB8722D2C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwEm9Mct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB8722D2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mtk-0003ey-Ta
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k8mpM-0006eD-1l
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:50:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k8mpJ-0003H6-Ku
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:50:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id t7so1845060otp.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1hHoa8Zhstwl+GX1djdWnX8Q/EMqOGBUg69hT7ehRLs=;
 b=bwEm9MctvyHW79yJuejOeUFDJqkjPELS1gm/cb3VUKHIzxD/fdxAXjH9WHXN9t8qtj
 cnvGuBv3gvdmvm4GUA2rg9zH0jcCoWbWzcLhulGJsVPgdi/Btse1GxEN20y1on7RAOlv
 az2wIvwY7NaDwPeV545lf34JPRZ5F/87wrJ1W8deL68D4IG31MVEYhPk1wOaMVQQoDPW
 Ue0MWUVQUJhPcJxf5uw7WRPWk249BKYH4NSH3Tts3e9EAoPin0hwVvMZGuKA6wF6Tw8z
 PvBdj+GlTWekMtzPvEAKKYcrOa/qzQzC1lN1v9OwyNLWfqC1QgZcNrQ2jUCOxNRm7X0F
 O+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1hHoa8Zhstwl+GX1djdWnX8Q/EMqOGBUg69hT7ehRLs=;
 b=q8GUmlZt+2gwsjHZ/2NtI7OODdzLL15s7lFgmvMW9fasvDi5day59X41jiP+GUjrvu
 w5NJF84MH3DVKmmbJkqD4giMojwXMgcrqqYl4Jl0DT38YyPMxi8YURtwPM1T+zpfbJer
 CPEUN9gJHSiZNvKM/mGhiiWRPw6KIqhXTxvcP/1UkedSXHwGDTb5ldVrAcq0Ij2BSfCs
 WfLrhwPdiN3NKfkfQ77poHaf9dW6NK1MioV2zY/pQXktMUlRVmkSlxsRwmlkGQcR66WQ
 AoTSYnBtXIoQR0X9dIEEnIW+Fqg4+oTqgeWfTWx6AnP4XFMtksgsUrNUBO29PwTK5iNx
 7SMA==
X-Gm-Message-State: AOAM531GdkxYbwwQxasnt+UkSmdzzbOvPq9yM8TXQMY8LihQ663MwKZD
 MHGk7Eha6K7GEseoiEQZRTAD8FddBeUY+UL7akU=
X-Google-Smtp-Source: ABdhPJy4hCAoc3LYRKsXHzN/APve0vGlbBMOCmSybZ0hnNFb0VG2v6BWm9XNdfapaur32ntmtGn7JiaDQf2EVAIciaY=
X-Received: by 2002:a9d:748e:: with SMTP id t14mr2479451otk.333.1597938603990; 
 Thu, 20 Aug 2020 08:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200819141533.66354-1-liq3ea@163.com>
 <a9fc6988-3561-5199-d2ff-6ea4892461a1@redhat.com>
In-Reply-To: <a9fc6988-3561-5199-d2ff-6ea4892461a1@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 20 Aug 2020 23:49:27 +0800
Message-ID: <CAKXe6S+DrOv3WUJw-F06pwbOavhRamROCr-T0z0aaJnmZ9HCBA@mail.gmail.com>
Subject: Re: [PATCH] qtest: add fuzz test case
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thomas Huth <thuth@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8820=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On 19/08/2020 16.15, Li Qiang wrote:
> > Currently the device fuzzer find a more and more issues.
> > For every fuzz case, we need not only the fixes but also
> > the coressponding test case. We can analysis the reproducer
> > for every case and find what happened in where and write
> > a beautiful test case. However the raw data of reproducer is not
> > friendly to analysis. It will take a very long time, even far more
> > than the fixes itself. So let's create a new file to hold all of
> > the fuzz test cases and just use the raw data to act as the test
> > case. This way nobody will be afraid of writing a test case for
> > the fuzz reproducer.
> >
> > This patch adds the issue LP#1878263 test case.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/qtest/Makefile.include |  2 ++
> >  tests/qtest/fuzz-test.c      | 45 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100644 tests/qtest/fuzz-test.c
> >
> > diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.includ=
e
> > index b0204e44f2..ff460179c5 100644
> > --- a/tests/qtest/Makefile.include
> > +++ b/tests/qtest/Makefile.include
> > @@ -7,6 +7,7 @@ check-qtest-generic-y +=3D machine-none-test
> >  check-qtest-generic-y +=3D qmp-test
> >  check-qtest-generic-y +=3D qmp-cmd-test
> >  check-qtest-generic-y +=3D qom-test
> > +check-qtest-generic-y +=3D fuzz-test
>
> I think this should go into check-qtest-i386-y instead ...
>
> > diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
> > new file mode 100644
> > index 0000000000..695c6dffb9
> > --- /dev/null
> > +++ b/tests/qtest/fuzz-test.c
> > @@ -0,0 +1,45 @@
> > +/*
> > + * QTest testcase for fuzz case
> > + *
> > + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "libqtest.h"
> > +
> > +/*
> > + * This used to trigger the assert in scsi_dma_complete
> > + * https://bugs.launchpad.net/qemu/+bug/1878263
> > + */
> > +static void test_megasas_zero_iov_cnt(void)
> > +{
> > +    QTestState *s;
> > +
> > +    s =3D qtest_init("-nographic -monitor none -serial none "
> > +                   "-M q35 -device megasas -device scsi-cd,drive=3Dnul=
l0 "
> > +                   "-blockdev driver=3Dnull-co,read-zeroes=3Don,node-n=
ame=3Dnull0");
>
> ... since you hard-coded -M q35 here.
>
> Alternatively, you need to check qtest_get_arch() for "i386" /  "x86_64"
> in the main() function.
>

Hi Thomas,
You're right. Anyway we write the northbridge. I just treat megasas as
a generic device but
forget this testcase is just for i386/x64 platform.


Will correct this in next revision.

Thanks,
Li Qiang

>  Thomas
>

