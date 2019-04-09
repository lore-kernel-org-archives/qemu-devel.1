Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCCDC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C9E82084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+Kc+5kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9E82084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42143 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDrJr-0002cN-96
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:01:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDrIM-0001g0-SD
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDrIL-0001MH-Pn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:00:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDrIL-0001Kn-1Z
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:00:13 -0400
Received: by mail-ot1-x341.google.com with SMTP id o74so15627762ota.3
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=aZzWpAxSSq/KWwQSdBLf3Eju7dGP3ee3sGuLg8uzzXc=;
	b=o+Kc+5kl8mJKYLt/QtGsqJ/0HFuA7Di2Z5H1j8e0SkSseshVKSNSoNae3ZL4vfOVt5
	J9dvYV/0fcYrTok3IyeT9Lwv/ddaNIphkfYhpsnK2mufm8D5k2Vxp4bj2Fp6xI0m9wl1
	YIR94AD2zkD/2GLmT+XWJkAc1TKl1yHnCPQ7mDwX1rFWU/GFHlxKlz7WCJk0y6BPRPim
	qpVRN1Ez6LrPno6RlA/8pAVFt42O076DmrIFBkPpE7/Nrxseoqcctx0shy60sSMQK45q
	tF3OsM4KAJEvR7hSqamNxlzP+CH01sb5uXAHoXtrmdMeTOCMptOEfRy3OhILzPYiXn1q
	f7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=aZzWpAxSSq/KWwQSdBLf3Eju7dGP3ee3sGuLg8uzzXc=;
	b=JYcqx2AXiOrGW1o+Kic3zrfJNN2snDEQ8xoXvkbZDI1N/YWmebaNQS6rVnzbTJZxcX
	vemjbQ1ml+wfN5zo1Zpg5tNPz3I+tNkWxFh1WUNnz2mlnEEEFYCxTZWJwtaofoig8nLo
	hHxxAgxCSDkkmC8c0oK7c/mEdb/zs2F+JaviYVS4H5hqK+LMcdJvdfyjlFBJ8dQaYELG
	qpXUpFe50WZEqMa1J1tbqFKd4Xg/gVB9VsUmE3Vh+x7iQ/Ltnjvds/S90wb4Idc4khOG
	Ztnxoh2U3gzwhkCn/afUizSjuhp7p4sqClmY6oLZ5u2NV1HryehmwfaCc/Mg5gBPdFkM
	gdnA==
X-Gm-Message-State: APjAAAU9wLSKbCR3AJXvJVnFj+6IHHj/gli3q/oga+akjHuPX/VnUpP5
	PCimPVfADzPfYR/SAkRy2XjePixChzouiMwhp9uzjQ==
X-Google-Smtp-Source: APXvYqy7qXo5/SpWHbaeaoF+fB30Ug6pM0KbeX687yaVdi4hsEFNPUYjJjXPJQn0JqzsV3bha4XvdZ5rT6D5QxnRVdg=
X-Received: by 2002:a05:6830:164a:: with SMTP id
	h10mr24664463otr.323.1554818411746; 
	Tue, 09 Apr 2019 07:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190409134536.15548-1-philmd@redhat.com>
In-Reply-To: <20190409134536.15548-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 15:00:00 +0100
Message-ID:
 <CAFEAcA9pc3Dw_X5b74+av0qq5hM7wB4uixSuh_TLwHAm8eGsqA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
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
Cc: Olaf Hering <olaf@aepfle.de>, "Michael S . Tsirkin" <mst@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409140000.yLg_GxTMGmB6DDu76wYE5LptTh_IqMRfyrVJipzuRnM@z>

On Tue, 9 Apr 2019 at 14:47, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi,
>
> Two trivial fixes to avoid the latest EDK2 testing series to
> cause trouble to downstream distributions (in particular if
> they have PIE enforced).
>
> Since v2:
> - addressed Laszlo's suggestion
> - reworded patch description
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
> error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00=
992.html
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   roms: Rename the EFIROM variable to avoid clashing with iPXE
>   roms: Allow passing configure options to the EDK2 build tools
>
>  roms/Makefile | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Thanks. This is one of a handful of remaining bugs we
should fix for 4.0, so I would ideally like to get this
in rc3 today (or tomorrow if we have to slip rc3 a day).
If people wanting to review this series could do so
promptly I'd definitely appreciate it.

-- PMM

