Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E711521951
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eN+NvlKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E711521951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzVn-0005V8-1T
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqzVb-00053t-MR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqzVa-0006Zg-Oj
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:39:39 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqzVa-0006Xv-J6
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:39:38 -0400
Received: by mail-ot1-x343.google.com with SMTP id z23so26837079ote.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7oY1OmwYSBXmtrtrGQg3aJRQtWKlkBxlgour/ZnR7gU=;
 b=eN+NvlKZO+1wB/GxfPvkpgwZ7crff5gjv6yw8NuvfN7ieFzVXvkHGTHvRTLxVRGUz1
 mNBvssdtENVb7gmgozMRfOQZ8oZqiL6tyiAFjtHjucufb8g1EUFQkwq48BuHYbwCLKAP
 Q8lw9Xgq98lECYnetbNn4GQFjSXjSVWj40z/F31EJp41qtoaG3YkVaRnprf5usvm4QOS
 jI+tmFGT6boK1O9OB8JZLSc5sYnrM+dMvJhIkmATcYOYCqro+4QVxIR7is9sLyOx8RNU
 b4MdPe9U4strqsc5wHmE3Kiu69+I4E90bmw/Re1X5YuaSNeubuHmXirrZkJwy7x4PaX9
 T7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7oY1OmwYSBXmtrtrGQg3aJRQtWKlkBxlgour/ZnR7gU=;
 b=CcG54hn0/ZVjAg0ZxBSVji4ZCe+7b2YzCYjXt2krUOI6BCZpK6I86JGMQLXL5s9PRn
 qF+8R2XhOYu2xGz0e3744nshl6CiG3h6qEh4LCG3y3jWjNREPQeF5Ojf7BAt6mGO9jcf
 CprnvXvFV7PZBNm1N5kwIaTqJlEa7AJ0lDzECSuerpXqFDZUrhPoc7/HdFhkB7+UJeO6
 Umi7biBWSsQYRy69Y98fXfXTxNQhlV7W74yLsI6/fNeafPcLt9r7uDnqhvZ6viuiD2LT
 1gix8ePLCySXlF6ZETDBMERGbTPzKZHXUGwdxXJbw3Mr4+ZDpzALTnMtaYLYSWdQva7x
 Ux2g==
X-Gm-Message-State: APjAAAVeaxB98/yHWKuTbXgz3arNR95gNV5gAXAK0UZWC8mnXOhOmoVc
 2so9XY0YzzEM9sVGq3UPfWQQAYgKp8DYcuikijE9Cg==
X-Google-Smtp-Source: APXvYqx9D27sH/kDjAz90LalWhJqXRpfNgtZDAD6R0tW6Khv1vf4yc42E15FcbaqrEDzYXO98dguGE3K580ov+Qa+qQ=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr11220298oti.91.1564144777276; 
 Fri, 26 Jul 2019 05:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
 <CAFEAcA-Qcq1ZmfDO_dkh_H9-aeQVU83ceLKU1NXM3VpW8g5sPQ@mail.gmail.com>
 <20190702124823-mutt-send-email-mst@kernel.org>
 <CAFEAcA-UFks7CmtcMT15KzK3TzRqGjwXWtFa8K6XZ=Bks92CJw@mail.gmail.com>
 <20190702142058-mutt-send-email-mst@kernel.org>
 <CAFEAcA_c3UXPVy_rXR_FxyXRw5ZE1-QgumPr9B-j+pmvBGWgpQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_c3UXPVy_rXR_FxyXRw5ZE1-QgumPr9B-j+pmvBGWgpQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 13:39:26 +0100
Message-ID: <CAFEAcA8EQPdNTDf_t2aFDkfBj8iSevYpVCxTjjuX9NFGJJbTkg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 19:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 2 Jul 2019 at 19:22, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jul 02, 2019 at 06:20:01PM +0100, Peter Maydell wrote:
> > > On Tue, 2 Jul 2019 at 18:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > This isn't from mainline. We have a bit of a deadlock with linux merge
> > > > window opening soon. I think it's reasonable temporarily
> > > > and then before release either virtio-pmem gets there or I will
> > > > revert it and drop the header.
> > >
> > > It's definitely not ideal: until the headers are actually
> > > upstream there's no guarantee that they won't change ABI.
> >
> > But then I'm watching it, if I see that I'll drop the device from qemu for
> > now.
>
> OK; I guess we can take this for now if we make sure we revert
> if the headers aren't upstream by the time we get to say rc2
> (23rd July). (That is, we'd want to do any revert shortly after
> rc2, since rc3 might be the last rc before release.)

Ping for status update -- have the headers hit the mainline
kernel yet? Do they match the versions we put into QEMU?

thanks
-- PMM

