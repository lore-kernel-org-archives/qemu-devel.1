Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5660C00307
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:14:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E27F21920
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 08:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E27F21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Ep2-000212-NX
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 04:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7EoP-0001bb-1T
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7EoN-00070y-Us
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:14:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7EoN-00070b-PP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 04:14:11 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B73424E832
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 08:14:10 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id c188so4145752wmd.9
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 01:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Lvon5AxfR3twsdlZjqV3M9LLrpUJdL+r+EHINDHqQ7s=;
 b=AidYcEA9LE+w9qp1F6tNaovk1+W5KK4pBs8I4Ot/v35B6zmzSrERgHdF2Q5BZecMZP
 ErPT1CgQklQTUOBBDtuJ22KlsofvyqIyqmldZ3dLhLP5l2I3bS+ubNJkbQp/DW8YamgA
 YaTBal87xc/TExT5m56b41oNRTJ8UNshVZbjRfgtfyeN/0EzwnSWC/GClaNWP9dPMJYZ
 OvLPlMMKrtils5eJwfTTJIUevmWmM7ThFAtgfophwVGLldWTDEEFIGFWYWZFTUmY+zl8
 HW8Kji2iCeMxvQCGvEfb2qhg5ca5UWdub1muUVmhMmsg5X3YJRM1zOoVJT34YbmqPEkA
 fSvg==
X-Gm-Message-State: APjAAAUfiq/lYddS0YX/BibYTwhi+rLV3rnVQ2SfClXU2u4m94OkJEBf
 usWUFLmJaxiOFu58YQqcFBYWBBnxi8+0q/hBdWbugWMmbcvxQrEoxC2eVuutowgZBKMUl2mxlyG
 8xcKywFI9SkGMGE4=
X-Received: by 2002:a5d:6612:: with SMTP id n18mr7614900wru.314.1568016849516; 
 Mon, 09 Sep 2019 01:14:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwfODM6WbInczzM0akynKlyWgJrY2emRxEqecZdTRI2BlwtJBJO3zkjQhA2wDGAv0UBcnDdeg==
X-Received: by 2002:a5d:6612:: with SMTP id n18mr7614887wru.314.1568016849318; 
 Mon, 09 Sep 2019 01:14:09 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id s3sm10590616wmj.48.2019.09.09.01.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 01:14:08 -0700 (PDT)
Date: Mon, 9 Sep 2019 10:14:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190909081406.kebhiuxfz74c2ihb@steredhat>
References: <20190908104816.20713-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908104816.20713-1-laurent@vivier.eu>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: remove useless variable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 08, 2019 at 12:48:15PM +0200, Laurent Vivier wrote:
> filename is only used to open the file if AT_EXECFD is not provided.
> But exec_path already contains the path of the file to open.
> Remove filename as it is only used in main.c whereas exec_path is
> also used in syscall.c.
> 
> Fixes: d088d664f201 ("linux-user: identify running binary in /proc/self/exe")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/main.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

