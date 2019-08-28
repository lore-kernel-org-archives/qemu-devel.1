Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C552BC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A10B20828
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A10B20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2uRj-0006xl-O4
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i2uR4-0006Rd-Mh
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i2uR3-0002yo-Pv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:40:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i2uR3-0002yH-Kx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:40:13 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C76CD81DE8
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 09:40:12 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id h3so1051993wrw.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 02:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Dpxw3oL8qVA2Oy6/uIQWU8w4JuVpqciyayeXWgluncY=;
 b=NYaWUwJ577zKrhgfH5w9WD/HlBoPFunir5l0alqe/e0PvHBAmkgfXP5QLrylhUMYys
 q2uCoApDjRMo9TicFdzCVOb8XGcp08n+qrZPKOMrqdF3sszqZGBtG6gs4d7nepvp6JI2
 Xmcxk/FMicud177aiC/ZL1ZpY8PJkodfONOoSNeQ8/ZhfzAahkxukILj+ZXcuTN3Lj6D
 cIt4s8GtxUxnn8+uKebr12iVI66ZUwk2on2yoklNRJaGUisC1gm0EnqFv+9x/XEfGp2c
 YmrnJt0oTY8hwYb9P7ii1ek5YXt7JonAC8Tq6rkV6sWc9vEUq/gcRhRmFU7yrGBNyqjy
 N0pQ==
X-Gm-Message-State: APjAAAUI0dJ3arxVOIMtt1x5jtP7jtGYtrYkQ8I7GYvcRKZ40JPprc8U
 zlPYYDncoVtll+gzbFuP6pyvuLjCzAgn6qY8Gfp16KMoGvbbvpe5DyDyNcXIEPho8Vbr0Dku1dG
 Bi9jtc/2GQbZaojw=
X-Received: by 2002:a7b:c214:: with SMTP id x20mr3619239wmi.11.1566985211196; 
 Wed, 28 Aug 2019 02:40:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysldRCVDDwnbCjvtejLDegE/uYUEbOs8hGfKpz+U4LGtD08xfbVbzn9uT7BAvr2alT35KaZw==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr3619206wmi.11.1566985210943; 
 Wed, 28 Aug 2019 02:40:10 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id s64sm5710272wmf.16.2019.08.28.02.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:40:10 -0700 (PDT)
Date: Wed, 28 Aug 2019 11:40:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190828094008.6lka45ugpa3iz4nl@steredhat>
References: <20190815132651.22410-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815132651.22410-1-stefanha@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add Stefan Hajnoczi as
 vhost-vsock maintainer
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
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 02:26:51PM +0100, Stefan Hajnoczi wrote:
> A MAINTAINERS entry wasn't added when this code was merged.  Add it now
> so that scripts/get_maintainer.pl works for vhost-vsock.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

