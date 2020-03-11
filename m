Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D747FC0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30899206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqlc5aVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30899206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4pF-0002Z5-R2
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jC4oQ-0000w1-TQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jC4oP-0004MS-Il
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jC4oP-0004LZ-Br
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:06:29 -0400
Received: by mail-ot1-x343.google.com with SMTP id b3so2792730otp.4
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aGn0TnCknah50BezscDT5KF1SuoP7SvUaGVvSkQBnDQ=;
 b=kqlc5aVxelAhuB5rxnm9iLhoYgopLSm9boT29bs29z+h3Eq80veHFVyb48zcHCqvfo
 ncwvGQh18pY/7T+VYF7uMr/lWDBlqo7RLRL0FgMeNP0LdpVvK1UrjARZT+ajRqT052kf
 oo/pXfbisrDDdRDC5jPKTefAlnT+eopjfyYrcIlAmjCZzhFJneJTizkJiCDatOP8MDcR
 Hi1qgagwqp+PkqPELgFBL6uPTDH37vouzBKc1zDVhN3I+aMWjjLI/9LDWj/fM3dcX5Iw
 zvgOUJfUflLqFvsAa0GhrQG1cG+eXqjoiCkF1O45VYauQhpQOnkpdaSqYC1Mxza72FJR
 13Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aGn0TnCknah50BezscDT5KF1SuoP7SvUaGVvSkQBnDQ=;
 b=TOTdnZTz094zcLz8hcbFNiwUlNI5rFrjDAVpqV09OoUQYFn5VxoKyVqbZ+R+kNvZqk
 4+RNOBME37wSgozf2yfvN17hM+J6ztonvPRBkrF0o3rjSLJ9uXfbEWo6r+hJjZhgP4pz
 b2C6hKnJr3qOdf5v3v2qYbNbLNG8af69oWMJJhB5lJLkzT9UHiyV6nvtb6HPbWZYP4ae
 Pnzg4NsQZWNAmjp6hQSxWKzmPbXnFwmPstLfDs9oHiDaw5Cl9UU84xgRbvgDA24mBJil
 98pB0HldA+0Gz4cqOUaskwxzG2Q0VNQWeMQps8unLT+iX8Piq+oIsB16zskNO58ZnyQo
 61aA==
X-Gm-Message-State: ANhLgQ2DDYhMl98ae1w+yw3y5W9DE1aSF3zg8L54pWV2BRADorI7Ja+S
 qdL7EhlCJiNOBSnoO29UkkLIgNjgml0YlhCN/sV3cg==
X-Google-Smtp-Source: ADFU+vsZk5JWWfqibvxqfjhBkB0AFAJ7o8iTcalrzmGmS0rzSR/0HOIrUvViVLz7IcmA9wgQ9ybJweAFce7A/cxxy4s=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr2958250ota.221.1583946388176; 
 Wed, 11 Mar 2020 10:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200311124045.277969-1-stefanha@redhat.com>
In-Reply-To: <20200311124045.277969-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2020 17:06:16 +0000
Message-ID: <CAFEAcA9MyVo4FtMkEXMKB_G6V9et29JEqXHncdYWSxuEdE1cJw@mail.gmail.com>
Subject: Re: [PULL 0/9] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Mar 2020 at 12:40, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 67f17e23baca5dd545fe98b01169cc351a70fe35:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-03-06 17:15:36 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to d37d0e365afb6825a90d8356fc6adcc1f58f40f3:
>
>   aio-posix: remove idle poll handlers to improve scalability (2020-03-09 16:45:16 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

