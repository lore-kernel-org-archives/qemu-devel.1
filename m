Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA1C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB27F20722
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv0AAlpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB27F20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLRJ-0005oa-3M
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFLQi-0005Nd-0X
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFLQg-0002I7-L8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:27:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29457)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFLQg-0002Hk-Ht
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584725250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iA9wWpwqjguT79CT0oLuDJmnMeRE7rA4A1Lh4+miDG8=;
 b=Sv0AAlpLhMWzt0lpmBncm7D8EbAPlLwoUHbsGS6lZsTEbWv4MgeR5Q9acpv/hvQaou3kSh
 0zJ+1pHPHFzPwTHIUxZ5K/y/74VymbnTRoL95jVIu5L+9/J1vz+0jCF6uoDfZf7Qy9eY3v
 IG68YLsh4a/1aK5bgrEfdlQkhyejVYM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-uC3hEy07PzSqEKfWnCyHQA-1; Fri, 20 Mar 2020 13:27:13 -0400
X-MC-Unique: uC3hEy07PzSqEKfWnCyHQA-1
Received: by mail-ed1-f71.google.com with SMTP id dm17so5640482edb.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Gu68uW5ubwvFoVy73hFJG1067x9NVWuA7/1KvFBjQo=;
 b=YgHSA582rBmf5h/UF5eIuLv5idX6pKYaUMRhPVbBpogu1Qobh766mNxhjlcf+ORaW3
 WdKJOI+hVOq1bVsPRw+oYPxvI8Rma1EW+Rst3KZGUto6w+VDhwqjm1+D2UzPn2rd80dA
 XyOJPdAntiCMtHJ6tRhywpGmcDf/wH5uKTqP+jGMkS7JsrO0db8/oIIGb6tM+RQDWCfg
 sPZdXMuta9cTSx3WAZmTbDB5sbpi4CN+xOeqvzVYpwiTc2h6wi0ibMZ9kQOEg8AdeyVx
 7rWHLbqHaMR7GtDLEhwxRo9UpvIu75lTC60XUJcuMYlw4o0RL0Aj7dP9n9EHekCDt9sP
 qAYw==
X-Gm-Message-State: ANhLgQ1JtvSTYaXZUBa/KT4HmYRNNCYok0oDJxUpJP27P9MHABWrR2Ub
 mBfKK/e6jBJITEHK9ZAxG8cxehbDQAEaGXJIqIw0OIvswaZWrG8a3VIGK0Xt0YCoFJrk5tYcIpn
 QJ3jTAboncFmf7ro=
X-Received: by 2002:a17:906:c7d0:: with SMTP id
 dc16mr9017997ejb.63.1584725232221; 
 Fri, 20 Mar 2020 10:27:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvuJvinZjBo/bP4N4r43W6+V6J75LLtPsr8o3VQZ3qSPjFtbGWUTYkOgjaOM5Ipgh72tfEbfg==
X-Received: by 2002:a17:906:c7d0:: with SMTP id
 dc16mr9017986ejb.63.1584725231944; 
 Fri, 20 Mar 2020 10:27:11 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e26sm420845ejh.32.2020.03.20.10.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 10:27:11 -0700 (PDT)
Subject: Re: [PATCH] Update copyright date for user-facing copyright strings
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200316112006.19107-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9c52900b-5b90-6a0e-950a-0c39fdeaff81@redhat.com>
Date: Fri, 20 Mar 2020 18:27:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316112006.19107-1-peter.maydell@linaro.org>
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
Cc: John Arbuckle <programmingkidx@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 12:20 PM, Peter Maydell wrote:
> Update the copyright date to 2020 for the copyright strings which are
> user-facing and represent overall copyright info for all of QEMU.
>=20
> Reported-by: John Arbuckle <programmingkidx@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu-common.h | 2 +-
>   docs/conf.py          | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 082da59e852..d0142f29ac1 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -13,7 +13,7 @@
>   #define TFR(expr) do { if ((expr) !=3D -1) break; } while (errno =3D=3D=
 EINTR)
>  =20
>   /* Copyright string for -version arguments, About dialogs, etc */
> -#define QEMU_COPYRIGHT "Copyright (c) 2003-2019 " \
> +#define QEMU_COPYRIGHT "Copyright (c) 2003-2020 " \
>       "Fabrice Bellard and the QEMU Project developers"
>  =20
>   /* Bug reporting information for --help arguments, About dialogs, etc *=
/
> diff --git a/docs/conf.py b/docs/conf.py
> index 960043cb860..af55f506d5d 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -80,7 +80,7 @@ master_doc =3D 'index'
>  =20
>   # General information about the project.
>   project =3D u'QEMU'
> -copyright =3D u'2019, The QEMU Project Developers'
> +copyright =3D u'2020, The QEMU Project Developers'

Ah, more complete than=20
https://www.mail-archive.com/qemu-devel@nongnu.org/msg688687.html, thanks.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>   author =3D u'The QEMU Project Developers'
>  =20
>   # The version info for the project you're documenting, acts as replacem=
ent for
>=20


