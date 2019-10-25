Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C73CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC22221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC22221D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy9Q-00006x-1o
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNy7L-0005bj-Pa
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNy7K-00040a-A1
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:50:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNy7K-000407-4X
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:50:54 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2E4EC08EC00
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 11:50:52 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id n34so1768135qta.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z9kJkoKPJIxbH8oaC1j6IRx5xtVo3P4xk5m8p6ybXvI=;
 b=CqdXGdWH+6p7XhgKanWQ3kd6n5cSHYY9QBl3Yc6qmxnS79bpGgNtILcLjX/Udl6T6S
 0bSjS2MrAlcwi2LCHAngpzd9lW40aUVU7ZEOD9EXrdD/5iSfw1wruy4d0H3Qfl5OAekI
 lHct3xUv2OatUwK8qcG4+T92SOAnSytYUAxwlQmdqTp8NBUVa5MOt6yQMvi2LsMwxnn1
 YnIKn27ocX9zSfymS/ZQ+6s63BgvzktHmcFONgPwOXfdOskDt8Y5rex13cUbJj8yRKm1
 XRpFD3i6LNlxdrnOSqQwuYDzwvvJR5SDMDwv2uJvJcx7vyJolqn+QnFsL2yMsE7+Qf3s
 qvKQ==
X-Gm-Message-State: APjAAAXBlOhO/1HARYK4F+pPsZ3WTUN6F//juY5AKm2hhRcNnHMV6sT7
 FMyPdgIupfo88sjL2iW7IKK6ag5jOetuGn9Zh0jTRXQqKj0UWNtTGe1qurvV/DW4cWWOOfroiIs
 WGl2MGSs3Fq390vU=
X-Received: by 2002:ac8:1346:: with SMTP id f6mr795718qtj.46.1572004252108;
 Fri, 25 Oct 2019 04:50:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8iKX6WzPGrpb9Ofp5bFJ0GevwqThQdslGjhes+fPLrNejOu5cJJZpUQgiHzqVjTswWoMXHA==
X-Received: by 2002:ac8:1346:: with SMTP id f6mr795709qtj.46.1572004251949;
 Fri, 25 Oct 2019 04:50:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 t65sm1051854qkh.23.2019.10.25.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:50:51 -0700 (PDT)
Date: Fri, 25 Oct 2019 07:50:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] more rcu_read_(un)lock conversions
Message-ID: <20191025075035-mutt-send-email-mst@kernel.org>
References: <20191025103403.120616-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025103403.120616-1-dgilbert@redhat.com>
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 11:34:01AM +0100, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Hi,
>   Two more rcu_read_(un)lock conversions around
> virtio stuff.
> (to go with, but independent of my previous 'virtio: Use auto rcu_read macros')
> 
> I like the way that the virtio-net case simplifies the function
> a lot.

Indeed, I'll queue this.

> Dr. David Alan Gilbert (2):
>   virtio/vhost: Use auto_rcu_read macros
>   virtio_net: use RCU_READ_LOCK_GUARD
> 
>  hw/net/virtio-net.c | 7 ++-----
>  hw/virtio/vhost.c   | 4 +---
>  2 files changed, 3 insertions(+), 8 deletions(-)
> 
> -- 
> 2.23.0

