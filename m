Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A3DC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 785202073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWdlwsSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785202073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH846-0004mW-Kk
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jH83S-0004BW-Ki
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jH83Q-0003xY-Fh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:34:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jH83Q-0003ww-Bg
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585150491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1i6+D3Dr5i6z44/aRPsi3fZSj6fGureJTN6PjRDe1Y=;
 b=ZWdlwsSe5tf5dvnkgBBf1QahtCFT0+oPoAtVo3nlafN6eMuO47zV007ZTG8wCuUhgWsdLn
 wBZZfVL/+QkQFkKXiEVeen0S1V3EjPT3YwPvnrFVu8Llc5fRniH200Hf1oYVFbl8N9fYmf
 Nas9knyC/BYJhekeZ1gNQhluanQpJ44=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-Xao2xOGnPWij47vd5zNS8Q-1; Wed, 25 Mar 2020 11:34:41 -0400
X-MC-Unique: Xao2xOGnPWij47vd5zNS8Q-1
Received: by mail-ed1-f72.google.com with SMTP id w6so2437239edq.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 08:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EX0ntLGCErCyCay3zxjiiaHqG0CAH6HYfAYSB3mVsnU=;
 b=BFaPo9anfHH2aD7QemECFCzY12Lh9TjwLzyRkViJCHIkRMROI6S8+Z8nzxU6VcAdbd
 MJHWgKdAw+GpjscY4re4CvXt7rDXNqb7ZbdqZK2jUl5e03ybZyangb02XX03Ol/j7qNh
 DL1FF34l7dNBfitr13eY6GRgced3SEdM6K3Yu0FdRIptEZQLsOm0flVzSLQ5ceWyKYAv
 8bPK+flVCrj0GYo5GZOPY6LY1bJHMg8iCBtvhnl2+ny/5jKn4BETsmJXzXYdJiW3vmIS
 Qh/HhLN8c0056/8bwEFIiBxWRHTDED0OjhJzliNgjI+yVz7dum9qv0CJnA49igDfJZfj
 n3yQ==
X-Gm-Message-State: ANhLgQ1jjROHho9/4lPFnXqw76BoxUMPxaZe//UMRkS3tHRy+eqddoUO
 eWA88rTo0ONLSt6ni1MlxNMK9TyAMIM7Gbhl5p+dEhkW/taRwwRVZ0fmZ+p/D00Y4zNa5PGcxPS
 ZX8lxYza8gAoep+s=
X-Received: by 2002:a17:906:6d87:: with SMTP id
 h7mr3689054ejt.42.1585150479863; 
 Wed, 25 Mar 2020 08:34:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtEf4Qp0tpgvaJrizjkNI2qPxFUuCcw/2x1K9zf6cdGz/f5BhXaiHBx9VtbnW67Mtc2bETIuw==
X-Received: by 2002:a17:906:6d87:: with SMTP id
 h7mr3689030ejt.42.1585150479505; 
 Wed, 25 Mar 2020 08:34:39 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id c64sm1628066edd.66.2020.03.25.08.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 08:34:38 -0700 (PDT)
Subject: Re: Help
To: Chained Up <alia.mk345@gmail.com>, qemu-devel@nongnu.org
References: <CAEwvOcF7==uOdEJoQpNh1-wE44nJqWJLFP93yK0dHEUA38EXKQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf6c2c9b-d964-3756-f125-ad8350ed64c1@redhat.com>
Date: Wed, 25 Mar 2020 16:34:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAEwvOcF7==uOdEJoQpNh1-wE44nJqWJLFP93yK0dHEUA38EXKQ@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Chained,

On 3/24/20 11:13 AM, Chained Up wrote:
> Please can some explain what should i do here?

You might have sent your question to a wrong list (this list is about=20
QEMU: https://www.qemu.org/).

>  =C2=A0Prepare import-libraries using Borland's implib program.=C2=A0 The=
 ".lib"
>  =C2=A0 =C2=A0 files that it uses are a different format than the import =
libraries
>  =C2=A0 =C2=A0 distributed with GnuWin2.=C2=A0 From Lynx's source directo=
ry run bcblibs
>=20
> Environment:
>  =C2=A0 =C2=A0 At this point, the bin-directory for the compiler and for =
the GnuWin32
>  =C2=A0 =C2=A0 libraries should be in your path.
>=20
> Building:
>  =C2=A0 =C2=A0 From Lynx's source directory
> cd src\chrtrans
> makew32 clean
> makew32
> cd ..\..
> makew32 clean
> makew32


