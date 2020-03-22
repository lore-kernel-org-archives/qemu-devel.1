Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB239C54EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A83920722
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 10:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZbyxcRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A83920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFy2c-0006SY-NZ
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 06:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFy1u-0005wU-KN
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFy1s-0002hH-VY
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:40:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57152)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFy1s-0002gb-Qi
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 06:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584873627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=duMpB8DleZnOHhKxPfAWBpe4PQunBzcKKHIr85PPwAs=;
 b=SZbyxcRqi278cyCi4MtnmL6A/ro9hVlNPHUpV6w/1UFJh+Dkil8ttbgwIf0Kx/vmrrV9l8
 a52neCkXBEcYKcG2sX+ZkMc7p3yCdXxFfaVUv5WJFFi4My+iezw+tFONMAFDEnKSmm3eIU
 NE1TN85cA5D2s1nCQNWIYZz0j3M2/A4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-VMqc41ppNZ-IQUFHvTIDFg-1; Sun, 22 Mar 2020 06:40:25 -0400
X-MC-Unique: VMqc41ppNZ-IQUFHvTIDFg-1
Received: by mail-ed1-f69.google.com with SMTP id dn10so9005871edb.6
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 03:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BGclFkV+PokZBLZOv1Tse73YS9XU5dXE/NWmqjm+7Gw=;
 b=RZM/mx2auChO+bObqFCBlq0gXSizDHu08lqOmLV+g9UENYTx1XANg+LuJCUWE5pVkU
 2cPsFH25C4tuz37OUss9R9g9phcBHqo9uV9KmCjVhaZdE6OXDs9cNv7xJIlOXwOAQ0FR
 10IYlg6Rc0TzQKFN/l3Xo/tZpgMiO6DGM3k/yQMiG5RWAehqoA5yABp+3GaOqZyYJc7Y
 F2q5dlvVHVFxfsERlTH2qbCPLTZ35qoKYYtT3GB8QprfjNCe20Pjw8EI7Xxnh+kwAdlV
 UFM6wzl0spIrsnmBP5NWT7Nr9XsPpm+k2HNTwa4q8VpbC0F7uHkfzTbCEG+9WUtafLds
 Fn5Q==
X-Gm-Message-State: ANhLgQ2zRTB5T9whYN99YPnYbZ/U5SpgHeYLxxKFa+JBTw0z4X+hyOY8
 08M9cALiFmN2aRUthRpDYgpydTIa2e6tB+xQbSVh6vuBOvp85Ep7Y7HfCRYNi8TaBqtBvss5xaz
 YEcmXYv0z1bSMgy0=
X-Received: by 2002:aa7:db57:: with SMTP id n23mr1001780edt.211.1584873624591; 
 Sun, 22 Mar 2020 03:40:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtTBt7otmPUgvaz2daabVUqgs4Vk/bFqC3iNzk+pPXkNHEEYiGQLynNxkiZsBnFchcNzcYs4w==
X-Received: by 2002:aa7:db57:: with SMTP id n23mr1001776edt.211.1584873624408; 
 Sun, 22 Mar 2020 03:40:24 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id x6sm676797ejw.19.2020.03.22.03.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Mar 2020 03:40:23 -0700 (PDT)
Subject: Re: [PATCH 0/3] target/arm: Coverity tweaks
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200320160622.8040-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6607fd2a-1409-3536-199d-b6b7bf5a8319@redhat.com>
Date: Sun, 22 Mar 2020 11:40:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320160622.8040-1-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/20/20 5:06 PM, Richard Henderson wrote:
> Only the first of these appears to be a real bug.
> The other two are adjustments to help satisfy Coverity.
>=20
>=20
> r~
>=20
>=20
> Richard Henderson (3):
>    target/arm: Rearrange disabled check for watchpoints
>    target/arm: Assert immh !=3D 0 in disas_simd_shift_imm
>    target/arm: Move computation of index in handle_simd_dupe
>=20
>   target/arm/helper.c        | 11 ++++++-----
>   target/arm/translate-a64.c |  6 +++++-
>   2 files changed, 11 insertions(+), 6 deletions(-)
>=20

Series:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


