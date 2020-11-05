Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D1FC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153E1206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QkL2fK2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153E1206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadUC-0005Dn-2g
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kadSj-0004On-H2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kadSh-00005a-SH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604575789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixGfMGuM0vP3ot5D7PfTPksz3T+ly6SwYNzJdAeo3Aw=;
 b=QkL2fK2OTHaSQppyfUrFphCZUrUrU5TLUHEBCjrQ/g9TYgcSg5Gpf507qqcjP+YX7Y3m5J
 OxJ9mUvUrBwtgLDxzCZrk4e2twYscp3kW++DpMhsDPYUB7as7GB5ZrhuUejfgQtHVZcNzk
 m9OWTmZpObC/wXRXuStkNzwWdI2AV7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-fFOjCpp1MTyYJCYh5dQn5Q-1; Thu, 05 Nov 2020 06:29:45 -0500
X-MC-Unique: fFOjCpp1MTyYJCYh5dQn5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4C2935A10;
 Thu,  5 Nov 2020 11:29:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-31.ams2.redhat.com
 [10.36.114.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A685C3E0;
 Thu,  5 Nov 2020 11:29:42 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] block: Fixes nfs compiling error on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org
References: <20201013001545.1958-1-luoyonggang@gmail.com>
 <20201013001545.1958-2-luoyonggang@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9582005a-1248-6a6b-060f-b0da597bc9c9@redhat.com>
Date: Thu, 5 Nov 2020 12:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201013001545.1958-2-luoyonggang@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13.10.20 02:15, Yonggang Luo wrote:
> These compiling errors are fixed:
> ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>     27 | #include <poll.h>
>        |          ^~~~~~~~
> compilation terminated.
> 
> ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>     63 |     blkcnt_t st_blocks;
>        |     ^~~~~~~~
> ../block/nfs.c: In function 'nfs_client_open':
> ../block/nfs.c:550:27: error: 'struct _stat64' has no member named 'st_blocks'
>    550 |     client->st_blocks = st.st_blocks;
>        |                           ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:751:41: error: 'struct _stat64' has no member named 'st_blocks'
>    751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>        |                                         ^
> ../block/nfs.c: In function 'nfs_reopen_prepare':
> ../block/nfs.c:805:31: error: 'struct _stat64' has no member named 'st_blocks'
>    805 |         client->st_blocks = st.st_blocks;
>        |                               ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:752:1: error: control reaches end of non-void function [-Werror=return-type]
>    752 | }
>        | ^
> 
> On msys2/mingw, there is no st_blocks in struct _stat64 yet, we disable the usage of it
> on msys2/mingw, and create a typedef long long blkcnt_t; for further implementation
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>   block/nfs.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/block/nfs.c b/block/nfs.c
> index f86e660374..cf8795fb49 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c

[...]

> @@ -51,6 +53,10 @@
>   #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
>   #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>   
> +#if defined(_WIN32)
> +typedef long long blkcnt_t;

This makes me uneasy.  Is there a guarantee that this type will never be 
defined in a mingw environment (which would then result in a new compile 
error)?

Can’t we just give NFSClient.st_blocks a different type, i.e. uint64_t?

Apart from that, looks good to me.


