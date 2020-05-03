Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67675C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 13:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3120F2073E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 13:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYoZCsrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3120F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVEQH-0007so-9b
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 09:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVEPj-0007TE-2j
 for qemu-devel@nongnu.org; Sun, 03 May 2020 09:12:11 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVEPh-0006G9-Cn
 for qemu-devel@nongnu.org; Sun, 03 May 2020 09:12:10 -0400
Received: by mail-oi1-x242.google.com with SMTP id o24so4246491oic.0
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0RUyQD1v5eEqHDBovmfKRvSVyNGhd1EFbXo7kEWcaOk=;
 b=AYoZCsrZsdhAGVigg0FAr34mLhTRr6UsSZjHKlHkgYj+MJ2fI8LaJxhZzQEbPD7qkf
 albIUgDvBEC/s+yQu4Z0dDzi/QkiSYBddOgqwENkzI7SL8CL7YDHPNNevnb8iEK7LxKt
 R2+g4b/hZkjqXMJJ5kvdxB0NZiMfAHe792SoJtYemHg5DW8UP/iCVAwsK9tpcEMF1ppP
 2/g1VSAPmOUlKKkxzWM4NEsJ6tEnCiG4ocJtijm92d76qr5MLMfT86pNVcQZTDnYDsPu
 Nyjct+B7Yv7p4GEn6p9o+n3YVeGzt1bDRl0mWTkev6bUY5fSTt6Ky2tf5JDyxtei1gni
 V/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0RUyQD1v5eEqHDBovmfKRvSVyNGhd1EFbXo7kEWcaOk=;
 b=dnkmlXFLZPqJRCfwNXbEmyQTnoG8HmajBdAONqmqI3n5pdPE6AGbwgJTdZe8S2kJJa
 4ea0KsTx6HKxTiD/LUL1wthZ1lTxqucCCjfkxAx+gs9+JQPJVCfk0dxfxplVzmRA49ID
 AOBfQ5zOEleQGUlCL+qybkTWM2Ay8gKUhTQIbTkbhR13gYsoXJ7n+v6wTdKQg1Cm26js
 DMWfqXucVeoKpVeVh92Stk/r/flqO9Rxk67zZCIfpP7AbjHAIO86XO/IKFj9jr3e7sb9
 8cIVgNGskwf1F3nIWyGu1zRqjf6aZ9wPUQmJPz89HZ7sZKdHoWEtbviTVil6Onk1mqe8
 bwcg==
X-Gm-Message-State: AGi0PuZkM+S1L7dttyGB4Sjn+SkCwEBBYCx8faJQ3d9Yy3M/rnMk1Kv9
 gX7aodN+WNHXaqCvffFKVzQx4EmABq2fvgza7JJ4XQ==
X-Google-Smtp-Source: APiQypJ05fFOVok37w3ZGtia04zuHmX+6W63LNIWutGa8Rjt/XyEW5sAj0WFSlQde2RJ0oT1HeONWSgMT2hGlnsbjuA=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr5461935oia.48.1588511527501; 
 Sun, 03 May 2020 06:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200501191500.126432-1-dgilbert@redhat.com>
In-Reply-To: <20200501191500.126432-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 May 2020 14:11:56 +0100
Message-ID: <CAFEAcA8W3kreu2s_4wjvP4mNgPpVHpv8A4T-D+etUORg18Rtew@mail.gmail.com>
Subject: Re: [PULL 0/6] virtiofs queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, yavrahami@paloaltonetworks.com,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 1 May 2020 at 20:16, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 1c47613588ccff44422d4bdeea0dc36a0a308ec7:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-04-30 19:25:41 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/dagrh/qemu.git tags/pull-virtiofs-20200501
>
> for you to fetch changes up to 66502bbca37ca7a3bfa57e82cfc03b89a7a11eae:
>
>   virtiofsd: drop all capabilities in the wait parent process (2020-05-01 20:05:37 +0100)
>
> ----------------------------------------------------------------
> virtiofsd: Pull 2020-05-01 (includes CVE fix)
>
> This set includes a security fix, other fixes and improvements.
>
> Security fix:
> The security fix is for CVE-2020-10717 where, on low RAM hosts,
> the guest can potentially exceed the maximum fd limit.
> This fix adds some more configuration so that the user
> can explicitly set the limit.
> Thank you to Yuval Avrahami for reporting this.
>
> Fixes:
>
> Recursive mounting of the exported directory is now used in
> the sandbox, such that if there was a mount underneath present at
> the time the virtiofsd was started, that mount is also
> visible to the guest; in the existing code, only mounts that
> happened after startup were visible.
>
> Security improvements:
>
> The jailing for /proc/self/fd is improved - but it's something
> that shouldn't be accessible anyway.
>
> Most capabilities are now dropped at startup; again this shouldn't
> change any behaviour but is extra protection.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

I notice you didn't include the usual Cc: qemu-stable@nongnu.org
lines in the commits to be backported, but I think the stable
branch maintainers can deal with the occasional manual notification.

thanks
-- PMM

