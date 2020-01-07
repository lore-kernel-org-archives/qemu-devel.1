Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFAC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48A12077B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyAq3xko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48A12077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorCx-0008CB-LZ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioqqC-0002le-6K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioqqA-0005MH-Py
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:19 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioqqA-0005LO-Jh
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:32:18 -0500
Received: by mail-oi1-x244.google.com with SMTP id l136so18016086oig.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 07:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=podBi/rjW/jG7GZECQsO96Hk3yL7ZXi+8rNfFC5U6Vk=;
 b=gyAq3xkowlKJbb8h/5wSe+QoInXdMm64UKGLzlOIRHVgsyeVZPW0890oCZrU7KN2KR
 Qh4SISYuDrLdlq9rLjyLBnKGZdGMqaIovOsgD3FMJ/dv7cLQHlnb1pGoOJK/UDde7Mpe
 rqmkvibT9b7mgnlwPNl0HtsxFZDxEXFodUqRnG1l5nbVdpabgwbclxFSrhfo5xBcqyzw
 6baYYv/CZ6ORHyXiRs9Ez61O1Jg0RC8s40pw0BoB/Nj49ALNbZleE+Wx0/7ja9kgEZ4E
 vT66Yvr5viahMIXAr+D0issydRpJ4yUMUqAosMzEZhDfoR0D78NQRDwz9LxGMEY+A2Vw
 ceTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=podBi/rjW/jG7GZECQsO96Hk3yL7ZXi+8rNfFC5U6Vk=;
 b=m74BB84rVbPs996G65lkjJF/ryXefhTbcXfkoaFshQW2+i3OWMMyqwIYKtbHndv0i0
 Ga48f0Jwtk5BD0zFY1phCHHhPdwr1xMbz6jtFLVwK17tCOphLCvYKPAnNUCU0NHChHuu
 AzJDaE8xG6spJEunl65g49BTt8plq+M5mcKGTInTpnzgWMO/OMVGVJ6HV+gdnbEZdCl1
 b3U0n9JEEuVmq+R/0gqDrDqUwO1chCAoPb11qGwz4k1ZpFZffBOT/pncoNHwwvwtacKu
 Lhv9L91JbmhIH8PX3v7ULweGkkeFz8Kmm68SNYSlaMYKiayIhet7chz9uomBwvJPL2bi
 wdgg==
X-Gm-Message-State: APjAAAXfD1+KXYbzrSVJUxO0d7Xn1iLvSsDNVxQrGXr8ik9pZ1fi0GQU
 8xOIltDGYAr512IOUScTDV8MKRUvYgf4gHUbyaPKkA==
X-Google-Smtp-Source: APXvYqwn1fMAwwiMYxxvEduTQ9AXWqbBn/SowIu8nOvJlTiuLVFlloBlPYS9aF6aqZM6TTKJ2sanhyhWW+MXED0IegU=
X-Received: by 2002:aca:f484:: with SMTP id s126mr190052oih.48.1578411137371; 
 Tue, 07 Jan 2020 07:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20200106144552.7205-1-peter.maydell@linaro.org>
 <20200106172808.GB219677@xz-x1>
 <CAFEAcA89VHAyQKCeV6exxzDjLCEGUyg59um7w-VZ2K6s4ZV31g@mail.gmail.com>
 <20200106180129.GD219677@xz-x1>
In-Reply-To: <20200106180129.GD219677@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 15:32:06 +0000
Message-ID: <CAFEAcA_-iB9buW0O8uoL9u8sUs7GdpD-fjfdjFfzP8yJ2+ZRbQ@mail.gmail.com>
Subject: Re: [PATCH] tests/iothread: Always connect iothread GSource to a
 GMainContext
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 18:01, Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Jan 06, 2020 at 05:40:15PM +0000, Peter Maydell wrote:
>
> [...]
>
> > So we're OK to not do this because tests/iothread.c's
> > main loop doesn't call g_main_loop_run(), and it doesn't
> > provide an iothread_get_g_main_context() ?
> >
> > I'm kind of inclined towards being lazy and sticking with
> > what this patch has, because:
> >  * it matches the real iothread.c, which reduces the possiblity
> >    of future surprise bugs due to things not matching up
> >  * it's already been reviewed
> >  * it saves me having to do a respin and retest
> >
> > But if people would prefer these bits deleted I'll stop
> > being lazy :-)
>
> Please feel free to be lazy and fix the test sooner (and that's why I
> offered my r-b :).

Thanks; I've applied this to master (though some other
problem with the NetBSD VM test run seems to have crept
in while I was ignoring failures on the assumption they
were due to this bug :-( )

-- PMM

