Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A245C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA53F20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3s57O/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA53F20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFtm-0004jQ-1n
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:54:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFrH-0002ie-SM
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFrD-0004Wu-Rq
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:51:39 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:42772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hREyp-0006wy-1p
	for qemu-devel@nongnu.org; Thu, 16 May 2019 07:55:23 -0400
Received: by mail-oi1-x22c.google.com with SMTP id w9so459322oic.9
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=CuAMivnfo6K315tiSkMxQUNeBoA572jc3TfjxQot0Lo=;
	b=l3s57O/akLc3INSz276uaGYZ+reCKs0gBLA5rhsHLHyUFMj3QykL8U39rbpb+kpKcc
	cg0TR2UaoRU7dZ5lFnJygnFmDcMbLwTo2wXzq3CUbz7bMymd6CwK9nr5YuNQ+/HbDQcW
	iIT2ACpsLG6gcevr4X329CKBt5j8gxLGzuOvvVOXm24hvae2unCYN0I8a5Z1VFdljrw2
	jmaeHwXZ/PrJBoxum+w4QVCkafjp0xayoEQ2Hm4kFuNIOyhF3jSQFOc0TfpW0uNj6ZlQ
	D7yJx2zL5SrJMy+4NiSsWio8xWX3mANn2zFbL+LnyN/t0+CJKHft+M1d8m5ihdS90hn7
	A3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=CuAMivnfo6K315tiSkMxQUNeBoA572jc3TfjxQot0Lo=;
	b=NDaj1xudatXIOAR+0WXQ4ia6b5+AQsUDu3MRtReT1JRMt4PHZWoQvWgVl1KBlF6ygW
	27ew3x6jZSdd67yAJb+hBBHwWdKQ2Erd8dNyEAEbqShaePgAht6Inpooppj7ms5ct9KY
	INIW8PNJ5cb5sDlmiH98xMIS1CT5kbfJzrFzvqv5IlLSG8ZkoSU+76rSapYrF4ACIChJ
	G6A8+k3XiTHoIOV3gSxuIEYgo1QDCRt1Ij6LA3QUQMmbMBzqqb2K1xjU/kioNnvnmeSE
	qqwFeyeL4NU0rjDHxfLB95dNgtlLm9y86sQaLxFGVqgHuRDXlFDrXvBjphm6sU3Z8PI7
	vh6g==
X-Gm-Message-State: APjAAAWrgZnsngap+MMfYgmmUOxp4aV84gw+i6ozQL85vlnB5uheaC9l
	kFmnDR+sMZu5IvOo+98kxHbtyz9lttt/BaVsWivF9w==
X-Google-Smtp-Source: APXvYqwOBgC+QfG/Wi5AlnM3ilUYpuR9A4J1CtwwamneyO2wPPt1kWwSN5NS/L1BN+Q+V4IOJpT1JlGPSVOIV+eNZ2A=
X-Received: by 2002:aca:845:: with SMTP id 66mr10220492oii.163.1558007684661; 
	Thu, 16 May 2019 04:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190514183454.12758-1-dgilbert@redhat.com>
In-Reply-To: <20190514183454.12758-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 12:54:33 +0100
Message-ID: <CAFEAcA-Wb7tCVGyJqfVH1WmRHQvGto=Bs_DkeT8StJ7KSi429w@mail.gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL 00/16] migration queue
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
	Yury Kotov <yury-kotov@yandex-team.ru>, Zhang Chen <chen.zhang@intel.com>,
	Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 19:36, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit e329ad2ab72c43b56df88b34954c2c7d839bb373:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190513' into staging (2019-05-14 10:08:47 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190514b
>
> for you to fetch changes up to 9d3250d5ba8c4c5389530b861686e22e77fddcc7:
>
>   monitor: Call mon_get_cpu() only once at hmp_gva2gpa() (2019-05-14 19:00:04 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2019-05-14
>
> Small fixes/cleanups
> One HMP/monitor fix
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

