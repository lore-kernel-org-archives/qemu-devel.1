Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B72CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F2F2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7yMMcq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F2F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdpS-00022H-Rq
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdZC-0002Iy-5l
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNdZA-0002Qo-6y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:54:17 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:37450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNdZA-0002QX-1f
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:54:16 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 53so9104337otv.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5jAAyVlzQw0jedZ6X53PF88YjErFNqAPbE/dq5y4Q3o=;
 b=g7yMMcq4i2FZaQctuoQd3ihfWi9nu8ipGLfWZqnlUIARe957QLC4F1Wg1/rcRyV28x
 WUsfxAObE6NTsDPoo4T55G6RhGTUWbefMvN58VZjaJ1+yLRhaq6ZmSdX+VGGQq76aP+u
 W34kUxPC79Akqfx+PyAfgwSH7Jtd+F1tgTQCnMjdikx8Gh+haelipabyXaFCTnSb9WF6
 HvvQfowzqzXy1CDvnu5j+eCo4tkFJqz9ORTuOKaUioJ4bbou3vKcxQIuTDf+iKzN5YxS
 LpsFvTFqeajh6wTEh7fByTswTRBTJ8S4X+Jz43Zlmk6bETBD1+QQ/3N+OhmPHTYwigir
 dFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5jAAyVlzQw0jedZ6X53PF88YjErFNqAPbE/dq5y4Q3o=;
 b=SUMVm9RbuvZqVMyvjD/7h13ap0o2WwGmloGcPsRFSSZbbd8oflMbp6vrGARlXzx0J6
 ynes5hT8yw9aE1NVPMTUETfKIN4/pB/5erfppKbHXq1+1szmFW03S2WC3EOeCInQKy4N
 bAKvOpeRsDHAnPqL553TyDX1P2heUIrhztawLZaikGMgEd93M/nJFZkHwb7P/jU2C4Hu
 W9vCcDX/JUjcp1iJJs3VshSkPMOaGBFStb6CdtxdZjSsuxEFEX1NI4Js+Anwld9HNSgO
 PiktNImQzMxjRwm0/1G6XwoRB3s8I2qDIRCsEMKG6kzI2/kEWnkJEjPtmB+wIBGtKQJT
 kEdw==
X-Gm-Message-State: APjAAAX+hKvLIxkHTVBDMCqju8Wtn7kABAmTgbRy9Bh4gyusUyNm2YfQ
 0j4ZIIQO13Bj34JkSE5COVvcNww8uA2PArKKfipNBg==
X-Google-Smtp-Source: APXvYqzI0zJ1PfAKPbzCRSmerZKFDJJpcbeP3z8cUMpEH3k0qf1WIxwYngG9aWeTMkdg3DfbAD50koL9AYqjwVqzhZc=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr11261834oto.221.1571925255061; 
 Thu, 24 Oct 2019 06:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191024024623.18848-1-ehabkost@redhat.com>
In-Reply-To: <20191024024623.18848-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 14:54:04 +0100
Message-ID: <CAFEAcA8VZUt8gvktwMczHGyto88RUs0SbGHNR7s_C1=KnHTJJw@mail.gmail.com>
Subject: Re: [PULL 0/4] x86 and machine queue, 2019-10-23
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 03:46, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit f78398bfe544db81a974825b0a2aa826f6576414:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-10-22' into staging (2019-10-23 16:06:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 6a3a2e828220d9c86425930178445b868ea3c3c4:
>
>   hppa: drop usage of memory_region_allocate_system_memory() for ROM (2019-10-23 23:37:42 -0300)
>
> ----------------------------------------------------------------
> x86 and machine queue, 2019-10-23
>
> Features:
> * Denverton CPU model (Tao Xu)
>
> Cleanups:
> * Eliminate remaining places that abuse
>   memory_region_allocate_system_memory() (Igor Mammedov)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

