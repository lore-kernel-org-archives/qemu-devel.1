Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F91C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D152067D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fihlcpE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D152067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUe4-00020R-QI
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jwUdS-0001bL-6X
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:59:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jwUdM-0005uE-LT
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595008734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPfHIKH3lDaSBPbtpdZXYgS5LyrVF9Ywdxxjrx3Dz6w=;
 b=fihlcpE283RbqyEM1410k0Efm/RViYzxJFwuEE4BgAqjyHsIUOoa9eNTHU+p2JLTa6K2kC
 nYdOHp15Ruai9yzxZxEOVeO/2QLZSvUMQ6e2/au6ek+wGNjcJRSi4JymfePI3xQcnFYBtd
 0+iAGR1FExPxwhJNZiDYxcaGKgDllCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-6p2guIP_M7-E93yL-r60kw-1; Fri, 17 Jul 2020 13:58:52 -0400
X-MC-Unique: 6p2guIP_M7-E93yL-r60kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFAD2800464
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 17:58:51 +0000 (UTC)
Received: from work-vm (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 26B305C298;
 Fri, 17 Jul 2020 17:58:43 +0000 (UTC)
Date: Fri, 17 Jul 2020 18:58:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2] virtiofsd: Remove "norace" from cmdline help and docs
Message-ID: <20200717175841.GC3294@work-vm>
References: <20200717121110.50580-1-slp@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200717121110.50580-1-slp@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Miklos Szeredi <mszeredi@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Sergio Lopez (slp@redhat.com) wrote:
> Commit 93bb3d8d4cda ("virtiofsd: remove symlink fallbacks") removed
> the implementation of the "norace" option, so remove it from the
> cmdline help and the documentation too.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks; I've added it for my list for the next virtiofsd pull.

> ---
> v2:
>  * Drop "norace" from the documentation too (Stefano Garzarella)
> ---
>  docs/tools/virtiofsd.rst | 3 ---
>  tools/virtiofsd/helper.c | 2 --
>  2 files changed, 5 deletions(-)
> 
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index 824e713491..58666a4495 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -63,9 +63,6 @@ Options
>      Print only log messages matching LEVEL or more severe.  LEVEL is one of
>      ``err``, ``warn``, ``info``, or ``debug``.  The default is ``info``.
>  
> -  * norace -
> -    Disable racy fallback.  The default is false.
> -
>    * posix_lock|no_posix_lock -
>      Enable/disable remote POSIX locks.  The default is ``posix_lock``.
>  
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index 3105b6c23a..7bc5d7dc5a 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -159,8 +159,6 @@ void fuse_cmdline_help(void)
>             "    -o max_idle_threads        the maximum number of idle worker "
>             "threads\n"
>             "                               allowed (default: 10)\n"
> -           "    -o norace                  disable racy fallback\n"
> -           "                               default: false\n"
>             "    -o posix_lock|no_posix_lock\n"
>             "                               enable/disable remote posix lock\n"
>             "                               default: posix_lock\n"
> -- 
> 2.26.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


