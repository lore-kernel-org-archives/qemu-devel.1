Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCA0C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836A320650
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836A320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXEl-00082h-68
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIWoW-0003Zd-3G
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIWoU-0007dq-Ab
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIWoT-0007dH-FZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:40:57 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 045068E587
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:40:56 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k4so2638824wru.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 04:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vZFU/Zorlb933nx9ib6PRKLtSYdiskEC9Tb6QaFsmFI=;
 b=AX0i2E9VPv8D46ZuPuAnavC/wesx4MlHSd3UhT/R+2649l3UbTPPZE2LylxCXQERbW
 VoALkqXGTvim4qCNp7tM3v8yuAKoqer1ur149gr6DcV2z2EMreVtjUCcgJNUQKxjK4ZU
 MIXbG+w6BGY2lCWJ95fXxQfL58cdq0+ycZOgNRYMJdwznyhR9iUMFsyz2GQnIFlgvNen
 N08rzPK1HS9CmMGSxBUxPx/+r9R13DtIG1YPMEAH2cLKOAOcglbtWH4TuOHygoVftTpu
 hi7Eg+rNxQwwMqWZ6GyViLTOiWvtye1x23r08svsLHPF6LM5DiYzt05gMxvUvJk91Avz
 SMXg==
X-Gm-Message-State: APjAAAUKeTkX++NkvvRymq5y8S0HcfHPAqN9kydMzitGdKnv+WWFvsX3
 E7t7BR1/6mbpBp+yRDKmQbLxSLoLn5oykk+dTYA/LjlJSUCIIG33jzWrPAQUJSlYc9EAWCEKb9B
 MQeXuyzv29UynzF0=
X-Received: by 2002:adf:fc42:: with SMTP id e2mr8676772wrs.100.1570707654803; 
 Thu, 10 Oct 2019 04:40:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySNn6IIrBPQkQeCkXNAVO8VhDB01xx8fXaS56SpDRCmEDoygi0MdgFxmgE3Gyb7aKeVPqQmA==
X-Received: by 2002:adf:fc42:: with SMTP id e2mr8676756wrs.100.1570707654642; 
 Thu, 10 Oct 2019 04:40:54 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id b144sm7302480wmb.3.2019.10.10.04.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2019 04:40:54 -0700 (PDT)
Subject: Re: [PATCH v7 12/12] MAINTAINERS: add microvm related files
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191008135537.197867-1-slp@redhat.com>
 <20191008135537.197867-13-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <425fbf8d-582e-4d30-8cc7-062d4d21dfd0@redhat.com>
Date: Thu, 10 Oct 2019 13:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191008135537.197867-13-slp@redhat.com>
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
Cc: ehabkost@redhat.com, mst@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/19 3:55 PM, Sergio Lopez wrote:
> Add a new "Microvm" section under "X86 Machines" with the new files
> related to this machine type.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>   MAINTAINERS | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ca814850e..dfdc4f9b57 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1275,6 +1275,16 @@ F: include/hw/timer/hpet.h
>   F: include/hw/timer/i8254*
>   F: include/hw/timer/mc146818rtc*
>  =20
> +Microvm
> +M: Sergio Lopez <slp@redhat.com>
> +M: Paolo Bonzini <pbonzini@redhat.com>
> +S: Maintained
> +F: docs/microvm.rst
> +F: hw/i386/microvm.c
> +F: include/hw/i386/microvm.h
> +F: roms/qboot
> +F: pc-bios/bios-microvm.bin
> +
>   Machine core
>   M: Eduardo Habkost <ehabkost@redhat.com>
>   M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

