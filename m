Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E8EC352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38A521569
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdCmrMnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38A521569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20rF-0004Av-1B
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j20qQ-0003ca-SI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j20qP-0005VE-NF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:50:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j20qP-0005V4-KG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581547857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2f4SMneFyOP4EZpuhnCgUYEzJ3aqLlkPMYPApKNwY2E=;
 b=BdCmrMnMYS7J5D6vf4GihJJ+b8Ks6bZmknUZ2zdVYHSWFvFHCn1BkiHTl8lyY8j645Ab4g
 t3PL2dho8Rq0I1eFrB/DYspjz5wRDe08EtrX/0/Wmw42ccgZn13ov6gXayiFDnOhZGDUW9
 LShJWdJ/r72f4/IDnCtid/5sxMYQYlI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-ZlfADQnrMzuXCdZMNSnTGQ-1; Wed, 12 Feb 2020 17:50:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so1447151wrn.11
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 14:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jcp2cuRqv/gBSHR2CBLD5Q8MTpSBi69bWNS+nJmJLvE=;
 b=DrfksXJqQQXhOWEIDHGdmf0XwLN7jn2mzzDcEXO+qSSY1SzHMQiiagxIWyXPVxo0HV
 7joD8qbPtYCN/XZcUaqt1tZ5EPCPUEpLaNJIkN9Z5WdsTlmOqxcbi4zD5I/KiR4NnmFK
 mwUHCjacd4xhAs4oeRwY69OO/OCq+y4BbujsxyzZvRPYANBKB2queGKihj7rwWFVW/Tz
 ayHys2h5PQKezwAY927XWG76yObXqZuw99Um0ge0yoJNRRj2DawwNb7UcOUqhWC2mgXZ
 Fq1hp2VpGrzkQbclen+bvrCJAKp9FBn+KfN55dSaLUEyOhiBYrbiHxdcgyEQKwOjPjvf
 LbwQ==
X-Gm-Message-State: APjAAAWFmLKIYmC15Dahs0g3C2+an9Ro0Bf10NeRc9izwOpaVu6LGQb1
 DryK+7TtukgIIs/Xx+PhG4YWYDiD9Gd5xp0z+Wf0mIM8rujqh44J65Nvb7kd4ypz7+ebmU6x9+W
 PuWJurWL76821ZJw=
X-Received: by 2002:a05:600c:10d2:: with SMTP id
 l18mr1353903wmd.122.1581547850892; 
 Wed, 12 Feb 2020 14:50:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwqRW8m84nNnaZB/IOAjJfsQwuNUy+WU3iBhQlsc4k7Ql7dMDG3c5Xj6agxK4iVJHVIMxpAuQ==
X-Received: by 2002:a05:600c:10d2:: with SMTP id
 l18mr1353891wmd.122.1581547850732; 
 Wed, 12 Feb 2020 14:50:50 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id p5sm272720wrt.79.2020.02.12.14.50.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 14:50:50 -0800 (PST)
Subject: Re: [PATCH] target/ppc/cpu.h: Remove duplicate includes
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <20200212223207.5A37574637F@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9aeada5e-9df3-310e-ede7-a6935d6285c4@redhat.com>
Date: Wed, 12 Feb 2020 23:50:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212223207.5A37574637F@zero.eik.bme.hu>
Content-Language: en-US
X-MC-Unique: ZlfADQnrMzuXCdZMNSnTGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 11:26 PM, BALATON Zoltan wrote:
> Commit 74433bf083b added some includes but added them twice. Since
> these are guarded against multiple inclusion including them once is
> enough.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   target/ppc/cpu.h | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 3a1eb76004..07dd2b4da7 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -23,8 +23,6 @@
>   #include "qemu/int128.h"
>   #include "exec/cpu-defs.h"
>   #include "cpu-qom.h"
> -#include "exec/cpu-defs.h"
> -#include "cpu-qom.h"
>  =20
>   /* #define PPC_EMULATE_32BITS_HYPV */

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


