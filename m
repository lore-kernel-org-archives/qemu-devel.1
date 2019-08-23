Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508E2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1935D22CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAKMmnm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1935D22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53371 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1663-0007Pi-6E
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i160v-0001FH-DQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i160s-0007gc-Uo
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:37:45 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i160n-0007bs-Cf; Fri, 23 Aug 2019 05:37:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id c7so8232211otp.1;
 Fri, 23 Aug 2019 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=VK3tHoLAJE5pXLWgsYcMHKFnFd1LYG8rko8XVVQD4vg=;
 b=SAKMmnm8DlEFbpf9FwvV8fGNKCVCyPINKlLBaNt/S75uCKHvslSUhoZQYQhdkEUATL
 WDPVHtxJ9IDyX5bwRBai0I9epHO2FnaubFfa7Dz+g50s8N/275coBdx5vDKrRz8sO7/N
 nYbJEmooSatBZY9JNyrdc0Lm5T3qvZd/poAoZfvQfeyPDtTgXJbTQCLzNP6FZAAV6gln
 xlu+O2ZjN2viNmqotlH+Gc3Iu0rPVyqKMyybSjFY6G1OtUITPf6SNMVcvHIUaMjayiAN
 5MtQCMXghTb2mzuUHbXKZ5TZBRIzMucJs27vtz7RcQvOyXpmktMWrwwYbzl9r895TcR6
 rQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=VK3tHoLAJE5pXLWgsYcMHKFnFd1LYG8rko8XVVQD4vg=;
 b=ZWlO6AoD23ZfjdbA1oiiFbimyFtXUKdfDNYuhLGqGAo9bF61tH3Le8ljyg9e8cjgOy
 TNtDfCu4kSwH5RpeX3PBDVyxIjOIeqd1mNQCIiHXLQYGPDHsDqEI2VTdebqsPxOUYWo5
 iYGKsLfyiyM9LsCL51LSru5tvXelYJHgeQtfUhLcSX+Berw61cc1gyOKE6VZR4K6yDvB
 v4wzikDPbfIVygi8UDiNdELfwDijLdqKrHu2vdOSLG4iqU+tq9WXOuLAU8tWxC2glubz
 u0/8zSTF4t0W0Q09QA5+Wa7LSDpnHjwdkfY8rpd2gOXeI30Zl6ZDC6GRXeOBVuEALAT5
 JSkA==
X-Gm-Message-State: APjAAAVSEJ06jmaUhoSf3GkXJujs06k4lS62+gi01fwCfnx/4YVZQPIZ
 B5f7K8kFMbNQbnI97EXWyglVBlzbLjb9bIV/77Q=
X-Google-Smtp-Source: APXvYqw7kShhY6NNJUkHqNxTxCNBHSOqZoWb+RLmlXYCFAKgHGkYBZMNLSBz++ASwc+p+/gGxP074zzxPSHdFMVB7pU=
X-Received: by 2002:a9d:1288:: with SMTP id g8mr3312957otg.306.1566553054770; 
 Fri, 23 Aug 2019 02:37:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 02:37:34
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Fri, 23 Aug 2019 02:37:34
 -0700 (PDT)
In-Reply-To: <20190822230916.576-2-philmd@redhat.com>
References: <20190822230916.576-1-philmd@redhat.com>
 <20190822230916.576-2-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 23 Aug 2019 11:37:34 +0200
Message-ID: <CAL1e-=hnAwWVobL7yP3GaC=8ywFtUvr-OeciJX8gFLQDJzaS7Q@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/3] mailmap: Reorder by sections
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

23.08.2019. 01.13, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Our mailmap currently has 4 sections somehow documented.
> Reorder few entries not related to "addresses from the original
> git import" into the 3rd section, and add a comment to describe
> it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Just for the sake of tidiness, consider alphabetically ordering items in
the new section. (This would've been a challenge though if we had had many
Chinese contributors... :) ) In any case:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  .mailmap | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index b8e08297c9..e1fdc88d25 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -4,20 +4,12 @@
>  # into proper addresses so that they are counted properly by git
shortlog.
>  Andrzej Zaborowski <balrogg@gmail.com> balrog
<balrog@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Anthony Liguori <anthony@codemonkey.ws> aliguori
<aliguori@c046a42c-6fe2-441c-8c8c-71466251a162>
> -Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <
aliguori@us.ibm.com>
>  Aurelien Jarno <aurelien@aurel32.net> aurel32
<aurel32@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Blue Swirl <blauwirbel@gmail.com> blueswir1
<blueswir1@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Edgar E. Iglesias <edgar.iglesias@gmail.com> edgar_igl
<edgar_igl@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Fabrice Bellard <fabrice@bellard.org> bellard
<bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
> -James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
>  Jocelyn Mayer <l_indien@magic.fr> j_mayer
<j_mayer@c046a42c-6fe2-441c-8c8c-71466251a162>
>  Paul Brook <paul@codesourcery.com> pbrook
<pbrook@c046a42c-6fe2-441c-8c8c-71466251a162>
> -Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
> -Aleksandar Markovic <amarkovic@wavecomp.com> <
aleksandar.markovic@mips.com>
> -Aleksandar Markovic <amarkovic@wavecomp.com> <
aleksandar.markovic@imgtec.com>
> -Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> -Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
> -Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
>  Thiemo Seufer <ths@networkno.de> ths
<ths@c046a42c-6fe2-441c-8c8c-71466251a162>
>  malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
>
> @@ -32,6 +24,15 @@ Ian McKellar <ianloic@google.com> Ian McKellar via
Qemu-devel <qemu-devel@nongnu
>  Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu-devel <
qemu-devel@nongnu.org>
>  Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via
Qemu-devel <qemu-devel@nongnu.org>
>
> +# Next, replace old addresses by a more recent one.
> +Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <
aliguori@us.ibm.com>
> +James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
> +Aleksandar Markovic <amarkovic@wavecomp.com> <
aleksandar.markovic@mips.com>
> +Aleksandar Markovic <amarkovic@wavecomp.com> <
aleksandar.markovic@imgtec.com>
> +Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
> +Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
> +Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> +Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>
>  # Also list preferred name forms where people have changed their
>  # git author config, or had utf8/latin1 encoding issues.
> --
> 2.20.1
>
>
