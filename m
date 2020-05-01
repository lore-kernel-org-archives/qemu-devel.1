Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88601C47254
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553DB206F0
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 12:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxeO6QMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553DB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUUlL-0000HR-ES
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 08:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUjG-0007ee-2a
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jUUi2-0007I7-Ar
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:25:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46702
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jUUi1-0007DF-MU
 for qemu-devel@nongnu.org; Fri, 01 May 2020 08:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588335840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVaXtgWvx1lIEcsCrlFMMqcEfe985d0uRPj6L7aruCk=;
 b=TxeO6QMrI3DXEjiYnMQzzPjGxfFvFuIqUG0IOQJ/TlJD6yI+g6D4VOPmlrb0t1hyZ6OJm3
 EUCdXt3sykNS/iTO8Q39tBxrzVgOdxbt2DP8QKdxsmChbF0XqSVzl5Glx9WGGM8493NKjw
 8RbZwL0aiMOoPK5qdavtM9568ZoEmjM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-OWCEHye8OYe_uDbYIPS5qg-1; Fri, 01 May 2020 08:23:58 -0400
X-MC-Unique: OWCEHye8OYe_uDbYIPS5qg-1
Received: by mail-wm1-f72.google.com with SMTP id o26so2018444wmh.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 05:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lqs+nVMq8ezf29gLDjw6oZ4ScVO5+GisaFSGRpFneiI=;
 b=T8TAUv+gXn1SjVVMHglGOQvWpUNbKO4VBEdyal66BHMcldLpvQpx+BdRFBQSG6bv3t
 iLR87qX9gCauOYZ7X/vNoLqo3oWVBW6ZzdTURBIxiLrgNjmsS0/NZ4N42ns9BSoPO0su
 QcD3xOMK/Bm+Zal0yyZ6pivJ5ynacwyjmwO4haM/nyqo2TutWB25NacjOqN6XRkEEWWA
 i09nDbdvE9fosfb6k8BtKmpGY4G1J3LJkBY29P5Eun0rlR+mdnSUny2EGa+0qu4Y1rQ8
 318kryIsKL1Uxa+7sORiO7M77ULiGF3qu9Fzb0vwY8L7Qfb97Mkb/KsTRE4uCaoaOTVm
 NCUw==
X-Gm-Message-State: AGi0PuYSxC4WmJgr//4k/mLMn40JH+a9lmD/JpQE2FzM/iuh1z/xwV87
 YgNw+17sDv8jolFWtF5wgnimcxa73guGQS3wRU70WcGANkERNKj1dUaPRAWw6w9tao7Ayd84fUF
 leCKrtj3QB/vLnoU=
X-Received: by 2002:a1c:e1c1:: with SMTP id y184mr3878340wmg.143.1588335837792; 
 Fri, 01 May 2020 05:23:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbaIRQWPbvyW2mwbOvvILoFR+0HT2//hanKVqQEcM1LG8peTol8AV3gQTlIL3rZ3xIFxWd/Q==
X-Received: by 2002:a1c:e1c1:: with SMTP id y184mr3878328wmg.143.1588335837567; 
 Fri, 01 May 2020 05:23:57 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id p190sm3673446wmp.38.2020.05.01.05.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2020 05:23:57 -0700 (PDT)
Subject: Re: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC
 check-tcg
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad941829-a2f3-6ef3-6251-0681b36be24a@redhat.com>
Date: Fri, 1 May 2020 14:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200501111505.4225-5-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 03:09:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/1/20 1:15 PM, Alex Benn=C3=A9e wrote:
> This seems to be timing out quite often and occasionally running out
> of disk space. Relegate it to light duties.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 49267b73b3..fe708792ca 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -458,7 +458,7 @@ jobs:
>             - genisoimage
>         env:
>           - TEST_CMD=3D"make check check-tcg V=3D1"
> -        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS},ppc64le-linux-user"
> +        - CONFIG=3D"--disable-containers --target-list=3Dppc64-softmmu,p=
pc64le-linux-user"

Cc'ing David, since I'm not sure about this one... Maybe split as we did=20
with other jobs?

>  =20
>       - name: "[s390x] GCC check-tcg"
>         arch: s390x
>=20


