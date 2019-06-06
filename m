Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3559C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C6F20673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C6F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44690 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ0tE-0005IH-Rh
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 18:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ0se-0004hY-N2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ0sc-0003cV-J8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:29:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZ0sX-0003NS-JP
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:29:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so222409wrv.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 15:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g05nqlPZqueh6GHM/y6R7bha3/gYOhV36leuPT9KDhk=;
 b=PCCQPkEPG8LrKeUX/GwpJRm9ALM6j93FU5CAAjhHtmyiLbB1zUjEMFEVJPj9vTgAxW
 69emoaIU5iS6Q39YwazXGPNfrYi/A3B79xbfMgqs96mDxsyA1bFBDARVj1tiWSgmCAnl
 jrCzB5so9keetJAqgN6KBV4X5hyXwGMZnfmCR+rMk3aRrkIEpJzovwvHA/sn0Noudhyo
 P9l+0pF5NcLekH4nwWbSjWigK245nuwfqW99b3e5qFAstKetiCl/9u/4M0ipNgw0Xv6/
 7gDz456U1uyr+ZJLHKmGa59ZNWBeNKHNT6o1+tLQSTFyEXon399SGUFY606QXJpQnHji
 wuRg==
X-Gm-Message-State: APjAAAUeOEVcNyYoSR+xnAVBYhT2A2isvcBOV4FQyeXKdRZCa53PA0MS
 GMNilOCta5N4q/aZNWXxr0Dnkw==
X-Google-Smtp-Source: APXvYqyjWJnniYOsRt1rRbQQJaRg0lsw/N6wLZEkseJEUXCNSzegXmd2LwJL1Ilcxk5JqE8lXhFENA==
X-Received: by 2002:adf:a18a:: with SMTP id u10mr8934774wru.351.1559860136571; 
 Thu, 06 Jun 2019 15:28:56 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id y5sm131228wrs.63.2019.06.06.15.28.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 15:28:56 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20190503193721.18459-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d1447249-9f93-f4d2-53db-c2617a41b43d@redhat.com>
Date: Fri, 7 Jun 2019 00:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503193721.18459-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] Deprecate Python 2 support
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/3/19 9:37 PM, Eduardo Habkost wrote:
> Python 2 will reach end of life in January 1 2020.  Declare it as
> deprecated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure            | 8 ++++++++
>  qemu-deprecated.texi | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/configure b/configure
> index 5b183c2e39..50385061ed 100755
> --- a/configure
> +++ b/configure
> @@ -6461,6 +6461,14 @@ if test "$supported_os" = "no"; then
>      echo "us upstream at qemu-devel@nongnu.org."
>  fi
>  
> +# Note that if the Python conditional here evaluates True we will exit
> +# with status 1 which is a shell 'false' value.
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
> +  echo
> +  echo "WARNING: Python 2 support is deprecated" >&2
> +  echo "WARNING: Python 3 will be required for building future versions of QEMU" >&2
> +fi
> +
>  config_host_mak="config-host.mak"
>  
>  echo "# Automatically generated by configure - do not modify" >config-all-disas.mak
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 842e71b11d..2f2d9a3e95 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -206,3 +206,11 @@ Note that if you are exposing the export via /dev/nbd0, it is easier
>  to just export the entire image and then mount only /dev/nbd0p1 than
>  it is to reinvoke @command{qemu-nbd -c /dev/nbd0} limited to just a
>  subset of the image.
> +
> +@section Build system
> +
> +@subsection Python 2 support (since 4.1.0)
> +
> +In the future, QEMU will require Python 3 to be available at
> +build time.  Support for Python 2 in scripts shipped with QEMU
> +is deprecated.
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

