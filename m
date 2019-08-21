Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F788C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE64422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUEjbF4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE64422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0QI0-0003uF-0H
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 09:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0QHG-0003JN-5I
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0QHB-0006Xy-4K
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:03:49 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:46359)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0QHA-0006XP-Vu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 09:03:45 -0400
Received: by mail-ot1-x333.google.com with SMTP id z17so1908766otk.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UwvzvB4SEE6/d1QR9Q8LZH8qGjKNPnlAOp089lEVWRk=;
 b=hUEjbF4eg07IquppL7LtdJq4vXDETpj9BwhcB8spZlMXuzmBqMhdSFSMBXNwucafem
 gFvjsgu44JHOSzvxnCWT4rNErI7i7Lp2d4CpRzU73Hym0U/zjATm9/d4ljkDoOGuIL4M
 2kyRf5yNYtOdoqF3uMt/mrtc7fPy5iFZrb1/wwWtcnrWcOT/Mjd+YlBoauPtJTVGxbYn
 5CXkb2E1+JMaGKFaDoicF0kCaaMHi8appRR+ikjGWB3CQRV7WbbV+4p9aBvHLMrpzKK/
 RzmqS3jDTYI1nNIybsiuJpPnzIas6t3eMelEKb2OrkMMaFzwR15WlYEfUCRaMh+OFtmU
 qy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UwvzvB4SEE6/d1QR9Q8LZH8qGjKNPnlAOp089lEVWRk=;
 b=dVbwoIts989pBRgV84HsefzkN3WhJT9J2l4q1E+PY8O3V0mjSDCrq1YgwgCjEd/H1D
 HZtl1FCb31fI7yfDz4XfjDH4AknpabUbLW6v+OFDdQ+exfYWci6s+bdjicEeFqyKotBB
 5Zs9e5VhrKdF4j4ydXJ11SLuI2JPTcFn338BOAxUXVPkXTjJqeP/QEmLCEHfrDyESSkK
 fCbKbk8jLvaGBxJuKHR2lUTBKdUR1CZAH3z5WXAmZdFSZEqYnxknZqXhh9oNlJGAh2Ns
 BwR7qiuM11UxrmFCtVEfa4j2aPdqaNRPVklSPUKl3DoDEzgLNWndYQcebaMArvFGer4+
 N8Zg==
X-Gm-Message-State: APjAAAV1/NlTqgmYCsC65xqgXmBj1cGRr1Qw4M3cWtfoJ0s3AVuKM98h
 kl8gks/Ia+my7u9UMBaZlqV/NPZ9AfW31e8SULJ4eg==
X-Google-Smtp-Source: APXvYqxZziDTVz/5gDN2LsxfPL4fqWYeFrRUgPed0Df7a6iMY4w++9PBHq4q4qg1TG8CoJZUMccyt5ZOBxHyvvSmye4=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr3613237otq.221.1566392623569; 
 Wed, 21 Aug 2019 06:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <1566324078-56764-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566324078-56764-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Aug 2019 14:03:31 +0100
Message-ID: <CAFEAcA-6pt4-M2=Lxo6Zr4HF476z7Yr087Wfep7ApcirGd8tZQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
Subject: Re: [Qemu-devel] [PULL v3 00/33] Misc patches for 2019-08-20
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

On Tue, 20 Aug 2019 at 19:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 80db491da4ce8b199e0e8d1e23943b20aab82f69:
>
>   x86: Intel AVX512_BF16 feature enabling (2019-08-20 20:00:52 +0200)
>
> ----------------------------------------------------------------
> * New KVM PV features (Marcelo, Wanpeng)
> * valgrind fixes (Andrey)
> * Remove clock reset notifiers (David)
> * KConfig and Makefile cleanups (Paolo)
> * Replay and icount improvements (Pavel)
> * x86 FP fixes (Peter M.)
> * TCG locking assertions (Roman)
> * x86 support for mmap-ed -kernel/-initrd (Stefano)
> * Other cleanups (Wei Yang, Yan Zhao, Tony)
> * LSI fix for infinite loop (Prasad)
> * ARM migration fix (Catherine)
> * AVX512_BF16 feature (Jing)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

