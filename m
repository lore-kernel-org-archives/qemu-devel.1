Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91567C10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 19:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447EF2064A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 19:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ht2GYg7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447EF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAIdI-0006Yp-CZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 14:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAIcd-00063M-Jw
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 14:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAIcc-0004yY-CR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 14:26:59 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42006)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAIcc-0004xk-6K
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 14:26:58 -0500
Received: by mail-oi1-x243.google.com with SMTP id l12so3660976oil.9
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 11:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AX9JG81qB7dkuRPP8lRcrq+JT/yGfCORUxbhpQhd/pE=;
 b=ht2GYg7pkP6KGgvxgboDjCgC/loG8+jLsH3UOKGHEVPJJEzCG0ew4GnYVla9p9jKLa
 l+eXjQFF/ZL71KLn/1oETGKBGA1cljpFxiCmzK8F7jQGVbFot56grK0AAfVuB9EBWWRq
 Kscr2Gtz77gxO6qi1dM7WCG7dy6SOx8MTQO9YyeG65ePvBe9jRQnM2ubz3fDzwHKnHZc
 rQtLMOniiC1jyxKzmAeVznnYqgjkOUQ02F7yKd388CL7zx6US/UrOGewlsiim1qJOwT3
 PkkQy+EOy7Bxa7lz4Nf2MMSYmzQNPSePxDF7WPM59IA5gjTrpGekCZZUix4Pjyup1Dqa
 exRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AX9JG81qB7dkuRPP8lRcrq+JT/yGfCORUxbhpQhd/pE=;
 b=Dyqj+Qo4uBPGH+FFD8Axf/loyF/eCbZse3v8KUtOZEukDUQ0xppDE4kbcgABY1zINJ
 N/nPdGGfVXGdSDmokvUncWzRXPed/2U9sXXMjL2CB4Eyi9ikUVmcthrBkWq/enZhIp1+
 6C6urv8jWY7vBWy5qQzGN4xF7REGUwHSHOYFhyM77Gw8tG3mgfALo4DqQq9DlXhumpG8
 413o+k/+3SqpRh6l3ZifGXD9+eEv1b02gg2JmqFTv7ICpvSeL6Q7zMJmRpmxxDmCubDs
 auLW1g0vEV06rK/rwy7N1+BW7Z2yeh3VvNtPCWLK7xhtXMMWQtv8Mvcvlo1DGM136/Nr
 IFbA==
X-Gm-Message-State: ANhLgQ2c+ryihNan37GoUlxbPRHYkF1LyBZ3r4efr3qyEBTwNunhMTUk
 TawE9Bi/CUuH03LvMCBk9cMgl/85kqxCU20VbesvVw==
X-Google-Smtp-Source: ADFU+vuiCPLE/qxMy57Dft4LV3czF0vPqMgtStdIw0m1alcokMHkiwueuSxi/umjdi+fSION4XLEIsn6OCnaBtA86cs=
X-Received: by 2002:a54:478b:: with SMTP id o11mr3603739oic.146.1583522817250; 
 Fri, 06 Mar 2020 11:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20200306171458.1848-1-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2020 19:26:46 +0000
Message-ID: <CAFEAcA8vgKSMUdzHsmy7pUBVninG4HZJqY3tLZeMVq2Ws2RMoQ@mail.gmail.com>
Subject: Re: [PULL 00/29] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Mar 2020 at 17:15, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit f4c4357fbfca0fb14e477bf661ae7384b4b9b283:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200306' into staging (2020-03-06 11:11:54 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1de6b45fb5c1489b450df7d1a4c692bba9678ce6:
>
>   block: bdrv_reopen() with backing file in different AioContext (2020-03-06 17:34:09 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Add qemu-storage-daemon (still experimental)
> - rbd: Add support for ceph namespaces
> - Fix bdrv_reopen() with backing file in different AioContext
> - qcow2: Fix read-write reopen with persistent dirty bitmaps
> - qcow2: Fix alloc_cluster_abort() for pre-existing clusters
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

