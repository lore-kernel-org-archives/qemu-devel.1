Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9ECC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DF5206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GM/DfOFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DF5206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRNe-00083O-9T
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isRN1-0007dO-Kh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isRN0-0001xd-93
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:09:03 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:40163)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isRN0-0001wi-30
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:09:02 -0500
Received: by mail-ot1-x332.google.com with SMTP id w21so22432033otj.7
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dRL5aheFult2l/QUcaADS2c4QmtdcS7THDxxywjrYkA=;
 b=GM/DfOFLJtlkT8yE0Yq/RKgj2phe8zSuL3Lr1oxDuzKxChaeAiaFjt3m1FtaSwdHpc
 GZkMteCJ1R7WSXNqBlILAJlBP4AzOe5+e7DH8kSsUTe9ilxNCV/zKaBymesO8MRhnMJN
 R4e+GEqCqc8798++byg9upNMDLBmgSbtcwMEWF9g36lu+LKKfy/HJe3zTLLB3Hc/Vbqg
 OwAkOZkx9I0EtviWnEh5MMXzw+YLtd9eqqUJiroRO1TIImNVBLDBlo/VWdSIsQt9m8xH
 Nj4PVGK+5goQnZMJERhKlWaWWomGH9ziNiUrFPIbfCr6SuSc6G985O5a9PSD8zXWLAl7
 2mtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dRL5aheFult2l/QUcaADS2c4QmtdcS7THDxxywjrYkA=;
 b=QqQNm2J86VnUsC6kimmZGOGPJ3/tbWy8yMcrb0wxtY6yMoiQ85XTKwDjTtkmfhM6yN
 N1ivF8Xoof3EZyPn6wFhSuV3TYw9/9tzJvyelj6jwbH+py311zpjbpwk0c5kmOeHBoz5
 nVsfw+fvrOArpG95WWWn5RkDYC5SIYjDkovNcLSlUFun4UoQIUSwKdHnhYuOYq6U27H2
 Rg6VJ55kMx9+ZisvZIshMQi5YhFPD84Pa8p4VWm5Wey1JgT6B/+09ReMzF5ek8LM0upA
 ywNajrsjXyGeJ7ko5gcmBOvOsN7kT7xyqmmFbSxmmxfbJ2YF2lSLvZreAwmAUlWPuztu
 g+NQ==
X-Gm-Message-State: APjAAAV0jvzp9AvFvoE3W3VDmqgARB2+vW0e7USz5g0iBK33BDyJUwOo
 QU9xoJBNhZzhDVM4Il9bbY87F9dPonaeAo558Sw3NQ==
X-Google-Smtp-Source: APXvYqzdQy3BbhrDLcIrrZHcEWbdS77OxmQ/p1pxgEt/X+aVdEsh9OZn9fIJZSbgoSk2qw79S5YNjnIWI0qgZtoAW5o=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr6058581ota.232.1579266539724; 
 Fri, 17 Jan 2020 05:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20200116014052.17069-1-richard.henderson@linaro.org>
In-Reply-To: <20200116014052.17069-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 13:08:48 +0000
Message-ID: <CAFEAcA9gQG7rUdhEM7baq1zddjNCZd1VmWQSwvgeTTboObyuvQ@mail.gmail.com>
Subject: Re: [PULL v2 00/34] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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

On Thu, 16 Jan 2020 at 01:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For version 2, drop the -static and -pie changes,
> i.e. patches 1-7 from version 1.
>
> I'll come back to those after the required linux-user changes are
> upstream.  In the meantime, it's still a large enough set of patches.
>
>
> r~
>
>
>
> The following changes since commit 3a63b24a1bbf166e6f455fe43a6bbd8dea413d92:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200114-pull-request' into staging (2020-01-14 16:00:31 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200115
>
> for you to fetch changes up to 3e5a01ef0268ee4c9d342a26dbf6624d6b5b20d6:
>
>   MAINTAINERS: Replace Claudio Fontana for tcg/aarch64 (2020-01-15 15:13:10 -1000)
>
> ----------------------------------------------------------------
> Add cpu_{ld,st}*_mmuidx_ra
> Remove MMU_MODE*_SUFFIX
> Move tcg headers under include/
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

