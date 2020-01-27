Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9417C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CA620702
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 12:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNcTe/NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CA620702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw3ij-0003xZ-QE
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 07:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iw3hx-0003Kb-UY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iw3hv-0002qy-9v
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:41:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iw3hv-0002qW-0U
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580128894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CTDk0k9Yir0j5YA6qE3yu+2cctRkp6nrM/g4CRUKNWU=;
 b=UNcTe/NI6+kinbxRrCJwtGrWxaQvWIwIkln4WZgxNWj5s5AcJWIBzkP/p1wKaj4KhVe5mz
 U31BWw8Voq2kkiESuVDV9Q5t+tK2fxNbYjHcLhY7RbafUUvvX6JFFrypcL+UDNolR7+RYw
 E88rJ2X2+TLTnM2CC0DM8AubXH8nRfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-G2SvCT3EO9-N0L9d0uX-CA-1; Mon, 27 Jan 2020 07:41:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 350EF13E5
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 12:41:29 +0000 (UTC)
Received: from ptitpuce (unknown [10.34.244.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7741E451F;
 Mon, 27 Jan 2020 12:41:25 +0000 (UTC)
References: <20200123115841.138849-1-dgilbert@redhat.com>
 <20200123115841.138849-112-dgilbert@redhat.com>
User-agent: mu4e 1.3.5; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 111/111] virtiofsd: add some options to the help message
In-reply-to: <20200123115841.138849-112-dgilbert@redhat.com>
Message-ID: <m1o8upqdfv.fsf@redhat.com>
Date: Mon, 27 Jan 2020 13:41:24 +0100
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: G2SvCT3EO9-N0L9d0uX-CA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dr. David Alan Gilbert (git) writes:

> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> Add following options to the help message:
> - cache
> - flock|no_flock
> - norace
> - posix_lock|no_posix_lock
> - readdirplus|no_readdirplus
> - timeout
> - writeback|no_writeback
> - xattr|no_xattr
>
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> dgilbert: Split cache, norace, posix_lock, readdirplus off
>   into our own earlier patches that added the options
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
> index f98d8f2eb2..0801cf752c 100644
> --- a/tools/virtiofsd/helper.c
> +++ b/tools/virtiofsd/helper.c
> @@ -148,6 +148,8 @@ void fuse_cmdline_help(void)
>             "    -o cache=3D<mode>            cache mode. could be one of=
 \"auto, "
>             "always, none\"\n"
>             "                               default: auto\n"
> +           "    -o flock|no_flock          enable/disable flock\n"
> +           "                               default: no_flock\n"
>             "    -o log_level=3D<level>       log level, default to \"inf=
o\"\n"
>             "                               level could be one of \"debug=
, "
>             "info, warn, err\"\n"
> @@ -163,7 +165,13 @@ void fuse_cmdline_help(void)
>             "                               enable/disable readirplus\n"
>             "                               default: readdirplus except w=
ith "
>             "cache=3Dnone\n"
> -          );
> +           "    -o timeout=3D<number>        I/O timeout (second)\n"

s/second/seconds/ ? (Not sure, I'm not a native speaker)

> +           "                               default: depends on cache=3D =
option.\n"
> +           "    -o writeback|no_writeback  enable/disable writeback cach=
e\n"
> +           "                               default: no_writeback\n"
> +           "    -o xattr|no_xattr          enable/disable xattr\n"
> +           "                               default: no_xattr\n"
> +           );
>  }
>
>  static int fuse_helper_opt_proc(void *data, const char *arg, int key,


--
Cheers,
Christophe de Dinechin (IRC c3d)


