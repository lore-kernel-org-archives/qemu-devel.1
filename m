Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04625C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A17B20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsDfM3zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A17B20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHr4b-0006Xc-A0
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHr23-0003oF-Mq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:08:43 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:38269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHr21-0002ZO-VK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 12:08:43 -0400
Received: by mail-ej1-x642.google.com with SMTP id i22so768454eja.5
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DFrBuGl0omN2QNoTE8MXvEPgYMm4dgEa6sRRmDOujOI=;
 b=FsDfM3zniTbsAvBJdD3cRnE05r/j3Ri7GisSSH7JHKMRhvxiMiTkyy/0rJ5+jgqEuV
 7jZkCbPmbQLo9ld4eUUYOKQqA7D5+zUUD1i13jEDLN1TbSvv979QNeo36DkuPS+FMPio
 3/0pLIJeShDqZyzanFcTmmG3dtK9DAMjlIAOnUb6kLlDeMDs9GjjSZJtMDbU4s3pIw/W
 A4y87nMlxBJ7T0giWLlkeyFJPP4IG5/YLVMrx6BZMyH+M3mxbZALf4k7tIrQR2oTz7WR
 fTr8bIuDqyZPkIx5OjeTKq1CdVamPZ4HCynlQLH5/Z1vCfS0/6BkVwYVPur6cLO/VLVI
 B5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DFrBuGl0omN2QNoTE8MXvEPgYMm4dgEa6sRRmDOujOI=;
 b=ZY/Uy97/jj73O2SneMynuaINjpVoTBssJQcfBpd+7QIqkYcXzuYRc+EyFJsthxUG2J
 x2wJv4ma8Rvdk18jZ0MyBx/snkHx3TV8TewylHqyXcGnzX8qDJDn8Icaoi66DCJGLHZ6
 +3H7llHUJwmfLeZ5YIRNIhTul+5V0MZZxTiR1uKSPUA2nb1veUP9OvZzseHHRt/Pz7g1
 2nGHwucEQm9Dp9Y+J5CIpbKss0pqPTJLXaG7R3RB951JMKTwLjCrk7V0/lRr1n6ClQJ5
 t8GiC3QflaxSS0pW/sngizHqPBiMabhxXuraLIyK66pGdX9qFPU505tp4XN8xW9aCZJY
 085w==
X-Gm-Message-State: AOAM530A7n8G74drjEIT4Y/P53YCfZ/kLZZibYQSfCxbSFPbcJRQ2r12
 LpsW54+/4iqKusG3afEZO+wkWWEx0RA+anA26tNVLw==
X-Google-Smtp-Source: ABdhPJxRKozBMI0lnvhaSbCvMeXcRded3CyeFcEXoSDt+tK5rexYHoNzqq9egxrPBYHOa62kXvrXMze5vpc95pnoVYI=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr15079935ejk.407.1600099718533; 
 Mon, 14 Sep 2020 09:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200914145606.94620-1-mreitz@redhat.com>
 <06b0ec10-34d0-05ab-7511-ac7878a6282a@redhat.com>
In-Reply-To: <06b0ec10-34d0-05ab-7511-ac7878a6282a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 17:08:27 +0100
Message-ID: <CAFEAcA-okX+R9+UvtqsJCDJDP_7OSqPOWu-BFReSX225LOkH7g@mail.gmail.com>
Subject: Re: [PATCH v3] iotests: Drop readlink -f
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 17:03, Eric Blake <eblake@redhat.com> wrote:
> If CDPATH is set, this can produce wrong results.  Do we care?  Probably
> not, since (as you point out), $source_iotests has the same bug, and no
> one has complained yet.

This has come up previously -- configure and probably most
of our other shell scripts will also break in the presence
of CDPATH. I stand by my position that CDPATH is a bad
misfeature that the shell should not be applying to
scripts. If anybody ever reports a bug we could I suppose
unconditionally unset CDPATH at the top of all our scripts.

thanks
-- PMM

