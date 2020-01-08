Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA2C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E747206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 09:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frLqJ5Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E747206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip7gO-00065C-F0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 04:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ip7fY-0005Yt-VP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ip7fY-0002wK-1f
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:30:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ip7fX-0002vw-Us
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 04:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578475827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLKEgyFBsAupgqhddCzYA41ELmhlsR1OfIDWzrOg7R0=;
 b=frLqJ5DgAzllcpa/TNaVX5SxfijBdpf3cSoExcrGwhpQ44+ERHZhImHupNj7eMZrRxxNUe
 HorgpcpiqY1ZTCXw4911iv/AZQLIujxgQV2ePFE7E+523iM+O2CrkvGsX8XQSkpUDpZakk
 MSFgR9FsI1itho0Ew8ISOnmehqrB7+s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-uiUlvD9CNHyfnW0IZvu5rA-1; Wed, 08 Jan 2020 04:30:24 -0500
Received: by mail-wm1-f69.google.com with SMTP id l11so3827414wmi.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 01:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iXB/WeSBODqxRDseHZbZ/z0xySYFgKTcdnWTvmOR7pc=;
 b=ghyqRthx+lcRWaCba1GKIfuZVX6p6fBJw2/YvEzAq8I2kNGBIXtPCVeVrNV+lAmh8W
 EERRB89cjMvv3UhENOUC0ZFTwzHd3zcc4vaR+Lcs0LRuJGXgDaqZMoCwyUbZMqedMzJN
 LrqTP24cGYJ0f7YInIQqsJ+uTRXhMgN90Fm7YIOGw1AEeRVTuuPmX+W4hnmKNSG4ALp3
 1lCgvDfwoHMmremrjsZe0lypwIhAlSuOromcWb95VtX9oVFux2rUljvEJiOt9TE1/Zq0
 OEyEPNkF/v/MSNCS+r4XhleQAzijW+5Xk+bs70s75cyZDmtsRQsNgqoC1Js25Xv73sYz
 HYSg==
X-Gm-Message-State: APjAAAWmXDgCdpNySubYuXpHc0iy8DEfJZgBXDZMA0Sjn1fV34vmRYk8
 +eR2Ri/NnURIeMYahh7I4idoEn2THCOTjJ9VoEDGu4YTnPc44a0Ujm0v9pU3e0FsFlE/6IOu9S+
 mwwqNYdrlMeUXJjo=
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr3385618wrn.152.1578475822894; 
 Wed, 08 Jan 2020 01:30:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxohjf1CO5q/ZZ3+U6ZmCD///4TTjmTVvSLytWUQO8iQs8H4G3i3o8VIT/b3CB8qoAow95L7g==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr3385592wrn.152.1578475822609; 
 Wed, 08 Jan 2020 01:30:22 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id c4sm3077658wml.7.2020.01.08.01.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 01:30:22 -0800 (PST)
Subject: Re: [PATCH 0/2] ppc/pnv: PNOR cleanups
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200108090348.21224-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f598722f-e7f0-417d-938b-da940a225f45@redhat.com>
Date: Wed, 8 Jan 2020 10:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108090348.21224-1-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: uiUlvD9CNHyfnW0IZvu5rA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 10:03 AM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> Here are small cleanups of the PnvPNOR model.
>=20
> Thanks,
>=20
> C.
>=20
> C=C3=A9dric Le Goater (2):
>    ppc/pnv: use QEMU unit definition MiB
>    ppc/pnv: improve error logging when a PNOR update fails
>=20
>   hw/ppc/pnv_pnor.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Thanks for the respin.

Series:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


