Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CCBC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9841C206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQn3L5nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9841C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQNF-000209-Gm
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnQM9-0006On-CX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnQM8-0002Hl-6r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:31:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:32818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnQM7-0002H5-Ud
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:31:08 -0400
Received: by mail-ot1-x342.google.com with SMTP id q20so21726069otl.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VSz1VqOqD40aBjneZfra1E/jcK7RSgKE9Sw01p8enxo=;
 b=BQn3L5nq3Yr+KNZHT2FjoPyaIsGXJBrOcEH6ItsvR8Nz1UIytDbygrO+Rx5+dEpVo2
 BLSVVMeh1zI/3rEWdTa7z6kbDeEf820TIlVqI8i+hqnPn+OS926ViGCp4PnkKdcJ5017
 TgHl4zAiC6Xc3gdTFXsVanSu28yI91+8orIQb7vZIbIFzPHTElhjTYibTs300evT8+xL
 9V4XCkx7BY4CpYOuysRFOcT3Nq+2Igf8dtZOWy1k2SrqImDAVYuLS1Sj/JwiuANh4gPB
 CNOqwCmv+Wtg/FSF5dTo3bQLvZnQvQmchwPdCI9Ve9hoR2Py2LK0OczT1uZOn9wIrZHj
 R56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VSz1VqOqD40aBjneZfra1E/jcK7RSgKE9Sw01p8enxo=;
 b=W9rpsTrbORZIHpS1WeFQufSzk0TgD4DGAgq5A9G6n+b17aAbf67QYsYVyG77SJuDsV
 fuWhMvQheJFfBpR05J4zeI/ay8KOP0FiQxbuIQk+L1JdQ3TwYyLE8H31mG5O0YKtsP07
 ZZ/8ZTooT6otO//XeVGRy6VyEOxjSnGyILP3TH0KBMHf/aVi+iQf1uQYsq3m3HiDy/OP
 iqgDvtKsKfX5V9842mOzhCMbb4qVnmgF5koXm1sFXbFpEwDK8xK+Lw+AsKNOXIQniPNe
 kodn4ABkEKHV+HMER5GEuHpdlMJpW9o+31NRWQtzdDkMkOJkPYSz+rn4PhCLDVg4m0/l
 DU1Q==
X-Gm-Message-State: APjAAAWV1CK7z1DMpjCdSAzzDKj8XbH+hWd4xKampLwqDHvsm0pCA9Vq
 KkkXeHYFYadRCwv+xRnr1jTYjOYO/mFn72QzVGaaJw==
X-Google-Smtp-Source: APXvYqyoDlW1Jr/Y6Ua9eVb83btQ9KjVkd1pa9xv5HwL5grQiX/DFSlQbbATo8eDqIZ7bS66qbf2XcVnOw68ovFrB8c=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr4141763oti.91.1563294666903; 
 Tue, 16 Jul 2019 09:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190716160143.394-1-philmd@redhat.com>
In-Reply-To: <20190716160143.394-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 17:30:55 +0100
Message-ID: <CAFEAcA_JTBOUsC5K0JrX_dV+STWJv95nzPLfc+ktP6=pR4rjHQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 0/2] pflash-next patches for v4.1.0-rc1
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 at 17:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit 697f59243f5a28b8a243ff5ad59e34bbecffca=
e1:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2019-07-16 15:08:29 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/pflash-next-20190716
>
> for you to fetch changes up to 611c749c3b86fe377c94ea301feab3d9ce3bf617:
>
>   hw/block/pflash_cfi01: Start state machine as READY to accept commands =
(2019-07-16 17:54:06 +0200)
>
> ----------------------------------------------------------------
>
> Trivial pflash fixes for rc1.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

