Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F4EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554F3208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymQNgseS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554F3208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55635 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOk3W-0008Fr-Eg
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:29:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOk1H-0006ot-0R
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hOk1F-0001Rd-3k
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:27:34 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:34772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hOk1B-0001Pu-GN
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:27:31 -0400
Received: by mail-ot1-x330.google.com with SMTP id l17so2484450otq.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=6LJyyErWpleJNO3piNiSstINguX+qYjhgSHzysSFEsc=;
	b=ymQNgseSTD7IsNFO6WmwM6s4AmETujq/N/Y4B14FGhnbmVkn04FG/XaqSwzrUwIRkG
	riYC6qj629MvlWGzJOmVK+p5AYlRI1uZxzNbnf1vc9QGc0XtcWmsQeUh5RrxssGm0pJM
	+rjY7W/Rb0bOEGCeDoNFSscTSXFuXQa4r9CIqoqq0AMjpfHCi8+ylsRc0QW4VBT9t/FL
	r9cideb7t3cnQfU5LLx3Z0D4I0bxnVHCRiLZDKqUJhRNoBphVsVJw4nuJdB5guGJPpF7
	yQCtSYuQw7yeTSV36aKE9AqTXHM1E7hrred2S9h+X68aItb41xpGnnFGppAixuCpR/N2
	pCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=6LJyyErWpleJNO3piNiSstINguX+qYjhgSHzysSFEsc=;
	b=YXxow1vsmaDR4zL2C9cR75QefTqDcXvxaveJt9ZKku8Zf9Ta+0+z4zTMQC7GB/JNaI
	K5vbY5J+WH+++rM2cKtZg04KrpPv08OikHWtow2nfsiXqNAPSgupKUFb5ZaO7cpeJncS
	S/gaDM5VSTCJr7Pfymy+dqAsEx02amLHYvMm7idOzuaNRjX10fV4Iy7QLTJm/10vEl7b
	ZItNz/yuXHO+oOA9X85Vd+u9yPfio3sOpc2f+Xz2cEsVEL8tA1WQx7Dge+zY7g1vNULe
	YWq3DyMfy+FBLGYbOVudu4JLiLlt/LBxD10FFWgRhHf0fTrnvcwxydZDJAtpMoBaCEdJ
	bliA==
X-Gm-Message-State: APjAAAV21P5XW2hvyuySPfIR/U/FHc7V7zlYel8MmlFuh1WcTE54q4Rh
	kKIc9VCIWBSqtxpuubt4kZWHwE9WcbY2+J684HZy6A==
X-Google-Smtp-Source: APXvYqxug6RbA8/NU0haF7VjVXSRmFQPOGZ8qh/JQ6WJZ5XjtE0nZ1ThSxR62nx57W9goKHcTr7LWwa8zRtb5tMa8mI=
X-Received: by 2002:a05:6830:1258:: with SMTP id
	s24mr2744486otp.238.1557412047216; 
	Thu, 09 May 2019 07:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190503112654.4393-1-laurent@vivier.eu>
	<80fb3313-239a-5828-94fa-d27137bfcb05@vivier.eu>
	<CAFEAcA_y24gpugttDTR-QrJ0fA7JCQeC0XXsR6pjm2rQ19rfCA@mail.gmail.com>
	<CAFEAcA9ZRSxPK17Zgx0WuhvjyVATL5-0Mp7LvBtv5O4+UGRVyg@mail.gmail.com>
	<2ada4cde-cece-4855-8499-90183a30fb0c@vivier.eu>
In-Reply-To: <2ada4cde-cece-4855-8499-90183a30fb0c@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 May 2019 15:27:16 +0100
Message-ID: <CAFEAcA9dyNWQ=Jes8xB5ZgmGhZ+c3ryiUOP2Uwe1GcWdDi-5DA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL v2 00/12] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 May 2019 at 09:58, Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 09/05/2019 10:51, Peter Maydell wrote:
> > On Tue, 7 May 2019 at 21:48, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >> On Tue, 7 May 2019 at 20:10, Laurent Vivier <laurent@vivier.eu> wrote:
> >>>
> >>> Ping ?
> >>
> >> This is in my queue to process, but there are still a bunch of
> >> other pullreqs in the queue too; I am working through them.
> >
> > Wait, I'm confused now. Looking back through my emails you
> > said "Forget this series, the send has been aborted for an
> > unknown reason.". So should I be applying something ?
>
> Yes, it's why I pinged.
>
> I sent the v2 three times because the sent was aborted for an known
> reason two times. The third is the good one.
>
> You must apply this series.

Applied, thanks.

-- PMM

