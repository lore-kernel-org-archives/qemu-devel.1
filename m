Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F6EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240E120709
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUgsZUki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240E120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9S4C-00088V-CL
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 06:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j9S3N-0007Ys-7R
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j9S3M-0001Jt-Ef
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:19:05 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e]:33952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j9S3M-0001Ji-BJ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 06:19:04 -0500
Received: by mail-qk1-x72e.google.com with SMTP id f3so1154183qkh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 03:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4LafxeiKiKXuO+ibdcGqlpvlsmYac8k7S7UN1+XhUP4=;
 b=kUgsZUkiQ5IA/Wwm11B03XmSwLbKG1wZxkOP4eUGTp6xg8R1uWhnVXx0mux2HbNe3a
 DVICMk/PmhyJMD3r4iWRjLdMPbTxKb+ZrgiNtBQm2jGqw/OlKUHh2LChPIjd/Z7LPKcE
 zvlnZJadOjgqHvnXkto+TYpiZirZLjoHoaZeDV7MAgM3dI9YVjgb1Rh31HD35za7WV2h
 fj4W3IJym/EKRNGm9SlHe6wbhU0t9KINMn9hhf7CG4QCVNyM0XNXlBWCZ3xod85r0CCl
 i/fseFOW4f+UTq8vi8HaGvF3vHwXZ/vqLyrP1WmiW3JQQPy8ykl1iJ5UFAChvqG2tGZ1
 Cxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4LafxeiKiKXuO+ibdcGqlpvlsmYac8k7S7UN1+XhUP4=;
 b=b0TBHkARSoqfUGC/NdE0zbkHD8fNrXe6l9vqkNr8p0p1EOaa2KEzmekmrINlDZ7aT2
 xqRfMz7Kny+3yBkKSUwLmBw9z4kjY6suDiyQ93LwgAIVnyDUpjFet3ogBbImsi4jvmL7
 BF96wPjEHG8g+fZmZJqEiTv1h/ltVGwXMAzfbBFF7KtRNuY8llAQqa4WMXeVwEvAHlSw
 MOtAXVG9VVmkxyfl+dkT4KpeSwLF4OQND9hc3e35in76Qy2QwMWRyU0ff9ie7JPSG44Z
 OI02961f1H5fVm8InJ1M1lkLBqCl9wKjWskw3iTw1Ug9rsJr7hYNH/6L6koiOYM+Coib
 YHqg==
X-Gm-Message-State: ANhLgQ2A1TtH06AXaUeCbVsCxo8+dBm1S3K/4qYRCH1WefCTfJLes5ca
 gCuD7ikCgSS/B3WxHT894w/PKvbFjHVtvb5s9Ek=
X-Google-Smtp-Source: ADFU+vvElR6yJm6XR4sJC+qFzgjafsik4HbdYvDVprVoGd8VSC03j/i3bhvIm7BhFDZEzZp7bZj2dtOATR8s7p8Irqg=
X-Received: by 2002:a37:2c84:: with SMTP id s126mr2475475qkh.370.1583320743763; 
 Wed, 04 Mar 2020 03:19:03 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
 <CAJSP0QW2ooLK_0Hr52h8HYdmm2j6CunTAnhFxS3De=azMutUeA@mail.gmail.com>
 <CAPV47zc6R1fX_RrEzLQkQuRtjKK87HNtmkgnxazZGOESGERwxw@mail.gmail.com>
 <CAJSP0QUoqdRiQp6zCWpsPQ_iM4K-BgAFCDoqU4ca0dafd3-rNw@mail.gmail.com>
 <CAPV47zd19obqLMFKeOhvaD9AbThyii_QqtHSHE57YxLW7_8JEQ@mail.gmail.com>
In-Reply-To: <CAPV47zd19obqLMFKeOhvaD9AbThyii_QqtHSHE57YxLW7_8JEQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 4 Mar 2020 11:18:52 +0000
Message-ID: <CAJSP0QVwO_n9_PRzwK9KU5+=zexFByHUAW8ptTG4Sz+F5L6kLg@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72e
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 4, 2020 at 11:16 AM Priyamvad Acharya
<priyamvad.agnisys@gmail.com> wrote:
> I have commented all the lines of other hardware models except custom device line " common-obj-$(CONFIG_TESTPCI) += testpci.o ".
> But when I run make I get errors  similar to error shown in file which I have shared with you in previous replies.

Try this:
1. Start with a fresh qemu.git tree (no modifications) and check that
it compiles successfully.
2. Add testpci.c and add the testpci.o line to Makefile.objs.
3. Compilation should succeed now.

Stefan

