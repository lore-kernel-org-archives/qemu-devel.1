Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1215C4740A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA97A2081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA97A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cZh-0006Mh-1D
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i7cXF-0003ee-Pn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:34:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i7cXA-0006sC-Ul
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:34:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55098)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i7cXA-0006rr-Ox
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:34:00 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFE01C05AA6F
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 09:33:59 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id o11so8715392wrq.22
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SYE7COlPn95BNBCV0tWUIbdL2rbUaElNph+5wfedMCM=;
 b=noHAd3W8pvP/FUxe965zcdLZM5VLpr9ZKpUbX4tk1NlyBKLCrbNQV5djVGVdXHMhKZ
 XRtTJHpgK7oM5wAsFn2TsfDkV2/TZekPEmwHQSoT2OaeOY3W/ds6AguMa/covXfhUnLG
 yZCyuBUdtgIs8NY5yFozb7M9f7JWG3/7EmeBhdIpM0+zj1KH8duFIjfC9E3KyRF1lziz
 KBcB2qQXeYL4YJMeqWPblXenplCvlHDJGS7py3ASXGADcGhtQMZBdlWXLPdtSjER8wRW
 UWR3Irc6pp2wsEOA7/Ehsj8+k+7vKu51ZQDzl4NHEdGGOVRz0J1U4uHhSwqg2zrk4jfm
 EHrA==
X-Gm-Message-State: APjAAAWTbFMfWeEb2ha9yWaw8ze6jpXwSELd7TGSpQs/pNTUkJN+CVyB
 jJ2YbfVAH/FPW8m5PEYaxpUJo3QGtIZgxdYs0ix5JZMh4aCjmgcME6cQrHWccRx3tmj0yvEp+GS
 i1UtII+MzoE5XoDE=
X-Received: by 2002:adf:8b13:: with SMTP id n19mr5876317wra.203.1568108038599; 
 Tue, 10 Sep 2019 02:33:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzM5n13Zx2PTTgsCgk5aPWioUEdVv2ZXFFGkYo9ymcNnJ8cttD9SUUw7hpqBIC+lwJfnJ0gqQ==
X-Received: by 2002:adf:8b13:: with SMTP id n19mr5876297wra.203.1568108038406; 
 Tue, 10 Sep 2019 02:33:58 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id 17sm8904693wrl.15.2019.09.10.02.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:33:57 -0700 (PDT)
Date: Tue, 10 Sep 2019 11:33:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190910093355.gp6tm3ne35bq3nfe@steredhat>
References: <20190910070949.16256-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910070949.16256-1-kwolf@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-io: Don't leak pattern
 file in error path
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
Cc: dplotnikov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 09:09:49AM +0200, Kevin Wolf wrote:
> qemu_io_alloc_from_file() needs to close the pattern file even if some
> error occurred.
> 
> Setting f = NULL in the success path and checking it for NULL in the
> error path isn't strictly necessary at this point, but let's do it
> anyway in case someone later adds a 'goto error' after closing the file.
> 
> Coverity: CID 1405303
> Fixes: 4d731510d34f280ed45a6de621d016f67a49ea48
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qemu-io-cmds.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

