Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1E9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E3A206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beZLCNj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E3A206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jom4o-00058A-HC
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jom3z-0004Bd-MN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:58:31 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jom3y-0005Ql-AF
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:58:31 -0400
Received: by mail-oi1-x241.google.com with SMTP id a21so7687484oic.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/5Z5SdaTsCaKDtDfyJe4e2nj6mxnbAhmjCKC/915jtI=;
 b=beZLCNj0HJ+v6LJ04dDsCVrW2bnCGzQJRMOssnVz20YtOcdaG1DR37ImC4lv0TATXd
 oDcU9cA3Nrn+5kNt7qU/ei1zXaSnfcWlYNMYcSaiK16pHN4mEElefj0VdJkkQJkzFPqM
 1+pZibKUvomUMyNIGIAlaPWKWVsL/v9R2Ufw+TLgrST6o9D9kfqCHOFQTtD/+lK3z7mr
 wgh8sjpDXy+lnK5l8EVQ/qftexKkOgsbmh7CkF4s4PJLyw1D/idf9QfyhvYz6q4phDct
 mjUXHOc0DN7Dj9TJLuBQ0ZbwvlD8sIqPt2r5IU8fyrP3/sZGlSGAfRhf4Gbs2dMQzeJM
 X/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/5Z5SdaTsCaKDtDfyJe4e2nj6mxnbAhmjCKC/915jtI=;
 b=YZaiXsiW3Gy2nBWIDvxjFFTFQjSce4OxrTR3qSECK9yVrWkgO0SNx3JMByzt0dzfk6
 0hd1zIjBLa+MhcyZz2y4JPq28nOpoWbQHcPRFsPtP+U/Y3S0LncGbmS32PpfgkON3Fdz
 9CNdMRET/qFBb9IxLr0i8VYtB1dEsDasqrpTYd55aOvhBavYoQGAepU/Sc7VqEHgtD6V
 tZOq/Voil/qVeguCPz7bCadov1yH62RwmtmFyAZo5CPGL5IUMvSmn9bbBnoD6mzjDWqq
 grAAVXrCg9EbSaM9EbyszpXsod08OJ0jscAMWDv/CbHxKxEEQKpcfl/SzcF/bIJzW1+W
 jodA==
X-Gm-Message-State: AOAM5309Auq/1It6u2xkmsqmuzlIGiBfcF5fnNC2cLNyzpDA0SHC/mZc
 yw+sING88iskjXXGzA8M88AClMLAW4iFnwrQsYy9GL/xKQ0=
X-Google-Smtp-Source: ABdhPJzB4Vl5GTl6F4C/KBux7jIKmk4Gwainz5s6WHAwdhiywendX5f9dOtzdnHUzFv6RdoE6uQ6fL42UbIImlhBEQI=
X-Received: by 2002:aca:568c:: with SMTP id k134mr1793487oib.48.1593169109139; 
 Fri, 26 Jun 2020 03:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqzxVaM2UHMjpOiwL-bM2GZb8KwSrXf1=+LTUy53mZGRWw@mail.gmail.com>
In-Reply-To: <CA+XhMqzxVaM2UHMjpOiwL-bM2GZb8KwSrXf1=+LTUy53mZGRWw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 11:58:18 +0100
Message-ID: <CAFEAcA9NheeyXgiU47nhS6t+vhH7BmzGKcsB7K+_W+S56KjGMw@mail.gmail.com>
Subject: Re: [PATCH 3/5] haiku build fix
To: David CARLIER <devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 11:11, David CARLIER <devnexen@gmail.com> wrote:
>
> From 56890fa5728d11c72232348b3f3273e2df31c197 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 26 Jun 2020 10:40:58 +0000
> Subject: [PATCH 3/5] Checking mlockall symbol presence
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

