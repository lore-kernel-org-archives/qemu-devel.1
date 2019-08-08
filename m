Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDECC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8C92187F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8C92187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvdf6-0004qi-SM
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 04:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hvdef-0004H5-0K
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hvded-00058c-W1
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:20:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hvded-00057H-OD
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:20:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so1473656wms.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 01:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CHBfq1enqWUV77BcPH2c4BSPbTXijNa2UI+Wxd3j9bE=;
 b=RLzkaqbpAFRQ4/3pgxC+9ckU1DAImOyHKH3h3Z6ePqRM5kLCenR8wBVA7eej1Hlg2e
 ywtC/mE54HgB2o+uTTJVAPVCYxB1uG5gASq0aAw8oEKDcaQkwO7L+9a8KzRnGf1a5qXr
 PcU01ob6VvT1mYkt1v2zr97p/cycYV8UNrM27yUTTv/5T3FfLiGS/7OzRxE/jIk+nN/Y
 hdwI+87RGdK8fxBIHTG7j5b5v+Zpl4spajORJf7Ehzj+DMpQDe6hiRHl65hW4hj1lfz5
 wnqVxgUqJCsFpL8OjYx14JhVrFM1miYJhJ63vi3LmR+xAPtoF3WPpsgwncZaiIr4tO7B
 rGBA==
X-Gm-Message-State: APjAAAWYRB7vXYr1Y2f8RdTAgdP7RSBcalaLa6rXt/LU606Aah7QvvMK
 XrmNtEW8CXzaNPznh++kB1xpwg==
X-Google-Smtp-Source: APXvYqwKy1PM7swkW4if9wkPhtQJhnBEjDt4wyNsZqyoIIsWf+WFuIrRnsh9slhXJnRk56lIFyyspg==
X-Received: by 2002:a1c:e710:: with SMTP id e16mr2979336wmh.38.1565252410365; 
 Thu, 08 Aug 2019 01:20:10 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id i66sm3186397wmi.11.2019.08.08.01.20.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 01:20:09 -0700 (PDT)
Date: Thu, 8 Aug 2019 10:20:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: P J P <ppandit@redhat.com>
Message-ID: <20190808082007.qkgkeyajxb3bere2@steredhat>
References: <20190808063340.23833-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808063340.23833-1-ppandit@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] scsi: lsi: exit infinite loop while
 executing script (CVE-2019-12068)
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Bugs SysSec <bugs-syssec@rub.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 08, 2019 at 12:03:40PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When executing script in lsi_execute_script(), the LSI scsi
> adapter emulator advances 's->dsp' index to read next opcode.
> This can lead to an infinite loop if the next opcode is empty.
> Exit such loop after reading 10k empty opcodes.
> 
> Reported-by: Bugs SysSec <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/scsi/lsi53c895a.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 10468c1ec1..c23a40525e 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -1132,7 +1132,10 @@ static void lsi_execute_script(LSIState *s)
>  
>      s->istat1 |= LSI_ISTAT1_SRUN;
>  again:
> -    insn_processed++;
> +    if (++insn_processed > 10000) {
                              ^
Since we are using this "magic" number in several lines,
should we define a macro?

Thanks,
Stefano

> +        s->waiting = LSI_NOWAIT;
> +        goto exitloop;
> +    }
>      insn = read_dword(s, s->dsp);
>      if (!insn) {
>          /* If we receive an empty opcode increment the DSP by 4 bytes
> @@ -1569,6 +1572,7 @@ again:
>              }
>          }
>      }
> +exitloop:
>      if (insn_processed > 10000 && s->waiting == LSI_NOWAIT) {
>          /* Some windows drivers make the device spin waiting for a memory
>             location to change.  If we have been executed a lot of code then
> -- 
> 2.21.0
> 
> 

-- 

