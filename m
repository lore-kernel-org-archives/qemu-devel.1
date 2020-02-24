Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A8AC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4ED92080D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 12:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF+tyapC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4ED92080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Cje-0001fm-1I
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 07:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6Cii-00019E-M5
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:20:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6Cih-0001Mx-GX
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:20:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6Cih-0001KT-Ci
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 07:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582546816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Zw+77kVjg/GJ5yCd1WelO9eU1jFFLcRgppvePUoyzY=;
 b=GF+tyapC/h79Y+twaxBVd3+qkoQGOyD2omaAUc0Ay6Rh9e9Qg+YTucyBRdA1tXyScZDAdF
 LAo80CocYBrWCmUmfc9ZCFzfBRgMkAMnneY4ofrwWb8PJuQoMcsw1PlEkxNa/om3cPNkd8
 rJ+6cgy/x9gwVqdMLjayL6raRKz+cOM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-qYvk9LPoNFadnSTQ4Opuhw-1; Mon, 24 Feb 2020 07:20:14 -0500
X-MC-Unique: qYvk9LPoNFadnSTQ4Opuhw-1
Received: by mail-wm1-f70.google.com with SMTP id f207so2311233wme.6
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 04:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qcqQnB6M2JpuGawRtr71mnRDIRohdx4PiCs696xf76Y=;
 b=S5+fd9ImXLkskNjwlMV1U2kerIAphBhtixeZST4jq41nDGBe8eRbeYyQU6GTmaPCmV
 Jp5gM8R3vdYIaqSn4GT9Bc8M6l8ufTGwokL9Fw/LM81dvRxqI2hmsGYti2OmmZ8YSELQ
 U8uFQdEupjxROVwSkjxwXiYqJ8CadZM/2FA5T9p9Qii0nx1ulGNYISOOe5bfxaQuuuF8
 ubbRYuPT02Rs3rtpTM7wbvUOfR2V4Cw57X49p+2HZPtd3HLq5x06AZQh7s0+8bc8WCfq
 0qXM8wHsSAoW27L65ZdjcBPfIBDwiMt9jBpIk0I6oouY0j0a8r9xaiGcGaRF5oaobKz2
 hnEg==
X-Gm-Message-State: APjAAAVYDsocKiIphruagLr8LudLRWkB+FsWGAY6szi2nbBPi+iygSC3
 fwi/45Dcju6XFdPnMhMeZkYKhajo3u+C7uiuBxPKkSmOiQYEtqtqMqRb8gOG2wNclYl+/ymBG4B
 uXM9jGsH/3esy1CQ=
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr23424630wmc.168.1582546813222; 
 Mon, 24 Feb 2020 04:20:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzrB9yZ8ZLR36vrFetQnxR3XG7qpfhDhIenFGiJmQ4yHtngk6yPvAuRbD2E46fUyK+iw4vTfA==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr23424613wmc.168.1582546812981; 
 Mon, 24 Feb 2020 04:20:12 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id h2sm18581768wrt.45.2020.02.24.04.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 04:20:12 -0800 (PST)
Subject: Re: [PATCH 0/3] tests/docker: Fix linking with VirGL
To: qemu-devel@nongnu.org
References: <20200212202709.12665-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b511e74-b965-dc42-be6d-fa70d752cf29@redhat.com>
Date: Mon, 24 Feb 2020 13:20:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212202709.12665-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Dave Airlie <airlied@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 9:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> We link with VirGL in our debian-amd64 (cross-host) docker image.
>=20
> This series includes few fixes to keep testing it.

ping?

>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>    tests/docker: Update VirGL git repository URL
>    tests/docker: Remove obsolete VirGL --with-glx configure option
>    tests/docker: Update VirGL to v0.8.0
>=20
>   tests/docker/dockerfiles/debian-amd64.docker | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20


