Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF53C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:22:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BDD21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzCjZQ3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BDD21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32993 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTksB-0004G5-Fu
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:22:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTkrG-0003wH-EH
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTkrF-0006MS-3r
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:21:58 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTkrE-0006Lf-VH
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:21:57 -0400
Received: by mail-ot1-x334.google.com with SMTP id l17so4939687otq.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=0kt0R/7SWTGyHu+Jlvc7bhQkTLkPae8dUdH0IzdBQK4=;
	b=mzCjZQ3hA6Qgod5pLHtH7l7zKwHAQ0TLBLFvfhXhQf2W0Wp+ljHO8MpPNTHfM3Dxw/
	JmmBHzPeYHeV8nbbkpIPR43oEMTs+XPd5kx5mcJh/LqiAmfBB24jNkykx5vuDPo5GJSs
	eV8FMg65eMmCUG7/Ph8jmYLz9sUCNzlaARP14wkKUjTrH43T3ievtdlWZlIHcO0OwTYw
	iZ7lsFW84EJomwLGC7UOhfUXioRspi6GAJRVBsfUa116pEkkwKd3wybeBgWmdx4ZVHoA
	m3F678bZ8mfQ1R6LnuxKKzonRbauY3TqqLzxKpnzx1Pv2+E2rY0b8ZTA+ODJ1xT3vVl/
	+V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=0kt0R/7SWTGyHu+Jlvc7bhQkTLkPae8dUdH0IzdBQK4=;
	b=scd2dZYg6uT8YCle7LEFLw0rIWTXtUB/h9YE/ZQR5WIyH2frLHdL5DBc505ECptud7
	rUcZ32oXhHlk77/2VFCgtAavNEyGcb764zDlMoHd0Cv0BC7PGfXRB7WDv0dPQSar41bC
	ke6CKj4NURgIuXiGp5uFQcNganY1/wrk+mtICDNrySJAXpW8me/W6QIs43IUdHQHZ45W
	z9+IIJeUYskWABhKztolblEzFhaDG8E/Ei+4gJSTGZQg8RUkY4VoeBqG5Xv7SkJ2Tvl8
	duOdqrxgpt2+KtYUaG+dDGtqwUnbHV+MUBju4gLygK98jpFtiNqXj7gUERgb4RhFnzcY
	49og==
X-Gm-Message-State: APjAAAXKPPPK/mqDJwUedNMwyer3gIR39zeOSBExTJL6deoZR1DWYFou
	IXteuOX9a7IyLEzuTyXRi9pKxucjd7pq8jL3GnA7Dw==
X-Google-Smtp-Source: APXvYqwbyWwKX8zPlzY3xiVBuF9juT5UFNYmI1FPRtJTrBOxrP5eVs1q2zcsa7NtYzlBEa5NFwEh4qSEQD8pCaTNoZI=
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr129820otl.97.1558606915523;
	Thu, 23 May 2019 03:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190522082717.9354-1-kraxel@redhat.com>
In-Reply-To: <20190522082717.9354-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 11:21:44 +0100
Message-ID: <CAFEAcA9P71p1+sU-br=PqWrLo5KQp_NNk_oZ4uNkgPeQHuRnZQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::334
Subject: Re: [Qemu-devel] [PULL 0/3] Input 20190522 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 09:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20190522-pull-request
>
> for you to fetch changes up to 06914c97d3ade856371c9a59cbe6a9b13422471f:
>
>   contrib: add vhost-user-input (2019-05-22 07:16:58 +0200)
>
> ----------------------------------------------------------------
> input: add vhost-user-input to contrib.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

