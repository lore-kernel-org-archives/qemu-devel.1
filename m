Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4794DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CFC207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti7AcqRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CFC207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkpn5-0004Et-AN
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpmH-0003Fu-3w
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:07:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkpmE-0002SB-Kz
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:07:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id s13so13177220otd.7
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 07:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6KkiC4ZvcCbn4Sxf8oUYD7MZxz/e28Wr3gAt3SWDtEc=;
 b=ti7AcqRDHgZ0A32L3+rr8+lPWtDYy+Ct82h/xPjXo/13ntWIE6iRwx5cjs4o0nrvUl
 T+VzxSZQ087vlpVplfCg/Kag1cgevnSkF5cC7ou6jajcsdVX+5JtHiJgk8NNryFJESEE
 VxTUv42JtY4lh87IzPM18QoRmr3yrQrV1lzx9Fr8GrXM/EDlAFLJxuzKl2rQ0fLDwqIz
 tCbQMKNM1V6ApaRsFHtdL4jLVNNu6ibYHFbHjFuXICszFrhNRn7U03ZjbK7VcMXVbP/O
 db2ZaQmF8VJOBhz3hzDn3RXgrE9SXb8En7X8Uqszw9Jo1VTyXVHRBcHh0cWuXaiaU6t5
 EkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6KkiC4ZvcCbn4Sxf8oUYD7MZxz/e28Wr3gAt3SWDtEc=;
 b=tSxQgLm0OVyuq9TNuIpy/SFKBxLVpU0H7b3WHPCR+SkP0FD7SCc0Dc0bT9glNfRkaK
 7ZAcxrGPCewkznYBIJRF4f/2m9nvt1pIGtRch+Dua/1fCb+T71EjnsROIrznUCuk7yar
 1DkEa3UnIzn6b/QzGmtqrwaQsz1V+pXnaGjndJ1ilk039zaioL1sqheqbwGnTlMkl+XI
 u66vdB3arlnCmfr79oQx6zF8L8nob8e2f1W0gSh1Qrj8Cliw7wvBw32gmpy8prjl4ZMj
 p/xPVjVGyzV4Uv4ZyCCLBdQzK6Q1bLYWDHcgqM4QzDNYz++sMyMhlwaRO/pzIHzMc8KG
 ctng==
X-Gm-Message-State: AOAM5319R8dPOkPJWkMVKJjyTpLs5UOMx7a6v/1GVEz3r3lafYk+DyX9
 /qeAbfLS7aJXiQkAc64MhA1b/fXRHAwvcv8D9G7fXQ==
X-Google-Smtp-Source: ABdhPJz1D6ZlkxZHc29KN5sinJgpslVNB8RGF3vUT/SN2cnEWtwpYUmaoavm7ep/pV5ODpSFBJk/lfHO6EAyVp0Hu/4=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr21370781oto.91.1592230072907; 
 Mon, 15 Jun 2020 07:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200605102230.21493-1-philmd@redhat.com>
 <20200605102230.21493-6-philmd@redhat.com>
In-Reply-To: <20200605102230.21493-6-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 15:07:42 +0100
Message-ID: <CAFEAcA9jGtLCA5ZRGE+qRpP-W7gyMMQMmXRHCcAMpR_jabk44w@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] hw/sd/sdcard: Update the SDState documentation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 11:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Add more descriptive comments to keep a clear separation
> between static property vs runtime changeable.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

