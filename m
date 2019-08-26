Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2606DC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:04:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECED20874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECED20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i29z9-00042M-Sn
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 04:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i29wz-0002jL-Ir
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i29wv-0007mi-Qb
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i29wv-0007j4-LF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:02:01 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D1FD7EBBD
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 08:02:00 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id f9so9319084wrq.14
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 01:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DRzhPJMKRfprIwg0JGxys3+5anP+yXb8kIiRxeJGw6c=;
 b=Hsbua2gk7C8JelZ6Z6lQVOZRTAPAx7RO8bV6v9HehPNbftzt0+6GomtrKIC0jeaTC1
 UKghQQEPdbRFw1xesttjF/ilQrUrE5vPNdzkA8NdlEpSELwMn2g59kWYmydYYMXBABq4
 6YWGPc1tVj2XtnE8WSsHdVZ/WWXjlBK9LnTdKryRMcJpkDabUi4HgJ+yLgb+bQBmQxCS
 sHmYQo7UxbkqX2huHFBzsazUA5Cuvv36bnumd74sOvXfRTpHTO/O5R5LI/1W2AyrqipG
 x6BMhjHh1AMwCBzfzZZbaogCtq+Z5QitAwkZSJvLYCvVcCcy25m7mF1WUMwH8oEE7Ml9
 JGnw==
X-Gm-Message-State: APjAAAVwk7Rz5dsc/LSl1m1LbJCMVkXY3BLf2EDLqCVo8CjNfUueyDhd
 nyw3FT5JhOG2AIKbewHRVHwfXp7bkM1z1rKpJ2DdKHJmEYzkm5fPtI9Om4vZi9YMXD1KzbLcTaS
 sGRUiHu6ZTMOPqF8=
X-Received: by 2002:a1c:6385:: with SMTP id
 x127mr20108409wmb.140.1566806518925; 
 Mon, 26 Aug 2019 01:01:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9qlY2Xps7RzsEGV3u366/F4ql1VEgwMF3Dci195Y4bopnF6cE0xq79K8P2ESoG/Mr3hQ/EA==
X-Received: by 2002:a1c:6385:: with SMTP id
 x127mr20108377wmb.140.1566806518654; 
 Mon, 26 Aug 2019 01:01:58 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id u130sm21969948wmg.28.2019.08.26.01.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 01:01:58 -0700 (PDT)
Date: Mon, 26 Aug 2019 10:01:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190826080155.xpz6ykzpc7o6wqmi@steredhat>
References: <20190823103946.7388-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823103946.7388-1-dgilbert@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qemu-file: Rework old qemu_fflush comment
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 23, 2019 at 11:39:46AM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Commit 11808bb removed the non-iovec based write support,
> the comment hung on.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/qemu-file.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index e33c46764f..075faf03c3 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -201,9 +201,8 @@ static void qemu_iovec_release_ram(QEMUFile *f)
>  /**
>   * Flushes QEMUFile buffer
>   *
> - * If there is writev_buffer QEMUFileOps it uses it otherwise uses
> - * put_buffer ops. This will flush all pending data. If data was
> - * only partially flushed, it will set an error state.
> + * This will flush all pending data. If data was only partially flushed, it
> + * will set an error state.
>   */
>  void qemu_fflush(QEMUFile *f)
>  {

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

