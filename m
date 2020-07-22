Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F68C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE1520771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 12:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqJngLkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE1520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDXo-0003tv-Gk
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 08:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDSu-0008Op-2g
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:03:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45039
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDSr-0005aR-GW
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 08:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595419392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnE8+G8xmw59yOqGwZx78IPncWOMXEACp1KU/ypc+B4=;
 b=HqJngLkcJyzWoqc5Auomw7rvUcjjm6RDhP5rGTOtWSRLilCyLJ94jgZB6oSUewaPSICsZe
 9LnVzdVGHPhfTpywqJmQlr45j5O7PAvqlwln/Cl/ZafupKjQ9s8b428BDa4p5hZ9lOxl83
 M0XHSVhMmpsa5s4IE1lrNjvFdZnTRkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-dAhmwl2kNQiKTNtisCJXDw-1; Wed, 22 Jul 2020 08:03:00 -0400
X-MC-Unique: dAhmwl2kNQiKTNtisCJXDw-1
Received: by mail-wr1-f71.google.com with SMTP id m7so536580wrb.20
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 05:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PnE8+G8xmw59yOqGwZx78IPncWOMXEACp1KU/ypc+B4=;
 b=Rn1NM7HfnGXV7g4/gqDvzC0fPrEl4D+FRWT+rEX+vAErYQZS5ySYIK2foK5BCgKOXV
 BM+cyLLmCcwY8SOjbcFod7UqIvC1G9U8binSKiDrL51o69KoebTsZ/ZY/H2RXOIhHx9b
 OxMxpHmOKia/idp8G2iK0w1qA5vVwGxmL6+83mViS1fnSqDR1AIWirZwhGlsCS9K3OJi
 QPOk3d2Hobzwv4Oq0PM1QPsMo4z4s4s0+ir75ezFwNoP1LuxF4WjT+Fptu1QRKks0FRl
 FIz0Q3KcuXJ7roE8+577wkQIBGOIsIozT3Q9ZmQOy9030IvlM+p9AF11FRBfYhRTgNNx
 9/Mg==
X-Gm-Message-State: AOAM5309o9xgIhm7pK1Qy5aqRsSS3jm5NJmkPba30gO7ejINHtD08CBy
 /xRH1sW46Se/xlyTDR0h5jZYl2LXpJjJlEMCQDYhBifMQU7sE2aMVn8yXzZatOQ9W7t+wt8GwsN
 fyzLWMPoADq0XDCU=
X-Received: by 2002:adf:e60a:: with SMTP id p10mr12688325wrm.312.1595419379633; 
 Wed, 22 Jul 2020 05:02:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlBcj4o4W6caHbEiKuX08OEtcEn1US/f86smnJi8H8oo/wggPrr8WVUMjmCc+qMFt3Ouk4Fw==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr12688309wrm.312.1595419379441; 
 Wed, 22 Jul 2020 05:02:59 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 k126sm7666197wme.17.2020.07.22.05.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 05:02:58 -0700 (PDT)
Date: Wed, 22 Jul 2020 08:02:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH for-5.1] acpi: accept byte and word access to core ACPI
 registers
Message-ID: <20200722080234-mutt-send-email-mst@kernel.org>
References: <20200720160627.15491-1-mjt@msgid.tls.msk.ru>
 <20200722072414-mutt-send-email-mst@kernel.org>
 <f928d1ed-d71a-c02b-bc4c-8049589aca2a@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <f928d1ed-d71a-c02b-bc4c-8049589aca2a@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Wed, Jul 22, 2020 at 03:00:15PM +0300, Michael Tokarev wrote:
> 22.07.2020 14:24, Michael S. Tsirkin wrote:
> > On Mon, Jul 20, 2020 at 07:06:27PM +0300, Michael Tokarev wrote:
> >> All ISA registers should be accessible as bytes, words or dwords
> >> (if wide enough).  Fix the access constraints for acpi-pm-evt,
> >> acpi-pm-tmr & acpi-cnt registers.
> >>
> >> Fixes: 5d971f9e67 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
> >> Fixes: afafe4bbe0 (apci: switch cnt to memory api)
> >> Fixes: 77d58b1e47 (apci: switch timer to memory api)
> >> Fixes: b5a7c024d2 (apci: switch evt to memory api)
> >> Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
> >> Buglink: https://bugs.debian.org/964793
> >> BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
> >> BugLink: https://bugs.launchpad.net/bugs/1886318
> >> Reported-By: Simon John <git@the-jedi.co.uk>
> >> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > 
> > Queued, thanks!
> 
> Michael, please add Cc: stable@ for this. Many people suffered due to
> this already, it's enough of that ;)
> 
> Thanks,
> 
> /mjt

I did that, thanks!



