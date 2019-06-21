Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F023C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570682070B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 17:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570682070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heNCJ-0006MO-5w
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 13:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heNB5-0005uP-Ip
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heNB4-0003Qh-Av
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:18:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40598)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heNAw-0003GT-36
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 13:18:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so7305568wre.7
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 10:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IwbtsifUNKgRjDSiZ/SU6hpcC6jED5oalA7QwTttp+g=;
 b=XZm0YQbDxI+63iSjoQFVWA7XTJn9aBuId0Mi/fOtSRlh89HinMgQNJh+EuEnbUwAsE
 MDV3nSXPziQs6KYk1rC54uYiKi7/595NxEPft6fQjxiCSb+T6fKvj3vhE0i/UycTydXV
 kQ/Rh3LWaS801LMycTyqq+1pecNwYhr0CESTDG5Ug2m2aGc+7TByYTHyfJ7WrvFj1iWW
 r/J6Po2byd5Y0GLhvLUGsxPMmNrXIPIXbV/RI0Bnyyc+iTkYmeFwYqujV5P3HEBUH8o7
 j5frk72CLnayIHHTYbxxOpw6K/Dtohzid3msDe7Q2s/EQrIis6xnDv1YjBXGy8Hl0PFU
 IeWg==
X-Gm-Message-State: APjAAAW881vKpiKQ8bFEdKkG14okvl78ZgB8Nz0amBi0sOEmcnx3FXvR
 yodVgeqWJtk8YfBl8OLJQPHIHQ==
X-Google-Smtp-Source: APXvYqzjrX3POMGk+8nukhPDIqNIGMNaZU+2mJZBbXlSJqUL1Y9+72BbOVqEdFowKu+m+TqQR2BBCw==
X-Received: by 2002:a5d:4d84:: with SMTP id b4mr16550714wru.242.1561137488338; 
 Fri, 21 Jun 2019 10:18:08 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id u25sm2992835wmc.3.2019.06.21.10.18.07
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 10:18:07 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190621130544.18860-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2533033c-16a2-fc6d-74aa-e7cb5ee93817@redhat.com>
Date: Fri, 21 Jun 2019 19:18:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621130544.18860-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH] configure: linux-user doesn't need neither
 fdt nor slirp
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 3:05 PM, Laurent Vivier wrote:
> if softmmu is not enabled, we disable by default fdt and
> slirp as they are only used by -softmmu targets.
> 
> A side effect is the git submodules are not cloned
> if they are not needed.
> 
> Clone and build can be forced with --enable-fdt and
> --enable-slirp.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  configure | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/configure b/configure
> index b091b82cb371..4b3853298c79 100755
> --- a/configure
> +++ b/configure
> @@ -4066,6 +4066,11 @@ if test "$fdt_required" = "yes"; then
>    fdt=yes
>  fi
>  
> +# linux-user doesn't need fdt

"fdt is only required when building softmmu targets"

(we don't need it to build tools such qemu-img)

> +if test -z "$fdt" -a "$softmmu" != "yes" ; then
> +    fdt="no"
> +fi
> +
>  if test "$fdt" != "no" ; then
>    fdt_libs="-lfdt"
>    # explicitly check for libfdt_env.h as it is missing in some stable installs
> @@ -5923,6 +5928,11 @@ fi
>  ##########################################
>  # check for slirp
>  
> +# linux-user doesn't need slirp

"slirp is only required when building softmmu targets"

> +if test -z "$slirp" -a "$softmmu" != "yes" ; then
> +    slirp="no"
> +fi
> +
>  case "$slirp" in
>    "" | yes)
>      if $pkg_config slirp; then
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

