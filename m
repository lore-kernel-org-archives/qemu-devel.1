Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A86CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA1020879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qWUfLN3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA1020879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35081 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmcl-0004Pu-Bl
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:15:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTmau-0003GC-8e
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:13:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTmas-0002QO-EM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:13:12 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:40061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTmas-0002P5-5D
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:13:10 -0400
Received: by mail-ot1-x32b.google.com with SMTP id u11so5172287otq.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gWy0oz1bt10UpMFG1UecC+ycclHYtB1K7ptyFBzriuA=;
	b=qWUfLN3EULVCwW0YUI6QpOVkeloaGfyZXnEhs/1Ei3M+Dqxm+id5OddKLD87KVc/na
	XOepA91c/1y9WJ6poZBcRZAlGFmssh9DHVowmEDkPjEGOI/rmeHvR7i1YU/9yDhLqhzw
	jIRqWFuY+mUkIpA+KSyqBMQUxPu/U+HxRtT/WlZBfPuVJOw2j1RFoWJ2sMKqEGeADIcS
	8d5bOmtjIAMnpHXud6vapjZVRVOSnzUesnjiuO1VNw+cxlHAYg4iLs/5vsD/beuYA6pi
	PTGbEwCosPkvQzawEb+CNvN5jOJcLintAXOW14dIB5rznva/Pt5iyj7hLxw3Gt44apQj
	b/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gWy0oz1bt10UpMFG1UecC+ycclHYtB1K7ptyFBzriuA=;
	b=Xm3L5hmIi3koNQ7O9fZ8ZQ0WgUhpEdKsvN7cpphHVBF79bFce/E9Nv97iYxIuJ/cg3
	9k6tluS8SsNJdI5igl2FW3sH7LXbKXXPa7bWx+BrniPAvmSwc5O/B5M0CNLoGiMJmgr7
	hEi+gXndN0YcWOJNKrMi+zSmXEAM3ezjgmAyApBKmnGy8pCUG9dwqWU2ObNy0wlTL26A
	X0lWzXFGC0N5iYsXzoZ2TQ7kQOvuf7au4pqK0/po5ejD6pQzJxNkLxy91N+G2aiPD1ej
	OG764ML+12eMvKeGkCAAgJjrRN45PuY1QWbIfwWcX4zM+zugYkn8RxUWz5WCj09I6oTG
	nZMA==
X-Gm-Message-State: APjAAAUTj+OOcNsb+47Isw5llkwGXpWfReuF06E4Mp+ZQAEyas65j+pv
	GZB5ayS++GvZH+QyhrXyGO/n19O/lmm3Xipn9/uUvg==
X-Google-Smtp-Source: APXvYqxc8ksgy9PhzivNTMC/7VNMdNkl3HhdbTZqXMaHWyiq9mRwIXM6V8B3yHvYfGH5gepW80hSHZRyrGJc/wKL7C4=
X-Received: by 2002:a9d:77d5:: with SMTP id w21mr61670otl.97.1558613589047;
	Thu, 23 May 2019 05:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190514171545.24961-1-peter.maydell@linaro.org>
	<878sv7yn6t.fsf@dusky.pond.sub.org>
	<CAFEAcA9O4YUFa1X+TqJLGD2M3mPXwhv3WwL2thOk-aeezEaoaQ@mail.gmail.com>
	<f972c27e-de17-2d96-04d9-bec421c78384@greensocs.com>
	<87imu3swp2.fsf@dusky.pond.sub.org>
	<CAFEAcA_LFdwYX0Lp8Z=ecgJKC18F7i51nUjOT7YY+CQBaH_tTg@mail.gmail.com>
	<87ef4pisja.fsf@dusky.pond.sub.org>
	<CAFEAcA-8CZT2-sNBDEJdKv7PB-b1usNgbqo0O9QofYApvR-=pQ@mail.gmail.com>
	<874l5lnzjd.fsf@dusky.pond.sub.org>
In-Reply-To: <874l5lnzjd.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 13:12:57 +0100
Message-ID: <CAFEAcA98zZ60fAWgu4s9aCdKjafNtZsCt8ieEfTWYdZx5D2aGw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [RFC] hw/core/bus.c: Only the main system bus can
 have no parent
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 13:09, Markus Armbruster <armbru@redhat.com> wrote:
> Registering qbus_reset_all_fn() in main() is kind of ugly, but it works.
> There's a comment pointing out it's ugly.  Right now it's a TODO
> comment, which maybe expresses more hope for cleanup than there really
> is.  I'd leave it alone anyway.

...so after this long thread, are we at a conclusion?
I think my view is that the patch-as-sent needs to be
revised to also fix bus_unparent() but is otherwise OK.

thanks
-- PMM

