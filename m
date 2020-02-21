Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E015C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC3B20722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP5k7ptm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC3B20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Bug-0002SR-3h
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j5Bu3-00023R-Gf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j5Bu2-0001iC-Is
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:15:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j5Bu2-0001hP-Ef
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582305349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Qd+LcsZRsCHoKht6m169/tDP+wILwgO1H0jkrhlOm8=;
 b=WP5k7ptmSfBdA8Qk85MmOvye9vyQnu4wu3M+kr3jWsBwBt/l/5q+3Ia2zYaUm3SNEEkS7n
 P9Rh9gbA6mim65kxhnrCpjSfpvaMPiKcu7qej9mNkw8Nwu8TjCx8ZDemSMjwt2rGc/oKtM
 EBs+Men2wavRpJU5AIvYplZ6DjHp7e8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-0uxmSZkMMbKy_COq-G6UtQ-1; Fri, 21 Feb 2020 12:15:47 -0500
X-MC-Unique: 0uxmSZkMMbKy_COq-G6UtQ-1
Received: by mail-wm1-f71.google.com with SMTP id p26so880896wmg.5
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Qd+LcsZRsCHoKht6m169/tDP+wILwgO1H0jkrhlOm8=;
 b=t/kliScvnqjkLVWsr36VgsZm3rpuchbEYAEqo02yBSN9qnCioVi2OPcdKel66b5TQS
 1GwiQfdwGT9/FjqXHxkQXGCe9TDI5SgXYAh0kpWdgq92uv2paOg6IsQ87fmk4Gucfu62
 0BgcpZAaAE1GcJfn+YujqS4/xQSD/UtOUL8vaHoO9hHpvzG8VpTb4+T2k1q7FxZsnG1j
 Dn+oD2rC2CwWD7v4L3PqFgQ+hlHqqr0X7ZA/ISzA74OaCJv3ABpOW3m0OMN7sBiJtZdJ
 jv+yO9LheEHmAoO9Fw7Csh8dK9egHiEBbLr2bvbWQW+zet5G+DtlNcIAytiheHuK5497
 dD4g==
X-Gm-Message-State: APjAAAVANThmqIVwEvB+dk2lGSR6j4RhMa3/RMIl3dD13Q168Lcx7HLh
 N1MXNyfTv5+8hSGSEvf7zCWrnWESdxkq+peomF2QaWWLJ/GXwq5QfIRTVdnPQ69L0veo19bNpw+
 L64UpjwuJ98wfGcs=
X-Received: by 2002:adf:e448:: with SMTP id t8mr49140891wrm.224.1582305346422; 
 Fri, 21 Feb 2020 09:15:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6WdZow84u5QJ6hKk/G5YyQRlcxkA97Y76EzHixYnZ/q1c1Yht5xfWYdc+/0xcEBh7rVSaMg==
X-Received: by 2002:adf:e448:: with SMTP id t8mr49140878wrm.224.1582305346222; 
 Fri, 21 Feb 2020 09:15:46 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
 by smtp.gmail.com with ESMTPSA id h10sm4543284wml.18.2020.02.21.09.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 09:15:45 -0800 (PST)
Subject: Re: [PATCH] WHPX: Assigning maintainer for Windows Hypervisor Platform
To: Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
References: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0994488b-8f1d-b77a-5d8a-057ea4e479a9@redhat.com>
Date: Fri, 21 Feb 2020 18:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB0880E245954826FD91C9D67DC0110@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
Cc: Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Justin Terry \(SF\)" <juterry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 21:38, Sunil Muthuswamy wrote:
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1740a4fddc..9b3ba4e1b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -404,6 +404,14 @@ S: Supported
>  F: target/i386/kvm.c
>  F: scripts/kvm/vmxcap
>  
> +WHPX CPUs
> +M: Sunil Muthuswamy <sunilmut@microsoft.com>
> +S: Supported
> +F: target/i386/whpx-all.c
> +F: target/i386/whp-dispatch.h
> +F: accel/stubs/whpx-stub.c
> +F: include/sysemu/whpx.h
> +
>  Guest CPU Cores (Xen)
>  ---------------------
>  X86 Xen CPUs
> 

Queued.  Patches can still go through my tree while you get up to speed.
 Thanks!

Paolo


