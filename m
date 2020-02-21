Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4453EC35642
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9F420722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 10:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMCjdzOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9F420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j55OU-0006sc-9n
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 05:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j55NW-0005ub-Fd
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j55NV-0006SU-Aj
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:17:50 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j55NV-0006Rt-3P
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 05:17:49 -0500
Received: by mail-oi1-x244.google.com with SMTP id a22so1055704oid.13
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u7wavj6OThSCoxCraTdF4zstIocPhDT1vEefuSemLQM=;
 b=IMCjdzOaRVvTNxJlhbJ+PJFDY/VqCRs3VD9KJzroBG8tMZUY/YhQbX1zJ2ZmLmzCpJ
 KWxLNY0qJLNp4ftTVe/oVFURZ95nFqDKoraWjorCQqIcYA68UgUyftSbre/UQf55jBVC
 VY+EHvurwE2GSLw9crQ+9E5zHMdYKcc8O8OzkiWbR1OOalJgqlU3d8T7IK+SIydk5ksh
 T8+EatJnPID4mARinMxQxD9iTnsviR/RHpDHPd+7fcmiM0+S3BNDDawor3nj4qQftEcI
 /ssORGJsooxHQCGbE/j/3eh3oXxL1liTzPx+5QeREwJgormoqjuwRWtmreTWvGDb1YI3
 PUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u7wavj6OThSCoxCraTdF4zstIocPhDT1vEefuSemLQM=;
 b=p11cR5dXGKo50+Nt29B8aRP+a3MQ1m1/1tieWtFvGctHrJvAnny0b/WBpXRooDvBkY
 SjST8UHp27bS5SXRyY8FF7kiRGd2ZwbzeajTBsi9fsFS+++VFWyG1d5RCLvURyVMxbHp
 LsjtFgmlE17AVtnOOHE59lbNjS6TGUOiTJqv+MHMsuO83wxTJ1Jrzl6n9ZAU1R2PCt55
 uI55ztAPx835LZKSeAPdoVJ4KZDRfT4wqKJWG+6gBQV/nWDdAKBZlvE8kLeSo2Cc7N3y
 zxOf+zPv0vHmfPkH5QKro1MNlwvAntekg3A2VO8BYgidwKTmaNLOr9DHmtaPg4gwdg/o
 nVTA==
X-Gm-Message-State: APjAAAVEEnMKglmaK4lHM/nLpQK0RCP2YtnNDUSvbn2mu1jqE0e16QZh
 n8tJn0R0O93Ytp0FRFGFJ9n3fYao1er0EXG/PDVf1A==
X-Google-Smtp-Source: APXvYqyj09GbiRvPOtWk+5gZhF/astt9hYzAc+AVr9Uusy5ZsHYGNqLSIciLfGRfb7vv4qSF5K+1e+c+q1OQqKz6okE=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr1398024oiy.170.1582280267863; 
 Fri, 21 Feb 2020 02:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20200220162214.3474280-1-eblake@redhat.com>
In-Reply-To: <20200220162214.3474280-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 10:17:36 +0000
Message-ID: <CAFEAcA8p7D_XFZ9e66wWHNSD6fh2yUvFyAM3QVrwBP7oonoCjQ@mail.gmail.com>
Subject: Re: [PATCH] maint: Include top-level *.rst files early in git diff
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Feb 2020 at 16:22, Eric Blake <eblake@redhat.com> wrote:
>
> We are converting more doc files to *.rst rather than *.texi.  Most
> doc files are already listed early in diffs due to our catchall
> docs/*, but a few top-level files get missed by that glob.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> Both *.texi and *.rst entries make sense while we are still converting
> things, but we'll need a followup to drop *.texi when the conversion
> is complete...

I was wondering what rst files we had outside docs, and
the answer is "README.rst, CODING_STYLE.rst and
tests/acceptance/README.rst".

(There's a reasonable argument for moving CODING_STYLE.rst to
docs/devel now; depends how highly you rate having it more
"discoverable" to new contributors.)

thanks
-- PMM

