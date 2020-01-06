Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CAAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0130424676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5p2GZUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0130424676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX2D-0000PP-7y
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioX1U-0007yx-N1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioX1T-0001pz-Ez
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:22:40 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:38240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioX1T-0001pB-8a
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:22:39 -0500
Received: by mail-oi1-x232.google.com with SMTP id l9so13837383oii.5
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UHjJxboTBKVUiBSfVPlqkZ919fmiFLCQYAEoJAJpgps=;
 b=v5p2GZUTxtQLNOBdCCj0wwWJGuByoHviPQX4uk1XGsrfjeOmYK5JrAh5ztQpV//vT+
 ktn6y/Zq/W+x8mO+0ADjq18xwqcUuzbpLCcXOzllKm0hvBRYghIFOvsU/qRFapCWnIa1
 /VENLpvi16JDcs+1o9hbS9OoD2KZCC3S0lefrXHFKPHw8ir2MGOW/sV+KT9q5lvZrbUj
 0ByiyaH/Ktv7qHFYdpKFCr54fCMhLbucetH0sPrYoJme2gfqeZY2cUuxDFmt87Y8g8zG
 mcOfGpcjFZNjJSxM09WqUpNZLnQFmrVOz+5Cq2J+ManaKRW2FRpJK+qBt/YWFkbZ7PxM
 yseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UHjJxboTBKVUiBSfVPlqkZ919fmiFLCQYAEoJAJpgps=;
 b=bqP1E/S4vlY43fP/HBqWCiBS347F639Da77Rx+tHxOR1tHGvMHd1/3jLmcqipkF48a
 hSaRw22lsXVjabxuSkGGCV7/MqzdQFpo4tELCgMJI4TC4KGFdxuCV6lSsLQAc8DxbUUq
 W4wrL+Ts5pjfIY1cKB5yGLVYD/4ExkALGcMnnbMW8DiEil1AyZLwfpBkY46hb9yvI25F
 FhVFPNaIgX1nyihBtNn3ItPOvpyZg/vnXumOYznZvdgAfiaStUnm9ZPMxXhct56xIbQJ
 VJCAHUuIffr+Hmb8zVT8K/EmquVH9btpEi+8eM5v/Ga1MnhI8L6lcETfdf5kkQsAaMzp
 qP3w==
X-Gm-Message-State: APjAAAWmv3YEzK0zI7/+gLWrqA8KPLVQSsPu7uLVkJLwCdBDiaoD+0re
 NrMxg9znuxBdE0fpsQhWNOHJJ1baOcOBwS8yqZRq9A==
X-Google-Smtp-Source: APXvYqw5I3+sUhmQLuQHXNd3/okhyosD1XHicyXUAdmK4TA/pxhHiATXG6u4+zoyTp0rmYZeMSOr36YK9WRwFURJpDg=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr6382669oig.163.1578334958161; 
 Mon, 06 Jan 2020 10:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20200106144206.698920-1-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 18:22:27 +0000
Message-ID: <CAFEAcA_u05UkX0f9es1MZaaJ0+KGrKFeu0rBRC2ZJ6z9xLN-uQ@mail.gmail.com>
Subject: Re: [PULL 00/34] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jan 2020 at 14:42, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit f17783e706ab9c7b3a2b69cf48e4f0ba40664f54:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191220' into staging (2020-01-03 18:50:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-01-06
>
> for you to fetch changes up to 503ca1262bab2c11c533a4816d1ff4297d4f58a6:
>
>   backup-top: Begin drain earlier (2020-01-06 14:26:23 +0100)
>
> ----------------------------------------------------------------
> Block patches:
> - Minor fixes and tests from the freeze period (too minor to be included
>   in 4.2)
> - Allow many bash iotests to test qcow2's external data file feature
> - Add compress filter driver
> - Fix Python iotests after 6f6e1698a6
> - Fix for the backup job
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

