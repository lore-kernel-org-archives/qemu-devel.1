Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF8AC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B0020731
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 18:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKfqVmb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B0020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO3k2-0005I4-8g
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 14:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jO3jQ-0004t3-PN
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jO3jP-0006R2-Ky
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:22:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jO3jP-0006Q4-9D
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 14:22:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id j4so3431689otr.11
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ut6bOVECxYRHJs2ojrm+229SFdLK6A3hayjM4R1R+jE=;
 b=HKfqVmb/YMPC2XgwfCqwXlM7zA+HQMBCUqDZM5bsXQ2wBAMafEDK9VlY4O5r94ID5L
 9iF6K5a+3fdbtzTJ0/F+BtGhl0g1ukGQlfmmimQVl3PB0NFU2R0P8fLR/GnIcfLunlo4
 qkSkjDv47DG7Wa9M6wcX4nTNfuxwW17GG6Bj+aBLmPUCihj63Qczi4LQPOVrjXZfTAi6
 l65znvwwDco28vvgIKa3HJ/z1qIR38bAkuS3+Mw+FvuIbsD4QzP/p8hdSUEka9iBKC5f
 xuMuLTZN2I1Fs3dQ6Smjlnc0E/h//LhjHABAk/blQnEq3/PgYtdoTuAunfzWAJW1D5Qi
 RTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ut6bOVECxYRHJs2ojrm+229SFdLK6A3hayjM4R1R+jE=;
 b=RH5rcC3EVH/jqbbNiCkPs2UL7WDdaFVS3jUfEaX/bebNHZ5ted6JgVHT4+1IdAYII/
 CBRa1nllI31rOw1Yhv2BtCLPRn8M/QFe/U1XfQD+dQiJ68h+r/3MQ2QKPQy3X6qhtZNv
 0PMzAASQTX1vgnLjDyu4z9Y5Uak440pogS7GIWmDIBbXlzznPXuTCCriLeDCCKmNzvhQ
 Hwj057EOki7Z11tfMdhUEJR3icrE3oyX3a67GQKQAVga57C7LDPHl0KCwcgyykdSOt5h
 bzwtMLVV+dOuTCXh8AJl8EORR+yQt+1US8GXajrvCymrmRIjGB25qdnian7zJQoAjlQH
 bHRQ==
X-Gm-Message-State: AGi0PuZ5m1uqVF97MmZfL+CkqYctvUk7N+a6pyHsD6CiyUu8AgGKiMXW
 7uDYxtHUO0gdUxKZKoN13ZMaIwOZBgmxbb5i5ULf/Q==
X-Google-Smtp-Source: APiQypIpnGY3ihIoIHjJ6uBS4AKrseVaag3ay9Bw08zRpUik68dSik7A28tedwJr4jldd9iWyP/Ro+hesN4P+vL8oBU=
X-Received: by 2002:a4a:b241:: with SMTP id i1mr15287182ooo.64.1586802170292; 
 Mon, 13 Apr 2020 11:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <4873c74c-f590-62bf-bd64-dd5ab391c252@redhat.com>
In-Reply-To: <4873c74c-f590-62bf-bd64-dd5ab391c252@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2020 19:22:39 +0100
Message-ID: <CAFEAcA-Nuk8hnbtTrhtmSDroZugoEWheyh1N9E4jcAPikpPx9g@mail.gmail.com>
Subject: Re: Supported Sphinx Versions (was: Re: [PATCH for-5.0? 0/3] Make
 docs build work with Sphinx 3)
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Apr 2020 at 19:08, John Snow <jsnow@redhat.com> wrote:
> I was curious about our actual version compatibility, so I did some testing.

Thanks for doing the testing.

> 1.6.1 through 2.2.2 all appear to work just fine, but produce a lot of
> warnings about a coming incompatibility with Docutils > 0.16.

FWIW, I don't get this warning with the stock Ubuntu
1.6.7. The only time I did see it was when I'd managed
to accidentally install half of Sphinx 3 to my ~/.local
directory and I think it was the system Sphinx and an
upgraded docutils or some other weird combo.

> Conclusion:
>
> Required: >= 1.6.1
> Recommended: >= 2.3.0

I think that what we actually care about is the usual thing:
do we build OK with the version of sphinx-build shipped by
every distro on our support list?

thanks
-- PMM

