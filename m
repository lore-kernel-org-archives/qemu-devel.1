Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBBBC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:16:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566A72051A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcujWI7X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566A72051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGZO-0006Jg-HN
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFGYT-0005lg-JW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFGYS-0003Fv-5E
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:15:13 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFGYR-00039S-ND
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:15:12 -0400
Received: by mail-oi1-x244.google.com with SMTP id 13so6208821oiy.9
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bk1ENErmgG653L2khbmrWWyTsl/YXrFkVME0IDC8qP0=;
 b=jcujWI7XgkyvsFuwTXGRV6IMWze49tQHHtaig6wopyN091bn6vFgRpGz7zbcHoKju8
 mXMULaemsT6tAXNsb90QDI00N+/Db0wPdHflXQnBfW3+BiNevQsy5j/rVDLDA66OYw3j
 71ji0gY41UvYn82M74E8FcPJ/eSc2AaKFmu7PxBxFCKPnd1DV4slA9XCUZHQW89RbklE
 KjQXlmh3/VTknK29b2fSuuY4lWsZnPDi/ec3QpwmLdzAX3LvFgr5x8T7xllHfEibZwLu
 aCZDTN8HoGXg/FdFLNebCbgi1BhJ49q6rqmZkdDTTmO+diliPc6Coe1CASJs31zHrI05
 njNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bk1ENErmgG653L2khbmrWWyTsl/YXrFkVME0IDC8qP0=;
 b=AtSb9V/NQlx+MdsF//ESFDfq4ujSu/uQQ/34l9HjJAplINLnZCCWPyL2HKAt7/MWnk
 /phW0E+DCO7FLdUzQJqwxYvl6EAybFRiJPXDKngXZsS3j3akWNSd99+S23iSa/kvvOK6
 GrjjOHLzJlLGu56dAstryFZc46uZG1asvRdCyR/WuOsvCFculFpHpcO7wTx0z9xu8Xdv
 BQyO1x+qS2//dXdP3KyCmhwqBo7sx1llKYbFTi7AVMtSoOB7sEhlcXT3gx9XSXycKVlI
 0TF1otlHkAfhUAUOxOJpSVThirTL7rl4C5fseTag3BBmfo4ZjvrN126E6vBuVb/rrPYP
 /d3Q==
X-Gm-Message-State: ANhLgQ0cKvVyAKDRqSMnPAD0CXLobGTjjWSUnwVilNBxzdFEgxwUL8yQ
 +rfeOmmdkjogV+audWAuKhRxC6yZhtPSv+XKsJdVcw==
X-Google-Smtp-Source: ADFU+vumVspXTWKO+42Op0nLWNkr+AZONcGb+tarI+WGAe/u4n7GaQTqcHK4ky0laRedv0fIxw45BGKEjciKoSTsfAs=
X-Received: by 2002:aca:190f:: with SMTP id l15mr5843133oii.48.1584706508973; 
 Fri, 20 Mar 2020 05:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200320072547.19003-1-kraxel@redhat.com>
In-Reply-To: <20200320072547.19003-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 12:14:57 +0000
Message-ID: <CAFEAcA9RaPCWwx+_WyB_=0c2Q33c8PdW4y29FtC2q9pxWXs0hw@mail.gmail.com>
Subject: Re: [PULL 0/1] Vga 20200320 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 07:27, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e6d567db23219fe9979f16d74e13f27145f07f84:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2020-03-19 15:31:09 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20200320-pull-request
>
> for you to fetch changes up to 02501fc39381c4dabaf6becdd12c2a4754c3847c:
>
>   compat: disable edid on correct virtio-gpu device (2020-03-20 07:50:52 +0100)
>
> ----------------------------------------------------------------
> vga: edid compat fix for virtio-gpu
>
> ----------------------------------------------------------------
>
> Cornelia Huck (1):
>   compat: disable edid on correct virtio-gpu device
>
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

