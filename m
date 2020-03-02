Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0037C3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2DF21D56
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 15:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lz2Hi9WV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2DF21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8nCl-0005k4-Mo
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 10:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nCA-0005Ke-W3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8nC9-0008J6-OZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:41:26 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8nC9-0008Iq-Ij
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 10:41:25 -0500
Received: by mail-ot1-x32e.google.com with SMTP id v10so2863434otp.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 07:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jUkERWRGFv3wMH2pX+xN65NMrzb8iPadHK6G1RUJ5VU=;
 b=lz2Hi9WVgnpzMYGrJwqGbAxrFtxYyP79UED+DT8zJaiMR4I/VlS74LuObzGKa4XXgk
 +4Fvop739a/+4XKzI+5tupCL67fDiQgDjfxQ0+bbwh7zkT7x4Q7ORzk7XYnTINnt1jxj
 jtjcShAQ1B1VCQ9X7bhOgKpVM01Kz3dxMe2uAuXUMXZiSCEw4T6CCRv9mFvL4a0SLP7u
 wydnMRuoHDVu9LgTcEkTlkzeRY4Krh/Myls3xf01TqXduLUUdvoNa4UH4zrFG16DsEFR
 x6sVIshuGohPBSxptjm0R/0CI+wEJ8OhpgauNMoM7MVSJH7OhKIjMFau57TZHvizcfjk
 6LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jUkERWRGFv3wMH2pX+xN65NMrzb8iPadHK6G1RUJ5VU=;
 b=d19aULdED88VciJo00yNVXU02HodJUJ3HYMg9xnRmD4myHlFiXcxuWZx7mIV00ZhM/
 a3d0MMO3cnFm279oHoMUfeKRgvD3xtRIgHQgcwUsfsfOCeIAy5nUCkNRIcwlyM75uGw6
 utnJpk3mdGPDjIs8Y6WvF3RMdvRuLyIUhGpYfBhfTGFtpN6qZTdpHYyVODLsTnSx2j0i
 a7710+I4xDDyqIidVIyll2M+JWo4E28qxXljSVxSr89vaO5/9tfLB3y2M2wi1os4aE6K
 2eEVOFJLU4N+2pDul4Btdf6VlDqVZO02g7KD6JiPXD/+KNZTj6dyuKDPt26SY3jtk0F8
 jG6Q==
X-Gm-Message-State: ANhLgQ3k8gbM4r3HLE5TXM5dDDj81iD35OPOL/7xbMlsp2Gwq+g6lanJ
 b8LKfsORl3dBWspDFayzbnllXg7NOWps2mwQHiiD0g==
X-Google-Smtp-Source: ADFU+vs1Ld6zJhxMzC0G52HF5I9yjrcSKwqasBJav3FWnLju0dknEb1+FvZ2gVcAKdr7lsgJEJSN7tilUhCJrd4WGKQ=
X-Received: by 2002:a9d:75ca:: with SMTP id c10mr2489140otl.97.1583163684298; 
 Mon, 02 Mar 2020 07:41:24 -0800 (PST)
MIME-Version: 1.0
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
 <1582631466-13880-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1582631466-13880-12-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 15:41:13 +0000
Message-ID: <CAFEAcA_0y0NsHfkK2V4-PTYe0fiOHE6x00i9z7am5+Kvg86PNg@mail.gmail.com>
Subject: Re: [PULL 012/136] arm/cubieboard: use memdev for RAM
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Feb 2020 at 11:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Igor Mammedov <imammedo@redhat.com>
>
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>
> PS:
> While at it, get rid of no longer needed CubieBoardState wrapper.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20200219160953.13771-13-imammedo@redhat.com>
> ---
>  hw/arm/cubieboard.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index 6dc2f1d..089f9a3 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -28,52 +28,42 @@ static struct arm_boot_info cubieboard_binfo = {
>      .board_id = 0x1008,
>  };
>
> -typedef struct CubieBoardState {
> -    AwA10State *a10;
> -    MemoryRegion sdram;
> -} CubieBoardState;
> -
>  static void cubieboard_init(MachineState *machine)
>  {
> -    CubieBoardState *s = g_new(CubieBoardState, 1);
> +    AwA10State *a10 = AW_A10(object_new(TYPE_AW_A10));
>      Error *err = NULL;
>
> -    s->a10 = AW_A10(object_new(TYPE_AW_A10));

Hi Igor, I just noticed this, and I don't think it's the
right thing. The board model should have its own state
structure which contains any objects it creates. Just
because there happens currently to be only a single
object in this case doesn't mean we want to lose the
structure. In particular, we now just leak the
pointer to the TYPE_AW_A10 object, rather than having
it be tracked by being pointed to from the MachineState.
Being able to avoid just leaking pointers to objects like
that is one of the reasons I like having a MachineState now.

Could you send a patch that reverts this bit, please
(and any of the other boards where you did this in
the course of this refactoring)?

thanks
-- PMM

