Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC63C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 15:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16987206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 15:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUUYpNU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16987206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48571 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK2wG-00084n-Tf
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 11:39:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK2vP-0007SZ-0b
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK2vN-0006Cf-1K
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:38:06 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hK2vL-00064Z-9D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 11:38:04 -0400
Received: by mail-ot1-x32c.google.com with SMTP id r20so1873964otg.4
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 08:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=QfHq/CZsEB2O/pBcnC9m2rNIy5/GdqRC+Gqzq+IxEek=;
	b=oUUYpNU0m5VzlfmOLExaelN11WOW4nC4qskfFNOE3lk9mZWpgd/i1FPM1urudjkA9c
	e5KutJ8uV+ixwPzbGWI9ti6ZdPG28jTiGaG+aNzeLrd5KjtjgQdXp+mpVZNisducnpU+
	YmpqdHdLwNmTHUu9W7Kt2/LahacbCDMkZyEdF3GBnuMaXsUQn9CUbS51NaJE9LYedhRR
	/nyNMjAKScFmekLegs7+Dr+Aha5BRRQ75TS8nQJLT8MTvJnZ1iXj8dqOZTWTUQcoMRnh
	yUMDybpx6iGDOeH80rgVkDMSWv3EEJWP35ZKlsixFZhEeBVbWaviV5vyhXa+KDgidUtG
	GCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=QfHq/CZsEB2O/pBcnC9m2rNIy5/GdqRC+Gqzq+IxEek=;
	b=jtAB+jwaJ3DwTLS3vS+7kd4azVFlD7/9HIn2nixyDAEaQTrSrsNkJt5JtQRaEpW9z0
	3lzNdfKE4HW2q4VbNwji+v6PUAZ4Dpnwl5ex4ukyXiIXxfCUzEFHqi9N/Dy7JE+TnK48
	SXucqglk7CV4+SKlZtlJamvWCsKIyr5nreXL5rf6TS2rGe/xTG3PuKMAtPHonur2mUGA
	sMRrRSAzGwVvdp8zLEfEPbLHqe2MicbziSNLiC76dF3rfDGT5slp6mJ0DrQrvft3SrVo
	nMRIDZBd+v7Pskh74EuMZ+DwAJadVKH2gM/NFTYT1NABC7zwuVqFUROY86Fd4UWthmJc
	Ye0Q==
X-Gm-Message-State: APjAAAVIMu0kBvysrmBL0bMmo3u83rHeRvJj33VUYRC0Mv00gIaQhIM4
	yMuVcQfIwHG8X/qTs3c5vh+B1b9i3yEadaBhPtFs7g==
X-Google-Smtp-Source: APXvYqxgdvtFUZbMumZ4q6KWvBxJ1AcxijyKMjDNq4Sl21N/C87rpHockg0ecHOhNSUFxzQO3ZVUvV4peSXwG3rWgBk=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr26113379oti.151.1556293066752; 
	Fri, 26 Apr 2019 08:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190425175659.24876-1-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2019 16:37:35 +0100
Message-ID:
 <CAFEAcA-9NBHWb9GCsYAHZ6HMw0NTRi3Ms-2171QO1Wnig8256w@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] [PULL 00/11] Machine queue, 2019-04-25
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426153735.Z2RYnD9ybhah9QGBxiSOUcOCG8up60zB1JNB1yy6aW0@z>

On Thu, 25 Apr 2019 at 18:57, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 119906afa5ca610adb87c55ab0d8e53c9104bfc3:
>
>   util/mmap-alloc: support MAP_SYNC in qemu_ram_mmap() (2019-04-25 14:17:36 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2019-04-25
>
> * 4.1 machine-types (Cornelia Huck)
> * Support MAP_SYNC on pmem memory backends (Zhang Yi)
> * -cpu parsing fixes and cleanups (Eduardo Habkost)
> * machine initialization cleanups (Wei Yang, Markus Armbruster)
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

