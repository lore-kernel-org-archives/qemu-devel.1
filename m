Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE18C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F3020639
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7+j9uVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F3020639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95hW-0001Dq-IA
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k95gz-0000nd-QU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k95gw-0004mR-TN
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598011120;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LAeJCt28bCWLCYzYJAbGe5IWKS5xmoN489M8mJ2sTFM=;
 b=g7+j9uVovJoqhcJS/7QoC5EFlJIWVK7aXXTEc4mBEOy9Ir3P9ZVkQgctwcDzmyHdYNj3zL
 S0ZOfHC4bQ+W5e098cayX3e8dtUcZeUuPBhwCODLuJYbxhb5Bw+LtkW8PiKXI5PQF9XZ2x
 IrJxftXfAPZLNaS+L1d/f2FzJ844c+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-v6oXekpAO1WSQD7Zof4Qpw-1; Fri, 21 Aug 2020 07:58:39 -0400
X-MC-Unique: v6oXekpAO1WSQD7Zof4Qpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E9D110082E0;
 Fri, 21 Aug 2020 11:58:38 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7CAA7BE99;
 Fri, 21 Aug 2020 11:58:32 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:58:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [PATCH] virtiofsd: add -o allow_directio|no_directio option
Message-ID: <20200821115829.GJ348677@redhat.com>
References: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20200821034126.8004-1-zhangjiachen.jaycee@bytedance.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 11:41:26AM +0800, Jiachen Zhang wrote:
> Due to the commit 65da4539803373ec4eec97ffc49ee90083e56efd, the O_DIRECT
> open flag of guest applications will be discarded by virtiofsd. While
> this behavior makes it consistent with the virtio-9p scheme when guest
> applications using direct I/O, we no longer have any chance to bypass
> the host page cache.
> 
> Therefore, we add a flag 'allow_directio' to lo_data. If '-o no_directio'
> option is added, or none of '-o no_directio' or '-o allow_directio' is
> added, the 'allow_directio' will be set to 0, and virtiofsd discards
> O_DIRECT as before. If '-o allow_directio' is added to the stariting
> command-line, 'allow_directio' will be set to 1, so that the O_DIRECT
> flags will be retained and host page cache can be bypassed.
> 
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  tools/virtiofsd/helper.c         |  4 ++++
>  tools/virtiofsd/passthrough_ll.c | 20 ++++++++++++++------
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..534ff52c64 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -180,6 +180,10 @@ void fuse_cmdline_help(void)
>             "                               (0 leaves rlimit unchanged)\n"
>             "                               default: min(1000000, fs.file-max - 16384)\n"
>             "                                        if the current rlimit is lower\n"
> +           "    -o allow_directio|no_directio\n"
> +           "                               retain/discard O_DIRECT flags passed down\n"
> +           "                               to virtiofsd from guest applications.\n"
> +           "                               default: no_directio\n"
>             );

The standard naming convention from existing options is to use
$OPTNAME and no_$OPTNAME.

IOW, don't use the "allow_" prefix. The options should be just
"directio" and "no_directio"


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


