Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021C0C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD48720787
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuDN6Hxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD48720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzQz-0000HM-Re
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEzQP-0008Fu-LB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEzQO-0006Hu-Er
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:57:45 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:40680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEzQO-0006D8-80
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:57:44 -0400
Received: by mail-oi1-x231.google.com with SMTP id y71so3629104oia.7
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SuPc0R3tXguM5jYs6E5F8oPwwkr/nQcpCu2CsOv08vk=;
 b=QuDN6HxhdZBWh6b4Q1vqhkRKkIh8tUlfAJ9dVgC/EceJfUPD74of+P3vBCvF5/SY0l
 EK/3cr8dtktZ1ak23eqhpzOfYnDs1NH/FYrJ35hrbcpPCoqP9+n4Q6F0SNSVzc2ro8yy
 PWMcvMi/T8D/6RhF7QbT+4KVUsSEXBLDa6zUaAu+Yml0gj38r9AatIICjtXHFntd6HDv
 lx/sXneFs8yvzdHeQ6NjZDS3cNs5u8N4BINdSV8fdBV3JWYgFMSo9EyR3JmOSZGettVu
 iTmyx1ORJyPN23ImMkMXKqnbrnEWOV9kMrvPVF8kH7iXbScqDaTLZS8msrEh/V54DKbC
 XG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SuPc0R3tXguM5jYs6E5F8oPwwkr/nQcpCu2CsOv08vk=;
 b=dM6S+uEOXsKSjH9/OCS7atvBIUolep/ph6bJRbIWuKPN/G8rTXCobsEz+c/V1PGt2V
 ATwd3ADCQYT4tkEl0/PNzUSS2yAPXNWEWpPbnYQzs+ciGalSfOIeT0G6pYmxPl90m5AE
 1iuVyYnUFfzu4ZC+IA/sJSn0LtKH9gK3rjcFyrpD/unL2Dj+OCbOsrtipEVat+WiUUZC
 OxtRlgUDD8TZ7MzZmIdP4oAVPIU34yKtfXsB6BHwtgpDX37y2I+67qdDQgDeVCHT8bJo
 3q71YmtucYt7c7ueSzFahRYHqDeBtpUb/AsSE1HoUPuZVzBlBr5klMudvC4gg/la+7OE
 krQw==
X-Gm-Message-State: ANhLgQ0kPgcCVqQq1T5ix2ufbXJwPZ8MNdMeN9HGC1DKjVhJWVnPYSTF
 gcw56EBbP+k72sSYc8n0OnX5nB6O9G5SmNPksNTJzg==
X-Google-Smtp-Source: ADFU+vs+p1m/3fefvOSPNHoGLh8YWnNvyX5uGQ8v3hzHA/UmmDGN8W3IDePJujBp1hTCTN8qPFOcFkcOCuT4MMwzxOw=
X-Received: by 2002:aca:c608:: with SMTP id w8mr3358936oif.163.1584640663373; 
 Thu, 19 Mar 2020 10:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200318202341.6961-1-jsnow@redhat.com>
In-Reply-To: <20200318202341.6961-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 17:57:32 +0000
Message-ID: <CAFEAcA959fk21aqQ+N=9qcHntviDL8tp2eXv1dMP2KVikoZg+A@mail.gmail.com>
Subject: Re: [PULL v2 00/11] Bitmaps patches
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 20:24, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-03-17 18:33:05 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to 2d00cbd8e222a4adc08f415c399e84590ee8ff9a:
>
>   block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty (2020-03-18 14:03:46 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

