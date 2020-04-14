Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7CC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8BA20575
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBz1+el5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8BA20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jORCl-0006b5-4e
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 15:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jORBx-00061l-5J
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jORBw-0008H7-10
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:25:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jORBt-0008Fi-Qg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:25:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id x10so2042950oie.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 12:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ajdhieO/yPSDycoQgMl2LpzqcalPWMGAn/dZc7rhDzk=;
 b=uBz1+el5UNKlTRKfgJtKVWtO7U7a5ioSSbF6helDq1B3vn0jF/niJOUki82R6SdGke
 3YepVZzkLYANwtFA81FrgIi6WKVmZvixQ8a0nlt3uaeSb6xZJcJj9oij4NVCVDin2ChV
 HHh81QxPbyNVHQSRukrf6Ai0SdFKZ5lXl46D4O8x268cFVOh56qs5qCNXlfVr3GeU18t
 3tjQAg3WBdhoLMiV/qhATzfoskc+frrLn/rmx1LPEmCQyhOkE3EvcRhJ7gWVw6z+/F2J
 y0IhDkryY5YWkBoTbmv2X9TzPnq4gstLn++bOHWJH7V5y7gQAfq0dKoXfvuBpuP04CBB
 tA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ajdhieO/yPSDycoQgMl2LpzqcalPWMGAn/dZc7rhDzk=;
 b=l2J+n8+TM15zL/f0Nq4L9nvNIwrTfNkpaeTLUL+clpl1xKZl1DcXdqI8qWSsDC1WUH
 ZYM0Q3f9/7mrJcqTs7vFATH4WXzRzt6bZgp7389nDrF9daJaIDPDVrc0X1A+FG2A8SlC
 Qd3XtBjPqrFOPzp+0HJXscpUwNYdULQi1VTYXuMjXFRtKG92KYquOV7Cl5bul0G66K3s
 AM5cDbNDuEuZMerKGYRaWtcpN9uQj/Dt0xMS0MVBt8bmzp7dW1LiLy93RkZJA1rlhGrA
 B2KbAKEkTe5Hh1VN3BtTp/xZ0pXEZ4k2bYWHQSkuc3cnOOYPT0JYNnn/KkCFkQms701D
 Vbeg==
X-Gm-Message-State: AGi0Pub1E10f7J8QTRp0Sc3Po5SE9007NOjvXStB2pxHgjrIA6iq3OwW
 TVbZR4cKWxKLjjSWC6oOk6Ec7hGjAQJEJzBr1ljyGQ==
X-Google-Smtp-Source: APiQypL2LiJ8pFhcUYZxpI/ReLaVqvf3j9xPuJkq51YazJ2nB//H+PoF2icK+vnEHFy1qf2jtipI+MDnFVdPcAV3Z8w=
X-Received: by 2002:aca:170e:: with SMTP id j14mr45161oii.163.1586892348919;
 Tue, 14 Apr 2020 12:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200406153326.806024-1-berrange@redhat.com>
In-Reply-To: <20200406153326.806024-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 20:25:36 +0100
Message-ID: <CAFEAcA8rXBty2tHZOoqQA+mEcxEYiBntjeKj07-NUiPH+NWxmg@mail.gmail.com>
Subject: Re: [PATCH v5 for-5.0] configure: warn if not using a separate build
 directory
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Apr 2020 at 16:33, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> Running configure directly from the source directory is a build
> configuration that will go away in future. It is also not currently
> covered by any automated testing. Display a deprecation warning if
> the user attempts to use an in-srcdir build setup, so that they are
> aware that they're building QEMU in an undesirable manner.
>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Given where we are in the release cycle, I think this isn't
going to go in for 5.0; and it's not really that urgent now
we've decided we don't want to actually deprecate in-tree builds.
I've removed the text I put into the changelog about this earlier.

thanks
-- PMM

