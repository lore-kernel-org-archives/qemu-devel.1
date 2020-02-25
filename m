Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35727C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0613220CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvmjF/YK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0613220CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cw2-00013h-8d
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6ctN-0007Sm-0d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6ctI-00047S-5A
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:17:04 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6ctH-00046M-V0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:17:00 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so32682oty.6
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 08:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hlv8glY/nETgRGQM3JrX7U+aqQLACOo8EtOJKWLyg2o=;
 b=pvmjF/YK/Llxj+KwQTKvFsDg33CBSxEkGh+RZmGNIHEKerUVTdAvcuUFYvXqpYL9+r
 lTArS0BYMJ/EA5azo0fl3vcMyZcK+zSUb7g+j1ySKdseWpQlcvmWlz8CF3iueT4dgByv
 807h3wLRfTDkU81vYKTM06rHLWXODWUPSfjOUmFuhu541V6ArRppRXhXBOXfUrvUCnPq
 Mpt8rUP4A3TJnwG7gAqUvU7ctZexojhvKWMY66MgVU0qMeIYIlKxrC9qeaj3b0aAbwEv
 f+Zj+t0k03vMYQz8Gr8tuY3cXljzjhe1UqtEO6T74nigH8FDdpJT7UfibHPu/3YIEfcX
 gQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hlv8glY/nETgRGQM3JrX7U+aqQLACOo8EtOJKWLyg2o=;
 b=pVU99Wts+yEv9Dzhfoj4Mdo+N2TjrDAN/aIGbkRWDtTAfXrVL4mP5qN6tgm7wxfoJD
 5Shfrl5kxvlyIzPMdJT4VzGMD48CnnyjUz1/4UJIX2GZlQA9HHqkxqyHoDIB5j/x6W8v
 sZvn/dP2NrxxZWLuU8mhS8AO44Vd4daoce7P62WHuFSp8fuZTiqLhxINoKUDj76ldacp
 LVCYIZDBHY2njQDifJ9NePsJOVw4DxD766nXgICv0Ph/ad2nkn4nxDKM1P1Uh9yIpWRZ
 4ZE0QAQZORKcTvtKT2aVrOH4ybMpBujRySAFXN7yI1hGYr4qzHy2yQSxDhxMG38D9sw+
 VZFg==
X-Gm-Message-State: APjAAAXC+ODVqOee8tHBySmEg18C8dLm85+kUpyNhVn9T9K2fch+I1x9
 L3Cc/mdkbR6tyg0ftyOUN65kKjhoZYsEJBCewYrtVqAe
X-Google-Smtp-Source: APXvYqwrQZAseC96mjkcu4WFviym/5+i8KWdLsn7ZJyRU6pF2+Hzhyqk2VMhlES5mY819yutsnfzMFQTlFmo0u79KhE=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr42364907otq.97.1582647415115; 
 Tue, 25 Feb 2020 08:16:55 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nreUP-zW2pJaH7tWSHHQn7WWeUDoeH_HM99wysgOHANXw@mail.gmail.com>
In-Reply-To: <CAM2K0nreUP-zW2pJaH7tWSHHQn7WWeUDoeH_HM99wysgOHANXw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 16:16:43 +0000
Message-ID: <CAFEAcA84xCMzUNfYNBNR8ShA58aor_rbYTq7jnmsLQqhvbOH8w@mail.gmail.com>
Subject: Re: Problem with virtual to physical memory translation when KVM is
 enabled.
To: Wayne Li <waynli329@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm-devel <kvm@vger.kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 16:10, Wayne Li <waynli329@gmail.com> wrote:
> So what could be causing this problem?  I=E2=80=99m guessing it has somet=
hing
> to do with the translation lookaside buffers (TLBs)?  But the
> translation between virtual and physical memory clearly works when KVM
> isn=E2=80=99t enabled.  So what could cause this to stop working when KVM=
 is
> enabled?

When you're not using KVM, virtual-to-physical lookups are
done using QEMU's emulation code that emulates the MMU.
When you are using KVM, virtual-to-physical lookups
are done entirely using the host CPU (except for corner
cases like when we come out of the kernel and the user
does things with the gdb debug stub). So all the page
tables and other guest setup of the MMU had better match
what the host CPU expects. (I don't know how big the
differences between e5500 and e6500 MMU are or whether
the PPC architecture/KVM supports emulating the one on
the other: some PPC expert will probably be able to tell you.)

thanks
-- PMM

