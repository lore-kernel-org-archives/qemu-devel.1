Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3227FC3815B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2978206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5Ppq2U7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2978206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOniC-0006my-W3
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 15:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOnhM-0006If-IL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOnhL-0007UI-1T
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:27:47 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOnhK-0007U7-SY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 15:27:46 -0400
Received: by mail-oi1-x244.google.com with SMTP id t199so11118856oif.7
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Esacg2U+BIQ4Ih0BOJph3Mlo7BtTZQt+5Q+g/MqbbiM=;
 b=T5Ppq2U7noiFa9TkQcEKBIhgV6R8lSD2+O/r5siBIdvoGyBJuxCNhVPd9tSndpRNN6
 8VrsmQMnmn87jhGqP/XBxmnG9VbvtznKAQLT1XfRvMY4yB5k+qvYJopaOFl3BqnSZKqr
 cbfXfo8t+eUmIZl4+A98xI5B+xue8FK8Fow7CscbCGhC3Kxsf3WscNwu4RYbpmsuSffq
 36yQpynfKA9kZh5uzTsaDKNLq5m1CF3W7f3pfn4FnpL92rEpzQQwY50JPpGPNAzUzlwh
 R0RmB9itKey1WyLdrPRRIx8NwPkYdV7BJzOdA/U4d8deGtVMP45Uja3i6f3GfQQXIFRO
 b8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Esacg2U+BIQ4Ih0BOJph3Mlo7BtTZQt+5Q+g/MqbbiM=;
 b=BSZCd+h28Xjg188DO/TwRErc6qqA9sb7mwRDkBg58ga9JEHKDo125skMtT99mj2M7P
 300t/UaOoqZ7i2IJtF+KO/mVVAw5ZByyD4mATVlcpegCxU6ZSenmeindpidLivkKoFOq
 QokdkvmV4vCYaCQvXeDDx9AcDPclprjeZcDnrie8Wk84zL0GJgWkFY9Wv+WOaht04Cnd
 oLX61BLR4S4RAjZ84zjOGdWcXjbLUEz0dob7TcIw75laVpgv0afYS1cJ8wCy7lzNEdv5
 AM+7WdiQ6JFv0xCis0633Dr9Fh51MpamhpUl9CVehAtw959AT8MkK/8yYZZIIZ8Y4zZ2
 65oA==
X-Gm-Message-State: AGi0PuaqTW2cHRTpdoHr7tGqJn4VTZ3dyzQB3BvyyRLkXxwLUnurRGYM
 vWXLtLEh9a/wYju/teCVt19ehdN/otCITnRcIzQ7+w==
X-Google-Smtp-Source: APiQypIRvQVp9qMJ5uZHJmi8x8P2rLXjAfoDL0g3F79wHaEwZVtS8UDVxufc99Klk3d2pUVqaLCLIWG+RVIRW+1GREk=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr607457oig.48.1586978865962;
 Wed, 15 Apr 2020 12:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200323112943.12010-1-philmd@redhat.com>
 <20200323112943.12010-2-philmd@redhat.com>
In-Reply-To: <20200323112943.12010-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 20:27:34 +0100
Message-ID: <CAFEAcA8fqJ63m4gtWwUm34Bgz5z9tqq6r9o=Nmai5NKDcPO8cw@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 1/3] vhost-user-gpu: Release memory returned by
 vu_queue_pop() with free()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 11:29, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> vu_queue_pop() returns memory that must be freed with free().
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Coverity (CID 1421887 ALLOC_FREE_MISMATCH)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 4 ++--
>  contrib/vhost-user-gpu/virgl.c          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied this patch (and not any of the rest of the series)
to master for rc3, thanks.

-- PMM

