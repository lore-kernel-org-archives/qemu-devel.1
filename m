Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31401C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F87420872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="se/5p126"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F87420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIy64-0006dd-6K
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kIy4m-0005lM-5s
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:52:09 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58456 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kIy4g-0004Lz-C1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:52:07 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 25BB957EC3;
 Thu, 17 Sep 2020 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1600365119;
 x=1602179520; bh=nMFhR9lz2KDa0+2xbZuIs4l9EjaeXXFrilONutE/ntA=; b=
 se/5p126U8LXObJ1dUvSc20Wsxvj3uXWJE7sxCIaetDwPRI44zKbitlvPRVySE6z
 O7kqxhFXGmPdSFGl/yUBR0Fb8kisuXg3rJrMgKZwIB7OrqAEkofk/ktgYNZK6iBq
 slpG1m87O/GU9XoXdJLCi4Kl9BUoauWFVGbZ6+uSuBo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8briFqzmAeNF; Thu, 17 Sep 2020 20:51:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id F27275796D;
 Thu, 17 Sep 2020 20:51:58 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 17
 Sep 2020 20:51:58 +0300
Date: Thu, 17 Sep 2020 20:51:58 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] configure: do not limit Hypervisor.framework test to
 Darwin
Message-ID: <20200917175158.GC43363@SPB-NB-133.local>
References: <20200916081131.21775-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916081131.21775-2-pbonzini@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 13:27:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Christophe de Dinechin <dinechin@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 04:11:31AM -0400, Paolo Bonzini wrote:
> Because the target/i386/hvf/meson.build rule culls hvf support
> on non-Darwin systems, a --enable-hvf build is succeeding.
> To fix this, just try the compilation test every time someone
> passes --enable-hvf.
> 
> Reported-by: Christophe de Dinechin <dinechin@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index b4c0e0d07c..14b06a2510 100755
> --- a/configure
> +++ b/configure
> @@ -863,7 +863,7 @@ Darwin)
>    bsd="yes"
>    darwin="yes"
>    hax="yes"
> -  hvf="yes"
> +  hvf=""
>    if [ "$cpu" = "x86_64" ] ; then
>      QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
>      QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
> @@ -5867,16 +5867,18 @@ fi
>  
>  #################################################
>  # Check to see if we have the Hypervisor framework
> -if [ "$darwin" = "yes" ] ; then
> +if [ "$hvf" != "no" ] ; then
>    cat > $TMPC << EOF
>  #include <Hypervisor/hv.h>
>  int main() { return 0;}
>  EOF
>    if ! compile_object ""; then
> +    if test "$hvf" = "yes"; then
> +	error_exit "Hypervisor.framework not available"
> +    fi
>      hvf='no'
>    else
>      hvf='yes'
> -    QEMU_LDFLAGS="-framework Hypervisor $QEMU_LDFLAGS"
>    fi
>  fi
>  
> -- 
> 2.26.2
> 

After reading "configure: move cocoa option to Meson", I think the patch
should follow meson-driven configuration like the cocoa patch. That'd be
a step closer to make configure a thin shim to "meson configure".

Roman

