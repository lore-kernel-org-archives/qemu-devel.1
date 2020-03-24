Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8311C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A5C208E0
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj8fbh9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A5C208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjN4-0000YP-Nf
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGjMV-00006Q-SP
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGjMU-0005Ro-Ph
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:12:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGjMU-0005RZ-ML
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585055573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1IdQrrAQ+b2WEs4vVc/pbrmHByHaIlXUzHNsEBZb/Y=;
 b=Qj8fbh9Y6dwkcJgC/jZ3Z8Tg1gO0bjO28h8JgflUer9NxKl8Qem8daWpqj4PFLqFxd14OV
 rVY7ovZKNbYywXQTIKb6HrrxlN6BnxzMmhm+56hzr6WLhVya44YpMNzINuqqhCVo/Cw0D8
 txHFkMsTjSH++w1Mb8GLNEp7FcXCTqk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-fGcY9rR9OKazDPl4db14mg-1; Tue, 24 Mar 2020 09:12:50 -0400
X-MC-Unique: fGcY9rR9OKazDPl4db14mg-1
Received: by mail-ed1-f72.google.com with SMTP id b9so13719092edj.10
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l1IdQrrAQ+b2WEs4vVc/pbrmHByHaIlXUzHNsEBZb/Y=;
 b=PUAkHFpUDYHucPLVtOxVC4N/8HAtFYVupzN4mDgsrP30Bxu/K/nXhgjsGS5fcRTosz
 UJ02zaE+v916NAZQwVgARQjiF4A65OZissZ7ntQe6X4Ru79AXiGsbH/yLPkWCKuOBpbr
 HQ1GoDKaT99We19E5k2ht6Gmlz6vlSScKPSZ1TWayVgchq2JeJg6dtFVfXVsS8ChnQn2
 1dzUK2PWDtmPP1pigvKqd67vI7xcUubm4oN3hH1dEi5EkrI6JHgSohhH1hfiT1Xc8OCD
 3yqCEUDBhxBWd3zbRn6jPk95nGUP+hDmKaQVWUXsoYEj4do963zh/pzx9/6R67gFajSz
 vxug==
X-Gm-Message-State: ANhLgQ0/JTGlcEK8T3uDNmBMtYtK7xUMmng+Gv28iyJWpgN0jKxr3s/S
 ira2fyQhG2KETsnxwDrrCKk8wfHmDtD0sKcnX9CTlqvYvDuhcc9ZytNs+NudgVeco/rkMTTH2Ve
 wrwfzS0A5FcVg2Fs=
X-Received: by 2002:a17:906:1f47:: with SMTP id
 d7mr24657116ejk.37.1585055568793; 
 Tue, 24 Mar 2020 06:12:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs54wKH0wq9nokG89CHgEm3bbAuP3/l508Rk74nbuqHecw2P6W6qPUvJCrNkWutbAx9TQ7CJA==
X-Received: by 2002:a17:906:1f47:: with SMTP id
 d7mr24657088ejk.37.1585055568523; 
 Tue, 24 Mar 2020 06:12:48 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id 16sm1026696ejy.39.2020.03.24.06.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:12:47 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] qga: Installer: Wait for installation to finish
To: Basil Salman <basil@daynix.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
References: <20200311170417.13415-1-basil@daynix.com>
 <20200311170417.13415-2-basil@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7d6f3f43-73c6-8500-6680-05ec059fd5ed@redhat.com>
Date: Tue, 24 Mar 2020 14:12:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311170417.13415-2-basil@daynix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Basil,

On 3/11/20 6:04 PM, Basil Salman wrote:
> Installation might fail if we don't wait for the provider
> unregisteration process to finish.
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
> Signed-off-by: Basil Salman <basil@daynix.com>
> ---
>   qga/installer/qemu-ga.wxs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
> index 64bf90bd85..f6781752e6 100644
> --- a/qga/installer/qemu-ga.wxs
> +++ b/qga/installer/qemu-ga.wxs
> @@ -81,7 +81,7 @@
>                 Arguments="-d --retry-path"
>                 >
>               </ServiceInstall>
> -            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="no" />
> +            <ServiceControl Id="StartService" Start="install" Stop="both" Remove="uninstall" Name="QEMU-GA" Wait="yes" />

As 'yes' is the default, can you simply remove 'Wait="no"'?

>             </Component>
>             <?ifdef var.InstallVss?>
>             <Component Id="qga_vss_dll" Guid="{CB19C453-FABB-4BB1-ABAB-6B74F687BFBB}">
> 


