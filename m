Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8ADC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9380D2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9380D2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40663 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqzL-0005bV-Tx
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:54:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTqvY-0002RZ-AJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTqgf-00030H-Hs
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hTqgb-0002ws-Os; Thu, 23 May 2019 12:35:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F056519CF89;
	Thu, 23 May 2019 16:35:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B744968366;
	Thu, 23 May 2019 16:35:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 49B0E1138648; Thu, 23 May 2019 18:35:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190523152250.106717-1-sgarzare@redhat.com>
	<20190523152250.106717-4-sgarzare@redhat.com>
Date: Thu, 23 May 2019 18:35:18 +0200
In-Reply-To: <20190523152250.106717-4-sgarzare@redhat.com> (Stefano
	Garzarella's message of "Thu, 23 May 2019 17:22:50 +0200")
Message-ID: <87y32xgmd5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 23 May 2019 16:35:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] block/gluster: update .help of
 BLOCK_OPT_PREALLOC option
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> writes:

> Show 'falloc' and 'full' among the allowed values of
> 'preallocation' option, only when they are supported
> ('falloc' is support if defined CONFIG_GLUSTERFS_FALLOCATE,
> 'full' is support if defined CONFIG_GLUSTERFS_ZEROFILL)

You could mention that 'falloc' is missing before the patch.

> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/gluster.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/block/gluster.c b/block/gluster.c
> index e664ca4462..682fe49912 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -97,7 +97,14 @@ static QemuOptsList qemu_gluster_create_opts = {
>          {
>              .name = BLOCK_OPT_PREALLOC,
>              .type = QEMU_OPT_STRING,
> -            .help = "Preallocation mode (allowed values: off, full)"
> +            .help = "Preallocation mode (allowed values: off"
> +#ifdef CONFIG_GLUSTERFS_FALLOCATE
> +                    ", falloc"
> +#endif
> +#ifdef CONFIG_GLUSTERFS_ZEROFILL
> +                    ", full"
> +#endif
> +                    ")"
>          },
>          {
>              .name = GLUSTER_OPT_DEBUG,

Reviewed-by: Markus Armbruster <armbru@redhat.com>

