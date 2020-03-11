Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C266C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A73D206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 18:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrHV5AkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A73D206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC6GH-00073X-4c
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 14:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jC6Ff-0006ey-A5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jC6Fe-0002WM-9P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:38:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jC6Fe-0002Vy-6C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 14:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583951921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gl2ra51CpEMH98PeqLqwTeOOX5lyngPRyeYdFFRSSL4=;
 b=hrHV5AkDWCFKQIha4gijdoP5dFOlqWwUiAMoA1n5ujYzFXwonmLNSRiC+dRnO3CtnV3nL6
 GEgOZoZVroQpe8hXty6OiWW2glitWrpXDds14beDVRqseScX7KHmfFnXcuwKFkeZcWuvJD
 QlHhhn+c3jl5mBCurqLkKarFAgNatBA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-bVTiIMDvOH6QW-AouR-odA-1; Wed, 11 Mar 2020 14:38:37 -0400
X-MC-Unique: bVTiIMDvOH6QW-AouR-odA-1
Received: by mail-wr1-f72.google.com with SMTP id h14so646440wrv.12
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 11:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wPfYCjp+EpdRoDoBHXSP26GKooXEH0epVeo1qfez/u0=;
 b=bOAvku9p5aSPxtIM7LDQm320rctJky+q+MPJNTnIjiRsEYU3juB7pM86KBbrFwWAsK
 cDtWET5IoMnanZPyWAkpBbwAi0wIQfyFKY8pUkP9cfun9RU9CN48Mj5CLVKeVcpD1bLX
 koVVmc5XfxW+iUGlfLG0ThmLsccHG7Tjc9M664k8MbLdpxB4rEgWM9Nl9Mq9rnq5D+ii
 /8VovdSZkicA1DK6HUmot4pojRwG5E5Bt8PUZK5FbFdfBgnl1uXhvRVb3I7JkjpATQaE
 WybwHvOBbLUKTTDph3o77ojcbUyBRftiHx4wJ7Yy8J8/2/5NbQPiNFoUShpNUFBwdFdM
 yedg==
X-Gm-Message-State: ANhLgQ3nfUebwYXLnGwAtHNjl2uO3oTfpT+CKeHNC8SdiVI6lN9eDpV7
 pvoMapi+PtKmN9LihmWZmWXDjvG7UXmrWq1VgPl5KpXrxmkp5d9V38hRtS+tdSgkVc8fjrcUe7Y
 Y2REVZTTOGEQpbM4=
X-Received: by 2002:adf:80af:: with SMTP id 44mr5893206wrl.241.1583951916384; 
 Wed, 11 Mar 2020 11:38:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvgLEH90ncw/7N+89oSWeuLd6d2ZDyNa5PvMls5FLDI4nooQ38L2eQ106CoGQvJQsthrmzoIA==
X-Received: by 2002:adf:80af:: with SMTP id 44mr5893186wrl.241.1583951916142; 
 Wed, 11 Mar 2020 11:38:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8?
 ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
 by smtp.gmail.com with ESMTPSA id r3sm9279443wmg.19.2020.03.11.11.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2020 11:38:35 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] buildsys: Fix building with SASL on Windows
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200309122454.22551-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <03e337bb-4533-09de-2ed0-fc0ac83bdf3c@redhat.com>
Date: Wed, 11 Mar 2020 19:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309122454.22551-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0J/QsNCy0LvQvtCy?= <alexey.pawlow@gmail.com>,
 =?UTF-8?B?0JzQtdGC0LvQuNGG0LrQuNC5INCu0YDQuNC5INCS0LjQutGC0L7RgNC+0LLQuNGH?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/03/20 13:24, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix a bug reported by Youry few months ago:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg625606.html
>=20
> Since v1:
> - addressed Daniel review (always define STRUCT_IOVEC_DEFINED)
>=20
> The Fedora docker image already uses the libsasl since commit
> 8ea5962f286. Add the similar package to the Debian (host) image.
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   configure: Fix building with SASL on Windows
>   tests/docker: Install SASL library to extend code coverage on amd64
>=20
>  configure                                    | 4 +++-
>  tests/docker/dockerfiles/debian-amd64.docker | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20

Queued, thanks.

Paolo


