Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA5CC432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 22:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CBB207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 22:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q7Hg9WrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CBB207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCWSx-00014e-MH
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 18:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCWRj-0000MG-MU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCWRh-0001aA-9d
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:04:39 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:44982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCWRg-0001Z5-Nm
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 18:04:37 -0400
Received: by mail-ot1-x336.google.com with SMTP id 21so13532747otj.11
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 15:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fup9GzCC3x62mnSNCz3pTtcek4vX4r1E0cNBsg2TOGo=;
 b=q7Hg9WrIsfsz8G3Bc/FwJdURl2vvfikxPwN1yDqfLJjaRXDgTC3aSifumA0Fe8paKd
 Qgqnr9+QQAOenuTFhyPOVOmqpKDe1T7fecN1B5NH31TjRwjEWwAyyDpI0copbYdolO6o
 oguqBkb0m01bfSNkokGmPlK6E3/3iDS1kcnO4EXodhjT4pW2EoyigqsGai7PKEeXkuui
 OWHGDqwK8AUBzO/xrDM9LHFOu8EE+vZeEJFYbhKKC6Ju+r6V9Jg/oRluGyPyFLJHW5Pa
 6zDrJgeuD1YDT2cv/PmjzVZvhmEy0WhLV3IDtQP8e1z+h3PidFgnZW8+ZdYLDhirefnG
 49+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fup9GzCC3x62mnSNCz3pTtcek4vX4r1E0cNBsg2TOGo=;
 b=CNytzimwgz04IQM11BfIjXleu9ycHkecJM8YxT0OIgiDldjQaRL0XAlsqdrKnahkaS
 rcnhhYs+DOVKyHjNGTDkIJ4Wh4JfCnHdDEIb2rDsWrkmzKhgA+SxVJI0wDCFB/Mh4GSW
 xgliCp/5amN+uenc8W0VSgZeWq/vd7kGZHQcFOSgjByy5uoA+fC1puCef9XrLcCV95o4
 Ucj10RbxHjOqRN+KCBcEMJjimAfhF6yXf4PKKkiCWqhrfu9e/hqBNTKDqloewz1qJGQM
 h5BPb/H69akHb39Gi6ogEdnox1h4/8KotdB5zQdlcDo3ifeaVq/5zK7XaTc0KYFKBenA
 qJzA==
X-Gm-Message-State: APjAAAWYuToaH5mzsfLQq/MMs5+2NT1er8hpMjPkQtVKmjq8j2Kp/ny2
 7TJPrt20BsQrBDBcecUWMO5jUlHY2YsTA2PAQ5l1yw==
X-Google-Smtp-Source: APXvYqwvxQyzkJpIo0TFYLPPC/pR87vxILZKT71zRjdZT+VeE1xltg4rujTZtzyZ2V5MX7r3cGwKHUoKaXZ/6DkUZzw=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr360480otp.221.1569276275743; 
 Mon, 23 Sep 2019 15:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190923080712.23951-1-david@redhat.com>
In-Reply-To: <20190923080712.23951-1-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Sep 2019 23:04:23 +0100
Message-ID: <CAFEAcA_zjiapxFAhB=XFEphcHEnkb=s-3TzPa6ZwEYEde-Hm6w@mail.gmail.com>
Subject: Re: [PULL 00/30] s390x/tcg update
To: David Hildenbrand <david@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Sep 2019 at 09:07, David Hildenbrand <david@redhat.com> wrote:
>
> Hi Peter,
>
> here is the updated tcg subset of the s390x update (including one more
> test).
>
> The following changes since commit 4300b7c2cd9f3f273804e8cca325842ccb93b1ad:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-09-20 17:28:43 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-09-23
>
> for you to fetch changes up to 5d69cbdfdd5cd6dadc9f0c986899844a0e4de703:
>
>   tests/tcg: target/s390x: Test MVC (2019-09-23 09:28:29 +0200)
>
> ----------------------------------------------------------------
> Fix a bunch of BUGs in the mem-helpers (including the MVC instruction),
> especially, to make them behave correctly on faults.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

