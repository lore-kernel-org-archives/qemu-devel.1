Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E77C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:28:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B02E20645
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 16:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgBimpwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B02E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55128 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMEZk-0008Ef-Sn
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 12:28:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hMEYr-0007j4-C8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hMEYq-0003Cz-9P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:27:53 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:38275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1hMEYp-00033j-UX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:27:52 -0400
Received: by mail-it1-x144.google.com with SMTP id q19so4457633itk.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 09:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Lc4CviBCGEp32pFXKHNImhDpYpHtlilaJsLj/0TS/6c=;
	b=RgBimpwx7uOHit8JOGuYA/uniXlvpIu/tg/jzTnY56mbPApIl1dBFX/mGQd0QGpTM8
	9bF3VPcKKAUfLUVm+R57Sbjq1jgQygolFOkrxe2vPy5QIMGFB6DrBEq9xknWdrVIDR/1
	yfamfN2QYL+PK2vD8C/RS2Z10M0jMrBkIc916VgrCV1sfaoObjGd5Ewzw9r0PTypGh89
	Hv8rFCj/bvmV97zrElkGAd6LgjllQ5QJAV3VQwOn5Atdcj6f26RgGZ5Ah338x6WzTjST
	+NrtBhjDH91RgklEy8MBdQQm8lLaOfD8/PrV2JTsmZB+QyzC57hsBs5YSVhfOknq+LRV
	i04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Lc4CviBCGEp32pFXKHNImhDpYpHtlilaJsLj/0TS/6c=;
	b=gu0JikiPp5ISubq/BXv1iGd5NTql6oEzIKdpSHTSqJbCztsZ9Gl075KU/6bJPNOx4a
	oe4yhaTUVoZAzBJ7m0j5319KAZcIHrlh5Ew/k9HI6obaES7/Tmm4IEvesLn+kCHVAJGn
	eo6cSojHYukRjXjW8mggCTOsX+CsKZAjKGbc5ElAvymNr33j2eOpm9uYDrctcoo+fluc
	TK0bBwTFv0V0EJM1AnQOQ5WWGBULBEtMUf4QIEfAeL7ApblZbX2r0iAVYUQvicsgGeJy
	HZJJKr6TgFsnEuztzi4wIkqhwXsvacHowaCMS7RK0ylG61ybHLHWOwNczHS09aI85Ggb
	IbJg==
X-Gm-Message-State: APjAAAXfRTLEu+PBqH+1KqdEIw039aiUoD3w8Syez/s/MVz8zPTHA/Aj
	yQxB7BQPy2D6KZbYxqGCFj9W6FBLBUcawwLJBJg=
X-Google-Smtp-Source: APXvYqxy1FTgPRNwfAMINj19A3kxENVQnw184kLMLF7KOdCBrn3E5REPbCH2Uj5iGwN1DvWfU9HM3+08jWhmqyIVBY8=
X-Received: by 2002:a02:8627:: with SMTP id e36mr3216596jai.98.1556814448646; 
	Thu, 02 May 2019 09:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <877eb86hcf.fsf@zen.linaroharston>
	<20190502145846.26226-1-alex.bennee@linaro.org>
	<765fa2ab-2803-1945-61ea-2e80b2da6072@vivier.eu>
In-Reply-To: <765fa2ab-2803-1945-61ea-2e80b2da6072@vivier.eu>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 2 May 2019 18:27:17 +0200
Message-ID:
 <CABoDooM+DtCbTTsoYdvAJOOKuybgKUAR1yYmckM1b=dGA10=NA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
Subject: Re: [Qemu-devel] [PATCH] linux-user: avoid treading on gprof's
 SIGPROF signals
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502162717.AqcLkPeysn3jyTfX4m9sdGmCw2BKX16hndiTI90Me90@z>

On Thu, May 2, 2019 at 6:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 02/05/2019 16:58, Alex Benn=C3=A9e wrote:
> > The guest tends to get confused when it receives signals it doesn't
> > know about. Given the gprof magic has also set up it's own handler we
> > would do well to avoid stomping on it as well.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  linux-user/signal.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/linux-user/signal.c b/linux-user/signal.c
> > index e2c0b37173..44b2d3b35a 100644
> > --- a/linux-user/signal.c
> > +++ b/linux-user/signal.c
> > @@ -508,6 +508,11 @@ void signal_init(void)
> >      act.sa_flags =3D SA_SIGINFO;
> >      act.sa_sigaction =3D host_signal_handler;
> >      for(i =3D 1; i <=3D TARGET_NSIG; i++) {
> > +#ifdef TARGET_GPROF
> > +        if (i =3D=3D SIGPROF) {
> > +            continue;
> > +        }
> > +#endif
> >          host_sig =3D target_to_host_signal(i);
> >          sigaction(host_sig, NULL, &oact);
> >          if (oact.sa_sigaction =3D=3D (void *)SIG_IGN) {
> >
>
> Perhaps merge this with the previous one and send a v2: it will ease
> bisecting.

I agree it would be better, though it should be noted that the signal
issue has existed for at least 8 years (that's when I had to add a
specific patch in my private repository).

Thanks,

Laurent

