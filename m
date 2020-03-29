Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F39C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 12:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3E4206DB
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 12:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgwvEh0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3E4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIXL8-0002Zl-C4
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 08:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jIXKW-00029b-51
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 08:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jIXKU-00017A-9v
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 08:46:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jIXKU-00016W-3h
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 08:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585485977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQrfLAQwnZwjD7aAT7gTbBg+pG71R9XuT9C4d5fYJ9w=;
 b=fgwvEh0ysTZBsZ9QZCHQHhdTMvJXFugGp0yTzwEuqYe3dlwsdEQGT42BsodFmR1InCEoSI
 2zwNZ/xMmbWd/wN2Ollhz3Wjno1ZEuiDD/c/kE4aMf7h5woDSPYGTU3IOOgbpI5j6b5Ld1
 BR6hJZOSTqS35M4SD5/Civ/57szwgeY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-XuL8t2zSM0SVFwvvnC-E7w-1; Sun, 29 Mar 2020 08:46:15 -0400
X-MC-Unique: XuL8t2zSM0SVFwvvnC-E7w-1
Received: by mail-wr1-f71.google.com with SMTP id d17so8355485wrs.7
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 05:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O6H48B9l2kL1FyHaYES3sjrAb5ABS+R/nVcgEgMTkNs=;
 b=XbzmMce2d68xlC43etUcf9E2sy13AD3RAWI0Anqo21fUNbo2thJv8vvQtODpjwyUhi
 QeVt45ZKshAnFPVh3RLvzAM7W6X/N7L6vLbI4ck8V6LtiNiJCzE7k2KR0I1XuqX2dh07
 Oc2ga8HI+txuuD3paD0ywb4io1lQjCzheMhAL9Mscpd4kPo0B4+wSXSSJwDpd/0xLEy1
 D6u3q24FigjWAm4wRZVz1snehRAhmnQb8razVHBoPVYFM1Lz8DNJYmairmljfdleiPGP
 7xwHyVMH7jLRFxBCY/CgdEO/3Z2VeOtAlJKtYJ7CEF9Ua4EzSc9WAMgTHnfPG7TdcC0W
 U0ng==
X-Gm-Message-State: ANhLgQ0h3TvT9OQOb4eZ0l2UFfOt2LeaWoFqcmrlaEFCyt3WYjElREVD
 ASQqBhimnym+mgM/bjvxHDjpywt4xw2g7ovWYe1nZjpeDEPsP7HZW0kiynI28KXmQ6Gd3HBkAFP
 T/3l6nSRdUEmgqAQ=
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr10448893wrp.276.1585485974116; 
 Sun, 29 Mar 2020 05:46:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvznKj5wC88LKiowE/Y0cMGxoMcjIqzYa8VSR71N/M2f6Czvn1FR5de5kvsQ4BryS+FddRkGA==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr10448878wrp.276.1585485973943; 
 Sun, 29 Mar 2020 05:46:13 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net.
 [79.183.139.129])
 by smtp.gmail.com with ESMTPSA id t12sm19011386wrm.0.2020.03.29.05.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2020 05:46:13 -0700 (PDT)
Date: Sun, 29 Mar 2020 08:46:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/6] acpi: i386 tweaks
Message-ID: <20200329084524-mutt-send-email-mst@kernel.org>
References: <20200327121111.1530-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200327121111.1530-1-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Fri, Mar 27, 2020 at 01:11:05PM +0100, Gerd Hoffmann wrote:
> First batch of microvm patches, some generic acpi stuff.
> Split the acpi-build.c monster, specifically split the
> pc and q35 and pci bits into a separate file which we
> can skip building at some point in the future.
>=20
> Also some small refactorings and simplifications.
>=20
> take care,
>   Gerd


I'd like to queue it for merge after the release. If possible
please ping me after the release to help make sure it didn't get
dropped.

Thanks!

--=20
MST


