Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA5BC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C8720665
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C8720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBHxJ-00013U-4l
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 08:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iBHtL-0005lI-VM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iBHtK-0005SR-V9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iBHtK-0005S4-Q9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 08:20:02 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24E843CBC1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 12:20:02 +0000 (UTC)
Received: by mail-pf1-f199.google.com with SMTP id s137so4523266pfs.18
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 05:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YT2+U48YiKgtkGoqkCAOaECo64sYneHhTOhAaskmRrA=;
 b=rNm37Mw01lpWzrgNzMhBX/nZxfuE7vHiBDzYrRJ+r2lJ6Km0W/g6QO5pfV30p8esn9
 rsqj8EmLgYgdiAffAHU+Slwu/dJceMnYD+OMjgXDfVnW2fIUabQjaiurq2reBncq3QG0
 YyekVZP2Eulf2EVuirLIVDrHay53jrFqREMybRwZZBZXKMqpDVV35PC+yOMkt3LzZj8O
 OWkjU2JY0AnDNA8DCbs5f1077pD8GfpvZPEApiACoOOU3e65BTZjqv2BlG6RV5m0Wu3x
 qDIY6+PFFUm+TjcVzdRMRmbYGwe/ZbwU70bkW5lxYfTb0BYUuo9J6BhreGzQVzWhouL/
 j+rQ==
X-Gm-Message-State: APjAAAWnhLWl2Wu77bKdotnnCzE5JVVhCMBx1bMbWG35v5KGigeVXrFo
 0cFGJ2/9EY5S7Jn4DEYQcdqLheBq2gXfpfYFDVCOgDqC5vOI0PzGV60VZwY6MuZH/7Rs0o8UXx6
 durrHREpYHOLAHRo=
X-Received: by 2002:a65:654d:: with SMTP id a13mr14778753pgw.196.1568982001623; 
 Fri, 20 Sep 2019 05:20:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvBosqGtje+xCGaMxa10ni9bDpuPqObzsTcsGCJcLEH2LWsD6008HD6lJ5vx3Br139qA/AGA==
X-Received: by 2002:a65:654d:: with SMTP id a13mr14778736pgw.196.1568982001413; 
 Fri, 20 Sep 2019 05:20:01 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d14sm5749076pfh.36.2019.09.20.05.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 05:20:00 -0700 (PDT)
Date: Fri, 20 Sep 2019 20:19:51 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] kvm: clear dirty bitmaps from all overlapping memslots
Message-ID: <20190920121951.GI12858@xz-x1>
References: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 12:21:20PM +0200, Paolo Bonzini wrote:
> A single ram_addr (representing a host-virtual address) could be aliased
> to multiple guest physical addresses.  Since the KVM dirty page reporting
> works on guest physical addresses, we need to clear all of the aliases
> when a page is migrated, or there is a risk of losing writes to the
> aliases that were not cleared.

(CCing Igor too so Igor would be aware of these changes that might
 conflict with the recent memslot split work)

-- 
Peter Xu

