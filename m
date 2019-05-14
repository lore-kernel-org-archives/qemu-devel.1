Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E50C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D27205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD3719aD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D27205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQa5O-000682-A7
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:15:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hQZw4-0007QH-Nj
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hQZw1-0003ja-AT
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:05:46 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:37449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hQZw0-0003dT-VE
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:05:45 -0400
Received: by mail-ot1-x32c.google.com with SMTP id r10so15004163otd.4
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=g815QicO24Zdcg/B1B8l8URqFo+173B68O7KxeY5SW4=;
	b=dD3719aDWh7FNNOqIhW4HWlXHxtWycjSij9AtHJf5TKFrupjgTfSDs7R+ShE+Rp67Z
	cYpYmMAnmJWxc6U5MugQT4TAG7yRyugZCdau5U9TSmIQifcQeJ/X8tpol5wJBkpcM7Y0
	lT1C/mcDP0ejEUX6Pe4MRbqfreqxTQd0LFqut8nTfYZdBfmiVBlV5xBASx+iOfePnVJ1
	QxRSs0lMFsr2aQPqQzxqLWPYvcZev2swLiEYm+2XDngrLDos+aELeFFIB01RteMJRbCG
	e44D2cp4WuQsATuuhJ9FWRiwE+mQbQj/HzawEJ0xmilAnS3817YrBI33am0ZrfAijDAU
	PGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=g815QicO24Zdcg/B1B8l8URqFo+173B68O7KxeY5SW4=;
	b=Uyob49+MHUgxJNRUUxQjRGpkdaiLVWYfrCHvrWU/vpgTni6EvmvW9WHuu07aLT66Ii
	ZKBuRh55EEVrSwUaV1TIhKPYawkl4qbg2+EeGJxw2Cs1QqoYFwKM6koj6ecIL6AiCN9K
	hPMNnzw1cOillN1ULWSzY/3fa0EQggbedKYcyyhmuRxQHRouO3/v4aEIO16V6A+kNVdg
	rc6VmBqvjZc2/i1+DThMZc4IFKvSLi3jbTLnqfF/7rSl1c/XqccsjADGLDx0lANA4Tmf
	w8i11GB1+EbbjvXZdvZuHaQk35cxaNZaGuasi82OAMOoorz7cvvcbqysg/fbV2hq8YNp
	dlAQ==
X-Gm-Message-State: APjAAAUWt/KZTmbwU+I6ukz6Uc9j6LOwj7F5EqaFiX60CVNN0HVUnL4L
	jk3biQvOmWkJWG+zLKhXE+ZtWn7ZKuWKZrj1jEw=
X-Google-Smtp-Source: APXvYqxOWTZn/vWqRTrGzW6g2Cyrh9IHPfoZyqWmRAl48R1GZ15xFilJkNQ+9b1DImRPQRMjXTVnFvz9Xn6IFi0CgGY=
X-Received: by 2002:a9d:400d:: with SMTP id m13mr1277481ote.100.1557849941335; 
	Tue, 14 May 2019 09:05:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Tue, 14 May 2019 09:05:40
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Tue, 14 May 2019 09:05:40
	-0700 (PDT)
In-Reply-To: <CAFEAcA-sN6BzQywHUssQqdaiTdSNNS5thnV1VHbKqB2k8K_7-A@mail.gmail.com>
References: <20190510185438.29533-1-richard.henderson@linaro.org>
	<20190510185438.29533-4-richard.henderson@linaro.org>
	<CAL1e-=hRXg7eykwjDxTDXt33FiFOAkkGQk23mEZRB3ChaZcAQA@mail.gmail.com>
	<CAFEAcA-sN6BzQywHUssQqdaiTdSNNS5thnV1VHbKqB2k8K_7-A@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 14 May 2019 18:05:40 +0200
Message-ID: <CAL1e-=j5EB=Y+3Lc=_bxs4+sEOSZ7pEWFpSzdozz87q7DOs8NA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL v2 12/27] target/mips: Convert to
 CPUClass::tlb_fill
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 14, 2019 5:26 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On Sat, 11 May 2019 at 14:43, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> > This commit message is generally poor, as it explains relatively
unimportant logging issue, while not explaining the core of the change.
>
> I think the assumption with this sort of "refactor to change
> all instances of an API" change is that you will go and
> look at the commit message (or cover letter for the patch
> series) that introduces the new API; there's no great need
> to repeat the same justification for every commit that
> applies the refactoring to each of our dozen or more
> guest front-ends.
>
> I'm not sure that wordsmithing a commit message really
> justifies rerolling this pull request at this point.
>
> thanks
> -- PMM

Peter, hi.

Thanks for your engaging in the discussion!

I am not complaining about myself looking at another commit message, but
have future maintainers and future developers in mind. Their effort needed
for deciphering commit messages like this one is multiple times larger than
putting together a clear, full, and right-on-the-money message by the
submitter. The commit messages should be made convenient for their readers,
not writters, shouldn't they?

That being said, I tend to accept your judgement, and I withdraw any
request for changing elements of this pull request. Please go ahead with
integrating it, and thanks again for involving in this issue, and sorry for
taking your time.

Sincerely,
Aleksandar
