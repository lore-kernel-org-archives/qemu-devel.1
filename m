Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84375C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FA81206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emzXO3K2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA81206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7HI-0007dO-9c
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is7GS-0006v0-9U
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is7GO-0000YB-1R
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:40:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is7GN-0000Xk-UE
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579189251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XsFhr/S1WfRkrVXz+qIVh16ki/lHWPt5GFVqVN55z8k=;
 b=emzXO3K23CXryjZ/5ZfIzIedUL71iOY8rRIk6ODZlroSM2LLD6bJvWJq5HqpYotOo4/ByL
 mDKY4pOnTjLNXGTT52i1jgUEKC4R1y94zx5YnzF3hnql182gRs0FfU+FXLwn/7mESUGZ7Q
 eOq7T8j2/lePU56DxClzs3ub9FeX31Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-g4AzFSwGMJOMSqa3Dtjbzw-1; Thu, 16 Jan 2020 10:40:48 -0500
Received: by mail-wm1-f72.google.com with SMTP id p5so669504wmc.4
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 07:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gm/KQNE4HskqN2+o6koW9CGTcOg1ttrNyvJh/xwjYU0=;
 b=CQRk707xBUwTLDGWez+Vo5OBk5ommfLSBavsHgOmC2Gtffn2AQZKbpW1poQqiPaVC7
 7sZvsoDACziBqNKmFHWyn5uM/Rx7vzOevDDJ6lRLQibdFGI3uCuDrMheRRr+B9vX46GM
 V8FPEEGqoDR9ldUAuK69wdgeuLcpB3xwZgEvng5jnaoxLp+R1NSJmG5kjvUe3CoTcLaT
 wQglbUAt4NDt4BxkJECddCUaKWAIiuvaMEPY6oedvwp70mSK1Pusm/k9TGhR0bJuf9eC
 IlewNR5HZhV1dK+7RK7dFbAvOXvqC8cIXNPGiuzC2lK667VKwJDS8zfxgND8CTkPmeQv
 3gUA==
X-Gm-Message-State: APjAAAVKHdNrN7H/HEDcpTrNq0ShRB9ZupEH7/AzCafQ9Y7aUH0qImeu
 zDD6yik38WI3W350UupXmQM6YrQPcQPHRDYd0K3xtJO3cVX5HIt+7zvqE3bI5YbvuyLKOpvUcuP
 Hc4SJuoZ2wZcsGE4=
X-Received: by 2002:a5d:4847:: with SMTP id n7mr4018305wrs.30.1579189246842;
 Thu, 16 Jan 2020 07:40:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyRP/+1AsU8pvTNKIMyFy/4x0OICR1y+UMFOwZQJatg28ZbJ7zQ6S3vj3a2v87UN4lOM+Sv1w==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr4018286wrs.30.1579189246633;
 Thu, 16 Jan 2020 07:40:46 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id b18sm30025590wru.50.2020.01.16.07.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:40:46 -0800 (PST)
Subject: Re: [PATCH v2 85/86] numa: make exit() usage consistent
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-86-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0243fb4a-298a-4211-46f4-db2f5a34b2c5@redhat.com>
Date: Thu, 16 Jan 2020 16:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1579100861-73692-86-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: g4AzFSwGMJOMSqa3Dtjbzw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 4:07 PM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: ehabkost@redhat.com
> ---
>   hw/core/numa.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/core/numa.c b/hw/core/numa.c
> index 3177066..47d5ea1 100644
> --- a/hw/core/numa.c
> +++ b/hw/core/numa.c
> @@ -718,7 +718,7 @@ void numa_complete_configuration(MachineState *ms)
>           /* Report large node IDs first, to make mistakes easier to spot=
 */
>           if (!numa_info[i].present) {
>               error_report("numa: Node ID missing: %d", i);
> -            exit(1);
> +            exit(EXIT_FAILURE);
>           }
>       }
>  =20
> @@ -759,7 +759,7 @@ void numa_complete_configuration(MachineState *ms)
>               error_report("total memory for NUMA nodes (0x%" PRIx64 ")"
>                            " should equal RAM size (0x" RAM_ADDR_FMT ")",
>                            numa_total, ram_size);
> -            exit(1);
> +            exit(EXIT_FAILURE);
>           }
>  =20
>           if (!numa_uses_legacy_mem()) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


