Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19FFC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDF720659
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 18:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDF720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iId6s-0004nq-O2
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 14:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIcyf-0001VF-Cw
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIcyd-0006pv-9q
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:15:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIcyd-0006pn-49
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 14:15:51 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2BBD19D381
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 18:15:49 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w10so3121673wrl.5
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UcLU747hLHItgLQCPxS96y8bLdrVR9p9K0nLPtjrJRQ=;
 b=AqUpp6kJSBwZl9pJb9VMlEQkIxJXiU3az/NiMX7gZ3aIo03U1MVY234V4a/ZuDNbNE
 J3DXMOFJ531D1XSpzJeJWKwZjiUcGc8PSknLJIhtgG0lz7oSXzJUqDYECc8EOEiFpy7J
 r0VJhs5oRPFO87SQa1LJfkSt9VtBqBzf/qDDDdYuzWyVHVUScsMrBE7iPklGfdkPwMgr
 LkLvr2l7ED1346lXej6hJ/yUZtEiQ73bYQy0O753rBqIVitpMBC03TbztazpbDrzNLFU
 KxFRJ5Q1ucxYB/Sd1SFJcBdU1kLe0a184WdXsa0xWkIJn/GG+nYRQ/C8Lgf+3ujQJKsZ
 l8PQ==
X-Gm-Message-State: APjAAAW9dvNMkh2aEUOhohF91HewES8114JRRyoe2XdiAGANzjpA5B0q
 asEbSJETD3ZAeqjGMTRacORRPe8jP03+tbNA0+oSS3rU6hFs+pLogteBhpWNE4LQvxnHtBaGh1y
 Ey8/RtzpE4LN6sw0=
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr9930524wrw.48.1570731348446; 
 Thu, 10 Oct 2019 11:15:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzvo+6Qm1Xao0a1wmIBWhDyuOCAtW26k26pRuIF5h5PkeMP9BmSxDvYpDzG6Of6qHQhPuNuMA==
X-Received: by 2002:a5d:66cb:: with SMTP id k11mr9930508wrw.48.1570731348259; 
 Thu, 10 Oct 2019 11:15:48 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 36sm9658196wrp.30.2019.10.10.11.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 11:15:47 -0700 (PDT)
Date: Thu, 10 Oct 2019 14:15:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
Message-ID: <20191010140934-mutt-send-email-mst@kernel.org>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
 <20191010095459-mutt-send-email-mst@kernel.org>
 <20191010175754.7c62cf8f@Igors-MacBook-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010175754.7c62cf8f@Igors-MacBook-Pro>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 05:57:54PM +0200, Igor Mammedov wrote:
> > Then we should consider switching acpi to use fw cfg.
> > Or build another interface that can scale.
> 
> Could be an option, it would be a pain to write a driver in AML for fwcfg access though
> (I've looked at possibility to access fwcfg from AML about a year ago and gave up.
> I'm definitely not volunteering for the second attempt and can't even give an estimate
> it it's viable approach).
> 
> But what scaling issue you are talking about, exactly?

Just this: each new thing we add is an ad-hoc data structure with
manually maintained backwards compatibility and no built-in discovery.

fw cfg has built-in discovery and we've finally managed to
handle compatibility reasonably well.

PV is already very problematic.  Spreading PV code all over the place
like this is a very bad idea.  For you CPU hotplug is something that you
keep in mind first of all, but someone bringing up a new platform
already has a steep hill to climb.  Adding tons of custom firmware is
not helping things.

-- 
MST

