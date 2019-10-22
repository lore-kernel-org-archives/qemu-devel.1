Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7554CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:51:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C0D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MegfBaR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C0D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51845 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpsn-0001fc-MC
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMprj-0008SX-QV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMpri-0005Kr-Np
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:50:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMpri-0005KQ-JP
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571734205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m83BXJXtRumeztxB1T8OWFTzQeDHyCuUriLWc5iQYJQ=;
 b=MegfBaR6AoNs1WEXqyDKB4/KFSs0vvSsZ/tqh6w6bum+ouZuZ2fWvnu17WFhntbx8Oqi8E
 xZyscMvARv5O9lF8qwKYBvxRuinnsZEe0bK8YIfOtcgzsfMqXX4PsryWflRRfxpTUiRrAU
 /qBSiDL1DreP+G3wjpD4yzYwLsh6NeI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-K4-Je6ZaMRafk3nsDZaZ_g-1; Tue, 22 Oct 2019 04:50:02 -0400
Received: by mail-wm1-f71.google.com with SMTP id g13so167946wme.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 01:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ei81U+a7i0jHxzrWjOPIbP4KsEGz9Gogem/Q9h4pGMY=;
 b=PD9PVfipu0myAF+sC1tOgRSbkE6UcqmaryiQ9nPduEVITM7wP8nWKWRlTPVvko2wqp
 yNa057xKOzhK/QvuibDV1lnqM3/IYbq0BZXDS6BtnHzht57tW7jtuEGX4yzOAMRaKspd
 oSmBN/aIo6VG0NJLFzqPkFZanGgB58t8nH7YLLGMZIwYHTiu/SQbUtg/uAgK9fwEzabl
 NgdQ3uzza86bB3L6y95/0cSYWcwTHgfk+WZioPu8hqRyn2tv+uxC6EBnmNsthaWjM6W5
 DTqrcTKLsRwEA4rsiGEVa0GB6Xf/QJXzUihPC1ofY/6lZ4A+7CCN7C1f/0Yq/PPkTIsy
 bU+A==
X-Gm-Message-State: APjAAAWZkBV8iW6ycuzUy5/oOkZ1eAR/W03Nz/Z3Gy0nVleYmDzaYT96
 62ca9OF2nwcEb9HjSHlEOGveteJketraf5hK5Bf0j39kBnqbPlvmovpuhj+BYKTNsTW82UOOHdY
 espeSAD/oZd87SZQ=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr1859957wmi.43.1571734201133;
 Tue, 22 Oct 2019 01:50:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+NDX95Qc/lqBp7NuR+Fz6v1bnFbNe54mS+kJw5+ma1haIbwWFRF5glhigKQnDOgDvDQTVgw==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr1859933wmi.43.1571734200798;
 Tue, 22 Oct 2019 01:50:00 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id 36sm21063042wrp.30.2019.10.22.01.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 01:50:00 -0700 (PDT)
Subject: Re: [GIT PULL for qemu-pseries] pseries: Update SLOF firmware image
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022040945.35730-1-aik@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c3c1b36-a355-9ebb-9c68-8ae1af268fff@redhat.com>
Date: Tue, 22 Oct 2019 10:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191022040945.35730-1-aik@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: K4-Je6ZaMRafk3nsDZaZ_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alekey,

On 10/22/19 6:09 AM, Alexey Kardashevskiy wrote:
> The following changes since commit 7cff77c24d8f5e558cef3538a44044d66aa225=
a5:
>=20
>    spapr: Move SpaprIrq::nr_xirqs to SpaprMachineClass (2019-10-16 12:01:=
41 +1100)
>=20
> are available in the Git repository at:
>=20
>    git@github.com:aik/qemu.git tags/qemu-slof-20191022
>=20
> for you to fetch changes up to 8e59d05f71ae783e12a8eb7eb582e0a86ba3d6dc:
>=20
>    pseries: Update SLOF firmware image (2019-10-22 15:05:36 +1100)
>=20
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>        pseries: Update SLOF firmware image
>=20
>   pc-bios/README   |   2 +-
>   pc-bios/slof.bin | Bin 930640 -> 928552 bytes
>   roms/SLOF        |   2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)

Looking at commit 8e59d05f71ae which update the SLOF submodule,
in your future updates can you include the git shortlog in the
commit description?

Simply:

   $ git shortlog qemu-slof-20190911..qemu-slof-20191022
   Alexey Kardashevskiy (3):
         pci: Align PCI node names with QEMU
         libusb: Fix compiler warnings with gcc9
         version: update to 20191022

   Thomas Huth (1):
         ipv6: Fix gcc9 warnings

Thanks,

Phil.


