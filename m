Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9308C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BDD208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaQke6dE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BDD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Z2-0002q2-UU
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:41:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j58LG-0004t5-9M
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j58LE-0000bH-6d
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:27:42 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j58LE-0000aP-1i
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:27:40 -0500
Received: by mail-ot1-x342.google.com with SMTP id j20so1987225otq.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GcZxewW97JwbXBI9Jf4ucP4HObqL4qhlUk8b37eqWaE=;
 b=EaQke6dEVEIfSlUCEYlEOCrm21Y5jNu645BS7B5Mnzpmd5E2LYse5PqMqaOyyyqmDT
 TH7PxB7YmqnbXHmCGANaHZpdSq7t/39bv5MdANyIOCN17/nrfpT8tAVQn/oMaqPlN//9
 OXX1UW6PhacNaddFOgeMhRfSWdETi+CbFocGnoS2Cjovmjb35EIC+0vq4M3U4pbBQKiI
 OZIJvL1O8PWXp3/dMYzQt8cultORd+/G6YtE1bktFoY2uP8ICQF+ruP/qknsB/tEbqdZ
 6Ky4zmDNJ92dukIDOwfcLUSUy0w55R5oRMlhYcznXQHoXsAb12qMgfIHeJ1adbyj2eD7
 HNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GcZxewW97JwbXBI9Jf4ucP4HObqL4qhlUk8b37eqWaE=;
 b=RQEXOq1b7b+DHh1sjUpPRgc7frF4fW0R9rcASMJTsyK3tQlNYgHAaCWp4H9W173P4s
 4nifsJndd7NJ9SHJURANqxs/LKbgibgzP9SZ7ncdceFCwp4mkd+VIVUUtSFdOCDVv++1
 vALNSeqlhPZgEvNx4x9rpDtzkfluSb/WLIN7inuf3R2GW0UHEF9p6RTWc8TOnMdjpOha
 8mFR7lMfwr2eCF52c4QNSClfWmtMJ2VCYNHR5bcVKCEd4fgUkBDmilgDM6UZBjQkiDE7
 AH/m70/uRkk8s5thbH4nsmyfeTv3rFOhoNpV8EC5Ms/BXxZt7HXgq5/p9z6d+jScQyqb
 DeSA==
X-Gm-Message-State: APjAAAUm7kPz+vBxkcZk14C0sbApb25Ut+r3DqSfqwWnlZhBLjBf6r6O
 Z3v4djS9EJPtIAsZoT+O2MuSkuifoY92Lpz/yNYYSg==
X-Google-Smtp-Source: APXvYqz5HW2iBdoJXnQMnJKVFmuAM1tOrKgk9grvbf4yRBrDWPw5KJab9RwObKaykVxmYmVaKhJy50qga13fT7sFRsA=
X-Received: by 2002:a9d:68d9:: with SMTP id i25mr16064912oto.135.1582291658882; 
 Fri, 21 Feb 2020 05:27:38 -0800 (PST)
MIME-Version: 1.0
References: <20200221132550.22156-1-philmd@redhat.com>
 <20200221132550.22156-2-philmd@redhat.com>
In-Reply-To: <20200221132550.22156-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 13:27:28 +0000
Message-ID: <CAFEAcA-23doj0rrDnPTyhvWH25jEjafev2Z-pJMR1oyqGvW-2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/dma/sparc32_dma: Make espdma_memory_[read/write]
 static
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Feb 2020 at 13:25, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> No code use the espdma_memory_[read/write] functions outside
> of hw/dma/sparc32_dma.c, make them static.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

