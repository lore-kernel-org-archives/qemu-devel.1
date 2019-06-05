Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF3C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164BB2083E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 07:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YawF5Bvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164BB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYQBe-0005p2-8Q
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 03:18:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hYQA7-0005D5-CL
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hYQA5-0002i6-BE
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:16:42 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:35200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hYQA5-0002gi-6u
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 03:16:41 -0400
Received: by mail-qk1-x742.google.com with SMTP id l128so4540501qke.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=9buaXQLGdYJ/2B0U1Is3vnoPf5kkPieOFWEMjJJ+h84=;
	b=YawF5BvlhnY7bHXhcAf6H6+MYzUbjCYmoRvd96QndWL4VsLcdIohXmkFVw45MIoK32
	C1DuVQnjrCT4UiT0FIyVFDYyvFgsmEx9sIiMdLrgjta2APqPspv5ef1EffkUwM0KWZpT
	jcOCZLuZyDIVuZkU5vuAgLNHiKQwlGm7wDQAugxOTf4EJPb0UWFCHXjQsdJXWn1OE9N2
	cnykjotpsRNNuibiZYLvnFA7+hMeVWll+ldRIUgd2n2a4syb3LrVChDAAb7VD+ehfGUS
	IjbF47ahtVPEDT6KHlFfkLmbJ/cvNjstZ0IxW6j3W9mWglUKcj5ENU9NzRhvpioPovWj
	5tqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=9buaXQLGdYJ/2B0U1Is3vnoPf5kkPieOFWEMjJJ+h84=;
	b=ONqQN9tSmLe205nkTUXMnvFHi571+/elKtccuEdhDLI2MfR3m0H4OFyBzPFd1lHHwY
	VeCOUCcReHHadOW/WUKH1C4EhF1ewSt4o/Jbw+ClUv8Rs6xsKJjBj2J0ld46OmsY7KsF
	uB6l/R4fdF/6Av2gc5b3o3dPEHT2OUqxe0X/CqyObvqWgzQTVgiqu1XF6T2L/QBbe9tt
	Z1IPnfrJbbW/zRBIYVSSBKPOIvh3UeS/FyqXoORlcQ4RFrHbhBIUwZeDbfIyRGALcVta
	DpffiIvWC/7aIdgUkNxT1dU+8aVphtT6XnuhO4l7qEWdMBBZfwwDC7i9sDgVR1cFc+zZ
	kaiw==
X-Gm-Message-State: APjAAAXu6on9a6TU6WPPP0JaIKdBOsdNNB4zSCUvCcoU4YY6/K21blBv
	MaRXMUP2pR1Za+OhhAc8Ul+h2pMrKKSrkf/aYlI=
X-Google-Smtp-Source: APXvYqwbNOaaTaeMkh1uPzS1Bu1hQJPJhlSQrfADa5ETA/oSdZKC1e7PMBNPHQntxnWy2lty6IcwilSUepfx8gZa3nA=
X-Received: by 2002:a37:9c15:: with SMTP id f21mr10914171qke.248.1559719000626;
	Wed, 05 Jun 2019 00:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190604073459.15651-1-xieyongji@baidu.com>
	<20190604073459.15651-3-xieyongji@baidu.com>
	<20190605084224.22e4cd92@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAONzpcZ_Wosy3BUZYDUp8UuEYk_3VSpSP+MQr7QRab8bKJ4-JQ@mail.gmail.com>
	<20190605091401.5177daca@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190605091401.5177daca@bahia.lab.toulouse-stg.fr.ibm.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 5 Jun 2019 15:16:28 +0800
Message-ID: <CAONzpcaw_KbtW5Y1KQd_Mo-gYPtydxRLwRVh0sUkk9a7BUQ+qw@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio: Set "start_on_kick" for
 legacy devices
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Xie Yongji <xieyongji@baidu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Jun 2019 at 15:14, Greg Kurz <groug@kaod.org> wrote:
>
> On Wed, 5 Jun 2019 14:49:34 +0800
> Yongji Xie <elohimes@gmail.com> wrote:
>
> > On Wed, 5 Jun 2019 at 14:42, Greg Kurz <groug@kaod.org> wrote:
> > >
> > > On Tue,  4 Jun 2019 15:34:56 +0800
> > > elohimes@gmail.com wrote:
> > >
> > > > From: Xie Yongji <xieyongji@baidu.com>
> > > >
> > > > Besides virtio 1.0 transitional devices, we should also
> > > > set "start_on_kick" flag for legacy devices (virtio 0.9).
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > ---
> > >
> > > Patch looks good but it would be even better if applied
> > > earlier so that it doesn't revert lines added by the
> > > previous patch...
> > >
> >
> > Fine with me. Will do it in v3.
> >
>
> Hold on before posting, I've just learned about hw_compat_4_0_1 while
> reviewing patch 5... need so more time to understand the impact.
>

Sure.

Thanks,
Yongji

