Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312EEC4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B9E20644
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B9E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iALE4-0006CG-1U
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 17:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iALCt-0005kE-H8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iALCq-0005KL-Lb
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:40:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iALCq-0005K0-GQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:40:16 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F17C9C049E32
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 21:40:14 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id z4so5811940qts.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 14:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a2jH8nz1A2NS/PdEgfxJ5WIEdlG/tIZgMVNkjAOOvd0=;
 b=IyqOzSvWNwVqY+VYEZjwuCs1t3bnCbhz7RT4r9G4znbH60AClPr3GI9ZcC8ktK6THF
 abQmfcX/lW3Atg58pVn9K6vhSqqCTwojFSfju0haBBBLjFu9Dn2cCGWrPxOAOZ1JgTbQ
 ETcA+6nFf185DOwAorDUvV+46Dv5HfneoTPOw3AYE0LGcl/ejtFNjWJn9SHrzecLtv0H
 COcPYDaiWg4ltFWawUltYPylPP77WGMBv4/DDjWZrXkUubU0OeXftb/X1vjZaG7FZtNL
 hhAFwDSXfCeOSzPLXapiI1VxYjvA54tizx47cqQ3/av4wt21xQeO6KveDgeWt8z+R1nq
 jt+w==
X-Gm-Message-State: APjAAAWVlX0Fld2RC2xgwoyqZIw9YrKk3K8WohFyNOpwfzRCJg/dQCXH
 yRld/H+Sp/fBWYQ4P5HI5bV6V5XCWXEokvdrFERx0ee1r5Vn4BQ8jpz1Qw+WLhVzopeUACo0Eor
 YoLxE0w0ttgDMYsM=
X-Received: by 2002:a0c:9638:: with SMTP id 53mr670293qvx.13.1568756414275;
 Tue, 17 Sep 2019 14:40:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztEKu4hDLuKPMkxyl5TySx09MjeZK3SC/x1XdltFK4wpbJSM10V35s3f1UunpE3X73+HjwDw==
X-Received: by 2002:a0c:9638:: with SMTP id 53mr670263qvx.13.1568756413978;
 Tue, 17 Sep 2019 14:40:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id q126sm2176259qkf.47.2019.09.17.14.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 14:40:12 -0700 (PDT)
Date: Tue, 17 Sep 2019 17:40:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Message-ID: <20190917173941-mutt-send-email-mst@kernel.org>
References: <20190917191901.28348-1-amorenoz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917191901.28348-1-amorenoz@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] vhost-user: save features if the char dev
 is closed
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
Cc: ddstreet@canonical.com, Pei Zhang <pezhang@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 09:19:01PM +0200, Adrian Moreno wrote:
> That way the state can be correctly restored when the device is opened
> again. This might happen if the backend is restarted.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1738768
> Reported-by: Pei Zhang <pezhang@redhat.com>
> Fixes: 6ab79a20af3a (do not call vhost_net_cleanup() on running net from char user event)
> Cc: ddstreet@canonical.com
> Cc: Michael S. Tsirkin <mst@redhat.com>
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/vhost-user.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/vhost-user.c b/net/vhost-user.c
> index 51921de443..acf20cb9e0 100644
> --- a/net/vhost-user.c
> +++ b/net/vhost-user.c
> @@ -235,6 +235,13 @@ static void chr_closed_bh(void *opaque)
>  
>      s = DO_UPCAST(NetVhostUserState, nc, ncs[0]);
>  
> +    if (s->vhost_net) {
> +        uint64_t features = vhost_net_get_acked_features(s->vhost_net);
> +        if (features) {
> +            s->acked_features = features;
> +         }

why does it make sense to check if (features)?
0x0 is a valid feature bitmap, isn't it?

> +    }
> +
>      qmp_set_link(name, false, &err);
>  
>      qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
> -- 
> 2.21.0

