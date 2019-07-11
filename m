Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C75C74260
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B199208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 17:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B199208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hldAw-0005h2-OI
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 13:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hldAV-0004Iw-Fp
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hldAS-00024H-HG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:47:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hldAQ-0001zW-Eu
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 13:47:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so6508806wme.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 10:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9ZeL5rd7wsQb5FMRZxtQ5oT+NRIcz3swN8Z2IO2HrY8=;
 b=rtHrLr3Vy75dOc5ASq9pnuLTCuOYcMSS66qxIJvY+Go/6FMlsV9kJS0YdLLz7zbosh
 C+aNkL/HEz9NTUA7zITxEZ7MHOvHASZzR4Q5JD4+LwcJ98RhJquaadMB6BBVg3jPJDkA
 4K9sscKzmgVC20r71VjazwARDK1/GN7aW8JhCJ05nExYJEu77ltTHfBqL+azgBjq1Ri+
 KkkC+M45XV0AWe7+dSFwX194ettz1kiZAvrs+mOv7pQv7m6fSGEP3onzdjKSsb3e9VX3
 zDjiuno/tN1zjjhgYr3malL9pTsoEf66FeXvtaiD+i47VFspr4b2QJoCEj3zlk3sZEkH
 iMXg==
X-Gm-Message-State: APjAAAWr2IQpC4exAiz1dcPZ5eNDRAqXUN7fNTspZqsxcgk31XkgiiCn
 0+lzxlcNMOyXeTvxqH3ex/LT8N7A+T4=
X-Google-Smtp-Source: APXvYqzRhUz83nVS0EHB4FM8dOKmM92tnf/6NKTbdEsuELpNrqsM7fF4G+mNCHqqCI1zGUOAGvNykA==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr5146952wme.12.1562867256745; 
 Thu, 11 Jul 2019 10:47:36 -0700 (PDT)
Received: from [192.168.1.103] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id e19sm8351896wra.71.2019.07.11.10.47.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 10:47:36 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1562865736-3546-1-git-send-email-pbonzini@redhat.com>
 <1562865736-3546-3-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <de09009c-1bcf-56e0-2d49-eb161b70d056@redhat.com>
Date: Thu, 11 Jul 2019 19:47:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1562865736-3546-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 2/2] create_config: remove
 $(CONFIG_SOFTMMU) hack
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 7:22 PM, Paolo Bonzini wrote:
> CONFIG_TPM is defined to a rather weird $(CONFIG_SOFTMMU) so that it
> expands to the right thing in hw/Makefile.objs.  This however is not
> needed anymore and it has a corresponding hack in create_config
> to turn it into "#define CONFIG_TPM 1".  Clean up.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure             | 2 +-
>  scripts/create_config | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 4983c8b..eb635c3 100755
> --- a/configure
> +++ b/configure
> @@ -7159,7 +7159,7 @@ if test "$live_block_migration" = "yes" ; then
>  fi
>  
>  if test "$tpm" = "yes"; then
> -  echo 'CONFIG_TPM=$(CONFIG_SOFTMMU)' >> $config_host_mak
> +  echo 'CONFIG_TPM=y' >> $config_host_mak
>  fi
>  
>  echo "TRACE_BACKENDS=$trace_backends" >> $config_host_mak
> diff --git a/scripts/create_config b/scripts/create_config
> index 00e86c8..6d8f08b 100755
> --- a/scripts/create_config
> +++ b/scripts/create_config
> @@ -54,7 +54,7 @@ case $line in
>      done
>      echo "    NULL"
>      ;;
> - CONFIG_*='$(CONFIG_SOFTMMU)'|CONFIG_*=y) # configuration
> + CONFIG_*=y) # configuration
>      name=${line%=*}
>      echo "#define $name 1"
>      ;;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

