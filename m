Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2267CA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 00:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7737E21D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 00:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7737E21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNn3H-0004L5-KH
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 20:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iNn2M-0003RZ-Uz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 20:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iNn2K-0000h9-Q9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 20:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iNn2K-0000gD-Ga
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 20:01:00 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE96EC049E10
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:00:57 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id o9so284396plk.13
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 17:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fgRH57NouE8aqqTQh8zvrQgtnM9KGLwZCv3OrjdyjnQ=;
 b=rvPcxJGQglwP2Pkug+dsknWM3uhmatkMn/PCa/rM5GW/EZkPWGBSru5hzSfee4mH2H
 9Wn5Su654a1lzlo5sVOgmzW7Falfhwx9ZbBLj1XLXZH88rRYkwStFNFMmXDUKCPfDe7o
 z+eRN/XyTJNNuXR1S6eMbKB7XWYncptEXQZRfg4OooZw/+OUePbbtsvpkH6enhGIaxUz
 54oYZcSgHsXat8Ax7fIfOgLKoEUIOVOxauZlFX6L/GMtnvyJoVNacYmo6FFMSVCGnZgP
 OREg4Rfv98pm+2tvwLN/T4Ew7IZpk9OFc0X7N0l+I1EoUcxJchLHmiB5lHGpo+xJQoyP
 gZeA==
X-Gm-Message-State: APjAAAVLVOLznrnhJnkfPvf3xrxWkzXG8r289wsoQkZ6MRA+Ss92cQwx
 CGMnL3JJaJSbk4hR3EgWhVnFuUWZL3ZPhHg4gf/lT9Wm3tLRi3cjFFY4qYfN9pOKUACyTRbzVcb
 S1UX5CeGs25/0FTE=
X-Received: by 2002:a63:778f:: with SMTP id s137mr775017pgc.147.1571961656991; 
 Thu, 24 Oct 2019 17:00:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLj3+WCtDAPudrKNXYA899NSimh24HJVFx032lmhR6Tp+Y39raUlDPBR53pcDhvMka+ZukTg==
X-Received: by 2002:a63:778f:: with SMTP id s137mr774988pgc.147.1571961656544; 
 Thu, 24 Oct 2019 17:00:56 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t3sm237149pje.7.2019.10.24.17.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 17:00:55 -0700 (PDT)
Date: Fri, 25 Oct 2019 08:00:43 +0800
From: Peter Xu <peterx@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 0/4] apic: Fix migration breakage of >255 vcpus
Message-ID: <20191025000043.GB20184@xz-x1>
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016144001.GE4084@habkost.net> <20191019034153.GB9478@xz-x1>
 <20191023075701.GA18443@xz-x1>
 <20191023081750.GA6177@localhost.localdomain>
 <1366742d-dbf4-39f5-179d-26014b13cade@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1366742d-dbf4-39f5-179d-26014b13cade@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Block List <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 01:49:11PM -0400, John Snow wrote:
> 
> 
> On 10/23/19 4:17 AM, Kevin Wolf wrote:
> > The important difference here is legacy IDE (which works) vs. AHCI
> > (which doesn't work). If you add a -device ahci to the -M pc case, it
> > starts failing, too.
> > 
> > Not sure why AHCI fails, but I'll just CC John who is the lucky
> > maintainer of this device. :-)
> 
> Hm... It looks like SeaBIOS is identifying the drive correctly and
> perfectly well, but we're failing at boot_disk(u8 bootdrv, int
> checksig), about here:
> 
> call16_int(0x13, &br);
> 
> if (br.flags & F_CF) {
>     printf("Boot failed: could not read the boot disk\n\n");
>     return;
> }
> 
> Looking at AHCI tracing (From the QEMU side), it looks like we set up
> the drive correctly, and then never touch the port ever again -- I don't
> see an attempted read on QEMU's end.
> 
> I'll need to look through SeaBIOS source for hints, I'm not sure right
> yet. If anyone is more familiar with the SeaBIOS boot code, maybe they
> can give a pointer faster than I'll figure it out myself.

Hi, John,

I don't know seabios well, but I did have a pointer in my previous
email on where it faulted.  It seems to me that the issue is that
SeaBIOS may have got incorrect secs/cyls/heads information (and
explicitly setting secs=1,cyls=1,heads=1 on the block device fixes the
issue).

Thanks,

-- 
Peter Xu

