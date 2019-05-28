Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F66FC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AD682081C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 14:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPqTKcS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD682081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVcrj-0002cI-CJ
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 10:14:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVcqw-0002Ix-IK
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVcqq-0000qq-Sc
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:13:19 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVcqj-0000kl-6q
	for qemu-devel@nongnu.org; Tue, 28 May 2019 10:13:12 -0400
Received: by mail-ot1-x343.google.com with SMTP id j49so17827236otc.13
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=v/m2uRfH+cSnyzahDf7B4swuBDM+bQU5sl6/jcQh0Og=;
	b=OPqTKcS0G698YeXpnPf1cbRnADm3phWX2aPXwh7nIWNgWAkYsGg54dPM2ZQlkSEhaZ
	vXnb99zepogy61aERIsRmGJz/nQUQUfe/o+Prk8XCsp25zvOMXSb3NTBXk/mbEuv9Wrs
	zCj6aw3Bt8Y1fELkh2sB+6321JXVQG5uK+Gmu1ohqECC8GuzbZqRzLmRcXbhY0RKweIJ
	zVVWQA+lzSyLERpcCVFYbedarmkj666L2NaeMWfp9boQYTkx1yTacfxg8Sq97Mm+DxJ/
	5IFv41m5aGhw6aJl8GJWNFIfdgY36wXPt9l9wry0ekUT3q+JnKF+dhm5zgOJZ6l3ByUr
	s1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=v/m2uRfH+cSnyzahDf7B4swuBDM+bQU5sl6/jcQh0Og=;
	b=rt0kbFLo7XUzpD4vYJL82PmWzK4vixAywRWvJ7Vibd4rAtNNBJ5ppi6CD3kMOr+cpO
	XIRvDUBNdp6MFtfRNqrxS7sdzpU6jQ63271akXjjJKUzAtRy9mID4VFivYGcRirVtO6a
	+1Got0DlMC8ifRlyLLUxyiBnyNn317PAyv4vSpRb2Tf8N27N49xO6nrq0lbhhRfzdbXh
	kilR9JM8+HJ7tuRTtMq9ESSgWqn2Fb2UJ2En1AE/sFBJ+6h5zzeQk8bPEaB761wQdhGt
	lr2siXQO6ECUihQ6kADtgW9mCBRheCuluWgbDcPxcZSxBzzH/S3HI3u+7l0MQi4m/yav
	v7Tg==
X-Gm-Message-State: APjAAAWkXnsGHxfXjMmaekjNa9LOekvjxPJgajSYISgDGl6zu3eyiOV6
	5PPUdAzwoIVUTboY8QTbzY3u6Y4bQLmOUckp8JNmFg==
X-Google-Smtp-Source: APXvYqwSkkhpv6A1njd+sa7l79FnKwFhEI1njWNOxcyNUuCcWB2a8Llgrnwl1iLL3E18dPJ69Cz5fenuhAciri/I0Zc=
X-Received: by 2002:a05:6830:149a:: with SMTP id
	s26mr110651otq.221.1559052784894; 
	Tue, 28 May 2019 07:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190528140750.28036-1-philmd@redhat.com>
In-Reply-To: <20190528140750.28036-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 15:12:53 +0100
Message-ID: <CAFEAcA8PmF-y8-RH6gC2mZQpUdOUEfHWp0aW_hwEDFHK7+QxwA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] hw/scsi/vmw_pvscsi: Use qbus_reset_all()
 directly
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	QEMU Trivial <qemu-trivial@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 15:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Since the BusState is accesible from the SCSIBus object,
> it is pointless to use qbus_reset_all_fn.
> Use qbus_reset_all() directly.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> One step toward removing qbus_reset_all_fn()
> ---
>  hw/scsi/vmw_pvscsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 584b4be07e..6f571d0d19 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -440,7 +440,7 @@ static void
>  pvscsi_reset_adapter(PVSCSIState *s)
>  {
>      s->resetting++;
> -    qbus_reset_all_fn(&s->bus);
> +    qbus_reset_all(&s->bus.qbus);

I thought our QOM style prefers using "BUS(&s->bus)"
rather than looking inside the definition of the
SCSIBus struct with "s->bus.qbus" ? (Compare preferring
"DEVICE(s)" to "s->qdev".)

thanks
-- PMM

