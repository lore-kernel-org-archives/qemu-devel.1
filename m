Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B993C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E357206D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 17:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMwMsxS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E357206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP8gQ-0002uw-AM
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 13:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jP8fG-0002LD-Cb
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jP8fE-0003y4-P0
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:51:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jP8fE-0003xa-GJ
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 13:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587059459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kUDrER49dCGYdRxNpaG+s1Zvz7uxNuExlrFoewGLaV8=;
 b=jMwMsxS2gMno/d5lRBcKbk0e8bXal6XOKxxyxGEWDNvoVHTIGrxl7MqgxncalWHJPHZ1Vn
 FCrDwXy1vjqtFTFoOKVIN27GgivoGMzyGAuuTgZQSkK5/qJ9k2GKX2qjx75ycn/aql4VtG
 NKuYJ2CDVOQ4120Vd0GyfWe4xDxUUkg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-MIs5CznjM6ieUgZ-nQs-NA-1; Thu, 16 Apr 2020 13:50:57 -0400
X-MC-Unique: MIs5CznjM6ieUgZ-nQs-NA-1
Received: by mail-ed1-f69.google.com with SMTP id u6so981246edq.11
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 10:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cQC8W0WSUjG4Mdby6kR0argtgNt3o9FbsLCeWa3k3b4=;
 b=J9opgsyTyox1WwbwNPYNbgmXaPFWfVA14HHMMBqorMyeQsey5frKv6GFLgeWOKkXj+
 /E0tRJCsmRlxGkHmYHG996EOZJ0qB8k8A0bli/YrJcZlMkYsq4qfXwJIYTETRlWx8nes
 +cH/E871dAz9+KlgmKp32kPhO5Rz0YAfDmi78jcemSxBXUsrXRnHE4P7HKgLBOxbdJc4
 /u5thFCp1BSD8UcuetDcwtr4CZKSqN0MvqPtbA4uyoAryur1SuEc8M/918kjIdHT7DhB
 HcMxrEB+LTkudIeblGuQym7N+rdBd4xAxbujlmW08CzuHydNRQm13PVDA3ya/iEB4QRB
 wuQQ==
X-Gm-Message-State: AGi0PuakE9UtGRPN9rSBgt4CyyunOZff+jFUoHf7adLtcnP5LNqmVLvV
 bZySPOj+gBj5QRg7e4wjS/+DWmT0cfPiBsskss4v4Tdb8he+1GANGeX5dSsRsegz2DTCvZ+YsG6
 ++2exJXB56OU4/CA=
X-Received: by 2002:a05:6402:22f7:: with SMTP id
 dn23mr31789061edb.167.1587059456277; 
 Thu, 16 Apr 2020 10:50:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYvq1vSB9o36cYKttnDjH4BQhlgSBOhyJbUjsnY5kaf9dqqON94chM5h58U4IGJasZOFK02g==
X-Received: by 2002:a05:6402:22f7:: with SMTP id
 dn23mr31789047edb.167.1587059456091; 
 Thu, 16 Apr 2020 10:50:56 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id l5sm1516249ejr.45.2020.04.16.10.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2020 10:50:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] virtiofsd: drop all capabilities in the wait parent
 process
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200416164907.244868-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <989583c7-f7a0-544f-420d-43eb197098cb@redhat.com>
Date: Thu, 16 Apr 2020 19:50:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200416164907.244868-3-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/16/20 6:49 PM, Stefan Hajnoczi wrote:
> All this process does is wait for its child.  No capabilities are
> needed.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/passthrough_ll.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index af97ba1c41..0c3f33b074 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2530,6 +2530,17 @@ static void print_capabilities(void)
>       printf("}\n");
>   }
>  =20
> +/*
> + * Drop all Linux capabilities because the wait parent process only need=
s to
> + * sit in waitpid(2) and terminate.
> + */
> +static void setup_wait_parent_capabilities(void)
> +{
> +    capng_setpid(syscall(SYS_gettid));

Maybe worth a /* Drop all capabilities */ comment here.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    capng_clear(CAPNG_SELECT_BOTH);
> +    capng_apply(CAPNG_SELECT_BOTH);
> +}
> +
>   /*
>    * Move to a new mount, net, and pid namespaces to isolate this process=
.
>    */
> @@ -2561,6 +2572,8 @@ static void setup_namespaces(struct lo_data *lo, st=
ruct fuse_session *se)
>           pid_t waited;
>           int wstatus;
>  =20
> +        setup_wait_parent_capabilities();
> +
>           /* The parent waits for the child */
>           do {
>               waited =3D waitpid(child, &wstatus, 0);
>=20


