Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361EEC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039BB21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlZ0TcpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039BB21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoOG9-0001zQ-Rs
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50522)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hoOF8-00063D-Fl
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hoOF6-00043C-CL
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:27:54 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:35460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hoOF6-00042U-80
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:27:52 -0400
Received: by mail-qt1-x843.google.com with SMTP id d23so30130192qto.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 01:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YeA7POpHAJICOwMJ5+K27gKtRH5vjLL2HbcCnHkwvas=;
 b=ZlZ0TcpQnZQ/PdO4r71znQJ3UKBmb16AIEPMprr+qAsNFUknzp+GBYyQDeX28w5UbS
 /UoUHN00WtjSM+RL8wZl5fuYT+A3dbVPMu+5AXoKuK9ACI6p52G0+bwEqqUzYbbB9XDA
 QMi5xjdWI1Ab1M2CMsqeg6w4LokFjSLGgTHDtBA5i7oI/CkKNPs1NTQUUG+t2iZ+cLWI
 LGr/v44L4dUtcGXC1QKFf649AYnaOOWdVqiO46kyxxhyyxKxNzAoB4s/u71Z7/moGaXV
 WMy8dtCm4/fvjFOKe15ZAmn/hLnA66DkmXmDWRqKjs4VtXb0JJz+g+ghXNot7mj7+1sl
 7ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YeA7POpHAJICOwMJ5+K27gKtRH5vjLL2HbcCnHkwvas=;
 b=aYHzs1HQJ3pZJ6i8asidLPmUy6XTf+10qGf8P/m8OtdV2BdFbEGPjt03MFfXlvtvrM
 kmL3lsDAXMOsaOR+B2AMYOxlUzQNO8aCY7Q68LEMpYrqUD9pqySJOcOHWCAk5pZlaPsI
 2JdLw1SFqdH7OyPXxIhFCiYCrOfWk1UcY4sjqY3swya26focatR4a+uAuaW0/0DJqZHV
 RU0ys3g0aRiGjxOYBt4HRDaGqj7cM2It1KqKEIiwsdvstCi53hf1io/hpraYokGPzKp2
 tS1lK2Tx1aYnR4foUv4OUSf8YvRm5/tV+wp5KAXTeyjxkIQRCRemn5NnMqxC4Q0QXKWO
 xrEw==
X-Gm-Message-State: APjAAAWnb923sL+PEkfhr5tzVVAtSNeId7pdw9gxaGslnmUijrCX1Bpn
 +hmpTiDN6pFgM2EyEJikX+kCe3cpFLOw9hyL6wM=
X-Google-Smtp-Source: APXvYqzk/SYpMJmUQ/9PI8bfP9Buy+fgq+5X/+7ml739xmnai5EixkxrX54UFYUpT3hMSoUTeJ9d8sjUJc/qWFs+z5I=
X-Received: by 2002:ac8:3a63:: with SMTP id w90mr36015023qte.371.1563524870593; 
 Fri, 19 Jul 2019 01:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190712053704.21228-1-mrolnik@gmail.com>
 <CAK4993h_VjHbg-BSbuH469fEZYy9zTz8Uh2o080vySNeopiHQQ@mail.gmail.com>
 <7c7dda7e-0a3a-dfb8-eae1-a4ae36c002cc@redhat.com>
In-Reply-To: <7c7dda7e-0a3a-dfb8-eae1-a4ae36c002cc@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 19 Jul 2019 11:27:14 +0300
Message-ID: <CAK4993gwAr19jS95mZv3RXMZ7N=hWxrT7DUXZrSSBK-8Qbwc-A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v26 0/7] QEMU AVR 8 bit cores
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil.

Thanks for explaining.

Tests are added.

On Thu, Jul 18, 2019 at 8:19 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Hi Michael,
>
> On 7/17/19 5:46 PM, Michael Rolnik wrote:
> > ping.
>
> QEMU is currently preparing for the next release (4.1) and we entered
> the "freezed" period where no new features are accepted.
>
> This does not mean people are not allowed to post new features to the
> list, but most volunteering reviewers will focus on bug-fixing patches
> and testing.
> (This is why I hadn't reply to your questions on v25).
>
> You can see the schedule here:
> https://wiki.qemu.org/Planning/4.1
>
> Meanwhile, could you have a look at adding a test for your work?
> (suggested in reply v24 cover).
>
> Cc'ing Yoshinori which series is in the same case than your.
>
> Regard,
>
> Phil.
>


--=20
Best Regards,
Michael Rolnik
