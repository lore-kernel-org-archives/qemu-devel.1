Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9920C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A501620714
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4Mo+m1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A501620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sTP-0005b7-R2
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 03:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sN0-0001jF-3g
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6sMx-0001JL-SM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:48:40 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6sMx-00018H-Jq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 03:48:39 -0500
Received: by mail-oi1-x241.google.com with SMTP id b18so2288436oie.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 00:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eHyZ+8Q0+T5PivPPaUzlhP1rP9BE4DHA1R8J+gyOeec=;
 b=A4Mo+m1inQCWtXXTb13EdfkhYo64odxSCmsFdnA1h3ymI0RFKiFWBI17mp5Zd4FgO5
 iZM4N3tO5Ssg/1uCBRxEbvQSJkmYDtBFZbgAi7fYsbZxD+JzLwiGIVh67mN3qHr1W1fa
 2aA81dgDhOqSiS8/0v/0+t719AhLpXTofM7MGwpkDbLFa/ciCe2ZE2kp/HuwIDMvkhhO
 VvnyoeFa1WsdJYzN4ggq0vRvqI98exQxlFgj56Sk6HUCNg7QKJ1U7RNyu6i2V+OU23YN
 TDeHIH0EyWcCx0rbm2+IZzsriHtvz5Co9DHVdphglVLz9RXno3QEb2nITtkQJG6T8XXX
 sNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eHyZ+8Q0+T5PivPPaUzlhP1rP9BE4DHA1R8J+gyOeec=;
 b=Ev5xXwKPMNvLb6sH0gvLT8Yrmew2JCt1VSfQDLsAlSw2kG1rDDkaNxXvXwSDeiJIP0
 8s8QWT2zCbOHNcG6bH7rDzevdvIUTF4JZnWo0lyWs76mxBM9WYOt9SV/lZloJ4Hg8yC+
 Cx0O76ICZMvj6e66qwpHyeQgl31EwUc6Tgmomrp2pXN/juFYxXeYmCSCAa1QRvayPBoS
 qmnrIwnLDdEG9YHsRAbKKKg6nyjcBtiOjmbxz+3PPIY+VnSrnEFu1qhcTOzb3o/002NB
 ltW9W/J5GzvVvhnIWqZoaYUBJdtVQMJNtTZSBmmzxjnoOMCaC1vf6uhlQwCqQMfTjDD9
 hFNA==
X-Gm-Message-State: APjAAAWdArx7L9pkHBRc/eLy1Xt9p4vGE38P2fYoPHstFr4LusXqeppR
 W4XSZc6cNnkFjtrKwgEYHcFGRUDl5TOsAoT2Qd7h+A==
X-Google-Smtp-Source: APXvYqygc8M579zHaRXI6AHr9qpTz7uXwSazma0BBFUyX5jNfDr3FBQNIgwzVXI+dEERoRTPqDIaBwAu8demOAfZ2ZU=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2124442oie.146.1582706917559; 
 Wed, 26 Feb 2020 00:48:37 -0800 (PST)
MIME-Version: 1.0
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <CAFEAcA_azGqyzbxegpK8ch_bums6Wtd=U7cNxvM=bAJ-Ld2DDA@mail.gmail.com>
 <ffa87cab-e85c-c381-289a-fdf1ef07b45a@redhat.com>
In-Reply-To: <ffa87cab-e85c-c381-289a-fdf1ef07b45a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2020 08:48:26 +0000
Message-ID: <CAFEAcA-32ddJW0ULWzGDDwLcvPGnXOatRHy73Agh0NRajfnRCQ@mail.gmail.com>
Subject: Re: Sudden slowdown of ARM emulation in master
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 08:44, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/26/20 9:41 AM, Peter Maydell wrote:
> > On Tue, 25 Feb 2020 at 23:08, Niek Linnenbank <nieklinnenbank@gmail.com=
> wrote:
> >
> >> Just now I was working on some small fixes for the cubieboard machine =
and rebasing my Allwinner H3 branches.
> >> While doing some testing, I noticed that suddenly the machines were mu=
ch slower than before.
> >> I only see this happening when I rebase to this commit:
> >>     ca6155c0f2bd39b4b4162533be401c98bd960820 ("Merge tag 'patchew/2020=
0219160953.13771-1-imammedo@redhat.com' of https://github.com/patchew-proje=
ct/qemu into HEAD")
> >
> > Yeah, I noticed a slowdown yesterday as well, but haven't tracked it do=
wn
> > as yet. The first thing would be to do a git bisect to try to narrow
> > down what commit caused it.
>
> My guess: biggest chunk of memory is the DRAM, registered as "fast RAM"
> by QEMU, but the SoCs provide SRAM which is supposed to be faster. Not
> anymore with QEMU. And Linux try to use the SRAM when possible.

Doesn't sound very likely to me: generally Linux doesn't use random small
lumps of SRAM, it just goes for whatever the dtb says is the main RAM,
usually DRAM. And I thought that all RAM blocks within QEMU performed
the same?

From the commit that Howard tracked down as the cause it looks like
an ordering-of-actions issue in vl.c where something that was assuming
memory-size-related stuff was set up is now running before those
variables/fields are set correctly rather than after ?

thanks
-- PMM

