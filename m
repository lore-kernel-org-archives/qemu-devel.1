Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BB0C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7ED20836
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 17:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8fJ1i5v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7ED20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9BHc-0005If-E5
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 12:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9BGa-0004Kf-Iz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9BGY-0002Rn-Ml
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:23:35 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:45187)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9BGY-0002RL-Hu
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 12:23:34 -0500
Received: by mail-ot1-x336.google.com with SMTP id f21so3757966otp.12
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 09:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/0l+ktrmUwIsGMeRud5MvKwRv3eU76dfP7rTvLbpokg=;
 b=V8fJ1i5vrx1/fm6NE3iPHnbHTY6HxTaDca8mG85yHt6e8MYy6Qo61PTFXQt/QZDNSl
 hf0a7e9a4B970N3j4gN6OlrZ7oHqaPIjiP9gCUO4flz7l0hsaV2bWFuz9jyoMRsZnu+Q
 qbFrc96hk8S/aLyRiuAVd2NVQUh2XoG7D4ysbGdTFSMYyY+k2WJC8g5S09ng4vRhotue
 Q+AS71x/h7AN9EID/f0k4H+BXQj1ovk7A1iExksRModwdmIZEcIOAknGWeH4+fQWOFo9
 YKbjz118AJkR/61PJzuFxJ5kJ6CCXII+8X304ESQ7aVVgV5zo2SQ7ZgZQIxxDBf+K5uS
 fc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/0l+ktrmUwIsGMeRud5MvKwRv3eU76dfP7rTvLbpokg=;
 b=eWBBw4uY0RPDhbwH6R5uU0Flalh1OmjSjBf3+Y+aPd6KN2oBk6HgAuLkAwcz5XM60w
 NEORLIfVJ/cit2Tu2pIHQzxfD4T8O/t5vEzM0T4Mvb7it4ikzgJ3PEKc5lc1S0oSa9cG
 nDojYiU1d9fCLD8Q0ra7rEgxBR/qoBnYnM66MtISHvNnzIPEFF4lmYC2N+lWz8cuNpni
 zLQur8o4030IRQIDeJ0mxUbzwf2l5rKBo1gessSOTzXKab9ADbQRhu3YrmSv/tHoqgLU
 y42y9ylOJL/SEzp5T+Dm7xvadhI8BfX4capszXCbyh680Jo38yi7oUm02ci0kUAdbCIV
 2FJQ==
X-Gm-Message-State: ANhLgQ1xhcfH2v78oNM5jKfrErfq4WF2LjuQTeCfc+Le22+twX692xaz
 39oqUxe+Xb9nKSt8+BRxpcC0dIx2yx/lUHdoF52o6QNE
X-Google-Smtp-Source: ADFU+vvAiG0t/TDiyYX37RoOWlS5DC2nx5HIZadfQJpO6kDB+/1nvIBDY1L4+CH/EIkJk9PkfruPqb8rPqigRwqHxSc=
X-Received: by 2002:a05:6830:1406:: with SMTP id
 v6mr4263908otp.232.1583256212932; 
 Tue, 03 Mar 2020 09:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20200303151606.108736-1-dgilbert@redhat.com>
In-Reply-To: <20200303151606.108736-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2020 17:23:22 +0000
Message-ID: <CAFEAcA_fSC2Xjcav0AD19GDSoo1ZN1wPn3HOhKWvzJnq715F5g@mail.gmail.com>
Subject: Re: [PULL 0/2] virtiofs queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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

On Tue, 3 Mar 2020 at 15:17, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 104933c4a973960dea605b06fcd5d0d478255d77:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2020-03-03 12:03:59 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200303
>
> for you to fetch changes up to bdfd66788349acc43cd3f1298718ad491663cfcc:
>
>   virtiofsd: Fix xattr operations (2020-03-03 15:13:24 +0000)
>
> ----------------------------------------------------------------
> Virtiofsd pull 2020-03-03
>
> xattr fixes from Misono.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

