Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97472145D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 19:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcHo/oAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97472145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQG5u-0002tI-3n
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 15:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58612 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQG57-0002Nm-F3
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:58:21 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQG56-00085i-PL
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:58:21 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42493)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQG56-00083R-8U
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 15:58:20 -0400
Received: by mail-ot1-x343.google.com with SMTP id m18so6218546otq.9
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2020 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8sgZNtHLVvuYw+5lDrqsN+Jm8FYYVijiJfjS9qHlDxA=;
 b=tcHo/oAdo+AaUr/nRWts65oNLNMeGWd5AIknQ0t3HEnEAdV4yG35Kk8yjSb3asyjWa
 iagFJhcl1bkDtx2phWa4bucjGe/x7IzojSIOvM8jTLUqVwfUMlExGIBFEXmlHGsx5Sdc
 CO+HdMvFiAxM+HfKBqJRXPupugrFmD8mF1GUWOmjS3x5pjlO0nrcT9m+kuxBgKZwxu7X
 pF4voaq7tIFkH+fvgSWGfwtka3hrMn/JXpnO+mXL+Heas4AHAfvarYypkXGnYplSyB7B
 zBpagAXgaVlLFQJ/KEQ38PyTCxL7tZBIdN1+sj+9XuQ5h1duPcpAy/N07H5U1wKe1S2b
 s9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8sgZNtHLVvuYw+5lDrqsN+Jm8FYYVijiJfjS9qHlDxA=;
 b=dIIvAPqFzhNfL5FtlmE7mRRBqEaGyKXC39LIc5dIAT7VsLX3IxRnqZMcydaAKvZUch
 gh2xu6uacJw23XZGPkqqgls8g9yzsyakP4l8jjkKmMkMmCbNmTi9aMcUb61F3blPK6ta
 rnERmWrn8YBjv0lwTjS6BLAQY0PdEgZq3owTrBocBa2AqMSzCFLdJ5UmwfmWGlfVIwoo
 L5C1askKoMVF80JJftHREiFNtaj544HgiVvQo9+hP7Nojl3v2OFgFbxVQ7NBdvQzqkeJ
 kk/qGKIT2JpubrHStXWDkfgI/QvE/qPmbBcmIYWx1Nsdm6I8KR5DNZSrPUcpUFGNkChA
 SF6g==
X-Gm-Message-State: AGi0PuZMVgAONoroiAzaArE7PrWDh4uxfUUXcY8bZnBgbIZb5wJZN9l4
 9hrHEaW1Rf7j3O4I5xplLPaQaLlYSdBT+UcekLi/4w==
X-Google-Smtp-Source: APiQypI8UIJka580eXEMW8htEkYmryhOVDrQrkv7Gcep4mnLZqyA9aHRQgiiEQiubaTRr7VBz+Gkb5XrWvUDV5JbomI=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr6978758otj.91.1587326298321; 
 Sun, 19 Apr 2020 12:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-2-philmd@redhat.com>
 <cb3178f1-5a0c-b11c-a012-c41beeb66cd2@linaro.org>
 <3dc0e645-05a5-938c-4277-38014e4a68a3@redhat.com>
 <f4ee109e-b6fc-8e1b-7110-41e045e58c30@redhat.com>
In-Reply-To: <f4ee109e-b6fc-8e1b-7110-41e045e58c30@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Apr 2020 20:58:07 +0100
Message-ID: <CAFEAcA8z5t__ZQQSqx88nMcC26SHowa3AjtDaQQFaPn-p-FYYQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/19] target/arm: Rename KVM set_feature() as
 kvm_set_feature()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs1p.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 19 Apr 2020 at 17:31, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 3/17/20 10:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 3/16/20 9:16 PM, Richard Henderson wrote:
> >> On 3/16/20 9:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> +++ b/target/arm/kvm32.c
> >>> @@ -22,7 +22,7 @@
> >>>   #include "internals.h"
> >>>   #include "qemu/log.h"
> >>> -static inline void set_feature(uint64_t *features, int feature)
> >>> +static inline void kvm_set_feature(uint64_t *features, int feature)
> >>
> >> Why, what's wrong with the existing name?
>
> Peter suggested the rename here:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg641931.html

In that message I suggest that if you move the set_feature()
function to cpu.h (which is included in lots of places) then
that is too generic a name to use for it. The function of
the same name here in kvm32.c is fine, because it's
'static inline' and only visible in this file, so the bar
for naming is lower. (In fact, it's a demonstration of why
you don't want a generic name like 'set_feature' in a widely
included header file.)

thanks
-- PMM

