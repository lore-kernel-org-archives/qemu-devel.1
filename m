Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172F6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B3D206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gk4x2V9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B3D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyeDw-00036x-43
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 12:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyeDM-0002hw-8f
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:37:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:37261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyeDJ-0002v0-UW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 12:36:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id y3so5794335wrl.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EEpKZjbcM4Lj96g6PObQWoCzM/9dw24XuRBGO5muidE=;
 b=Gk4x2V9TKveyU95Monw5q1/cl/Df07kQA6WIQ15K5V3jahmNTjLgoiD9weClb8cq3o
 rBMGcUjJ5xejlhh8YO1rySop/uRMx8TzjquzbRB9EVXAGVwPZXpl6YTzRNIED7vooReW
 kSoHQDnuJCPIHjD4FCFSYVJ4kbZ71+leCXuBlgUkM4kA0kzEN59rR22vXUv/YdcUWKOU
 gdk1Pn6xoB5YSSKTA/JMk1Fz9Pk9Ttp7eSGDakQdYUl+3OqTdw8isWFGelG7nk7zKUwG
 vUl7ZtzA1xmqXiDmcRnlX0oG4wKtkNA6j4rehfzIPhgXB66UXt2KTnAfFlxTZ7NkLOEt
 RgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EEpKZjbcM4Lj96g6PObQWoCzM/9dw24XuRBGO5muidE=;
 b=TG86Kuz2LXkpIiJun1lR+v8BWNoWPm6iDkrr5FFZJmYrR68gKAhBMk9dXK0seN6Mre
 PVZGzd5Kn8T/SPMX+tkLAFUWI1cy8eakjSOGxHUuklz3YSpthKJfKDjorPBy2cokwie1
 aI0eX/aOKCrQ0rsVFloMZlVQ+4y3rGXh9I7lNk1bNnM5UzCacDc5uR/UYadrD6j4n4gX
 hPZO5S1mZ7GERo+SoG0hmM70YT034/Tx8m6gSOjqRBseQtSZJrpvdo/yKitCmJ/mWnRI
 EqkZMpl+2SyEybkrm4LUdRVquUA6kp0pjmGl7TPQZ14H9JGINuJlY20kwvtk99ytAsgH
 W0LQ==
X-Gm-Message-State: AOAM531LtcE50aSlZIuXsiP4Xii46wZpcWhDIQ7fz+J08DsPTZGU5rYy
 cFo9kXrm1pv8w8VWzslA6jGQCA==
X-Google-Smtp-Source: ABdhPJwFAM4vtk9cErjJvzTA/neZxej5A5O68qrXv129b4/v+UCJIX+zhr5AcVpThBkEyjRmLYVfbw==
X-Received: by 2002:adf:f045:: with SMTP id t5mr5082690wro.288.1595522215812; 
 Thu, 23 Jul 2020 09:36:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a11sm4820660wrq.0.2020.07.23.09.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 09:36:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBDAE1FF7E;
 Thu, 23 Jul 2020 17:36:53 +0100 (BST)
References: <CAFEAcA9+9ZQY2CxZ9V4bZrkAGR5eUapbwSk6sNyFGyyd39Y=1Q@mail.gmail.com>
 <20200722093621.GA4838@linux.fritz.box> <87r1t3u4me.fsf@linaro.org>
 <87o8o6pwwm.fsf@dusky.pond.sub.org>
 <16f1e661-edaa-2ee2-008d-3c9ad0e5e10d@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: please try to avoid sending pullreqs late on release-candidate day
In-reply-to: <16f1e661-edaa-2ee2-008d-3c9ad0e5e10d@redhat.com>
Date: Thu, 23 Jul 2020 17:36:53 +0100
Message-ID: <871rl2tcgq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/23/20 8:28 AM, Markus Armbruster wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Kevin Wolf <kwolf@redhat.com> writes:
>>>
>>>> Am 21.07.2020 um 17:56 hat Peter Maydell geschrieben:
>>>>> It is not helpful if everybody sends their pullrequests late
>>>>> on the Tuesday afternoon, as there just isn't enough time in the
>>>>> day to merge test and apply them all before I have to cut the tag.
>>>>> Please, if you can, try to send pullrequests earlier, eg Monday.
>>>>
>>> <snip>
>>>>
>>>> So given that we _will_ have some late patches, what can we do to
>>>> improve the situation?
>>>>
>>>> Maybe I could send the pull request before testing it to save some tim=
e.
>>>> Your tests will take a while anyway, so if my own testing fails (e.g.
>>>> for the parts of iotests that you don't test), I would still have time
>>>> to NACK my own pull request. This wouldn't buy us more than an hour at
>>>> most and could lead to wasted testing effort on your side (which is
>>>> exactly the resource we want to save).
>>>>
>>>> Can you test multiple pull requests at once? The Tuesday ones tend to =
be
>>>> small (between 1 and 3 patches was what I saw yesterday), so they shou=
ld
>>>> be much less likely to fail than large pull requests. If you test two
>>>> pull requests together and it fails so you have to retest one of them =
in
>>>> isolation, you still haven't really lost time compared to testing both
>>>> individually. And if it succeeds, you cut the testing time in half.
>>>
>>> I've taken to just stacking up patches from my multiple trees to avoid
>>> sending more than one PR a week. Of course sometimes the stack grows a
>>> bit too tall and becomes unwieldy :-/
>>=20
>> You're right, stacking unrelated smaller pull requests makes sense when
>> pulling all the pull requests in flight races with a deadline.
>
> I tend to disagree, since few patches from the "candidate fixes for
> 5.1-rc1" series are still being discussed, and we are past rc1. Half
> of them could have been merged in for rc1.

Sometime I do peel of the patches that are already ready and push
through the PR - especially if the stack is getting a bit too wobbly.
However as rc1 had already passed I just continued to collect them.

After all splitting them off is not cost free as I like to ensure my
final tag has a clean run through our CI as well as an overnight soak
through some of the longer tests ("make docker-test-build" & the vm
tests). Usually I tag at the end of the day and then send the PR the
next morning.

I'm about to post v3 of the series - I'll aim to tag it all Friday
evening or over the w/e and post the PR on Monday.

--=20
Alex Benn=C3=A9e

