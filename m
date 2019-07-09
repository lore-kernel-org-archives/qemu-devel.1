Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2DDC73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 13:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349FF214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 13:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PrDtSr3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349FF214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkq04-00072D-FL
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 09:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41091)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkpyF-0006V2-Px
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkpyE-0007Pp-8d
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:15:47 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:34840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkpyE-0007P7-16
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 09:15:46 -0400
Received: by mail-ot1-x331.google.com with SMTP id j19so1390863otq.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kVCfbcEvKpvYwCPIDnIzNNB0SLMcepGzbOHLyy3d6xk=;
 b=PrDtSr3DriEzya2wDWEg4XKHkM9wfWDB1gZxowrjCzYmEi3B7oTytnsMxBCLUdBEYP
 GmYypfuzevjJiMw2NIEJKgN8W6n8sjPxbXrYq4lPV20HM3ZpAfkqvlnK80WAacyOJ3WV
 jUAWmphTPRiUh51WIx8kLpIav6h88t+MOWtWqqy0RBXctvmk/Z25bbRxthaofyYYJLun
 n1SAzxX+8o8flEJ42wEczAWANAp7e+kcuf3trsIlGCHp0iJfJgP0UQVTrJ/iC5jwCuUu
 zl2KHg66g8rnGk6ZEqiXQ0dz3g0PKxZ9Sdx63P9Hbe+P1zQmQc8ZvZ5L+u0++B5AS9/S
 tnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kVCfbcEvKpvYwCPIDnIzNNB0SLMcepGzbOHLyy3d6xk=;
 b=qJ8h9yjcg6CwF4GexFDvRWUC4p/wq40EpCRfy/RZNDEr2hZgQpRRMLtAedFQMltjVF
 UCL8x09CqO6ljSq4JZEE3svyArwaL998mgpaJk3QneMuzKqqQGaUBvJkKe9oJVjqBr8Y
 5E4AIBvu9oyatqiNZNXnRcYnJCoWc2cT2XYYHhezrbdXJ1doxEsX0vxLXzxCW7sNU+Dp
 RBYgCnACqU8l2fh+UGhyhG7/Gpfv1WHXbT84IhZUdLIsUb4h+LuODWN42a61fuxpPMZW
 vKfgRqOwMwRgTJR360pGiLUNSSYgms6A8UvdH5F7DILwOvDEX6tADOV0eiz3l1e5cfV3
 UoQQ==
X-Gm-Message-State: APjAAAW4wwqt4ELyu13ljTUazJhFTKCF3/DubfyLnnL8Hhp1dn9ymvI6
 +EgOTfW7Cv+FPon4AGnk0CqFsNdUvy4/ygfIm0BQtQ==
X-Google-Smtp-Source: APXvYqy/Pj6ouH8cQZXymXiDqtnGG4SI7XJBPvdZil/00P9m8vTmEj5jd6Yl8f/MDte8wMD5zojwNLFCfKkPquG1r+M=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr19807130oti.91.1562678144364; 
 Tue, 09 Jul 2019 06:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190709122546.12373-1-cohuck@redhat.com>
In-Reply-To: <20190709122546.12373-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 14:15:33 +0100
Message-ID: <CAFEAcA-ceUK89Cj=dKodZ+DCnVr7BhMaK7ExNL_FJAhi-Ec6aQ@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL for-4.1 0/4] s390x patches for -rc0
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jul 2019 at 13:25, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 3a1acf5d47295d22ffdae0982a2fd808b802a7da:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-07-08 09:46:19 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190709
>
> for you to fetch changes up to 92b9afe45e10edd8eaed6329366201c2165a8065:
>
>   s390x/tcg: move fallthrough annotation (2019-07-09 10:37:44 +0200)
>
> ----------------------------------------------------------------
> Fixes in cpu models, tcg, and vfio-ccw.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

