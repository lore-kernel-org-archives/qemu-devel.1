Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4797C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822A224670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByG/EeXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822A224670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHtM-0005Fn-Kz
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idGDL-0005u7-NB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idGDG-00021g-S3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:12:16 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:38550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idGDF-0001wg-7E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:12:14 -0500
Received: by mail-oi1-x22c.google.com with SMTP id b8so231606oiy.5
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jgcPCyitlQ6IjnvaSm8sYLpQnIA1AsZmeJ98HjcnU3Y=;
 b=ByG/EeXw8ozqQiG/dvvlWRAGllbKoyceX3b5Del7qZ0nBO3bbzhr1AVNZQSFQ6SaEI
 5BTTY6tGUcABkF/l/S40TP2FAzus64Db7h0ZS4RUX4U/I6U842DkoQNyh9n9cgOFwU+I
 gU1IvDe8kxGJSMzQgVItGQZx/E9NJc1bW5DWmFOls+oOJTOLLvnJVv/hxkMbJOi/MlTR
 4rlOmPtQUK61Yq5GiDSqeXsruZLvPDxIykjwktlvCBsP2m1ubax2zVMN5maOtIuMZpaZ
 QH8XdF6Ugq6Mx92ie0qKzb/rO5KatbH+ncImp0skSYIubmb6tHyp14nyVjceUIeKfMEf
 6hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jgcPCyitlQ6IjnvaSm8sYLpQnIA1AsZmeJ98HjcnU3Y=;
 b=r/hyzZ2pkXQA8HeWoUoI0aPunN3mquoupCjoHUfm2PsFsXyfZhDlN0KxOXTcSYkGR3
 7juAGNA44oreUd6ofbI8HX4u5/gDhsWv8HkZ0kV80Ns3RN9iDTvhT92ARhjD0OqvqEcM
 3z6IyA4iApexfmeSjFVNWcO+14LLijimSzprsb4YqylK60KkWc+JUTbwEtOrM6J+zzrO
 WGcxnvcN2hMyDf3R2KKZ1B1x1ea8JL6tC1DAX8erLvlT2wtTf6B4ZDa3OYH/mn0rnFS2
 pQtF90aVTOZkpdUbaXPNbQCI0vYLoWGM9pbIh66I0vznJxVn868CO4R5VWMiqydywsJP
 5xkA==
X-Gm-Message-State: APjAAAWnUPlkK+ikehJ5KQs22/vQIBo08c6vabJ6r68aMAijZBNmPz2Y
 npGeaB7+Wjk1s/sQx+z3g3aFWM61uqRfM9xLNx9sHy3M
X-Google-Smtp-Source: APXvYqyIJ17cdISawzEmhT7Tvh5pfXVlEJFogBA+n23AYEHXIyWWT02UnibHcyfYsh2YKHMCSsMIb+gjKXFt9D3uOTw=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr13136865oix.170.1575648729745; 
 Fri, 06 Dec 2019 08:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20191206113635.6570-1-pbonzini@redhat.com>
In-Reply-To: <20191206113635.6570-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 16:11:58 +0000
Message-ID: <CAFEAcA81bcaNMpg8vs8tMM5bLA2phxZMP1az3j_ErqaWc33h6w@mail.gmail.com>
Subject: Re: [PULL 0/1] KVM fix for QEMU 4.2-rc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Dec 2019 at 15:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9278e:
>
>   Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2605188240f939fa9ae9353f53a0985620b34769:
>
>   target/i386: disable VMX features if nested=0 (2019-12-06 12:35:40 +0100)
>
> ----------------------------------------------------------------
> * fix for x86 KVM on older kernels (Yang Zhong)
>
> ----------------------------------------------------------------
> Yang Zhong (1):
>       target/i386: disable VMX features if nested=0


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

