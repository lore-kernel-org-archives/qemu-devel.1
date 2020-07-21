Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6535AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2972073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5Hr3dOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2972073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrjx-0005RA-EC
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxriJ-0003C8-BK
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:49:43 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxriH-0005s3-Ll
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:49:42 -0400
Received: by mail-ot1-x344.google.com with SMTP id h13so14952989otr.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2YTOEYkSLxB/0JxW+ThRFXv1GQARK/n24g546JJKt5o=;
 b=Z5Hr3dOXt9nsAGu3iJgJmW0Y2gN9rRDu/mhTfCdnK6o2LGaiGUkIGb84zCPul6xZPw
 5R3npiPyEOGwidmLlcGbWC3j+NsRkdwAlptGI/6i9+AtMuBwBstbJQZi/UpB3SB+ey/w
 HPxyUa5FkuXjbtc7MHD5no1w81kRAeuonU4nduoXFNycA7RoeneivpJp3b5EA5sFcTCp
 lLHzURxQ/8F+asMJbl+hWKslnD6L/errZbb1ycFcGUt3CbijqRh+6w5aNFk94l8q/cOX
 dHT1n7hNj3b/0y1WfFR/XAJNa/10pjnTi7liYbRgs0ZlvCD+p1Bm1fXCwIApJxS4nlEf
 YLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2YTOEYkSLxB/0JxW+ThRFXv1GQARK/n24g546JJKt5o=;
 b=jDessbjpZxCppRatTNKT42UGhYn5lzNwjnxef60F5CMW6E4+V4xPpG3UqjqQPX7u4a
 eeNbYP3OxySjyLVxjWOBaBQqRux2RraLPtB6VEbnkc+f5gomuF6cJ708nJxBrjuICE/6
 CXbuE2S5kGEvyb5bQH0Zb+8Mxcs8tWCJ80ZBMxwhKG/xO3OxRH6ad/gAzXiH7a6FEHak
 zdzr5HLcS4lxmr5LZh2Z84jQg+4wd3LxNAUaQ2dnBIlAuDUT6KGfCauA/94xE47oRg9T
 HGniIxKAAqJz8QGn1wlZESKLW/8Df5k4hgiSE9dCRDQkff6Ij/HbQ9+VF52jIFQJ1fAR
 j65A==
X-Gm-Message-State: AOAM532uWHLeMAn7lk5pCbXgjBL3d1mfyF8KV9Axzd9GkqARHHCa6rmW
 riGOc16ahjfAahpO//DF57E/T8NceTXPPmcSFUdC/w==
X-Google-Smtp-Source: ABdhPJzqN4D2mKN8fUBkEUdXRaNMdD+3H0s9LqsLUrwlrwmxdaaCio9IKwlWQIIREVWvZ9N3ZvsUByBeLhVC6mhGOTA=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr24963119oto.135.1595335776322; 
 Tue, 21 Jul 2020 05:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200721123154.5302-1-f4bug@amsat.org>
 <20200721123154.5302-2-f4bug@amsat.org>
 <CAFEAcA_C1C-5oSrEZgJoufCc_91TdC3vv5+SUSBHHnWDGVyOCg@mail.gmail.com>
 <1e60f58f-b4b1-3490-5485-d51f4584caf4@amsat.org>
In-Reply-To: <1e60f58f-b4b1-3490-5485-d51f4584caf4@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 13:49:25 +0100
Message-ID: <CAFEAcA_bDSqH=JHWJDYAehov8p1VHS8rjMFWp27-DPi2Nu8nxQ@mail.gmail.com>
Subject: Re: [RFC PATCH-for-5.1? v3 1/2] memory: Allow monkey-patching
 MemoryRegion access sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 13:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 7/21/20 2:33 PM, Peter Maydell wrote:
> > On Tue, 21 Jul 2020 at 13:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> > Don't you now need to g_memfree() mr->ops somewhere? Otherwise
> > you've leaked it if the device which owned this MemoryRegion
> > is hot-unplugged, I think.
>
> I haven't thinking of hot-unplug. I went with the simplest fix
> considering we are in freeze, and fixing the bug was more
> important that a leak at this point.
> I'll have a look at freeing this memory, hoping it is still less
> disruptive than a proper architectural change to fix this problem.

Instead of g_memdup()ing the ops struct here, you could maybe
do it in isa_register_ioport() instead. Then you don't need to
worry about leaks because we know all ISA devices are not
hotpluggable, and the ugliness is also a bit more constrained
to the ISA code. (Coverity probably still thinks it's a leak though.)

thanks
-- PMM

