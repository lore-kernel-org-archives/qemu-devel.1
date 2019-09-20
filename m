Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE3C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78DCB2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DCB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFGM-0000Kc-UO
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iBF8X-0005nI-RH
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iBF0I-0000fd-UT
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:15:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iBF0I-0000el-PU
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:15:02 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42FE97BDA6
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 09:15:01 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v13so2005746wrq.23
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 02:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sNfsJgsIyOv71awToOVs97vuH1M2dMkzbt40tu53VFY=;
 b=KbLz/LekjxJbOcXTW7vc2Wq6WY+QUdoC0GUvNwLTEfLfHRk/+VOQaj6BNFuH/tiIG3
 8oR/zySDJoF24tThz3UhI0yqqXu222maP8Mhp13KIz5twv6GqD+e12YeWB06GuOa7uGy
 4BUR2YmvrXP6fOBEhmnczDTVc9hDk7FV/OdzZR24cJDVj9RQHakokLfo+zUmaHLQIB2h
 3PEEKDu3kslZUU1lGXBijWxa2ONIyns2xryhJo3YeDMURsVD9d9izQkYQ/5cyHQIxy4B
 41jiU9v0jHmLNB6cFi9RWGwcjrux0u/Dp2cWSjB2WIaL+Mw/NKOd2NqoCQdhljkgYkZp
 QDKw==
X-Gm-Message-State: APjAAAUR2RMZAb2KTno8nvrMfq7Y9zt64IctfQ8jZmeYr6hjv3XFVeh2
 b08hNsZEghVByAUcYlXrfIKxrBtzVOFZqUUi5ec/2Twm2+QAddSH4EwQeNkocbVPkdtwd9bgQ35
 QOFeJuq6cTWbXQL8=
X-Received: by 2002:a5d:4611:: with SMTP id t17mr11111405wrq.135.1568970899980; 
 Fri, 20 Sep 2019 02:14:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuK8HjpXuGcJVznGkPu9jTgW7DXy9J7CEvZtOQCRB9iFoP8LlZZrKVT5m25It48Vl8UwLG9Q==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr11111387wrq.135.1568970899776; 
 Fri, 20 Sep 2019 02:14:59 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id g24sm1460163wrb.35.2019.09.20.02.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 02:14:59 -0700 (PDT)
Date: Fri, 20 Sep 2019 11:14:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v2] target/i386: clean up comments over 80 chars per line
Message-ID: <20190920091456.c6r4lcnsts6jw2v7@steredhat>
References: <20190920053136.945-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920053136.945-1-tao3.xu@intel.com>
User-Agent: NeoMutt/20180716
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 20, 2019 at 01:31:36PM +0800, Tao Xu wrote:
> Drop the duplicate definition of CPUID_7_0_ECX_VBMI. And add some
> comments, clean up comments over 80 chars per line.
> 
> There is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD,
> remove the extra enter and spaces.

Might it be better to split this patch into two?

One where you fix the comments over 80 chars rand one where you drop the
CPUID_7_0_ECX_VBMI definition.

Thanks,
Stefano


