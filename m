Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F579C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0132D2080C
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 07:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeLsbLcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0132D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM54f-0000Cz-2J
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 03:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kM53z-00088Q-Qw
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 03:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35528)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kM53x-0008GT-8x
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 03:56:11 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601106968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4kV3T7hzPKK3/3oXJOpR3FlMCQqMO5CoJCEIAAx/K4=;
 b=QeLsbLcjdHz5BjiEPDdIUXi+1jb83MKGMHnvx/iuyTAjJOmWs1cF/JyEQjZkuxmF9lIxML
 RVIIb08WooE7To9mi7pfcB0ZR1ucykjpODO6bHBClkuKzsj0QrQxlzp2qMRyY6vdQFJKfB
 b5J25K4mp6jrt5U/jIp5oynsF2p07Zg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-jmkIjODLPrW2lFMYm9yvig-1; Sat, 26 Sep 2020 03:56:06 -0400
X-MC-Unique: jmkIjODLPrW2lFMYm9yvig-1
Received: by mail-ot1-f70.google.com with SMTP id x25so664063otq.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 00:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S4kV3T7hzPKK3/3oXJOpR3FlMCQqMO5CoJCEIAAx/K4=;
 b=Z747fBAov2YcRbDxlcwRpMqrObRMrF0xRamb6kbopS/JZJCfCPyigxZUbVDtpYY19S
 vCG0pi5teFELUv2h4YJvoHdmIaOj/3iImQLDkl6eZbuC+iV4wLcnGYKrrIyAhkqVNt5y
 tUAQ5+Cseh1wBbS91PWnnrTSYBnaVizAepYcMg6U+zWE183lFhJpKVwexGS1fP70wr9x
 XeACmSrAPQNHuX0gCayN5QsYXty5zw2mthe2sG13WTmsFF4iZkDicHpBLMZhOkkBzqWV
 tMbYgiqRL1Z74zZp3CEM35nKk4jOANy6ey5RjjGmJyuptMADRC2SEYnyvKHo9jqrbR9K
 0I5Q==
X-Gm-Message-State: AOAM533TjoWd/wKF3sUpttmhgTlABD23aHnmI4b9I3rwYkpfEcGqCHXR
 DKrFrzKk5MXMWQjveeelwvqgi+SQuIapoI5uKCbXX5e7TvhDfU6L9inGYHqzco3yRVeahmWKM5j
 CJGcfiQiUFNPDZlthMSFliRBRn7kxgRo=
X-Received: by 2002:aca:5110:: with SMTP id f16mr750808oib.30.1601106965359;
 Sat, 26 Sep 2020 00:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQU6V4x31QZRjhA/rEuj9+m+wkqXbtsMxkjX3FzfvlqWeH6p8BjMGIr1tgmWg76SnkFXWt9W1mYmmZ+FiC39Y=
X-Received: by 2002:aca:5110:: with SMTP id f16mr750801oib.30.1601106965175;
 Sat, 26 Sep 2020 00:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+XhMqxQ3o_h7_Fwho7gu9x9Pw5jCw=z-goVMyzJgQYqZR-cgA@mail.gmail.com>
In-Reply-To: <CA+XhMqxQ3o_h7_Fwho7gu9x9Pw5jCw=z-goVMyzJgQYqZR-cgA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sat, 26 Sep 2020 09:55:54 +0200
Message-ID: <CAP+75-XwpLiutpW6-J3DLKFGXOVd=tLF2fG2=0=nP9+KZ0UYug@mail.gmail.com>
Subject: Re: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros
 build
To: David CARLIER <devnexen@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On Fri, Jun 26, 2020 at 4:08 PM David CARLIER <devnexen@gmail.com> wrote:
>
> From 95ef79ddff73eebd1f1bec6673c2c68209fab107 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Fri, 26 Jun 2020 13:56:14 +0000
> Subject: [PATCH 1/3] Include endian.h for Haiku to solve bswap* macros build
>  failure.

Back to this patch, what version of Haiku are you using?
I couldn't find this information in your other emails.
Thanks,
Phil.

>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  include/qemu/bswap.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 2a9f3fe783..1d3e4c24e4 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -8,6 +8,8 @@
>  # include <machine/bswap.h>
>  #elif defined(__FreeBSD__)
>  # include <sys/endian.h>
> +#elif defined(__HAIKU__)
> +# include <endian.h>
>  #elif defined(CONFIG_BYTESWAP_H)
>  # include <byteswap.h>
>
> --
> 2.26.0
>


