Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D27CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D882083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMpilucc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D882083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ5aa-0003CN-8F
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ5Z3-0002Iw-CI
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:12:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQ5Z2-0007Qp-6e
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:12:17 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:38310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQ5Z1-0007JT-Vl
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:12:16 -0400
Received: by mail-oi1-x235.google.com with SMTP id v186so4415584oie.5
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 01:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iqO/qdTKzyrRFvsCztpbLyq3b2K2QnxtRfolHig/lCM=;
 b=mMpiluccx8h3ikxO4E36H+Y9RE4KPACNXo48BCCpEE3GdCl+DPwB7j4Kj5F7YhpEjG
 HA4Yd2WQHTOgk+1c6vvMKuHGlavThPSr+1qE7hSKkPc4ynOsCQFcboByPP1deYgz4MRQ
 YSZmPqdWd76ogxQ7LNMQIMsanE+ODIWEtB/ll+XRD9/AYpa3Sn+ELyU3JPtDuEw3/6nQ
 ozuzbs7iOUyUOry/Zww6T1yZnc0MQmjJJrUwPjXJuFcBRjMqs/kQNkQ5PJ5WQqreesi3
 7JvhGW8sD+NNryf0uAbkRBNLmrmmzzzBl7J8nKmvwtkWmKlFc0lZacAhychjVL/pUWyk
 me2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iqO/qdTKzyrRFvsCztpbLyq3b2K2QnxtRfolHig/lCM=;
 b=BRxlOnY+8g8VoCvfix4uQJJPz8dFsZ/l1TqjhPOgvKKRPGqoR6fSOtCVBCp32TDuRH
 npI50mmQ41crdQkynXPAWhw+RDaXX5TSTnI9t+ciD3DG8AwKjOIKWzhsQPdbj8lxkvtH
 ruxnlkCjPPenjdr+yx1nVX4LLUIaIUWfw141qkqNA3JlgrM7nLHgzPv3U5ZHAbLLIDZ4
 LgMYnf2y71sOwyC1d8MCsSQFh2pgMucfSlvQOqBEz8NBIJYBeyk116UxiP76FvuLw+/V
 7H6FnBFlngOyNc1mJkT93pUIT2YlxNw4d2pWoz1kjx6TC7CIZ8Qk9i1D4QmrsqCh8yjT
 gYPQ==
X-Gm-Message-State: APjAAAXtnp10N07w/STly+ClyJoOsx7T8Y3k8uOkyGkmA0y/rdEGXGxk
 0OvbIVSBHLRvjyiG0AwRkfwkOFiiVEwSCTJOPyXLdA==
X-Google-Smtp-Source: APXvYqzfy0eidPlPWz6PhfZ9dSN7VPAzehwPanKRjhKAXqBS4QPEjum5nNSzW0Sp5eGyLjmgDF1jgW7a3EoZykJzGnc=
X-Received: by 2002:a05:6808:2c6:: with SMTP id
 a6mr2923122oid.48.1572509534537; 
 Thu, 31 Oct 2019 01:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191025203427.20181-1-ehabkost@redhat.com>
In-Reply-To: <20191025203427.20181-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2019 08:12:01 +0000
Message-ID: <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 21:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 03bf012e523ecdf047ac56b2057950247256064d:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-10-25 14:59:53 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to d24e417866f85229de1b75bc5c0a1d942451a842:
>
>   configure: Require Python >= 3.5 (2019-10-25 16:34:57 -0300)
>
> ----------------------------------------------------------------
> Require Python >= 3.5 to build QEMU
>
> ----------------------------------------------------------------

I can't apply this until we've fixed the tests/vm netbsd setup to
not use Python 2.

Have you tried a test run with Travis/etc/etc to check that none of
those CI configs need updating to have python3 available ?

thanks
-- PMM

