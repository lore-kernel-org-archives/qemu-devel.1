Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF02C28CBC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382E3206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byFZbOa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382E3206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9nA-0000GB-AB
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU9do-0001wb-EL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU9dn-00057t-HP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:54:15 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:41198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU9dn-00057Z-1O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:54:15 -0400
Received: by mail-oo1-xc42.google.com with SMTP id t3so1291774oou.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NNxYdaib8CMyxtlzKDpq7zsL0Pmfz+iNnAEEkFTtwVo=;
 b=byFZbOa1no9ydV7y0HYAYK9sufjlBrg5c7xPwAeHYXr7fxEdJDiNFKL7ZE/euEfrNF
 z/GhUvPaQy1hJDVhxtdytiCqm+s8uyy8sYKygoLkPkorJy9zuS9APXxaHPeG759oluqO
 WDihhUJYfIGxylksTjzuehKVC+Nc36yRxCiC2l08gvtq0h3BKpPNGJ6nKpEjVWSAxj8O
 E9AIZKHG0WrVYfyrvBhjkFSAm24Bqxi2QeB5+A+8trYqtoNH4wpte/qQN/DsQ6lGtIJ/
 SHKfwS4f843E2yObwFyBpVtcosYPDGScaGL6xnLOHOhNa9v8AAvCbb2SfG3pO0R+Xq2l
 4ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NNxYdaib8CMyxtlzKDpq7zsL0Pmfz+iNnAEEkFTtwVo=;
 b=LGY0sfmCu4PRCda72vpJBu8sJQve5TfTqo7BVgFdcNXmQMLYKumf0yvafh/7JT9ZUL
 MOfpXZq6nsqnWIsrmrKosMZMwJBxt2wh6T54/tcZbq1z4o8P00zfSiPhT4GFqb6FqRel
 kGaDxYrfobFbug2R0nJKs9kB3+2AhEYjlotPSWhDpocosI1J+5cVsc0utwUXsP+XZAGo
 tVljLhVQ1PatTzCqr3mlGQNlZaLDynau5JGeHLzvGYNkZ9gI6iz0V5Z64zTD1tyRUraf
 7nF+SGepWCGV+DjLkORKweYYiJx5NiVSyT3cSm2VxHL8wcvw8vnkAG41znCcOeZvrYXO
 yeOg==
X-Gm-Message-State: AGi0Pub67rOC469cik+E7LL28utnsKG1yalDP3EERxRPriepPmVPlAvt
 1RVKmU5lt4GxgulPkyuy6zTwJHYp+mUn0WC76AYGUw==
X-Google-Smtp-Source: APiQypK2VAbp/bjFrcbEQYgByqBH8J46+nAPyzKBiCICIjGu4nh6zuz4uiUDFRdwRArFr8As5XgL7eRmmO3EPYswNO0=
X-Received: by 2002:a4a:890b:: with SMTP id f11mr2876392ooi.85.1588254853318; 
 Thu, 30 Apr 2020 06:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200430094445.25943-1-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 14:54:02 +0100
Message-ID: <CAFEAcA_d2dJVoa2q_NLF-aHrRg1hypMqWH0KG7Hv9HJ=hGYcLg@mail.gmail.com>
Subject: Re: [PULL 00/20] first set of s390x patches for 5.1
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 10:45, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit ee573f5326046223b6eef4ae7fbfec31d274e093:
>
>   Update version for v5.0.0-rc4 release (2020-04-22 17:51:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20200430
>
> for you to fetch changes up to fbc1384ccd48fa7c0c38f950adf7992a4fb6042e:
>
>   s390x/s390-virtio-ccw: Fix build on systems without KVM (2020-04-29 14:36:19 +0200)
>
> ----------------------------------------------------------------
> - update Linux headers to 5.7-rc3 (and virtio-net fixup)
> - support for protected virtualization aka secure execution
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

