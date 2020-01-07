Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DC9C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4012080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 20:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m78ucRXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4012080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iovCw-0001QV-4s
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 15:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iovC3-0000pT-Vx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iovC2-0002q8-QJ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:11:11 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iovC2-0002p0-LE
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 15:11:10 -0500
Received: by mail-ot1-x344.google.com with SMTP id i15so1293136oto.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=//JeRDKzXVuhC5r3zAh0bcMFvLvuTTucMR3ytkVzT0M=;
 b=m78ucRXiQksXRYSAbaVZHvhQYwfyzVSrcmsZtCMIJjwbsoyop8zFJxE9GZuWD45IBQ
 Q2MUbz/axlgt8WyDVD2g2mGWrhqCJjxGhto5yBBoyLtNflaZV4uj6lKnTNu3bAucXZPE
 ChfwXE3GYth4eAQuDNJ432pvU/q0s3nE4Z7UzKUjIuADNbkbPeSdoiamjNihFhg0GLbH
 9Z+Wg6sMn8V3VDyPtseswzLJbhqvpqNH7tatrT6U5LrWbNGT5+2RFlWvfwIyI5T16vdt
 4O+tL+rkfRtvSvYLTj0EnUWWRkDGqn29BxITTSL6Afnl59RESC88GcOjkzhT5QLx2R98
 qIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition:in-reply-to
 :user-agent;
 bh=//JeRDKzXVuhC5r3zAh0bcMFvLvuTTucMR3ytkVzT0M=;
 b=WJ2OwYVaSYMTV2w+uIZKINHv8osD4x6fIpESOu5JjvoxNzw1ZDzW3dYIHqupCJAuYA
 5vKfMlaonJ8b74GfFe4EEvIDNBbVaqyhgdqXa4kY/1C+MbQn6fa+pFTKHAg2O+K++fak
 bz5oAKA+UNoS18k3ZI/dStYCZvDajbLlx9bVmU8AOEanAuEVnP1BUojGdHBPnhMNd0NB
 V65yRty4R4kzZJPH2eXq9aQ+gLPpFgcvKI6D2cnOyqogrsaHZquphsj0mtQ4zXue9c97
 VfQdVf8XB4Nc0ntZ7NXgkkNuGq9N9cbnlcQYaAyart2eIypA03YYH33smZ2urnW3X4fv
 scUw==
X-Gm-Message-State: APjAAAUgKhetJ671teMlqHPhB6MWsuhOhbzjhMr8aDK9UvS6piyxTwlY
 Rw9Fka29+EmCorMOBAYz2g==
X-Google-Smtp-Source: APXvYqwNQ24eLfo9xJj6xEZT8pBM5OEaDmFvb+2ywdV+6xVpUn4jtuZbT9wT8NR7trpH9W37MMfDWQ==
X-Received: by 2002:a05:6830:1691:: with SMTP id
 k17mr1551453otr.282.1578427869198; 
 Tue, 07 Jan 2020 12:11:09 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
 by smtp.gmail.com with ESMTPSA id e65sm243111otb.62.2020.01.07.12.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 12:11:08 -0800 (PST)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8b39:e806:149e:81c8])
 by serve.minyard.net (Postfix) with ESMTPSA id 180F4180050;
 Tue,  7 Jan 2020 20:11:08 +0000 (UTC)
Date: Tue, 7 Jan 2020 14:11:06 -0600
From: Corey Minyard <minyard@acm.org>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] i386:acpi: Remove _HID from the SMBus ACPI entry
Message-ID: <20200107201106.GA2874@minyard.net>
References: <20200106152705.8258-1-minyard@acm.org>
 <20200107175821.72556c39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107175821.72556c39@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Reply-To: minyard@acm.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 07, 2020 at 05:58:21PM +0100, Igor Mammedov wrote:
> On Mon,  6 Jan 2020 09:27:05 -0600
> minyard@acm.org wrote:
> 
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > Per the ACPI spec (version 6.1, section 6.1.5 _HID) it is not required
> > on enumerated buses (like PCI in this case), _ADR is required (and is
> > already there).  And the _HID value is wrong.  Linux appears to ignore
> > the _HID entry, but it confuses Windows.
> 
> Corey,
> 
> Could you clarify as what "confuses Windows" means?
> s/confuses Windows/description of the observed problem and on what windows version/

Yeah, I should have done that.  The error is not given, but the report
says" "It is detected by Windows 10 as 'Unknown Device' and there is no
driver available."  Link is https://bugs.launchpad.net/qemu/+bug/1856724

I'll add that to the text, along with the link.

-corey

> 
> > 
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  hw/i386/acpi-build.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 7b8da62d41..ab73a8f4c8 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1815,7 +1815,6 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
> >      Aml *scope = aml_scope("_SB.PCI0");
> >      Aml *dev = aml_device("SMB0");
> >  
> > -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("APP0005")));
> >      aml_append(dev, aml_name_decl("_ADR", aml_int(devnr << 16 | func)));
> >      build_acpi_ipmi_devices(dev, BUS(smbus), "\\_SB.PCI0.SMB0");
> >      aml_append(scope, dev);
> 

