Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307CEC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093D1217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 13:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093D1217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT4uu-0002zG-8f
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 09:34:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT4tG-0001tr-RP
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hT4tF-0007TE-Rb
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:33:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hT4tF-0007Sj-Nl
	for qemu-devel@nongnu.org; Tue, 21 May 2019 09:33:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so20459634qtk.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 06:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=P/ufS22KCVQSHg3wFWEiYxGGg66pWSx8uFJ1K0/zHqw=;
	b=ckBT2uaJSMq7l0Sxgtix7FNZLxrk2Vanl8kyPC7XbpaRaBxDOcItaLrGUu7GXjUaAD
	hhnsI8vYW0jvoPDvKyCrshzsXSyr36IYmBYq1z8tJidedXWaWQ1gkyMjTmSEBYSSkuBW
	8mZLKG1dM5yMltgsv+3xYsKRwntNkFAeppXkx38jo/5KPIaOmfGH6i7ir6HhXtdByACL
	I+5Qv8NbM0OLGAVXYl+FMWFh87W7R2ELYIZxeuT/PGro3o4f6YrT8NXcfaDwYxoojASP
	RlN8eSUKHs1LyGF/2NOMevtKI+6C9CSPj6aV4YfW1FdZoNvAmpOZ4Zi4J5Ynz8u985RL
	+FCA==
X-Gm-Message-State: APjAAAW7rLT9OszEJGvngvDT8TQcBO/fZBpzldZuHzowvkX8aQuUTaG3
	tJYLZ6QVcGHflyutWvBXq4x7jQ==
X-Google-Smtp-Source: APXvYqyLrh1eVXavZ65StKsxm3rLxV1cqaBGca3ct+oQC1MblZSm0HNWOaEKkGdW2gaCPx1JcLYRFw==
X-Received: by 2002:aed:2183:: with SMTP id l3mr68571670qtc.102.1558445593221; 
	Tue, 21 May 2019 06:33:13 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	x206sm9713435qkb.71.2019.05.21.06.33.11
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 21 May 2019 06:33:12 -0700 (PDT)
Date: Tue, 21 May 2019 09:33:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190521093223-mutt-send-email-mst@kernel.org>
References: <1558444486-314511-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558444486-314511-1-git-send-email-imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH] docs: smbios: remove family=x from type2
 entry description
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, thuth@redhat.com, berrange@redhat.com,
	qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 03:14:46PM +0200, Igor Mammedov wrote:
> 'family' option is not part of type 2 table and if user tries to use it
> as such QEMU will error out with an unknow option error.
> Drop it from docs lest it confuse users.
> 
> Fixes: b155eb1d04

Add summary after the hash within ("...") please.

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5daa5a8..dcdb808 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2080,7 +2080,7 @@ Specify SMBIOS type 0 fields
>  @item -smbios type=1[,manufacturer=@var{str}][,product=@var{str}][,version=@var{str}][,serial=@var{str}][,uuid=@var{uuid}][,sku=@var{str}][,family=@var{str}]
>  Specify SMBIOS type 1 fields
>  
> -@item -smbios type=2[,manufacturer=@var{str}][,product=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,location=@var{str}][,family=@var{str}]
> +@item -smbios type=2[,manufacturer=@var{str}][,product=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,location=@var{str}]
>  Specify SMBIOS type 2 fields
>  
>  @item -smbios type=3[,manufacturer=@var{str}][,version=@var{str}][,serial=@var{str}][,asset=@var{str}][,sku=@var{str}]
> -- 
> 2.7.4

