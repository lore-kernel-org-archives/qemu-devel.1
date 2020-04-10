Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685E0C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2302078E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 11:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+0QFERO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2302078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMrQq-00060t-Cx
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMrKN-00048Z-GU
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMrKL-0002yy-8F
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:56:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMrKL-0002xk-52
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 06:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586516159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOLA7AqaqpADD0ZR9/oqBIrBUf1FjNrKODwO5g6ohmU=;
 b=i+0QFEROsJilopX32V2NyVS1MunKMKbNW4AfNI5GfIDHYRRX9qSVuiqSljkuZDwvWznXCt
 p2gTkUEC6a/GlekmT8Cpe5siohKO/zPTfiY91bEzBQhia21Sh9bXegkNiV/c7lwABRGTmi
 y4nsnW1t+LrYcqgdZEKzE1DTbZdy04Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-ehoVO-bXNjOhG-0ZSIcV1Q-1; Fri, 10 Apr 2020 06:55:56 -0400
X-MC-Unique: ehoVO-bXNjOhG-0ZSIcV1Q-1
Received: by mail-ed1-f72.google.com with SMTP id f11so1828142edc.4
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 03:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+Qy0+sxx9vY8LwqhMfzG/MM9udzfMVKhxBEV71lHBa8=;
 b=OpCkYfLgsMP86h18JYicJk6FR3Q7q0RaFduNg1Z37plE0Aq74tmbz6nwQ/wWMA+ebu
 jV4JV6AnKe/Oeh/NwCl9/hklAwKWddi6F8/dYfO9+QVkxEV8DhqYJwKZargFlyFBbrp/
 sRAEVtPEi5nYPWMZUJU+JUIVuhpmVd4xtHGS05davFWh0q4urHVHVk9nVX8yvaIxPblG
 riEGQ9afPHjGn4ej+3uAWHgcFBthhfkSlIXRtj/ELlFztgUgceKkEbRZKGMc9gOAboE0
 8qeGpAyqM47XydgZKQRtklqV7rryk+5SLzYmawPGQui8wNS8G6F3gnyJckx9mwL2QB3Y
 RuAA==
X-Gm-Message-State: AGi0PuYD51rtO+NZRcI44RBXkzgJFVkpK2XUT+xBj5UapPoIu70JiB8H
 vQThV0YQ/wqbgB7CkGawhxHuA3kZP8iJZ33ZhHS/LgQdOaH4OInWX/vBmHRJd+LAZYCkw6Hs4Wc
 TzUP/ZtRHuBgJNQk=
X-Received: by 2002:a17:907:270c:: with SMTP id
 w12mr3373498ejk.258.1586516154840; 
 Fri, 10 Apr 2020 03:55:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIbvYsXf+Sj3ctP1EpcO3kqssWOcQsBcbeAmJ8KeeO+BuBrgtm+86EyXYH7jwbpxIpbnCLUdQ==
X-Received: by 2002:a17:907:270c:: with SMTP id
 w12mr3373485ejk.258.1586516154564; 
 Fri, 10 Apr 2020 03:55:54 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id ar26sm92759ejc.52.2020.04.10.03.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 03:55:54 -0700 (PDT)
Subject: Re: [PATCH v1 07/11] configure: disable PIE for Windows builds
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <427d4303-f69b-bbf8-7b2d-12805c61f816@redhat.com>
Date: Fri, 10 Apr 2020 12:55:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-8-alex.bennee@linaro.org>
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
Cc: Bug 1871798 <1871798@bugs.launchpad.net>,
 James Le Cuirot <chewi@aura-online.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 11:15 PM, Alex Benn=C3=A9e wrote:
> It seems on some compilers the test can pass but still give you
> broken binaries.
>=20
> [AJB untested - please could windows users test]
>=20
> Fixes: d2cd29e30736
> Fixes: https://bugs.launchpad.net/qemu/+bug/1871798
> Cc: Bug 1871798 <1871798@bugs.launchpad.net>
> Cc: James Le Cuirot <chewi@aura-online.co.uk>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   configure | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/configure b/configure
> index a207cce82bc..e9c5f630c14 100755
> --- a/configure
> +++ b/configure
> @@ -807,6 +807,7 @@ MINGW32*)
>       audio_drv_list=3D""
>     fi
>     supported_os=3D"yes"
> +  pie=3D"no"
>   ;;
>   GNU/kFreeBSD)
>     bsd=3D"yes"
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


