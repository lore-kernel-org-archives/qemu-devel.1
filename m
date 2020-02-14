Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133DAC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F8F2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X20By/Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F8F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2g5p-0006y2-16
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2g3r-0004bm-2D
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:51:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2g3q-0008Qa-1a
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:51:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2g3p-0008QD-TT
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581706293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vr7kJPFLQJFvgKoTUh9FNIUw6MI1zaccR0EhfQ+8pgs=;
 b=X20By/OrFGmn3C6tIDg3n+zkGOppWsFgGugfK/EXF9nHdHE21VVecE56810GVeI8s9kuNA
 lboOd1z52YZWEml2E72tOo3oMO9J4q1RgAcbUOIJ4d32u9BG3Wb/54Rjtn3FBf2M0ElmQW
 PvlkZ/ft2t3jhlhDTQ8tTzNdGpcoR2A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-mGSSmenXMSeWHgwcaozRpg-1; Fri, 14 Feb 2020 13:51:29 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so4519054wrm.16
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3+XCdfaJsMWyobdSaCrYfrPeY49Gz7yZrU38lMGxMKM=;
 b=fennfG892ozt38JoPIXc4nhI33JQp4lTiyAEF1Zmu3jy21cQKlb3+Q90IIMRQ7Vxne
 nEc5P1YT6bh9S8eoLjbXEdCMQEMJ1BDWu+YWRO2ljAECj3RgyTBvhxLy+JKG24DR9FQj
 /tPl/hr4jEFScINRtni+u5ZaVZjt9sppriehk8fdJbC3Pa7Kvde2WFOq+WrtNfoD3kM1
 1/Jt1eio6eGqCUbXnkNd/tjGc1lH7ybcpS836KyeP+aCJu/ztV/0SLVeqXf+/+e6/VxI
 Bg4KO6oIvu+HsM470zvSFQFCJ7CEi0ZpYd5W7kOf0dX7oZfwmGCSB5/VfMbSrh+NyQAO
 gv7A==
X-Gm-Message-State: APjAAAWiKKXFao2DQ/UzQQ33nwEb01SS1rvbLfisN/BbBr3JFG2tnrJU
 if4iuVd1otev5I3roSv2Wrhg06JJs4d71OLv2dUNWUDA9y37rK+/XmdtjUGTJmZrWcx9GRDCdLp
 jLodmr2amWuhx0UI=
X-Received: by 2002:a5d:4085:: with SMTP id o5mr5270474wrp.321.1581706288057; 
 Fri, 14 Feb 2020 10:51:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhzQQz009xB2A5nqVxv+IqfQPVwsOEW2TdwbsCGv7g8UU3dImBYKL8mPz0jOjU/rS/7VU05Q==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr5270462wrp.321.1581706287880; 
 Fri, 14 Feb 2020 10:51:27 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id k10sm8316650wrd.68.2020.02.14.10.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 10:51:27 -0800 (PST)
Subject: Re: [PATCH 06/19] target/arm: Rename isar_feature_aa32_fpdp_v2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200214181547.21408-1-richard.henderson@linaro.org>
 <20200214181547.21408-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <273cdc34-9a55-1866-c8ec-b2319b4f99cb@redhat.com>
Date: Fri, 14 Feb 2020 19:51:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214181547.21408-7-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: mGSSmenXMSeWHgwcaozRpg-1
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 7:15 PM, Richard Henderson wrote:
> The old name, isar_feature_aa32_fpdp, does not reflect
> that the test includes VFPv2.  We will introduce another
> feature tests for VFPv3.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h               |  4 ++--
>   target/arm/translate-vfp.inc.c | 40 +++++++++++++++++-----------------
>   2 files changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


