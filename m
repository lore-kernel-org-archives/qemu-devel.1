Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DF1FC6198
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:03:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC512187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC512187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSdha-00085N-QB
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSdZu-00036Q-9G
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSdZr-0004Ib-U7
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSdZr-00044i-JN
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 03:55:39 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63DF1C057F31
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 08:55:37 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id g5so1768289qtc.5
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 00:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mN14RHBQTacGDmzpXA+VTGfCydp2qDZE5RujK0pXeOs=;
 b=A+DuXNzl4LfsQHNIG4TWnUPopLD45lkXVvEFJ9VCWmGxvsjS0ufSoioTPF44uJfLLV
 VV4Kf5uGd4OxYriNmhW+gberI83Rh25goQgTJVkCmYeasRG9aJwujTzXDXJMC9hsAK+Z
 v8XJGGGBc1xaIs+mHdXqFTqkCNmhMptfUUit/xQIvFEM0ZTg3LzGP6A/Ln6rZS+fX9w/
 0b+p1rnaa5UssdVlFTRkhKHk7MK0Z/Qjxc2aRbmUWVJiP0aHA8peCb6TD3iWfqfExLCT
 Z/Fdp30Z/SIt5q440dOKavqv51Q9jAUjf+FpMZOSXCVjcmDuR0YIODJ3FMgtxvoiQFup
 VXMA==
X-Gm-Message-State: APjAAAXNW8O2Y/SQcC9m8wsaiDH+BEXA6g9sJklHYNkiARxQteeJ6fTh
 6ZD0AUIFls+kJHAPVnGj/04eaqxLjRtzecTky7u/pnJehu3TnhhbYo/ClyMYpc6j4DLl/YjYi5w
 CzAwtP8HASfjwXNc=
X-Received: by 2002:aed:2986:: with SMTP id o6mr2548400qtd.320.1573116936738; 
 Thu, 07 Nov 2019 00:55:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlnlJsQAw+9zgyv8eZYsV98xZFfgQf9HYEGdF4IrS+krSi5LjgMAGA7iSQI8J6J69SXPdtgg==
X-Received: by 2002:aed:2986:: with SMTP id o6mr2548383qtd.320.1573116936472; 
 Thu, 07 Nov 2019 00:55:36 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id s21sm680319qkg.24.2019.11.07.00.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2019 00:55:35 -0800 (PST)
Date: Thu, 7 Nov 2019 03:55:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [RFC v2 02/14] standard-headers: import arm_sdei.h
Message-ID: <20191107035155-mutt-send-email-mst@kernel.org>
References: <20191105091056.9541-1-guoheyi@huawei.com>
 <20191105091056.9541-3-guoheyi@huawei.com>
 <20191106185240.3f5e2c2a.cohuck@redhat.com>
 <059c6396-bbfb-2dd3-f7cc-7c64bc2d3ccb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059c6396-bbfb-2dd3-f7cc-7c64bc2d3ccb@huawei.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 wanghaibin.wang@huawei.com, Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 09:40:49AM +0800, Guoheyi wrote:
> 
> 
> On 2019/11/7 1:52, Cornelia Huck wrote:
> > On Tue, 5 Nov 2019 17:10:44 +0800
> > Heyi Guo <guoheyi@huawei.com> wrote:
> > 
> > > Import Linux header file include/uapi/linux/arm_sdei.h from kernel v5.4-rc5.
> > > 
> > > This is to prepare for qemu SDEI emulation.
> > > 
> > > Signed-off-by: Heyi Guo <guoheyi@huawei.com>
> > > Cc: Peter Maydell <peter.maydell@linaro.org>
> > > Cc: Dave Martin <Dave.Martin@arm.com>
> > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: James Morse <james.morse@arm.com>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > > 
> > > Notes:
> > >      v2:
> > >      - Import arm_sdei.h by running update-linux-headers.sh
> > > 
> > >   include/standard-headers/linux/arm_sdei.h | 73 +++++++++++++++++++++++
> > >   1 file changed, 73 insertions(+)
> > >   create mode 100644 include/standard-headers/linux/arm_sdei.h
> > Just a remark that I find it a bit odd that that a header that looks
> > arm-specific is in the generic linux/ directory (already in the kernel,
> > I know.) Is this for sharing between arm and arm64, maybe?
> I don't think arm platforms will use this header. In section 4.1 of SDEI
> spec, it says " Both the client and dispatcher of SDEI must execute in
> AArch64 state."
> So shall we move it to include/standard-headers/asm-arm64/?
> 
> Thanks,
> HG


Yea, that's because it's used by drivers/firmware/arm_sdei.c, also flat
in the top level hierarchy. It's been like this historically.
If you want to do a small kernel project and reorganize
drivers/firmware/ according to the architecture,
then arm_sdei.h can move too.

Until that happens upstream let's just mirror what kernel does.

> > 
> > 
> > .
> > 
> 

