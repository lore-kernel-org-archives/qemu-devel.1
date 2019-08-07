Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86D7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1D2219BE
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKQXA9fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1D2219BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvKi8-0002tl-Jv
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33371)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hvKhl-0002Ut-Ho
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hvKhk-00063W-Fu
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:06:09 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:41472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hvKhk-000624-8I; Wed, 07 Aug 2019 08:06:08 -0400
Received: by mail-lf1-x129.google.com with SMTP id 62so58967765lfa.8;
 Wed, 07 Aug 2019 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=feauNxMbWvbu8rvtkPy593IYNPbG8Nb3Imgk75IIBsE=;
 b=YKQXA9fmOuzr6daNDOeElVLtqjSIBUhOKlkYnV0qmYxvXC3ZGndcTfIVLAtHyoj3zX
 pHvz2VF5wcF3uQfDtuH9s6QHUOrn9EcxOn+44JXuJeRMB3irqsipVtpHD80mtwjJFb7V
 b6VcxahwRo1VfAE5ba7/e3Ev9RtfFaZmdepXMqlqlar0DVe+Q4BiO/9T82fbDodRZc67
 6KXn4VjSiqXpnmYjYy0Ml1RW/Q9kWRbewvb3VNYIhkAbCoAlnnJtHc/MbCkz6rvlyQ3o
 v9KFC/7CnMVG9L5zw2yauVKFJlLEWHOe4Z5FvKqRfN+nIDzPsp7vJ9oTxWV5v31xpZRg
 j7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=feauNxMbWvbu8rvtkPy593IYNPbG8Nb3Imgk75IIBsE=;
 b=DzksyZnHcHmqdSR51jweKfcPwm9oF+NBXcZsvygKJJjoRt/XVDbRKJBqY/jh9UsQVT
 6FVpbAuU0R5wuRR1JWXlVB5Hf1LqjzPCgMhQ9HfrDd8VbCjEOTrKWw/VHKr0E15Axacd
 QC4VLKS70BcMT45yZ/r4DTyX3QYV9vf5soH59S6PNZCtjxkm30ubH6QSRKNGYcEAc3OD
 P7QqKcVqI9doNjJRN+DKrETDjpazWb/l0+SFwJTkm3dQCKp1sqjgYl0+8ctGd1MGg94g
 jlWHsU7Jx0qxZjvzv93c/yf0IwUKJgEvL6UFNvpZsC4OEucyta0r1rSnQvs8xMJehzce
 054Q==
X-Gm-Message-State: APjAAAUP+vA6FGIsKDJeGrEXRCBHRqnXFd4TglTn9y++mc1nZ09qj7bK
 IjIAQ+JJqzdzY8djjvUv4MmhBEBmo0ILwXNlPFU=
X-Google-Smtp-Source: APXvYqwA9UDQPINBAkRol6slZ2O7MWdNOpgPJfjS/qQ5JxyxoVatccFkcmohLuWLiTH35JIC3q6FTmCyh32TG7fNHJE=
X-Received: by 2002:ac2:43bc:: with SMTP id t28mr5892487lfl.14.1565179566251; 
 Wed, 07 Aug 2019 05:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
 <20190801234031.29561-8-mehta.aaru20@gmail.com>
 <CAMDeoFUMSupka-F+TCHSq+1UMd_UbNXFyPwzdC738BSmNWXi2w@mail.gmail.com>
In-Reply-To: <CAMDeoFUMSupka-F+TCHSq+1UMd_UbNXFyPwzdC738BSmNWXi2w@mail.gmail.com>
From: Aarushi Mehta <mehta.aaru20@gmail.com>
Date: Wed, 7 Aug 2019 17:35:54 +0530
Message-ID: <CAEg9+6Kwn2Fw8X+v5r9eMTitiG9e4bjdfKwtxX2pu23JQe_5_w@mail.gmail.com>
To: Julia Suvorova <jusual@mail.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::129
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v9 07/17] blockdev: adds bdrv_parse_aio to
 use io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Aug, 2019, 17:15 Julia Suvorova, <jusual@mail.ru> wrote:

> On Fri, Aug 2, 2019 at 1:41 AM Aarushi Mehta <mehta.aaru20@gmail.com>
> wrote:
> > +int bdrv_parse_aio(const char *mode, int *flags)
> > +{
> > +    if (!strcmp(mode, "threads")) {
> > +        /* do nothing, default */
> > +    } else if (!strcmp(mode, "native")) {
> > +        *flags |= BDRV_O_NATIVE_AIO;
>
> This 'if' should be covered with CONFIG_LINUX_AIO.
>

The aio=native definition is shared with Windows hosts' native aio and will
break if it was covered.

file-posix handles the case.

Best regards, Julia Suvorova.
>
> > +#ifdef CONFIG_LINUX_IO_URING
> > +    } else if (!strcmp(mode, "io_uring")) {
> > +        *flags |= BDRV_O_IO_URING;
> > +#endif
> > +    } else {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
>
