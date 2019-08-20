Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2560C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 04:54:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C3F20C01
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 04:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C3F20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzwA0-0002Bv-Mk
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 00:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzw8t-0001Mc-Lx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 00:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzw8r-000669-Gy
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 00:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzw8r-00065M-6d
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 00:53:09 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DFB64627A
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 04:53:07 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id d6so3312075pls.17
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 21:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7OAkatFtL3uV9O1KjVgASVF8+d2XpEtjZ+CJJQ33G+M=;
 b=AesEp8GZ2nNX64XPAWI+maN3MIZ1p0Lngh/1ADTUwVMjCSPugus4xpBqhoybXSOiHD
 y/IkVnxNN45NQ5//1GtwdjZSrHZj8kFLa4vU6+vfmLIUT4s7X0zSvPPSjPOjmOsV73S+
 HeAhrAKr2H6IK7en4LsZ5FJiqchsSDT+BY4l12sxg7dpuqew0yxU+9EH3zxxBjN7HE3Q
 uPVpyZUsdYD5nnRJ0xNupBGAlz4Lned1TsaWfirxswaw7DUK32nzjPV6FCBNQuGkEo6b
 IIC7KeQZV6Rxndqb33C5w9pdDsAiaRAMKQ/sOownvjIWvu5BI3TqzZMEkUQ76pr7fCn8
 v/5g==
X-Gm-Message-State: APjAAAV7xaR8bSGvOJuFrMfaW3ZlKG4Jiz6N8i378Do/oCgicxVSzyJo
 ByQCDCCDHuT/mskq/zLsmEap2iAYMp4FRV/OHO5dEik4ELET8fPtrxu+w2a2A96nUCvwbLYiQkY
 Ub7FfvhnaGJzllro=
X-Received: by 2002:a17:902:b094:: with SMTP id
 p20mr5907473plr.320.1566276786642; 
 Mon, 19 Aug 2019 21:53:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6KOkpjqOpNxGIXb7/ZVrXlqY53BToGhJ/yLNu5IOwV356TQLCgWbD0CXINf4wQhKeCbfV9w==
X-Received: by 2002:a17:902:b094:: with SMTP id
 p20mr5907456plr.320.1566276786383; 
 Mon, 19 Aug 2019 21:53:06 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o67sm6997207pfb.39.2019.08.19.21.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 21:53:05 -0700 (PDT)
Date: Tue, 20 Aug 2019 12:52:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190820045256.GF13560@xz-x1>
References: <20190817093237.27967-1-peterx@redhat.com>
 <20190817093237.27967-2-peterx@redhat.com>
 <da9a1a0d-749b-a81d-fc9a-af6ff2775be8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da9a1a0d-749b-a81d-fc9a-af6ff2775be8@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] memory: Replace has_coalesced_range
 with add/del flags
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 04:30:45PM +0200, Paolo Bonzini wrote:
> On 17/08/19 11:32, Peter Xu wrote:
> > The previous has_coalesced_range counter has a problem in that it only
> > works for additions of coalesced mmio ranges but not deletions.  The
> > reason is that has_coalesced_range information can be lost when the
> > FlatView updates the topology again when the updated region is not
> > covering the coalesced regions. When that happens, due to
> > flatrange_equal() is not checking against has_coalesced_range, the new
> > FlatRange will be seen as the same one as the old and the new
> > instance (whose has_coalesced_range will be zero) will replace the old
> > instance (whose has_coalesced_range _could_ be non-zero).
> > 
> > To fix it, we don't cache has_coalesced_range at all in the FlatRange.
> > Instead we introduce two flags to make sure the coalesced_io_{add|del}
> > will only be called once for every FlatRange instance.  This will even
> > work if another FlatRange replaces current one.
> 
> It's still a bit ugly that coalesced_mmio_add_done ends up not being set
> on the new (but equal) FlatRange.
> 
> Would something like this work too?
> 
> diff --git a/memory.c b/memory.c
> index edd0c13..fc91f06 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -939,6 +939,7 @@ static void address_space_update_topology_pass(AddressSpace *as,
>              /* In both and unchanged (except logging may have changed) */
>  
>              if (adding) {
> +                frnew->has_coalesced_range = frold->has_coalesced_range;
>                  MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_nop);
>                  if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
>                      MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, log_start,

This seems to be a much better (and, shorter) idea. :-)

I'll verify it and repost if it goes well.

Regards,

-- 
Peter Xu

