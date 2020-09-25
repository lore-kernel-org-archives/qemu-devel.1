Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD72AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63628207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7QrFuD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63628207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLiev-0004Vd-0G
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLidz-0003tX-UF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLidy-0007Fa-1M
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 03:59:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601020787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/r63qHHASwi/y6OcMinoPsksv7Xyv8VNrBrxUqWCqRY=;
 b=i7QrFuD6346yFq2fQYljBS7i7scWuDu+v+LSMWUJQCKwIK0ioaqEtycIrAki+H++82T/3q
 HWsMVTkbH/tNZOR45HvqsZ/mf2xbPe6Sj3UKstUb9BmVDXIoldKC24rPMOm45lSVsm45Pj
 CfERuYwbZVeMEmBSiHFEsxPx/Pnd+MA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-gB_uMSd-NhSXi-ClHm9ryA-1; Fri, 25 Sep 2020 03:59:46 -0400
X-MC-Unique: gB_uMSd-NhSXi-ClHm9ryA-1
Received: by mail-wm1-f69.google.com with SMTP id x6so793704wmi.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/r63qHHASwi/y6OcMinoPsksv7Xyv8VNrBrxUqWCqRY=;
 b=m73cyGGxVroB5r5snpnEpwaWrIf49X/53zsklaZMsh4RLE4eIomZPNSk/vsGr0Iedq
 NjL2oGQmgM+xkkWDKUWG9fDeUoIikHDnPDrCkG8ZZ6vPkMq59458aGUzS0umntoZJiO9
 bqOcyFl90flnDtlp2DNZmSx1F9TkSP6iQbCzPMVB8QOEl2CTsWi8PBz1qc2WpW8Qlr7y
 eX1SJY2vpvQwevQ0kN0pghXHOaQ8ZPxkGPF5SU/usw3+rZkKuYfBYI7aq/LeXQcdCxNl
 CYKwk4b/0EHh0cMbd1PeFiPSxL56iItg+I2MhU18jSGM4TurSSFzKMQuNO5TUhfiB9lI
 z10A==
X-Gm-Message-State: AOAM5306vK+a1u+/REjF+IQVpadkf9pzGeWrfI9Q5YfwLSqzT5fyOsHM
 Xv3B4L9q53e1GuCDzGFDssgAD+Q8stwoj3X+zNB5Pqggb5Bb5kNi71R3uk4+ekaKgR5nr/AeuSz
 QOYr1EWEdBRxg8Zs=
X-Received: by 2002:adf:e449:: with SMTP id t9mr3132664wrm.154.1601020784791; 
 Fri, 25 Sep 2020 00:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRDUjb6EesEKY16rwsoOMhovOrZeE1mkU9LEwEDMXzwt27sTVL+iHc9kXgDs72e1SRMZc/oQ==
X-Received: by 2002:adf:e449:: with SMTP id t9mr3132651wrm.154.1601020784570; 
 Fri, 25 Sep 2020 00:59:44 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf?
 ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
 by smtp.gmail.com with ESMTPSA id n4sm1848991wrp.61.2020.09.25.00.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 00:59:43 -0700 (PDT)
Subject: Re: [PATCH] configure: Fix build dependencies with vhost-vdpa.
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200924210023.160679-1-lvivier@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <234121e9-de6a-a157-9a8d-2328841e21ca@redhat.com>
Date: Fri, 25 Sep 2020 09:59:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924210023.160679-1-lvivier@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, Jason Wang <jasowang@redhat.com>,
 lulu@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/20 23:00, Laurent Vivier wrote:
> Following the same logic as for vhost-net-user and vhost-kernel,
> enable vhost-net if vhost-net-vdpa is enabled and vhost-net is not
> explicitly disabled.
> See 299e6f19b3e2 ("vhost-net: revamp configure logic")
> 
> Autoselect VHOST if VHOST_VDPA is set
> See 21c6b0c87e85 ("configure: simplify vhost condition with Kconfig")
> See 2becc36a3e53 ("meson: infrastructure for building emulators"
> 
> Problems can be triggered using;
> ... --enable-vhost-vdpa --disable-vhost-user --disable-vhost-kernel ...
> 
> Fixes: 108a64818e69 ("vhost-vdpa: introduce vhost-vdpa backend")
> Cc: lulu@redhat.com
> Cc: pbonzini@redhat.com
> Cc: marcandre.lureau@redhat.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  Kconfig.host | 4 ++++
>  configure    | 3 ++-
>  meson.build  | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Kconfig.host b/Kconfig.host
> index 4af19bf70ef9..a9a55a9c315c 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -24,6 +24,10 @@ config VHOST_USER
>      bool
>      select VHOST
>  
> +config VHOST_VDPA
> +    bool
> +    select VHOST
> +
>  config VHOST_KERNEL
>      bool
>      select VHOST
> diff --git a/configure b/configure
> index e8e8e984f245..8ee15810c882 100755
> --- a/configure
> +++ b/configure
> @@ -2494,9 +2494,10 @@ if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
>    error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
>  fi
>  
> -# OR the vhost-kernel and vhost-user values for simplicity
> +# OR the vhost-kernel, vhost-vdpa and vhost-user values for simplicity
>  if test "$vhost_net" = ""; then
>    test "$vhost_net_user" = "yes" && vhost_net=yes
> +  test "$vhost_net_vdpa" = "yes" && vhost_net=yes
>    test "$vhost_kernel" = "yes" && vhost_net=yes
>  fi
>  
> diff --git a/meson.build b/meson.build
> index f4d1ab109680..488ca205fad2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -521,6 +521,7 @@ kconfig_external_symbols = [
>    'CONFIG_OPENGL',
>    'CONFIG_X11',
>    'CONFIG_VHOST_USER',
> +  'CONFIG_VHOST_VDPA',
>    'CONFIG_VHOST_KERNEL',
>    'CONFIG_VIRTFS',
>    'CONFIG_LINUX',
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I expect this to be merged by Michael or Jason?

Paolo


