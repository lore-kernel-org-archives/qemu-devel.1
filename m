Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402E9C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F7E20828
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBMSdccS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F7E20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99bo-0007Y5-7l
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j99av-0006bQ-SF
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j99au-0002jN-Fc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:36:29 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b]:42242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j99au-0002jG-Ba
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:36:28 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id e7so1835272qvy.9
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 07:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VqTf3Nf4MEQR51S2SvInzv4nbP2J7g8HrU04vUQNcAU=;
 b=YBMSdccSQPwJ07hQhy+CF5cXeCFlUamUDaVmWhpvw2rt9098l8toKTjX2wspq3i7br
 +jJBvUmLesiagf4Y/y8rAODGL1rF2l0UP95ltTTCmzaPhEdLPXUUvBlksFn+/3yrinIn
 sR5EGQOMjy4XaOj1ijy1ZUQuHoKpK81mGBVUJmxgHSQKfa+Pj1kPBvSPyaiQrJOpRX8c
 IWo5lDO9cO39AGLRbOwgjdk16o3hl5Gy9dNyzrqGWG05r9T/GD7eqfcWjHmDO1Xk2N47
 oEoNs0n27sqdVdJjK3m317AWgg5DSm6BiVEn6cYbJnoDAN9qV4GMq1FOyBTynhj8JzbM
 WWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VqTf3Nf4MEQR51S2SvInzv4nbP2J7g8HrU04vUQNcAU=;
 b=gnlZUR5fjv5Cm4q8LXjaLhxalKY4qy2x5P6xfDbD/9u2fHm4jc9DZjZoTj/rag8zU6
 H5ZFkxiUdXLVt/epGLRowbhTwY0SBaLkDBAK4Mtz8pOFBmj+0+uqJ6NfkvewEt4SZDd6
 Zd1f35HfLPAVTtM1CQRgh1YAIkBuQ5dP6f7IO+uG0om0WBlQUIOuUBpU7XLfa0tDF5iD
 4uIMtO0Jd+EDY2Y0d5jcNJ9pUH8tpm6AGIBpMFngKUOOek8U6KVKBbC9yJkJDMqpj6i2
 tPT/tZnwHd7tUZdQmWSgEtjj3Ckm9gWmDQ3W+TyOtC35PoAdJF/qz7jvHR6Ye//sKsEN
 bCtQ==
X-Gm-Message-State: ANhLgQ2k0/TU2s4tVut+Ko01vgluFXfPlckmk57NLkc/XY0aWFhf46U8
 EhPdJnQfIR4co0GRvlcrl0gEEOgbUKvjBfs+oNI=
X-Google-Smtp-Source: ADFU+vtVHCXhLPC/RPieogKzM744j7HNm/xikn0DHI1CO8BtvHD+lHxGT4fN3A8Bj702Q17vHSYspTXw08agxSQVOkg=
X-Received: by 2002:ad4:4a69:: with SMTP id cn9mr4613878qvb.218.1583249787843; 
 Tue, 03 Mar 2020 07:36:27 -0800 (PST)
MIME-Version: 1.0
References: <CAPV47zf2Bz1xNTcD_1M=hf7tyVnCYh8yLagN=r8ocgrz2GT2Hw@mail.gmail.com>
 <20200302173604.GB682016@stefanha-x1.localdomain>
 <CAPV47zdPz+Z5=bOFNGjTG8nEWgH4gb78_AE3SGU0TD_7TNmSLw@mail.gmail.com>
 <CAJSP0QXd9fhz45OdA190XizdiwYF84UzHhD7QQVdzh9293iH9A@mail.gmail.com>
 <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
In-Reply-To: <CAPV47zdueruup1R0yCv9adLSTJTF-qmZiUotyL3G7udL732AuQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Mar 2020 15:36:16 +0000
Message-ID: <CAJSP0QW2ooLK_0Hr52h8HYdmm2j6CunTAnhFxS3De=azMutUeA@mail.gmail.com>
Subject: Re: New Hardware model emulation
To: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f2b
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

On Tue, Mar 3, 2020 at 12:45 PM Priyamvad Acharya
<priyamvad.agnisys@gmail.com> wrote:
> Thanks Stefan for explaining the method.
> After following above method when I run below command to compile my custom device in Qemu source code , I get the output on terminal which is attached in a file for your reference.
>
> Command:- make -j8 -C build
>
> Most of the lines in attached file indicate that error might be due to helper.c file.
>
> How to resolve it?

These errors are probably due to the Makefile.objs changes in your commit:
https://github.com/PriyamvadAcharya/virtual_prototype_qemu/commit/4c71c2759a96cf1db83a74027b93c6ceeab24bf1#diff-a8f0482bb5eda5c20e2054e1b1d263f2

Stefan

