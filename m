Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2020420760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7TvebXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2020420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLkq-0003jO-ES
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLjw-0002ye-Lu
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:28:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLjt-00031y-KZ
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:28:27 -0400
Received: by mail-oi1-x243.google.com with SMTP id j11so23836670oiw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nOpmnabgIyYuJchkjcJhs0C6qE6r/S0hcjNieOTii6U=;
 b=i7TvebXRhChWGiqHX6GteR2n8XogubWBZS9TQ/mG46lkGSc80VOJxbYsYGpjxWfA0u
 210XXo2Spqu6FTcF8VmdVU+jksS1D5e5n2cVw3/kR8y7dCklqHl5NdwPqGlJajxP1xM9
 4soVTJJHtNi//R1NFaUcvWYidwBnNnnTala3Q8HeXh7O1NPk81/kPACxrVP8AyCuwokW
 iucGzsZUWWU41blL6Qig2+7Zavh5svCtFWnHDVBEppHMIbPz55ejcIRDIfEye4DDSvvb
 mtwOKlmIqtOW9mkIEEorYQZyzVfBsdqJvs9CJcAdFFIFkleKlLFYy33pKwjSf3N2FSF+
 Pw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nOpmnabgIyYuJchkjcJhs0C6qE6r/S0hcjNieOTii6U=;
 b=ZZ3MzCbpExrj99tkjfdg2o8CxLi5b8z+8QDPR6FutQ++mroRNQD4+Mv5EwWPkEoPYV
 ZPE6ytqw/rykNrAtmFpfGXvLXF59VmLllw46v46OVKi81y45Kn+7XiO3IpLSBGdZZB1s
 cPjnpge4ky9txlyuE2yXYvy+ZgdNPLCgYMSp5Ai1FbIX4h60Tbf/Zs79Wb8qKzRdCMod
 AftPgGFklJQkg2n4n82M1NxmhAjcxU7FsK7Pv+W9j6QN/8m4S2qKHV7A3ct09m74rS/V
 W0gKC2Zvp3oYBAuQ/fSRxT5JHVyrXmEcWUSRNrAozDdcGE0cFi3N/ki0ECI/cjUinFcD
 oCyg==
X-Gm-Message-State: AOAM532Z/MoW88V08Hre4JbKnsMT9LWx7vqoBiGwHoc/DD5ZQNzLOXAN
 vWZmKv/GtAjia6G7eQdrqhTVwTb2B3iDrL12crIlmg==
X-Google-Smtp-Source: ABdhPJxC+AjGDEA70X68Axd9AmgMtheJmquwcQg0MhFSeVTtgHgC1MvL75KRBc3Vo6zfjJjrnYkk4WB+clVjcCeGIqY=
X-Received: by 2002:aca:1706:: with SMTP id j6mr509722oii.146.1593782903948;
 Fri, 03 Jul 2020 06:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-16-f4bug@amsat.org>
In-Reply-To: <20200630133912.9428-16-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:28:12 +0100
Message-ID: <CAFEAcA8tWKTq5qe8_JufgxhZo1X_CuCUCoO1HsEyxOSbzWDOhg@mail.gmail.com>
Subject: Re: [PATCH v7 15/17] hw/sd/sdcard: Correctly display the command name
 in trace events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Some ACMD were incorrectly displayed. Fix by remembering if we
> are processing a ACMD (with current_cmd_is_acmd) and add the
> sd_current_cmd_name() helper, which display to correct name
> regardless it is a CMD or ACMD.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I think my comments on v3 of this patch still apply:
https://patchew.org/QEMU/20200605102230.21493-1-philmd@redhat.com/202006051=
02230.21493-10-philmd@redhat.com/

thanks
-- PMM

