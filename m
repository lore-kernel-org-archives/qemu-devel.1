Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C60C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:21:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9A924679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f68eeP0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9A924679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGL9-0004Xh-I2
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiGKX-00041Y-MP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiGKW-0002lO-0B
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:20:25 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiGKV-0002dk-NN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:20:23 -0500
Received: by mail-ot1-x336.google.com with SMTP id d7so7099157otf.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 03:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O0I6D1IRvPzYKxLemJ/qpUMYhDMNUnBFYpy1JXR1Y9U=;
 b=f68eeP0Oop+yprowBezPZML05zgSbbxovlJGU3NALwPMy76yv0zesE6A74UzHPXA2P
 Kxhbjr4w9KZ6MS1ebhtaPmjJZZbLr/dPo8zPgt8Me3rBXDPwr2iURphfs7yFyJd8XqrH
 CRh9qWejR8kOfvXNXKZCogzJL1nGgQT2XocYc2xMqzHKtnhq6ZU9MpWDpNEjPcC2CI+d
 tga2KpiXBufnfw5G/fdJIs9dpwNV8zlB/FdzIkjE7XO2DS1GDQAw2Kw66rPhHzweSWGr
 RXCSzSH9FQjKWgI9gtKpxynaC/JxIV7CNB46dwHwRCV/XHL6qeHgW0Q/QknkGAqYZCQA
 7TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O0I6D1IRvPzYKxLemJ/qpUMYhDMNUnBFYpy1JXR1Y9U=;
 b=IS8/vi+6pzTEVGboXMWIfK1MImUdU7tdOtpNBkhLKGBoAglINA0hmEw9Z5FrG4JJm3
 VJggZsxbjqCBUcrNicXIIbKMJa+5eMCvEBAM0ROJkQ9ckAR9ok/EcPMCjElQJWHlQr74
 Hu/79aunePdbFyfcJpqVWoIAGXStsz++IocZ9j97HSeYQ7MJPoQ0z/YAA1Jl6PN1u+L3
 2ZmB7Uo50C840oy/fZi/NnltMblWtEI7UcYw+0+tkqXg+2bux9kR8JPgwHJXp/P/zds9
 SzcvTqXui2q3DjpzkOTHo0RMwHR/loK01oyu2PrF4iZOVv8Re59fl8XUIAi9PsqjdZrW
 8o1Q==
X-Gm-Message-State: APjAAAXOYckZYZuoygPJ81kJRQHtylhX2bVqj+xNwI/9eu+o+abTYHZ1
 x7G6TxSN6djiHP9572APOMIetSD5yz7XcpfHjQEgpw==
X-Google-Smtp-Source: APXvYqyagk0rqfSiDJL9xKISXfI1jzEhVf5l+dkyJ8ZzriPDuT7S9zYcbl0HVHCOC4geDyDyzNMdFaHFMu6oMNkuOQE=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr14580435otd.91.1576840821814; 
 Fri, 20 Dec 2019 03:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20191218081721.23520-1-armbru@redhat.com>
In-Reply-To: <20191218081721.23520-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 11:20:11 +0000
Message-ID: <CAFEAcA_p-2Z4v29SJmnjthb6GaJhvhb5h+nGd-ywfoiPS_w9jA@mail.gmail.com>
Subject: Re: [PULL v2 00/35] Error reporting patches for 2019-12-17
To: Markus Armbruster <armbru@redhat.com>
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

On Wed, 18 Dec 2019 at 08:19, Markus Armbruster <armbru@redhat.com> wrote:
>
> v2:
> * New PATCH 20: Resolve conflict with David Gibson's pull request
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2019-12-17-v2
>
> for you to fetch changes up to d936613547aec49b0b80193cee0b9df05cd8a2ae:
>
>   nbd: assert that Error** is not NULL in nbd_iter_channel_error (2019-12-18 08:43:19 +0100)
>
> ----------------------------------------------------------------
> Error reporting patches for 2019-12-17
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

