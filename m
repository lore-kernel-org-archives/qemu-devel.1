Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4CEC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:31:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573FC21781
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hM/K15A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573FC21781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaRNy-0005Zm-Bn
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 16:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaQ3a-0004Ub-0f
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaQ3U-0005QC-Rs
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:06:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaQ3T-000586-TY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 15:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574971580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDIym4OHMEWbiOUI+TteBrIR8mDSvy/eXHajOEdeLrc=;
 b=hM/K15A9FdJIKix92bEc+6ThYU/GssuF5LXs/mQGSgg7NABHBxcEA8GRvZUWdXx6aghmKO
 VqLoRJ7z7VQGTP90ubUKP/BHiNPV/QMrSNKmHiLe3BM7KzFlGc1tl4+g9LrtI2CLfBiKjo
 B9ltqjgJt9yBTdw5rKC74JdChLl5zAo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-0aW-LHWLNnScH6VQryMaCA-1; Thu, 28 Nov 2019 15:06:18 -0500
Received: by mail-wm1-f72.google.com with SMTP id v8so3820489wml.4
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 12:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wQQAyUg+BrOixEIVEvxdKaMHKTPSyqFGtJrsl6yh4YQ=;
 b=oUF8/13RZuutcUY6BmiqcjQoJbrw3Tmxs0AC4YePOJeJMG7I8b2j+GlO1hPDdhgvNj
 CUb+7E3Kl0SMlhsAlt8m5o7D13oTy7SdGsYIY4hoYPy836wBsGVSWqbeGf/xEBf2sApH
 nJ6ZfAUSfZeEkdZslV13cduUgeMUCAl5+4P0wOUHq+oON10JC5Xg8l30WkwLfFY2Rxki
 7Uwhxk5e4a/NTXf2WyP0cQnx8F3vBGKG9wCl89CkAcE27Nm+FVuBDIXztdoVVj2nQb0n
 gPkKarWT7+tkj9RYFgW+/OSoQh9LWQuCDoguuiJ6OCo662u8NeXVh12Sz6DNroXIFSSO
 6HXw==
X-Gm-Message-State: APjAAAUP08b/3QMYK1+9M+XyOow92cLSFXpBFCLieeoWM9eZJdBJM7jV
 XxGQZiHym1QD7fvKy12qHfS28KsSJkIIMc+M50QsnIGRsbh1zi9eBngR5/KQfYt4E2R1Qv4XXau
 9S22ExNWQ5yaK+Jo=
X-Received: by 2002:a1c:16:: with SMTP id 22mr11780638wma.0.1574971577712;
 Thu, 28 Nov 2019 12:06:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2BJOP3QE8Sh41903YIBaee7wgj2r3OwRTPFwlc9B8w8WII5KoonJ3cstqA3cUxfON5E85bA==
X-Received: by 2002:a1c:16:: with SMTP id 22mr11780626wma.0.1574971577527;
 Thu, 28 Nov 2019 12:06:17 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id z15sm10886615wmi.12.2019.11.28.12.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 12:06:16 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Run tcg tests with tci on Travis
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20191128153525.2646-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cdc19981-6440-403e-a668-67d1f71fc12f@redhat.com>
Date: Thu, 28 Nov 2019 21:06:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128153525.2646-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: 0aW-LHWLNnScH6VQryMaCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 4:35 PM, Thomas Huth wrote:
> It's now possible to run some TCG-based tests with our Tiny Code
> Generator Interpreter (TCI), too. These two patches enable the
> testing on Travis.
>=20
> Alex Benn=C3=A9e (1):
>    configure: allow disable of cross compilation containers
>=20
> Thomas Huth (1):
>    travis.yml: Run tcg tests with tci
>=20
>   .travis.yml            | 7 ++++---
>   configure              | 8 +++++++-
>   tests/tcg/configure.sh | 6 ++++--
>   3 files changed, 15 insertions(+), 6 deletions(-)

Good idea to add/use '--disable-containers'.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


