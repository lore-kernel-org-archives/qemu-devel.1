Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5930FC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC3A21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZP19vSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC3A21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDVVc-000297-2w
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 11:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDVTv-0001A0-Ha
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDVTr-0003Ih-02
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:14:58 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDVTo-0003Hd-SU
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 11:14:54 -0400
Received: by mail-ot1-f54.google.com with SMTP id g25so2349647otl.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y2OFHL0NmMlm/XHEoD/pUGxiEXALsB/2CpDjoGBnlfc=;
 b=QZP19vSKSazNCKZnkTiNSjuIGU7wB37oePBUdPUVZe+EZU69MzLObtb8Y0YLFfzbx+
 CZMLwAOl1i3sQzorRRtequ3g7Fpg7ZcFmTzX9xllMtCFXP+3cl1dj3FAIX1L6AXHtUpW
 wPv0fsjPDc0NYAb4/mP2UXesX7he10tEJZ8E6AUPrL0hdtUs3reeGIop38fRT5R/32zH
 T5XPPob6qPAx2m9KCakFsLb+yXjIHFoAG+khwyyKM3yGLF9zUl/tMfleGApQg9UkJHcq
 zWJoKXty/qeeBWrZSu6yOJ+Q83dyOxJ4Ig+3eqB32xZe/4iFPKuFQdRWfSSx3AUGNmVH
 KxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y2OFHL0NmMlm/XHEoD/pUGxiEXALsB/2CpDjoGBnlfc=;
 b=YbF3gMdzki01PUkKnEAAHfxOJRlBSTh4EXwvG7wlOrVyF5QdBuh1UHOWj+CM/Voiwb
 9Quq1qdaZ0s52TrHyWWeaozQDlBx3TCcv9mAgn7EGLJduIRLWnY0X/ZMtyr7DKkQuLsF
 R1XNM4Q0hlnjw1DzLobmkYza+fMn1o1L4BBAZ7Aq+lKDbyNjYVZWSCvDPUjdmFgVpT7y
 /SLHhtCkfEkmbKux6zT9Kz7Bb3d6FlzprNLFS4iUtrbViUjOdLzJMUvDEhYSNIkaFYcV
 VFA6gWq3qpuWn8zIDifo+YUHZYfi/QScJKihSh2K8rxc9pzgqvCi+WGZ6IyNznyPqHg6
 84wQ==
X-Gm-Message-State: APjAAAXQJrIZDHB8yVTGGJQ208qigTtMVb+KtfZCEovn/iYBJ7BxlxdX
 uhS27yrPFw1+9U7NHxy+r+ogkRj9lk/4PHA4mvYDmg==
X-Google-Smtp-Source: APXvYqy3b9kmejU/SdK+ynuLuabojLqNmOSMDYN9mFr5JquGDWQ+9Dm9N86LpMcrElz6Lcst67GUqjOLh079alF26BQ=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr1884633otq.91.1569510832068; 
 Thu, 26 Sep 2019 08:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190925150130.12303-1-dgilbert@redhat.com>
In-Reply-To: <20190925150130.12303-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Sep 2019 16:13:41 +0100
Message-ID: <CAFEAcA9Areptpe7iSh-KfNj9ym4DDGOKCdx0zwNAY1q5EKfSAA@mail.gmail.com>
Subject: Re: [PULL 0/9] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.54
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 alex.benee@linaro.org, Wei Yang <richardw.yang@linux.intel.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 at 16:06, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 240ab11fb72049d6373cbbec8d788f8e411a00bc:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20190924' into staging (2019-09-24 15:36:31 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190925a
>
> for you to fetch changes up to 3748fef9b95a9bc1602f3c4ed2a329d8ef47e63c:
>
>   migration/postcopy: Recognise the recovery states as 'in_postcopy' (2019-09-25 15:51:19 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2019-09-25
>
>   me: test fixes from (should stop hangs in postcopy tests).
>   me: An RDMA cleanup hang fix
>   Wei: Tidy ups around postcopy
>   Marc-Andre: mem leak fix
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

