Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195EEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E235420854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E235420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKP7Y-00029S-4S
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKOtR-0000xH-Nw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKOtP-00031D-Pc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:37:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKOtP-00030q-I1
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:37:47 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACA8F81129
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 15:37:46 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id q22so70095wmc.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 08:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mH6KA/H4LAwyhAxZ39o0zeNmf2TlfdN7p/hlqbvX1xw=;
 b=WkjXt4qw5+yqzn8Jg0XN/e4crEfo0Jb4MCUeAjxUSgBcUn85nVLfqCPM6izE/CmOn7
 KF6NxSQFrq36iZCRnIVl2vAHQvUxDlpNhIo6uhjCQQXCutRXBbOpR12UUhjUKIOFRCcT
 vv9iT4ycw+2EKq8YgnbmdHSn08mH+1TgenAy10RGk5Ncrn7r4C5VJVoCjzH4yvFwV2XI
 3AN7uFz8fGTmGk/+WQ9A9cUNvwxkB7kEqsLWfsKShMjiiCG0y1+cK34d+0t1/3JlDtaB
 iqEGqJ9Op+hb5EdzeMsXY14F0dPDnH0g2QqaILcN3bPEMMvQT5uASqqjPtMT0AN4igXD
 Vr8g==
X-Gm-Message-State: APjAAAUcLDqlvyCMWhIDO1eILMspmgavRaF+BSmipjmNVlGh3Mds1Jv/
 UbFtp2EmGGSunQN29TOMJS1zNzmZoiOHj1vq8g6bnnvb4h+2sCOl7WEgUlKC8ikwySRBLs4VV9l
 SvHeAbVN36G51eYM=
X-Received: by 2002:a1c:750d:: with SMTP id o13mr19437588wmc.140.1571153865114; 
 Tue, 15 Oct 2019 08:37:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuh7iBDUDNhrLlfN5VBAGVnK92F4NjKpXPnKzi5cVyepZkS/dEdJwMRZJgWAoezG+HwubaSQ==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr19437569wmc.140.1571153864803; 
 Tue, 15 Oct 2019 08:37:44 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t11sm6666036wmi.25.2019.10.15.08.37.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2019 08:37:44 -0700 (PDT)
Subject: Re: [PATCH] blockdev: Use error_report() in hmp_commit()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191015123932.12214-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4a1867c3-ffe3-2252-ee96-9325b3ed7f2d@redhat.com>
Date: Tue, 15 Oct 2019 17:37:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015123932.12214-1-kwolf@redhat.com>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 2:39 PM, Kevin Wolf wrote:
> Instead of using monitor_printf() to report errors, hmp_commit() should
> use error_report() like other places do.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   blockdev.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index f89e48fc79..e2358966c3 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1088,11 +1088,11 @@ void hmp_commit(Monitor *mon, const QDict *qdic=
t)
>  =20
>           blk =3D blk_by_name(device);
>           if (!blk) {
> -            monitor_printf(mon, "Device '%s' not found\n", device);
> +            error_report("Device '%s' not found", device);
>               return;
>           }
>           if (!blk_is_available(blk)) {
> -            monitor_printf(mon, "Device '%s' has no medium\n", device)=
;
> +            error_report("Device '%s' has no medium", device);
>               return;
>           }
>  =20
> @@ -1105,8 +1105,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
>           aio_context_release(aio_context);
>       }
>       if (ret < 0) {
> -        monitor_printf(mon, "'commit' error for '%s': %s\n", device,
> -                       strerror(-ret));
> +        error_report("'commit' error for '%s': %s", device, strerror(-=
ret));
>       }
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

