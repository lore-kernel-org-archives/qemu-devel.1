Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A9C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F695217F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zcr6bKTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F695217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47903 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9m1-0006r3-Vu
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:57:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP9ZX-0004CW-QE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP9ZW-0006Cu-N2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:44:39 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:40285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP9ZW-0006C2-HQ
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:44:38 -0400
Received: by mail-oi1-x236.google.com with SMTP id r136so5123717oie.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=J6m34n5ZlWSG9kxB2vm7Nyqy5zXyKFTaogKuNOdHcRQ=;
	b=Zcr6bKTwunoCBp6BA+ELEQqGHDg53JI0LT/7vgwnaToMz+jW4bKwWr8FMpzZohYytv
	FrJeZv/i77X4fvZmhaHC5ueqpiIig0y9vGov62oTFwMaqVwBl6Ba/E0OH0t0l+1TtQoF
	aLrNg1WX/pDu8Pyqz/13vtd2qpPLitoHbK3swXxeVSbSrI9NiqR2c9neVU/Auhhuubum
	trDx9mquDSkwubxoizDPvoc7KvH444D3JKCMikTjB8LX/DKvd9+X1efTQUjP9oBQz4Uo
	zLEYp/DShiv8kP2/ITSd9M3w/9/ENISnuHijUGpzbI4TgAFOUvwSAyR252z9RBf3g+v1
	vnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=J6m34n5ZlWSG9kxB2vm7Nyqy5zXyKFTaogKuNOdHcRQ=;
	b=OeRHwkjU4/+QclReexkrhc0JZhKF/BfTTRDce8mMmIn+OLwIwKzMJIaT2ad3ZwOLU7
	1i6+84GuzONOtWfy3SmNWtenMOXMWlRJI/ld3lyNGOSflzcGvMs90uFfMIfsDtx1VxsZ
	niwN4DwFBpKYXOx1cFfDzqPTajiUYbnHdKXecVPS0P04iTFTy+m+F6rrlP9ok/tOOwig
	7kropF1N27j9sdrytWpn7L/UnafJZNrps9oG7SHKCvtp+MmXyQncYeUR/fWHMWTh4wxj
	5+4j8xYnujSGIJmIpy3zzLGV13umYkibgCRT5cG5GTwgss7YWHr+veC/97Mns5gLdJIl
	JqZQ==
X-Gm-Message-State: APjAAAVbsZ9mluZKWFqtSTddfgpWp/N9kUq04s1I5ZEKLztVIkbCEqBn
	BKq0PuFUC+U4nILveipi5OQuUG54IkMCjou5Ps3tog==
X-Google-Smtp-Source: APXvYqxvfO0D5aYI3CYGR7FeioxthqcDa7OsmuWLn3EAJazQqhMJ4sIgNpXjUnQWWnJV9z2qiDJZuS6rjoFk8vWeRu0=
X-Received: by 2002:aca:5785:: with SMTP id l127mr5501807oib.48.1557510277415; 
	Fri, 10 May 2019 10:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190510151944.22981-1-richard.henderson@linaro.org>
In-Reply-To: <20190510151944.22981-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 18:44:26 +0100
Message-ID: <CAFEAcA_E1uuQk8WFXZTyzCNW=D24rdGxZgz7U=EjK57zDAOeHg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 00/27] tcg: Add CPUClass::tlb_fill
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 16:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-05-10 14:49:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190510
>
> for you to fetch changes up to 5f32c102ec3a0db4773d0f74b398191b578c0720:
>
>   tcg: Use tlb_fill probe from tlb_vaddr_to_host (2019-05-10 07:58:11 -0700)
>
> ----------------------------------------------------------------
> Add CPUClass::tlb_fill.
> Improve tlb_vaddr_to_host for use by ARM SVE no-fault loads.
>
> ----------------------------------------------------------------

Compile failure for aarch32 and 32-bit Windows builds:

/home/peter.maydell/qemu/accel/tcg/cputlb.c: In function 'tlb_vaddr_to_host':
/home/peter.maydell/qemu/accel/tcg/cputlb.c:1161:12: error: cast to
pointer from integer of different size
[-Werror=int-to-pointer-cast]
     return (void *)(addr + entry->addend);
            ^

I also saw this link error in my --disable-tcg build:

  LINK    x86_64-softmmu/qemu-system-x86_64
target/i386/cpu.o: In function `x86_cpu_common_class_init':
/home/petmay01/linaro/qemu-for-merges/target/i386/cpu.c:5918:
undefined reference to `x86_cpu_tlb_fill'
collect2: error: ld returned 1 exit status

thanks
-- PMM

