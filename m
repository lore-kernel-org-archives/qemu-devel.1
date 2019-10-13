Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AB5C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 06:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE2B206B7
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 06:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE2B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJXTz-0004GJ-MZ
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 02:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iJXT1-0003XN-BF
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 02:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iJXSz-0002rV-Ad
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 02:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iJXSz-0002qQ-2Z
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 02:34:57 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 644F485541
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 06:34:53 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id m19so14358400qtm.13
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 23:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sojoGNv0rRwJpZYZGhwRiwdgk3T1aUZWIBl5YwwCzDs=;
 b=Qb8yYUokeUMeWLbH2SGxjM6B/ujzeoAKhgPbKeL/BikCJBnAQv8y45xC/HOQZ3L3eL
 A3RAZwWodIQRSlYHY73hMcUSy0S0uIAbHoStu2/ichEaj11MS0gLE3fg3+EtaN2toIPC
 +PkAOU7TARR0i1ykSZesrSfww7ExkrVCnYHWHSIez6dguzcvGjadMqA/CLlGyatCBobL
 +m8PhoJ1aZTnk1yAIxeZnICaq1FXopYWaVhYm4QbJZa+jIS7sf6Nfdajj8kdc0gMEAPr
 gXXg34elUCRGLauioLMhY4vDOsz0TtLYulvHC3COIv4bieKJdVyi6nEPq6hj7SZxE3gU
 e1gw==
X-Gm-Message-State: APjAAAXLD9PFsZilcxGLjgs2nJu7xkp7FfnmzA82Rva6Ph/LYcbZKCRJ
 EtdbCimD+rM8bltWVoT8G+arP6Jmi5gR7B3JihGIqBG+qAdo2sviow7GT9NlWbQqNSgQlpdxSGV
 1xXjpEpwWJnLPb6g=
X-Received: by 2002:ac8:356e:: with SMTP id z43mr26548727qtb.88.1570948492685; 
 Sat, 12 Oct 2019 23:34:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqywoZWEQHYHiqHHeU0vnWsSZmb8NmF+QN8+PX4fiFM9ayx8B8oiMF7JOKUXwAEshqAgBTmKqw==
X-Received: by 2002:ac8:356e:: with SMTP id z43mr26548696qtb.88.1570948492411; 
 Sat, 12 Oct 2019 23:34:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 c14sm7543327qta.80.2019.10.12.23.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2019 23:34:51 -0700 (PDT)
Date: Sun, 13 Oct 2019 02:34:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 1/2] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Message-ID: <20191013023436-mutt-send-email-mst@kernel.org>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013021145.16011-2-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 kraxel@redhat.com, den@openvz.org, qemu-block@nongnu.org, quintela@redhat.com,
 armbru@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 marcandre.lureau@redhat.com, rth@twiddle.net, ehabkost@redhat.com,
 sw@weilnetz.de, dgilbert@redhat.com, yuval.shaia@oracle.com,
 alex.williamson@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 david@gibson.dropbear.id.au, kwolf@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 13, 2019 at 10:11:44AM +0800, Wei Yang wrote:
> Use ROUND_UP() to define, which is a little bit easy to read.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/exec/cpu-all.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index ad9ab85eb3..255bb186ac 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -220,7 +220,7 @@ extern int target_page_bits;
>  
>  #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
>  #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
> -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
>  
>  /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
>   * when intptr_t is 32-bit and we are aligning a long long.
> @@ -228,9 +228,8 @@ extern int target_page_bits;
>  extern uintptr_t qemu_host_page_size;
>  extern intptr_t qemu_host_page_mask;
>  
> -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qemu_host_page_mask)
> -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size - 1) & \
> -                                    qemu_real_host_page_mask)
> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
> +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size)
>  
>  /* same as PROT_xxx */
>  #define PAGE_READ      0x0001
> -- 
> 2.17.1

