Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A8C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7469A2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I6cRXMEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7469A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5OT-0000zy-QD
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40875)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hb5Mp-0008S4-PX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hb5Mn-0002cZ-U2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:40:51 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hb5Mn-0002aw-Cn
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:40:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id s20so1531082otp.4
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=djvtYB22OLGm/uM75GsGGWYU6ZCZwYXdLnz40yxeXb0=;
 b=I6cRXMEZdlx8G+KDcKcUYcFwwKMzmc05fnz+kjSDTahmA7SvfgHsLlv9GLRZ3FRvoP
 TgElxQ6eEXVuJzJkJ78Chy7SfzAAQWSyvJasDzd5tCPJtfOangBLk6VNXeFftBUCIWyF
 hv6NkAHojY5yjezH7Xyr9om4+iMSR180uu9kco5HFyR2dwk0pwzdWROJgu9qIuI3m8ar
 FIA/lTU4nhRGcVqLmQzNfWkGSeVt+Z9tyvVUanWE6Wb/rN+oqCVYnF733Ct2xt1r3tQ9
 vop5gysF9YwZ0qPnnFmCc8afpvnPvZHJ8G50kM5Bqd1/cYj2+4VXxkgjrqez1sp4iTEz
 vhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=djvtYB22OLGm/uM75GsGGWYU6ZCZwYXdLnz40yxeXb0=;
 b=MpOi1j7SyaROPczQU48VijPlsae8TCyDPcCBROTj/WfNMph8B+lG2cebuB2jM4+tJj
 55CrX4qDozdk5SJKrAk+YzhusOZ1T4YnuW5Xd1kfFZfQWql1x2//Y51bSZ7sJupAgxJM
 YQZoLik1Oy7AczN50RRfihafkTkwzB1rVnLh2iFFVne9jBp07oFHkk3Yxzyn+u3mKVFS
 JIMgUYBnKvydZKfEK9SodwTXKkjHPkE0dANMWguS4Qdg00koeX/cYpiLuq4XBQm6/3A4
 Loxed3FWz2XSv6OV7FbcOYqzgzgRoM44X7by3YrR3aDVp862+l9gcqWGSJyx+CwzPR3Y
 Z12g==
X-Gm-Message-State: APjAAAWVxI1nWovQuGsrQFjB7e8/xoCzkUlSQJYSjvIzb/JIYRP+Pg8i
 OfEzvQI82D2NqQvzgGCpB2hrCsIZmdnxkSwg6po3Wg==
X-Google-Smtp-Source: APXvYqzPRcc4jP1R6Tg6WhkliqWCcVmwdhkauSNhwBhgffz7WqCIoXYdfGHARbymmV0BKRzTg9ei480PMwseg/LAXes=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr4928458otj.97.1560354048136; 
 Wed, 12 Jun 2019 08:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190612054929.21136-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190612054929.21136-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2019 16:40:37 +0100
Message-ID: <CAFEAcA-nBM+03N6vaD=nJbAMhQEHnMywUx5FOVRujdvR+8VN5g@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/13] ppc-for-4.1 queue 20190612
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Jun 2019 at 06:49, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 219dca61ebf41625831d4f96a720852baf44b762:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2019-06-11 16:02:07 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190612
>
> for you to fetch changes up to 4aca9786542e427d4337503566efdf09f2cb87cd:
>
>   ppc/xive: Make XIVE generate the proper interrupt types (2019-06-12 10:41:50 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-06-12
>
> Next pull request against qemu-4.1.  The big thing here is adding
> support for hot plug of P2P bridges, and PCI devices under P2P bridges
> on the "pseries" machine (which doesn't use SHPC).  Other than that
> there's just a handful of fixes and small enhancements.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

