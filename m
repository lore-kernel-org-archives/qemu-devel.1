Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D714C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131B92082F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MehroyMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131B92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbCQ-0002Oy-85
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJbB2-0001mW-6q
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJbB0-0004mC-TL
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:04:55 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJbB0-0004f4-MU
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:04:54 -0400
Received: by mail-oi1-x243.google.com with SMTP id v134so21774103oie.11
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 04:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+J3BnKAM1aRtEgL8XA62o2h76CP9GuSgPlAEZXxKv24=;
 b=MehroyMDcA71jn5xJUJo0STTR0xLGWjEmf1r0aFbbpuEKZe0YCozLShTJXW+/5VPX4
 uS1Vtv5YYaYvewQIZLFVklaQYzhyet/+sRAcFzuaiH+SBMRIh1JKJHRQiWlJKsZAEIGw
 zZdeLCxL7qsS1fIR/h0Kx50l1xudDlIysTKQhm/5Jc9byBYZ3fOxOSzInMkCTiTa7NJz
 GzDO3UGbCwHVJAGLHPe0QFdF/31oG3FA+XGblpueUETwXKtvNyssBhTxEGXULWvfUFxo
 Rkkub8o/X/LaQgNMidXjSY0LyaLETZHA4/CVCVEZU1sSwkLNMynVtQqpG+7McGWJcOFy
 RQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+J3BnKAM1aRtEgL8XA62o2h76CP9GuSgPlAEZXxKv24=;
 b=H7ER6TBFBCxr3T/wLPZSUAkRNQvMNmaLllnFyzSwJwoL5QVHhvQMtG/r5RD4tBOYOs
 I62lLLgnUQoHMJKLsS29iq0/wbrFl0O5hTCzrSZ5rL0ZYXAn0wmHvUOpkf3UvQL4nyVo
 7EnZQlomEjM4Zo4jDthjdBAfBT0MQ3oysG9eYNSE439dNZTZhu0wKa9O8n/wQkFQP0qR
 0ZxSoypKxvBn4JJMG+99zREtmMSJ4x7QbItz+fQ4bvCEa7q0STjmwwatGz2IV+izTki6
 6ExfBFwRlbqHtBwxV9VUUztBou3iJO76sR48l1ntp7Mp5N0p1tItdZ3khLsPBtdmkB9I
 Nl1Q==
X-Gm-Message-State: AGi0PuYGL5DB0e/kV2GgJ06fER2mySarjLuAANWdPwfH2hUjSKLsLKgL
 K7tOJZVboVUCiZqDa19igE8WP0mf3Kjbbozzw+bj1g==
X-Google-Smtp-Source: APiQypLbNTCtBuFPWVZTYcFiYaWaNYzZ8w/ob3qBM4u5jH1eojfJwi1+kf+QyNlHGXHL4uskcACfus2VXNNUkT5AK1Y=
X-Received: by 2002:aca:c608:: with SMTP id w8mr2361070oif.163.1585739092256; 
 Wed, 01 Apr 2020 04:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
 <20200324153630.11882-2-vsementsov@virtuozzo.com>
 <87bloc3nmr.fsf@dusky.pond.sub.org>
 <CAFEAcA-c_gX4=Be0oMLCmQy+PWc4uEHpQatuyNQjbrZXvsv1+w@mail.gmail.com>
 <87wo6zoku0.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo6zoku0.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Apr 2020 11:04:41 +0000
Message-ID: <CAFEAcA-mZ5nPOoPz0kafmEjUORYQj-DvieMeWqgbFarp1_DhNg@mail.gmail.com>
Subject: Re: [PATCH 1/6] scripts/coccinelle: add error-use-after-free.cocci
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 1 Apr 2020 at 06:07, Markus Armbruster <armbru@redhat.com> wrote:

> Generic instructions for using .cocci scripts should go into README.
> Enough to get you started if you know nothing about Coccinelle.
>
> Options that should always be used with a certain script should be
> documented in that script.
>
> Options that only affect work-flow, not the patch, I'd rather keep out
> of the script.  If there are any we feel we should mention, do that in
> README.  Example: --no-show-diff.

But then as a coccinelle script author I need to know which of
the options I needed are standard, which are for-this-script-only,
and which are just 'workflow'. And as a reader I *still* need to
go and look through the README and look at this script and
then try to reconstitute what command line might have been
used. That's more work for the author *and* more work for the
reader than just "put the command line you used into the script
as a comment" -- so who's it benefiting?

thanks
-- PMM

