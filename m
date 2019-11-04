Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F80FCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F6F2080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F6F2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhOQ-000623-V1
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRhLi-0004FL-FZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRhLh-00068u-6T
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:45:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRhLg-00065Y-Vy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:45:09 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02CFDC04FF80
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:45:08 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k10so10795011wrl.22
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DD01XaN1ab7JExxD2E3NBo6wP4sfSZej9WUh5hJeDMg=;
 b=DjaTTJFNo9H43XrbEeEIzUeeFkXn34C+IsIcO3THX6GuncI7Wj7PEVbnt5YM6zT9DO
 fvBBeTXlEs/axRNEtXyW2ngyq2ggpFBU/3vNDAORieUYe/GjL09xMka+kvs12y+zkn5N
 hynVugxU+CiEeitM96/ThOl+ddyBHquqv0EBTosSJOMIC/pQsFYAGbAGJkKreY+7Nq1H
 zB88NFrHkVT0/RMpzN+Nn7QM9xsv/BaBy/rSg8M2KUckLFwIGThqr+ubbcndd6a3LYZ2
 Cna4E+6qH1Ggpa5rcbd9sLS2+QjvLTUp6l3I0SE0jDXBaZekDhJLQW9SKYP5rBK2Tinj
 aN7Q==
X-Gm-Message-State: APjAAAUXBKrNBrjEej2kE3AEK/FQCt6L0Cb1CYy2p8Xxcjy5E6b3U5f6
 YwCLfgA0PWXcnycT4z2+00Wb7M6NkN1DITZ11d5fdPUwT3pKfPpra/6/1iqN9biYlB5to6Zyrls
 DtbVw885auy7jCF4=
X-Received: by 2002:a1c:6146:: with SMTP id v67mr503075wmb.102.1572893105974; 
 Mon, 04 Nov 2019 10:45:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqyw+z0VZ9eMSWjCZo+kb3ePVCFzabhlkENSFLCJJXtTi7vbbRvZCpeL/ItK0K36Eqp5uaYHcw==
X-Received: by 2002:a1c:6146:: with SMTP id v67mr503062wmb.102.1572893105824; 
 Mon, 04 Nov 2019 10:45:05 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id j66sm12799312wma.19.2019.11.04.10.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:45:05 -0800 (PST)
Subject: Re: [PATCH v1 4/6] tests/vm: update netbsd to version 8.1
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1001ac5f-509b-99d1-ccf0-3a3a3adb43a1@redhat.com>
Date: Mon, 4 Nov 2019 19:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104173654.30125-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 6:36 PM, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Message-Id: <20191031085306.28888-5-kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/netbsd | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
> index d1bccccfd01..33779402dd1 100755
> --- a/tests/vm/netbsd
> +++ b/tests/vm/netbsd
> @@ -22,7 +22,7 @@ class NetBSDVM(basevm.BaseVM):
>       name =3D "netbsd"
>       arch =3D "x86_64"
>  =20
> -    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetB=
SD-8.0-amd64.iso"
> +    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.1/images/NetB=
SD-8.1-amd64.iso"
>       size =3D "20G"
>       pkgs =3D [
>           # tools
>=20

